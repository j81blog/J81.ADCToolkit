function Invoke-ADCGetAuthenticationloginschemapolicyStats {
    <#
    .SYNOPSIS
        Get Authentication statistics object(s).
    .DESCRIPTION
        Read/write properties
    .PARAMETER Name 
        The name of the LoginSchema policy for which statistics will be displayed. If not given statistics are shown for all policies. 
    .PARAMETER GetAll 
        Retrieve all authenticationloginschemapolicy object(s).
    .PARAMETER Count
        If specified, the count of the authenticationloginschemapolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuthenticationloginschemapolicyStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuthenticationloginschemapolicyStats -GetAll 
        Get all authenticationloginschemapolicy data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuthenticationloginschemapolicyStats -name <string>
        Get authenticationloginschemapolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuthenticationloginschemapolicyStats -Filter @{ 'name'='<value>' }
        Get authenticationloginschemapolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuthenticationloginschemapolicyStats
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/authentication/authenticationloginschemapolicy/
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
        Write-Verbose "Invoke-ADCGetAuthenticationloginschemapolicyStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all authenticationloginschemapolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationloginschemapolicy -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for authenticationloginschemapolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationloginschemapolicy -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving authenticationloginschemapolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationloginschemapolicy -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving authenticationloginschemapolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationloginschemapolicy -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving authenticationloginschemapolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationloginschemapolicy -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuthenticationloginschemapolicyStats: Ended"
    }
}

function Invoke-ADCGetAuthenticationoauthidppolicyStats {
    <#
    .SYNOPSIS
        Get Authentication statistics object(s).
    .DESCRIPTION
        Statistics for AAA OAuth IdentityProvider (IdP) policy resource.
    .PARAMETER Name 
        The name of the OAuth Identity Provider (IdP) policy for which statistics will be displayed. If not given statistics are shown for all policies. 
    .PARAMETER GetAll 
        Retrieve all authenticationoauthidppolicy object(s).
    .PARAMETER Count
        If specified, the count of the authenticationoauthidppolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuthenticationoauthidppolicyStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuthenticationoauthidppolicyStats -GetAll 
        Get all authenticationoauthidppolicy data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuthenticationoauthidppolicyStats -name <string>
        Get authenticationoauthidppolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuthenticationoauthidppolicyStats -Filter @{ 'name'='<value>' }
        Get authenticationoauthidppolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuthenticationoauthidppolicyStats
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/authentication/authenticationoauthidppolicy/
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
        Write-Verbose "Invoke-ADCGetAuthenticationoauthidppolicyStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all authenticationoauthidppolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationoauthidppolicy -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for authenticationoauthidppolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationoauthidppolicy -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving authenticationoauthidppolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationoauthidppolicy -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving authenticationoauthidppolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationoauthidppolicy -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving authenticationoauthidppolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationoauthidppolicy -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuthenticationoauthidppolicyStats: Ended"
    }
}

function Invoke-ADCGetAuthenticationpolicyStats {
    <#
    .SYNOPSIS
        Get Authentication statistics object(s).
    .DESCRIPTION
        Statistics for Authentication Policy resource.
    .PARAMETER Name 
        Name of the advanced authentication policy for which to display statistics. If no name is specified, statistics for all advanced authentication polices are shown. 
    .PARAMETER GetAll 
        Retrieve all authenticationpolicy object(s).
    .PARAMETER Count
        If specified, the count of the authenticationpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuthenticationpolicyStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuthenticationpolicyStats -GetAll 
        Get all authenticationpolicy data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuthenticationpolicyStats -name <string>
        Get authenticationpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuthenticationpolicyStats -Filter @{ 'name'='<value>' }
        Get authenticationpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuthenticationpolicyStats
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/authentication/authenticationpolicy/
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
        Write-Verbose "Invoke-ADCGetAuthenticationpolicyStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all authenticationpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationpolicy -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for authenticationpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationpolicy -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving authenticationpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationpolicy -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving authenticationpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationpolicy -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving authenticationpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationpolicy -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuthenticationpolicyStats: Ended"
    }
}

function Invoke-ADCGetAuthenticationpolicylabelStats {
    <#
    .SYNOPSIS
        Get Authentication statistics object(s).
    .DESCRIPTION
        Statistics for authentication policy label resource.
    .PARAMETER Labelname 
        Name of the authentication policy label. 
    .PARAMETER GetAll 
        Retrieve all authenticationpolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the authenticationpolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuthenticationpolicylabelStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuthenticationpolicylabelStats -GetAll 
        Get all authenticationpolicylabel data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuthenticationpolicylabelStats -name <string>
        Get authenticationpolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuthenticationpolicylabelStats -Filter @{ 'name'='<value>' }
        Get authenticationpolicylabel data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuthenticationpolicylabelStats
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/authentication/authenticationpolicylabel/
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
        [string]$Labelname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAuthenticationpolicylabelStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all authenticationpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationpolicylabel -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for authenticationpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationpolicylabel -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving authenticationpolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationpolicylabel -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving authenticationpolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationpolicylabel -NitroPath nitro/v1/stat -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving authenticationpolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationpolicylabel -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuthenticationpolicylabelStats: Ended"
    }
}

function Invoke-ADCGetAuthenticationsamlidppolicyStats {
    <#
    .SYNOPSIS
        Get Authentication statistics object(s).
    .DESCRIPTION
        Statistics for AAA Saml IdentityProvider (IdP) policy resource.
    .PARAMETER Name 
        The name of the SAML Identity Provider (IdP) policy for which statistics will be displayed. If not given statistics are shown for all policies. 
    .PARAMETER GetAll 
        Retrieve all authenticationsamlidppolicy object(s).
    .PARAMETER Count
        If specified, the count of the authenticationsamlidppolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuthenticationsamlidppolicyStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuthenticationsamlidppolicyStats -GetAll 
        Get all authenticationsamlidppolicy data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuthenticationsamlidppolicyStats -name <string>
        Get authenticationsamlidppolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuthenticationsamlidppolicyStats -Filter @{ 'name'='<value>' }
        Get authenticationsamlidppolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuthenticationsamlidppolicyStats
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/authentication/authenticationsamlidppolicy/
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
        Write-Verbose "Invoke-ADCGetAuthenticationsamlidppolicyStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all authenticationsamlidppolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationsamlidppolicy -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for authenticationsamlidppolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationsamlidppolicy -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving authenticationsamlidppolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationsamlidppolicy -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving authenticationsamlidppolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationsamlidppolicy -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving authenticationsamlidppolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationsamlidppolicy -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuthenticationsamlidppolicyStats: Ended"
    }
}

function Invoke-ADCGetAuthenticationvserverStats {
    <#
    .SYNOPSIS
        Get Authentication statistics object(s).
    .DESCRIPTION
        Statistics for authentication virtual server resource.
    .PARAMETER Name 
        Name of the authentication virtual server. 
    .PARAMETER GetAll 
        Retrieve all authenticationvserver object(s).
    .PARAMETER Count
        If specified, the count of the authenticationvserver object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuthenticationvserverStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuthenticationvserverStats -GetAll 
        Get all authenticationvserver data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuthenticationvserverStats -name <string>
        Get authenticationvserver object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuthenticationvserverStats -Filter @{ 'name'='<value>' }
        Get authenticationvserver data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuthenticationvserverStats
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/authentication/authenticationvserver/
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
        Write-Verbose "Invoke-ADCGetAuthenticationvserverStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all authenticationvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationvserver -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for authenticationvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationvserver -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving authenticationvserver objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationvserver -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving authenticationvserver configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationvserver -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving authenticationvserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type authenticationvserver -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuthenticationvserverStats: Ended"
    }
}


