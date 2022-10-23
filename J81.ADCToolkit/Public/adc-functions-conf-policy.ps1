function Invoke-ADCAddPolicydataset {
    <#
    .SYNOPSIS
        Add Policy configuration Object.
    .DESCRIPTION
        Configuration for TYPE set resource.
    .PARAMETER Name 
        Name of the dataset. Must not exceed 127 characters. 
    .PARAMETER Type 
        Type of value to bind to the dataset. 
        Possible values = ipv4, number, ipv6, ulong, double, mac 
    .PARAMETER Comment 
        Any comments to preserve information about this dataset or a data bound to this dataset. 
    .PARAMETER Patsetfile 
        File which contains list of patterns that needs to be bound to the dataset. A patsetfile cannot be associated with multiple datasets. 
    .PARAMETER PassThru 
        Return details about the created policydataset item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddPolicydataset -name <string> -type <string>
        An example how to add policydataset configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddPolicydataset
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policydataset/
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
        [ValidateSet('ipv4', 'number', 'ipv6', 'ulong', 'double', 'mac')]
        [string]$Type,

        [string]$Comment,

        [string]$Patsetfile,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicydataset: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                type           = $type
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('patsetfile') ) { $payload.Add('patsetfile', $patsetfile) }
            if ( $PSCmdlet.ShouldProcess("policydataset", "Add Policy configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policydataset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetPolicydataset -Filter $payload)
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
        Delete Policy configuration Object.
    .DESCRIPTION
        Configuration for TYPE set resource.
    .PARAMETER Name 
        Name of the dataset. Must not exceed 127 characters.
    .EXAMPLE
        PS C:\>Invoke-ADCDeletePolicydataset -Name <string>
        An example how to delete policydataset configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeletePolicydataset
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policydataset/
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
        Write-Verbose "Invoke-ADCDeletePolicydataset: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policydataset -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Policy configuration object(s).
    .DESCRIPTION
        Configuration for TYPE set resource.
    .PARAMETER Name 
        Name of the dataset. Must not exceed 127 characters. 
    .PARAMETER GetAll 
        Retrieve all policydataset object(s).
    .PARAMETER Count
        If specified, the count of the policydataset object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicydataset
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicydataset -GetAll 
        Get all policydataset data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicydataset -Count 
        Get the number of policydataset objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicydataset -name <string>
        Get policydataset object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicydataset -Filter @{ 'name'='<value>' }
        Get policydataset data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPolicydataset
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policydataset/
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
        Write-Verbose "Invoke-ADCGetPolicydataset: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policydataset objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policydataset objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policydataset objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policydataset configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policydataset configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Policy configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to policydataset.
    .PARAMETER Name 
        Name of the dataset. Must not exceed 127 characters. 
    .PARAMETER GetAll 
        Retrieve all policydataset_binding object(s).
    .PARAMETER Count
        If specified, the count of the policydataset_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicydatasetbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicydatasetbinding -GetAll 
        Get all policydataset_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicydatasetbinding -name <string>
        Get policydataset_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicydatasetbinding -Filter @{ 'name'='<value>' }
        Get policydataset_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPolicydatasetbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policydataset_binding/
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
        Write-Verbose "Invoke-ADCGetPolicydatasetbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all policydataset_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policydataset_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policydataset_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policydataset_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policydataset_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Policy configuration Object.
    .DESCRIPTION
        Binding object showing the value that can be bound to policydataset.
    .PARAMETER Name 
        Name of the dataset to which to bind the value. 
    .PARAMETER Value 
        Value of the specified type that is associated with the dataset. 
    .PARAMETER Index 
        The index of the value (ipv4, ipv6, number) associated with the set. 
    .PARAMETER Endrange 
        The dataset entry is a range from <value> through <end_range>, inclusive. 
    .PARAMETER Comment 
        Any comments to preserve information about this dataset or a data bound to this dataset. 
    .PARAMETER PassThru 
        Return details about the created policydataset_value_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddPolicydatasetvaluebinding -name <string> -value <string>
        An example how to add policydataset_value_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddPolicydatasetvaluebinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policydataset_value_binding/
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
        [string]$Value,

        [double]$Index,

        [string]$Endrange,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicydatasetvaluebinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                value          = $value
            }
            if ( $PSBoundParameters.ContainsKey('index') ) { $payload.Add('index', $index) }
            if ( $PSBoundParameters.ContainsKey('endrange') ) { $payload.Add('endrange', $endrange) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("policydataset_value_binding", "Add Policy configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type policydataset_value_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetPolicydatasetvaluebinding -Filter $payload)
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
        Delete Policy configuration Object.
    .DESCRIPTION
        Binding object showing the value that can be bound to policydataset.
    .PARAMETER Name 
        Name of the dataset to which to bind the value. 
    .PARAMETER Value 
        Value of the specified type that is associated with the dataset. 
    .PARAMETER Endrange 
        The dataset entry is a range from <value> through <end_range>, inclusive.
    .EXAMPLE
        PS C:\>Invoke-ADCDeletePolicydatasetvaluebinding -Name <string>
        An example how to delete policydataset_value_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeletePolicydatasetvaluebinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policydataset_value_binding/
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

        [string]$Value,

        [string]$Endrange 
    )
    begin {
        Write-Verbose "Invoke-ADCDeletePolicydatasetvaluebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Value') ) { $arguments.Add('value', $Value) }
            if ( $PSBoundParameters.ContainsKey('Endrange') ) { $arguments.Add('endrange', $Endrange) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policydataset_value_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Policy configuration object(s).
    .DESCRIPTION
        Binding object showing the value that can be bound to policydataset.
    .PARAMETER Name 
        Name of the dataset to which to bind the value. 
    .PARAMETER GetAll 
        Retrieve all policydataset_value_binding object(s).
    .PARAMETER Count
        If specified, the count of the policydataset_value_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicydatasetvaluebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicydatasetvaluebinding -GetAll 
        Get all policydataset_value_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicydatasetvaluebinding -Count 
        Get the number of policydataset_value_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicydatasetvaluebinding -name <string>
        Get policydataset_value_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicydatasetvaluebinding -Filter @{ 'name'='<value>' }
        Get policydataset_value_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPolicydatasetvaluebinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policydataset_value_binding/
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
        Write-Verbose "Invoke-ADCGetPolicydatasetvaluebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all policydataset_value_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_value_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policydataset_value_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_value_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policydataset_value_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_value_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policydataset_value_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_value_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policydataset_value_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policydataset_value_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Policy configuration object(s).
    .DESCRIPTION
        Configuration for expr evaluation resource.
    .PARAMETER Expression 
        Expression string. For example: http.req.body(100).contains("this"). 
    .PARAMETER Action 
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
    .PARAMETER Type 
        Indicates request or response input packet. 
        Possible values = HTTP_REQ, HTTP_RES, TEXT 
    .PARAMETER Input 
        Text representation of input packet. 
    .PARAMETER GetAll 
        Retrieve all policyevaluation object(s).
    .PARAMETER Count
        If specified, the count of the policyevaluation object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicyevaluation
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicyevaluation -GetAll 
        Get all policyevaluation data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicyevaluation -Count 
        Get the number of policyevaluation objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicyevaluation -name <string>
        Get policyevaluation object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicyevaluation -Filter @{ 'name'='<value>' }
        Get policyevaluation data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPolicyevaluation
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyevaluation/
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

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Expression,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Action,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('HTTP_REQ', 'HTTP_RES', 'TEXT')]
        [string]$Type,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Input,
			
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policyevaluation objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyevaluation -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policyevaluation objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyevaluation -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policyevaluation objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('expression') ) { $arguments.Add('expression', $expression) } 
                if ( $PSBoundParameters.ContainsKey('action') ) { $arguments.Add('action', $action) } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) } 
                if ( $PSBoundParameters.ContainsKey('input') ) { $arguments.Add('input', $input) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyevaluation -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policyevaluation configuration for property ''"

            } else {
                Write-Verbose "Retrieving policyevaluation configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyevaluation -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Policy configuration Object.
    .DESCRIPTION
        Configuration for expression resource.
    .PARAMETER Name 
        Unique name for the expression. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
    .PARAMETER Value 
        Expression string. For example: http.req.body(100).contains("this"). 
    .PARAMETER Comment 
        Any comments associated with the expression. Displayed upon viewing the policy expression. 
    .PARAMETER Clientsecuritymessage 
        Message to display if the expression fails. Allowed for classic end-point check expressions only. 
    .PARAMETER PassThru 
        Return details about the created policyexpression item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddPolicyexpression -name <string> -value <string>
        An example how to add policyexpression configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddPolicyexpression
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyexpression/
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
        [string]$Value,

        [string]$Comment,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Clientsecuritymessage,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicyexpression: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                value          = $value
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('clientsecuritymessage') ) { $payload.Add('clientsecuritymessage', $clientsecuritymessage) }
            if ( $PSCmdlet.ShouldProcess("policyexpression", "Add Policy configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policyexpression -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetPolicyexpression -Filter $payload)
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
        Delete Policy configuration Object.
    .DESCRIPTION
        Configuration for expression resource.
    .PARAMETER Name 
        Unique name for the expression. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout.
    .EXAMPLE
        PS C:\>Invoke-ADCDeletePolicyexpression -Name <string>
        An example how to delete policyexpression configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeletePolicyexpression
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyexpression/
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
        Write-Verbose "Invoke-ADCDeletePolicyexpression: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policyexpression -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update Policy configuration Object.
    .DESCRIPTION
        Configuration for expression resource.
    .PARAMETER Name 
        Unique name for the expression. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
    .PARAMETER Value 
        Expression string. For example: http.req.body(100).contains("this"). 
    .PARAMETER Comment 
        Any comments associated with the expression. Displayed upon viewing the policy expression. 
    .PARAMETER Clientsecuritymessage 
        Message to display if the expression fails. Allowed for classic end-point check expressions only. 
    .PARAMETER PassThru 
        Return details about the created policyexpression item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdatePolicyexpression -name <string>
        An example how to update policyexpression configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdatePolicyexpression
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyexpression/
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

        [string]$Value,

        [string]$Comment,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Clientsecuritymessage,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdatePolicyexpression: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('value') ) { $payload.Add('value', $value) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('clientsecuritymessage') ) { $payload.Add('clientsecuritymessage', $clientsecuritymessage) }
            if ( $PSCmdlet.ShouldProcess("policyexpression", "Update Policy configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type policyexpression -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetPolicyexpression -Filter $payload)
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
        Unset Policy configuration Object.
    .DESCRIPTION
        Configuration for expression resource.
    .PARAMETER Name 
        Unique name for the expression. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
    .PARAMETER Comment 
        Any comments associated with the expression. Displayed upon viewing the policy expression. 
    .PARAMETER Clientsecuritymessage 
        Message to display if the expression fails. Allowed for classic end-point check expressions only.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetPolicyexpression -name <string>
        An example how to unset policyexpression configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetPolicyexpression
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyexpression
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

        [Boolean]$comment,

        [Boolean]$clientsecuritymessage 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetPolicyexpression: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('clientsecuritymessage') ) { $payload.Add('clientsecuritymessage', $clientsecuritymessage) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Policy configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type policyexpression -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get Policy configuration object(s).
    .DESCRIPTION
        Configuration for expression resource.
    .PARAMETER Name 
        Unique name for the expression. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
    .PARAMETER GetAll 
        Retrieve all policyexpression object(s).
    .PARAMETER Count
        If specified, the count of the policyexpression object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicyexpression
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicyexpression -GetAll 
        Get all policyexpression data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicyexpression -Count 
        Get the number of policyexpression objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicyexpression -name <string>
        Get policyexpression object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicyexpression -Filter @{ 'name'='<value>' }
        Get policyexpression data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPolicyexpression
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyexpression/
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
        Write-Verbose "Invoke-ADCGetPolicyexpression: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policyexpression objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyexpression -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policyexpression objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyexpression -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policyexpression objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyexpression -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policyexpression configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyexpression -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policyexpression configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyexpression -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Policy configuration Object.
    .DESCRIPTION
        Configuration for HTTP callout resource.
    .PARAMETER Name 
        Name for the HTTP callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
    .PARAMETER Ipaddress 
        IP Address of the server (callout agent) to which the callout is sent. Can be an IPv4 or IPv6 address. 
        Mutually exclusive with the Virtual Server parameter. Therefore, you cannot set the <IP Address, Port> and the Virtual Server in the same HTTP callout. 
    .PARAMETER Port 
        Server port to which the HTTP callout agent is mapped. Mutually exclusive with the Virtual Server parameter. Therefore, you cannot set the <IP Address, Port> and the Virtual Server in the same HTTP callout. 
    .PARAMETER Vserver 
        Name of the load balancing, content switching, or cache redirection virtual server (the callout agent) to which the HTTP callout is sent. The service type of the virtual server must be HTTP. Mutually exclusive with the IP address and port parameters. Therefore, you cannot set the <IP Address, Port> and the Virtual Server in the same HTTP callout. 
    .PARAMETER Returntype 
        Type of data that the target callout agent returns in response to the callout. 
        Available settings function as follows: 
        * TEXT - Treat the returned value as a text string. 
        * NUM - Treat the returned value as a number. 
        * BOOL - Treat the returned value as a Boolean value. 
        Note: You cannot change the return type after it is set. 
        Possible values = BOOL, NUM, TEXT 
    .PARAMETER Httpmethod 
        Method used in the HTTP request that this callout sends. Mutually exclusive with the full HTTP request expression. 
        Possible values = GET, POST 
    .PARAMETER Hostexpr 
        String expression to configure the Host header. Can contain a literal value (for example, 10.101.10.11) or a derived value (for example, http.req.header("Host")). The literal value can be an IP address or a fully qualified domain name. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Urlstemexpr 
        String expression for generating the URL stem. Can contain a literal string (for example, "/mysite/index.html") or an expression that derives the value (for example, http.req.url). Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Headers 
        One or more headers to insert into the HTTP request. Each header is specified as "name(expr)", where expr is an expression that is evaluated at runtime to provide the value for the named header. You can configure a maximum of eight headers for an HTTP callout. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Parameters 
        One or more query parameters to insert into the HTTP request URL (for a GET request) or into the request body (for a POST request). Each parameter is specified as "name(expr)", where expr is an expression that is evaluated at run time to provide the value for the named parameter (name=value). The parameter values are URL encoded. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Bodyexpr 
        An advanced string expression for generating the body of the request. The expression can contain a literal string or an expression that derives the value (for example, client.ip.src). Mutually exclusive with -fullReqExpr. 
    .PARAMETER Fullreqexpr 
        Exact HTTP request, in the form of an expression, which the Citrix ADC sends to the callout agent. If you set this parameter, you must not include HTTP method, host expression, URL stem expression, headers, or parameters. 
        The request expression is constrained by the feature for which the callout is used. For example, an HTTP.RES expression cannot be used in a request-time policy bank or in a TCP content switching policy bank. 
        The Citrix ADC does not check the validity of this request. You must manually validate the request. 
    .PARAMETER Scheme 
        Type of scheme for the callout server. 
        Possible values = http, https 
    .PARAMETER Resultexpr 
        Expression that extracts the callout results from the response sent by the HTTP callout agent. Must be a response based expression, that is, it must begin with HTTP.RES. The operations in this expression must match the return type. For example, if you configure a return type of TEXT, the result expression must be a text based expression. If the return type is NUM, the result expression (resultExpr) must return a numeric value, as in the following example: http.res.body(10000).length. 
    .PARAMETER Cacheforsecs 
        Duration, in seconds, for which the callout response is cached. The cached responses are stored in an integrated caching content group named "calloutContentGroup". If no duration is configured, the callout responses will not be cached unless normal caching configuration is used to cache them. This parameter takes precedence over any normal caching configuration that would otherwise apply to these responses. 
        Note that the calloutContentGroup definition may not be modified or removed nor may it be used with other cache policies. 
    .PARAMETER Comment 
        Any comments to preserve information about this HTTP callout. 
    .PARAMETER PassThru 
        Return details about the created policyhttpcallout item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddPolicyhttpcallout -name <string>
        An example how to add policyhttpcallout configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddPolicyhttpcallout
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyhttpcallout/
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

        [string]$Ipaddress,

        [int]$Port,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Vserver,

        [ValidateSet('BOOL', 'NUM', 'TEXT')]
        [string]$Returntype,

        [ValidateSet('GET', 'POST')]
        [string]$Httpmethod,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Hostexpr,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Urlstemexpr,

        [string[]]$Headers,

        [string[]]$Parameters,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bodyexpr,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Fullreqexpr,

        [ValidateSet('http', 'https')]
        [string]$Scheme,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Resultexpr,

        [ValidateRange(1, 31536000)]
        [double]$Cacheforsecs,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicyhttpcallout: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSBoundParameters.ContainsKey('returntype') ) { $payload.Add('returntype', $returntype) }
            if ( $PSBoundParameters.ContainsKey('httpmethod') ) { $payload.Add('httpmethod', $httpmethod) }
            if ( $PSBoundParameters.ContainsKey('hostexpr') ) { $payload.Add('hostexpr', $hostexpr) }
            if ( $PSBoundParameters.ContainsKey('urlstemexpr') ) { $payload.Add('urlstemexpr', $urlstemexpr) }
            if ( $PSBoundParameters.ContainsKey('headers') ) { $payload.Add('headers', $headers) }
            if ( $PSBoundParameters.ContainsKey('parameters') ) { $payload.Add('parameters', $parameters) }
            if ( $PSBoundParameters.ContainsKey('bodyexpr') ) { $payload.Add('bodyexpr', $bodyexpr) }
            if ( $PSBoundParameters.ContainsKey('fullreqexpr') ) { $payload.Add('fullreqexpr', $fullreqexpr) }
            if ( $PSBoundParameters.ContainsKey('scheme') ) { $payload.Add('scheme', $scheme) }
            if ( $PSBoundParameters.ContainsKey('resultexpr') ) { $payload.Add('resultexpr', $resultexpr) }
            if ( $PSBoundParameters.ContainsKey('cacheforsecs') ) { $payload.Add('cacheforsecs', $cacheforsecs) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("policyhttpcallout", "Add Policy configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policyhttpcallout -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetPolicyhttpcallout -Filter $payload)
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
        Delete Policy configuration Object.
    .DESCRIPTION
        Configuration for HTTP callout resource.
    .PARAMETER Name 
        Name for the HTTP callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout.
    .EXAMPLE
        PS C:\>Invoke-ADCDeletePolicyhttpcallout -Name <string>
        An example how to delete policyhttpcallout configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeletePolicyhttpcallout
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyhttpcallout/
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
        Write-Verbose "Invoke-ADCDeletePolicyhttpcallout: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policyhttpcallout -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update Policy configuration Object.
    .DESCRIPTION
        Configuration for HTTP callout resource.
    .PARAMETER Name 
        Name for the HTTP callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
    .PARAMETER Ipaddress 
        IP Address of the server (callout agent) to which the callout is sent. Can be an IPv4 or IPv6 address. 
        Mutually exclusive with the Virtual Server parameter. Therefore, you cannot set the <IP Address, Port> and the Virtual Server in the same HTTP callout. 
    .PARAMETER Port 
        Server port to which the HTTP callout agent is mapped. Mutually exclusive with the Virtual Server parameter. Therefore, you cannot set the <IP Address, Port> and the Virtual Server in the same HTTP callout. 
    .PARAMETER Vserver 
        Name of the load balancing, content switching, or cache redirection virtual server (the callout agent) to which the HTTP callout is sent. The service type of the virtual server must be HTTP. Mutually exclusive with the IP address and port parameters. Therefore, you cannot set the <IP Address, Port> and the Virtual Server in the same HTTP callout. 
    .PARAMETER Returntype 
        Type of data that the target callout agent returns in response to the callout. 
        Available settings function as follows: 
        * TEXT - Treat the returned value as a text string. 
        * NUM - Treat the returned value as a number. 
        * BOOL - Treat the returned value as a Boolean value. 
        Note: You cannot change the return type after it is set. 
        Possible values = BOOL, NUM, TEXT 
    .PARAMETER Httpmethod 
        Method used in the HTTP request that this callout sends. Mutually exclusive with the full HTTP request expression. 
        Possible values = GET, POST 
    .PARAMETER Hostexpr 
        String expression to configure the Host header. Can contain a literal value (for example, 10.101.10.11) or a derived value (for example, http.req.header("Host")). The literal value can be an IP address or a fully qualified domain name. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Urlstemexpr 
        String expression for generating the URL stem. Can contain a literal string (for example, "/mysite/index.html") or an expression that derives the value (for example, http.req.url). Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Headers 
        One or more headers to insert into the HTTP request. Each header is specified as "name(expr)", where expr is an expression that is evaluated at runtime to provide the value for the named header. You can configure a maximum of eight headers for an HTTP callout. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Parameters 
        One or more query parameters to insert into the HTTP request URL (for a GET request) or into the request body (for a POST request). Each parameter is specified as "name(expr)", where expr is an expression that is evaluated at run time to provide the value for the named parameter (name=value). The parameter values are URL encoded. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Bodyexpr 
        An advanced string expression for generating the body of the request. The expression can contain a literal string or an expression that derives the value (for example, client.ip.src). Mutually exclusive with -fullReqExpr. 
    .PARAMETER Fullreqexpr 
        Exact HTTP request, in the form of an expression, which the Citrix ADC sends to the callout agent. If you set this parameter, you must not include HTTP method, host expression, URL stem expression, headers, or parameters. 
        The request expression is constrained by the feature for which the callout is used. For example, an HTTP.RES expression cannot be used in a request-time policy bank or in a TCP content switching policy bank. 
        The Citrix ADC does not check the validity of this request. You must manually validate the request. 
    .PARAMETER Scheme 
        Type of scheme for the callout server. 
        Possible values = http, https 
    .PARAMETER Resultexpr 
        Expression that extracts the callout results from the response sent by the HTTP callout agent. Must be a response based expression, that is, it must begin with HTTP.RES. The operations in this expression must match the return type. For example, if you configure a return type of TEXT, the result expression must be a text based expression. If the return type is NUM, the result expression (resultExpr) must return a numeric value, as in the following example: http.res.body(10000).length. 
    .PARAMETER Cacheforsecs 
        Duration, in seconds, for which the callout response is cached. The cached responses are stored in an integrated caching content group named "calloutContentGroup". If no duration is configured, the callout responses will not be cached unless normal caching configuration is used to cache them. This parameter takes precedence over any normal caching configuration that would otherwise apply to these responses. 
        Note that the calloutContentGroup definition may not be modified or removed nor may it be used with other cache policies. 
    .PARAMETER Comment 
        Any comments to preserve information about this HTTP callout. 
    .PARAMETER PassThru 
        Return details about the created policyhttpcallout item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdatePolicyhttpcallout -name <string>
        An example how to update policyhttpcallout configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdatePolicyhttpcallout
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyhttpcallout/
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

        [string]$Ipaddress,

        [int]$Port,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Vserver,

        [ValidateSet('BOOL', 'NUM', 'TEXT')]
        [string]$Returntype,

        [ValidateSet('GET', 'POST')]
        [string]$Httpmethod,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Hostexpr,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Urlstemexpr,

        [string[]]$Headers,

        [string[]]$Parameters,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bodyexpr,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Fullreqexpr,

        [ValidateSet('http', 'https')]
        [string]$Scheme,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Resultexpr,

        [ValidateRange(1, 31536000)]
        [double]$Cacheforsecs,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdatePolicyhttpcallout: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSBoundParameters.ContainsKey('returntype') ) { $payload.Add('returntype', $returntype) }
            if ( $PSBoundParameters.ContainsKey('httpmethod') ) { $payload.Add('httpmethod', $httpmethod) }
            if ( $PSBoundParameters.ContainsKey('hostexpr') ) { $payload.Add('hostexpr', $hostexpr) }
            if ( $PSBoundParameters.ContainsKey('urlstemexpr') ) { $payload.Add('urlstemexpr', $urlstemexpr) }
            if ( $PSBoundParameters.ContainsKey('headers') ) { $payload.Add('headers', $headers) }
            if ( $PSBoundParameters.ContainsKey('parameters') ) { $payload.Add('parameters', $parameters) }
            if ( $PSBoundParameters.ContainsKey('bodyexpr') ) { $payload.Add('bodyexpr', $bodyexpr) }
            if ( $PSBoundParameters.ContainsKey('fullreqexpr') ) { $payload.Add('fullreqexpr', $fullreqexpr) }
            if ( $PSBoundParameters.ContainsKey('scheme') ) { $payload.Add('scheme', $scheme) }
            if ( $PSBoundParameters.ContainsKey('resultexpr') ) { $payload.Add('resultexpr', $resultexpr) }
            if ( $PSBoundParameters.ContainsKey('cacheforsecs') ) { $payload.Add('cacheforsecs', $cacheforsecs) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("policyhttpcallout", "Update Policy configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type policyhttpcallout -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetPolicyhttpcallout -Filter $payload)
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
        Unset Policy configuration Object.
    .DESCRIPTION
        Configuration for HTTP callout resource.
    .PARAMETER Name 
        Name for the HTTP callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
    .PARAMETER Ipaddress 
        IP Address of the server (callout agent) to which the callout is sent. Can be an IPv4 or IPv6 address. 
        Mutually exclusive with the Virtual Server parameter. Therefore, you cannot set the <IP Address, Port> and the Virtual Server in the same HTTP callout. 
    .PARAMETER Port 
        Server port to which the HTTP callout agent is mapped. Mutually exclusive with the Virtual Server parameter. Therefore, you cannot set the <IP Address, Port> and the Virtual Server in the same HTTP callout. 
    .PARAMETER Vserver 
        Name of the load balancing, content switching, or cache redirection virtual server (the callout agent) to which the HTTP callout is sent. The service type of the virtual server must be HTTP. Mutually exclusive with the IP address and port parameters. Therefore, you cannot set the <IP Address, Port> and the Virtual Server in the same HTTP callout. 
    .PARAMETER Httpmethod 
        Method used in the HTTP request that this callout sends. Mutually exclusive with the full HTTP request expression. 
        Possible values = GET, POST 
    .PARAMETER Hostexpr 
        String expression to configure the Host header. Can contain a literal value (for example, 10.101.10.11) or a derived value (for example, http.req.header("Host")). The literal value can be an IP address or a fully qualified domain name. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Urlstemexpr 
        String expression for generating the URL stem. Can contain a literal string (for example, "/mysite/index.html") or an expression that derives the value (for example, http.req.url). Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Headers 
        One or more headers to insert into the HTTP request. Each header is specified as "name(expr)", where expr is an expression that is evaluated at runtime to provide the value for the named header. You can configure a maximum of eight headers for an HTTP callout. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Parameters 
        One or more query parameters to insert into the HTTP request URL (for a GET request) or into the request body (for a POST request). Each parameter is specified as "name(expr)", where expr is an expression that is evaluated at run time to provide the value for the named parameter (name=value). The parameter values are URL encoded. Mutually exclusive with the full HTTP request expression. 
    .PARAMETER Bodyexpr 
        An advanced string expression for generating the body of the request. The expression can contain a literal string or an expression that derives the value (for example, client.ip.src). Mutually exclusive with -fullReqExpr. 
    .PARAMETER Fullreqexpr 
        Exact HTTP request, in the form of an expression, which the Citrix ADC sends to the callout agent. If you set this parameter, you must not include HTTP method, host expression, URL stem expression, headers, or parameters. 
        The request expression is constrained by the feature for which the callout is used. For example, an HTTP.RES expression cannot be used in a request-time policy bank or in a TCP content switching policy bank. 
        The Citrix ADC does not check the validity of this request. You must manually validate the request. 
    .PARAMETER Resultexpr 
        Expression that extracts the callout results from the response sent by the HTTP callout agent. Must be a response based expression, that is, it must begin with HTTP.RES. The operations in this expression must match the return type. For example, if you configure a return type of TEXT, the result expression must be a text based expression. If the return type is NUM, the result expression (resultExpr) must return a numeric value, as in the following example: http.res.body(10000).length. 
    .PARAMETER Cacheforsecs 
        Duration, in seconds, for which the callout response is cached. The cached responses are stored in an integrated caching content group named "calloutContentGroup". If no duration is configured, the callout responses will not be cached unless normal caching configuration is used to cache them. This parameter takes precedence over any normal caching configuration that would otherwise apply to these responses. 
        Note that the calloutContentGroup definition may not be modified or removed nor may it be used with other cache policies. 
    .PARAMETER Comment 
        Any comments to preserve information about this HTTP callout.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetPolicyhttpcallout -name <string>
        An example how to unset policyhttpcallout configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetPolicyhttpcallout
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyhttpcallout
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

        [Boolean]$ipaddress,

        [Boolean]$port,

        [Boolean]$vserver,

        [Boolean]$httpmethod,

        [Boolean]$hostexpr,

        [Boolean]$urlstemexpr,

        [Boolean]$headers,

        [Boolean]$parameters,

        [Boolean]$bodyexpr,

        [Boolean]$fullreqexpr,

        [Boolean]$resultexpr,

        [Boolean]$cacheforsecs,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetPolicyhttpcallout: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSBoundParameters.ContainsKey('httpmethod') ) { $payload.Add('httpmethod', $httpmethod) }
            if ( $PSBoundParameters.ContainsKey('hostexpr') ) { $payload.Add('hostexpr', $hostexpr) }
            if ( $PSBoundParameters.ContainsKey('urlstemexpr') ) { $payload.Add('urlstemexpr', $urlstemexpr) }
            if ( $PSBoundParameters.ContainsKey('headers') ) { $payload.Add('headers', $headers) }
            if ( $PSBoundParameters.ContainsKey('parameters') ) { $payload.Add('parameters', $parameters) }
            if ( $PSBoundParameters.ContainsKey('bodyexpr') ) { $payload.Add('bodyexpr', $bodyexpr) }
            if ( $PSBoundParameters.ContainsKey('fullreqexpr') ) { $payload.Add('fullreqexpr', $fullreqexpr) }
            if ( $PSBoundParameters.ContainsKey('resultexpr') ) { $payload.Add('resultexpr', $resultexpr) }
            if ( $PSBoundParameters.ContainsKey('cacheforsecs') ) { $payload.Add('cacheforsecs', $cacheforsecs) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Policy configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type policyhttpcallout -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get Policy configuration object(s).
    .DESCRIPTION
        Configuration for HTTP callout resource.
    .PARAMETER Name 
        Name for the HTTP callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or HTTP callout. 
    .PARAMETER GetAll 
        Retrieve all policyhttpcallout object(s).
    .PARAMETER Count
        If specified, the count of the policyhttpcallout object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicyhttpcallout
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicyhttpcallout -GetAll 
        Get all policyhttpcallout data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicyhttpcallout -Count 
        Get the number of policyhttpcallout objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicyhttpcallout -name <string>
        Get policyhttpcallout object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicyhttpcallout -Filter @{ 'name'='<value>' }
        Get policyhttpcallout data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPolicyhttpcallout
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyhttpcallout/
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
        Write-Verbose "Invoke-ADCGetPolicyhttpcallout: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policyhttpcallout objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyhttpcallout -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policyhttpcallout objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyhttpcallout -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policyhttpcallout objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyhttpcallout -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policyhttpcallout configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyhttpcallout -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policyhttpcallout configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyhttpcallout -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Policy configuration Object.
    .DESCRIPTION
        Configuration for map policy resource.
    .PARAMETER Mappolicyname 
        Name for the map policy. Must begin with a letter, number, or the underscore (_) character and must consist only of letters, numbers, and the hash (#), period (.), colon (:), space ( ), at (@), equals (=), hyphen (-), and underscore (_) characters. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my map" or 'my map'). 
    .PARAMETER Sd 
        Publicly known source domain name. This is the domain name with which a client request arrives at a reverse proxy virtual server for cache redirection. If you specify a source domain, you must specify a target domain. 
    .PARAMETER Su 
        Source URL. Specify all or part of the source URL, in the following format: /[[prefix] [*]] [.suffix]. 
    .PARAMETER Td 
        Target domain name sent to the server. The source domain name is replaced with this domain name. 
    .PARAMETER Tu 
        Target URL. Specify the target URL in the following format: /[[prefix] [*]][.suffix]. 
    .PARAMETER PassThru 
        Return details about the created policymap item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddPolicymap -mappolicyname <string> -sd <string>
        An example how to add policymap configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddPolicymap
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policymap/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Mappolicyname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sd,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Su,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Td,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Tu,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicymap: Starting"
    }
    process {
        try {
            $payload = @{ mappolicyname = $mappolicyname
                sd                      = $sd
            }
            if ( $PSBoundParameters.ContainsKey('su') ) { $payload.Add('su', $su) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('tu') ) { $payload.Add('tu', $tu) }
            if ( $PSCmdlet.ShouldProcess("policymap", "Add Policy configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policymap -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetPolicymap -Filter $payload)
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
        Delete Policy configuration Object.
    .DESCRIPTION
        Configuration for map policy resource.
    .PARAMETER Mappolicyname 
        Name for the map policy. Must begin with a letter, number, or the underscore (_) character and must consist only of letters, numbers, and the hash (#), period (.), colon (:), space ( ), at (@), equals (=), hyphen (-), and underscore (_) characters. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my map" or 'my map').
    .EXAMPLE
        PS C:\>Invoke-ADCDeletePolicymap -Mappolicyname <string>
        An example how to delete policymap configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeletePolicymap
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policymap/
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
        [string]$Mappolicyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeletePolicymap: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$mappolicyname", "Delete Policy configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policymap -NitroPath nitro/v1/config -Resource $mappolicyname -Arguments $arguments
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
        Get Policy configuration object(s).
    .DESCRIPTION
        Configuration for map policy resource.
    .PARAMETER Mappolicyname 
        Name for the map policy. Must begin with a letter, number, or the underscore (_) character and must consist only of letters, numbers, and the hash (#), period (.), colon (:), space ( ), at (@), equals (=), hyphen (-), and underscore (_) characters. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my map" or 'my map'). 
    .PARAMETER GetAll 
        Retrieve all policymap object(s).
    .PARAMETER Count
        If specified, the count of the policymap object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicymap
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicymap -GetAll 
        Get all policymap data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicymap -Count 
        Get the number of policymap objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicymap -name <string>
        Get policymap object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicymap -Filter @{ 'name'='<value>' }
        Get policymap data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPolicymap
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policymap/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Mappolicyname,

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
        Write-Verbose "Invoke-ADCGetPolicymap: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policymap objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policymap -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policymap objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policymap -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policymap objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policymap -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policymap configuration for property 'mappolicyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policymap -NitroPath nitro/v1/config -Resource $mappolicyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policymap configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policymap -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Update Policy configuration Object.
    .DESCRIPTION
        Configuration for policy parameter resource.
    .PARAMETER Timeout 
        Maximum time in milliseconds to allow for processing expressions without interruption. If the timeout is reached then the evaluation causes an UNDEF to be raised and no further processing is performed.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdatePolicyparam 
        An example how to update policyparam configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdatePolicyparam
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyparam/
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

        [ValidateRange(1, 5000)]
        [double]$Timeout 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdatePolicyparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSCmdlet.ShouldProcess("policyparam", "Update Policy configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type policyparam -Payload $payload -GetWarning
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
        Unset Policy configuration Object.
    .DESCRIPTION
        Configuration for policy parameter resource.
    .PARAMETER Timeout 
        Maximum time in milliseconds to allow for processing expressions without interruption. If the timeout is reached then the evaluation causes an UNDEF to be raised and no further processing is performed.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetPolicyparam 
        An example how to unset policyparam configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetPolicyparam
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyparam
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

        [Boolean]$timeout 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetPolicyparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSCmdlet.ShouldProcess("policyparam", "Unset Policy configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type policyparam -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get Policy configuration object(s).
    .DESCRIPTION
        Configuration for policy parameter resource.
    .PARAMETER GetAll 
        Retrieve all policyparam object(s).
    .PARAMETER Count
        If specified, the count of the policyparam object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicyparam
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicyparam -GetAll 
        Get all policyparam data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicyparam -name <string>
        Get policyparam object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicyparam -Filter @{ 'name'='<value>' }
        Get policyparam data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPolicyparam
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyparam/
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
        Write-Verbose "Invoke-ADCGetPolicyparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policyparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policyparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policyparam objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyparam -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policyparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving policyparam configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Policy configuration Object.
    .DESCRIPTION
        Configuration for PAT set resource.
    .PARAMETER Name 
        Unique name of the pattern set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER Comment 
        Any comments to preserve information about this patset or a pattern bound to this patset. 
    .PARAMETER Patsetfile 
        File which contains list of patterns that needs to be bound to the patset. A patsetfile cannot be associated with multiple patsets. 
    .PARAMETER PassThru 
        Return details about the created policypatset item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddPolicypatset -name <string>
        An example how to add policypatset configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddPolicypatset
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policypatset/
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

        [string]$Comment,

        [string]$Patsetfile,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicypatset: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('patsetfile') ) { $payload.Add('patsetfile', $patsetfile) }
            if ( $PSCmdlet.ShouldProcess("policypatset", "Add Policy configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policypatset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetPolicypatset -Filter $payload)
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
        Delete Policy configuration Object.
    .DESCRIPTION
        Configuration for PAT set resource.
    .PARAMETER Name 
        Unique name of the pattern set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout.
    .EXAMPLE
        PS C:\>Invoke-ADCDeletePolicypatset -Name <string>
        An example how to delete policypatset configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeletePolicypatset
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policypatset/
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
        Write-Verbose "Invoke-ADCDeletePolicypatset: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policypatset -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Policy configuration object(s).
    .DESCRIPTION
        Configuration for PAT set resource.
    .PARAMETER Name 
        Unique name of the pattern set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER GetAll 
        Retrieve all policypatset object(s).
    .PARAMETER Count
        If specified, the count of the policypatset object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicypatset
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicypatset -GetAll 
        Get all policypatset data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicypatset -Count 
        Get the number of policypatset objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicypatset -name <string>
        Get policypatset object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicypatset -Filter @{ 'name'='<value>' }
        Get policypatset data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPolicypatset
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policypatset/
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
        Write-Verbose "Invoke-ADCGetPolicypatset: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policypatset objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policypatset objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policypatset objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policypatset configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policypatset configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Policy configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to policypatset.
    .PARAMETER Name 
        Name of the pattern set for which to display the detailed information. If a name is not provided, a list of all pattern sets configured on the appliance is shown. 
    .PARAMETER GetAll 
        Retrieve all policypatset_binding object(s).
    .PARAMETER Count
        If specified, the count of the policypatset_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicypatsetbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicypatsetbinding -GetAll 
        Get all policypatset_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicypatsetbinding -name <string>
        Get policypatset_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicypatsetbinding -Filter @{ 'name'='<value>' }
        Get policypatset_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPolicypatsetbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policypatset_binding/
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
        Write-Verbose "Invoke-ADCGetPolicypatsetbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all policypatset_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policypatset_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policypatset_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policypatset_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policypatset_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Policy configuration Object.
    .DESCRIPTION
        Binding object showing the pattern that can be bound to policypatset.
    .PARAMETER Name 
        Name of the pattern set to which to bind the string. 
    .PARAMETER String 
        String of characters that constitutes a pattern. For more information about the characters that can be used, refer to the character set parameter. Note: Minimum length for pattern sets used in rewrite actions of type REPLACE_ALL, DELETE_ALL, INSERT_AFTER_ALL, and INSERT_BEFORE_ALL, is three characters. 
    .PARAMETER Index 
        The index of the string associated with the patset. 
    .PARAMETER Charset 
        Character set associated with the characters in the string. Note: UTF-8 characters can be entered directly (if the UI supports it) or can be encoded as a sequence of hexadecimal bytes '\xNN'. For example, the UTF-8 character 'ü' can be encoded as '\xC3\xBC'. 
        Possible values = ASCII, UTF_8 
    .PARAMETER Comment 
        Any comments to preserve information about this patset or a pattern bound to this patset. 
    .PARAMETER PassThru 
        Return details about the created policypatset_pattern_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddPolicypatsetpatternbinding -name <string> -String <string>
        An example how to add policypatset_pattern_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddPolicypatsetpatternbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policypatset_pattern_binding/
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
        [string]$String,

        [double]$Index,

        [ValidateSet('ASCII', 'UTF_8')]
        [string]$Charset,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicypatsetpatternbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                String         = $String
            }
            if ( $PSBoundParameters.ContainsKey('index') ) { $payload.Add('index', $index) }
            if ( $PSBoundParameters.ContainsKey('charset') ) { $payload.Add('charset', $charset) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("policypatset_pattern_binding", "Add Policy configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type policypatset_pattern_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetPolicypatsetpatternbinding -Filter $payload)
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
        Delete Policy configuration Object.
    .DESCRIPTION
        Binding object showing the pattern that can be bound to policypatset.
    .PARAMETER Name 
        Name of the pattern set to which to bind the string. 
    .PARAMETER String 
        String of characters that constitutes a pattern. For more information about the characters that can be used, refer to the character set parameter. Note: Minimum length for pattern sets used in rewrite actions of type REPLACE_ALL, DELETE_ALL, INSERT_AFTER_ALL, and INSERT_BEFORE_ALL, is three characters.
    .EXAMPLE
        PS C:\>Invoke-ADCDeletePolicypatsetpatternbinding -Name <string>
        An example how to delete policypatset_pattern_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeletePolicypatsetpatternbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policypatset_pattern_binding/
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

        [string]$String 
    )
    begin {
        Write-Verbose "Invoke-ADCDeletePolicypatsetpatternbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('String') ) { $arguments.Add('String', $String) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policypatset_pattern_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Policy configuration object(s).
    .DESCRIPTION
        Binding object showing the pattern that can be bound to policypatset.
    .PARAMETER Name 
        Name of the pattern set to which to bind the string. 
    .PARAMETER GetAll 
        Retrieve all policypatset_pattern_binding object(s).
    .PARAMETER Count
        If specified, the count of the policypatset_pattern_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicypatsetpatternbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicypatsetpatternbinding -GetAll 
        Get all policypatset_pattern_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicypatsetpatternbinding -Count 
        Get the number of policypatset_pattern_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicypatsetpatternbinding -name <string>
        Get policypatset_pattern_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicypatsetpatternbinding -Filter @{ 'name'='<value>' }
        Get policypatset_pattern_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPolicypatsetpatternbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policypatset_pattern_binding/
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
        Write-Verbose "Invoke-ADCGetPolicypatsetpatternbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all policypatset_pattern_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_pattern_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policypatset_pattern_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_pattern_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policypatset_pattern_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_pattern_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policypatset_pattern_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_pattern_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policypatset_pattern_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policypatset_pattern_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Policy configuration Object.
    .DESCRIPTION
        Configuration for string map resource.
    .PARAMETER Name 
        Unique name for the string map. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER Comment 
        Comments associated with the string map or key-value pair bound to this string map. 
    .PARAMETER PassThru 
        Return details about the created policystringmap item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddPolicystringmap -name <string>
        An example how to add policystringmap configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddPolicystringmap
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policystringmap/
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

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicystringmap: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("policystringmap", "Add Policy configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policystringmap -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetPolicystringmap -Filter $payload)
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
        Delete Policy configuration Object.
    .DESCRIPTION
        Configuration for string map resource.
    .PARAMETER Name 
        Unique name for the string map. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout.
    .EXAMPLE
        PS C:\>Invoke-ADCDeletePolicystringmap -Name <string>
        An example how to delete policystringmap configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeletePolicystringmap
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policystringmap/
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
        Write-Verbose "Invoke-ADCDeletePolicystringmap: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policystringmap -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update Policy configuration Object.
    .DESCRIPTION
        Configuration for string map resource.
    .PARAMETER Name 
        Unique name for the string map. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER Comment 
        Comments associated with the string map or key-value pair bound to this string map. 
    .PARAMETER PassThru 
        Return details about the created policystringmap item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdatePolicystringmap -name <string>
        An example how to update policystringmap configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdatePolicystringmap
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policystringmap/
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

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdatePolicystringmap: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("policystringmap", "Update Policy configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type policystringmap -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetPolicystringmap -Filter $payload)
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
        Unset Policy configuration Object.
    .DESCRIPTION
        Configuration for string map resource.
    .PARAMETER Name 
        Unique name for the string map. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER Comment 
        Comments associated with the string map or key-value pair bound to this string map.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetPolicystringmap -name <string>
        An example how to unset policystringmap configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetPolicystringmap
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policystringmap
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

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetPolicystringmap: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Policy configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type policystringmap -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get Policy configuration object(s).
    .DESCRIPTION
        Configuration for string map resource.
    .PARAMETER Name 
        Unique name for the string map. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER GetAll 
        Retrieve all policystringmap object(s).
    .PARAMETER Count
        If specified, the count of the policystringmap object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicystringmap
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicystringmap -GetAll 
        Get all policystringmap data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicystringmap -Count 
        Get the number of policystringmap objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicystringmap -name <string>
        Get policystringmap object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicystringmap -Filter @{ 'name'='<value>' }
        Get policystringmap data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPolicystringmap
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policystringmap/
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
        Write-Verbose "Invoke-ADCGetPolicystringmap: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policystringmap objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policystringmap objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policystringmap objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policystringmap configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policystringmap configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Policy configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to policystringmap.
    .PARAMETER Name 
        Name of the string map to display. If a name is not provided, a list of all the configured string maps is shown. 
    .PARAMETER GetAll 
        Retrieve all policystringmap_binding object(s).
    .PARAMETER Count
        If specified, the count of the policystringmap_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicystringmapbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicystringmapbinding -GetAll 
        Get all policystringmap_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicystringmapbinding -name <string>
        Get policystringmap_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicystringmapbinding -Filter @{ 'name'='<value>' }
        Get policystringmap_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPolicystringmapbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policystringmap_binding/
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
        Write-Verbose "Invoke-ADCGetPolicystringmapbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all policystringmap_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policystringmap_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policystringmap_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policystringmap_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policystringmap_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Policy configuration Object.
    .DESCRIPTION
        Binding object showing the pattern that can be bound to policystringmap.
    .PARAMETER Name 
        Name of the string map to which to bind the key-value pair. 
    .PARAMETER Key 
        Character string constituting the key to be bound to the string map. The key is matched against the data processed by the operation that uses the string map. The default character set is ASCII. UTF-8 characters can be included if the character set is UTF-8. UTF-8 characters can be entered directly (if the UI supports it) or can be encoded as a sequence of hexadecimal bytes '\xNN'. For example, the UTF-8 character 'ü' can be encoded as '\xC3\xBC'. 
    .PARAMETER Value 
        Character string constituting the value associated with the key. This value is returned when processed data matches the associated key. Refer to the key parameter for details of the value character set. 
    .PARAMETER Comment 
        Comments associated with the string map or key-value pair bound to this string map. 
    .PARAMETER PassThru 
        Return details about the created policystringmap_pattern_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddPolicystringmappatternbinding -name <string> -key <string> -value <string>
        An example how to add policystringmap_pattern_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddPolicystringmappatternbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policystringmap_pattern_binding/
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
        [string]$Key,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Value,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicystringmappatternbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                key            = $key
                value          = $value
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("policystringmap_pattern_binding", "Add Policy configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type policystringmap_pattern_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetPolicystringmappatternbinding -Filter $payload)
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
        Delete Policy configuration Object.
    .DESCRIPTION
        Binding object showing the pattern that can be bound to policystringmap.
    .PARAMETER Name 
        Name of the string map to which to bind the key-value pair. 
    .PARAMETER Key 
        Character string constituting the key to be bound to the string map. The key is matched against the data processed by the operation that uses the string map. The default character set is ASCII. UTF-8 characters can be included if the character set is UTF-8. UTF-8 characters can be entered directly (if the UI supports it) or can be encoded as a sequence of hexadecimal bytes '\xNN'. For example, the UTF-8 character 'ü' can be encoded as '\xC3\xBC'.
    .EXAMPLE
        PS C:\>Invoke-ADCDeletePolicystringmappatternbinding -Name <string>
        An example how to delete policystringmap_pattern_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeletePolicystringmappatternbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policystringmap_pattern_binding/
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

        [string]$Key 
    )
    begin {
        Write-Verbose "Invoke-ADCDeletePolicystringmappatternbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Key') ) { $arguments.Add('key', $Key) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policystringmap_pattern_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Policy configuration object(s).
    .DESCRIPTION
        Binding object showing the pattern that can be bound to policystringmap.
    .PARAMETER Name 
        Name of the string map to which to bind the key-value pair. 
    .PARAMETER GetAll 
        Retrieve all policystringmap_pattern_binding object(s).
    .PARAMETER Count
        If specified, the count of the policystringmap_pattern_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicystringmappatternbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicystringmappatternbinding -GetAll 
        Get all policystringmap_pattern_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicystringmappatternbinding -Count 
        Get the number of policystringmap_pattern_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicystringmappatternbinding -name <string>
        Get policystringmap_pattern_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicystringmappatternbinding -Filter @{ 'name'='<value>' }
        Get policystringmap_pattern_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPolicystringmappatternbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policystringmap_pattern_binding/
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
        Write-Verbose "Invoke-ADCGetPolicystringmappatternbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all policystringmap_pattern_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_pattern_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policystringmap_pattern_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_pattern_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policystringmap_pattern_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_pattern_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policystringmap_pattern_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_pattern_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policystringmap_pattern_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policystringmap_pattern_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Policy configuration Object.
    .DESCRIPTION
        Configuration for URL set resource.
    .PARAMETER Name 
        Unique name of the url set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER Comment 
        Any comments to preserve information about this url set. 
    .PARAMETER PassThru 
        Return details about the created policyurlset item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddPolicyurlset -name <string>
        An example how to add policyurlset configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddPolicyurlset
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyurlset/
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
        [ValidateLength(1, 127)]
        [string]$Name,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddPolicyurlset: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("policyurlset", "Add Policy configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policyurlset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetPolicyurlset -Filter $payload)
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
        Delete Policy configuration Object.
    .DESCRIPTION
        Configuration for URL set resource.
    .PARAMETER Name 
        Unique name of the url set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout.
    .EXAMPLE
        PS C:\>Invoke-ADCDeletePolicyurlset -Name <string>
        An example how to delete policyurlset configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeletePolicyurlset
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyurlset/
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
        Write-Verbose "Invoke-ADCDeletePolicyurlset: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Policy configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type policyurlset -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Import Policy configuration Object.
    .DESCRIPTION
        Configuration for URL set resource.
    .PARAMETER Name 
        Unique name of the url set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER Overwrite 
        Overwrites the existing file. 
    .PARAMETER Delimiter 
        CSV file record delimiter. 
    .PARAMETER Rowseparator 
        CSV file row separator. 
    .PARAMETER Url 
        URL (protocol, host, path and file name) from where the CSV (comma separated file) file will be imported or exported. Each record/line will one entry within the urlset. The first field contains the URL pattern, subsequent fields contains the metadata, if available. HTTP, HTTPS and FTP protocols are supported. NOTE: The operation fails if the destination HTTPS server requires client certificate authentication for access. 
    .PARAMETER Interval 
        The interval, in seconds, rounded down to the nearest 15 minutes, at which the update of urlset occurs. 
    .PARAMETER Privateset 
        Prevent this urlset from being exported. 
    .PARAMETER Subdomainexactmatch 
        Force exact subdomain matching, ex. given an entry 'google.com' in the urlset, a request to 'news.google.com' won't match, if subdomainExactMatch is set. 
    .PARAMETER Matchedid 
        An ID that would be sent to AppFlow to indicate which URLSet was the last one that matched the requested URL. 
    .PARAMETER Canaryurl 
        Add this URL to this urlset. Used for testing when contents of urlset is kept confidential.
    .EXAMPLE
        PS C:\>Invoke-ADCImportPolicyurlset -name <string> -url <string>
        An example how to import policyurlset configuration Object(s).
    .NOTES
        File Name : Invoke-ADCImportPolicyurlset
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyurlset/
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
        [ValidateLength(1, 127)]
        [string]$Name,

        [boolean]$Overwrite,

        [string]$Delimiter,

        [string]$Rowseparator,

        [Parameter(Mandatory)]
        [ValidateLength(1, 2047)]
        [string]$Url,

        [ValidateRange(0, 2592000)]
        [double]$Interval,

        [boolean]$Privateset,

        [boolean]$Subdomainexactmatch,

        [ValidateRange(2, 31)]
        [double]$Matchedid,

        [ValidateLength(1, 2047)]
        [string]$Canaryurl 

    )
    begin {
        Write-Verbose "Invoke-ADCImportPolicyurlset: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                url            = $url
            }
            if ( $PSBoundParameters.ContainsKey('overwrite') ) { $payload.Add('overwrite', $overwrite) }
            if ( $PSBoundParameters.ContainsKey('delimiter') ) { $payload.Add('delimiter', $delimiter) }
            if ( $PSBoundParameters.ContainsKey('rowseparator') ) { $payload.Add('rowseparator', $rowseparator) }
            if ( $PSBoundParameters.ContainsKey('interval') ) { $payload.Add('interval', $interval) }
            if ( $PSBoundParameters.ContainsKey('privateset') ) { $payload.Add('privateset', $privateset) }
            if ( $PSBoundParameters.ContainsKey('subdomainexactmatch') ) { $payload.Add('subdomainexactmatch', $subdomainexactmatch) }
            if ( $PSBoundParameters.ContainsKey('matchedid') ) { $payload.Add('matchedid', $matchedid) }
            if ( $PSBoundParameters.ContainsKey('canaryurl') ) { $payload.Add('canaryurl', $canaryurl) }
            if ( $PSCmdlet.ShouldProcess($Name, "Import Policy configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policyurlset -Action import -Payload $payload -GetWarning
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
        Change Policy configuration Object.
    .DESCRIPTION
        Configuration for URL set resource.
    .PARAMETER Name 
        Unique name of the url set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER PassThru 
        Return details about the created policyurlset item.
    .EXAMPLE
        PS C:\>Invoke-ADCChangePolicyurlset -name <string>
        An example how to change policyurlset configuration Object(s).
    .NOTES
        File Name : Invoke-ADCChangePolicyurlset
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyurlset/
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
        [ValidateLength(1, 127)]
        [string]$Name,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCChangePolicyurlset: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess("policyurlset", "Change Policy configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policyurlset -Action update -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetPolicyurlset -Filter $payload)
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
        Export Policy configuration Object.
    .DESCRIPTION
        Configuration for URL set resource.
    .PARAMETER Name 
        Unique name of the url set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER Url 
        URL (protocol, host, path and file name) from where the CSV (comma separated file) file will be imported or exported. Each record/line will one entry within the urlset. The first field contains the URL pattern, subsequent fields contains the metadata, if available. HTTP, HTTPS and FTP protocols are supported. NOTE: The operation fails if the destination HTTPS server requires client certificate authentication for access.
    .EXAMPLE
        PS C:\>Invoke-ADCExportPolicyurlset -name <string> -url <string>
        An example how to export policyurlset configuration Object(s).
    .NOTES
        File Name : Invoke-ADCExportPolicyurlset
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyurlset/
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
        [ValidateLength(1, 127)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateLength(1, 2047)]
        [string]$Url 

    )
    begin {
        Write-Verbose "Invoke-ADCExportPolicyurlset: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                url            = $url
            }

            if ( $PSCmdlet.ShouldProcess($Name, "Export Policy configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type policyurlset -Action export -Payload $payload -GetWarning
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
        Get Policy configuration object(s).
    .DESCRIPTION
        Configuration for URL set resource.
    .PARAMETER Name 
        Unique name of the url set. Not case sensitive. Must begin with an ASCII letter or underscore (_) character and must contain only alphanumeric and underscore characters. Must not be the name of an existing named expression, pattern set, dataset, string map, or HTTP callout. 
    .PARAMETER GetAll 
        Retrieve all policyurlset object(s).
    .PARAMETER Count
        If specified, the count of the policyurlset object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicyurlset
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicyurlset -GetAll 
        Get all policyurlset data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPolicyurlset -Count 
        Get the number of policyurlset objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicyurlset -name <string>
        Get policyurlset object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPolicyurlset -Filter @{ 'name'='<value>' }
        Get policyurlset data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPolicyurlset
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/policy/policyurlset/
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
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-ADCGetPolicyurlset: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all policyurlset objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyurlset -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for policyurlset objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyurlset -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving policyurlset objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyurlset -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving policyurlset configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyurlset -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving policyurlset configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type policyurlset -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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


