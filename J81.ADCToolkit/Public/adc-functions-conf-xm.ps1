function Invoke-ADCAddXmdeployment {
<#
    .SYNOPSIS
        Add Xm configuration Object
    .DESCRIPTION
        Add Xm configuration Object 
    .PARAMETER name 
        XenMobile deployment name.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER frompackage 
        XenMobile package name.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER config 
        XenMobile deployment config data.  
        Minimum length = 1  
        Maximum length = 4095 
    .PARAMETER PassThru 
        Return details about the created xmdeployment item.
    .EXAMPLE
        Invoke-ADCAddXmdeployment -name <string> -frompackage <string> -config <string>
    .NOTES
        File Name : Invoke-ADCAddXmdeployment
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/xm/xmdeployment/
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
        [ValidateLength(1, 255)]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 255)]
        [string]$frompackage ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 4095)]
        [string]$config ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddXmdeployment: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                frompackage = $frompackage
                config = $config
            }

 
            if ($PSCmdlet.ShouldProcess("xmdeployment", "Add Xm configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type xmdeployment -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetXmdeployment -Filter $Payload)
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
        Delete Xm configuration Object
    .DESCRIPTION
        Delete Xm configuration Object
    .PARAMETER name 
       XenMobile deployment name.  
       Minimum length = 1  
       Maximum length = 255 
    .EXAMPLE
        Invoke-ADCDeleteXmdeployment -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteXmdeployment
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/xm/xmdeployment/
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
        Write-Verbose "Invoke-ADCDeleteXmdeployment: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Xm configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type xmdeployment -Resource $name -Arguments $Arguments
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
        Get Xm configuration object(s)
    .DESCRIPTION
        Get Xm configuration object(s)
    .PARAMETER name 
       XenMobile deployment name. 
    .PARAMETER GetAll 
        Retreive all xmdeployment object(s)
    .PARAMETER Count
        If specified, the count of the xmdeployment object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetXmdeployment
    .EXAMPLE 
        Invoke-ADCGetXmdeployment -GetAll 
    .EXAMPLE 
        Invoke-ADCGetXmdeployment -Count
    .EXAMPLE
        Invoke-ADCGetXmdeployment -name <string>
    .EXAMPLE
        Invoke-ADCGetXmdeployment -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetXmdeployment
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/xm/xmdeployment/
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
        [ValidateLength(1, 255)]
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
        Write-Verbose "Invoke-ADCGetXmdeployment: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all xmdeployment objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmdeployment -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for xmdeployment objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmdeployment -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving xmdeployment objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmdeployment -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving xmdeployment configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmdeployment -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving xmdeployment configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmdeployment -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Xm configuration Object
    .DESCRIPTION
        Add Xm configuration Object 
    .PARAMETER name 
        XenMobile package name.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER packagefile 
        Path to the upload XenMobile package file.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER PassThru 
        Return details about the created xmpackage item.
    .EXAMPLE
        Invoke-ADCAddXmpackage -name <string> -packagefile <string>
    .NOTES
        File Name : Invoke-ADCAddXmpackage
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/xm/xmpackage/
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
        [ValidateLength(1, 255)]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 255)]
        [string]$packagefile ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddXmpackage: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                packagefile = $packagefile
            }

 
            if ($PSCmdlet.ShouldProcess("xmpackage", "Add Xm configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type xmpackage -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetXmpackage -Filter $Payload)
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
        Delete Xm configuration Object
    .DESCRIPTION
        Delete Xm configuration Object
    .PARAMETER name 
       XenMobile package name.  
       Minimum length = 1  
       Maximum length = 255 
    .EXAMPLE
        Invoke-ADCDeleteXmpackage -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteXmpackage
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/xm/xmpackage/
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
        Write-Verbose "Invoke-ADCDeleteXmpackage: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Xm configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type xmpackage -Resource $name -Arguments $Arguments
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
        Get Xm configuration object(s)
    .DESCRIPTION
        Get Xm configuration object(s)
    .PARAMETER name 
       XenMobile package name. 
    .PARAMETER GetAll 
        Retreive all xmpackage object(s)
    .PARAMETER Count
        If specified, the count of the xmpackage object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetXmpackage
    .EXAMPLE 
        Invoke-ADCGetXmpackage -GetAll 
    .EXAMPLE 
        Invoke-ADCGetXmpackage -Count
    .EXAMPLE
        Invoke-ADCGetXmpackage -name <string>
    .EXAMPLE
        Invoke-ADCGetXmpackage -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetXmpackage
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/xm/xmpackage/
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
        [ValidateLength(1, 255)]
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
        Write-Verbose "Invoke-ADCGetXmpackage: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all xmpackage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmpackage -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for xmpackage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmpackage -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving xmpackage objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmpackage -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving xmpackage configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmpackage -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving xmpackage configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type xmpackage -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


