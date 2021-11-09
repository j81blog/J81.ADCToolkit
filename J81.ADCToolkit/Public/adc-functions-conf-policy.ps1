function Invoke-ADCAddPolicydataset {
<#
    .SYNOPSIS
        Add Policy configuration Object
    .DESCRIPTION
        Add Policy configuration Object 
    .PARAMETER name 
        Name of the dataset. Must not exceed 127 characters.  
        Minimum length = 1 
    .PARAMETER type 
        Type of value to bind to the dataset.  
        Possible values = ipv4, number, ipv6, ulong, double, mac 
    .PARAMETER indextype 
        Index type.  
        Possible values = Auto-generated, User-defined 
    .PARAMETER comment 
        Any comments to preserve information about this dataset or a data bound to this dataset. 
    .PARAMETER PassThru 
        Return details about the created policydataset item.
    .EXAMPLE
        Invoke-ADCAddPolicydataset -name <string> -type <string>
    .NOTES
        File Name : Invoke-ADCAddPolicydataset
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policydataset/
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
        [ValidateSet('ipv4', 'number', 'ipv6', 'ulong', 'double', 'mac')]
        [string]$type ,

        [ValidateSet('Auto-generated', 'User-defined')]
        [string]$indextype ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicydataset: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                type = $type
            }
            if ($PSBoundParameters.ContainsKey('indextype')) { $Payload.Add('indextype', $indextype) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("policydataset", "Add Policy configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policydataset -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPolicydataset -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddPolicydataset: Finished"
    }
}

function Invoke-ADCDeletePolicydataset {
<#
    .SYNOPSIS
        Delete Policy configuration Object
    .DESCRIPTION
        Delete Policy configuration Object
    .PARAMETER name 
       Name of the dataset. Must not exceed 127 characters.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeletePolicydataset -name <string>
    .NOTES
        File Name : Invoke-ADCDeletePolicydataset
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policydataset/
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
        Write-Verbose "Invoke-ADCDeletePolicydataset: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Policy configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policydataset -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeletePolicydataset: Finished"
    }
}

function Invoke-ADCGetPolicydataset {
<#
    .SYNOPSIS
        Get Policy configuration object(s)
    .DESCRIPTION
        Get Policy configuration object(s)
    .PARAMETER name 
       Name of the dataset. Must not exceed 127 characters. 
    .PARAMETER GetAll 
        Retreive all policydataset object(s)
    .PARAMETER Count
        If specified, the count of the policydataset object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPolicydataset
    .EXAMPLE 
        Invoke-ADCGetPolicydataset -GetAll 
    .EXAMPLE 
        Invoke-ADCGetPolicydataset -Count
    .EXAMPLE
        Invoke-ADCGetPolicydataset -name <string>
    .EXAMPLE
        Invoke-ADCGetPolicydataset -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPolicydataset
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policydataset/
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
        Write-Verbose "Invoke-ADCGetPolicydataset: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all policydataset objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policydataset objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policydataset objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policydataset configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policydataset configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPolicydataset: Ended"
    }
}

function Invoke-ADCGetPolicydatasetbinding {
<#
    .SYNOPSIS
        Get Policy configuration object(s)
    .DESCRIPTION
        Get Policy configuration object(s)
    .PARAMETER name 
       Name of the dataset. Must not exceed 127 characters. 
    .PARAMETER GetAll 
        Retreive all policydataset_binding object(s)
    .PARAMETER Count
        If specified, the count of the policydataset_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPolicydatasetbinding
    .EXAMPLE 
        Invoke-ADCGetPolicydatasetbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetPolicydatasetbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetPolicydatasetbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPolicydatasetbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policydataset_binding/
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
        Write-Verbose "Invoke-ADCGetPolicydatasetbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all policydataset_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policydataset_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policydataset_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policydataset_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policydataset_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPolicydatasetbinding: Ended"
    }
}

function Invoke-ADCAddPolicydatasetvaluebinding {
<#
    .SYNOPSIS
        Add Policy configuration Object
    .DESCRIPTION
        Add Policy configuration Object 
    .PARAMETER name 
        Name of the dataset to which to bind the value.  
        Minimum length = 1 
    .PARAMETER value 
        Value of the specified type that is associated with the dataset. 
    .PARAMETER index 
        The index of the value (ipv4, ipv6, number) associated with the set. 
    .PARAMETER endrange 
        The dataset entry is a range from <value> through <end_range>, inclusive. 
    .PARAMETER comment 
        Any comments to preserve information about this dataset or a data bound to this dataset. 
    .PARAMETER PassThru 
        Return details about the created policydataset_value_binding item.
    .EXAMPLE
        Invoke-ADCAddPolicydatasetvaluebinding -name <string> -value <string>
    .NOTES
        File Name : Invoke-ADCAddPolicydatasetvaluebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policydataset_value_binding/
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
        [string]$value ,

        [double]$index ,

        [string]$endrange ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicydatasetvaluebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                value = $value
            }
            if ($PSBoundParameters.ContainsKey('index')) { $Payload.Add('index', $index) }
            if ($PSBoundParameters.ContainsKey('endrange')) { $Payload.Add('endrange', $endrange) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("policydataset_value_binding", "Add Policy configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type policydataset_value_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPolicydatasetvaluebinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddPolicydatasetvaluebinding: Finished"
    }
}

function Invoke-ADCDeletePolicydatasetvaluebinding {
<#
    .SYNOPSIS
        Delete Policy configuration Object
    .DESCRIPTION
        Delete Policy configuration Object
    .PARAMETER name 
       Name of the dataset to which to bind the value.  
       Minimum length = 1    .PARAMETER value 
       Value of the specified type that is associated with the dataset.    .PARAMETER endrange 
       The dataset entry is a range from <value> through <end_range>, inclusive.
    .EXAMPLE
        Invoke-ADCDeletePolicydatasetvaluebinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeletePolicydatasetvaluebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policydataset_value_binding/
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

        [string]$value ,

        [string]$endrange 
    )
    begin {
        Write-Verbose "Invoke-ADCDeletePolicydatasetvaluebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('value')) { $Arguments.Add('value', $value) }
            if ($PSBoundParameters.ContainsKey('endrange')) { $Arguments.Add('endrange', $endrange) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Policy configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policydataset_value_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeletePolicydatasetvaluebinding: Finished"
    }
}

function Invoke-ADCGetPolicydatasetvaluebinding {
<#
    .SYNOPSIS
        Get Policy configuration object(s)
    .DESCRIPTION
        Get Policy configuration object(s)
    .PARAMETER name 
       Name of the dataset to which to bind the value. 
    .PARAMETER GetAll 
        Retreive all policydataset_value_binding object(s)
    .PARAMETER Count
        If specified, the count of the policydataset_value_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPolicydatasetvaluebinding
    .EXAMPLE 
        Invoke-ADCGetPolicydatasetvaluebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetPolicydatasetvaluebinding -Count
    .EXAMPLE
        Invoke-ADCGetPolicydatasetvaluebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetPolicydatasetvaluebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPolicydatasetvaluebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policydataset_value_binding/
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
        Write-Verbose "Invoke-ADCGetPolicydatasetvaluebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all policydataset_value_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_value_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policydataset_value_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_value_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policydataset_value_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_value_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policydataset_value_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_value_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policydataset_value_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_value_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPolicydatasetvaluebinding: Ended"
    }
}

function Invoke-ADCGetPolicyevaluation {
<#
    .SYNOPSIS
        Get Policy configuration object(s)
    .DESCRIPTION
        Get Policy configuration object(s)
    .PARAMETER expression 
       Expression string. For example: http.req.body(100).contains("this"). 
    .PARAMETER action 
       Rewrite action name. Supported rewrite action types are:  
       -delete  
       -delete_all  
       -delete_http_header  
       -insert_after  
       -insert_after_all  
       -insert_before  
       -insert_before_all  
       -insert_http_header  
       -replace  
       -replace_all  
       . 
    .PARAMETER type 
       Indicates request or response input packet.  
       Possible values = HTTP_REQ, HTTP_RES, TEXT 
    .PARAMETER input 
       Text representation of input packet. 
    .PARAMETER GetAll 
        Retreive all policyevaluation object(s)
    .PARAMETER Count
        If specified, the count of the policyevaluation object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPolicyevaluation
    .EXAMPLE 
        Invoke-ADCGetPolicyevaluation -GetAll 
    .EXAMPLE 
        Invoke-ADCGetPolicyevaluation -Count
    .EXAMPLE
        Invoke-ADCGetPolicyevaluation -name <string>
    .EXAMPLE
        Invoke-ADCGetPolicyevaluation -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPolicyevaluation
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyevaluation/
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
        [string]$expression ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$action ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('HTTP_REQ', 'HTTP_RES', 'TEXT')]
        [string]$type ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$input,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetPolicyevaluation: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all policyevaluation objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyevaluation -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policyevaluation objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyevaluation -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policyevaluation objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('expression')) { $Arguments.Add('expression', $expression) } 
                if ($PSBoundParameters.ContainsKey('action')) { $Arguments.Add('action', $action) } 
                if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) } 
                if ($PSBoundParameters.ContainsKey('input')) { $Arguments.Add('input', $input) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyevaluation -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policyevaluation configuration for property ''"

            } else {
                Write-Verbose "Retrieving policyevaluation configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyevaluation -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPolicyevaluation: Ended"
    }
}

function Invoke-ADCAddPolicyexpression {
<#
    .SYNOPSIS
        Add Policy configuration Object
    .DESCRIPTION
        Add Policy configuration Object 
    .PARAMETER name 
        Unique name for the expression. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout.  
        Minimum length = 1 
    .PARAMETER value 
        Expression string. For example: http.req.body(100).contains("this"). 
    .PARAMETER description 
        Description for the expression. 
    .PARAMETER comment 
        Any comments associated with the expression. Displayed upon viewing the policy expression. 
    .PARAMETER clientsecuritymessage 
        Message to display if the expression fails. Allowed for classic end-point check expressions only.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created policyexpression item.
    .EXAMPLE
        Invoke-ADCAddPolicyexpression -name <string> -value <string>
    .NOTES
        File Name : Invoke-ADCAddPolicyexpression
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyexpression/
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
        [string]$value ,

        [string]$description ,

        [string]$comment ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$clientsecuritymessage ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicyexpression: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                value = $value
            }
            if ($PSBoundParameters.ContainsKey('description')) { $Payload.Add('description', $description) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('clientsecuritymessage')) { $Payload.Add('clientsecuritymessage', $clientsecuritymessage) }
 
            if ($PSCmdlet.ShouldProcess("policyexpression", "Add Policy configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policyexpression -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPolicyexpression -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddPolicyexpression: Finished"
    }
}

function Invoke-ADCDeletePolicyexpression {
<#
    .SYNOPSIS
        Delete Policy configuration Object
    .DESCRIPTION
        Delete Policy configuration Object
    .PARAMETER name 
       Unique name for the expression. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeletePolicyexpression -name <string>
    .NOTES
        File Name : Invoke-ADCDeletePolicyexpression
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyexpression/
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
        Write-Verbose "Invoke-ADCDeletePolicyexpression: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Policy configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policyexpression -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeletePolicyexpression: Finished"
    }
}

function Invoke-ADCUpdatePolicyexpression {
<#
    .SYNOPSIS
        Update Policy configuration Object
    .DESCRIPTION
        Update Policy configuration Object 
    .PARAMETER name 
        Unique name for the expression. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout.  
        Minimum length = 1 
    .PARAMETER value 
        Expression string. For example: http.req.body(100).contains("this"). 
    .PARAMETER description 
        Description for the expression. 
    .PARAMETER comment 
        Any comments associated with the expression. Displayed upon viewing the policy expression. 
    .PARAMETER clientsecuritymessage 
        Message to display if the expression fails. Allowed for classic end-point check expressions only.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created policyexpression item.
    .EXAMPLE
        Invoke-ADCUpdatePolicyexpression -name <string>
    .NOTES
        File Name : Invoke-ADCUpdatePolicyexpression
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyexpression/
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

        [string]$value ,

        [string]$description ,

        [string]$comment ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$clientsecuritymessage ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdatePolicyexpression: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('value')) { $Payload.Add('value', $value) }
            if ($PSBoundParameters.ContainsKey('description')) { $Payload.Add('description', $description) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('clientsecuritymessage')) { $Payload.Add('clientsecuritymessage', $clientsecuritymessage) }
 
            if ($PSCmdlet.ShouldProcess("policyexpression", "Update Policy configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type policyexpression -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPolicyexpression -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdatePolicyexpression: Finished"
    }
}

function Invoke-ADCUnsetPolicyexpression {
<#
    .SYNOPSIS
        Unset Policy configuration Object
    .DESCRIPTION
        Unset Policy configuration Object 
   .PARAMETER name 
       Unique name for the expression. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
   .PARAMETER description 
       Description for the expression. 
   .PARAMETER comment 
       Any comments associated with the expression. Displayed upon viewing the policy expression. 
   .PARAMETER clientsecuritymessage 
       Message to display if the expression fails. Allowed for classic end-point check expressions only.
    .EXAMPLE
        Invoke-ADCUnsetPolicyexpression -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetPolicyexpression
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyexpression
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

        [Boolean]$description ,

        [Boolean]$comment ,

        [Boolean]$clientsecuritymessage 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetPolicyexpression: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('description')) { $Payload.Add('description', $description) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('clientsecuritymessage')) { $Payload.Add('clientsecuritymessage', $clientsecuritymessage) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Policy configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type policyexpression -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetPolicyexpression: Finished"
    }
}

function Invoke-ADCGetPolicyexpression {
<#
    .SYNOPSIS
        Get Policy configuration object(s)
    .DESCRIPTION
        Get Policy configuration object(s)
    .PARAMETER name 
       Unique name for the expression. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
    .PARAMETER GetAll 
        Retreive all policyexpression object(s)
    .PARAMETER Count
        If specified, the count of the policyexpression object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPolicyexpression
    .EXAMPLE 
        Invoke-ADCGetPolicyexpression -GetAll 
    .EXAMPLE 
        Invoke-ADCGetPolicyexpression -Count
    .EXAMPLE
        Invoke-ADCGetPolicyexpression -name <string>
    .EXAMPLE
        Invoke-ADCGetPolicyexpression -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPolicyexpression
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyexpression/
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
        Write-Verbose "Invoke-ADCGetPolicyexpression: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all policyexpression objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyexpression -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policyexpression objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyexpression -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policyexpression objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyexpression -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policyexpression configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyexpression -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policyexpression configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyexpression -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPolicyexpression: Ended"
    }
}

function Invoke-ADCAddPolicyhttpcallout {
<#
    .SYNOPSIS
        Add Policy configuration Object
    .DESCRIPTION
        Add Policy configuration Object 
    .PARAMETER name 
        Name for the HTTP callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout.  
        Minimum length = 1 
    .PARAMETER ipaddress 
        IP Address of the server (callout agent) to which the callout is sent. Can be an IPv4 or IPv6 address.  
        Mutually exclusive with the Virtual Server parameter. Therefore, you cannot set the <IP Address, Port> and the Virtual Server in the same HTTP callout. 
    .PARAMETER port 
        Server port to which the HTTP callout agent is mapped. Mutually exclusive with the Virtual Server parameter. Therefore, you cannot set the <IP Address, Port> and the Virtual Server in the same HTTP callout.  
        Minimum value = 1 
    .PARAMETER vserver 
        Name of the load balancing, content switching, or cache redirection virtual server (the callout agent) to which the HTTP callout is sent. The service type of the virtual server must be HTTP. Mutually exclusive with the IP address and port parameters. Therefore, you cannot set the <IP Address, Port> and the Virtual Server in the same HTTP callout.  
        Minimum length = 1 
    .PARAMETER returntype 
        Type of data that the target callout agent returns in response to the callout.  
        Available settings function as follows:  
        * TEXT - Treat the returned value as a text string.  
        * NUM - Treat the returned value as a number.  
        * BOOL - Treat the returned value as a Boolean value.  
        Note: You cannot change the return type after it is set.  
        Possible values = BOOL, NUM, TEXT 
    .PARAMETER httpmethod 
        Method used in the HTTP request that this callout sends. Mutually exclusive with the full HTTP request expression.  
        Possible values = GET, POST 
    .PARAMETER hostexpr 
        String expression to configure the Host header. Can contain a literal value (for example, 10.101.10.11) or a derived value (for example, http.req.header("Host")). The literal value can be an IP address or a fully qualified domain name. Mutually exclusive with the full HTTP request expression.  
        Minimum length = 1 
    .PARAMETER urlstemexpr 
        String expression for generating the URL stem. Can contain a literal string (for example, "/mysite/index.html") or an expression that derives the value (for example, http.req.url). Mutually exclusive with the full HTTP request expression.  
        Minimum length = 1 
    .PARAMETER headers 
        One or more headers to insert into the HTTP request. Each header is specified as "name(expr)", where expr is an expression that is evaluated at runtime to provide the value for the named header. You can configure a maximum of eight headers for an HTTP callout. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER parameters 
        One or more query parameters to insert into the HTTP request URL (for a GET request) or into the request body (for a POST request). Each parameter is specified as "name(expr)", where expr is an expression that is evaluated at run time to provide the value for the named parameter (name=value). The parameter values are URL encoded. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER bodyexpr 
        An advanced string expression for generating the body of the request. The expression can contain a literal string or an expression that derives the value (for example, client.ip.src). Mutually exclusive with -fullReqExpr.  
        Minimum length = 1 
    .PARAMETER fullreqexpr 
        Exact HTTP request, in the form of an expression, which the Citrix ADC sends to the callout agent. If you set this parameter, you must not include HTTP method, host expression, URL stem expression, headers, or parameters.  
        The request expression is constrained by the feature for which the callout is used. For example, an HTTP.RES expression cannot be used in a request-time policy bank or in a TCP content switching policy bank.  
        The Citrix ADC does not check the validity of this request. You must manually validate the request.  
        Minimum length = 1 
    .PARAMETER scheme 
        Type of scheme for the callout server.  
        Possible values = http, https 
    .PARAMETER resultexpr 
        Expression that extracts the callout results from the response sent by the HTTP callout agent. Must be a response based expression, that is, it must begin with HTTP.RES. The operations in this expression must match the return type. For example, if you configure a return type of TEXT, the result expression must be a text based expression. If the return type is NUM, the result expression (resultExpr) must return a numeric value, as in the following example: http.res.body(10000).length.  
        Minimum length = 1 
    .PARAMETER cacheforsecs 
        Duration, in seconds, for which the callout response is cached. The cached responses are stored in an integrated caching content group named "calloutContentGroup". If no duration is configured, the callout responses will not be cached unless normal caching configuration is used to cache them. This parameter takes precedence over any normal caching configuration that would otherwise apply to these responses.  
        Note that the calloutContentGroup definition may not be modified or removed nor may it be used with other cache policies.  
        Minimum value = 1  
        Maximum value = 31536000 
    .PARAMETER comment 
        Any comments to preserve information about this HTTP callout. 
    .PARAMETER PassThru 
        Return details about the created policyhttpcallout item.
    .EXAMPLE
        Invoke-ADCAddPolicyhttpcallout -name <string>
    .NOTES
        File Name : Invoke-ADCAddPolicyhttpcallout
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyhttpcallout/
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

        [string]$ipaddress ,

        [int]$port ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$vserver ,

        [ValidateSet('BOOL', 'NUM', 'TEXT')]
        [string]$returntype ,

        [ValidateSet('GET', 'POST')]
        [string]$httpmethod ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$hostexpr ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$urlstemexpr ,

        [string[]]$headers ,

        [string[]]$parameters ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$bodyexpr ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$fullreqexpr ,

        [ValidateSet('http', 'https')]
        [string]$scheme ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$resultexpr ,

        [ValidateRange(1, 31536000)]
        [double]$cacheforsecs ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicyhttpcallout: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Payload.Add('ipaddress', $ipaddress) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Payload.Add('vserver', $vserver) }
            if ($PSBoundParameters.ContainsKey('returntype')) { $Payload.Add('returntype', $returntype) }
            if ($PSBoundParameters.ContainsKey('httpmethod')) { $Payload.Add('httpmethod', $httpmethod) }
            if ($PSBoundParameters.ContainsKey('hostexpr')) { $Payload.Add('hostexpr', $hostexpr) }
            if ($PSBoundParameters.ContainsKey('urlstemexpr')) { $Payload.Add('urlstemexpr', $urlstemexpr) }
            if ($PSBoundParameters.ContainsKey('headers')) { $Payload.Add('headers', $headers) }
            if ($PSBoundParameters.ContainsKey('parameters')) { $Payload.Add('parameters', $parameters) }
            if ($PSBoundParameters.ContainsKey('bodyexpr')) { $Payload.Add('bodyexpr', $bodyexpr) }
            if ($PSBoundParameters.ContainsKey('fullreqexpr')) { $Payload.Add('fullreqexpr', $fullreqexpr) }
            if ($PSBoundParameters.ContainsKey('scheme')) { $Payload.Add('scheme', $scheme) }
            if ($PSBoundParameters.ContainsKey('resultexpr')) { $Payload.Add('resultexpr', $resultexpr) }
            if ($PSBoundParameters.ContainsKey('cacheforsecs')) { $Payload.Add('cacheforsecs', $cacheforsecs) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("policyhttpcallout", "Add Policy configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policyhttpcallout -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPolicyhttpcallout -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddPolicyhttpcallout: Finished"
    }
}

function Invoke-ADCDeletePolicyhttpcallout {
<#
    .SYNOPSIS
        Delete Policy configuration Object
    .DESCRIPTION
        Delete Policy configuration Object
    .PARAMETER name 
       Name for the HTTP callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeletePolicyhttpcallout -name <string>
    .NOTES
        File Name : Invoke-ADCDeletePolicyhttpcallout
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyhttpcallout/
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
        Write-Verbose "Invoke-ADCDeletePolicyhttpcallout: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Policy configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policyhttpcallout -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeletePolicyhttpcallout: Finished"
    }
}

function Invoke-ADCUpdatePolicyhttpcallout {
<#
    .SYNOPSIS
        Update Policy configuration Object
    .DESCRIPTION
        Update Policy configuration Object 
    .PARAMETER name 
        Name for the HTTP callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout.  
        Minimum length = 1 
    .PARAMETER ipaddress 
        IP Address of the server (callout agent) to which the callout is sent. Can be an IPv4 or IPv6 address.  
        Mutually exclusive with the Virtual Server parameter. Therefore, you cannot set the <IP Address, Port> and the Virtual Server in the same HTTP callout. 
    .PARAMETER port 
        Server port to which the HTTP callout agent is mapped. Mutually exclusive with the Virtual Server parameter. Therefore, you cannot set the <IP Address, Port> and the Virtual Server in the same HTTP callout.  
        Minimum value = 1 
    .PARAMETER vserver 
        Name of the load balancing, content switching, or cache redirection virtual server (the callout agent) to which the HTTP callout is sent. The service type of the virtual server must be HTTP. Mutually exclusive with the IP address and port parameters. Therefore, you cannot set the <IP Address, Port> and the Virtual Server in the same HTTP callout.  
        Minimum length = 1 
    .PARAMETER returntype 
        Type of data that the target callout agent returns in response to the callout.  
        Available settings function as follows:  
        * TEXT - Treat the returned value as a text string.  
        * NUM - Treat the returned value as a number.  
        * BOOL - Treat the returned value as a Boolean value.  
        Note: You cannot change the return type after it is set.  
        Possible values = BOOL, NUM, TEXT 
    .PARAMETER httpmethod 
        Method used in the HTTP request that this callout sends. Mutually exclusive with the full HTTP request expression.  
        Possible values = GET, POST 
    .PARAMETER hostexpr 
        String expression to configure the Host header. Can contain a literal value (for example, 10.101.10.11) or a derived value (for example, http.req.header("Host")). The literal value can be an IP address or a fully qualified domain name. Mutually exclusive with the full HTTP request expression.  
        Minimum length = 1 
    .PARAMETER urlstemexpr 
        String expression for generating the URL stem. Can contain a literal string (for example, "/mysite/index.html") or an expression that derives the value (for example, http.req.url). Mutually exclusive with the full HTTP request expression.  
        Minimum length = 1 
    .PARAMETER headers 
        One or more headers to insert into the HTTP request. Each header is specified as "name(expr)", where expr is an expression that is evaluated at runtime to provide the value for the named header. You can configure a maximum of eight headers for an HTTP callout. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER parameters 
        One or more query parameters to insert into the HTTP request URL (for a GET request) or into the request body (for a POST request). Each parameter is specified as "name(expr)", where expr is an expression that is evaluated at run time to provide the value for the named parameter (name=value). The parameter values are URL encoded. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER bodyexpr 
        An advanced string expression for generating the body of the request. The expression can contain a literal string or an expression that derives the value (for example, client.ip.src). Mutually exclusive with -fullReqExpr.  
        Minimum length = 1 
    .PARAMETER fullreqexpr 
        Exact HTTP request, in the form of an expression, which the Citrix ADC sends to the callout agent. If you set this parameter, you must not include HTTP method, host expression, URL stem expression, headers, or parameters.  
        The request expression is constrained by the feature for which the callout is used. For example, an HTTP.RES expression cannot be used in a request-time policy bank or in a TCP content switching policy bank.  
        The Citrix ADC does not check the validity of this request. You must manually validate the request.  
        Minimum length = 1 
    .PARAMETER scheme 
        Type of scheme for the callout server.  
        Possible values = http, https 
    .PARAMETER resultexpr 
        Expression that extracts the callout results from the response sent by the HTTP callout agent. Must be a response based expression, that is, it must begin with HTTP.RES. The operations in this expression must match the return type. For example, if you configure a return type of TEXT, the result expression must be a text based expression. If the return type is NUM, the result expression (resultExpr) must return a numeric value, as in the following example: http.res.body(10000).length.  
        Minimum length = 1 
    .PARAMETER cacheforsecs 
        Duration, in seconds, for which the callout response is cached. The cached responses are stored in an integrated caching content group named "calloutContentGroup". If no duration is configured, the callout responses will not be cached unless normal caching configuration is used to cache them. This parameter takes precedence over any normal caching configuration that would otherwise apply to these responses.  
        Note that the calloutContentGroup definition may not be modified or removed nor may it be used with other cache policies.  
        Minimum value = 1  
        Maximum value = 31536000 
    .PARAMETER comment 
        Any comments to preserve information about this HTTP callout. 
    .PARAMETER PassThru 
        Return details about the created policyhttpcallout item.
    .EXAMPLE
        Invoke-ADCUpdatePolicyhttpcallout -name <string>
    .NOTES
        File Name : Invoke-ADCUpdatePolicyhttpcallout
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyhttpcallout/
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

        [string]$ipaddress ,

        [int]$port ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$vserver ,

        [ValidateSet('BOOL', 'NUM', 'TEXT')]
        [string]$returntype ,

        [ValidateSet('GET', 'POST')]
        [string]$httpmethod ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$hostexpr ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$urlstemexpr ,

        [string[]]$headers ,

        [string[]]$parameters ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$bodyexpr ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$fullreqexpr ,

        [ValidateSet('http', 'https')]
        [string]$scheme ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$resultexpr ,

        [ValidateRange(1, 31536000)]
        [double]$cacheforsecs ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdatePolicyhttpcallout: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Payload.Add('ipaddress', $ipaddress) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Payload.Add('vserver', $vserver) }
            if ($PSBoundParameters.ContainsKey('returntype')) { $Payload.Add('returntype', $returntype) }
            if ($PSBoundParameters.ContainsKey('httpmethod')) { $Payload.Add('httpmethod', $httpmethod) }
            if ($PSBoundParameters.ContainsKey('hostexpr')) { $Payload.Add('hostexpr', $hostexpr) }
            if ($PSBoundParameters.ContainsKey('urlstemexpr')) { $Payload.Add('urlstemexpr', $urlstemexpr) }
            if ($PSBoundParameters.ContainsKey('headers')) { $Payload.Add('headers', $headers) }
            if ($PSBoundParameters.ContainsKey('parameters')) { $Payload.Add('parameters', $parameters) }
            if ($PSBoundParameters.ContainsKey('bodyexpr')) { $Payload.Add('bodyexpr', $bodyexpr) }
            if ($PSBoundParameters.ContainsKey('fullreqexpr')) { $Payload.Add('fullreqexpr', $fullreqexpr) }
            if ($PSBoundParameters.ContainsKey('scheme')) { $Payload.Add('scheme', $scheme) }
            if ($PSBoundParameters.ContainsKey('resultexpr')) { $Payload.Add('resultexpr', $resultexpr) }
            if ($PSBoundParameters.ContainsKey('cacheforsecs')) { $Payload.Add('cacheforsecs', $cacheforsecs) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("policyhttpcallout", "Update Policy configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type policyhttpcallout -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPolicyhttpcallout -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdatePolicyhttpcallout: Finished"
    }
}

function Invoke-ADCUnsetPolicyhttpcallout {
<#
    .SYNOPSIS
        Unset Policy configuration Object
    .DESCRIPTION
        Unset Policy configuration Object 
   .PARAMETER name 
       Name for the HTTP callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
   .PARAMETER ipaddress 
       IP Address of the server (callout agent) to which the callout is sent. Can be an IPv4 or IPv6 address.  
       Mutually exclusive with the Virtual Server parameter. Therefore, you cannot set the <IP Address, Port> and the Virtual Server in the same HTTP callout. 
   .PARAMETER port 
       Server port to which the HTTP callout agent is mapped. Mutually exclusive with the Virtual Server parameter. Therefore, you cannot set the <IP Address, Port> and the Virtual Server in the same HTTP callout. 
   .PARAMETER vserver 
       Name of the load balancing, content switching, or cache redirection virtual server (the callout agent) to which the HTTP callout is sent. The service type of the virtual server must be HTTP. Mutually exclusive with the IP address and port parameters. Therefore, you cannot set the <IP Address, Port> and the Virtual Server in the same HTTP callout. 
   .PARAMETER httpmethod 
       Method used in the HTTP request that this callout sends. Mutually exclusive with the full HTTP request expression.  
       Possible values = GET, POST 
   .PARAMETER hostexpr 
       String expression to configure the Host header. Can contain a literal value (for example, 10.101.10.11) or a derived value (for example, http.req.header("Host")). The literal value can be an IP address or a fully qualified domain name. Mutually exclusive with the full HTTP request expression. 
   .PARAMETER urlstemexpr 
       String expression for generating the URL stem. Can contain a literal string (for example, "/mysite/index.html") or an expression that derives the value (for example, http.req.url). Mutually exclusive with the full HTTP request expression. 
   .PARAMETER headers 
       One or more headers to insert into the HTTP request. Each header is specified as "name(expr)", where expr is an expression that is evaluated at runtime to provide the value for the named header. You can configure a maximum of eight headers for an HTTP callout. Mutually exclusive with the full HTTP request expression. 
   .PARAMETER parameters 
       One or more query parameters to insert into the HTTP request URL (for a GET request) or into the request body (for a POST request). Each parameter is specified as "name(expr)", where expr is an expression that is evaluated at run time to provide the value for the named parameter (name=value). The parameter values are URL encoded. Mutually exclusive with the full HTTP request expression. 
   .PARAMETER bodyexpr 
       An advanced string expression for generating the body of the request. The expression can contain a literal string or an expression that derives the value (for example, client.ip.src). Mutually exclusive with -fullReqExpr. 
   .PARAMETER fullreqexpr 
       Exact HTTP request, in the form of an expression, which the Citrix ADC sends to the callout agent. If you set this parameter, you must not include HTTP method, host expression, URL stem expression, headers, or parameters.  
       The request expression is constrained by the feature for which the callout is used. For example, an HTTP.RES expression cannot be used in a request-time policy bank or in a TCP content switching policy bank.  
       The Citrix ADC does not check the validity of this request. You must manually validate the request. 
   .PARAMETER resultexpr 
       Expression that extracts the callout results from the response sent by the HTTP callout agent. Must be a response based expression, that is, it must begin with HTTP.RES. The operations in this expression must match the return type. For example, if you configure a return type of TEXT, the result expression must be a text based expression. If the return type is NUM, the result expression (resultExpr) must return a numeric value, as in the following example: http.res.body(10000).length. 
   .PARAMETER cacheforsecs 
       Duration, in seconds, for which the callout response is cached. The cached responses are stored in an integrated caching content group named "calloutContentGroup". If no duration is configured, the callout responses will not be cached unless normal caching configuration is used to cache them. This parameter takes precedence over any normal caching configuration that would otherwise apply to these responses.  
       Note that the calloutContentGroup definition may not be modified or removed nor may it be used with other cache policies. 
   .PARAMETER comment 
       Any comments to preserve information about this HTTP callout.
    .EXAMPLE
        Invoke-ADCUnsetPolicyhttpcallout -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetPolicyhttpcallout
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyhttpcallout
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

        [Boolean]$ipaddress ,

        [Boolean]$port ,

        [Boolean]$vserver ,

        [Boolean]$httpmethod ,

        [Boolean]$hostexpr ,

        [Boolean]$urlstemexpr ,

        [Boolean]$headers ,

        [Boolean]$parameters ,

        [Boolean]$bodyexpr ,

        [Boolean]$fullreqexpr ,

        [Boolean]$resultexpr ,

        [Boolean]$cacheforsecs ,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetPolicyhttpcallout: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Payload.Add('ipaddress', $ipaddress) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Payload.Add('vserver', $vserver) }
            if ($PSBoundParameters.ContainsKey('httpmethod')) { $Payload.Add('httpmethod', $httpmethod) }
            if ($PSBoundParameters.ContainsKey('hostexpr')) { $Payload.Add('hostexpr', $hostexpr) }
            if ($PSBoundParameters.ContainsKey('urlstemexpr')) { $Payload.Add('urlstemexpr', $urlstemexpr) }
            if ($PSBoundParameters.ContainsKey('headers')) { $Payload.Add('headers', $headers) }
            if ($PSBoundParameters.ContainsKey('parameters')) { $Payload.Add('parameters', $parameters) }
            if ($PSBoundParameters.ContainsKey('bodyexpr')) { $Payload.Add('bodyexpr', $bodyexpr) }
            if ($PSBoundParameters.ContainsKey('fullreqexpr')) { $Payload.Add('fullreqexpr', $fullreqexpr) }
            if ($PSBoundParameters.ContainsKey('resultexpr')) { $Payload.Add('resultexpr', $resultexpr) }
            if ($PSBoundParameters.ContainsKey('cacheforsecs')) { $Payload.Add('cacheforsecs', $cacheforsecs) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Policy configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type policyhttpcallout -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetPolicyhttpcallout: Finished"
    }
}

function Invoke-ADCGetPolicyhttpcallout {
<#
    .SYNOPSIS
        Get Policy configuration object(s)
    .DESCRIPTION
        Get Policy configuration object(s)
    .PARAMETER name 
       Name for the HTTP callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
    .PARAMETER GetAll 
        Retreive all policyhttpcallout object(s)
    .PARAMETER Count
        If specified, the count of the policyhttpcallout object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPolicyhttpcallout
    .EXAMPLE 
        Invoke-ADCGetPolicyhttpcallout -GetAll 
    .EXAMPLE 
        Invoke-ADCGetPolicyhttpcallout -Count
    .EXAMPLE
        Invoke-ADCGetPolicyhttpcallout -name <string>
    .EXAMPLE
        Invoke-ADCGetPolicyhttpcallout -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPolicyhttpcallout
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyhttpcallout/
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
        Write-Verbose "Invoke-ADCGetPolicyhttpcallout: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all policyhttpcallout objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyhttpcallout -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policyhttpcallout objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyhttpcallout -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policyhttpcallout objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyhttpcallout -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policyhttpcallout configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyhttpcallout -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policyhttpcallout configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyhttpcallout -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPolicyhttpcallout: Ended"
    }
}

function Invoke-ADCAddPolicymap {
<#
    .SYNOPSIS
        Add Policy configuration Object
    .DESCRIPTION
        Add Policy configuration Object 
    .PARAMETER mappolicyname 
        Name for the map policy. Must begin with a letter, number, or the underscore (_) character and must consist only of letters, numbers, and the hash (#), period (.), colon (:), space ( ), at (@), equals (=), hyphen (-), and underscore (_) characters.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my map" or 'my map').  
        Minimum length = 1 
    .PARAMETER sd 
        Publicly known source domain name. This is the domain name with which a client request arrives at a reverse proxy virtual server for cache redirection. If you specify a source domain, you must specify a target domain.  
        Minimum length = 1 
    .PARAMETER su 
        Source URL. Specify all or part of the source URL, in the following format: /[[prefix] [*]] [.suffix].  
        Minimum length = 1 
    .PARAMETER td 
        Target domain name sent to the server. The source domain name is replaced with this domain name.  
        Minimum length = 1 
    .PARAMETER tu 
        Target URL. Specify the target URL in the following format: /[[prefix] [*]][.suffix].  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created policymap item.
    .EXAMPLE
        Invoke-ADCAddPolicymap -mappolicyname <string> -sd <string>
    .NOTES
        File Name : Invoke-ADCAddPolicymap
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policymap/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$mappolicyname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$sd ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$su ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$td ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$tu ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicymap: Starting"
    }
    process {
        try {
            $Payload = @{
                mappolicyname = $mappolicyname
                sd = $sd
            }
            if ($PSBoundParameters.ContainsKey('su')) { $Payload.Add('su', $su) }
            if ($PSBoundParameters.ContainsKey('td')) { $Payload.Add('td', $td) }
            if ($PSBoundParameters.ContainsKey('tu')) { $Payload.Add('tu', $tu) }
 
            if ($PSCmdlet.ShouldProcess("policymap", "Add Policy configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policymap -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPolicymap -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddPolicymap: Finished"
    }
}

function Invoke-ADCDeletePolicymap {
<#
    .SYNOPSIS
        Delete Policy configuration Object
    .DESCRIPTION
        Delete Policy configuration Object
    .PARAMETER mappolicyname 
       Name for the map policy. Must begin with a letter, number, or the underscore (_) character and must consist only of letters, numbers, and the hash (#), period (.), colon (:), space ( ), at (@), equals (=), hyphen (-), and underscore (_) characters.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my map" or 'my map').  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeletePolicymap -mappolicyname <string>
    .NOTES
        File Name : Invoke-ADCDeletePolicymap
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policymap/
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
        [string]$mappolicyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeletePolicymap: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$mappolicyname", "Delete Policy configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policymap -NitroPath nitro/v1/config -Resource $mappolicyname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeletePolicymap: Finished"
    }
}

function Invoke-ADCGetPolicymap {
<#
    .SYNOPSIS
        Get Policy configuration object(s)
    .DESCRIPTION
        Get Policy configuration object(s)
    .PARAMETER mappolicyname 
       Name for the map policy. Must begin with a letter, number, or the underscore (_) character and must consist only of letters, numbers, and the hash (#), period (.), colon (:), space ( ), at (@), equals (=), hyphen (-), and underscore (_) characters.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my map" or 'my map'). 
    .PARAMETER GetAll 
        Retreive all policymap object(s)
    .PARAMETER Count
        If specified, the count of the policymap object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPolicymap
    .EXAMPLE 
        Invoke-ADCGetPolicymap -GetAll 
    .EXAMPLE 
        Invoke-ADCGetPolicymap -Count
    .EXAMPLE
        Invoke-ADCGetPolicymap -name <string>
    .EXAMPLE
        Invoke-ADCGetPolicymap -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPolicymap
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policymap/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$mappolicyname,

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
        Write-Verbose "Invoke-ADCGetPolicymap: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all policymap objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policymap -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policymap objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policymap -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policymap objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policymap -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policymap configuration for property 'mappolicyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policymap -NitroPath nitro/v1/config -Resource $mappolicyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policymap configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policymap -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPolicymap: Ended"
    }
}

function Invoke-ADCUpdatePolicyparam {
<#
    .SYNOPSIS
        Update Policy configuration Object
    .DESCRIPTION
        Update Policy configuration Object 
    .PARAMETER timeout 
        Maximum time in milliseconds to allow for processing expressions without interruption. If the timeout is reached then the evaluation causes an UNDEF to be raised and no further processing is performed.  
        Default value: 3900  
        Minimum value = 1  
        Maximum value = 5000
    .EXAMPLE
        Invoke-ADCUpdatePolicyparam 
    .NOTES
        File Name : Invoke-ADCUpdatePolicyparam
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyparam/
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

        [ValidateRange(1, 5000)]
        [double]$timeout 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdatePolicyparam: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
 
            if ($PSCmdlet.ShouldProcess("policyparam", "Update Policy configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type policyparam -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdatePolicyparam: Finished"
    }
}

function Invoke-ADCUnsetPolicyparam {
<#
    .SYNOPSIS
        Unset Policy configuration Object
    .DESCRIPTION
        Unset Policy configuration Object 
   .PARAMETER timeout 
       Maximum time in milliseconds to allow for processing expressions without interruption. If the timeout is reached then the evaluation causes an UNDEF to be raised and no further processing is performed.
    .EXAMPLE
        Invoke-ADCUnsetPolicyparam 
    .NOTES
        File Name : Invoke-ADCUnsetPolicyparam
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyparam
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

        [Boolean]$timeout 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetPolicyparam: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSCmdlet.ShouldProcess("policyparam", "Unset Policy configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type policyparam -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetPolicyparam: Finished"
    }
}

function Invoke-ADCGetPolicyparam {
<#
    .SYNOPSIS
        Get Policy configuration object(s)
    .DESCRIPTION
        Get Policy configuration object(s)
    .PARAMETER GetAll 
        Retreive all policyparam object(s)
    .PARAMETER Count
        If specified, the count of the policyparam object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPolicyparam
    .EXAMPLE 
        Invoke-ADCGetPolicyparam -GetAll
    .EXAMPLE
        Invoke-ADCGetPolicyparam -name <string>
    .EXAMPLE
        Invoke-ADCGetPolicyparam -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPolicyparam
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyparam/
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
        Write-Verbose "Invoke-ADCGetPolicyparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all policyparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyparam -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policyparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyparam -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policyparam objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyparam -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policyparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving policyparam configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPolicyparam: Ended"
    }
}

function Invoke-ADCAddPolicypatset {
<#
    .SYNOPSIS
        Add Policy configuration Object
    .DESCRIPTION
        Add Policy configuration Object 
    .PARAMETER name 
        Unique name of the pattern set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout.  
        Minimum length = 1 
    .PARAMETER indextype 
        Index type.  
        Possible values = Auto-generated, User-defined 
    .PARAMETER comment 
        Any comments to preserve information about this patset or a pattern bound to this patset. 
    .PARAMETER PassThru 
        Return details about the created policypatset item.
    .EXAMPLE
        Invoke-ADCAddPolicypatset -name <string>
    .NOTES
        File Name : Invoke-ADCAddPolicypatset
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policypatset/
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

        [ValidateSet('Auto-generated', 'User-defined')]
        [string]$indextype ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicypatset: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('indextype')) { $Payload.Add('indextype', $indextype) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("policypatset", "Add Policy configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policypatset -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPolicypatset -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddPolicypatset: Finished"
    }
}

function Invoke-ADCDeletePolicypatset {
<#
    .SYNOPSIS
        Delete Policy configuration Object
    .DESCRIPTION
        Delete Policy configuration Object
    .PARAMETER name 
       Unique name of the pattern set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeletePolicypatset -name <string>
    .NOTES
        File Name : Invoke-ADCDeletePolicypatset
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policypatset/
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
        Write-Verbose "Invoke-ADCDeletePolicypatset: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Policy configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policypatset -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeletePolicypatset: Finished"
    }
}

function Invoke-ADCGetPolicypatset {
<#
    .SYNOPSIS
        Get Policy configuration object(s)
    .DESCRIPTION
        Get Policy configuration object(s)
    .PARAMETER name 
       Unique name of the pattern set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER GetAll 
        Retreive all policypatset object(s)
    .PARAMETER Count
        If specified, the count of the policypatset object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPolicypatset
    .EXAMPLE 
        Invoke-ADCGetPolicypatset -GetAll 
    .EXAMPLE 
        Invoke-ADCGetPolicypatset -Count
    .EXAMPLE
        Invoke-ADCGetPolicypatset -name <string>
    .EXAMPLE
        Invoke-ADCGetPolicypatset -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPolicypatset
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policypatset/
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
        Write-Verbose "Invoke-ADCGetPolicypatset: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all policypatset objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policypatset objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policypatset objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policypatset configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policypatset configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPolicypatset: Ended"
    }
}

function Invoke-ADCGetPolicypatsetbinding {
<#
    .SYNOPSIS
        Get Policy configuration object(s)
    .DESCRIPTION
        Get Policy configuration object(s)
    .PARAMETER name 
       Name of the pattern set for which to display the detailed information. If a name is not provided, a list of all pattern sets configured on the appliance is shown. 
    .PARAMETER GetAll 
        Retreive all policypatset_binding object(s)
    .PARAMETER Count
        If specified, the count of the policypatset_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPolicypatsetbinding
    .EXAMPLE 
        Invoke-ADCGetPolicypatsetbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetPolicypatsetbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetPolicypatsetbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPolicypatsetbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policypatset_binding/
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
        Write-Verbose "Invoke-ADCGetPolicypatsetbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all policypatset_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policypatset_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policypatset_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policypatset_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policypatset_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPolicypatsetbinding: Ended"
    }
}

function Invoke-ADCAddPolicypatsetpatternbinding {
<#
    .SYNOPSIS
        Add Policy configuration Object
    .DESCRIPTION
        Add Policy configuration Object 
    .PARAMETER name 
        Name of the pattern set to which to bind the string.  
        Minimum length = 1 
    .PARAMETER String 
        String of characters that constitutes a pattern. For more information about the characters that can be used, refer to the character set parameter. Note: Minimum length for pattern sets used in rewrite actions of type REPLACE_ALL, DELETE_ALL, INSERT_AFTER_ALL, and INSERT_BEFORE_ALL, is three characters. 
    .PARAMETER index 
        The index of the string associated with the patset. 
    .PARAMETER charset 
        Character set associated with the characters in the string. Note: UTF-8 characters can be entered directly (if the UI supports it) or can be encoded as a sequence of hexadecimal bytes '\xNN'. For example, the UTF-8 character 'ü' can be encoded as '\xC3\xBC'.  
        Possible values = ASCII, UTF_8 
    .PARAMETER comment 
        Any comments to preserve information about this patset or a pattern bound to this patset. 
    .PARAMETER PassThru 
        Return details about the created policypatset_pattern_binding item.
    .EXAMPLE
        Invoke-ADCAddPolicypatsetpatternbinding -name <string> -String <string>
    .NOTES
        File Name : Invoke-ADCAddPolicypatsetpatternbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policypatset_pattern_binding/
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
        [string]$String ,

        [double]$index ,

        [ValidateSet('ASCII', 'UTF_8')]
        [string]$charset ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicypatsetpatternbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                String = $String
            }
            if ($PSBoundParameters.ContainsKey('index')) { $Payload.Add('index', $index) }
            if ($PSBoundParameters.ContainsKey('charset')) { $Payload.Add('charset', $charset) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("policypatset_pattern_binding", "Add Policy configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type policypatset_pattern_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPolicypatsetpatternbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddPolicypatsetpatternbinding: Finished"
    }
}

function Invoke-ADCDeletePolicypatsetpatternbinding {
<#
    .SYNOPSIS
        Delete Policy configuration Object
    .DESCRIPTION
        Delete Policy configuration Object
    .PARAMETER name 
       Name of the pattern set to which to bind the string.  
       Minimum length = 1    .PARAMETER String 
       String of characters that constitutes a pattern. For more information about the characters that can be used, refer to the character set parameter. Note: Minimum length for pattern sets used in rewrite actions of type REPLACE_ALL, DELETE_ALL, INSERT_AFTER_ALL, and INSERT_BEFORE_ALL, is three characters.
    .EXAMPLE
        Invoke-ADCDeletePolicypatsetpatternbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeletePolicypatsetpatternbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policypatset_pattern_binding/
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

        [string]$String 
    )
    begin {
        Write-Verbose "Invoke-ADCDeletePolicypatsetpatternbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('String')) { $Arguments.Add('String', $String) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Policy configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policypatset_pattern_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeletePolicypatsetpatternbinding: Finished"
    }
}

function Invoke-ADCGetPolicypatsetpatternbinding {
<#
    .SYNOPSIS
        Get Policy configuration object(s)
    .DESCRIPTION
        Get Policy configuration object(s)
    .PARAMETER name 
       Name of the pattern set to which to bind the string. 
    .PARAMETER GetAll 
        Retreive all policypatset_pattern_binding object(s)
    .PARAMETER Count
        If specified, the count of the policypatset_pattern_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPolicypatsetpatternbinding
    .EXAMPLE 
        Invoke-ADCGetPolicypatsetpatternbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetPolicypatsetpatternbinding -Count
    .EXAMPLE
        Invoke-ADCGetPolicypatsetpatternbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetPolicypatsetpatternbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPolicypatsetpatternbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policypatset_pattern_binding/
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
        Write-Verbose "Invoke-ADCGetPolicypatsetpatternbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all policypatset_pattern_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_pattern_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policypatset_pattern_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_pattern_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policypatset_pattern_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_pattern_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policypatset_pattern_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_pattern_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policypatset_pattern_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_pattern_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPolicypatsetpatternbinding: Ended"
    }
}

function Invoke-ADCAddPolicystringmap {
<#
    .SYNOPSIS
        Add Policy configuration Object
    .DESCRIPTION
        Add Policy configuration Object 
    .PARAMETER name 
        Unique name for the string map. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout.  
        Minimum length = 1 
    .PARAMETER comment 
        Comments associated with the string map or key-value pair bound to this string map. 
    .PARAMETER PassThru 
        Return details about the created policystringmap item.
    .EXAMPLE
        Invoke-ADCAddPolicystringmap -name <string>
    .NOTES
        File Name : Invoke-ADCAddPolicystringmap
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policystringmap/
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

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicystringmap: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("policystringmap", "Add Policy configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policystringmap -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPolicystringmap -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddPolicystringmap: Finished"
    }
}

function Invoke-ADCDeletePolicystringmap {
<#
    .SYNOPSIS
        Delete Policy configuration Object
    .DESCRIPTION
        Delete Policy configuration Object
    .PARAMETER name 
       Unique name for the string map. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeletePolicystringmap -name <string>
    .NOTES
        File Name : Invoke-ADCDeletePolicystringmap
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policystringmap/
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
        Write-Verbose "Invoke-ADCDeletePolicystringmap: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Policy configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policystringmap -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeletePolicystringmap: Finished"
    }
}

function Invoke-ADCUpdatePolicystringmap {
<#
    .SYNOPSIS
        Update Policy configuration Object
    .DESCRIPTION
        Update Policy configuration Object 
    .PARAMETER name 
        Unique name for the string map. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout.  
        Minimum length = 1 
    .PARAMETER comment 
        Comments associated with the string map or key-value pair bound to this string map. 
    .PARAMETER PassThru 
        Return details about the created policystringmap item.
    .EXAMPLE
        Invoke-ADCUpdatePolicystringmap -name <string>
    .NOTES
        File Name : Invoke-ADCUpdatePolicystringmap
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policystringmap/
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

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdatePolicystringmap: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("policystringmap", "Update Policy configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type policystringmap -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPolicystringmap -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdatePolicystringmap: Finished"
    }
}

function Invoke-ADCUnsetPolicystringmap {
<#
    .SYNOPSIS
        Unset Policy configuration Object
    .DESCRIPTION
        Unset Policy configuration Object 
   .PARAMETER name 
       Unique name for the string map. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
   .PARAMETER comment 
       Comments associated with the string map or key-value pair bound to this string map.
    .EXAMPLE
        Invoke-ADCUnsetPolicystringmap -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetPolicystringmap
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policystringmap
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

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetPolicystringmap: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Policy configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type policystringmap -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetPolicystringmap: Finished"
    }
}

function Invoke-ADCGetPolicystringmap {
<#
    .SYNOPSIS
        Get Policy configuration object(s)
    .DESCRIPTION
        Get Policy configuration object(s)
    .PARAMETER name 
       Unique name for the string map. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER GetAll 
        Retreive all policystringmap object(s)
    .PARAMETER Count
        If specified, the count of the policystringmap object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPolicystringmap
    .EXAMPLE 
        Invoke-ADCGetPolicystringmap -GetAll 
    .EXAMPLE 
        Invoke-ADCGetPolicystringmap -Count
    .EXAMPLE
        Invoke-ADCGetPolicystringmap -name <string>
    .EXAMPLE
        Invoke-ADCGetPolicystringmap -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPolicystringmap
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policystringmap/
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
        Write-Verbose "Invoke-ADCGetPolicystringmap: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all policystringmap objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policystringmap objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policystringmap objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policystringmap configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policystringmap configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPolicystringmap: Ended"
    }
}

function Invoke-ADCGetPolicystringmapbinding {
<#
    .SYNOPSIS
        Get Policy configuration object(s)
    .DESCRIPTION
        Get Policy configuration object(s)
    .PARAMETER name 
       Name of the string map to display. If a name is not provided, a list of all the configured string maps is shown. 
    .PARAMETER GetAll 
        Retreive all policystringmap_binding object(s)
    .PARAMETER Count
        If specified, the count of the policystringmap_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPolicystringmapbinding
    .EXAMPLE 
        Invoke-ADCGetPolicystringmapbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetPolicystringmapbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetPolicystringmapbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPolicystringmapbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policystringmap_binding/
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
        Write-Verbose "Invoke-ADCGetPolicystringmapbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all policystringmap_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policystringmap_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policystringmap_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policystringmap_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policystringmap_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPolicystringmapbinding: Ended"
    }
}

function Invoke-ADCAddPolicystringmappatternbinding {
<#
    .SYNOPSIS
        Add Policy configuration Object
    .DESCRIPTION
        Add Policy configuration Object 
    .PARAMETER name 
        Name of the string map to which to bind the key-value pair.  
        Minimum length = 1 
    .PARAMETER key 
        Character string constituting the key to be bound to the string map. The key is matched against the data processed by the operation that uses the string map. The default character set is ASCII. UTF-8 characters can be included if the character set is UTF-8. UTF-8 characters can be entered directly (if the UI supports it) or can be encoded as a sequence of hexadecimal bytes '\xNN'. For example, the UTF-8 character 'ü' can be encoded as '\xC3\xBC'.  
        Minimum length = 1 
    .PARAMETER value 
        Character string constituting the value associated with the key. This value is returned when processed data matches the associated key. Refer to the key parameter for details of the value character set.  
        Minimum length = 1 
    .PARAMETER comment 
        Comments associated with the string map or key-value pair bound to this string map. 
    .PARAMETER PassThru 
        Return details about the created policystringmap_pattern_binding item.
    .EXAMPLE
        Invoke-ADCAddPolicystringmappatternbinding -name <string> -key <string> -value <string>
    .NOTES
        File Name : Invoke-ADCAddPolicystringmappatternbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policystringmap_pattern_binding/
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
        [string]$key ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$value ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicystringmappatternbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                key = $key
                value = $value
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("policystringmap_pattern_binding", "Add Policy configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type policystringmap_pattern_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPolicystringmappatternbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddPolicystringmappatternbinding: Finished"
    }
}

function Invoke-ADCDeletePolicystringmappatternbinding {
<#
    .SYNOPSIS
        Delete Policy configuration Object
    .DESCRIPTION
        Delete Policy configuration Object
    .PARAMETER name 
       Name of the string map to which to bind the key-value pair.  
       Minimum length = 1    .PARAMETER key 
       Character string constituting the key to be bound to the string map. The key is matched against the data processed by the operation that uses the string map. The default character set is ASCII. UTF-8 characters can be included if the character set is UTF-8. UTF-8 characters can be entered directly (if the UI supports it) or can be encoded as a sequence of hexadecimal bytes '\xNN'. For example, the UTF-8 character 'ü' can be encoded as '\xC3\xBC'.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeletePolicystringmappatternbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeletePolicystringmappatternbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policystringmap_pattern_binding/
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

        [string]$key 
    )
    begin {
        Write-Verbose "Invoke-ADCDeletePolicystringmappatternbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('key')) { $Arguments.Add('key', $key) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Policy configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policystringmap_pattern_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeletePolicystringmappatternbinding: Finished"
    }
}

function Invoke-ADCGetPolicystringmappatternbinding {
<#
    .SYNOPSIS
        Get Policy configuration object(s)
    .DESCRIPTION
        Get Policy configuration object(s)
    .PARAMETER name 
       Name of the string map to which to bind the key-value pair. 
    .PARAMETER GetAll 
        Retreive all policystringmap_pattern_binding object(s)
    .PARAMETER Count
        If specified, the count of the policystringmap_pattern_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPolicystringmappatternbinding
    .EXAMPLE 
        Invoke-ADCGetPolicystringmappatternbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetPolicystringmappatternbinding -Count
    .EXAMPLE
        Invoke-ADCGetPolicystringmappatternbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetPolicystringmappatternbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPolicystringmappatternbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policystringmap_pattern_binding/
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
        Write-Verbose "Invoke-ADCGetPolicystringmappatternbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all policystringmap_pattern_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_pattern_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policystringmap_pattern_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_pattern_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policystringmap_pattern_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_pattern_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policystringmap_pattern_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_pattern_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policystringmap_pattern_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_pattern_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPolicystringmappatternbinding: Ended"
    }
}

function Invoke-ADCAddPolicyurlset {
<#
    .SYNOPSIS
        Add Policy configuration Object
    .DESCRIPTION
        Add Policy configuration Object 
    .PARAMETER name 
        Unique name of the url set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER comment 
        Any comments to preserve information about this url set. 
    .PARAMETER PassThru 
        Return details about the created policyurlset item.
    .EXAMPLE
        Invoke-ADCAddPolicyurlset -name <string>
    .NOTES
        File Name : Invoke-ADCAddPolicyurlset
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyurlset/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicyurlset: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("policyurlset", "Add Policy configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policyurlset -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPolicyurlset -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddPolicyurlset: Finished"
    }
}

function Invoke-ADCDeletePolicyurlset {
<#
    .SYNOPSIS
        Delete Policy configuration Object
    .DESCRIPTION
        Delete Policy configuration Object
    .PARAMETER name 
       Unique name of the url set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout.  
       Minimum length = 1  
       Maximum length = 127 
    .EXAMPLE
        Invoke-ADCDeletePolicyurlset -name <string>
    .NOTES
        File Name : Invoke-ADCDeletePolicyurlset
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyurlset/
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
        Write-Verbose "Invoke-ADCDeletePolicyurlset: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Policy configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policyurlset -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeletePolicyurlset: Finished"
    }
}

function Invoke-ADCImportPolicyurlset {
<#
    .SYNOPSIS
        Import Policy configuration Object
    .DESCRIPTION
        Import Policy configuration Object 
    .PARAMETER name 
        Unique name of the url set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER overwrite 
        Overwrites the existing file. 
    .PARAMETER delimiter 
        CSV file record delimiter. 
    .PARAMETER rowseparator 
        CSV file row separator. 
    .PARAMETER url 
        URL (protocol, host, path and file name) from where the CSV (comma separated file) file will be imported or exported. Each record/line will one entry within the urlset. The first field contains the URL pattern, subsequent fields contains the metadata, if available. HTTP, HTTPS and FTP protocols are supported. NOTE: The operation fails if the destination HTTPS server requires client certificate authentication for access. 
    .PARAMETER interval 
        The interval, in seconds, rounded down to the nearest 15 minutes, at which the update of urlset occurs. 
    .PARAMETER privateset 
        Prevent this urlset from being exported. 
    .PARAMETER subdomainexactmatch 
        Force exact subdomain matching, ex. given an entry 'google.com' in the urlset, a request to 'news.google.com' won't match, if subdomainExactMatch is set. 
    .PARAMETER matchedid 
        An ID that would be sent to AppFlow to indicate which URLSet was the last one that matched the requested URL. 
    .PARAMETER canaryurl 
        Add this URL to this urlset. Used for testing when contents of urlset is kept confidential.
    .EXAMPLE
        Invoke-ADCImportPolicyurlset -name <string> -url <string>
    .NOTES
        File Name : Invoke-ADCImportPolicyurlset
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyurlset/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [boolean]$overwrite ,

        [string]$delimiter ,

        [string]$rowseparator ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 2047)]
        [string]$url ,

        [ValidateRange(0, 2592000)]
        [double]$interval ,

        [boolean]$privateset ,

        [boolean]$subdomainexactmatch ,

        [ValidateRange(2, 31)]
        [double]$matchedid ,

        [ValidateLength(1, 2047)]
        [string]$canaryurl 

    )
    begin {
        Write-Verbose "Invoke-ADCImportPolicyurlset: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                url = $url
            }
            if ($PSBoundParameters.ContainsKey('overwrite')) { $Payload.Add('overwrite', $overwrite) }
            if ($PSBoundParameters.ContainsKey('delimiter')) { $Payload.Add('delimiter', $delimiter) }
            if ($PSBoundParameters.ContainsKey('rowseparator')) { $Payload.Add('rowseparator', $rowseparator) }
            if ($PSBoundParameters.ContainsKey('interval')) { $Payload.Add('interval', $interval) }
            if ($PSBoundParameters.ContainsKey('privateset')) { $Payload.Add('privateset', $privateset) }
            if ($PSBoundParameters.ContainsKey('subdomainexactmatch')) { $Payload.Add('subdomainexactmatch', $subdomainexactmatch) }
            if ($PSBoundParameters.ContainsKey('matchedid')) { $Payload.Add('matchedid', $matchedid) }
            if ($PSBoundParameters.ContainsKey('canaryurl')) { $Payload.Add('canaryurl', $canaryurl) }
            if ($PSCmdlet.ShouldProcess($Name, "Import Policy configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policyurlset -Action import -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportPolicyurlset: Finished"
    }
}

function Invoke-ADCChangePolicyurlset {
<#
    .SYNOPSIS
        Change Policy configuration Object
    .DESCRIPTION
        Change Policy configuration Object 
    .PARAMETER name 
        Unique name of the url set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER PassThru 
        Return details about the created policyurlset item.
    .EXAMPLE
        Invoke-ADCChangePolicyurlset -name <string>
    .NOTES
        File Name : Invoke-ADCChangePolicyurlset
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyurlset/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCChangePolicyurlset: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

 
            if ($PSCmdlet.ShouldProcess("policyurlset", "Change Policy configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policyurlset -Action update -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPolicyurlset -Filter $Payload)
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
        Write-Verbose "Invoke-ADCChangePolicyurlset: Finished"
    }
}

function Invoke-ADCExportPolicyurlset {
<#
    .SYNOPSIS
        Export Policy configuration Object
    .DESCRIPTION
        Export Policy configuration Object 
    .PARAMETER name 
        Unique name of the url set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER url 
        URL (protocol, host, path and file name) from where the CSV (comma separated file) file will be imported or exported. Each record/line will one entry within the urlset. The first field contains the URL pattern, subsequent fields contains the metadata, if available. HTTP, HTTPS and FTP protocols are supported. NOTE: The operation fails if the destination HTTPS server requires client certificate authentication for access.
    .EXAMPLE
        Invoke-ADCExportPolicyurlset -name <string> -url <string>
    .NOTES
        File Name : Invoke-ADCExportPolicyurlset
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyurlset/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 2047)]
        [string]$url 

    )
    begin {
        Write-Verbose "Invoke-ADCExportPolicyurlset: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                url = $url
            }

            if ($PSCmdlet.ShouldProcess($Name, "Export Policy configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policyurlset -Action export -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCExportPolicyurlset: Finished"
    }
}

function Invoke-ADCGetPolicyurlset {
<#
    .SYNOPSIS
        Get Policy configuration object(s)
    .DESCRIPTION
        Get Policy configuration object(s)
    .PARAMETER name 
       Unique name of the url set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER GetAll 
        Retreive all policyurlset object(s)
    .PARAMETER Count
        If specified, the count of the policyurlset object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPolicyurlset
    .EXAMPLE 
        Invoke-ADCGetPolicyurlset -GetAll 
    .EXAMPLE 
        Invoke-ADCGetPolicyurlset -Count
    .EXAMPLE
        Invoke-ADCGetPolicyurlset -name <string>
    .EXAMPLE
        Invoke-ADCGetPolicyurlset -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPolicyurlset
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyurlset/
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
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-ADCGetPolicyurlset: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all policyurlset objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyurlset -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policyurlset objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyurlset -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policyurlset objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyurlset -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policyurlset configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyurlset -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policyurlset configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyurlset -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPolicyurlset: Ended"
    }
}


