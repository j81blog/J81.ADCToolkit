function Invoke-ADCGetCloudautoscalegroup {
<#
    .SYNOPSIS
        Get Cloud configuration object(s)
    .DESCRIPTION
        Get Cloud configuration object(s)
    .PARAMETER name 
       . 
    .PARAMETER GetAll 
        Retreive all cloudautoscalegroup object(s)
    .PARAMETER Count
        If specified, the count of the cloudautoscalegroup object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCloudautoscalegroup
    .EXAMPLE 
        Invoke-ADCGetCloudautoscalegroup -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCloudautoscalegroup -Count
    .EXAMPLE
        Invoke-ADCGetCloudautoscalegroup -name <string>
    .EXAMPLE
        Invoke-ADCGetCloudautoscalegroup -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCloudautoscalegroup
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudautoscalegroup/
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
        Write-Verbose "Invoke-ADCGetCloudautoscalegroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all cloudautoscalegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudautoscalegroup -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudautoscalegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudautoscalegroup -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudautoscalegroup objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudautoscalegroup -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudautoscalegroup configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudautoscalegroup -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cloudautoscalegroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudautoscalegroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Update Cloud configuration Object
    .DESCRIPTION
        Update Cloud configuration Object 
    .PARAMETER tenantidentifier 
        Tenant ID of the Credentials.  
        Minimum length = 1 
    .PARAMETER applicationid 
        Application ID of the Credentials.  
        Minimum length = 1 
    .PARAMETER applicationsecret 
        Application Secret of the Credentials.  
        Minimum length = 1
    .EXAMPLE
        Invoke-ADCUpdateCloudcredential -tenantidentifier <string> -applicationid <string> -applicationsecret <string>
    .NOTES
        File Name : Invoke-ADCUpdateCloudcredential
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudcredential/
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
        [string]$tenantidentifier ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$applicationid ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$applicationsecret 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCloudcredential: Starting"
    }
    process {
        try {
            $Payload = @{
                tenantidentifier = $tenantidentifier
                applicationid = $applicationid
                applicationsecret = $applicationsecret
            }

 
            if ($PSCmdlet.ShouldProcess("cloudcredential", "Update Cloud configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type cloudcredential -Payload $Payload -GetWarning
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
        Get Cloud configuration object(s)
    .DESCRIPTION
        Get Cloud configuration object(s)
    .PARAMETER GetAll 
        Retreive all cloudcredential object(s)
    .PARAMETER Count
        If specified, the count of the cloudcredential object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCloudcredential
    .EXAMPLE 
        Invoke-ADCGetCloudcredential -GetAll
    .EXAMPLE
        Invoke-ADCGetCloudcredential -name <string>
    .EXAMPLE
        Invoke-ADCGetCloudcredential -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCloudcredential
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudcredential/
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
        Write-Verbose "Invoke-ADCGetCloudcredential: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all cloudcredential objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudcredential -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudcredential objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudcredential -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudcredential objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudcredential -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudcredential configuration for property ''"

            } else {
                Write-Verbose "Retrieving cloudcredential configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudcredential -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Update Cloud configuration Object
    .DESCRIPTION
        Update Cloud configuration Object 
    .PARAMETER controllerfqdn 
        FQDN of the controller to which the Citrix ADC SDProxy Connects.  
        Minimum length = 1 
    .PARAMETER controllerport 
        Port number of the controller to which the Citrix ADC SDProxy connects.  
        Minimum value = 1  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER instanceid 
        Instance ID of the customer provided by Trust.  
        Minimum length = 1 
    .PARAMETER customerid 
        Customer ID of the citrix cloud customer.  
        Minimum length = 1 
    .PARAMETER resourcelocation 
        Resource Location of the customer provided by Trust.  
        Minimum length = 1 
    .PARAMETER activationcode 
        Activation code for the NGS Connector instance. 
    .PARAMETER deployment 
        Describes if the customer is a Staging/Production or Dev Citrix Cloud customer.  
        Possible values = , Production, Staging, Dev 
    .PARAMETER connectorresidence 
        Identifies whether the connector is located Onprem, Aws or Azure.  
        Possible values = None, Onprem, Aws, Azure, Cpx
    .EXAMPLE
        Invoke-ADCUpdateCloudparameter 
    .NOTES
        File Name : Invoke-ADCUpdateCloudparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudparameter/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$controllerfqdn ,

        [ValidateRange(1, 65535)]
        [int]$controllerport ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$instanceid ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$customerid ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$resourcelocation ,

        [string]$activationcode ,

        [ValidateSet('', 'Production', 'Staging', 'Dev')]
        [string]$deployment ,

        [ValidateSet('None', 'Onprem', 'Aws', 'Azure', 'Cpx')]
        [string]$connectorresidence 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCloudparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('controllerfqdn')) { $Payload.Add('controllerfqdn', $controllerfqdn) }
            if ($PSBoundParameters.ContainsKey('controllerport')) { $Payload.Add('controllerport', $controllerport) }
            if ($PSBoundParameters.ContainsKey('instanceid')) { $Payload.Add('instanceid', $instanceid) }
            if ($PSBoundParameters.ContainsKey('customerid')) { $Payload.Add('customerid', $customerid) }
            if ($PSBoundParameters.ContainsKey('resourcelocation')) { $Payload.Add('resourcelocation', $resourcelocation) }
            if ($PSBoundParameters.ContainsKey('activationcode')) { $Payload.Add('activationcode', $activationcode) }
            if ($PSBoundParameters.ContainsKey('deployment')) { $Payload.Add('deployment', $deployment) }
            if ($PSBoundParameters.ContainsKey('connectorresidence')) { $Payload.Add('connectorresidence', $connectorresidence) }
 
            if ($PSCmdlet.ShouldProcess("cloudparameter", "Update Cloud configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type cloudparameter -Payload $Payload -GetWarning
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
        Unset Cloud configuration Object
    .DESCRIPTION
        Unset Cloud configuration Object 
   .PARAMETER instanceid 
       Instance ID of the customer provided by Trust. 
   .PARAMETER customerid 
       Customer ID of the citrix cloud customer. 
   .PARAMETER resourcelocation 
       Resource Location of the customer provided by Trust.
    .EXAMPLE
        Invoke-ADCUnsetCloudparameter 
    .NOTES
        File Name : Invoke-ADCUnsetCloudparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudparameter
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

        [Boolean]$instanceid ,

        [Boolean]$customerid ,

        [Boolean]$resourcelocation 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCloudparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('instanceid')) { $Payload.Add('instanceid', $instanceid) }
            if ($PSBoundParameters.ContainsKey('customerid')) { $Payload.Add('customerid', $customerid) }
            if ($PSBoundParameters.ContainsKey('resourcelocation')) { $Payload.Add('resourcelocation', $resourcelocation) }
            if ($PSCmdlet.ShouldProcess("cloudparameter", "Unset Cloud configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type cloudparameter -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Cloud configuration object(s)
    .DESCRIPTION
        Get Cloud configuration object(s)
    .PARAMETER GetAll 
        Retreive all cloudparameter object(s)
    .PARAMETER Count
        If specified, the count of the cloudparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCloudparameter
    .EXAMPLE 
        Invoke-ADCGetCloudparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetCloudparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetCloudparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCloudparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudparameter/
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
        Write-Verbose "Invoke-ADCGetCloudparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all cloudparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudparameter -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving cloudparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Update Cloud configuration Object
    .DESCRIPTION
        Update Cloud configuration Object 
    .PARAMETER nonftumode 
        Indicates if GUI in in FTU mode or not.  
        Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCUpdateCloudparaminternal 
    .NOTES
        File Name : Invoke-ADCUpdateCloudparaminternal
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudparaminternal/
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

        [ValidateSet('YES', 'NO')]
        [string]$nonftumode 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCloudparaminternal: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('nonftumode')) { $Payload.Add('nonftumode', $nonftumode) }
 
            if ($PSCmdlet.ShouldProcess("cloudparaminternal", "Update Cloud configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type cloudparaminternal -Payload $Payload -GetWarning
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
        Get Cloud configuration object(s)
    .DESCRIPTION
        Get Cloud configuration object(s)
    .PARAMETER GetAll 
        Retreive all cloudparaminternal object(s)
    .PARAMETER Count
        If specified, the count of the cloudparaminternal object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCloudparaminternal
    .EXAMPLE 
        Invoke-ADCGetCloudparaminternal -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCloudparaminternal -Count
    .EXAMPLE
        Invoke-ADCGetCloudparaminternal -name <string>
    .EXAMPLE
        Invoke-ADCGetCloudparaminternal -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCloudparaminternal
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudparaminternal/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all cloudparaminternal objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudparaminternal -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudparaminternal objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudparaminternal -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudparaminternal objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudparaminternal -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudparaminternal configuration for property ''"

            } else {
                Write-Verbose "Retrieving cloudparaminternal configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudparaminternal -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cloud configuration Object
    .DESCRIPTION
        Add Cloud configuration Object 
    .PARAMETER name 
        Name for the Cloud profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the profile is created.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER type 
        Type of cloud profile that you want to create, Vserver or based on Azure Tags.  
        Possible values = autoscale, azuretags 
    .PARAMETER vservername 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER servicetype 
        Protocol used by the service (also called the service type).  
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, DTLS, NNTP, DNS, DHCPRA, ANY, SIP_UDP, SIP_TCP, SIP_SSL, DNS_TCP, RTSP, PUSH, SSL_PUSH, RADIUS, RDP, MYSQL, MSSQL, DIAMETER, SSL_DIAMETER, TFTP, ORACLE, SMPP, SYSLOGTCP, SYSLOGUDP, FIX, SSL_FIX, PROXY, USER_TCP, USER_SSL_TCP, QUIC, IPFIX, LOGSTREAM, MONGO, MONGO_TLS 
    .PARAMETER ipaddress 
        IPv4 or IPv6 address to assign to the virtual server. 
    .PARAMETER port 
        Port number for the virtual server.  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER servicegroupname 
        servicegroups bind to this server. 
    .PARAMETER boundservicegroupsvctype 
        The type of bound service.  
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, DTLS, NNTP, RPCSVR, DNS, ADNS, SNMP, RTSP, DHCPRA, ANY, SIP_UDP, SIP_TCP, SIP_SSL, DNS_TCP, ADNS_TCP, MYSQL, MSSQL, ORACLE, MONGO, MONGO_TLS, RADIUS, RADIUSListener, RDP, DIAMETER, SSL_DIAMETER, TFTP, SMPP, PPTP, GRE, SYSLOGTCP, SYSLOGUDP, FIX, SSL_FIX, USER_TCP, USER_SSL_TCP, QUIC, IPFIX, LOGSTREAM, LOGSTREAM_SSL 
    .PARAMETER vsvrbindsvcport 
        The port number to be used for the bound service.  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER graceful 
        Indicates graceful shutdown of the service. System will wait for all outstanding connections to this service to be closed before disabling the service.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER delay 
        Time, in seconds, after which all the services configured on the server are disabled. 
    .PARAMETER azuretagname 
        Azure tag name.  
        Maximum length = 512 
    .PARAMETER azuretagvalue 
        Azure tag value.  
        Maximum length = 256 
    .PARAMETER azurepollperiod 
        Azure polling period (in seconds).  
        Default value: 60  
        Minimum value = 60  
        Maximum value = 3600 
    .PARAMETER PassThru 
        Return details about the created cloudprofile item.
    .EXAMPLE
        Invoke-ADCAddCloudprofile -name <string> -type <string> -vservername <string> -servicetype <string> -ipaddress <string> -port <int> -servicegroupname <string> -boundservicegroupsvctype <string> -vsvrbindsvcport <int>
    .NOTES
        File Name : Invoke-ADCAddCloudprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudprofile/
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
        [ValidateSet('autoscale', 'azuretags')]
        [string]$type ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$vservername ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'DTLS', 'NNTP', 'DNS', 'DHCPRA', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'DNS_TCP', 'RTSP', 'PUSH', 'SSL_PUSH', 'RADIUS', 'RDP', 'MYSQL', 'MSSQL', 'DIAMETER', 'SSL_DIAMETER', 'TFTP', 'ORACLE', 'SMPP', 'SYSLOGTCP', 'SYSLOGUDP', 'FIX', 'SSL_FIX', 'PROXY', 'USER_TCP', 'USER_SSL_TCP', 'QUIC', 'IPFIX', 'LOGSTREAM', 'MONGO', 'MONGO_TLS')]
        [string]$servicetype ,

        [Parameter(Mandatory = $true)]
        [string]$ipaddress ,

        [Parameter(Mandatory = $true)]
        [ValidateRange(1, 65535)]
        [int]$port ,

        [Parameter(Mandatory = $true)]
        [string]$servicegroupname ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'DTLS', 'NNTP', 'RPCSVR', 'DNS', 'ADNS', 'SNMP', 'RTSP', 'DHCPRA', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'DNS_TCP', 'ADNS_TCP', 'MYSQL', 'MSSQL', 'ORACLE', 'MONGO', 'MONGO_TLS', 'RADIUS', 'RADIUSListener', 'RDP', 'DIAMETER', 'SSL_DIAMETER', 'TFTP', 'SMPP', 'PPTP', 'GRE', 'SYSLOGTCP', 'SYSLOGUDP', 'FIX', 'SSL_FIX', 'USER_TCP', 'USER_SSL_TCP', 'QUIC', 'IPFIX', 'LOGSTREAM', 'LOGSTREAM_SSL')]
        [string]$boundservicegroupsvctype ,

        [Parameter(Mandatory = $true)]
        [ValidateRange(1, 65535)]
        [int]$vsvrbindsvcport ,

        [ValidateSet('YES', 'NO')]
        [string]$graceful = 'NO' ,

        [double]$delay ,

        [string]$azuretagname ,

        [string]$azuretagvalue ,

        [ValidateRange(60, 3600)]
        [double]$azurepollperiod = '60' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCloudprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                type = $type
                vservername = $vservername
                servicetype = $servicetype
                ipaddress = $ipaddress
                port = $port
                servicegroupname = $servicegroupname
                boundservicegroupsvctype = $boundservicegroupsvctype
                vsvrbindsvcport = $vsvrbindsvcport
            }
            if ($PSBoundParameters.ContainsKey('graceful')) { $Payload.Add('graceful', $graceful) }
            if ($PSBoundParameters.ContainsKey('delay')) { $Payload.Add('delay', $delay) }
            if ($PSBoundParameters.ContainsKey('azuretagname')) { $Payload.Add('azuretagname', $azuretagname) }
            if ($PSBoundParameters.ContainsKey('azuretagvalue')) { $Payload.Add('azuretagvalue', $azuretagvalue) }
            if ($PSBoundParameters.ContainsKey('azurepollperiod')) { $Payload.Add('azurepollperiod', $azurepollperiod) }
 
            if ($PSCmdlet.ShouldProcess("cloudprofile", "Add Cloud configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cloudprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCloudprofile -Filter $Payload)
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
        Delete Cloud configuration Object
    .DESCRIPTION
        Delete Cloud configuration Object
    .PARAMETER name 
       Name for the Cloud profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the profile is created.  
       Minimum length = 1  
       Maximum length = 127 
    .EXAMPLE
        Invoke-ADCDeleteCloudprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCloudprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudprofile/
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
        Write-Verbose "Invoke-ADCDeleteCloudprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Cloud configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type cloudprofile -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Cloud configuration object(s)
    .DESCRIPTION
        Get Cloud configuration object(s)
    .PARAMETER name 
       Name for the Cloud profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the profile is created. 
    .PARAMETER GetAll 
        Retreive all cloudprofile object(s)
    .PARAMETER Count
        If specified, the count of the cloudprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCloudprofile
    .EXAMPLE 
        Invoke-ADCGetCloudprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCloudprofile -Count
    .EXAMPLE
        Invoke-ADCGetCloudprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetCloudprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCloudprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudprofile/
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
        Write-Verbose "Invoke-ADCGetCloudprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all cloudprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cloudprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Check Cloud configuration Object
    .DESCRIPTION
        Check Cloud configuration Object 
    .EXAMPLE
        Invoke-ADCCheckCloudservice 
    .NOTES
        File Name : Invoke-ADCCheckCloudservice
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudservice/
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
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession) 

    )
    begin {
        Write-Verbose "Invoke-ADCCheckCloudservice: Starting"
    }
    process {
        try {
            $Payload = @{

            }

            if ($PSCmdlet.ShouldProcess($Name, "Check Cloud configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cloudservice -Action check -Payload $Payload -GetWarning
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
        Get Cloud configuration object(s)
    .DESCRIPTION
        Get Cloud configuration object(s)
    .PARAMETER GetAll 
        Retreive all cloudvserverip object(s)
    .PARAMETER Count
        If specified, the count of the cloudvserverip object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCloudvserverip
    .EXAMPLE 
        Invoke-ADCGetCloudvserverip -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCloudvserverip -Count
    .EXAMPLE
        Invoke-ADCGetCloudvserverip -name <string>
    .EXAMPLE
        Invoke-ADCGetCloudvserverip -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCloudvserverip
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cloud/cloudvserverip/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all cloudvserverip objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudvserverip -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cloudvserverip objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudvserverip -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cloudvserverip objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudvserverip -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cloudvserverip configuration for property ''"

            } else {
                Write-Verbose "Retrieving cloudvserverip configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cloudvserverip -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


