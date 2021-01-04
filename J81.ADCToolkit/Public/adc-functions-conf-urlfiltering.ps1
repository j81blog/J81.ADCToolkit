function Invoke-ADCGetUrlfilteringcategories {
<#
    .SYNOPSIS
        Get Urlfiltering configuration object(s)
    .DESCRIPTION
        Get Urlfiltering configuration object(s)
    .PARAMETER group 
       URL Filtering SDK Category per Group. 
    .PARAMETER GetAll 
        Retreive all urlfilteringcategories object(s)
    .PARAMETER Count
        If specified, the count of the urlfilteringcategories object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetUrlfilteringcategories
    .EXAMPLE 
        Invoke-ADCGetUrlfilteringcategories -GetAll
    .EXAMPLE
        Invoke-ADCGetUrlfilteringcategories -name <string>
    .EXAMPLE
        Invoke-ADCGetUrlfilteringcategories -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetUrlfilteringcategories
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/urlfiltering/urlfilteringcategories/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$group,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetUrlfilteringcategories: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all urlfilteringcategories objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategories -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for urlfilteringcategories objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategories -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving urlfilteringcategories objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('group')) { $Arguments.Add('group', $group) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategories -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving urlfilteringcategories configuration for property ''"

            } else {
                Write-Verbose "Retrieving urlfilteringcategories configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategories -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Urlfiltering configuration Object
    .DESCRIPTION
        Add Urlfiltering configuration Object 
    .PARAMETER url 
        Url given for categorization.  
        Minimum length = 1
    .EXAMPLE
        Invoke-ADCAddUrlfilteringcategorization 
    .NOTES
        File Name : Invoke-ADCAddUrlfilteringcategorization
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/urlfiltering/urlfilteringcategorization/
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
        [string]$url 

    )
    begin {
        Write-Verbose "Invoke-ADCAddUrlfilteringcategorization: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('url')) { $Payload.Add('url', $url) }
 
            if ($PSCmdlet.ShouldProcess("urlfilteringcategorization", "Add Urlfiltering configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type urlfilteringcategorization -Payload $Payload -GetWarning
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
        Clear Urlfiltering configuration Object
    .DESCRIPTION
        Clear Urlfiltering configuration Object 
    .EXAMPLE
        Invoke-ADCClearUrlfilteringcategorization 
    .NOTES
        File Name : Invoke-ADCClearUrlfilteringcategorization
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/urlfiltering/urlfilteringcategorization/
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
        Write-Verbose "Invoke-ADCClearUrlfilteringcategorization: Starting"
    }
    process {
        try {
            $Payload = @{

            }

            if ($PSCmdlet.ShouldProcess($Name, "Clear Urlfiltering configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type urlfilteringcategorization -Action clear -Payload $Payload -GetWarning
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
        Get Urlfiltering configuration object(s)
    .DESCRIPTION
        Get Urlfiltering configuration object(s)
    .PARAMETER GetAll 
        Retreive all urlfilteringcategorization object(s)
    .PARAMETER Count
        If specified, the count of the urlfilteringcategorization object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetUrlfilteringcategorization
    .EXAMPLE 
        Invoke-ADCGetUrlfilteringcategorization -GetAll
    .EXAMPLE
        Invoke-ADCGetUrlfilteringcategorization -name <string>
    .EXAMPLE
        Invoke-ADCGetUrlfilteringcategorization -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetUrlfilteringcategorization
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/urlfiltering/urlfilteringcategorization/
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
        Write-Verbose "Invoke-ADCGetUrlfilteringcategorization: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all urlfilteringcategorization objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategorization -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for urlfilteringcategorization objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategorization -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving urlfilteringcategorization objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategorization -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving urlfilteringcategorization configuration for property ''"

            } else {
                Write-Verbose "Retrieving urlfilteringcategorization configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategorization -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Urlfiltering configuration object(s)
    .DESCRIPTION
        Get Urlfiltering configuration object(s)
    .PARAMETER GetAll 
        Retreive all urlfilteringcategorygroups object(s)
    .PARAMETER Count
        If specified, the count of the urlfilteringcategorygroups object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetUrlfilteringcategorygroups
    .EXAMPLE 
        Invoke-ADCGetUrlfilteringcategorygroups -GetAll
    .EXAMPLE
        Invoke-ADCGetUrlfilteringcategorygroups -name <string>
    .EXAMPLE
        Invoke-ADCGetUrlfilteringcategorygroups -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetUrlfilteringcategorygroups
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/urlfiltering/urlfilteringcategorygroups/
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
        Write-Verbose "Invoke-ADCGetUrlfilteringcategorygroups: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all urlfilteringcategorygroups objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategorygroups -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for urlfilteringcategorygroups objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategorygroups -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving urlfilteringcategorygroups objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategorygroups -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving urlfilteringcategorygroups configuration for property ''"

            } else {
                Write-Verbose "Retrieving urlfilteringcategorygroups configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringcategorygroups -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Update Urlfiltering configuration Object
    .DESCRIPTION
        Update Urlfiltering configuration Object 
    .PARAMETER hoursbetweendbupdates 
        URL Filtering hours between DB updates.  
        Minimum value = 0  
        Maximum value = 720 
    .PARAMETER timeofdaytoupdatedb 
        URL Filtering time of day to update DB. 
    .PARAMETER localdatabasethreads 
        URL Filtering Local DB number of threads.  
        Minimum value = 1  
        Maximum value = 4 
    .PARAMETER cloudhost 
        URL Filtering Cloud host. 
    .PARAMETER seeddbpath 
        URL Filtering Seed DB path.
    .EXAMPLE
        Invoke-ADCUpdateUrlfilteringparameter 
    .NOTES
        File Name : Invoke-ADCUpdateUrlfilteringparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/urlfiltering/urlfilteringparameter/
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

        [ValidateRange(0, 720)]
        [double]$hoursbetweendbupdates ,

        [string]$timeofdaytoupdatedb ,

        [ValidateRange(1, 4)]
        [double]$localdatabasethreads ,

        [string]$cloudhost ,

        [string]$seeddbpath 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateUrlfilteringparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('hoursbetweendbupdates')) { $Payload.Add('hoursbetweendbupdates', $hoursbetweendbupdates) }
            if ($PSBoundParameters.ContainsKey('timeofdaytoupdatedb')) { $Payload.Add('timeofdaytoupdatedb', $timeofdaytoupdatedb) }
            if ($PSBoundParameters.ContainsKey('localdatabasethreads')) { $Payload.Add('localdatabasethreads', $localdatabasethreads) }
            if ($PSBoundParameters.ContainsKey('cloudhost')) { $Payload.Add('cloudhost', $cloudhost) }
            if ($PSBoundParameters.ContainsKey('seeddbpath')) { $Payload.Add('seeddbpath', $seeddbpath) }
 
            if ($PSCmdlet.ShouldProcess("urlfilteringparameter", "Update Urlfiltering configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type urlfilteringparameter -Payload $Payload -GetWarning
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
        Unset Urlfiltering configuration Object
    .DESCRIPTION
        Unset Urlfiltering configuration Object 
   .PARAMETER hoursbetweendbupdates 
       URL Filtering hours between DB updates. 
   .PARAMETER timeofdaytoupdatedb 
       URL Filtering time of day to update DB. 
   .PARAMETER localdatabasethreads 
       URL Filtering Local DB number of threads. 
   .PARAMETER cloudhost 
       URL Filtering Cloud host. 
   .PARAMETER seeddbpath 
       URL Filtering Seed DB path.
    .EXAMPLE
        Invoke-ADCUnsetUrlfilteringparameter 
    .NOTES
        File Name : Invoke-ADCUnsetUrlfilteringparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/urlfiltering/urlfilteringparameter
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

        [Boolean]$hoursbetweendbupdates ,

        [Boolean]$timeofdaytoupdatedb ,

        [Boolean]$localdatabasethreads ,

        [Boolean]$cloudhost ,

        [Boolean]$seeddbpath 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetUrlfilteringparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('hoursbetweendbupdates')) { $Payload.Add('hoursbetweendbupdates', $hoursbetweendbupdates) }
            if ($PSBoundParameters.ContainsKey('timeofdaytoupdatedb')) { $Payload.Add('timeofdaytoupdatedb', $timeofdaytoupdatedb) }
            if ($PSBoundParameters.ContainsKey('localdatabasethreads')) { $Payload.Add('localdatabasethreads', $localdatabasethreads) }
            if ($PSBoundParameters.ContainsKey('cloudhost')) { $Payload.Add('cloudhost', $cloudhost) }
            if ($PSBoundParameters.ContainsKey('seeddbpath')) { $Payload.Add('seeddbpath', $seeddbpath) }
            if ($PSCmdlet.ShouldProcess("urlfilteringparameter", "Unset Urlfiltering configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type urlfilteringparameter -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Urlfiltering configuration object(s)
    .DESCRIPTION
        Get Urlfiltering configuration object(s)
    .PARAMETER GetAll 
        Retreive all urlfilteringparameter object(s)
    .PARAMETER Count
        If specified, the count of the urlfilteringparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetUrlfilteringparameter
    .EXAMPLE 
        Invoke-ADCGetUrlfilteringparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetUrlfilteringparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetUrlfilteringparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetUrlfilteringparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/urlfiltering/urlfilteringparameter/
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
        Write-Verbose "Invoke-ADCGetUrlfilteringparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all urlfilteringparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for urlfilteringparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving urlfilteringparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringparameter -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving urlfilteringparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving urlfilteringparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type urlfilteringparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


