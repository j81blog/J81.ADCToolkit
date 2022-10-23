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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [ValidateLength(1, 127)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateSet('autoscale', 'azuretags')]
        [string]$Type,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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


