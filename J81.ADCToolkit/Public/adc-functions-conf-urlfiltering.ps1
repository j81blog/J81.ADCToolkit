function Invoke-ADCGetUrlfilteringcategories {
    <#
    .SYNOPSIS
        Get Urlfiltering configuration object(s).
    .DESCRIPTION
        Configuration for Categories resource.
    .PARAMETER Group 
        URL Filtering SDK Category per Group. 
    .PARAMETER GetAll 
        Retrieve all urlfilteringcategories object(s).
    .PARAMETER Count
        If specified, the count of the urlfilteringcategories object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetUrlfilteringcategories
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetUrlfilteringcategories -GetAll 
        Get all urlfilteringcategories data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetUrlfilteringcategories -name <string>
        Get urlfilteringcategories object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetUrlfilteringcategories -Filter @{ 'name'='<value>' }
        Get urlfilteringcategories data with a filter.
    .NOTES
        File Name : Invoke-ADCGetUrlfilteringcategories
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/urlfiltering/urlfilteringcategories/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Group,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetUrlfilteringcategories: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all urlfilteringcategories objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategories -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for urlfilteringcategories objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategories -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving urlfilteringcategories objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('group') ) { $arguments.Add('group', $group) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategories -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving urlfilteringcategories configuration for property ''"

            } else {
                Write-Verbose "Retrieving urlfilteringcategories configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategories -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetUrlfilteringcategories: Ended"
    }
}

function Invoke-ADCAddUrlfilteringcategorization {
    <#
    .SYNOPSIS
        Add Urlfiltering configuration Object.
    .DESCRIPTION
        Configuration for Categorization resource.
    .PARAMETER Url 
        Url given for categorization.
    .EXAMPLE
        PS C:\>Invoke-ADCAddUrlfilteringcategorization 
        An example how to add urlfilteringcategorization configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddUrlfilteringcategorization
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/urlfiltering/urlfilteringcategorization/
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
        [string]$Url 
    )
    begin {
        Write-Verbose "Invoke-ADCAddUrlfilteringcategorization: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('url') ) { $payload.Add('url', $url) }
            if ( $PSCmdlet.ShouldProcess("urlfilteringcategorization", "Add Urlfiltering configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type urlfilteringcategorization -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddUrlfilteringcategorization: Finished"
    }
}

function Invoke-ADCClearUrlfilteringcategorization {
    <#
    .SYNOPSIS
        Clear Urlfiltering configuration Object.
    .DESCRIPTION
        Configuration for Categorization resource.
    .EXAMPLE
        PS C:\>Invoke-ADCClearUrlfilteringcategorization 
        An example how to clear urlfilteringcategorization configuration Object(s).
    .NOTES
        File Name : Invoke-ADCClearUrlfilteringcategorization
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/urlfiltering/urlfilteringcategorization/
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
        Write-Verbose "Invoke-ADCClearUrlfilteringcategorization: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Clear Urlfiltering configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type urlfilteringcategorization -Action clear -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCClearUrlfilteringcategorization: Finished"
    }
}

function Invoke-ADCGetUrlfilteringcategorization {
    <#
    .SYNOPSIS
        Get Urlfiltering configuration object(s).
    .DESCRIPTION
        Configuration for Categorization resource.
    .PARAMETER GetAll 
        Retrieve all urlfilteringcategorization object(s).
    .PARAMETER Count
        If specified, the count of the urlfilteringcategorization object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetUrlfilteringcategorization
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetUrlfilteringcategorization -GetAll 
        Get all urlfilteringcategorization data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetUrlfilteringcategorization -name <string>
        Get urlfilteringcategorization object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetUrlfilteringcategorization -Filter @{ 'name'='<value>' }
        Get urlfilteringcategorization data with a filter.
    .NOTES
        File Name : Invoke-ADCGetUrlfilteringcategorization
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/urlfiltering/urlfilteringcategorization/
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
        Write-Verbose "Invoke-ADCGetUrlfilteringcategorization: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all urlfilteringcategorization objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategorization -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for urlfilteringcategorization objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategorization -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving urlfilteringcategorization objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategorization -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving urlfilteringcategorization configuration for property ''"

            } else {
                Write-Verbose "Retrieving urlfilteringcategorization configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategorization -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetUrlfilteringcategorization: Ended"
    }
}

function Invoke-ADCGetUrlfilteringcategorygroups {
    <#
    .SYNOPSIS
        Get Urlfiltering configuration object(s).
    .DESCRIPTION
        Configuration for Category Groups resource.
    .PARAMETER GetAll 
        Retrieve all urlfilteringcategorygroups object(s).
    .PARAMETER Count
        If specified, the count of the urlfilteringcategorygroups object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetUrlfilteringcategorygroups
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetUrlfilteringcategorygroups -GetAll 
        Get all urlfilteringcategorygroups data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetUrlfilteringcategorygroups -name <string>
        Get urlfilteringcategorygroups object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetUrlfilteringcategorygroups -Filter @{ 'name'='<value>' }
        Get urlfilteringcategorygroups data with a filter.
    .NOTES
        File Name : Invoke-ADCGetUrlfilteringcategorygroups
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/urlfiltering/urlfilteringcategorygroups/
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
        Write-Verbose "Invoke-ADCGetUrlfilteringcategorygroups: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all urlfilteringcategorygroups objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategorygroups -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for urlfilteringcategorygroups objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategorygroups -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving urlfilteringcategorygroups objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategorygroups -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving urlfilteringcategorygroups configuration for property ''"

            } else {
                Write-Verbose "Retrieving urlfilteringcategorygroups configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategorygroups -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetUrlfilteringcategorygroups: Ended"
    }
}

function Invoke-ADCUpdateUrlfilteringparameter {
    <#
    .SYNOPSIS
        Update Urlfiltering configuration Object.
    .DESCRIPTION
        Configuration for URLFILTERING paramter resource.
    .PARAMETER Hoursbetweendbupdates 
        URL Filtering hours between DB updates. 
    .PARAMETER Timeofdaytoupdatedb 
        URL Filtering time of day to update DB. 
    .PARAMETER Localdatabasethreads 
        URL Filtering Local DB number of threads. 
    .PARAMETER Cloudhost 
        URL Filtering Cloud host. 
    .PARAMETER Seeddbpath 
        URL Filtering Seed DB path.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateUrlfilteringparameter 
        An example how to update urlfilteringparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateUrlfilteringparameter
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/urlfiltering/urlfilteringparameter/
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

        [ValidateRange(0, 720)]
        [double]$Hoursbetweendbupdates,

        [string]$Timeofdaytoupdatedb,

        [ValidateRange(1, 4)]
        [double]$Localdatabasethreads,

        [string]$Cloudhost,

        [string]$Seeddbpath 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateUrlfilteringparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('hoursbetweendbupdates') ) { $payload.Add('hoursbetweendbupdates', $hoursbetweendbupdates) }
            if ( $PSBoundParameters.ContainsKey('timeofdaytoupdatedb') ) { $payload.Add('timeofdaytoupdatedb', $timeofdaytoupdatedb) }
            if ( $PSBoundParameters.ContainsKey('localdatabasethreads') ) { $payload.Add('localdatabasethreads', $localdatabasethreads) }
            if ( $PSBoundParameters.ContainsKey('cloudhost') ) { $payload.Add('cloudhost', $cloudhost) }
            if ( $PSBoundParameters.ContainsKey('seeddbpath') ) { $payload.Add('seeddbpath', $seeddbpath) }
            if ( $PSCmdlet.ShouldProcess("urlfilteringparameter", "Update Urlfiltering configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type urlfilteringparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateUrlfilteringparameter: Finished"
    }
}

function Invoke-ADCUnsetUrlfilteringparameter {
    <#
    .SYNOPSIS
        Unset Urlfiltering configuration Object.
    .DESCRIPTION
        Configuration for URLFILTERING paramter resource.
    .PARAMETER Hoursbetweendbupdates 
        URL Filtering hours between DB updates. 
    .PARAMETER Timeofdaytoupdatedb 
        URL Filtering time of day to update DB. 
    .PARAMETER Localdatabasethreads 
        URL Filtering Local DB number of threads. 
    .PARAMETER Cloudhost 
        URL Filtering Cloud host. 
    .PARAMETER Seeddbpath 
        URL Filtering Seed DB path.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetUrlfilteringparameter 
        An example how to unset urlfilteringparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetUrlfilteringparameter
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/urlfiltering/urlfilteringparameter
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

        [Boolean]$hoursbetweendbupdates,

        [Boolean]$timeofdaytoupdatedb,

        [Boolean]$localdatabasethreads,

        [Boolean]$cloudhost,

        [Boolean]$seeddbpath 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetUrlfilteringparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('hoursbetweendbupdates') ) { $payload.Add('hoursbetweendbupdates', $hoursbetweendbupdates) }
            if ( $PSBoundParameters.ContainsKey('timeofdaytoupdatedb') ) { $payload.Add('timeofdaytoupdatedb', $timeofdaytoupdatedb) }
            if ( $PSBoundParameters.ContainsKey('localdatabasethreads') ) { $payload.Add('localdatabasethreads', $localdatabasethreads) }
            if ( $PSBoundParameters.ContainsKey('cloudhost') ) { $payload.Add('cloudhost', $cloudhost) }
            if ( $PSBoundParameters.ContainsKey('seeddbpath') ) { $payload.Add('seeddbpath', $seeddbpath) }
            if ( $PSCmdlet.ShouldProcess("urlfilteringparameter", "Unset Urlfiltering configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type urlfilteringparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetUrlfilteringparameter: Finished"
    }
}

function Invoke-ADCGetUrlfilteringparameter {
    <#
    .SYNOPSIS
        Get Urlfiltering configuration object(s).
    .DESCRIPTION
        Configuration for URLFILTERING paramter resource.
    .PARAMETER GetAll 
        Retrieve all urlfilteringparameter object(s).
    .PARAMETER Count
        If specified, the count of the urlfilteringparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetUrlfilteringparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetUrlfilteringparameter -GetAll 
        Get all urlfilteringparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetUrlfilteringparameter -name <string>
        Get urlfilteringparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetUrlfilteringparameter -Filter @{ 'name'='<value>' }
        Get urlfilteringparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetUrlfilteringparameter
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/urlfiltering/urlfilteringparameter/
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
        Write-Verbose "Invoke-ADCGetUrlfilteringparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all urlfilteringparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for urlfilteringparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving urlfilteringparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving urlfilteringparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving urlfilteringparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetUrlfilteringparameter: Ended"
    }
}


