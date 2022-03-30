function Invoke-ADCUpdateExtendedmemoryparam {
    <#
    .SYNOPSIS
        Update Basic configuration Object.
    .DESCRIPTION
        Configuration for Parameter for extended memory used by LSN and Subscriber Store resource.
    .PARAMETER Memlimit 
        Amount of Citrix ADC memory to reserve for the memory used by LSN and Subscriber Session Store feature, in multiples of 2MB. 
        Note: If you later reduce the value of this parameter, the amount of active memory is not reduced. Changing the configured memory limit can only increase the amount of active memory.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateExtendedmemoryparam 
        An example how to update extendedmemoryparam configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateExtendedmemoryparam
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/extendedmemoryparam/
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

        [double]$Memlimit 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateExtendedmemoryparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('memlimit') ) { $payload.Add('memlimit', $memlimit) }
            if ( $PSCmdlet.ShouldProcess("extendedmemoryparam", "Update Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type extendedmemoryparam -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateExtendedmemoryparam: Finished"
    }
}

function Invoke-ADCUnsetExtendedmemoryparam {
    <#
    .SYNOPSIS
        Unset Basic configuration Object.
    .DESCRIPTION
        Configuration for Parameter for extended memory used by LSN and Subscriber Store resource.
    .PARAMETER Memlimit 
        Amount of Citrix ADC memory to reserve for the memory used by LSN and Subscriber Session Store feature, in multiples of 2MB. 
        Note: If you later reduce the value of this parameter, the amount of active memory is not reduced. Changing the configured memory limit can only increase the amount of active memory.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetExtendedmemoryparam 
        An example how to unset extendedmemoryparam configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetExtendedmemoryparam
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/extendedmemoryparam
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

        [Boolean]$memlimit 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetExtendedmemoryparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('memlimit') ) { $payload.Add('memlimit', $memlimit) }
            if ( $PSCmdlet.ShouldProcess("extendedmemoryparam", "Unset Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type extendedmemoryparam -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetExtendedmemoryparam: Finished"
    }
}

function Invoke-ADCGetExtendedmemoryparam {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Configuration for Parameter for extended memory used by LSN and Subscriber Store resource.
    .PARAMETER GetAll 
        Retrieve all extendedmemoryparam object(s).
    .PARAMETER Count
        If specified, the count of the extendedmemoryparam object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetExtendedmemoryparam
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetExtendedmemoryparam -GetAll 
        Get all extendedmemoryparam data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetExtendedmemoryparam -name <string>
        Get extendedmemoryparam object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetExtendedmemoryparam -Filter @{ 'name'='<value>' }
        Get extendedmemoryparam data with a filter.
    .NOTES
        File Name : Invoke-ADCGetExtendedmemoryparam
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/extendedmemoryparam/
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
        Write-Verbose "Invoke-ADCGetExtendedmemoryparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all extendedmemoryparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type extendedmemoryparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for extendedmemoryparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type extendedmemoryparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving extendedmemoryparam objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type extendedmemoryparam -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving extendedmemoryparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving extendedmemoryparam configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type extendedmemoryparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetExtendedmemoryparam: Ended"
    }
}

function Invoke-ADCAddLocation {
    <#
    .SYNOPSIS
        Add Basic configuration Object.
    .DESCRIPTION
        Configuration for location resource.
    .PARAMETER Ipfrom 
        First IP address in the range, in dotted decimal notation. 
    .PARAMETER Ipto 
        Last IP address in the range, in dotted decimal notation. 
    .PARAMETER Preferredlocation 
        String of qualifiers, in dotted notation, describing the geographical location of the IP address range. Each qualifier is more specific than the one that precedes it, as in continent.country.region.city.isp.organization. For example, "NA.US.CA.San Jose.ATT.citrix". 
        Note: A qualifier that includes a dot (.) or space ( ) must be enclosed in double quotation marks. 
    .PARAMETER Longitude 
        Numerical value, in degrees, specifying the longitude of the geographical location of the IP address-range. 
        Note: Longitude and latitude parameters are used for selecting a service with the static proximity GSLB method. If they are not specified, selection is based on the qualifiers specified for the location. 
    .PARAMETER Latitude 
        Numerical value, in degrees, specifying the latitude of the geographical location of the IP address-range. 
        Note: Longitude and latitude parameters are used for selecting a service with the static proximity GSLB method. If they are not specified, selection is based on the qualifiers specified for the location. 
    .PARAMETER PassThru 
        Return details about the created location item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLocation -ipfrom <string> -ipto <string> -preferredlocation <string>
        An example how to add location configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLocation
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/location/
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
        [string]$Ipfrom,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipto,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Preferredlocation,

        [ValidateRange(-180, 180)]
        [int]$Longitude,

        [ValidateRange(-90, 90)]
        [int]$Latitude,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLocation: Starting"
    }
    process {
        try {
            $payload = @{ ipfrom  = $ipfrom
                ipto              = $ipto
                preferredlocation = $preferredlocation
            }
            if ( $PSBoundParameters.ContainsKey('longitude') ) { $payload.Add('longitude', $longitude) }
            if ( $PSBoundParameters.ContainsKey('latitude') ) { $payload.Add('latitude', $latitude) }
            if ( $PSCmdlet.ShouldProcess("location", "Add Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type location -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLocation -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLocation: Finished"
    }
}

function Invoke-ADCDeleteLocation {
    <#
    .SYNOPSIS
        Delete Basic configuration Object.
    .DESCRIPTION
        Configuration for location resource.
    .PARAMETER Ipfrom 
        First IP address in the range, in dotted decimal notation. 
    .PARAMETER Ipto 
        Last IP address in the range, in dotted decimal notation.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLocation -Ipfrom <string>
        An example how to delete location configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLocation
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/location/
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
        [string]$Ipfrom,

        [string]$Ipto 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLocation: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ipto') ) { $arguments.Add('ipto', $Ipto) }
            if ( $PSCmdlet.ShouldProcess("$ipfrom", "Delete Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type location -NitroPath nitro/v1/config -Resource $ipfrom -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLocation: Finished"
    }
}

function Invoke-ADCGetLocation {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Configuration for location resource.
    .PARAMETER Ipfrom 
        First IP address in the range, in dotted decimal notation. 
    .PARAMETER GetAll 
        Retrieve all location object(s).
    .PARAMETER Count
        If specified, the count of the location object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLocation
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLocation -GetAll 
        Get all location data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLocation -Count 
        Get the number of location objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLocation -name <string>
        Get location object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLocation -Filter @{ 'name'='<value>' }
        Get location data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLocation
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/location/
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
        [string]$Ipfrom,

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
        Write-Verbose "Invoke-ADCGetLocation: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all location objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type location -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for location objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type location -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving location objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type location -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving location configuration for property 'ipfrom'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type location -NitroPath nitro/v1/config -Resource $ipfrom -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving location configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type location -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLocation: Ended"
    }
}

function Invoke-ADCImportLocationfile {
    <#
    .SYNOPSIS
        Import Basic configuration Object.
    .DESCRIPTION
        Configuration for location file resource.
    .PARAMETER Locationfile 
        Name of the location file, with or without absolute path. If the path is not included, the default path (/var/netscaler/locdb) is assumed. In a high availability setup, the static database must be stored in the same location on both Citrix ADCs. 
    .PARAMETER Src 
        URL \(protocol, host, path, and file name\) from where the location file will be imported. 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access.
    .EXAMPLE
        PS C:\>Invoke-ADCImportLocationfile -Locationfile <string> -src <string>
        An example how to import locationfile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCImportLocationfile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationfile/
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
        [string]$Locationfile,

        [Parameter(Mandatory)]
        [ValidateLength(1, 2047)]
        [string]$Src 

    )
    begin {
        Write-Verbose "Invoke-ADCImportLocationfile: Starting"
    }
    process {
        try {
            $payload = @{ Locationfile = $Locationfile
                src                    = $src
            }

            if ( $PSCmdlet.ShouldProcess($Name, "Import Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type locationfile -Action import -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportLocationfile: Finished"
    }
}

function Invoke-ADCAddLocationfile {
    <#
    .SYNOPSIS
        Add Basic configuration Object.
    .DESCRIPTION
        Configuration for location file resource.
    .PARAMETER Locationfile 
        Name of the location file, with or without absolute path. If the path is not included, the default path (/var/netscaler/locdb) is assumed. In a high availability setup, the static database must be stored in the same location on both Citrix ADCs. 
    .PARAMETER Format 
        Format of the location file. Required for the Citrix ADC to identify how to read the location file. 
        Possible values = netscaler, ip-country, ip-country-isp, ip-country-region-city, ip-country-region-city-isp, geoip-country, geoip-region, geoip-city, geoip-country-org, geoip-country-isp, geoip-city-isp-org
    .EXAMPLE
        PS C:\>Invoke-ADCAddLocationfile -Locationfile <string>
        An example how to add locationfile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLocationfile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationfile/
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
        [string]$Locationfile,

        [ValidateSet('netscaler', 'ip-country', 'ip-country-isp', 'ip-country-region-city', 'ip-country-region-city-isp', 'geoip-country', 'geoip-region', 'geoip-city', 'geoip-country-org', 'geoip-country-isp', 'geoip-city-isp-org')]
        [string]$Format = 'netscaler' 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLocationfile: Starting"
    }
    process {
        try {
            $payload = @{ Locationfile = $Locationfile }
            if ( $PSBoundParameters.ContainsKey('format') ) { $payload.Add('format', $format) }
            if ( $PSCmdlet.ShouldProcess("locationfile", "Add Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type locationfile -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCAddLocationfile: Finished"
    }
}

function Invoke-ADCDeleteLocationfile {
    <#
    .SYNOPSIS
        Delete Basic configuration Object.
    .DESCRIPTION
        Configuration for location file resource.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLocationfile 
        An example how to delete locationfile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLocationfile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationfile/
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
        Write-Verbose "Invoke-ADCDeleteLocationfile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("locationfile", "Delete Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type locationfile -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLocationfile: Finished"
    }
}

function Invoke-ADCGetLocationfile {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Configuration for location file resource.
    .PARAMETER GetAll 
        Retrieve all locationfile object(s).
    .PARAMETER Count
        If specified, the count of the locationfile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLocationfile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLocationfile -GetAll 
        Get all locationfile data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLocationfile -name <string>
        Get locationfile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLocationfile -Filter @{ 'name'='<value>' }
        Get locationfile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLocationfile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationfile/
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
        Write-Verbose "Invoke-ADCGetLocationfile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all locationfile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationfile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for locationfile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationfile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving locationfile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationfile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving locationfile configuration for property ''"

            } else {
                Write-Verbose "Retrieving locationfile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationfile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLocationfile: Ended"
    }
}

function Invoke-ADCImportLocationfile6 {
    <#
    .SYNOPSIS
        Import Basic configuration Object.
    .DESCRIPTION
        Configuration for location file6 resource.
    .PARAMETER Locationfile 
        Name of the IPv6 location file, with or without absolute path. If the path is not included, the default path (/var/netscaler/locdb) is assumed. In a high availability setup, the static database must be stored in the same location on both Citrix ADCs. 
    .PARAMETER Src 
        URL \(protocol, host, path, and file name\) from where the location file will be imported. 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access.
    .EXAMPLE
        PS C:\>Invoke-ADCImportLocationfile6 -Locationfile <string> -src <string>
        An example how to import locationfile6 configuration Object(s).
    .NOTES
        File Name : Invoke-ADCImportLocationfile6
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationfile6/
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
        [string]$Locationfile,

        [Parameter(Mandatory)]
        [ValidateLength(1, 2047)]
        [string]$Src 

    )
    begin {
        Write-Verbose "Invoke-ADCImportLocationfile6: Starting"
    }
    process {
        try {
            $payload = @{ Locationfile = $Locationfile
                src                    = $src
            }

            if ( $PSCmdlet.ShouldProcess($Name, "Import Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type locationfile6 -Action import -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportLocationfile6: Finished"
    }
}

function Invoke-ADCDeleteLocationfile6 {
    <#
    .SYNOPSIS
        Delete Basic configuration Object.
    .DESCRIPTION
        Configuration for location file6 resource.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLocationfile6 
        An example how to delete locationfile6 configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLocationfile6
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationfile6/
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
        Write-Verbose "Invoke-ADCDeleteLocationfile6: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("locationfile6", "Delete Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type locationfile6 -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLocationfile6: Finished"
    }
}

function Invoke-ADCAddLocationfile6 {
    <#
    .SYNOPSIS
        Add Basic configuration Object.
    .DESCRIPTION
        Configuration for location file6 resource.
    .PARAMETER Locationfile 
        Name of the IPv6 location file, with or without absolute path. If the path is not included, the default path (/var/netscaler/locdb) is assumed. In a high availability setup, the static database must be stored in the same location on both Citrix ADCs. 
    .PARAMETER Format 
        Format of the IPv6 location file. Required for the Citrix ADC to identify how to read the location file. 
        Possible values = netscaler6, geoip-country6
    .EXAMPLE
        PS C:\>Invoke-ADCAddLocationfile6 -Locationfile <string>
        An example how to add locationfile6 configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLocationfile6
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationfile6/
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
        [string]$Locationfile,

        [ValidateSet('netscaler6', 'geoip-country6')]
        [string]$Format = 'netscaler6' 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLocationfile6: Starting"
    }
    process {
        try {
            $payload = @{ Locationfile = $Locationfile }
            if ( $PSBoundParameters.ContainsKey('format') ) { $payload.Add('format', $format) }
            if ( $PSCmdlet.ShouldProcess("locationfile6", "Add Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type locationfile6 -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCAddLocationfile6: Finished"
    }
}

function Invoke-ADCGetLocationfile6 {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Configuration for location file6 resource.
    .PARAMETER GetAll 
        Retrieve all locationfile6 object(s).
    .PARAMETER Count
        If specified, the count of the locationfile6 object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLocationfile6
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLocationfile6 -GetAll 
        Get all locationfile6 data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLocationfile6 -Count 
        Get the number of locationfile6 objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLocationfile6 -name <string>
        Get locationfile6 object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLocationfile6 -Filter @{ 'name'='<value>' }
        Get locationfile6 data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLocationfile6
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationfile6/
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
        Write-Verbose "Invoke-ADCGetLocationfile6: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all locationfile6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationfile6 -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for locationfile6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationfile6 -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving locationfile6 objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationfile6 -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving locationfile6 configuration for property ''"

            } else {
                Write-Verbose "Retrieving locationfile6 configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationfile6 -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLocationfile6: Ended"
    }
}

function Invoke-ADCUnsetLocationparameter {
    <#
    .SYNOPSIS
        Unset Basic configuration Object.
    .DESCRIPTION
        Configuration for location parameter resource.
    .PARAMETER Context 
        Context for describing locations. In geographic context, qualifier labels are assigned by default in the following sequence: Continent.Country.Region.City.ISP.Organization. In custom context, the qualifiers labels can have any meaning that you designate. 
        Possible values = geographic, custom 
    .PARAMETER Q1label 
        Label specifying the meaning of the first qualifier. Can be specified for custom context only. 
    .PARAMETER Q2label 
        Label specifying the meaning of the second qualifier. Can be specified for custom context only. 
    .PARAMETER Q3label 
        Label specifying the meaning of the third qualifier. Can be specified for custom context only. 
    .PARAMETER Q4label 
        Label specifying the meaning of the fourth qualifier. Can be specified for custom context only. 
    .PARAMETER Q5label 
        Label specifying the meaning of the fifth qualifier. Can be specified for custom context only. 
    .PARAMETER Q6label 
        Label specifying the meaning of the sixth qualifier. Can be specified for custom context only. 
    .PARAMETER Matchwildcardtoany 
        Indicates whether wildcard qualifiers should match any other 
        qualifier including non-wildcard while evaluating 
        location based expressions. 
        Possible values: Yes, No, Expression. 
        Yes - Wildcard qualifiers match any other qualifiers. 
        No - Wildcard qualifiers do not match non-wildcard 
        qualifiers, but match other wildcard qualifiers. 
        Expression - Wildcard qualifiers in an expression 
        match any qualifier in an LDNS location, 
        wildcard qualifiers in the LDNS location do not match 
        non-wildcard qualifiers in an expression. 
        Possible values = YES, NO, Expression
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLocationparameter 
        An example how to unset locationparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLocationparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationparameter
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

        [Boolean]$context,

        [Boolean]$q1label,

        [Boolean]$q2label,

        [Boolean]$q3label,

        [Boolean]$q4label,

        [Boolean]$q5label,

        [Boolean]$q6label,

        [Boolean]$matchwildcardtoany 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLocationparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('context') ) { $payload.Add('context', $context) }
            if ( $PSBoundParameters.ContainsKey('q1label') ) { $payload.Add('q1label', $q1label) }
            if ( $PSBoundParameters.ContainsKey('q2label') ) { $payload.Add('q2label', $q2label) }
            if ( $PSBoundParameters.ContainsKey('q3label') ) { $payload.Add('q3label', $q3label) }
            if ( $PSBoundParameters.ContainsKey('q4label') ) { $payload.Add('q4label', $q4label) }
            if ( $PSBoundParameters.ContainsKey('q5label') ) { $payload.Add('q5label', $q5label) }
            if ( $PSBoundParameters.ContainsKey('q6label') ) { $payload.Add('q6label', $q6label) }
            if ( $PSBoundParameters.ContainsKey('matchwildcardtoany') ) { $payload.Add('matchwildcardtoany', $matchwildcardtoany) }
            if ( $PSCmdlet.ShouldProcess("locationparameter", "Unset Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type locationparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLocationparameter: Finished"
    }
}

function Invoke-ADCUpdateLocationparameter {
    <#
    .SYNOPSIS
        Update Basic configuration Object.
    .DESCRIPTION
        Configuration for location parameter resource.
    .PARAMETER Context 
        Context for describing locations. In geographic context, qualifier labels are assigned by default in the following sequence: Continent.Country.Region.City.ISP.Organization. In custom context, the qualifiers labels can have any meaning that you designate. 
        Possible values = geographic, custom 
    .PARAMETER Q1label 
        Label specifying the meaning of the first qualifier. Can be specified for custom context only. 
    .PARAMETER Q2label 
        Label specifying the meaning of the second qualifier. Can be specified for custom context only. 
    .PARAMETER Q3label 
        Label specifying the meaning of the third qualifier. Can be specified for custom context only. 
    .PARAMETER Q4label 
        Label specifying the meaning of the fourth qualifier. Can be specified for custom context only. 
    .PARAMETER Q5label 
        Label specifying the meaning of the fifth qualifier. Can be specified for custom context only. 
    .PARAMETER Q6label 
        Label specifying the meaning of the sixth qualifier. Can be specified for custom context only. 
    .PARAMETER Matchwildcardtoany 
        Indicates whether wildcard qualifiers should match any other 
        qualifier including non-wildcard while evaluating 
        location based expressions. 
        Possible values: Yes, No, Expression. 
        Yes - Wildcard qualifiers match any other qualifiers. 
        No - Wildcard qualifiers do not match non-wildcard 
        qualifiers, but match other wildcard qualifiers. 
        Expression - Wildcard qualifiers in an expression 
        match any qualifier in an LDNS location, 
        wildcard qualifiers in the LDNS location do not match 
        non-wildcard qualifiers in an expression. 
        Possible values = YES, NO, Expression
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLocationparameter 
        An example how to update locationparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLocationparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationparameter/
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

        [ValidateSet('geographic', 'custom')]
        [string]$Context,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Q1label,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Q2label,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Q3label,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Q4label,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Q5label,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Q6label,

        [ValidateSet('YES', 'NO', 'Expression')]
        [string]$Matchwildcardtoany 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLocationparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('context') ) { $payload.Add('context', $context) }
            if ( $PSBoundParameters.ContainsKey('q1label') ) { $payload.Add('q1label', $q1label) }
            if ( $PSBoundParameters.ContainsKey('q2label') ) { $payload.Add('q2label', $q2label) }
            if ( $PSBoundParameters.ContainsKey('q3label') ) { $payload.Add('q3label', $q3label) }
            if ( $PSBoundParameters.ContainsKey('q4label') ) { $payload.Add('q4label', $q4label) }
            if ( $PSBoundParameters.ContainsKey('q5label') ) { $payload.Add('q5label', $q5label) }
            if ( $PSBoundParameters.ContainsKey('q6label') ) { $payload.Add('q6label', $q6label) }
            if ( $PSBoundParameters.ContainsKey('matchwildcardtoany') ) { $payload.Add('matchwildcardtoany', $matchwildcardtoany) }
            if ( $PSCmdlet.ShouldProcess("locationparameter", "Update Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type locationparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateLocationparameter: Finished"
    }
}

function Invoke-ADCGetLocationparameter {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Configuration for location parameter resource.
    .PARAMETER GetAll 
        Retrieve all locationparameter object(s).
    .PARAMETER Count
        If specified, the count of the locationparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLocationparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLocationparameter -GetAll 
        Get all locationparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLocationparameter -name <string>
        Get locationparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLocationparameter -Filter @{ 'name'='<value>' }
        Get locationparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLocationparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationparameter/
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
        Write-Verbose "Invoke-ADCGetLocationparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all locationparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for locationparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving locationparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving locationparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving locationparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLocationparameter: Ended"
    }
}

function Invoke-ADCGetNstrace {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Configuration for nstrace operations resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retrieve all nstrace object(s).
    .PARAMETER Count
        If specified, the count of the nstrace object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNstrace
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetNstrace -GetAll 
        Get all nstrace data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNstrace -name <string>
        Get nstrace object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNstrace -Filter @{ 'name'='<value>' }
        Get nstrace data with a filter.
    .NOTES
        File Name : Invoke-ADCGetNstrace
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/nstrace/
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
        [ValidateRange(0, 31)]
        [double]$Nodeid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetNstrace: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all nstrace objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nstrace -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nstrace objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nstrace -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nstrace objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nstrace -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nstrace configuration for property ''"

            } else {
                Write-Verbose "Retrieving nstrace configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nstrace -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetNstrace: Ended"
    }
}

function Invoke-ADCDeleteRadiusnode {
    <#
    .SYNOPSIS
        Delete Basic configuration Object.
    .DESCRIPTION
        Configuration for RADIUS Node resource.
    .PARAMETER Nodeprefix 
        IP address/IP prefix of radius node in CIDR format.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteRadiusnode -Nodeprefix <string>
        An example how to delete radiusnode configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteRadiusnode
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/radiusnode/
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
        [string]$Nodeprefix 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteRadiusnode: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$nodeprefix", "Delete Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type radiusnode -NitroPath nitro/v1/config -Resource $nodeprefix -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteRadiusnode: Finished"
    }
}

function Invoke-ADCUpdateRadiusnode {
    <#
    .SYNOPSIS
        Update Basic configuration Object.
    .DESCRIPTION
        Configuration for RADIUS Node resource.
    .PARAMETER Nodeprefix 
        IP address/IP prefix of radius node in CIDR format. 
    .PARAMETER Radkey 
        The key shared between the RADIUS server and clients. 
        Required for Citrix ADC to communicate with the RADIUS nodes. 
    .PARAMETER PassThru 
        Return details about the created radiusnode item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateRadiusnode -nodeprefix <string>
        An example how to update radiusnode configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateRadiusnode
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/radiusnode/
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
        [string]$Nodeprefix,

        [string]$Radkey,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateRadiusnode: Starting"
    }
    process {
        try {
            $payload = @{ nodeprefix = $nodeprefix }
            if ( $PSBoundParameters.ContainsKey('radkey') ) { $payload.Add('radkey', $radkey) }
            if ( $PSCmdlet.ShouldProcess("radiusnode", "Update Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type radiusnode -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetRadiusnode -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateRadiusnode: Finished"
    }
}

function Invoke-ADCAddRadiusnode {
    <#
    .SYNOPSIS
        Add Basic configuration Object.
    .DESCRIPTION
        Configuration for RADIUS Node resource.
    .PARAMETER Nodeprefix 
        IP address/IP prefix of radius node in CIDR format. 
    .PARAMETER Radkey 
        The key shared between the RADIUS server and clients. 
        Required for Citrix ADC to communicate with the RADIUS nodes. 
    .PARAMETER PassThru 
        Return details about the created radiusnode item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddRadiusnode -nodeprefix <string> -radkey <string>
        An example how to add radiusnode configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddRadiusnode
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/radiusnode/
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
        [string]$Nodeprefix,

        [Parameter(Mandatory)]
        [string]$Radkey,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddRadiusnode: Starting"
    }
    process {
        try {
            $payload = @{ nodeprefix = $nodeprefix
                radkey               = $radkey
            }

            if ( $PSCmdlet.ShouldProcess("radiusnode", "Add Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type radiusnode -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetRadiusnode -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddRadiusnode: Finished"
    }
}

function Invoke-ADCGetRadiusnode {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Configuration for RADIUS Node resource.
    .PARAMETER Nodeprefix 
        IP address/IP prefix of radius node in CIDR format. 
    .PARAMETER GetAll 
        Retrieve all radiusnode object(s).
    .PARAMETER Count
        If specified, the count of the radiusnode object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRadiusnode
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRadiusnode -GetAll 
        Get all radiusnode data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRadiusnode -Count 
        Get the number of radiusnode objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRadiusnode -name <string>
        Get radiusnode object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRadiusnode -Filter @{ 'name'='<value>' }
        Get radiusnode data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRadiusnode
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/radiusnode/
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
        [string]$Nodeprefix,

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
        Write-Verbose "Invoke-ADCGetRadiusnode: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all radiusnode objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type radiusnode -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for radiusnode objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type radiusnode -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving radiusnode objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type radiusnode -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving radiusnode configuration for property 'nodeprefix'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type radiusnode -NitroPath nitro/v1/config -Resource $nodeprefix -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving radiusnode configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type radiusnode -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRadiusnode: Ended"
    }
}

function Invoke-ADCDisableReporting {
    <#
    .SYNOPSIS
        Disable Basic configuration Object.
    .DESCRIPTION
        Configuration for reporting resource.
    .EXAMPLE
        PS C:\>Invoke-ADCDisableReporting 
        An example how to disable reporting configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDisableReporting
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/reporting/
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
        Write-Verbose "Invoke-ADCDisableReporting: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type reporting -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCDisableReporting: Finished"
    }
}

function Invoke-ADCEnableReporting {
    <#
    .SYNOPSIS
        Enable Basic configuration Object.
    .DESCRIPTION
        Configuration for reporting resource.
    .EXAMPLE
        PS C:\>Invoke-ADCEnableReporting 
        An example how to enable reporting configuration Object(s).
    .NOTES
        File Name : Invoke-ADCEnableReporting
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/reporting/
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
        Write-Verbose "Invoke-ADCEnableReporting: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type reporting -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCEnableReporting: Finished"
    }
}

function Invoke-ADCGetReporting {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Configuration for reporting resource.
    .PARAMETER GetAll 
        Retrieve all reporting object(s).
    .PARAMETER Count
        If specified, the count of the reporting object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetReporting
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetReporting -GetAll 
        Get all reporting data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetReporting -name <string>
        Get reporting object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetReporting -Filter @{ 'name'='<value>' }
        Get reporting data with a filter.
    .NOTES
        File Name : Invoke-ADCGetReporting
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/reporting/
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
        Write-Verbose "Invoke-ADCGetReporting: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all reporting objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type reporting -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for reporting objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type reporting -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving reporting objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type reporting -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving reporting configuration for property ''"

            } else {
                Write-Verbose "Retrieving reporting configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type reporting -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetReporting: Ended"
    }
}

function Invoke-ADCRenameServer {
    <#
    .SYNOPSIS
        Rename Basic configuration Object.
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the server. 
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the name is created. 
    .PARAMETER Newname 
        New name for the server. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created server item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameServer -name <string> -newname <string>
        An example how to rename server configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameServer
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameServer: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("server", "Rename Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type server -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetServer -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameServer: Finished"
    }
}

function Invoke-ADCDisableServer {
    <#
    .SYNOPSIS
        Disable Basic configuration Object.
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the server. 
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the name is created. 
    .PARAMETER Delay 
        Time, in seconds, after which all the services configured on the server are disabled. 
    .PARAMETER Graceful 
        Shut down gracefully, without accepting any new connections, and disabling each service when all of its connections are closed. 
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-ADCDisableServer -name <string>
        An example how to disable server configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDisableServer
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server/
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

        [double]$Delay,

        [ValidateSet('YES', 'NO')]
        [string]$Graceful 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableServer: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('graceful') ) { $payload.Add('graceful', $graceful) }
            if ( $PSCmdlet.ShouldProcess($Name, "Disable Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type server -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCDisableServer: Finished"
    }
}

function Invoke-ADCEnableServer {
    <#
    .SYNOPSIS
        Enable Basic configuration Object.
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the server. 
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the name is created.
    .EXAMPLE
        PS C:\>Invoke-ADCEnableServer -name <string>
        An example how to enable server configuration Object(s).
    .NOTES
        File Name : Invoke-ADCEnableServer
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server/
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
        [string]$Name 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableServer: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type server -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCEnableServer: Finished"
    }
}

function Invoke-ADCUnsetServer {
    <#
    .SYNOPSIS
        Unset Basic configuration Object.
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the server. 
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the name is created. 
    .PARAMETER Comment 
        Any information about the server.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetServer -name <string>
        An example how to unset server configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetServer
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server
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
        Write-Verbose "Invoke-ADCUnsetServer: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type server -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetServer: Finished"
    }
}

function Invoke-ADCUpdateServer {
    <#
    .SYNOPSIS
        Update Basic configuration Object.
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the server. 
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the name is created. 
    .PARAMETER Ipaddress 
        IPv4 or IPv6 address of the server. If you create an IP address based server, you can specify the name of the server, instead of its IP address, when creating a service. Note: If you do not create a server entry, the server IP address that you enter when you create a service becomes the name of the server. 
    .PARAMETER Domainresolveretry 
        Time, in seconds, for which the Citrix ADC must wait, after DNS resolution fails, before sending the next DNS query to resolve the domain name. 
    .PARAMETER Translationip 
        IP address used to transform the server's DNS-resolved IP address. 
    .PARAMETER Translationmask 
        The netmask of the translation ip. 
    .PARAMETER Domainresolvenow 
        Immediately send a DNS query to resolve the server's domain name. 
    .PARAMETER Comment 
        Any information about the server. 
    .PARAMETER PassThru 
        Return details about the created server item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateServer -name <string>
        An example how to update server configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateServer
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server/
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

        [ValidateRange(5, 20939)]
        [int]$Domainresolveretry,

        [string]$Translationip,

        [string]$Translationmask,

        [boolean]$Domainresolvenow,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateServer: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('domainresolveretry') ) { $payload.Add('domainresolveretry', $domainresolveretry) }
            if ( $PSBoundParameters.ContainsKey('translationip') ) { $payload.Add('translationip', $translationip) }
            if ( $PSBoundParameters.ContainsKey('translationmask') ) { $payload.Add('translationmask', $translationmask) }
            if ( $PSBoundParameters.ContainsKey('domainresolvenow') ) { $payload.Add('domainresolvenow', $domainresolvenow) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("server", "Update Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type server -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetServer -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateServer: Finished"
    }
}

function Invoke-ADCAddServer {
    <#
    .SYNOPSIS
        Add Basic configuration Object.
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the server. 
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the name is created. 
    .PARAMETER Ipaddress 
        IPv4 or IPv6 address of the server. If you create an IP address based server, you can specify the name of the server, instead of its IP address, when creating a service. Note: If you do not create a server entry, the server IP address that you enter when you create a service becomes the name of the server. 
    .PARAMETER Domain 
        Domain name of the server. For a domain based configuration, you must create the server first. 
    .PARAMETER Translationip 
        IP address used to transform the server's DNS-resolved IP address. 
    .PARAMETER Translationmask 
        The netmask of the translation ip. 
    .PARAMETER Domainresolveretry 
        Time, in seconds, for which the Citrix ADC must wait, after DNS resolution fails, before sending the next DNS query to resolve the domain name. 
    .PARAMETER State 
        Initial state of the server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ipv6address 
        Support IPv6 addressing mode. If you configure a server with the IPv6 addressing mode, you cannot use the server in the IPv4 addressing mode. 
        Possible values = YES, NO 
    .PARAMETER Comment 
        Any information about the server. 
    .PARAMETER Td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0. 
    .PARAMETER Querytype 
        Specify the type of DNS resolution to be done on the configured domain to get the backend services. Valid query types are A, AAAA and SRV with A being the default querytype. The type of DNS resolution done on the domains in SRV records is inherited from ipv6 argument. 
        Possible values = A, AAAA, SRV 
    .PARAMETER PassThru 
        Return details about the created server item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddServer -name <string>
        An example how to add server configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddServer
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [string]$Translationip,

        [string]$Translationmask,

        [ValidateRange(5, 20939)]
        [int]$Domainresolveretry = '5',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('YES', 'NO')]
        [string]$Ipv6address = 'NO',

        [string]$Comment,

        [ValidateRange(0, 4094)]
        [double]$Td,

        [ValidateSet('A', 'AAAA', 'SRV')]
        [string]$Querytype = 'A',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddServer: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('domain') ) { $payload.Add('domain', $domain) }
            if ( $PSBoundParameters.ContainsKey('translationip') ) { $payload.Add('translationip', $translationip) }
            if ( $PSBoundParameters.ContainsKey('translationmask') ) { $payload.Add('translationmask', $translationmask) }
            if ( $PSBoundParameters.ContainsKey('domainresolveretry') ) { $payload.Add('domainresolveretry', $domainresolveretry) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('ipv6address') ) { $payload.Add('ipv6address', $ipv6address) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('querytype') ) { $payload.Add('querytype', $querytype) }
            if ( $PSCmdlet.ShouldProcess("server", "Add Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type server -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetServer -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddServer: Finished"
    }
}

function Invoke-ADCDeleteServer {
    <#
    .SYNOPSIS
        Delete Basic configuration Object.
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the server. 
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the name is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteServer -Name <string>
        An example how to delete server configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteServer
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server/
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
        Write-Verbose "Invoke-ADCDeleteServer: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type server -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteServer: Finished"
    }
}

function Invoke-ADCGetServer {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the server. 
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Can be changed after the name is created. 
    .PARAMETER GetAll 
        Retrieve all server object(s).
    .PARAMETER Count
        If specified, the count of the server object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServer
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServer -GetAll 
        Get all server data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServer -Count 
        Get the number of server objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServer -name <string>
        Get server object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServer -Filter @{ 'name'='<value>' }
        Get server data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServer
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server/
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
        Write-Verbose "Invoke-ADCGetServer: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all server objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for server objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving server objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving server configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving server configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServer: Ended"
    }
}

function Invoke-ADCGetServerbinding {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to server.
    .PARAMETER Name 
        Name of the server for which to display parameters. 
    .PARAMETER GetAll 
        Retrieve all server_binding object(s).
    .PARAMETER Count
        If specified, the count of the server_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServerbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServerbinding -GetAll 
        Get all server_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServerbinding -name <string>
        Get server_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServerbinding -Filter @{ 'name'='<value>' }
        Get server_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServerbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server_binding/
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
        Write-Verbose "Invoke-ADCGetServerbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all server_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for server_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving server_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving server_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving server_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServerbinding: Ended"
    }
}

function Invoke-ADCGetServergslbservicegroupbinding {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbservicegroup that can be bound to server.
    .PARAMETER Name 
        Name of the server for which to display parameters. 
    .PARAMETER GetAll 
        Retrieve all server_gslbservicegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the server_gslbservicegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServergslbservicegroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServergslbservicegroupbinding -GetAll 
        Get all server_gslbservicegroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServergslbservicegroupbinding -Count 
        Get the number of server_gslbservicegroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServergslbservicegroupbinding -name <string>
        Get server_gslbservicegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServergslbservicegroupbinding -Filter @{ 'name'='<value>' }
        Get server_gslbservicegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServergslbservicegroupbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server_gslbservicegroup_binding/
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
        Write-Verbose "Invoke-ADCGetServergslbservicegroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all server_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for server_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving server_gslbservicegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservicegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving server_gslbservicegroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservicegroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving server_gslbservicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServergslbservicegroupbinding: Ended"
    }
}

function Invoke-ADCGetServergslbservicebinding {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbservice that can be bound to server.
    .PARAMETER Name 
        Name of the server for which to display parameters. 
    .PARAMETER GetAll 
        Retrieve all server_gslbservice_binding object(s).
    .PARAMETER Count
        If specified, the count of the server_gslbservice_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServergslbservicebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServergslbservicebinding -GetAll 
        Get all server_gslbservice_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServergslbservicebinding -Count 
        Get the number of server_gslbservice_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServergslbservicebinding -name <string>
        Get server_gslbservice_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServergslbservicebinding -Filter @{ 'name'='<value>' }
        Get server_gslbservice_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServergslbservicebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server_gslbservice_binding/
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
        Write-Verbose "Invoke-ADCGetServergslbservicebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all server_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for server_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving server_gslbservice_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservice_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving server_gslbservice_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservice_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving server_gslbservice_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservice_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServergslbservicebinding: Ended"
    }
}

function Invoke-ADCGetServerservicegroupbinding {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Binding object showing the servicegroup that can be bound to server.
    .PARAMETER Name 
        Name of the server for which to display parameters. 
    .PARAMETER GetAll 
        Retrieve all server_servicegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the server_servicegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServerservicegroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServerservicegroupbinding -GetAll 
        Get all server_servicegroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServerservicegroupbinding -Count 
        Get the number of server_servicegroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServerservicegroupbinding -name <string>
        Get server_servicegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServerservicegroupbinding -Filter @{ 'name'='<value>' }
        Get server_servicegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServerservicegroupbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server_servicegroup_binding/
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
        Write-Verbose "Invoke-ADCGetServerservicegroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all server_servicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_servicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for server_servicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_servicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving server_servicegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_servicegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving server_servicegroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_servicegroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving server_servicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_servicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServerservicegroupbinding: Ended"
    }
}

function Invoke-ADCGetServerservicebinding {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Binding object showing the service that can be bound to server.
    .PARAMETER Name 
        Name of the server for which to display parameters. 
    .PARAMETER GetAll 
        Retrieve all server_service_binding object(s).
    .PARAMETER Count
        If specified, the count of the server_service_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServerservicebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServerservicebinding -GetAll 
        Get all server_service_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServerservicebinding -Count 
        Get the number of server_service_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServerservicebinding -name <string>
        Get server_service_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServerservicebinding -Filter @{ 'name'='<value>' }
        Get server_service_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServerservicebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server_service_binding/
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
        Write-Verbose "Invoke-ADCGetServerservicebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all server_service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_service_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for server_service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_service_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving server_service_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_service_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving server_service_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_service_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving server_service_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_service_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServerservicebinding: Ended"
    }
}

function Invoke-ADCRenameService {
    <#
    .SYNOPSIS
        Rename Basic configuration Object.
    .DESCRIPTION
        Configuration for service resource.
    .PARAMETER Name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created. 
    .PARAMETER Newname 
        New name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created service item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameService -name <string> -newname <string>
        An example how to rename service configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameService
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameService: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("service", "Rename Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type service -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetService -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameService: Finished"
    }
}

function Invoke-ADCEnableService {
    <#
    .SYNOPSIS
        Enable Basic configuration Object.
    .DESCRIPTION
        Configuration for service resource.
    .PARAMETER Name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created.
    .EXAMPLE
        PS C:\>Invoke-ADCEnableService -name <string>
        An example how to enable service configuration Object(s).
    .NOTES
        File Name : Invoke-ADCEnableService
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service/
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
        [string]$Name 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableService: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type service -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCEnableService: Finished"
    }
}

function Invoke-ADCDisableService {
    <#
    .SYNOPSIS
        Disable Basic configuration Object.
    .DESCRIPTION
        Configuration for service resource.
    .PARAMETER Name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created. 
    .PARAMETER Delay 
        Time, in seconds, allocated to the Citrix ADC for a graceful shutdown of the service. During this period, new requests are sent to the service only for clients who already have persistent sessions on the appliance. Requests from new clients are load balanced among other available services. After the delay time expires, no requests are sent to the service, and the service is marked as unavailable (OUT OF SERVICE). 
    .PARAMETER Graceful 
        Shut down gracefully, not accepting any new connections, and disabling the service when all of its connections are closed. 
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-ADCDisableService -name <string>
        An example how to disable service configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDisableService
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service/
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

        [double]$Delay,

        [ValidateSet('YES', 'NO')]
        [string]$Graceful 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableService: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('graceful') ) { $payload.Add('graceful', $graceful) }
            if ( $PSCmdlet.ShouldProcess($Name, "Disable Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type service -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCDisableService: Finished"
    }
}

function Invoke-ADCUnsetService {
    <#
    .SYNOPSIS
        Unset Basic configuration Object.
    .DESCRIPTION
        Configuration for service resource.
    .PARAMETER Name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created. 
    .PARAMETER Maxclient 
        Maximum number of simultaneous open connections to the service. 
    .PARAMETER Maxreq 
        Maximum number of requests that can be sent on a persistent connection to the service. 
        Note: Connection requests beyond this value are rejected. 
    .PARAMETER Cacheable 
        Use the transparent cache redirection virtual server to forward requests to the cache server. 
        Note: Do not specify this parameter if you set the Cache Type parameter. 
        Possible values = YES, NO 
    .PARAMETER Cip 
        Before forwarding a request to the service, insert an HTTP header with the client's IPv4 or IPv6 address as its value. Used if the server needs the client's IP address for security, accounting, or other purposes, and setting the Use Source IP parameter is not a viable option. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Usip 
        Use the client's IP address as the source IP address when initiating a connection to the server. When creating a service, if you do not set this parameter, the service inherits the global Use Source IP setting (available in the enable ns mode and disable ns mode CLI commands, or in the System > Settings > Configure modes > Configure Modes dialog box). However, you can override this setting after you create the service. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitor 
        Path monitoring for clustering. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitorindv 
        Individual Path monitoring decisions. 
        Possible values = YES, NO 
    .PARAMETER Useproxyport 
        Use the proxy port as the source port when initiating connections with the server. With the NO setting, the client-side connection port is used as the source port for the server-side connection. 
        Note: This parameter is available only when the Use Source IP (USIP) parameter is set to YES. 
        Possible values = YES, NO 
    .PARAMETER Sp 
        Enable surge protection for the service. 
        Possible values = ON, OFF 
    .PARAMETER Rtspsessionidremap 
        Enable RTSP session ID mapping for the service. 
        Possible values = ON, OFF 
    .PARAMETER Customserverid 
        Unique identifier for the service. Used when the persistency type for the virtual server is set to Custom Server ID. 
    .PARAMETER Serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER Cka 
        Enable client keep-alive for the service. 
        Possible values = YES, NO 
    .PARAMETER Tcpb 
        Enable TCP buffering for the service. 
        Possible values = YES, NO 
    .PARAMETER Cmp 
        Enable compression for the service. 
        Possible values = YES, NO 
    .PARAMETER Maxbandwidth 
        Maximum bandwidth, in Kbps, allocated to the service. 
    .PARAMETER Accessdown 
        Use Layer 2 mode to bridge the packets sent to this service if it is marked as DOWN. If the service is DOWN, and this parameter is disabled, the packets are dropped. 
        Possible values = YES, NO 
    .PARAMETER Monthreshold 
        Minimum sum of weights of the monitors that are bound to this service. Used to determine whether to mark a service as UP or DOWN. 
    .PARAMETER Clttimeout 
        Time, in seconds, after which to terminate an idle client connection. 
    .PARAMETER Svrtimeout 
        Time, in seconds, after which to terminate an idle server connection. 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile that contains TCP configuration settings for the service. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile that contains HTTP configuration settings for the service. 
    .PARAMETER Contentinspectionprofilename 
        Name of the ContentInspection profile that contains IPS/IDS communication related setting for the service. 
    .PARAMETER Hashid 
        A numerical identifier that can be used by hash based load balancing methods. Must be unique for each service. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Network profile to use for the service. 
    .PARAMETER Processlocal 
        By turning on this option packets destined to a service in a cluster will not under go any steering. Turn this option for single packet request response mode or when the upstream device is performing a proper RSS for connection based distribution. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the service. DNS profile properties will applied to the transactions processed by a service. This parameter is valid only for ADNS and ADNS-TCP services. 
    .PARAMETER Monconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set. 
        Possible values = RESET, FIN 
    .PARAMETER Cipheader 
        Name for the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If you set the Client IP parameter, and you do not specify a name for the header, the appliance uses the header name specified for the global Client IP Header parameter (the cipHeader parameter in the set ns param CLI command or the Client IP Header parameter in the Configure HTTP Parameters dialog box at System > Settings > Change HTTP parameters). If the global Client IP Header parameter is not specified, the appliance inserts a header with the name "client-ip.". 
    .PARAMETER Healthmonitor 
        Monitor the health of this service. Available settings function as follows: 
        YES - Send probes to check the health of the service. 
        NO - Do not send probes to check the health of the service. With the NO option, the appliance shows the service as UP at all times. 
        Possible values = YES, NO 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with a service whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Comment 
        Any information about the service.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetService -name <string>
        An example how to unset service configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetService
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service
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

        [Boolean]$maxclient,

        [Boolean]$maxreq,

        [Boolean]$cacheable,

        [Boolean]$cip,

        [Boolean]$usip,

        [Boolean]$pathmonitor,

        [Boolean]$pathmonitorindv,

        [Boolean]$useproxyport,

        [Boolean]$sp,

        [Boolean]$rtspsessionidremap,

        [Boolean]$customserverid,

        [Boolean]$serverid,

        [Boolean]$cka,

        [Boolean]$tcpb,

        [Boolean]$cmp,

        [Boolean]$maxbandwidth,

        [Boolean]$accessdown,

        [Boolean]$monthreshold,

        [Boolean]$clttimeout,

        [Boolean]$svrtimeout,

        [Boolean]$tcpprofilename,

        [Boolean]$httpprofilename,

        [Boolean]$contentinspectionprofilename,

        [Boolean]$hashid,

        [Boolean]$appflowlog,

        [Boolean]$netprofile,

        [Boolean]$processlocal,

        [Boolean]$dnsprofilename,

        [Boolean]$monconnectionclose,

        [Boolean]$cipheader,

        [Boolean]$healthmonitor,

        [Boolean]$downstateflush,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetService: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('maxreq') ) { $payload.Add('maxreq', $maxreq) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('usip') ) { $payload.Add('usip', $usip) }
            if ( $PSBoundParameters.ContainsKey('pathmonitor') ) { $payload.Add('pathmonitor', $pathmonitor) }
            if ( $PSBoundParameters.ContainsKey('pathmonitorindv') ) { $payload.Add('pathmonitorindv', $pathmonitorindv) }
            if ( $PSBoundParameters.ContainsKey('useproxyport') ) { $payload.Add('useproxyport', $useproxyport) }
            if ( $PSBoundParameters.ContainsKey('sp') ) { $payload.Add('sp', $sp) }
            if ( $PSBoundParameters.ContainsKey('rtspsessionidremap') ) { $payload.Add('rtspsessionidremap', $rtspsessionidremap) }
            if ( $PSBoundParameters.ContainsKey('customserverid') ) { $payload.Add('customserverid', $customserverid) }
            if ( $PSBoundParameters.ContainsKey('serverid') ) { $payload.Add('serverid', $serverid) }
            if ( $PSBoundParameters.ContainsKey('cka') ) { $payload.Add('cka', $cka) }
            if ( $PSBoundParameters.ContainsKey('tcpb') ) { $payload.Add('tcpb', $tcpb) }
            if ( $PSBoundParameters.ContainsKey('cmp') ) { $payload.Add('cmp', $cmp) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('accessdown') ) { $payload.Add('accessdown', $accessdown) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionprofilename') ) { $payload.Add('contentinspectionprofilename', $contentinspectionprofilename) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('processlocal') ) { $payload.Add('processlocal', $processlocal) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('monconnectionclose') ) { $payload.Add('monconnectionclose', $monconnectionclose) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type service -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetService: Finished"
    }
}

function Invoke-ADCDeleteService {
    <#
    .SYNOPSIS
        Delete Basic configuration Object.
    .DESCRIPTION
        Configuration for service resource.
    .PARAMETER Name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteService -Name <string>
        An example how to delete service configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteService
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service/
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
        Write-Verbose "Invoke-ADCDeleteService: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type service -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteService: Finished"
    }
}

function Invoke-ADCUpdateService {
    <#
    .SYNOPSIS
        Update Basic configuration Object.
    .DESCRIPTION
        Configuration for service resource.
    .PARAMETER Name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created. 
    .PARAMETER Ipaddress 
        The new IP address of the service. 
    .PARAMETER Maxclient 
        Maximum number of simultaneous open connections to the service. 
    .PARAMETER Maxreq 
        Maximum number of requests that can be sent on a persistent connection to the service. 
        Note: Connection requests beyond this value are rejected. 
    .PARAMETER Cacheable 
        Use the transparent cache redirection virtual server to forward requests to the cache server. 
        Note: Do not specify this parameter if you set the Cache Type parameter. 
        Possible values = YES, NO 
    .PARAMETER Cip 
        Before forwarding a request to the service, insert an HTTP header with the client's IPv4 or IPv6 address as its value. Used if the server needs the client's IP address for security, accounting, or other purposes, and setting the Use Source IP parameter is not a viable option. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cipheader 
        Name for the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If you set the Client IP parameter, and you do not specify a name for the header, the appliance uses the header name specified for the global Client IP Header parameter (the cipHeader parameter in the set ns param CLI command or the Client IP Header parameter in the Configure HTTP Parameters dialog box at System > Settings > Change HTTP parameters). If the global Client IP Header parameter is not specified, the appliance inserts a header with the name "client-ip.". 
    .PARAMETER Usip 
        Use the client's IP address as the source IP address when initiating a connection to the server. When creating a service, if you do not set this parameter, the service inherits the global Use Source IP setting (available in the enable ns mode and disable ns mode CLI commands, or in the System > Settings > Configure modes > Configure Modes dialog box). However, you can override this setting after you create the service. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitor 
        Path monitoring for clustering. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitorindv 
        Individual Path monitoring decisions. 
        Possible values = YES, NO 
    .PARAMETER Useproxyport 
        Use the proxy port as the source port when initiating connections with the server. With the NO setting, the client-side connection port is used as the source port for the server-side connection. 
        Note: This parameter is available only when the Use Source IP (USIP) parameter is set to YES. 
        Possible values = YES, NO 
    .PARAMETER Sp 
        Enable surge protection for the service. 
        Possible values = ON, OFF 
    .PARAMETER Rtspsessionidremap 
        Enable RTSP session ID mapping for the service. 
        Possible values = ON, OFF 
    .PARAMETER Healthmonitor 
        Monitor the health of this service. Available settings function as follows: 
        YES - Send probes to check the health of the service. 
        NO - Do not send probes to check the health of the service. With the NO option, the appliance shows the service as UP at all times. 
        Possible values = YES, NO 
    .PARAMETER Clttimeout 
        Time, in seconds, after which to terminate an idle client connection. 
    .PARAMETER Svrtimeout 
        Time, in seconds, after which to terminate an idle server connection. 
    .PARAMETER Customserverid 
        Unique identifier for the service. Used when the persistency type for the virtual server is set to Custom Server ID. 
    .PARAMETER Serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER Cka 
        Enable client keep-alive for the service. 
        Possible values = YES, NO 
    .PARAMETER Tcpb 
        Enable TCP buffering for the service. 
        Possible values = YES, NO 
    .PARAMETER Cmp 
        Enable compression for the service. 
        Possible values = YES, NO 
    .PARAMETER Maxbandwidth 
        Maximum bandwidth, in Kbps, allocated to the service. 
    .PARAMETER Accessdown 
        Use Layer 2 mode to bridge the packets sent to this service if it is marked as DOWN. If the service is DOWN, and this parameter is disabled, the packets are dropped. 
        Possible values = YES, NO 
    .PARAMETER Monthreshold 
        Minimum sum of weights of the monitors that are bound to this service. Used to determine whether to mark a service as UP or DOWN. 
    .PARAMETER Weight 
        Weight to assign to the monitor-service binding. When a monitor is UP, the weight assigned to its binding with the service determines how much the monitor contributes toward keeping the health of the service above the value configured for the Monitor Threshold parameter. 
    .PARAMETER Monitor_name_svc 
        Name of the monitor bound to the specified service. 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with a service whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile that contains TCP configuration settings for the service. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile that contains HTTP configuration settings for the service. 
    .PARAMETER Contentinspectionprofilename 
        Name of the ContentInspection profile that contains IPS/IDS communication related setting for the service. 
    .PARAMETER Hashid 
        A numerical identifier that can be used by hash based load balancing methods. Must be unique for each service. 
    .PARAMETER Comment 
        Any information about the service. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Network profile to use for the service. 
    .PARAMETER Processlocal 
        By turning on this option packets destined to a service in a cluster will not under go any steering. Turn this option for single packet request response mode or when the upstream device is performing a proper RSS for connection based distribution. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the service. DNS profile properties will applied to the transactions processed by a service. This parameter is valid only for ADNS and ADNS-TCP services. 
    .PARAMETER Monconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set. 
        Possible values = RESET, FIN 
    .PARAMETER PassThru 
        Return details about the created service item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateService -name <string>
        An example how to update service configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateService
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service/
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

        [ValidateRange(0, 4294967294)]
        [double]$Maxclient,

        [ValidateRange(0, 65535)]
        [double]$Maxreq,

        [ValidateSet('YES', 'NO')]
        [string]$Cacheable,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cipheader,

        [ValidateSet('YES', 'NO')]
        [string]$Usip,

        [ValidateSet('YES', 'NO')]
        [string]$Pathmonitor,

        [ValidateSet('YES', 'NO')]
        [string]$Pathmonitorindv,

        [ValidateSet('YES', 'NO')]
        [string]$Useproxyport,

        [ValidateSet('ON', 'OFF')]
        [string]$Sp,

        [ValidateSet('ON', 'OFF')]
        [string]$Rtspsessionidremap,

        [ValidateSet('YES', 'NO')]
        [string]$Healthmonitor,

        [ValidateRange(0, 31536000)]
        [double]$Clttimeout,

        [ValidateRange(0, 31536000)]
        [double]$Svrtimeout,

        [string]$Customserverid,

        [double]$Serverid,

        [ValidateSet('YES', 'NO')]
        [string]$Cka,

        [ValidateSet('YES', 'NO')]
        [string]$Tcpb,

        [ValidateSet('YES', 'NO')]
        [string]$Cmp,

        [ValidateRange(0, 4294967287)]
        [double]$Maxbandwidth,

        [ValidateSet('YES', 'NO')]
        [string]$Accessdown,

        [ValidateRange(0, 65535)]
        [double]$Monthreshold,

        [ValidateRange(1, 100)]
        [double]$Weight,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Monitor_name_svc,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush,

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateLength(1, 127)]
        [string]$Httpprofilename,

        [ValidateLength(1, 127)]
        [string]$Contentinspectionprofilename,

        [double]$Hashid,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog,

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Processlocal,

        [ValidateLength(1, 127)]
        [string]$Dnsprofilename,

        [ValidateSet('RESET', 'FIN')]
        [string]$Monconnectionclose,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateService: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('maxreq') ) { $payload.Add('maxreq', $maxreq) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('usip') ) { $payload.Add('usip', $usip) }
            if ( $PSBoundParameters.ContainsKey('pathmonitor') ) { $payload.Add('pathmonitor', $pathmonitor) }
            if ( $PSBoundParameters.ContainsKey('pathmonitorindv') ) { $payload.Add('pathmonitorindv', $pathmonitorindv) }
            if ( $PSBoundParameters.ContainsKey('useproxyport') ) { $payload.Add('useproxyport', $useproxyport) }
            if ( $PSBoundParameters.ContainsKey('sp') ) { $payload.Add('sp', $sp) }
            if ( $PSBoundParameters.ContainsKey('rtspsessionidremap') ) { $payload.Add('rtspsessionidremap', $rtspsessionidremap) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('customserverid') ) { $payload.Add('customserverid', $customserverid) }
            if ( $PSBoundParameters.ContainsKey('serverid') ) { $payload.Add('serverid', $serverid) }
            if ( $PSBoundParameters.ContainsKey('cka') ) { $payload.Add('cka', $cka) }
            if ( $PSBoundParameters.ContainsKey('tcpb') ) { $payload.Add('tcpb', $tcpb) }
            if ( $PSBoundParameters.ContainsKey('cmp') ) { $payload.Add('cmp', $cmp) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('accessdown') ) { $payload.Add('accessdown', $accessdown) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('monitor_name_svc') ) { $payload.Add('monitor_name_svc', $monitor_name_svc) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionprofilename') ) { $payload.Add('contentinspectionprofilename', $contentinspectionprofilename) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('processlocal') ) { $payload.Add('processlocal', $processlocal) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('monconnectionclose') ) { $payload.Add('monconnectionclose', $monconnectionclose) }
            if ( $PSCmdlet.ShouldProcess("service", "Update Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type service -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetService -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateService: Finished"
    }
}

function Invoke-ADCAddService {
    <#
    .SYNOPSIS
        Add Basic configuration Object.
    .DESCRIPTION
        Configuration for service resource.
    .PARAMETER Name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created. 
    .PARAMETER Ip 
        IP to assign to the service. 
    .PARAMETER Servername 
        Name of the server that hosts the service. 
    .PARAMETER Servicetype 
        Protocol in which data is exchanged with the service. 
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, DTLS, NNTP, RPCSVR, DNS, ADNS, SNMP, RTSP, DHCPRA, ANY, SIP_UDP, SIP_TCP, SIP_SSL, DNS_TCP, ADNS_TCP, MYSQL, MSSQL, ORACLE, MONGO, MONGO_TLS, RADIUS, RADIUSListener, RDP, DIAMETER, SSL_DIAMETER, TFTP, SMPP, PPTP, GRE, SYSLOGTCP, SYSLOGUDP, FIX, SSL_FIX, USER_TCP, USER_SSL_TCP, QUIC, IPFIX, LOGSTREAM, LOGSTREAM_SSL, MQTT, MQTT_TLS, QUIC_BRIDGE 
    .PARAMETER Port 
        Port number of the service. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Cleartextport 
        Port to which clear text data must be sent after the appliance decrypts incoming SSL traffic. Applicable to transparent SSL services. 
    .PARAMETER Cachetype 
        Cache type supported by the cache server. 
        Possible values = TRANSPARENT, REVERSE, FORWARD 
    .PARAMETER Maxclient 
        Maximum number of simultaneous open connections to the service. 
    .PARAMETER Healthmonitor 
        Monitor the health of this service. Available settings function as follows: 
        YES - Send probes to check the health of the service. 
        NO - Do not send probes to check the health of the service. With the NO option, the appliance shows the service as UP at all times. 
        Possible values = YES, NO 
    .PARAMETER Maxreq 
        Maximum number of requests that can be sent on a persistent connection to the service. 
        Note: Connection requests beyond this value are rejected. 
    .PARAMETER Cacheable 
        Use the transparent cache redirection virtual server to forward requests to the cache server. 
        Note: Do not specify this parameter if you set the Cache Type parameter. 
        Possible values = YES, NO 
    .PARAMETER Cip 
        Before forwarding a request to the service, insert an HTTP header with the client's IPv4 or IPv6 address as its value. Used if the server needs the client's IP address for security, accounting, or other purposes, and setting the Use Source IP parameter is not a viable option. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cipheader 
        Name for the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If you set the Client IP parameter, and you do not specify a name for the header, the appliance uses the header name specified for the global Client IP Header parameter (the cipHeader parameter in the set ns param CLI command or the Client IP Header parameter in the Configure HTTP Parameters dialog box at System > Settings > Change HTTP parameters). If the global Client IP Header parameter is not specified, the appliance inserts a header with the name "client-ip.". 
    .PARAMETER Usip 
        Use the client's IP address as the source IP address when initiating a connection to the server. When creating a service, if you do not set this parameter, the service inherits the global Use Source IP setting (available in the enable ns mode and disable ns mode CLI commands, or in the System > Settings > Configure modes > Configure Modes dialog box). However, you can override this setting after you create the service. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitor 
        Path monitoring for clustering. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitorindv 
        Individual Path monitoring decisions. 
        Possible values = YES, NO 
    .PARAMETER Useproxyport 
        Use the proxy port as the source port when initiating connections with the server. With the NO setting, the client-side connection port is used as the source port for the server-side connection. 
        Note: This parameter is available only when the Use Source IP (USIP) parameter is set to YES. 
        Possible values = YES, NO 
    .PARAMETER Sp 
        Enable surge protection for the service. 
        Possible values = ON, OFF 
    .PARAMETER Rtspsessionidremap 
        Enable RTSP session ID mapping for the service. 
        Possible values = ON, OFF 
    .PARAMETER Clttimeout 
        Time, in seconds, after which to terminate an idle client connection. 
    .PARAMETER Svrtimeout 
        Time, in seconds, after which to terminate an idle server connection. 
    .PARAMETER Customserverid 
        Unique identifier for the service. Used when the persistency type for the virtual server is set to Custom Server ID. 
    .PARAMETER Serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER Cka 
        Enable client keep-alive for the service. 
        Possible values = YES, NO 
    .PARAMETER Tcpb 
        Enable TCP buffering for the service. 
        Possible values = YES, NO 
    .PARAMETER Cmp 
        Enable compression for the service. 
        Possible values = YES, NO 
    .PARAMETER Maxbandwidth 
        Maximum bandwidth, in Kbps, allocated to the service. 
    .PARAMETER Accessdown 
        Use Layer 2 mode to bridge the packets sent to this service if it is marked as DOWN. If the service is DOWN, and this parameter is disabled, the packets are dropped. 
        Possible values = YES, NO 
    .PARAMETER Monthreshold 
        Minimum sum of weights of the monitors that are bound to this service. Used to determine whether to mark a service as UP or DOWN. 
    .PARAMETER State 
        Initial state of the service. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with a service whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile that contains TCP configuration settings for the service. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile that contains HTTP configuration settings for the service. 
    .PARAMETER Contentinspectionprofilename 
        Name of the ContentInspection profile that contains IPS/IDS communication related setting for the service. 
    .PARAMETER Hashid 
        A numerical identifier that can be used by hash based load balancing methods. Must be unique for each service. 
    .PARAMETER Comment 
        Any information about the service. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Network profile to use for the service. 
    .PARAMETER Td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0. 
    .PARAMETER Processlocal 
        By turning on this option packets destined to a service in a cluster will not under go any steering. Turn this option for single packet request response mode or when the upstream device is performing a proper RSS for connection based distribution. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the service. DNS profile properties will applied to the transactions processed by a service. This parameter is valid only for ADNS and ADNS-TCP services. 
    .PARAMETER Monconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set. 
        Possible values = RESET, FIN 
    .PARAMETER PassThru 
        Return details about the created service item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddService -name <string> -servicetype <string> -port <int>
        An example how to add service configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddService
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servername,

        [Parameter(Mandatory)]
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'DTLS', 'NNTP', 'RPCSVR', 'DNS', 'ADNS', 'SNMP', 'RTSP', 'DHCPRA', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'DNS_TCP', 'ADNS_TCP', 'MYSQL', 'MSSQL', 'ORACLE', 'MONGO', 'MONGO_TLS', 'RADIUS', 'RADIUSListener', 'RDP', 'DIAMETER', 'SSL_DIAMETER', 'TFTP', 'SMPP', 'PPTP', 'GRE', 'SYSLOGTCP', 'SYSLOGUDP', 'FIX', 'SSL_FIX', 'USER_TCP', 'USER_SSL_TCP', 'QUIC', 'IPFIX', 'LOGSTREAM', 'LOGSTREAM_SSL', 'MQTT', 'MQTT_TLS', 'QUIC_BRIDGE')]
        [string]$Servicetype,

        [Parameter(Mandatory)]
        [ValidateRange(1, 65535)]
        [int]$Port,

        [int]$Cleartextport,

        [ValidateSet('TRANSPARENT', 'REVERSE', 'FORWARD')]
        [string]$Cachetype,

        [ValidateRange(0, 4294967294)]
        [double]$Maxclient,

        [ValidateSet('YES', 'NO')]
        [string]$Healthmonitor = 'YES',

        [ValidateRange(0, 65535)]
        [double]$Maxreq,

        [ValidateSet('YES', 'NO')]
        [string]$Cacheable = 'NO',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cipheader,

        [ValidateSet('YES', 'NO')]
        [string]$Usip,

        [ValidateSet('YES', 'NO')]
        [string]$Pathmonitor,

        [ValidateSet('YES', 'NO')]
        [string]$Pathmonitorindv,

        [ValidateSet('YES', 'NO')]
        [string]$Useproxyport,

        [ValidateSet('ON', 'OFF')]
        [string]$Sp,

        [ValidateSet('ON', 'OFF')]
        [string]$Rtspsessionidremap = 'OFF',

        [ValidateRange(0, 31536000)]
        [double]$Clttimeout,

        [ValidateRange(0, 31536000)]
        [double]$Svrtimeout,

        [string]$Customserverid = '"None"',

        [double]$Serverid,

        [ValidateSet('YES', 'NO')]
        [string]$Cka,

        [ValidateSet('YES', 'NO')]
        [string]$Tcpb,

        [ValidateSet('YES', 'NO')]
        [string]$Cmp,

        [ValidateRange(0, 4294967287)]
        [double]$Maxbandwidth,

        [ValidateSet('YES', 'NO')]
        [string]$Accessdown = 'NO',

        [ValidateRange(0, 65535)]
        [double]$Monthreshold,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush = 'ENABLED',

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateLength(1, 127)]
        [string]$Httpprofilename,

        [ValidateLength(1, 127)]
        [string]$Contentinspectionprofilename,

        [double]$Hashid,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog = 'ENABLED',

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateRange(0, 4094)]
        [double]$Td,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Processlocal = 'DISABLED',

        [ValidateLength(1, 127)]
        [string]$Dnsprofilename,

        [ValidateSet('RESET', 'FIN')]
        [string]$Monconnectionclose = 'NONE',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddService: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                servicetype    = $servicetype
                port           = $port
            }
            if ( $PSBoundParameters.ContainsKey('ip') ) { $payload.Add('ip', $ip) }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('cleartextport') ) { $payload.Add('cleartextport', $cleartextport) }
            if ( $PSBoundParameters.ContainsKey('cachetype') ) { $payload.Add('cachetype', $cachetype) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('maxreq') ) { $payload.Add('maxreq', $maxreq) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('usip') ) { $payload.Add('usip', $usip) }
            if ( $PSBoundParameters.ContainsKey('pathmonitor') ) { $payload.Add('pathmonitor', $pathmonitor) }
            if ( $PSBoundParameters.ContainsKey('pathmonitorindv') ) { $payload.Add('pathmonitorindv', $pathmonitorindv) }
            if ( $PSBoundParameters.ContainsKey('useproxyport') ) { $payload.Add('useproxyport', $useproxyport) }
            if ( $PSBoundParameters.ContainsKey('sp') ) { $payload.Add('sp', $sp) }
            if ( $PSBoundParameters.ContainsKey('rtspsessionidremap') ) { $payload.Add('rtspsessionidremap', $rtspsessionidremap) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('customserverid') ) { $payload.Add('customserverid', $customserverid) }
            if ( $PSBoundParameters.ContainsKey('serverid') ) { $payload.Add('serverid', $serverid) }
            if ( $PSBoundParameters.ContainsKey('cka') ) { $payload.Add('cka', $cka) }
            if ( $PSBoundParameters.ContainsKey('tcpb') ) { $payload.Add('tcpb', $tcpb) }
            if ( $PSBoundParameters.ContainsKey('cmp') ) { $payload.Add('cmp', $cmp) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('accessdown') ) { $payload.Add('accessdown', $accessdown) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionprofilename') ) { $payload.Add('contentinspectionprofilename', $contentinspectionprofilename) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('processlocal') ) { $payload.Add('processlocal', $processlocal) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('monconnectionclose') ) { $payload.Add('monconnectionclose', $monconnectionclose) }
            if ( $PSCmdlet.ShouldProcess("service", "Add Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type service -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetService -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddService: Finished"
    }
}

function Invoke-ADCGetService {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Configuration for service resource.
    .PARAMETER Name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created. 
    .PARAMETER GetAll 
        Retrieve all service object(s).
    .PARAMETER Count
        If specified, the count of the service object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetService
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetService -GetAll 
        Get all service data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetService -Count 
        Get the number of service objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetService -name <string>
        Get service object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetService -Filter @{ 'name'='<value>' }
        Get service data with a filter.
    .NOTES
        File Name : Invoke-ADCGetService
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service/
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
        Write-Verbose "Invoke-ADCGetService: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all service objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for service objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving service objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving service configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving service configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetService: Ended"
    }
}

function Invoke-ADCRenameServicegroup {
    <#
    .SYNOPSIS
        Rename Basic configuration Object.
    .DESCRIPTION
        Configuration for service group resource.
    .PARAMETER Servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Newname 
        New name for the service group. 
    .PARAMETER PassThru 
        Return details about the created servicegroup item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameServicegroup -servicegroupname <string> -newname <string>
        An example how to rename servicegroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameServicegroup
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup/
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
        [string]$Servicegroupname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameServicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname
                newname                    = $newname
            }

            if ( $PSCmdlet.ShouldProcess("servicegroup", "Rename Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type servicegroup -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetServicegroup -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameServicegroup: Finished"
    }
}

function Invoke-ADCEnableServicegroup {
    <#
    .SYNOPSIS
        Enable Basic configuration Object.
    .DESCRIPTION
        Configuration for service group resource.
    .PARAMETER Servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
        * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        PS C:\>Invoke-ADCEnableServicegroup -servicegroupname <string>
        An example how to enable servicegroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCEnableServicegroup
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup/
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
        [string]$Servicegroupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servername,

        [ValidateRange(1, 65535)]
        [int]$Port 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableServicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSCmdlet.ShouldProcess($Name, "Enable Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type servicegroup -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCEnableServicegroup: Finished"
    }
}

function Invoke-ADCDisableServicegroup {
    <#
    .SYNOPSIS
        Disable Basic configuration Object.
    .DESCRIPTION
        Configuration for service group resource.
    .PARAMETER Servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Delay 
        Time, in seconds, allocated for a shutdown of the services in the service group. During this period, new requests are sent to the service only for clients who already have persistent sessions on the appliance. Requests from new clients are load balanced among other available services. After the delay time expires, no requests are sent to the service, and the service is marked as unavailable (OUT OF SERVICE). 
    .PARAMETER Graceful 
        Wait for all existing connections to the service to terminate before shutting down the service. 
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-ADCDisableServicegroup -servicegroupname <string>
        An example how to disable servicegroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDisableServicegroup
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup/
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
        [string]$Servicegroupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servername,

        [ValidateRange(1, 65535)]
        [int]$Port,

        [double]$Delay,

        [ValidateSet('YES', 'NO')]
        [string]$Graceful 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableServicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('graceful') ) { $payload.Add('graceful', $graceful) }
            if ( $PSCmdlet.ShouldProcess($Name, "Disable Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type servicegroup -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCDisableServicegroup: Finished"
    }
}

function Invoke-ADCUnsetServicegroup {
    <#
    .SYNOPSIS
        Unset Basic configuration Object.
    .DESCRIPTION
        Configuration for service group resource.
    .PARAMETER Servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service. 
    .PARAMETER Customserverid 
        The identifier for this IP:Port pair. Used when the persistency type is set to Custom Server ID. 
    .PARAMETER Serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER Hashid 
        The hash identifier for the service. This must be unique for each service. This parameter is used by hash based load balancing methods. 
    .PARAMETER Nameserver 
        Specify the nameserver to which the query for bound domain needs to be sent. If not specified, use the global nameserver. 
    .PARAMETER Dbsttl 
        Specify the TTL for DNS record for domain based service.The default value of ttl is 0 which indicates to use the TTL received in DNS response for monitors. 
    .PARAMETER Maxclient 
        Maximum number of simultaneous open connections for the service group. 
    .PARAMETER Maxreq 
        Maximum number of requests that can be sent on a persistent connection to the service group. 
        Note: Connection requests beyond this value are rejected. 
    .PARAMETER Cacheable 
        Use the transparent cache redirection virtual server to forward the request to the cache server. 
        Note: Do not set this parameter if you set the Cache Type. 
        Possible values = YES, NO 
    .PARAMETER Cip 
        Insert the Client IP header in requests forwarded to the service. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Usip 
        Use client's IP address as the source IP address when initiating connection to the server. With the NO setting, which is the default, a mapped IP (MIP) address or subnet IP (SNIP) address is used as the source IP address to initiate server side connections. 
        Possible values = YES, NO 
    .PARAMETER Useproxyport 
        Use the proxy port as the source port when initiating connections with the server. With the NO setting, the client-side connection port is used as the source port for the server-side connection. 
        Note: This parameter is available only when the Use Source IP (USIP) parameter is set to YES. 
        Possible values = YES, NO 
    .PARAMETER Sp 
        Enable surge protection for the service group. 
        Possible values = ON, OFF 
    .PARAMETER Rtspsessionidremap 
        Enable RTSP session ID mapping for the service group. 
        Possible values = ON, OFF 
    .PARAMETER Clttimeout 
        Time, in seconds, after which to terminate an idle client connection. 
    .PARAMETER Svrtimeout 
        Time, in seconds, after which to terminate an idle server connection. 
    .PARAMETER Cka 
        Enable client keep-alive for the service group. 
        Possible values = YES, NO 
    .PARAMETER Tcpb 
        Enable TCP buffering for the service group. 
        Possible values = YES, NO 
    .PARAMETER Cmp 
        Enable compression for the specified service. 
        Possible values = YES, NO 
    .PARAMETER Maxbandwidth 
        Maximum bandwidth, in Kbps, allocated for all the services in the service group. 
    .PARAMETER Monthreshold 
        Minimum sum of weights of the monitors that are bound to this service. Used to determine whether to mark a service as UP or DOWN. 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile that contains TCP configuration settings for the service group. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile that contains HTTP configuration settings for the service group. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information for the specified service group. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Network profile for the service group. 
    .PARAMETER Autodisablegraceful 
        Indicates graceful shutdown of the service. System will wait for all outstanding connections to this service to be closed before disabling the service. 
        Possible values = YES, NO 
    .PARAMETER Autodisabledelay 
        The time allowed (in seconds) for a graceful shutdown. During this period, new connections or requests will continue to be sent to this service for clients who already have a persistent session on the system. Connections or requests from fresh or new clients who do not yet have a persistence sessions on the system will not be sent to the service. Instead, they will be load balanced among other available services. After the delay time expires, no new requests or connections will be sent to the service. 
    .PARAMETER Monitor_name_svc 
        Name of the monitor bound to the service group. Used to assign a weight to the monitor. 
    .PARAMETER Dup_weight 
        weight of the monitor that is bound to servicegroup. 
    .PARAMETER Healthmonitor 
        Monitor the health of this service. Available settings function as follows: 
        YES - Send probes to check the health of the service. 
        NO - Do not send probes to check the health of the service. With the NO option, the appliance shows the service as UP at all times. 
        Possible values = YES, NO 
    .PARAMETER Cipheader 
        Name of the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If client IP insertion is enabled, and the client IP header is not specified, the value of Client IP Header parameter or the value set by the set ns config command is used as client's IP header name. 
    .PARAMETER Pathmonitor 
        Path monitoring for clustering. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitorindv 
        Individual Path monitoring decisions. 
        Possible values = YES, NO 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with all the services in the service group whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Comment 
        Any information about the service group. 
    .PARAMETER Monconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set. 
        Possible values = RESET, FIN
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetServicegroup -servicegroupname <string>
        An example how to unset servicegroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetServicegroup
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup
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
        [string]$Servicegroupname,

        [Boolean]$servername,

        [Boolean]$port,

        [Boolean]$weight,

        [Boolean]$customserverid,

        [Boolean]$serverid,

        [Boolean]$hashid,

        [Boolean]$nameserver,

        [Boolean]$dbsttl,

        [Boolean]$maxclient,

        [Boolean]$maxreq,

        [Boolean]$cacheable,

        [Boolean]$cip,

        [Boolean]$usip,

        [Boolean]$useproxyport,

        [Boolean]$sp,

        [Boolean]$rtspsessionidremap,

        [Boolean]$clttimeout,

        [Boolean]$svrtimeout,

        [Boolean]$cka,

        [Boolean]$tcpb,

        [Boolean]$cmp,

        [Boolean]$maxbandwidth,

        [Boolean]$monthreshold,

        [Boolean]$tcpprofilename,

        [Boolean]$httpprofilename,

        [Boolean]$appflowlog,

        [Boolean]$netprofile,

        [Boolean]$autodisablegraceful,

        [Boolean]$autodisabledelay,

        [Boolean]$monitor_name_svc,

        [Boolean]$dup_weight,

        [Boolean]$healthmonitor,

        [Boolean]$cipheader,

        [Boolean]$pathmonitor,

        [Boolean]$pathmonitorindv,

        [Boolean]$downstateflush,

        [Boolean]$comment,

        [Boolean]$monconnectionclose 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetServicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('customserverid') ) { $payload.Add('customserverid', $customserverid) }
            if ( $PSBoundParameters.ContainsKey('serverid') ) { $payload.Add('serverid', $serverid) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('nameserver') ) { $payload.Add('nameserver', $nameserver) }
            if ( $PSBoundParameters.ContainsKey('dbsttl') ) { $payload.Add('dbsttl', $dbsttl) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('maxreq') ) { $payload.Add('maxreq', $maxreq) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('usip') ) { $payload.Add('usip', $usip) }
            if ( $PSBoundParameters.ContainsKey('useproxyport') ) { $payload.Add('useproxyport', $useproxyport) }
            if ( $PSBoundParameters.ContainsKey('sp') ) { $payload.Add('sp', $sp) }
            if ( $PSBoundParameters.ContainsKey('rtspsessionidremap') ) { $payload.Add('rtspsessionidremap', $rtspsessionidremap) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('cka') ) { $payload.Add('cka', $cka) }
            if ( $PSBoundParameters.ContainsKey('tcpb') ) { $payload.Add('tcpb', $tcpb) }
            if ( $PSBoundParameters.ContainsKey('cmp') ) { $payload.Add('cmp', $cmp) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('autodisablegraceful') ) { $payload.Add('autodisablegraceful', $autodisablegraceful) }
            if ( $PSBoundParameters.ContainsKey('autodisabledelay') ) { $payload.Add('autodisabledelay', $autodisabledelay) }
            if ( $PSBoundParameters.ContainsKey('monitor_name_svc') ) { $payload.Add('monitor_name_svc', $monitor_name_svc) }
            if ( $PSBoundParameters.ContainsKey('dup_weight') ) { $payload.Add('dup_weight', $dup_weight) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('pathmonitor') ) { $payload.Add('pathmonitor', $pathmonitor) }
            if ( $PSBoundParameters.ContainsKey('pathmonitorindv') ) { $payload.Add('pathmonitorindv', $pathmonitorindv) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('monconnectionclose') ) { $payload.Add('monconnectionclose', $monconnectionclose) }
            if ( $PSCmdlet.ShouldProcess("$servicegroupname", "Unset Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type servicegroup -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetServicegroup: Finished"
    }
}

function Invoke-ADCDeleteServicegroup {
    <#
    .SYNOPSIS
        Delete Basic configuration Object.
    .DESCRIPTION
        Configuration for service group resource.
    .PARAMETER Servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteServicegroup -Servicegroupname <string>
        An example how to delete servicegroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteServicegroup
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup/
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
        [string]$Servicegroupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteServicegroup: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$servicegroupname", "Delete Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type servicegroup -NitroPath nitro/v1/config -Resource $servicegroupname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteServicegroup: Finished"
    }
}

function Invoke-ADCUpdateServicegroup {
    <#
    .SYNOPSIS
        Update Basic configuration Object.
    .DESCRIPTION
        Configuration for service group resource.
    .PARAMETER Servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service. 
    .PARAMETER Customserverid 
        The identifier for this IP:Port pair. Used when the persistency type is set to Custom Server ID. 
    .PARAMETER Serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER Hashid 
        The hash identifier for the service. This must be unique for each service. This parameter is used by hash based load balancing methods. 
    .PARAMETER Nameserver 
        Specify the nameserver to which the query for bound domain needs to be sent. If not specified, use the global nameserver. 
    .PARAMETER Dbsttl 
        Specify the TTL for DNS record for domain based service.The default value of ttl is 0 which indicates to use the TTL received in DNS response for monitors. 
    .PARAMETER Monitor_name_svc 
        Name of the monitor bound to the service group. Used to assign a weight to the monitor. 
    .PARAMETER Dup_weight 
        weight of the monitor that is bound to servicegroup. 
    .PARAMETER Maxclient 
        Maximum number of simultaneous open connections for the service group. 
    .PARAMETER Maxreq 
        Maximum number of requests that can be sent on a persistent connection to the service group. 
        Note: Connection requests beyond this value are rejected. 
    .PARAMETER Healthmonitor 
        Monitor the health of this service. Available settings function as follows: 
        YES - Send probes to check the health of the service. 
        NO - Do not send probes to check the health of the service. With the NO option, the appliance shows the service as UP at all times. 
        Possible values = YES, NO 
    .PARAMETER Cacheable 
        Use the transparent cache redirection virtual server to forward the request to the cache server. 
        Note: Do not set this parameter if you set the Cache Type. 
        Possible values = YES, NO 
    .PARAMETER Cip 
        Insert the Client IP header in requests forwarded to the service. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cipheader 
        Name of the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If client IP insertion is enabled, and the client IP header is not specified, the value of Client IP Header parameter or the value set by the set ns config command is used as client's IP header name. 
    .PARAMETER Usip 
        Use client's IP address as the source IP address when initiating connection to the server. With the NO setting, which is the default, a mapped IP (MIP) address or subnet IP (SNIP) address is used as the source IP address to initiate server side connections. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitor 
        Path monitoring for clustering. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitorindv 
        Individual Path monitoring decisions. 
        Possible values = YES, NO 
    .PARAMETER Useproxyport 
        Use the proxy port as the source port when initiating connections with the server. With the NO setting, the client-side connection port is used as the source port for the server-side connection. 
        Note: This parameter is available only when the Use Source IP (USIP) parameter is set to YES. 
        Possible values = YES, NO 
    .PARAMETER Sp 
        Enable surge protection for the service group. 
        Possible values = ON, OFF 
    .PARAMETER Rtspsessionidremap 
        Enable RTSP session ID mapping for the service group. 
        Possible values = ON, OFF 
    .PARAMETER Clttimeout 
        Time, in seconds, after which to terminate an idle client connection. 
    .PARAMETER Svrtimeout 
        Time, in seconds, after which to terminate an idle server connection. 
    .PARAMETER Cka 
        Enable client keep-alive for the service group. 
        Possible values = YES, NO 
    .PARAMETER Tcpb 
        Enable TCP buffering for the service group. 
        Possible values = YES, NO 
    .PARAMETER Cmp 
        Enable compression for the specified service. 
        Possible values = YES, NO 
    .PARAMETER Maxbandwidth 
        Maximum bandwidth, in Kbps, allocated for all the services in the service group. 
    .PARAMETER Monthreshold 
        Minimum sum of weights of the monitors that are bound to this service. Used to determine whether to mark a service as UP or DOWN. 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with all the services in the service group whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile that contains TCP configuration settings for the service group. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile that contains HTTP configuration settings for the service group. 
    .PARAMETER Comment 
        Any information about the service group. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information for the specified service group. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Network profile for the service group. 
    .PARAMETER Autodisablegraceful 
        Indicates graceful shutdown of the service. System will wait for all outstanding connections to this service to be closed before disabling the service. 
        Possible values = YES, NO 
    .PARAMETER Autodisabledelay 
        The time allowed (in seconds) for a graceful shutdown. During this period, new connections or requests will continue to be sent to this service for clients who already have a persistent session on the system. Connections or requests from fresh or new clients who do not yet have a persistence sessions on the system will not be sent to the service. Instead, they will be load balanced among other available services. After the delay time expires, no new requests or connections will be sent to the service. 
    .PARAMETER Monconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set. 
        Possible values = RESET, FIN 
    .PARAMETER Autoscale 
        Auto scale option for a servicegroup. 
        Possible values = DISABLED, DNS, POLICY, CLOUD, API 
    .PARAMETER PassThru 
        Return details about the created servicegroup item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateServicegroup -servicegroupname <string>
        An example how to update servicegroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateServicegroup
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup/
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
        [string]$Servicegroupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servername,

        [ValidateRange(1, 65535)]
        [int]$Port,

        [ValidateRange(1, 100)]
        [double]$Weight,

        [string]$Customserverid,

        [double]$Serverid,

        [double]$Hashid,

        [string]$Nameserver,

        [double]$Dbsttl,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Monitor_name_svc,

        [double]$Dup_weight,

        [ValidateRange(0, 4294967294)]
        [double]$Maxclient,

        [ValidateRange(0, 65535)]
        [double]$Maxreq,

        [ValidateSet('YES', 'NO')]
        [string]$Healthmonitor,

        [ValidateSet('YES', 'NO')]
        [string]$Cacheable,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cipheader,

        [ValidateSet('YES', 'NO')]
        [string]$Usip,

        [ValidateSet('YES', 'NO')]
        [string]$Pathmonitor,

        [ValidateSet('YES', 'NO')]
        [string]$Pathmonitorindv,

        [ValidateSet('YES', 'NO')]
        [string]$Useproxyport,

        [ValidateSet('ON', 'OFF')]
        [string]$Sp,

        [ValidateSet('ON', 'OFF')]
        [string]$Rtspsessionidremap,

        [ValidateRange(0, 31536000)]
        [double]$Clttimeout,

        [ValidateRange(0, 31536000)]
        [double]$Svrtimeout,

        [ValidateSet('YES', 'NO')]
        [string]$Cka,

        [ValidateSet('YES', 'NO')]
        [string]$Tcpb,

        [ValidateSet('YES', 'NO')]
        [string]$Cmp,

        [ValidateRange(0, 4294967287)]
        [double]$Maxbandwidth,

        [ValidateRange(0, 65535)]
        [double]$Monthreshold,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush,

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateLength(1, 127)]
        [string]$Httpprofilename,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog,

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateSet('YES', 'NO')]
        [string]$Autodisablegraceful,

        [double]$Autodisabledelay,

        [ValidateSet('RESET', 'FIN')]
        [string]$Monconnectionclose,

        [ValidateSet('DISABLED', 'DNS', 'POLICY', 'CLOUD', 'API')]
        [string]$Autoscale,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateServicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('customserverid') ) { $payload.Add('customserverid', $customserverid) }
            if ( $PSBoundParameters.ContainsKey('serverid') ) { $payload.Add('serverid', $serverid) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('nameserver') ) { $payload.Add('nameserver', $nameserver) }
            if ( $PSBoundParameters.ContainsKey('dbsttl') ) { $payload.Add('dbsttl', $dbsttl) }
            if ( $PSBoundParameters.ContainsKey('monitor_name_svc') ) { $payload.Add('monitor_name_svc', $monitor_name_svc) }
            if ( $PSBoundParameters.ContainsKey('dup_weight') ) { $payload.Add('dup_weight', $dup_weight) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('maxreq') ) { $payload.Add('maxreq', $maxreq) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('usip') ) { $payload.Add('usip', $usip) }
            if ( $PSBoundParameters.ContainsKey('pathmonitor') ) { $payload.Add('pathmonitor', $pathmonitor) }
            if ( $PSBoundParameters.ContainsKey('pathmonitorindv') ) { $payload.Add('pathmonitorindv', $pathmonitorindv) }
            if ( $PSBoundParameters.ContainsKey('useproxyport') ) { $payload.Add('useproxyport', $useproxyport) }
            if ( $PSBoundParameters.ContainsKey('sp') ) { $payload.Add('sp', $sp) }
            if ( $PSBoundParameters.ContainsKey('rtspsessionidremap') ) { $payload.Add('rtspsessionidremap', $rtspsessionidremap) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('cka') ) { $payload.Add('cka', $cka) }
            if ( $PSBoundParameters.ContainsKey('tcpb') ) { $payload.Add('tcpb', $tcpb) }
            if ( $PSBoundParameters.ContainsKey('cmp') ) { $payload.Add('cmp', $cmp) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('autodisablegraceful') ) { $payload.Add('autodisablegraceful', $autodisablegraceful) }
            if ( $PSBoundParameters.ContainsKey('autodisabledelay') ) { $payload.Add('autodisabledelay', $autodisabledelay) }
            if ( $PSBoundParameters.ContainsKey('monconnectionclose') ) { $payload.Add('monconnectionclose', $monconnectionclose) }
            if ( $PSBoundParameters.ContainsKey('autoscale') ) { $payload.Add('autoscale', $autoscale) }
            if ( $PSCmdlet.ShouldProcess("servicegroup", "Update Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type servicegroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetServicegroup -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateServicegroup: Finished"
    }
}

function Invoke-ADCAddServicegroup {
    <#
    .SYNOPSIS
        Add Basic configuration Object.
    .DESCRIPTION
        Configuration for service group resource.
    .PARAMETER Servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servicetype 
        Protocol used to exchange data with the service. 
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, DTLS, NNTP, RPCSVR, DNS, ADNS, SNMP, RTSP, DHCPRA, ANY, SIP_UDP, SIP_TCP, SIP_SSL, DNS_TCP, ADNS_TCP, MYSQL, MSSQL, ORACLE, MONGO, MONGO_TLS, RADIUS, RADIUSListener, RDP, DIAMETER, SSL_DIAMETER, TFTP, SMPP, PPTP, GRE, SYSLOGTCP, SYSLOGUDP, FIX, SSL_FIX, USER_TCP, USER_SSL_TCP, QUIC, IPFIX, LOGSTREAM, LOGSTREAM_SSL, MQTT, MQTT_TLS, QUIC_BRIDGE 
    .PARAMETER Cachetype 
        Cache type supported by the cache server. 
        Possible values = TRANSPARENT, REVERSE, FORWARD 
    .PARAMETER Td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0. 
    .PARAMETER Maxclient 
        Maximum number of simultaneous open connections for the service group. 
    .PARAMETER Maxreq 
        Maximum number of requests that can be sent on a persistent connection to the service group. 
        Note: Connection requests beyond this value are rejected. 
    .PARAMETER Cacheable 
        Use the transparent cache redirection virtual server to forward the request to the cache server. 
        Note: Do not set this parameter if you set the Cache Type. 
        Possible values = YES, NO 
    .PARAMETER Cip 
        Insert the Client IP header in requests forwarded to the service. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cipheader 
        Name of the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If client IP insertion is enabled, and the client IP header is not specified, the value of Client IP Header parameter or the value set by the set ns config command is used as client's IP header name. 
    .PARAMETER Usip 
        Use client's IP address as the source IP address when initiating connection to the server. With the NO setting, which is the default, a mapped IP (MIP) address or subnet IP (SNIP) address is used as the source IP address to initiate server side connections. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitor 
        Path monitoring for clustering. 
        Possible values = YES, NO 
    .PARAMETER Pathmonitorindv 
        Individual Path monitoring decisions. 
        Possible values = YES, NO 
    .PARAMETER Useproxyport 
        Use the proxy port as the source port when initiating connections with the server. With the NO setting, the client-side connection port is used as the source port for the server-side connection. 
        Note: This parameter is available only when the Use Source IP (USIP) parameter is set to YES. 
        Possible values = YES, NO 
    .PARAMETER Healthmonitor 
        Monitor the health of this service. Available settings function as follows: 
        YES - Send probes to check the health of the service. 
        NO - Do not send probes to check the health of the service. With the NO option, the appliance shows the service as UP at all times. 
        Possible values = YES, NO 
    .PARAMETER Sp 
        Enable surge protection for the service group. 
        Possible values = ON, OFF 
    .PARAMETER Rtspsessionidremap 
        Enable RTSP session ID mapping for the service group. 
        Possible values = ON, OFF 
    .PARAMETER Clttimeout 
        Time, in seconds, after which to terminate an idle client connection. 
    .PARAMETER Svrtimeout 
        Time, in seconds, after which to terminate an idle server connection. 
    .PARAMETER Cka 
        Enable client keep-alive for the service group. 
        Possible values = YES, NO 
    .PARAMETER Tcpb 
        Enable TCP buffering for the service group. 
        Possible values = YES, NO 
    .PARAMETER Cmp 
        Enable compression for the specified service. 
        Possible values = YES, NO 
    .PARAMETER Maxbandwidth 
        Maximum bandwidth, in Kbps, allocated for all the services in the service group. 
    .PARAMETER Monthreshold 
        Minimum sum of weights of the monitors that are bound to this service. Used to determine whether to mark a service as UP or DOWN. 
    .PARAMETER State 
        Initial state of the service group. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with all the services in the service group whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile that contains TCP configuration settings for the service group. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile that contains HTTP configuration settings for the service group. 
    .PARAMETER Comment 
        Any information about the service group. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information for the specified service group. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Network profile for the service group. 
    .PARAMETER Autoscale 
        Auto scale option for a servicegroup. 
        Possible values = DISABLED, DNS, POLICY, CLOUD, API 
    .PARAMETER Memberport 
        member port. 
    .PARAMETER Autodisablegraceful 
        Indicates graceful shutdown of the service. System will wait for all outstanding connections to this service to be closed before disabling the service. 
        Possible values = YES, NO 
    .PARAMETER Autodisabledelay 
        The time allowed (in seconds) for a graceful shutdown. During this period, new connections or requests will continue to be sent to this service for clients who already have a persistent session on the system. Connections or requests from fresh or new clients who do not yet have a persistence sessions on the system will not be sent to the service. Instead, they will be load balanced among other available services. After the delay time expires, no new requests or connections will be sent to the service. 
    .PARAMETER Monconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set. 
        Possible values = RESET, FIN 
    .PARAMETER PassThru 
        Return details about the created servicegroup item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddServicegroup -servicegroupname <string> -servicetype <string>
        An example how to add servicegroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddServicegroup
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup/
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
        [string]$Servicegroupname,

        [Parameter(Mandatory)]
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'DTLS', 'NNTP', 'RPCSVR', 'DNS', 'ADNS', 'SNMP', 'RTSP', 'DHCPRA', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'DNS_TCP', 'ADNS_TCP', 'MYSQL', 'MSSQL', 'ORACLE', 'MONGO', 'MONGO_TLS', 'RADIUS', 'RADIUSListener', 'RDP', 'DIAMETER', 'SSL_DIAMETER', 'TFTP', 'SMPP', 'PPTP', 'GRE', 'SYSLOGTCP', 'SYSLOGUDP', 'FIX', 'SSL_FIX', 'USER_TCP', 'USER_SSL_TCP', 'QUIC', 'IPFIX', 'LOGSTREAM', 'LOGSTREAM_SSL', 'MQTT', 'MQTT_TLS', 'QUIC_BRIDGE')]
        [string]$Servicetype,

        [ValidateSet('TRANSPARENT', 'REVERSE', 'FORWARD')]
        [string]$Cachetype,

        [ValidateRange(0, 4094)]
        [double]$Td,

        [ValidateRange(0, 4294967294)]
        [double]$Maxclient,

        [ValidateRange(0, 65535)]
        [double]$Maxreq,

        [ValidateSet('YES', 'NO')]
        [string]$Cacheable = 'NO',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cipheader,

        [ValidateSet('YES', 'NO')]
        [string]$Usip,

        [ValidateSet('YES', 'NO')]
        [string]$Pathmonitor,

        [ValidateSet('YES', 'NO')]
        [string]$Pathmonitorindv,

        [ValidateSet('YES', 'NO')]
        [string]$Useproxyport,

        [ValidateSet('YES', 'NO')]
        [string]$Healthmonitor = 'YES',

        [ValidateSet('ON', 'OFF')]
        [string]$Sp = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Rtspsessionidremap = 'OFF',

        [ValidateRange(0, 31536000)]
        [double]$Clttimeout,

        [ValidateRange(0, 31536000)]
        [double]$Svrtimeout,

        [ValidateSet('YES', 'NO')]
        [string]$Cka,

        [ValidateSet('YES', 'NO')]
        [string]$Tcpb,

        [ValidateSet('YES', 'NO')]
        [string]$Cmp,

        [ValidateRange(0, 4294967287)]
        [double]$Maxbandwidth,

        [ValidateRange(0, 65535)]
        [double]$Monthreshold,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush = 'ENABLED',

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateLength(1, 127)]
        [string]$Httpprofilename,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog = 'ENABLED',

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateSet('DISABLED', 'DNS', 'POLICY', 'CLOUD', 'API')]
        [string]$Autoscale = 'DISABLED',

        [int]$Memberport,

        [ValidateSet('YES', 'NO')]
        [string]$Autodisablegraceful = 'NO',

        [double]$Autodisabledelay,

        [ValidateSet('RESET', 'FIN')]
        [string]$Monconnectionclose = 'NONE',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddServicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname
                servicetype                = $servicetype
            }
            if ( $PSBoundParameters.ContainsKey('cachetype') ) { $payload.Add('cachetype', $cachetype) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('maxreq') ) { $payload.Add('maxreq', $maxreq) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('usip') ) { $payload.Add('usip', $usip) }
            if ( $PSBoundParameters.ContainsKey('pathmonitor') ) { $payload.Add('pathmonitor', $pathmonitor) }
            if ( $PSBoundParameters.ContainsKey('pathmonitorindv') ) { $payload.Add('pathmonitorindv', $pathmonitorindv) }
            if ( $PSBoundParameters.ContainsKey('useproxyport') ) { $payload.Add('useproxyport', $useproxyport) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('sp') ) { $payload.Add('sp', $sp) }
            if ( $PSBoundParameters.ContainsKey('rtspsessionidremap') ) { $payload.Add('rtspsessionidremap', $rtspsessionidremap) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('cka') ) { $payload.Add('cka', $cka) }
            if ( $PSBoundParameters.ContainsKey('tcpb') ) { $payload.Add('tcpb', $tcpb) }
            if ( $PSBoundParameters.ContainsKey('cmp') ) { $payload.Add('cmp', $cmp) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('autoscale') ) { $payload.Add('autoscale', $autoscale) }
            if ( $PSBoundParameters.ContainsKey('memberport') ) { $payload.Add('memberport', $memberport) }
            if ( $PSBoundParameters.ContainsKey('autodisablegraceful') ) { $payload.Add('autodisablegraceful', $autodisablegraceful) }
            if ( $PSBoundParameters.ContainsKey('autodisabledelay') ) { $payload.Add('autodisabledelay', $autodisabledelay) }
            if ( $PSBoundParameters.ContainsKey('monconnectionclose') ) { $payload.Add('monconnectionclose', $monconnectionclose) }
            if ( $PSCmdlet.ShouldProcess("servicegroup", "Add Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type servicegroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetServicegroup -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddServicegroup: Finished"
    }
}

function Invoke-ADCGetServicegroup {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Configuration for service group resource.
    .PARAMETER Servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER GetAll 
        Retrieve all servicegroup object(s).
    .PARAMETER Count
        If specified, the count of the servicegroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicegroup -GetAll 
        Get all servicegroup data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicegroup -Count 
        Get the number of servicegroup objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroup -name <string>
        Get servicegroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroup -Filter @{ 'name'='<value>' }
        Get servicegroup data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServicegroup
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup/
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
        [string]$Servicegroupname,

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
        Write-Verbose "Invoke-ADCGetServicegroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all servicegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroup configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServicegroup: Ended"
    }
}

function Invoke-ADCGetServicegroupbindings {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Configuration for servicegroupbind resource.
    .PARAMETER Servicegroupname 
        The name of the service. 
    .PARAMETER GetAll 
        Retrieve all servicegroupbindings object(s).
    .PARAMETER Count
        If specified, the count of the servicegroupbindings object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroupbindings
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicegroupbindings -GetAll 
        Get all servicegroupbindings data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicegroupbindings -Count 
        Get the number of servicegroupbindings objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroupbindings -name <string>
        Get servicegroupbindings object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroupbindings -Filter @{ 'name'='<value>' }
        Get servicegroupbindings data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServicegroupbindings
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroupbindings/
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
        [string]$Servicegroupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetServicegroupbindings: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all servicegroupbindings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroupbindings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroupbindings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroupbindings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroupbindings objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroupbindings -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroupbindings configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroupbindings -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroupbindings configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroupbindings -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServicegroupbindings: Ended"
    }
}

function Invoke-ADCGetServicegroupbinding {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER GetAll 
        Retrieve all servicegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the servicegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicegroupbinding -GetAll 
        Get all servicegroup_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroupbinding -name <string>
        Get servicegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroupbinding -Filter @{ 'name'='<value>' }
        Get servicegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServicegroupbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_binding/
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
        [string]$Servicegroupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetServicegroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all servicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroup_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServicegroupbinding: Ended"
    }
}

function Invoke-ADCAddServicegrouplbmonitorbinding {
    <#
    .SYNOPSIS
        Add Basic configuration Object.
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER Port 
        Port number of the service. Each service must have a unique port number. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Monitor_name 
        Monitor name. 
    .PARAMETER Monstate 
        Monitor state. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Passive 
        Indicates if load monitor is passive. A passive load monitor does not remove service from LB decision when threshold is breached. 
    .PARAMETER Weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service. 
    .PARAMETER Customserverid 
        Unique service identifier. Used when the persistency type for the virtual server is set to Custom Server ID. 
    .PARAMETER Serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER State 
        Initial state of the service after binding. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Hashid 
        Unique numerical identifier used by hash based load balancing methods to identify a service. 
    .PARAMETER Nameserver 
        Specify the nameserver to which the query for bound domain needs to be sent. If not specified, use the global nameserver. 
    .PARAMETER Dbsttl 
        Specify the TTL for DNS record for domain based service.The default value of ttl is 0 which indicates to use the TTL received in DNS response for monitors. 
    .PARAMETER PassThru 
        Return details about the created servicegroup_lbmonitor_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddServicegrouplbmonitorbinding -servicegroupname <string>
        An example how to add servicegroup_lbmonitor_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddServicegrouplbmonitorbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_lbmonitor_binding/
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
        [string]$Servicegroupname,

        [ValidateRange(1, 65535)]
        [int]$Port,

        [string]$Monitor_name,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Monstate,

        [boolean]$Passive,

        [ValidateRange(1, 100)]
        [double]$Weight,

        [string]$Customserverid = '"None"',

        [double]$Serverid,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [double]$Hashid,

        [string]$Nameserver,

        [double]$Dbsttl = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddServicegrouplbmonitorbinding: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('monitor_name') ) { $payload.Add('monitor_name', $monitor_name) }
            if ( $PSBoundParameters.ContainsKey('monstate') ) { $payload.Add('monstate', $monstate) }
            if ( $PSBoundParameters.ContainsKey('passive') ) { $payload.Add('passive', $passive) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('customserverid') ) { $payload.Add('customserverid', $customserverid) }
            if ( $PSBoundParameters.ContainsKey('serverid') ) { $payload.Add('serverid', $serverid) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('nameserver') ) { $payload.Add('nameserver', $nameserver) }
            if ( $PSBoundParameters.ContainsKey('dbsttl') ) { $payload.Add('dbsttl', $dbsttl) }
            if ( $PSCmdlet.ShouldProcess("servicegroup_lbmonitor_binding", "Add Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type servicegroup_lbmonitor_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetServicegrouplbmonitorbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddServicegrouplbmonitorbinding: Finished"
    }
}

function Invoke-ADCDeleteServicegrouplbmonitorbinding {
    <#
    .SYNOPSIS
        Delete Basic configuration Object.
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER Port 
        Port number of the service. Each service must have a unique port number. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Monitor_name 
        Monitor name.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteServicegrouplbmonitorbinding -Servicegroupname <string>
        An example how to delete servicegroup_lbmonitor_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteServicegrouplbmonitorbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_lbmonitor_binding/
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
        [string]$Servicegroupname,

        [int]$Port,

        [string]$Monitor_name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteServicegrouplbmonitorbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Port') ) { $arguments.Add('port', $Port) }
            if ( $PSBoundParameters.ContainsKey('Monitor_name') ) { $arguments.Add('monitor_name', $Monitor_name) }
            if ( $PSCmdlet.ShouldProcess("$servicegroupname", "Delete Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type servicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteServicegrouplbmonitorbinding: Finished"
    }
}

function Invoke-ADCGetServicegrouplbmonitorbinding {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER GetAll 
        Retrieve all servicegroup_lbmonitor_binding object(s).
    .PARAMETER Count
        If specified, the count of the servicegroup_lbmonitor_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegrouplbmonitorbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicegrouplbmonitorbinding -GetAll 
        Get all servicegroup_lbmonitor_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicegrouplbmonitorbinding -Count 
        Get the number of servicegroup_lbmonitor_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegrouplbmonitorbinding -name <string>
        Get servicegroup_lbmonitor_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegrouplbmonitorbinding -Filter @{ 'name'='<value>' }
        Get servicegroup_lbmonitor_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServicegrouplbmonitorbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_lbmonitor_binding/
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
        [string]$Servicegroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetServicegrouplbmonitorbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all servicegroup_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroup_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroup_lbmonitor_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroup_lbmonitor_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroup_lbmonitor_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServicegrouplbmonitorbinding: Ended"
    }
}

function Invoke-ADCGetServicegroupservicegroupentitymonbindingsbinding {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Binding object showing the servicegroupentitymonbindings that can be bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER GetAll 
        Retrieve all servicegroup_servicegroupentitymonbindings_binding object(s).
    .PARAMETER Count
        If specified, the count of the servicegroup_servicegroupentitymonbindings_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroupservicegroupentitymonbindingsbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicegroupservicegroupentitymonbindingsbinding -GetAll 
        Get all servicegroup_servicegroupentitymonbindings_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicegroupservicegroupentitymonbindingsbinding -Count 
        Get the number of servicegroup_servicegroupentitymonbindings_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroupservicegroupentitymonbindingsbinding -name <string>
        Get servicegroup_servicegroupentitymonbindings_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroupservicegroupentitymonbindingsbinding -Filter @{ 'name'='<value>' }
        Get servicegroup_servicegroupentitymonbindings_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServicegroupservicegroupentitymonbindingsbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_servicegroupentitymonbindings_binding/
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
        [string]$Servicegroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetServicegroupservicegroupentitymonbindingsbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all servicegroup_servicegroupentitymonbindings_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroup_servicegroupentitymonbindings_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroup_servicegroupentitymonbindings_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroup_servicegroupentitymonbindings_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroup_servicegroupentitymonbindings_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServicegroupservicegroupentitymonbindingsbinding: Ended"
    }
}

function Invoke-ADCAddServicegroupservicegroupmemberlistbinding {
    <#
    .SYNOPSIS
        Add Basic configuration Object.
    .DESCRIPTION
        Binding object showing the servicegroupmemberlist that can be bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER Members 
        Desired servicegroupmember binding set. Any existing servicegroupmember which is not part of the input will be deleted or disabled based on graceful setting on servicegroup.
    .EXAMPLE
        PS C:\>Invoke-ADCAddServicegroupservicegroupmemberlistbinding -servicegroupname <string>
        An example how to add servicegroup_servicegroupmemberlist_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddServicegroupservicegroupmemberlistbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_servicegroupmemberlist_binding/
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
        [string]$Servicegroupname,

        [object[]]$Members 
    )
    begin {
        Write-Verbose "Invoke-ADCAddServicegroupservicegroupmemberlistbinding: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('members') ) { $payload.Add('members', $members) }
            if ( $PSCmdlet.ShouldProcess("servicegroup_servicegroupmemberlist_binding", "Add Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type servicegroup_servicegroupmemberlist_binding -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCAddServicegroupservicegroupmemberlistbinding: Finished"
    }
}

function Invoke-ADCDeleteServicegroupservicegroupmemberlistbinding {
    <#
    .SYNOPSIS
        Delete Basic configuration Object.
    .DESCRIPTION
        Binding object showing the servicegroupmemberlist that can be bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteServicegroupservicegroupmemberlistbinding -Servicegroupname <string>
        An example how to delete servicegroup_servicegroupmemberlist_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteServicegroupservicegroupmemberlistbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_servicegroupmemberlist_binding/
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
        [string]$Servicegroupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteServicegroupservicegroupmemberlistbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$servicegroupname", "Delete Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type servicegroup_servicegroupmemberlist_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteServicegroupservicegroupmemberlistbinding: Finished"
    }
}

function Invoke-ADCAddServicegroupservicegroupmemberbinding {
    <#
    .SYNOPSIS
        Add Basic configuration Object.
    .DESCRIPTION
        Binding object showing the servicegroupmember that can be bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER Ip 
        IP Address. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service. 
    .PARAMETER Customserverid 
        The identifier for this IP:Port pair. Used when the persistency type is set to Custom Server ID. 
    .PARAMETER Serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER State 
        Initial state of the service group. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Hashid 
        The hash identifier for the service. This must be unique for each service. This parameter is used by hash based load balancing methods. 
    .PARAMETER Nameserver 
        Specify the nameserver to which the query for bound domain needs to be sent. If not specified, use the global nameserver. 
    .PARAMETER Dbsttl 
        Specify the TTL for DNS record for domain based service.The default value of ttl is 0 which indicates to use the TTL received in DNS response for monitors. 
    .PARAMETER PassThru 
        Return details about the created servicegroup_servicegroupmember_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddServicegroupservicegroupmemberbinding -servicegroupname <string>
        An example how to add servicegroup_servicegroupmember_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddServicegroupservicegroupmemberbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_servicegroupmember_binding/
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
        [string]$Servicegroupname,

        [string]$Ip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servername,

        [ValidateRange(1, 65535)]
        [int]$Port,

        [ValidateRange(1, 100)]
        [double]$Weight,

        [string]$Customserverid = '"None"',

        [double]$Serverid,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [double]$Hashid,

        [string]$Nameserver,

        [double]$Dbsttl = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddServicegroupservicegroupmemberbinding: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('ip') ) { $payload.Add('ip', $ip) }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('customserverid') ) { $payload.Add('customserverid', $customserverid) }
            if ( $PSBoundParameters.ContainsKey('serverid') ) { $payload.Add('serverid', $serverid) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('nameserver') ) { $payload.Add('nameserver', $nameserver) }
            if ( $PSBoundParameters.ContainsKey('dbsttl') ) { $payload.Add('dbsttl', $dbsttl) }
            if ( $PSCmdlet.ShouldProcess("servicegroup_servicegroupmember_binding", "Add Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type servicegroup_servicegroupmember_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetServicegroupservicegroupmemberbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddServicegroupservicegroupmemberbinding: Finished"
    }
}

function Invoke-ADCDeleteServicegroupservicegroupmemberbinding {
    <#
    .SYNOPSIS
        Delete Basic configuration Object.
    .DESCRIPTION
        Binding object showing the servicegroupmember that can be bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER Ip 
        IP Address. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
        * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteServicegroupservicegroupmemberbinding -Servicegroupname <string>
        An example how to delete servicegroup_servicegroupmember_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteServicegroupservicegroupmemberbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_servicegroupmember_binding/
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
        [string]$Servicegroupname,

        [string]$Ip,

        [string]$Servername,

        [int]$Port 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteServicegroupservicegroupmemberbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ip') ) { $arguments.Add('ip', $Ip) }
            if ( $PSBoundParameters.ContainsKey('Servername') ) { $arguments.Add('servername', $Servername) }
            if ( $PSBoundParameters.ContainsKey('Port') ) { $arguments.Add('port', $Port) }
            if ( $PSCmdlet.ShouldProcess("$servicegroupname", "Delete Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type servicegroup_servicegroupmember_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteServicegroupservicegroupmemberbinding: Finished"
    }
}

function Invoke-ADCGetServicegroupservicegroupmemberbinding {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Binding object showing the servicegroupmember that can be bound to servicegroup.
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER GetAll 
        Retrieve all servicegroup_servicegroupmember_binding object(s).
    .PARAMETER Count
        If specified, the count of the servicegroup_servicegroupmember_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroupservicegroupmemberbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicegroupservicegroupmemberbinding -GetAll 
        Get all servicegroup_servicegroupmember_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicegroupservicegroupmemberbinding -Count 
        Get the number of servicegroup_servicegroupmember_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroupservicegroupmemberbinding -name <string>
        Get servicegroup_servicegroupmember_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroupservicegroupmemberbinding -Filter @{ 'name'='<value>' }
        Get servicegroup_servicegroupmember_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServicegroupservicegroupmemberbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_servicegroupmember_binding/
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
        [string]$Servicegroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetServicegroupservicegroupmemberbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all servicegroup_servicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroup_servicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroup_servicegroupmember_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupmember_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroup_servicegroupmember_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupmember_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroup_servicegroupmember_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupmember_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServicegroupservicegroupmemberbinding: Ended"
    }
}

function Invoke-ADCGetServicebinding {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to service.
    .PARAMETER Name 
        Name of the service for which to display configuration details. 
    .PARAMETER GetAll 
        Retrieve all service_binding object(s).
    .PARAMETER Count
        If specified, the count of the service_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicebinding -GetAll 
        Get all service_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicebinding -name <string>
        Get service_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicebinding -Filter @{ 'name'='<value>' }
        Get service_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServicebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_binding/
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
        Write-Verbose "Invoke-ADCGetServicebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving service_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving service_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving service_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServicebinding: Ended"
    }
}

function Invoke-ADCAddServicedospolicybinding {
    <#
    .SYNOPSIS
        Add Basic configuration Object.
    .DESCRIPTION
        Binding object showing the dospolicy that can be bound to service.
    .PARAMETER Name 
        Name of the service to which to bind a policy or monitor. 
    .PARAMETER Policyname 
        The name of the policyname for which this service is bound. 
    .PARAMETER PassThru 
        Return details about the created service_dospolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddServicedospolicybinding -name <string>
        An example how to add service_dospolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddServicedospolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_dospolicy_binding.md/
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

        [string]$Policyname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddServicedospolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSCmdlet.ShouldProcess("service_dospolicy_binding", "Add Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type service_dospolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetServicedospolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddServicedospolicybinding: Finished"
    }
}

function Invoke-ADCDeleteServicedospolicybinding {
    <#
    .SYNOPSIS
        Delete Basic configuration Object.
    .DESCRIPTION
        Binding object showing the dospolicy that can be bound to service.
    .PARAMETER Name 
        Name of the service to which to bind a policy or monitor. 
    .PARAMETER Policyname 
        The name of the policyname for which this service is bound.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteServicedospolicybinding -Name <string>
        An example how to delete service_dospolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteServicedospolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_dospolicy_binding.md/
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

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteServicedospolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type service_dospolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteServicedospolicybinding: Finished"
    }
}

function Invoke-ADCGetServicedospolicybinding {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Binding object showing the dospolicy that can be bound to service.
    .PARAMETER Name 
        Name of the service to which to bind a policy or monitor. 
    .PARAMETER GetAll 
        Retrieve all service_dospolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the service_dospolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicedospolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicedospolicybinding -GetAll 
        Get all service_dospolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicedospolicybinding -Count 
        Get the number of service_dospolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicedospolicybinding -name <string>
        Get service_dospolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicedospolicybinding -Filter @{ 'name'='<value>' }
        Get service_dospolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServicedospolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_dospolicy_binding.md/
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
        Write-Verbose "Invoke-ADCGetServicedospolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all service_dospolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_dospolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for service_dospolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_dospolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving service_dospolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_dospolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving service_dospolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_dospolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving service_dospolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_dospolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServicedospolicybinding: Ended"
    }
}

function Invoke-ADCAddServicelbmonitorbinding {
    <#
    .SYNOPSIS
        Add Basic configuration Object.
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to service.
    .PARAMETER Name 
        Name of the service to which to bind a monitor. 
    .PARAMETER Monitor_name 
        The monitor Names. 
    .PARAMETER Monstate 
        The configured state (enable/disable) of the monitor on this server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Weight 
        Weight to assign to the monitor-service binding. When a monitor is UP, the weight assigned to its binding with the service determines how much the monitor contributes toward keeping the health of the service above the value configured for the Monitor Threshold parameter. 
    .PARAMETER Passive 
        Indicates if load monitor is passive. A passive load monitor does not remove service from LB decision when threshold is breached. 
    .PARAMETER PassThru 
        Return details about the created service_lbmonitor_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddServicelbmonitorbinding -name <string>
        An example how to add service_lbmonitor_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddServicelbmonitorbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_lbmonitor_binding/
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

        [string]$Monitor_name,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Monstate,

        [ValidateRange(1, 100)]
        [double]$Weight,

        [boolean]$Passive,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddServicelbmonitorbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('monitor_name') ) { $payload.Add('monitor_name', $monitor_name) }
            if ( $PSBoundParameters.ContainsKey('monstate') ) { $payload.Add('monstate', $monstate) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('passive') ) { $payload.Add('passive', $passive) }
            if ( $PSCmdlet.ShouldProcess("service_lbmonitor_binding", "Add Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type service_lbmonitor_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetServicelbmonitorbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddServicelbmonitorbinding: Finished"
    }
}

function Invoke-ADCDeleteServicelbmonitorbinding {
    <#
    .SYNOPSIS
        Delete Basic configuration Object.
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to service.
    .PARAMETER Name 
        Name of the service to which to bind a monitor. 
    .PARAMETER Monitor_name 
        The monitor Names.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteServicelbmonitorbinding -Name <string>
        An example how to delete service_lbmonitor_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteServicelbmonitorbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_lbmonitor_binding/
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

        [string]$Monitor_name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteServicelbmonitorbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Monitor_name') ) { $arguments.Add('monitor_name', $Monitor_name) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type service_lbmonitor_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteServicelbmonitorbinding: Finished"
    }
}

function Invoke-ADCGetServicelbmonitorbinding {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to service.
    .PARAMETER Name 
        Name of the service to which to bind a monitor. 
    .PARAMETER GetAll 
        Retrieve all service_lbmonitor_binding object(s).
    .PARAMETER Count
        If specified, the count of the service_lbmonitor_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicelbmonitorbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicelbmonitorbinding -GetAll 
        Get all service_lbmonitor_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicelbmonitorbinding -Count 
        Get the number of service_lbmonitor_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicelbmonitorbinding -name <string>
        Get service_lbmonitor_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicelbmonitorbinding -Filter @{ 'name'='<value>' }
        Get service_lbmonitor_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServicelbmonitorbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_lbmonitor_binding/
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
        Write-Verbose "Invoke-ADCGetServicelbmonitorbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all service_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for service_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving service_lbmonitor_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_lbmonitor_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving service_lbmonitor_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_lbmonitor_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving service_lbmonitor_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_lbmonitor_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServicelbmonitorbinding: Ended"
    }
}

function Invoke-ADCAddServicescpolicybinding {
    <#
    .SYNOPSIS
        Add Basic configuration Object.
    .DESCRIPTION
        Binding object showing the scpolicy that can be bound to service.
    .PARAMETER Name 
        Name of the service to which to bind a policy or monitor. 
    .PARAMETER Policyname 
        The name of the policyname for which this service is bound. 
    .PARAMETER PassThru 
        Return details about the created service_scpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddServicescpolicybinding -name <string>
        An example how to add service_scpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddServicescpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_scpolicy_binding.md/
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

        [string]$Policyname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddServicescpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSCmdlet.ShouldProcess("service_scpolicy_binding", "Add Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type service_scpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetServicescpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddServicescpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteServicescpolicybinding {
    <#
    .SYNOPSIS
        Delete Basic configuration Object.
    .DESCRIPTION
        Binding object showing the scpolicy that can be bound to service.
    .PARAMETER Name 
        Name of the service to which to bind a policy or monitor. 
    .PARAMETER Policyname 
        The name of the policyname for which this service is bound.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteServicescpolicybinding -Name <string>
        An example how to delete service_scpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteServicescpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_scpolicy_binding.md/
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

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteServicescpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type service_scpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteServicescpolicybinding: Finished"
    }
}

function Invoke-ADCGetServicescpolicybinding {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Binding object showing the scpolicy that can be bound to service.
    .PARAMETER Name 
        Name of the service to which to bind a policy or monitor. 
    .PARAMETER GetAll 
        Retrieve all service_scpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the service_scpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicescpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicescpolicybinding -GetAll 
        Get all service_scpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicescpolicybinding -Count 
        Get the number of service_scpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicescpolicybinding -name <string>
        Get service_scpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicescpolicybinding -Filter @{ 'name'='<value>' }
        Get service_scpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServicescpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_scpolicy_binding.md/
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
        Write-Verbose "Invoke-ADCGetServicescpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all service_scpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_scpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for service_scpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_scpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving service_scpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_scpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving service_scpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_scpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving service_scpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_scpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServicescpolicybinding: Ended"
    }
}

function Invoke-ADCGetSvcbindings {
    <#
    .SYNOPSIS
        Get Basic configuration object(s).
    .DESCRIPTION
        Configuration for service bindings resource.
    .PARAMETER Servicename 
        The name of the service. 
    .PARAMETER GetAll 
        Retrieve all svcbindings object(s).
    .PARAMETER Count
        If specified, the count of the svcbindings object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSvcbindings
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSvcbindings -GetAll 
        Get all svcbindings data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSvcbindings -Count 
        Get the number of svcbindings objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSvcbindings -name <string>
        Get svcbindings object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSvcbindings -Filter @{ 'name'='<value>' }
        Get svcbindings data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSvcbindings
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/svcbindings/
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
        [string]$Servicename,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetSvcbindings: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all svcbindings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type svcbindings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for svcbindings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type svcbindings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving svcbindings objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type svcbindings -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving svcbindings configuration for property 'servicename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type svcbindings -NitroPath nitro/v1/config -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving svcbindings configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type svcbindings -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSvcbindings: Ended"
    }
}

function Invoke-ADCEnableVserver {
    <#
    .SYNOPSIS
        Enable Basic configuration Object.
    .DESCRIPTION
        Configuration for virtual server resource.
    .PARAMETER Name 
        The name of the virtual server to be removed.
    .EXAMPLE
        PS C:\>Invoke-ADCEnableVserver -name <string>
        An example how to enable vserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCEnableVserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/vserver/
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
        [string]$Name 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableVserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type vserver -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCEnableVserver: Finished"
    }
}

function Invoke-ADCDisableVserver {
    <#
    .SYNOPSIS
        Disable Basic configuration Object.
    .DESCRIPTION
        Configuration for virtual server resource.
    .PARAMETER Name 
        The name of the virtual server to be removed.
    .EXAMPLE
        PS C:\>Invoke-ADCDisableVserver -name <string>
        An example how to disable vserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDisableVserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/vserver/
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
        [string]$Name 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableVserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type vserver -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCDisableVserver: Finished"
    }
}

function Invoke-ADCDeleteVserver {
    <#
    .SYNOPSIS
        Delete Basic configuration Object.
    .DESCRIPTION
        Configuration for virtual server resource.
    .PARAMETER Name 
        The name of the virtual server to be removed.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteVserver -Name <string>
        An example how to delete vserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteVserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/vserver/
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
        Write-Verbose "Invoke-ADCDeleteVserver: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Basic configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type vserver -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteVserver: Finished"
    }
}

function Invoke-ADCUpdateVserver {
    <#
    .SYNOPSIS
        Update Basic configuration Object.
    .DESCRIPTION
        Configuration for virtual server resource.
    .PARAMETER Name 
        The name of the virtual server to be removed. 
    .PARAMETER Backupvserver 
        The name of the backup virtual server for this virtual server. 
    .PARAMETER Redirecturl 
        The URL where traffic is redirected if the virtual server in the system becomes unavailable. 
    .PARAMETER Cacheable 
        Use this option to specify whether a virtual server (used for load balancing or content switching) routes requests to the cache redirection virtual server before sending it to the configured servers. 
        Possible values = YES, NO 
    .PARAMETER Clttimeout 
        The timeout value in seconds for idle client connection. 
    .PARAMETER Somethod 
        The spillover factor. The system will use this value to determine if it should send traffic to the backupvserver when the main virtual server reaches the spillover threshold. 
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER Sopersistence 
        The state of the spillover persistence. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sopersistencetimeout 
        The spillover persistence entry timeout. 
    .PARAMETER Sothreshold 
        The spillver threshold value. 
    .PARAMETER Pushvserver 
        The lb vserver of type PUSH/SSL_PUSH to which server pushes the updates received on the client facing non-push lb vserver.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateVserver -name <string>
        An example how to update vserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateVserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/vserver/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backupvserver,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Redirecturl,

        [ValidateSet('YES', 'NO')]
        [string]$Cacheable,

        [ValidateRange(0, 31536000)]
        [double]$Clttimeout,

        [ValidateSet('CONNECTION', 'DYNAMICCONNECTION', 'BANDWIDTH', 'HEALTH', 'NONE')]
        [string]$Somethod,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sopersistence,

        [ValidateRange(2, 1440)]
        [double]$Sopersistencetimeout,

        [ValidateRange(1, 4294967294)]
        [double]$Sothreshold,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Pushvserver 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateVserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('redirecturl') ) { $payload.Add('redirecturl', $redirecturl) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('somethod') ) { $payload.Add('somethod', $somethod) }
            if ( $PSBoundParameters.ContainsKey('sopersistence') ) { $payload.Add('sopersistence', $sopersistence) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('pushvserver') ) { $payload.Add('pushvserver', $pushvserver) }
            if ( $PSCmdlet.ShouldProcess("vserver", "Update Basic configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type vserver -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateVserver: Finished"
    }
}

# SIG # Begin signature block
# MIIkrQYJKoZIhvcNAQcCoIIknjCCJJoCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBRTjyasoLzNcOc
# iNIEtMznO9eYwpY9BJ3d/D/9XbUtVKCCHnAwggTzMIID26ADAgECAhAsJ03zZBC0
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
# LqPzW0sH3DJZ84enGm1YMIIG7DCCBNSgAwIBAgIQMA9vrN1mmHR8qUY2p3gtuTAN
# BgkqhkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJz
# ZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNU
# IE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBB
# dXRob3JpdHkwHhcNMTkwNTAyMDAwMDAwWhcNMzgwMTE4MjM1OTU5WjB9MQswCQYD
# VQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
# YWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJTAjBgNVBAMTHFNlY3Rp
# Z28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAw
# ggIKAoICAQDIGwGv2Sx+iJl9AZg/IJC9nIAhVJO5z6A+U++zWsB21hoEpc5Hg7Xr
# xMxJNMvzRWW5+adkFiYJ+9UyUnkuyWPCE5u2hj8BBZJmbyGr1XEQeYf0RirNxFrJ
# 29ddSU1yVg/cyeNTmDoqHvzOWEnTv/M5u7mkI0Ks0BXDf56iXNc48RaycNOjxN+z
# xXKsLgp3/A2UUrf8H5VzJD0BKLwPDU+zkQGObp0ndVXRFzs0IXuXAZSvf4DP0REK
# V4TJf1bgvUacgr6Unb+0ILBgfrhN9Q0/29DqhYyKVnHRLZRMyIw80xSinL0m/9NT
# IMdgaZtYClT0Bef9Maz5yIUXx7gpGaQpL0bj3duRX58/Nj4OMGcrRrc1r5a+2kxg
# zKi7nw0U1BjEMJh0giHPYla1IXMSHv2qyghYh3ekFesZVf/QOVQtJu5FGjpvzdeE
# 8NfwKMVPZIMC1Pvi3vG8Aij0bdonigbSlofe6GsO8Ft96XZpkyAcSpcsdxkrk5WY
# nJee647BeFbGRCXfBhKaBi2fA179g6JTZ8qx+o2hZMmIklnLqEbAyfKm/31X2xJ2
# +opBJNQb/HKlFKLUrUMcpEmLQTkUAx4p+hulIq6lw02C0I3aa7fb9xhAV3PwcaP7
# Sn1FNsH3jYL6uckNU4B9+rY5WDLvbxhQiddPnTO9GrWdod6VQXqngwIDAQABo4IB
# WjCCAVYwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYE
# FBqh+GEZIA/DQXdFKI7RNV8GEgRVMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8E
# CDAGAQH/AgEAMBMGA1UdJQQMMAoGCCsGAQUFBwMIMBEGA1UdIAQKMAgwBgYEVR0g
# ADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNF
# UlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEE
# ajBoMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRy
# dXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVz
# ZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggIBAG1UgaUzXRbhtVOBkXXfA3oy
# Cy0lhBGysNsqfSoF9bw7J/RaoLlJWZApbGHLtVDb4n35nwDvQMOt0+LkVvlYQc/x
# QuUQff+wdB+PxlwJ+TNe6qAcJlhc87QRD9XVw+K81Vh4v0h24URnbY+wQxAPjeT5
# OGK/EwHFhaNMxcyyUzCVpNb0llYIuM1cfwGWvnJSajtCN3wWeDmTk5SbsdyybUFt
# Z83Jb5A9f0VywRsj1sJVhGbks8VmBvbz1kteraMrQoohkv6ob1olcGKBc2NeoLvY
# 3NdK0z2vgwY4Eh0khy3k/ALWPncEvAQ2ted3y5wujSMYuaPCRx3wXdahc1cFaJqn
# yTdlHb7qvNhCg0MFpYumCf/RoZSmTqo9CfUFbLfSZFrYKiLCS53xOV5M3kg9mzSW
# mglfjv33sVKRzj+J9hyhtal1H3G/W0NdZT1QgW6r8NDT/LKzH7aZlib0PHmLXGTM
# ze4nmuWgwAxyh8FuTVrTHurwROYybxzrF06Uw3hlIDsPQaof6aFBnf6xuKBlKjTg
# 3qj5PObBMLvAoGMs/FwWAKjQxH/qEZ0eBsambTJdtDgJK0kHqv3sMNrxpy/Pt/36
# 0KOE2See+wFmd7lWEOEgbsausfm2usg1XTN2jvF8IAwqd661ogKGuinutFoAsYyr
# 4/kKyVRd1LlqdJ69SK6YMIIHBzCCBO+gAwIBAgIRAIx3oACP9NGwxj2fOkiDjWsw
# DQYJKoZIhvcNAQEMBQAwfTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
# TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBM
# aW1pdGVkMSUwIwYDVQQDExxTZWN0aWdvIFJTQSBUaW1lIFN0YW1waW5nIENBMB4X
# DTIwMTAyMzAwMDAwMFoXDTMyMDEyMjIzNTk1OVowgYQxCzAJBgNVBAYTAkdCMRsw
# GQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAW
# BgNVBAoTD1NlY3RpZ28gTGltaXRlZDEsMCoGA1UEAwwjU2VjdGlnbyBSU0EgVGlt
# ZSBTdGFtcGluZyBTaWduZXIgIzIwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIK
# AoICAQCRh0ssi8HxHqCe0wfGAcpSsL55eV0JZgYtLzV9u8D7J9pCalkbJUzq70DW
# mn4yyGqBfbRcPlYQgTU6IjaM+/ggKYesdNAbYrw/ZIcCX+/FgO8GHNxeTpOHuJre
# TAdOhcxwxQ177MPZ45fpyxnbVkVs7ksgbMk+bP3wm/Eo+JGZqvxawZqCIDq37+fW
# uCVJwjkbh4E5y8O3Os2fUAQfGpmkgAJNHQWoVdNtUoCD5m5IpV/BiVhgiu/xrM2H
# YxiOdMuEh0FpY4G89h+qfNfBQc6tq3aLIIDULZUHjcf1CxcemuXWmWlRx06mnSlv
# 53mTDTJjU67MximKIMFgxvICLMT5yCLf+SeCoYNRwrzJghohhLKXvNSvRByWgiKV
# KoVUrvH9Pkl0dPyOrj+lcvTDWgGqUKWLdpUbZuvv2t+ULtka60wnfUwF9/gjXcRX
# yCYFevyBI19UCTgqYtWqyt/tz1OrH/ZEnNWZWcVWZFv3jlIPZvyYP0QGE2Ru6eEV
# YFClsezPuOjJC77FhPfdCp3avClsPVbtv3hntlvIXhQcua+ELXei9zmVN29OfxzG
# PATWMcV+7z3oUX5xrSR0Gyzc+Xyq78J2SWhi1Yv1A9++fY4PNnVGW5N2xIPugr4s
# rjcS8bxWw+StQ8O3ZpZelDL6oPariVD6zqDzCIEa0USnzPe4MQIDAQABo4IBeDCC
# AXQwHwYDVR0jBBgwFoAUGqH4YRkgD8NBd0UojtE1XwYSBFUwHQYDVR0OBBYEFGl1
# N3u7nTVCTr9X05rbnwHRrt7QMA4GA1UdDwEB/wQEAwIGwDAMBgNVHRMBAf8EAjAA
# MBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMIMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQEC
# AQMIMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMEQGA1Ud
# HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQVRp
# bWVTdGFtcGluZ0NBLmNybDB0BggrBgEFBQcBAQRoMGYwPwYIKwYBBQUHMAKGM2h0
# dHA6Ly9jcnQuc2VjdGlnby5jb20vU2VjdGlnb1JTQVRpbWVTdGFtcGluZ0NBLmNy
# dDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wDQYJKoZIhvcN
# AQEMBQADggIBAEoDeJBCM+x7GoMJNjOYVbudQAYwa0Vq8ZQOGVD/WyVeO+E5xFu6
# 6ZWQNze93/tk7OWCt5XMV1VwS070qIfdIoWmV7u4ISfUoCoxlIoHIZ6Kvaca9QIV
# y0RQmYzsProDd6aCApDCLpOpviE0dWO54C0PzwE3y42i+rhamq6hep4TkxlVjwmQ
# Lt/qiBcW62nW4SW9RQiXgNdUIChPynuzs6XSALBgNGXE48XDpeS6hap6adt1pD55
# aJo2i0OuNtRhcjwOhWINoF5w22QvAcfBoccklKOyPG6yXqLQ+qjRuCUcFubA1X9o
# GsRlKTUqLYi86q501oLnwIi44U948FzKwEBcwp/VMhws2jysNvcGUpqjQDAXsCkW
# mcmqt4hJ9+gLJTO1P22vn18KVt8SscPuzpF36CAT6Vwkx+pEC0rmE4QcTesNtbiG
# oDCni6GftCzMwBYjyZHlQgNLgM7kTeYqAT7AXoWgJKEXQNXb2+eYEKTx6hkbgFT6
# R4nomIGpdcAO39BolHmhoJ6OtrdCZsvZ2WsvTdjePjIeIOTsnE1CjZ3HM5mCN0TU
# JikmQI54L7nu+i/x8Y/+ULh43RSW3hwOcLAqhWqxbGjpKuQQK24h/dN8nTfkKgbW
# w/HXaONPB3mBCBP+smRe6bE85tB4I7IJLOImYr87qZdRzMdEMoGyr8/fMYIFkzCC
# BY8CAQEwgZAwfDELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
# c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVk
# MSQwIgYDVQQDExtTZWN0aWdvIFJTQSBDb2RlIFNpZ25pbmcgQ0ECECwnTfNkELSL
# /bju5S9Y3lMwDQYJYIZIAWUDBAIBBQCggYQwGAYKKwYBBAGCNwIBDDEKMAigAoAA
# oQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4w
# DAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQxIgQgN9DglPwq5OFKs03/qwM9hNvB
# +CW11VLGbuXFOxyKoxcwDQYJKoZIhvcNAQEBBQAEggEAP5CIznH99eaLUpvq6/Q5
# eaTN69Cds7Ne4qPq2mqaU5jSN19qnUns6DT0Sn92w6IasPUWeOscswl/r1/tKKjY
# QsRIG1dNvaoXxT3+lYoqFdZnKWWMiztdjz+ggPUtmXniHaPG20suPcI28WpkQaOv
# NxhmvvebC90yN7whiKDX0aOJwiUmEchZ2Y64Qsv9xEbyGsA1dd72vQfIpZnZJkdu
# enna0Z7FflWkwrYyZ/QRxPowVrcX2li+7VD8DCre4eXc0ZGcxEoxt8JjQco8bFTe
# dODDO6avSE/TAt7KQN1A+7WFxtr/0mtI82Jsvs6dM/CUS5Mx5Sb+9WgpR5PxTDL4
# gqGCA0wwggNIBgkqhkiG9w0BCQYxggM5MIIDNQIBATCBkjB9MQswCQYDVQQGEwJH
# QjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3Jk
# MRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNB
# IFRpbWUgU3RhbXBpbmcgQ0ECEQCMd6AAj/TRsMY9nzpIg41rMA0GCWCGSAFlAwQC
# AgUAoHkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
# MjIwMzMwMTkzMjM1WjA/BgkqhkiG9w0BCQQxMgQwvN/dIqjYy9Y9/9TLZY6BSGn8
# ftc0cOO/ARQnNb4E+XsGbvHWrJiApOXEdqfQJbx+MA0GCSqGSIb3DQEBAQUABIIC
# AEpP2VC8vZhGHsnEyyOxQmck8OAFV36C2BlU7lL3DfaCWEaf6Fig37q/fnRCvyEs
# DGNoS7dkfNAUTd6cc/kga4eoHZN6YP07Jicx77pvR3obdG2IO1EaechX0xw5uzmE
# ILSuMLoXCSqn/kzV4cbJBHGIf23XsRQ+F2eBa+neGthYuA976F8tD5Adn/QE4NdX
# q5a3ryKmD320aypee7BHAxAzOFr70iF8r0seaZ7drdWZedUGBnMxFGCbLnrB2Rjh
# QQ2Ck1zf3JwqcwEgzYDtGeupZte8f37zC0MJuXScvawefKw0pM9rglAHfy90Sz4n
# l6mWERIFpJc7ptDxuZJP5uDbSqYpdPA4dZMWD4eyLOAi/KryMF/twRJ+EFmbsey7
# 9nzZzmNHUQEBh2A+QY1HJtewFq0uXFqfD+WLxajnKLElYmSII++gTq2Biia+NJNr
# S3OJUyhNSA+L/SIlhE8LteGaA4uMrbPxBaoqRrjvyGzIlL12ikTz98PhbAXpIqza
# Z0TZQZAKFipiUqehieDioFJDjuXULT0qe1dLTvMACAW45mtGpBtHplSdDliX2RiL
# 7sMHZzcbm+FdCqA1P4O8OrrcStnTEWUPHHw1Tx7ZoBPbfBx+K3sqWKyNpIBjs9L1
# EQGHagvkOwJyfmj33tj0ZEhJRNvDp2TH7shD+mWf1VID
# SIG # End signature block
