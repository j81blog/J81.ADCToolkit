function Invoke-ADCGetCloudautoscalegroup {
    <#
    .SYNOPSIS
        Get Cloud configuration object(s).
    .DESCRIPTION
        Configuration for Cloud autoscalegroup resource.
    .PARAMETER Name 
        . 
    .PARAMETER GetAll 
        Retrieve all cloudautoscalegroup object(s).
    .PARAMETER Count
        If specified, the count of the cloudautoscalegroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCloudautoscalegroup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCloudautoscalegroup -GetAll 
        Get all cloudautoscalegroup data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCloudautoscalegroup -Count 
        Get the number of cloudautoscalegroup objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCloudautoscalegroup -name <string>
        Get cloudautoscalegroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCloudautoscalegroup -Filter @{ 'name'='<value>' }
        Get cloudautoscalegroup data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCloudautoscalegroup
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudautoscalegroup/
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
        Write-Verbose "Invoke-ADCGetCloudautoscalegroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cloudautoscalegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudautoscalegroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudautoscalegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudautoscalegroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudautoscalegroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudautoscalegroup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudautoscalegroup configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudautoscalegroup -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cloudautoscalegroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudautoscalegroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCloudautoscalegroup: Ended"
    }
}

function Invoke-ADCUpdateCloudcredential {
    <#
    .SYNOPSIS
        Update Cloud configuration Object.
    .DESCRIPTION
        Configuration for cloud credentials resource.
    .PARAMETER Tenantidentifier 
        Tenant ID of the Credentials. 
    .PARAMETER Applicationid 
        Application ID of the Credentials. 
    .PARAMETER Applicationsecret 
        Application Secret of the Credentials.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateCloudcredential -tenantidentifier <string> -applicationid <string> -applicationsecret <string>
        An example how to update cloudcredential configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateCloudcredential
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudcredential/
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
        [string]$Tenantidentifier,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Applicationid,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Applicationsecret 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCloudcredential: Starting"
    }
    process {
        try {
            $payload = @{ tenantidentifier = $tenantidentifier
                applicationid              = $applicationid
                applicationsecret          = $applicationsecret
            }

            if ( $PSCmdlet.ShouldProcess("cloudcredential", "Update Cloud configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type cloudcredential -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateCloudcredential: Finished"
    }
}

function Invoke-ADCGetCloudcredential {
    <#
    .SYNOPSIS
        Get Cloud configuration object(s).
    .DESCRIPTION
        Configuration for cloud credentials resource.
    .PARAMETER GetAll 
        Retrieve all cloudcredential object(s).
    .PARAMETER Count
        If specified, the count of the cloudcredential object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCloudcredential
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCloudcredential -GetAll 
        Get all cloudcredential data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCloudcredential -name <string>
        Get cloudcredential object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCloudcredential -Filter @{ 'name'='<value>' }
        Get cloudcredential data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCloudcredential
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudcredential/
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
        Write-Verbose "Invoke-ADCGetCloudcredential: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cloudcredential objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudcredential -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudcredential objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudcredential -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudcredential objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudcredential -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudcredential configuration for property ''"

            } else {
                Write-Verbose "Retrieving cloudcredential configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudcredential -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCloudcredential: Ended"
    }
}

function Invoke-ADCUpdateCloudparameter {
    <#
    .SYNOPSIS
        Update Cloud configuration Object.
    .DESCRIPTION
        Configuration for cloud parameter resource.
    .PARAMETER Controllerfqdn 
        FQDN of the controller to which the Citrix ADC SDProxy Connects. 
    .PARAMETER Controllerport 
        Port number of the controller to which the Citrix ADC SDProxy connects. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Instanceid 
        Instance ID of the customer provided by Trust. 
    .PARAMETER Customerid 
        Customer ID of the citrix cloud customer. 
    .PARAMETER Resourcelocation 
        Resource Location of the customer provided by Trust. 
    .PARAMETER Activationcode 
        Activation code for the NGS Connector instance. 
    .PARAMETER Deployment 
        Describes if the customer is a Staging/Production or Dev Citrix Cloud customer. 
        Possible values = Production, Staging, Dev 
    .PARAMETER Connectorresidence 
        Identifies whether the connector is located Onprem, Aws or Azure. 
        Possible values = None, Onprem, Aws, Azure, Cpx
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateCloudparameter 
        An example how to update cloudparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateCloudparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudparameter/
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
        [string]$Controllerfqdn,

        [ValidateRange(1, 65535)]
        [int]$Controllerport,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Instanceid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Customerid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Resourcelocation,

        [string]$Activationcode,

        [ValidateSet('Production', 'Staging', 'Dev')]
        [string]$Deployment,

        [ValidateSet('None', 'Onprem', 'Aws', 'Azure', 'Cpx')]
        [string]$Connectorresidence 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCloudparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('controllerfqdn') ) { $payload.Add('controllerfqdn', $controllerfqdn) }
            if ( $PSBoundParameters.ContainsKey('controllerport') ) { $payload.Add('controllerport', $controllerport) }
            if ( $PSBoundParameters.ContainsKey('instanceid') ) { $payload.Add('instanceid', $instanceid) }
            if ( $PSBoundParameters.ContainsKey('customerid') ) { $payload.Add('customerid', $customerid) }
            if ( $PSBoundParameters.ContainsKey('resourcelocation') ) { $payload.Add('resourcelocation', $resourcelocation) }
            if ( $PSBoundParameters.ContainsKey('activationcode') ) { $payload.Add('activationcode', $activationcode) }
            if ( $PSBoundParameters.ContainsKey('deployment') ) { $payload.Add('deployment', $deployment) }
            if ( $PSBoundParameters.ContainsKey('connectorresidence') ) { $payload.Add('connectorresidence', $connectorresidence) }
            if ( $PSCmdlet.ShouldProcess("cloudparameter", "Update Cloud configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type cloudparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateCloudparameter: Finished"
    }
}

function Invoke-ADCUnsetCloudparameter {
    <#
    .SYNOPSIS
        Unset Cloud configuration Object.
    .DESCRIPTION
        Configuration for cloud parameter resource.
    .PARAMETER Instanceid 
        Instance ID of the customer provided by Trust. 
    .PARAMETER Customerid 
        Customer ID of the citrix cloud customer. 
    .PARAMETER Resourcelocation 
        Resource Location of the customer provided by Trust.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetCloudparameter 
        An example how to unset cloudparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetCloudparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudparameter
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

        [Boolean]$instanceid,

        [Boolean]$customerid,

        [Boolean]$resourcelocation 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCloudparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('instanceid') ) { $payload.Add('instanceid', $instanceid) }
            if ( $PSBoundParameters.ContainsKey('customerid') ) { $payload.Add('customerid', $customerid) }
            if ( $PSBoundParameters.ContainsKey('resourcelocation') ) { $payload.Add('resourcelocation', $resourcelocation) }
            if ( $PSCmdlet.ShouldProcess("cloudparameter", "Unset Cloud configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type cloudparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetCloudparameter: Finished"
    }
}

function Invoke-ADCGetCloudparameter {
    <#
    .SYNOPSIS
        Get Cloud configuration object(s).
    .DESCRIPTION
        Configuration for cloud parameter resource.
    .PARAMETER GetAll 
        Retrieve all cloudparameter object(s).
    .PARAMETER Count
        If specified, the count of the cloudparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCloudparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCloudparameter -GetAll 
        Get all cloudparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCloudparameter -name <string>
        Get cloudparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCloudparameter -Filter @{ 'name'='<value>' }
        Get cloudparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCloudparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudparameter/
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
        Write-Verbose "Invoke-ADCGetCloudparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cloudparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving cloudparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCloudparameter: Ended"
    }
}

function Invoke-ADCUpdateCloudparaminternal {
    <#
    .SYNOPSIS
        Update Cloud configuration Object.
    .DESCRIPTION
        Configuration for cloud paramInternal resource.
    .PARAMETER Nonftumode 
        Indicates if GUI in in FTU mode or not. 
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateCloudparaminternal 
        An example how to update cloudparaminternal configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateCloudparaminternal
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudparaminternal/
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

        [ValidateSet('YES', 'NO')]
        [string]$Nonftumode 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCloudparaminternal: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('nonftumode') ) { $payload.Add('nonftumode', $nonftumode) }
            if ( $PSCmdlet.ShouldProcess("cloudparaminternal", "Update Cloud configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type cloudparaminternal -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateCloudparaminternal: Finished"
    }
}

function Invoke-ADCGetCloudparaminternal {
    <#
    .SYNOPSIS
        Get Cloud configuration object(s).
    .DESCRIPTION
        Configuration for cloud paramInternal resource.
    .PARAMETER GetAll 
        Retrieve all cloudparaminternal object(s).
    .PARAMETER Count
        If specified, the count of the cloudparaminternal object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCloudparaminternal
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCloudparaminternal -GetAll 
        Get all cloudparaminternal data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCloudparaminternal -Count 
        Get the number of cloudparaminternal objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCloudparaminternal -name <string>
        Get cloudparaminternal object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCloudparaminternal -Filter @{ 'name'='<value>' }
        Get cloudparaminternal data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCloudparaminternal
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudparaminternal/
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
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetCloudparaminternal: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cloudparaminternal objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudparaminternal -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudparaminternal objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudparaminternal -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudparaminternal objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudparaminternal -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudparaminternal configuration for property ''"

            } else {
                Write-Verbose "Retrieving cloudparaminternal configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudparaminternal -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCloudparaminternal: Ended"
    }
}

function Invoke-ADCAddCloudprofile {
    <#
    .SYNOPSIS
        Add Cloud configuration Object.
    .DESCRIPTION
        Configuration for cloud profile resource.
    .PARAMETER Name 
        Name for the Cloud profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the profile is created. 
    .PARAMETER Type 
        Type of cloud profile that you want to create, Vserver or based on Azure Tags. 
        Possible values = autoscale, azuretags 
    .PARAMETER Vservername 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Servicetype 
        Protocol used by the service (also called the service type). 
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, DTLS, NNTP, DNS, DHCPRA, ANY, SIP_UDP, SIP_TCP, SIP_SSL, DNS_TCP, RTSP, PUSH, SSL_PUSH, RADIUS, RDP, MYSQL, MSSQL, DIAMETER, SSL_DIAMETER, TFTP, ORACLE, SMPP, SYSLOGTCP, SYSLOGUDP, FIX, SSL_FIX, PROXY, USER_TCP, USER_SSL_TCP, QUIC, IPFIX, LOGSTREAM, MONGO, MONGO_TLS, MQTT, MQTT_TLS, QUIC_BRIDGE, HTTP_QUIC 
    .PARAMETER Ipaddress 
        IPv4 or IPv6 address to assign to the virtual server. 
    .PARAMETER Port 
        Port number for the virtual server. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Servicegroupname 
        servicegroups bind to this server. 
    .PARAMETER Boundservicegroupsvctype 
        The type of bound service. 
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, DTLS, NNTP, RPCSVR, DNS, ADNS, SNMP, RTSP, DHCPRA, ANY, SIP_UDP, SIP_TCP, SIP_SSL, DNS_TCP, ADNS_TCP, MYSQL, MSSQL, ORACLE, MONGO, MONGO_TLS, RADIUS, RADIUSListener, RDP, DIAMETER, SSL_DIAMETER, TFTP, SMPP, PPTP, GRE, SYSLOGTCP, SYSLOGUDP, FIX, SSL_FIX, USER_TCP, USER_SSL_TCP, QUIC, IPFIX, LOGSTREAM, LOGSTREAM_SSL, MQTT, MQTT_TLS, QUIC_BRIDGE 
    .PARAMETER Vsvrbindsvcport 
        The port number to be used for the bound service. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Graceful 
        Indicates graceful shutdown of the service. System will wait for all outstanding connections to this service to be closed before disabling the service. 
        Possible values = YES, NO 
    .PARAMETER Delay 
        Time, in seconds, after which all the services configured on the server are disabled. 
    .PARAMETER Azuretagname 
        Azure tag name. 
    .PARAMETER Azuretagvalue 
        Azure tag value. 
    .PARAMETER Azurepollperiod 
        Azure polling period (in seconds). 
    .PARAMETER PassThru 
        Return details about the created cloudprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCloudprofile -name <string> -type <string> -vservername <string> -servicetype <string> -ipaddress <string> -port <int> -servicegroupname <string> -boundservicegroupsvctype <string> -vsvrbindsvcport <int>
        An example how to add cloudprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCloudprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudprofile/
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
        [ValidateSet('autoscale', 'azuretags')]
        [string]$Type,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Vservername,

        [Parameter(Mandatory)]
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'DTLS', 'NNTP', 'DNS', 'DHCPRA', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'DNS_TCP', 'RTSP', 'PUSH', 'SSL_PUSH', 'RADIUS', 'RDP', 'MYSQL', 'MSSQL', 'DIAMETER', 'SSL_DIAMETER', 'TFTP', 'ORACLE', 'SMPP', 'SYSLOGTCP', 'SYSLOGUDP', 'FIX', 'SSL_FIX', 'PROXY', 'USER_TCP', 'USER_SSL_TCP', 'QUIC', 'IPFIX', 'LOGSTREAM', 'MONGO', 'MONGO_TLS', 'MQTT', 'MQTT_TLS', 'QUIC_BRIDGE', 'HTTP_QUIC')]
        [string]$Servicetype,

        [Parameter(Mandatory)]
        [string]$Ipaddress,

        [Parameter(Mandatory)]
        [ValidateRange(1, 65535)]
        [int]$Port,

        [Parameter(Mandatory)]
        [string]$Servicegroupname,

        [Parameter(Mandatory)]
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'DTLS', 'NNTP', 'RPCSVR', 'DNS', 'ADNS', 'SNMP', 'RTSP', 'DHCPRA', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'DNS_TCP', 'ADNS_TCP', 'MYSQL', 'MSSQL', 'ORACLE', 'MONGO', 'MONGO_TLS', 'RADIUS', 'RADIUSListener', 'RDP', 'DIAMETER', 'SSL_DIAMETER', 'TFTP', 'SMPP', 'PPTP', 'GRE', 'SYSLOGTCP', 'SYSLOGUDP', 'FIX', 'SSL_FIX', 'USER_TCP', 'USER_SSL_TCP', 'QUIC', 'IPFIX', 'LOGSTREAM', 'LOGSTREAM_SSL', 'MQTT', 'MQTT_TLS', 'QUIC_BRIDGE')]
        [string]$Boundservicegroupsvctype,

        [Parameter(Mandatory)]
        [ValidateRange(1, 65535)]
        [int]$Vsvrbindsvcport,

        [ValidateSet('YES', 'NO')]
        [string]$Graceful = 'NO',

        [double]$Delay,

        [string]$Azuretagname,

        [string]$Azuretagvalue,

        [ValidateRange(60, 3600)]
        [double]$Azurepollperiod = '60',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCloudprofile: Starting"
    }
    process {
        try {
            $payload = @{ name           = $name
                type                     = $type
                vservername              = $vservername
                servicetype              = $servicetype
                ipaddress                = $ipaddress
                port                     = $port
                servicegroupname         = $servicegroupname
                boundservicegroupsvctype = $boundservicegroupsvctype
                vsvrbindsvcport          = $vsvrbindsvcport
            }
            if ( $PSBoundParameters.ContainsKey('graceful') ) { $payload.Add('graceful', $graceful) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('azuretagname') ) { $payload.Add('azuretagname', $azuretagname) }
            if ( $PSBoundParameters.ContainsKey('azuretagvalue') ) { $payload.Add('azuretagvalue', $azuretagvalue) }
            if ( $PSBoundParameters.ContainsKey('azurepollperiod') ) { $payload.Add('azurepollperiod', $azurepollperiod) }
            if ( $PSCmdlet.ShouldProcess("cloudprofile", "Add Cloud configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cloudprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCloudprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCloudprofile: Finished"
    }
}

function Invoke-ADCDeleteCloudprofile {
    <#
    .SYNOPSIS
        Delete Cloud configuration Object.
    .DESCRIPTION
        Configuration for cloud profile resource.
    .PARAMETER Name 
        Name for the Cloud profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the profile is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCloudprofile -Name <string>
        An example how to delete cloudprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCloudprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudprofile/
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
        Write-Verbose "Invoke-ADCDeleteCloudprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cloud configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type cloudprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCloudprofile: Finished"
    }
}

function Invoke-ADCGetCloudprofile {
    <#
    .SYNOPSIS
        Get Cloud configuration object(s).
    .DESCRIPTION
        Configuration for cloud profile resource.
    .PARAMETER Name 
        Name for the Cloud profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the profile is created. 
    .PARAMETER GetAll 
        Retrieve all cloudprofile object(s).
    .PARAMETER Count
        If specified, the count of the cloudprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCloudprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCloudprofile -GetAll 
        Get all cloudprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCloudprofile -Count 
        Get the number of cloudprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCloudprofile -name <string>
        Get cloudprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCloudprofile -Filter @{ 'name'='<value>' }
        Get cloudprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCloudprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudprofile/
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
        Write-Verbose "Invoke-ADCGetCloudprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cloudprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cloudprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCloudprofile: Ended"
    }
}

function Invoke-ADCCheckCloudservice {
    <#
    .SYNOPSIS
        Check Cloud configuration Object.
    .DESCRIPTION
        Configuration for cloud service resource.
    .EXAMPLE
        PS C:\>Invoke-ADCCheckCloudservice 
        An example how to check cloudservice configuration Object(s).
    .NOTES
        File Name : Invoke-ADCCheckCloudservice
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudservice/
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
        [Object]$ADCSession = (Get-ADCSession) 

    )
    begin {
        Write-Verbose "Invoke-ADCCheckCloudservice: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Check Cloud configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cloudservice -Action check -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCCheckCloudservice: Finished"
    }
}

function Invoke-ADCGetCloudvserverip {
    <#
    .SYNOPSIS
        Get Cloud configuration object(s).
    .DESCRIPTION
        Configuration for Cloud virtual server IPs resource.
    .PARAMETER GetAll 
        Retrieve all cloudvserverip object(s).
    .PARAMETER Count
        If specified, the count of the cloudvserverip object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCloudvserverip
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCloudvserverip -GetAll 
        Get all cloudvserverip data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCloudvserverip -Count 
        Get the number of cloudvserverip objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCloudvserverip -name <string>
        Get cloudvserverip object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCloudvserverip -Filter @{ 'name'='<value>' }
        Get cloudvserverip data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCloudvserverip
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudvserverip/
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
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetCloudvserverip: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cloudvserverip objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudvserverip -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudvserverip objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudvserverip -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudvserverip objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudvserverip -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudvserverip configuration for property ''"

            } else {
                Write-Verbose "Retrieving cloudvserverip configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudvserverip -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCloudvserverip: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDpLpB2fIVQoE1O
# LgnR2F18PZ0sgLrC69feXEoMjtbWs6CCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
# i/247uUvWN5TMA0GCSqGSIb3DQEBCwUAMHwxCzAJBgNVBAYTAkdCMRswGQYDVQQI
# ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoT
# D1NlY3RpZ28gTGltaXRlZDEkMCIGA1UEAxMbU2VjdGlnbyBSU0EgQ29kZSBTaWdu
# aW5nIENBMB4XDTIxMDUwNTAwMDAwMFoXDTI0MDUwNDIzNTk1OVowWzELMAkGA1UE
# BhMCTkwxEjAQBgNVBAcMCVZlbGRob3ZlbjEbMBkGA1UECgwSSm9oYW5uZXMgQmls
# bGVrZW5zMRswGQYDVQQDDBJKb2hhbm5lcyBCaWxsZWtlbnMwggEiMA0GCSqGSIb3
# DQEBAQUAA4IBDwAwggEKAoIBAQCsfgRG81keOHalHfCUgxOa1Qy4VNOnGxB8SL8e
# rjP9SfcF13McP7F1HGka5Be495pTZ+duGbaQMNozwg/5Dg9IRJEeBabeSSJJCbZo
# SNpmUu7NNRRfidQxlPC81LxTVHxJ7In0MEfCVm7rWcri28MRCAuafqOfSE+hyb1Z
# /tKyCyQ5RUq3kjs/CF+VfMHsJn6ZT63YqewRkwHuc7UogTTZKjhPJ9prGLTer8UX
# UgvsGRbvhYZXIEuy+bmx/iJ1yRl1kX4nj6gUYzlhemOnlSDD66YOrkLDhXPMXLym
# AN7h0/W5Bo//R5itgvdGBkXkWCKRASnq/9PTcoxW6mwtgU8xAgMBAAGjggGQMIIB
# jDAfBgNVHSMEGDAWgBQO4TqoUzox1Yq+wbutZxoDha00DjAdBgNVHQ4EFgQUZWMy
# gC0i1u2NZ1msk2Mm5nJm5AswDgYDVR0PAQH/BAQDAgeAMAwGA1UdEwEB/wQCMAAw
# EwYDVR0lBAwwCgYIKwYBBQUHAwMwEQYJYIZIAYb4QgEBBAQDAgQQMEoGA1UdIARD
# MEEwNQYMKwYBBAGyMQECAQMCMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
# by5jb20vQ1BTMAgGBmeBDAEEATBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3Js
# LnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDb2RlU2lnbmluZ0NBLmNybDBzBggrBgEF
# BQcBAQRnMGUwPgYIKwYBBQUHMAKGMmh0dHA6Ly9jcnQuc2VjdGlnby5jb20vU2Vj
# dGlnb1JTQUNvZGVTaWduaW5nQ0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2Nz
# cC5zZWN0aWdvLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEARjv9ieRocb1DXRWm3XtY
# jjuSRjlvkoPd9wS6DNfsGlSU42BFd9LCKSyRREZVu8FDq7dN0PhD4bBTT+k6AgrY
# KG6f/8yUponOdxskv850SjN2S2FeVuR20pqActMrpd1+GCylG8mj8RGjdrLQ3QuX
# qYKS68WJ39WWYdVB/8Ftajir5p6sAfwHErLhbJS6WwmYjGI/9SekossvU8mZjZwo
# Gbu+fjZhPc4PhjbEh0ABSsPMfGjQQsg5zLFjg/P+cS6hgYI7qctToo0TexGe32DY
# fFWHrHuBErW2qXEJvzSqM5OtLRD06a4lH5ZkhojhMOX9S8xDs/ArDKgX1j1Xm4Tu
# DjCCBYEwggRpoAMCAQICEDlyRDr5IrdR19NsEN0xNZUwDQYJKoZIhvcNAQEMBQAw
# ezELMAkGA1UEBhMCR0IxGzAZBgNVBAgMEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
# A1UEBwwHU2FsZm9yZDEaMBgGA1UECgwRQ29tb2RvIENBIExpbWl0ZWQxITAfBgNV
# BAMMGEFBQSBDZXJ0aWZpY2F0ZSBTZXJ2aWNlczAeFw0xOTAzMTIwMDAwMDBaFw0y
# ODEyMzEyMzU5NTlaMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEplcnNl
# eTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1Qg
# TmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1
# dGhvcml0eTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAIASZRc2DsPb
# CLPQrFcNdu3NJ9NMrVCDYeKqIE0JLWQJ3M6Jn8w9qez2z8Hc8dOx1ns3KBErR9o5
# xrw6GbRfpr19naNjQrZ28qk7K5H44m/Q7BYgkAk+4uh0yRi0kdRiZNt/owbxiBhq
# kCI8vP4T8IcUe/bkH47U5FHGEWdGCFHLhhRUP7wz/n5snP8WnRi9UY41pqdmyHJn
# 2yFmsdSbeAPAUDrozPDcvJ5M/q8FljUfV1q3/875PbcstvZU3cjnEjpNrkyKt1ya
# tLcgPcp/IjSufjtoZgFE5wFORlObM2D3lL5TN5BzQ/Myw1Pv26r+dE5px2uMYJPe
# xMcM3+EyrsyTO1F4lWeL7j1W/gzQaQ8bD/MlJmszbfduR/pzQ+V+DqVmsSl8MoRj
# VYnEDcGTVDAZE6zTfTen6106bDVc20HXEtqpSQvf2ICKCZNijrVmzyWIzYS4sT+k
# OQ/ZAp7rEkyVfPNrBaleFoPMuGfi6BOdzFuC00yz7Vv/3uVzrCM7LQC/NVV0CUnY
# SVgaf5I25lGSDvMmfRxNF7zJ7EMm0L9BX0CpRET0medXh55QH1dUqD79dGMvsVBl
# CeZYQi5DGky08CVHWfoEHpPUJkZKUIGy3r54t/xnFeHJV4QeD2PW6WK61l9VLupc
# xigIBCU5uA4rqfJMlxwHPw1S9e3vL4IPAgMBAAGjgfIwge8wHwYDVR0jBBgwFoAU
# oBEKIz6W8Qfs4q8p74Klf9AwpLQwHQYDVR0OBBYEFFN5v1qqK0rPVIDh2JvAnfKy
# A2bLMA4GA1UdDwEB/wQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MBEGA1UdIAQKMAgw
# BgYEVR0gADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLmNvbW9kb2NhLmNv
# bS9BQUFDZXJ0aWZpY2F0ZVNlcnZpY2VzLmNybDA0BggrBgEFBQcBAQQoMCYwJAYI
# KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwF
# AAOCAQEAGIdR3HQhPZyK4Ce3M9AuzOzw5steEd4ib5t1jp5y/uTW/qofnJYt7wNK
# fq70jW9yPEM7wD/ruN9cqqnGrvL82O6je0P2hjZ8FODN9Pc//t64tIrwkZb+/UNk
# fv3M0gGhfX34GRnJQisTv1iLuqSiZgR2iJFODIkUzqJNyTKzuugUGrxx8VvwQQuY
# AAoiAxDlDLH5zZI3Ge078eQ6tvlFEyZ1r7uq7z97dzvSxAKRPRkA0xdcOds/exgN
# Rc2ThZYvXd9ZFk8/Ub3VRRg/7UqO6AZhdCMWtQ1QcydER38QXYkqa4UxFMToqWpM
# gLxqeM+4f452cpkMnf7XkQgWoaNflTCCBfUwggPdoAMCAQICEB2iSDBvmyYY0ILg
# ln0z02owDQYJKoZIhvcNAQEMBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpO
# ZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVT
# RVJUUlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmlj
# YXRpb24gQXV0aG9yaXR5MB4XDTE4MTEwMjAwMDAwMFoXDTMwMTIzMTIzNTk1OVow
# fDELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
# A1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSQwIgYDVQQD
# ExtTZWN0aWdvIFJTQSBDb2RlIFNpZ25pbmcgQ0EwggEiMA0GCSqGSIb3DQEBAQUA
# A4IBDwAwggEKAoIBAQCGIo0yhXoYn0nwli9jCB4t3HyfFM/jJrYlZilAhlRGdDFi
# xRDtsocnppnLlTDAVvWkdcapDlBipVGREGrgS2Ku/fD4GKyn/+4uMyD6DBmJqGx7
# rQDDYaHcaWVtH24nlteXUYam9CflfGqLlR5bYNV+1xaSnAAvaPeX7Wpyvjg7Y96P
# v25MQV0SIAhZ6DnNj9LWzwa0VwW2TqE+V2sfmLzEYtYbC43HZhtKn52BxHJAteJf
# 7wtF/6POF6YtVbC3sLxUap28jVZTxvC6eVBJLPcDuf4vZTXyIuosB69G2flGHNyM
# fHEo8/6nxhTdVZFuihEN3wYklX0Pp6F8OtqGNWHTAgMBAAGjggFkMIIBYDAfBgNV
# HSMEGDAWgBRTeb9aqitKz1SA4dibwJ3ysgNmyzAdBgNVHQ4EFgQUDuE6qFM6MdWK
# vsG7rWcaA4WtNA4wDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAw
# HQYDVR0lBBYwFAYIKwYBBQUHAwMGCCsGAQUFBwMIMBEGA1UdIAQKMAgwBgYEVR0g
# ADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNF
# UlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEE
# ajBoMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRy
# dXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVz
# ZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggIBAE1jUO1HNEphpNveaiqMm/EA
# AB4dYns61zLC9rPgY7P7YQCImhttEAcET7646ol4IusPRuzzRl5ARokS9At3Wpwq
# QTr81vTr5/cVlTPDoYMot94v5JT3hTODLUpASL+awk9KsY8k9LOBN9O3ZLCmI2pZ
# aFJCX/8E6+F0ZXkI9amT3mtxQJmWunjxucjiwwgWsatjWsgVgG10Xkp1fqW4w2y1
# z99KeYdcx0BNYzX2MNPPtQoOCwR/oEuuu6Ol0IQAkz5TXTSlADVpbL6fICUQDRn7
# UJBhvjmPeo5N9p8OHv4HURJmgyYZSJXOSsnBf/M6BZv5b9+If8AjntIeQ3pFMcGc
# TanwWbJZGehqjSkEAnd8S0vNcL46slVaeD68u28DECV3FTSK+TbMQ5Lkuk/xYpMo
# JVcp+1EZx6ElQGqEV8aynbG8HArafGd+fS7pKEwYfsR7MUFxmksp7As9V1DSyt39
# ngVR5UR43QHesXWYDVQk/fBO4+L4g71yuss9Ou7wXheSaG3IYfmm8SoKC6W59J7u
# mDIFhZ7r+YMp08Ysfb06dy6LN0KgaoLtO0qqlBCk4Q34F8W2WnkzGJLjtXX4oemO
# CiUe5B7xn1qHI/+fpFGe+zmAEc3btcSnqIBv5VPU4OOiwtJbGvoyJi1qV3AcPKRY
# LqPzW0sH3DJZ84enGm1YMYICQzCCAj8CAQEwgZAwfDELMAkGA1UEBhMCR0IxGzAZ
# BgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
# A1UEChMPU2VjdGlnbyBMaW1pdGVkMSQwIgYDVQQDExtTZWN0aWdvIFJTQSBDb2Rl
# IFNpZ25pbmcgQ0ECECwnTfNkELSL/bju5S9Y3lMwDQYJYIZIAWUDBAIBBQCggYQw
# GAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGC
# NwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQx
# IgQgKMsrVMAh+zyHODVWLFN6fqSaSja/tDUMlHtYD4vTRMowDQYJKoZIhvcNAQEB
# BQAEggEAAj++tw3+OUXXrTh9hJxW6bMPRLPE0LbQ9ChfOgSPY+OkWHbiA6Esqo+y
# qxWcP2SQQKsZeKom6GWO3iNbTRFrmeQcNRseS2bj08c4vpSdcy0YoPZvfI1c5m+P
# dUyJVcCkCZETXqX/Lvauqr7RkNZEdJTLowCk52NuxvXsUX3TUz8ip7HQja4EC3t0
# oOwWRJ7iR4irTu6QnZo0CNSW3blFMYxcOAKBJEOSZxUA+VsCpDxSH3ylBx0oqVRs
# GPUb4uzqxBm8UCx9WpljluNH4qAH4GKi5YU7+GOvIv2WKN1W15SgVMMscPtuyl0m
# 82nY1uXZLwe3HMfMy2/aQATBO0u/0A==
# SIG # End signature block
