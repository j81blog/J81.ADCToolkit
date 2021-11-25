function Invoke-ADCAddAzureapplication {
    <#
    .SYNOPSIS
        Add Azure configuration Object.
    .DESCRIPTION
        Configuration for Azure Application resource.
    .PARAMETER Name 
        Name for the application. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the application is created.', 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my application" or 'my application'). 
    .PARAMETER Clientid 
        Application ID that is generated when an application is created in Azure Active Directory using either the Azure CLI or the Azure portal (GUI). 
    .PARAMETER Clientsecret 
        Password for the application configured in Azure Active Directory. The password is specified in the Azure CLI or generated in the Azure portal (GUI). 
    .PARAMETER Tenantid 
        ID of the directory inside Azure Active Directory in which the application was created. 
    .PARAMETER Vaultresource 
        Vault resource for which access token is granted. Example : vault.azure.net. 
    .PARAMETER Tokenendpoint 
        URL from where access token can be obtained. If the token end point is not specified, the default value is https://login.microsoftonline.com/<tenant id>. 
    .PARAMETER PassThru 
        Return details about the created azureapplication item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAzureapplication -name <string> -clientid <string> -clientsecret <string> -tenantid <string> -vaultresource <string>
        An example how to add azureapplication configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAzureapplication
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/azure/azureapplication/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Clientid,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Clientsecret,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Tenantid,

        [Parameter(Mandatory)]
        [ValidateLength(3, 255)]
        [string]$Vaultresource,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Tokenendpoint,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAzureapplication: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                clientid       = $clientid
                clientsecret   = $clientsecret
                tenantid       = $tenantid
                vaultresource  = $vaultresource
            }
            if ( $PSBoundParameters.ContainsKey('tokenendpoint') ) { $payload.Add('tokenendpoint', $tokenendpoint) }
            if ( $PSCmdlet.ShouldProcess("azureapplication", "Add Azure configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type azureapplication -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAzureapplication -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddAzureapplication: Finished"
    }
}

function Invoke-ADCDeleteAzureapplication {
    <#
    .SYNOPSIS
        Delete Azure configuration Object.
    .DESCRIPTION
        Configuration for Azure Application resource.
    .PARAMETER Name 
        Name for the application. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the application is created.', 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my application" or 'my application').
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAzureapplication -Name <string>
        An example how to delete azureapplication configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAzureapplication
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/azure/azureapplication/
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
        Write-Verbose "Invoke-ADCDeleteAzureapplication: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Azure configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type azureapplication -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteAzureapplication: Finished"
    }
}

function Invoke-ADCGetAzureapplication {
    <#
    .SYNOPSIS
        Get Azure configuration object(s).
    .DESCRIPTION
        Configuration for Azure Application resource.
    .PARAMETER Name 
        Name for the application. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the application is created.', 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my application" or 'my application'). 
    .PARAMETER GetAll 
        Retrieve all azureapplication object(s).
    .PARAMETER Count
        If specified, the count of the azureapplication object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAzureapplication
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAzureapplication -GetAll 
        Get all azureapplication data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAzureapplication -Count 
        Get the number of azureapplication objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAzureapplication -name <string>
        Get azureapplication object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAzureapplication -Filter @{ 'name'='<value>' }
        Get azureapplication data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAzureapplication
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/azure/azureapplication/
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
        Write-Verbose "Invoke-ADCGetAzureapplication: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all azureapplication objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type azureapplication -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for azureapplication objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type azureapplication -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving azureapplication objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type azureapplication -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving azureapplication configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type azureapplication -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving azureapplication configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type azureapplication -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAzureapplication: Ended"
    }
}

function Invoke-ADCAddAzurekeyvault {
    <#
    .SYNOPSIS
        Add Azure configuration Object.
    .DESCRIPTION
        Configuration for Azure Key Vault entity resource.
    .PARAMETER Name 
        Name for the Key Vault. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the Key Vault is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my keyvault" or 'my keyvault'). 
    .PARAMETER Azurevaultname 
        Name of the Key Vault configured in Azure cloud using either the Azure CLI or the Azure portal (GUI) with complete domain name. Example: Test.vault.azure.net. 
    .PARAMETER Azureapplication 
        Name of the Azure Application object created on the ADC appliance. This object will be used for authentication with Azure Active Directory. 
    .PARAMETER PassThru 
        Return details about the created azurekeyvault item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAzurekeyvault -name <string> -azureapplication <string>
        An example how to add azurekeyvault configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAzurekeyvault
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/azure/azurekeyvault/
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

        [ValidateLength(3, 255)]
        [string]$Azurevaultname,

        [Parameter(Mandatory)]
        [ValidateLength(1, 63)]
        [string]$Azureapplication,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAzurekeyvault: Starting"
    }
    process {
        try {
            $payload = @{ name   = $name
                azureapplication = $azureapplication
            }
            if ( $PSBoundParameters.ContainsKey('azurevaultname') ) { $payload.Add('azurevaultname', $azurevaultname) }
            if ( $PSCmdlet.ShouldProcess("azurekeyvault", "Add Azure configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type azurekeyvault -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAzurekeyvault -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddAzurekeyvault: Finished"
    }
}

function Invoke-ADCDeleteAzurekeyvault {
    <#
    .SYNOPSIS
        Delete Azure configuration Object.
    .DESCRIPTION
        Configuration for Azure Key Vault entity resource.
    .PARAMETER Name 
        Name for the Key Vault. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the Key Vault is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my keyvault" or 'my keyvault').
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAzurekeyvault -Name <string>
        An example how to delete azurekeyvault configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAzurekeyvault
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/azure/azurekeyvault/
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
        Write-Verbose "Invoke-ADCDeleteAzurekeyvault: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Azure configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type azurekeyvault -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteAzurekeyvault: Finished"
    }
}

function Invoke-ADCGetAzurekeyvault {
    <#
    .SYNOPSIS
        Get Azure configuration object(s).
    .DESCRIPTION
        Configuration for Azure Key Vault entity resource.
    .PARAMETER Name 
        Name for the Key Vault. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the Key Vault is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my keyvault" or 'my keyvault'). 
    .PARAMETER GetAll 
        Retrieve all azurekeyvault object(s).
    .PARAMETER Count
        If specified, the count of the azurekeyvault object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAzurekeyvault
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAzurekeyvault -GetAll 
        Get all azurekeyvault data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAzurekeyvault -Count 
        Get the number of azurekeyvault objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAzurekeyvault -name <string>
        Get azurekeyvault object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAzurekeyvault -Filter @{ 'name'='<value>' }
        Get azurekeyvault data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAzurekeyvault
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/azure/azurekeyvault/
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
        Write-Verbose "Invoke-ADCGetAzurekeyvault: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all azurekeyvault objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type azurekeyvault -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for azurekeyvault objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type azurekeyvault -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving azurekeyvault objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type azurekeyvault -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving azurekeyvault configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type azurekeyvault -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving azurekeyvault configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type azurekeyvault -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAzurekeyvault: Ended"
    }
}


