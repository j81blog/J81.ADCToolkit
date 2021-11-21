function Invoke-ADCAddXmdeployment {
    <#
    .SYNOPSIS
        Add Xm configuration Object.
    .DESCRIPTION
        Configuration for XenMobile Deployment resource.
    .PARAMETER Name 
        XenMobile deployment name. 
    .PARAMETER Frompackage 
        XenMobile package name. 
    .PARAMETER Config 
        XenMobile deployment config data. 
    .PARAMETER PassThru 
        Return details about the created xmdeployment item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddXmdeployment -name <string> -frompackage <string> -config <string>
        An example how to add xmdeployment configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddXmdeployment
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/xm/xmdeployment.md/
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
        [ValidateLength(1, 255)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateLength(1, 255)]
        [string]$Frompackage,

        [Parameter(Mandatory)]
        [ValidateLength(1, 4095)]
        [string]$Config,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddXmdeployment: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                frompackage    = $frompackage
                config         = $config
            }

            if ( $PSCmdlet.ShouldProcess("xmdeployment", "Add Xm configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type xmdeployment -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetXmdeployment -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddXmdeployment: Finished"
    }
}

function Invoke-ADCDeleteXmdeployment {
    <#
    .SYNOPSIS
        Delete Xm configuration Object.
    .DESCRIPTION
        Configuration for XenMobile Deployment resource.
    .PARAMETER Name 
        XenMobile deployment name.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteXmdeployment -Name <string>
        An example how to delete xmdeployment configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteXmdeployment
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/xm/xmdeployment.md/
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
        Write-Verbose "Invoke-ADCDeleteXmdeployment: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Xm configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type xmdeployment -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteXmdeployment: Finished"
    }
}

function Invoke-ADCGetXmdeployment {
    <#
    .SYNOPSIS
        Get Xm configuration object(s).
    .DESCRIPTION
        Configuration for XenMobile Deployment resource.
    .PARAMETER Name 
        XenMobile deployment name. 
    .PARAMETER GetAll 
        Retrieve all xmdeployment object(s).
    .PARAMETER Count
        If specified, the count of the xmdeployment object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetXmdeployment
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetXmdeployment -GetAll 
        Get all xmdeployment data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetXmdeployment -Count 
        Get the number of xmdeployment objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetXmdeployment -name <string>
        Get xmdeployment object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetXmdeployment -Filter @{ 'name'='<value>' }
        Get xmdeployment data with a filter.
    .NOTES
        File Name : Invoke-ADCGetXmdeployment
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/xm/xmdeployment.md/
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
        [ValidateLength(1, 255)]
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
        Write-Verbose "Invoke-ADCGetXmdeployment: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all xmdeployment objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmdeployment -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for xmdeployment objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmdeployment -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving xmdeployment objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmdeployment -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving xmdeployment configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmdeployment -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving xmdeployment configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmdeployment -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetXmdeployment: Ended"
    }
}

function Invoke-ADCAddXmpackage {
    <#
    .SYNOPSIS
        Add Xm configuration Object.
    .DESCRIPTION
        Configuration for XenMobile Deployment Package resource.
    .PARAMETER Name 
        XenMobile package name. 
    .PARAMETER Packagefile 
        Path to the upload XenMobile package file. 
    .PARAMETER PassThru 
        Return details about the created xmpackage item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddXmpackage -name <string> -packagefile <string>
        An example how to add xmpackage configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddXmpackage
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/xm/xmpackage.md/
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
        [ValidateLength(1, 255)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateLength(1, 255)]
        [string]$Packagefile,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddXmpackage: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                packagefile    = $packagefile
            }

            if ( $PSCmdlet.ShouldProcess("xmpackage", "Add Xm configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type xmpackage -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetXmpackage -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddXmpackage: Finished"
    }
}

function Invoke-ADCDeleteXmpackage {
    <#
    .SYNOPSIS
        Delete Xm configuration Object.
    .DESCRIPTION
        Configuration for XenMobile Deployment Package resource.
    .PARAMETER Name 
        XenMobile package name.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteXmpackage -Name <string>
        An example how to delete xmpackage configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteXmpackage
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/xm/xmpackage.md/
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
        Write-Verbose "Invoke-ADCDeleteXmpackage: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Xm configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type xmpackage -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteXmpackage: Finished"
    }
}

function Invoke-ADCGetXmpackage {
    <#
    .SYNOPSIS
        Get Xm configuration object(s).
    .DESCRIPTION
        Configuration for XenMobile Deployment Package resource.
    .PARAMETER Name 
        XenMobile package name. 
    .PARAMETER GetAll 
        Retrieve all xmpackage object(s).
    .PARAMETER Count
        If specified, the count of the xmpackage object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetXmpackage
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetXmpackage -GetAll 
        Get all xmpackage data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetXmpackage -Count 
        Get the number of xmpackage objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetXmpackage -name <string>
        Get xmpackage object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetXmpackage -Filter @{ 'name'='<value>' }
        Get xmpackage data with a filter.
    .NOTES
        File Name : Invoke-ADCGetXmpackage
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/xm/xmpackage.md/
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
        [ValidateLength(1, 255)]
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
        Write-Verbose "Invoke-ADCGetXmpackage: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all xmpackage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmpackage -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for xmpackage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmpackage -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving xmpackage objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmpackage -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving xmpackage configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmpackage -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving xmpackage configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmpackage -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetXmpackage: Ended"
    }
}


