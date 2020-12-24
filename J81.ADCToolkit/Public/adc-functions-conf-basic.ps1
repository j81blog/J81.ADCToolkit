function Invoke-ADCRestartDbsmonitors {
<#
    .SYNOPSIS
        Restart Basic configuration Object
    .DESCRIPTION
        Restart Basic configuration Object 
    .EXAMPLE
        Invoke-ADCRestartDbsmonitors 
    .NOTES
        File Name : Invoke-ADCRestartDbsmonitors
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/dbsmonitors/
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
        Write-Verbose "Invoke-ADCRestartDbsmonitors: Starting"
    }
    process {
        try {
            $Payload = @{

            }

            if ($PSCmdlet.ShouldProcess($Name, "Restart Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dbsmonitors -Action restart -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCRestartDbsmonitors: Finished"
    }
}

function Invoke-ADCUpdateExtendedmemoryparam {
<#
    .SYNOPSIS
        Update Basic configuration Object
    .DESCRIPTION
        Update Basic configuration Object 
    .PARAMETER memlimit 
        Amount of Citrix ADC memory to reserve for the memory used by LSN and Subscriber Session Store feature, in multiples of 2MB.  
        Note: If you later reduce the value of this parameter, the amount of active memory is not reduced. Changing the configured memory limit can only increase the amount of active memory.
    .EXAMPLE
        Invoke-ADCUpdateExtendedmemoryparam 
    .NOTES
        File Name : Invoke-ADCUpdateExtendedmemoryparam
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/extendedmemoryparam/
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

        [double]$memlimit 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateExtendedmemoryparam: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('memlimit')) { $Payload.Add('memlimit', $memlimit) }
 
            if ($PSCmdlet.ShouldProcess("extendedmemoryparam", "Update Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type extendedmemoryparam -Payload $Payload -GetWarning
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
        Unset Basic configuration Object
    .DESCRIPTION
        Unset Basic configuration Object 
   .PARAMETER memlimit 
       Amount of Citrix ADC memory to reserve for the memory used by LSN and Subscriber Session Store feature, in multiples of 2MB.  
       Note: If you later reduce the value of this parameter, the amount of active memory is not reduced. Changing the configured memory limit can only increase the amount of active memory.
    .EXAMPLE
        Invoke-ADCUnsetExtendedmemoryparam 
    .NOTES
        File Name : Invoke-ADCUnsetExtendedmemoryparam
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/extendedmemoryparam
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

        [Boolean]$memlimit 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetExtendedmemoryparam: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('memlimit')) { $Payload.Add('memlimit', $memlimit) }
            if ($PSCmdlet.ShouldProcess("extendedmemoryparam", "Unset Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type extendedmemoryparam -Action unset -Payload $Payload -GetWarning
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
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER GetAll 
        Retreive all extendedmemoryparam object(s)
    .PARAMETER Count
        If specified, the count of the extendedmemoryparam object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetExtendedmemoryparam
    .EXAMPLE 
        Invoke-ADCGetExtendedmemoryparam -GetAll
    .EXAMPLE
        Invoke-ADCGetExtendedmemoryparam -name <string>
    .EXAMPLE
        Invoke-ADCGetExtendedmemoryparam -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetExtendedmemoryparam
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/extendedmemoryparam/
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
        Write-Verbose "Invoke-ADCGetExtendedmemoryparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all extendedmemoryparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type extendedmemoryparam -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for extendedmemoryparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type extendedmemoryparam -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving extendedmemoryparam objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type extendedmemoryparam -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving extendedmemoryparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving extendedmemoryparam configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type extendedmemoryparam -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Basic configuration Object
    .DESCRIPTION
        Add Basic configuration Object 
    .PARAMETER ipfrom 
        First IP address in the range, in dotted decimal notation.  
        Minimum length = 1 
    .PARAMETER ipto 
        Last IP address in the range, in dotted decimal notation.  
        Minimum length = 1 
    .PARAMETER preferredlocation 
        String of qualifiers, in dotted notation, describing the geographical location of the IP address range. Each qualifier is more specific than the one that precedes it, as in continent.country.region.city.isp.organization. For example, "NA.US.CA.San Jose.ATT.citrix".  
        Note: A qualifier that includes a dot (.) or space ( ) must be enclosed in double quotation marks.  
        Minimum length = 1 
    .PARAMETER longitude 
        Numerical value, in degrees, specifying the longitude of the geographical location of the IP address-range.  
        Note: Longitude and latitude parameters are used for selecting a service with the static proximity GSLB method. If they are not specified, selection is based on the qualifiers specified for the location.  
        Minimum value = -180  
        Maximum value = 180 
    .PARAMETER latitude 
        Numerical value, in degrees, specifying the latitude of the geographical location of the IP address-range.  
        Note: Longitude and latitude parameters are used for selecting a service with the static proximity GSLB method. If they are not specified, selection is based on the qualifiers specified for the location.  
        Minimum value = -90  
        Maximum value = 90 
    .PARAMETER PassThru 
        Return details about the created location item.
    .EXAMPLE
        Invoke-ADCAddLocation -ipfrom <string> -ipto <string> -preferredlocation <string>
    .NOTES
        File Name : Invoke-ADCAddLocation
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/location/
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
        [string]$ipfrom ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ipto ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$preferredlocation ,

        [int]$longitude ,

        [int]$latitude ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLocation: Starting"
    }
    process {
        try {
            $Payload = @{
                ipfrom = $ipfrom
                ipto = $ipto
                preferredlocation = $preferredlocation
            }
            if ($PSBoundParameters.ContainsKey('longitude')) { $Payload.Add('longitude', $longitude) }
            if ($PSBoundParameters.ContainsKey('latitude')) { $Payload.Add('latitude', $latitude) }
 
            if ($PSCmdlet.ShouldProcess("location", "Add Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type location -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLocation -Filter $Payload)
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
        Delete Basic configuration Object
    .DESCRIPTION
        Delete Basic configuration Object
    .PARAMETER ipfrom 
       First IP address in the range, in dotted decimal notation.  
       Minimum length = 1    .PARAMETER ipto 
       Last IP address in the range, in dotted decimal notation.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteLocation -ipfrom <string>
    .NOTES
        File Name : Invoke-ADCDeleteLocation
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/location/
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
        [string]$ipfrom ,

        [string]$ipto 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLocation: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ipto')) { $Arguments.Add('ipto', $ipto) }
            if ($PSCmdlet.ShouldProcess("$ipfrom", "Delete Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type location -Resource $ipfrom -Arguments $Arguments
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
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER ipfrom 
       First IP address in the range, in dotted decimal notation. 
    .PARAMETER GetAll 
        Retreive all location object(s)
    .PARAMETER Count
        If specified, the count of the location object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLocation
    .EXAMPLE 
        Invoke-ADCGetLocation -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLocation -Count
    .EXAMPLE
        Invoke-ADCGetLocation -name <string>
    .EXAMPLE
        Invoke-ADCGetLocation -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLocation
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/location/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ipfrom,

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
        Write-Verbose "Invoke-ADCGetLocation: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all location objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type location -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for location objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type location -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving location objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type location -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving location configuration for property 'ipfrom'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type location -Resource $ipfrom -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving location configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type location -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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

function Invoke-ADCClearLocationdata {
<#
    .SYNOPSIS
        Clear Basic configuration Object
    .DESCRIPTION
        Clear Basic configuration Object 
    .EXAMPLE
        Invoke-ADCClearLocationdata 
    .NOTES
        File Name : Invoke-ADCClearLocationdata
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationdata/
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
        Write-Verbose "Invoke-ADCClearLocationdata: Starting"
    }
    process {
        try {
            $Payload = @{

            }

            if ($PSCmdlet.ShouldProcess($Name, "Clear Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type locationdata -Action clear -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCClearLocationdata: Finished"
    }
}

function Invoke-ADCAddLocationfile {
<#
    .SYNOPSIS
        Add Basic configuration Object
    .DESCRIPTION
        Add Basic configuration Object 
    .PARAMETER Locationfile 
        Name of the location file, with or without absolute path. If the path is not included, the default path (/var/netscaler/locdb) is assumed. In a high availability setup, the static database must be stored in the same location on both Citrix ADCs.  
        Minimum length = 1 
    .PARAMETER format 
        Format of the location file. Required for the Citrix ADC to identify how to read the location file.  
        Default value: netscaler  
        Possible values = netscaler, ip-country, ip-country-isp, ip-country-region-city, ip-country-region-city-isp, geoip-country, geoip-region, geoip-city, geoip-country-org, geoip-country-isp, geoip-city-isp-org
    .EXAMPLE
        Invoke-ADCAddLocationfile -Locationfile <string>
    .NOTES
        File Name : Invoke-ADCAddLocationfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationfile/
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
        [string]$Locationfile ,

        [ValidateSet('netscaler', 'ip-country', 'ip-country-isp', 'ip-country-region-city', 'ip-country-region-city-isp', 'geoip-country', 'geoip-region', 'geoip-city', 'geoip-country-org', 'geoip-country-isp', 'geoip-city-isp-org')]
        [string]$format = 'netscaler' 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLocationfile: Starting"
    }
    process {
        try {
            $Payload = @{
                Locationfile = $Locationfile
            }
            if ($PSBoundParameters.ContainsKey('format')) { $Payload.Add('format', $format) }
 
            if ($PSCmdlet.ShouldProcess("locationfile", "Add Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type locationfile -Payload $Payload -GetWarning
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
        Delete Basic configuration Object
    .DESCRIPTION
        Delete Basic configuration Object
  
    .EXAMPLE
        Invoke-ADCDeleteLocationfile 
    .NOTES
        File Name : Invoke-ADCDeleteLocationfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationfile/
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
        Write-Verbose "Invoke-ADCDeleteLocationfile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("locationfile", "Delete Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type locationfile -Resource $ -Arguments $Arguments
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

function Invoke-ADCImportLocationfile {
<#
    .SYNOPSIS
        Import Basic configuration Object
    .DESCRIPTION
        Import Basic configuration Object 
    .PARAMETER Locationfile 
        Name of the location file, with or without absolute path. If the path is not included, the default path (/var/netscaler/locdb) is assumed. In a high availability setup, the static database must be stored in the same location on both Citrix ADCs. 
    .PARAMETER src 
        URL \(protocol, host, path, and file name\) from where the location file will be imported.  
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access.
    .EXAMPLE
        Invoke-ADCImportLocationfile -Locationfile <string> -src <string>
    .NOTES
        File Name : Invoke-ADCImportLocationfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationfile/
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
        [string]$Locationfile ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 2047)]
        [string]$src 

    )
    begin {
        Write-Verbose "Invoke-ADCImportLocationfile: Starting"
    }
    process {
        try {
            $Payload = @{
                Locationfile = $Locationfile
                src = $src
            }

            if ($PSCmdlet.ShouldProcess($Name, "Import Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type locationfile -Action import -Payload $Payload -GetWarning
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

function Invoke-ADCGetLocationfile {
<#
    .SYNOPSIS
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER GetAll 
        Retreive all locationfile object(s)
    .PARAMETER Count
        If specified, the count of the locationfile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLocationfile
    .EXAMPLE 
        Invoke-ADCGetLocationfile -GetAll
    .EXAMPLE
        Invoke-ADCGetLocationfile -name <string>
    .EXAMPLE
        Invoke-ADCGetLocationfile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLocationfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationfile/
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
        Write-Verbose "Invoke-ADCGetLocationfile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all locationfile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationfile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for locationfile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationfile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving locationfile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationfile -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving locationfile configuration for property ''"

            } else {
                Write-Verbose "Retrieving locationfile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationfile -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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

function Invoke-ADCAddLocationfile6 {
<#
    .SYNOPSIS
        Add Basic configuration Object
    .DESCRIPTION
        Add Basic configuration Object 
    .PARAMETER Locationfile 
        Name of the IPv6 location file, with or without absolute path. If the path is not included, the default path (/var/netscaler/locdb) is assumed. In a high availability setup, the static database must be stored in the same location on both Citrix ADCs.  
        Minimum length = 1 
    .PARAMETER format 
        Format of the IPv6 location file. Required for the Citrix ADC to identify how to read the location file.  
        Default value: netscaler6  
        Possible values = netscaler6, geoip-country6
    .EXAMPLE
        Invoke-ADCAddLocationfile6 -Locationfile <string>
    .NOTES
        File Name : Invoke-ADCAddLocationfile6
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationfile6/
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
        [string]$Locationfile ,

        [ValidateSet('netscaler6', 'geoip-country6')]
        [string]$format = 'netscaler6' 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLocationfile6: Starting"
    }
    process {
        try {
            $Payload = @{
                Locationfile = $Locationfile
            }
            if ($PSBoundParameters.ContainsKey('format')) { $Payload.Add('format', $format) }
 
            if ($PSCmdlet.ShouldProcess("locationfile6", "Add Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type locationfile6 -Payload $Payload -GetWarning
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

function Invoke-ADCDeleteLocationfile6 {
<#
    .SYNOPSIS
        Delete Basic configuration Object
    .DESCRIPTION
        Delete Basic configuration Object
  
    .EXAMPLE
        Invoke-ADCDeleteLocationfile6 
    .NOTES
        File Name : Invoke-ADCDeleteLocationfile6
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationfile6/
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
        Write-Verbose "Invoke-ADCDeleteLocationfile6: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("locationfile6", "Delete Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type locationfile6 -Resource $ -Arguments $Arguments
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

function Invoke-ADCImportLocationfile6 {
<#
    .SYNOPSIS
        Import Basic configuration Object
    .DESCRIPTION
        Import Basic configuration Object 
    .PARAMETER Locationfile 
        Name of the IPv6 location file, with or without absolute path. If the path is not included, the default path (/var/netscaler/locdb) is assumed. In a high availability setup, the static database must be stored in the same location on both Citrix ADCs. 
    .PARAMETER src 
        URL \(protocol, host, path, and file name\) from where the location file will be imported.  
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access.
    .EXAMPLE
        Invoke-ADCImportLocationfile6 -Locationfile <string> -src <string>
    .NOTES
        File Name : Invoke-ADCImportLocationfile6
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationfile6/
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
        [string]$Locationfile ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 2047)]
        [string]$src 

    )
    begin {
        Write-Verbose "Invoke-ADCImportLocationfile6: Starting"
    }
    process {
        try {
            $Payload = @{
                Locationfile = $Locationfile
                src = $src
            }

            if ($PSCmdlet.ShouldProcess($Name, "Import Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type locationfile6 -Action import -Payload $Payload -GetWarning
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

function Invoke-ADCGetLocationfile6 {
<#
    .SYNOPSIS
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER GetAll 
        Retreive all locationfile6 object(s)
    .PARAMETER Count
        If specified, the count of the locationfile6 object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLocationfile6
    .EXAMPLE 
        Invoke-ADCGetLocationfile6 -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLocationfile6 -Count
    .EXAMPLE
        Invoke-ADCGetLocationfile6 -name <string>
    .EXAMPLE
        Invoke-ADCGetLocationfile6 -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLocationfile6
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationfile6/
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
        Write-Verbose "Invoke-ADCGetLocationfile6: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all locationfile6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationfile6 -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for locationfile6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationfile6 -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving locationfile6 objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationfile6 -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving locationfile6 configuration for property ''"

            } else {
                Write-Verbose "Retrieving locationfile6 configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationfile6 -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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

function Invoke-ADCUpdateLocationparameter {
<#
    .SYNOPSIS
        Update Basic configuration Object
    .DESCRIPTION
        Update Basic configuration Object 
    .PARAMETER context 
        Context for describing locations. In geographic context, qualifier labels are assigned by default in the following sequence: Continent.Country.Region.City.ISP.Organization. In custom context, the qualifiers labels can have any meaning that you designate.  
        Possible values = geographic, custom 
    .PARAMETER q1label 
        Label specifying the meaning of the first qualifier. Can be specified for custom context only.  
        Minimum length = 1 
    .PARAMETER q2label 
        Label specifying the meaning of the second qualifier. Can be specified for custom context only.  
        Minimum length = 1 
    .PARAMETER q3label 
        Label specifying the meaning of the third qualifier. Can be specified for custom context only.  
        Minimum length = 1 
    .PARAMETER q4label 
        Label specifying the meaning of the fourth qualifier. Can be specified for custom context only.  
        Minimum length = 1 
    .PARAMETER q5label 
        Label specifying the meaning of the fifth qualifier. Can be specified for custom context only.  
        Minimum length = 1 
    .PARAMETER q6label 
        Label specifying the meaning of the sixth qualifier. Can be specified for custom context only.  
        Minimum length = 1 
    .PARAMETER matchwildcardtoany 
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
        Default value: NO  
        Possible values = YES, NO, Expression
    .EXAMPLE
        Invoke-ADCUpdateLocationparameter 
    .NOTES
        File Name : Invoke-ADCUpdateLocationparameter
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationparameter/
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

        [ValidateSet('geographic', 'custom')]
        [string]$context ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$q1label ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$q2label ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$q3label ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$q4label ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$q5label ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$q6label ,

        [ValidateSet('YES', 'NO', 'Expression')]
        [string]$matchwildcardtoany 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLocationparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('context')) { $Payload.Add('context', $context) }
            if ($PSBoundParameters.ContainsKey('q1label')) { $Payload.Add('q1label', $q1label) }
            if ($PSBoundParameters.ContainsKey('q2label')) { $Payload.Add('q2label', $q2label) }
            if ($PSBoundParameters.ContainsKey('q3label')) { $Payload.Add('q3label', $q3label) }
            if ($PSBoundParameters.ContainsKey('q4label')) { $Payload.Add('q4label', $q4label) }
            if ($PSBoundParameters.ContainsKey('q5label')) { $Payload.Add('q5label', $q5label) }
            if ($PSBoundParameters.ContainsKey('q6label')) { $Payload.Add('q6label', $q6label) }
            if ($PSBoundParameters.ContainsKey('matchwildcardtoany')) { $Payload.Add('matchwildcardtoany', $matchwildcardtoany) }
 
            if ($PSCmdlet.ShouldProcess("locationparameter", "Update Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type locationparameter -Payload $Payload -GetWarning
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

function Invoke-ADCUnsetLocationparameter {
<#
    .SYNOPSIS
        Unset Basic configuration Object
    .DESCRIPTION
        Unset Basic configuration Object 
   .PARAMETER context 
       Context for describing locations. In geographic context, qualifier labels are assigned by default in the following sequence: Continent.Country.Region.City.ISP.Organization. In custom context, the qualifiers labels can have any meaning that you designate.  
       Possible values = geographic, custom 
   .PARAMETER q1label 
       Label specifying the meaning of the first qualifier. Can be specified for custom context only. 
   .PARAMETER q2label 
       Label specifying the meaning of the second qualifier. Can be specified for custom context only. 
   .PARAMETER q3label 
       Label specifying the meaning of the third qualifier. Can be specified for custom context only. 
   .PARAMETER q4label 
       Label specifying the meaning of the fourth qualifier. Can be specified for custom context only. 
   .PARAMETER q5label 
       Label specifying the meaning of the fifth qualifier. Can be specified for custom context only. 
   .PARAMETER q6label 
       Label specifying the meaning of the sixth qualifier. Can be specified for custom context only. 
   .PARAMETER matchwildcardtoany 
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
        Invoke-ADCUnsetLocationparameter 
    .NOTES
        File Name : Invoke-ADCUnsetLocationparameter
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationparameter
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

        [Boolean]$context ,

        [Boolean]$q1label ,

        [Boolean]$q2label ,

        [Boolean]$q3label ,

        [Boolean]$q4label ,

        [Boolean]$q5label ,

        [Boolean]$q6label ,

        [Boolean]$matchwildcardtoany 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLocationparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('context')) { $Payload.Add('context', $context) }
            if ($PSBoundParameters.ContainsKey('q1label')) { $Payload.Add('q1label', $q1label) }
            if ($PSBoundParameters.ContainsKey('q2label')) { $Payload.Add('q2label', $q2label) }
            if ($PSBoundParameters.ContainsKey('q3label')) { $Payload.Add('q3label', $q3label) }
            if ($PSBoundParameters.ContainsKey('q4label')) { $Payload.Add('q4label', $q4label) }
            if ($PSBoundParameters.ContainsKey('q5label')) { $Payload.Add('q5label', $q5label) }
            if ($PSBoundParameters.ContainsKey('q6label')) { $Payload.Add('q6label', $q6label) }
            if ($PSBoundParameters.ContainsKey('matchwildcardtoany')) { $Payload.Add('matchwildcardtoany', $matchwildcardtoany) }
            if ($PSCmdlet.ShouldProcess("locationparameter", "Unset Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type locationparameter -Action unset -Payload $Payload -GetWarning
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

function Invoke-ADCGetLocationparameter {
<#
    .SYNOPSIS
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER GetAll 
        Retreive all locationparameter object(s)
    .PARAMETER Count
        If specified, the count of the locationparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLocationparameter
    .EXAMPLE 
        Invoke-ADCGetLocationparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetLocationparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetLocationparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLocationparameter
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/locationparameter/
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
        Write-Verbose "Invoke-ADCGetLocationparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all locationparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationparameter -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for locationparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationparameter -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving locationparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationparameter -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving locationparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving locationparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type locationparameter -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER nodeid 
       Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retreive all nstrace object(s)
    .PARAMETER Count
        If specified, the count of the nstrace object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetNstrace
    .EXAMPLE 
        Invoke-ADCGetNstrace -GetAll
    .EXAMPLE
        Invoke-ADCGetNstrace -name <string>
    .EXAMPLE
        Invoke-ADCGetNstrace -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetNstrace
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/nstrace/
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
        [ValidateRange(0, 31)]
        [double]$nodeid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetNstrace: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all nstrace objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nstrace -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nstrace objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nstrace -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nstrace objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('nodeid')) { $Arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nstrace -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nstrace configuration for property ''"

            } else {
                Write-Verbose "Retrieving nstrace configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nstrace -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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

function Invoke-ADCAddRadiusnode {
<#
    .SYNOPSIS
        Add Basic configuration Object
    .DESCRIPTION
        Add Basic configuration Object 
    .PARAMETER nodeprefix 
        IP address/IP prefix of radius node in CIDR format. 
    .PARAMETER radkey 
        The key shared between the RADIUS server and clients.  
        Required for Citrix ADC to communicate with the RADIUS nodes. 
    .PARAMETER PassThru 
        Return details about the created radiusnode item.
    .EXAMPLE
        Invoke-ADCAddRadiusnode -nodeprefix <string> -radkey <string>
    .NOTES
        File Name : Invoke-ADCAddRadiusnode
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/radiusnode/
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
        [string]$nodeprefix ,

        [Parameter(Mandatory = $true)]
        [string]$radkey ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddRadiusnode: Starting"
    }
    process {
        try {
            $Payload = @{
                nodeprefix = $nodeprefix
                radkey = $radkey
            }

 
            if ($PSCmdlet.ShouldProcess("radiusnode", "Add Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type radiusnode -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetRadiusnode -Filter $Payload)
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

function Invoke-ADCUpdateRadiusnode {
<#
    .SYNOPSIS
        Update Basic configuration Object
    .DESCRIPTION
        Update Basic configuration Object 
    .PARAMETER nodeprefix 
        IP address/IP prefix of radius node in CIDR format. 
    .PARAMETER radkey 
        The key shared between the RADIUS server and clients.  
        Required for Citrix ADC to communicate with the RADIUS nodes. 
    .PARAMETER PassThru 
        Return details about the created radiusnode item.
    .EXAMPLE
        Invoke-ADCUpdateRadiusnode -nodeprefix <string>
    .NOTES
        File Name : Invoke-ADCUpdateRadiusnode
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/radiusnode/
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
        [string]$nodeprefix ,

        [string]$radkey ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateRadiusnode: Starting"
    }
    process {
        try {
            $Payload = @{
                nodeprefix = $nodeprefix
            }
            if ($PSBoundParameters.ContainsKey('radkey')) { $Payload.Add('radkey', $radkey) }
 
            if ($PSCmdlet.ShouldProcess("radiusnode", "Update Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type radiusnode -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetRadiusnode -Filter $Payload)
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

function Invoke-ADCDeleteRadiusnode {
<#
    .SYNOPSIS
        Delete Basic configuration Object
    .DESCRIPTION
        Delete Basic configuration Object
    .PARAMETER nodeprefix 
       IP address/IP prefix of radius node in CIDR format. 
    .EXAMPLE
        Invoke-ADCDeleteRadiusnode -nodeprefix <string>
    .NOTES
        File Name : Invoke-ADCDeleteRadiusnode
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/radiusnode/
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
        [string]$nodeprefix 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteRadiusnode: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$nodeprefix", "Delete Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type radiusnode -Resource $nodeprefix -Arguments $Arguments
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

function Invoke-ADCGetRadiusnode {
<#
    .SYNOPSIS
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER nodeprefix 
       IP address/IP prefix of radius node in CIDR format. 
    .PARAMETER GetAll 
        Retreive all radiusnode object(s)
    .PARAMETER Count
        If specified, the count of the radiusnode object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetRadiusnode
    .EXAMPLE 
        Invoke-ADCGetRadiusnode -GetAll 
    .EXAMPLE 
        Invoke-ADCGetRadiusnode -Count
    .EXAMPLE
        Invoke-ADCGetRadiusnode -name <string>
    .EXAMPLE
        Invoke-ADCGetRadiusnode -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetRadiusnode
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/radiusnode/
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
        [string]$nodeprefix,

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
        Write-Verbose "Invoke-ADCGetRadiusnode: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all radiusnode objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type radiusnode -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for radiusnode objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type radiusnode -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving radiusnode objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type radiusnode -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving radiusnode configuration for property 'nodeprefix'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type radiusnode -Resource $nodeprefix -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving radiusnode configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type radiusnode -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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

function Invoke-ADCEnableReporting {
<#
    .SYNOPSIS
        Enable Basic configuration Object
    .DESCRIPTION
        Enable Basic configuration Object 
    .EXAMPLE
        Invoke-ADCEnableReporting 
    .NOTES
        File Name : Invoke-ADCEnableReporting
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/reporting/
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
        Write-Verbose "Invoke-ADCEnableReporting: Starting"
    }
    process {
        try {
            $Payload = @{

            }

            if ($PSCmdlet.ShouldProcess($Name, "Enable Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type reporting -Action enable -Payload $Payload -GetWarning
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

function Invoke-ADCDisableReporting {
<#
    .SYNOPSIS
        Disable Basic configuration Object
    .DESCRIPTION
        Disable Basic configuration Object 
    .EXAMPLE
        Invoke-ADCDisableReporting 
    .NOTES
        File Name : Invoke-ADCDisableReporting
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/reporting/
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
        Write-Verbose "Invoke-ADCDisableReporting: Starting"
    }
    process {
        try {
            $Payload = @{

            }

            if ($PSCmdlet.ShouldProcess($Name, "Disable Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type reporting -Action disable -Payload $Payload -GetWarning
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

function Invoke-ADCGetReporting {
<#
    .SYNOPSIS
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER GetAll 
        Retreive all reporting object(s)
    .PARAMETER Count
        If specified, the count of the reporting object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetReporting
    .EXAMPLE 
        Invoke-ADCGetReporting -GetAll
    .EXAMPLE
        Invoke-ADCGetReporting -name <string>
    .EXAMPLE
        Invoke-ADCGetReporting -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetReporting
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/reporting/
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
        Write-Verbose "Invoke-ADCGetReporting: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all reporting objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type reporting -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for reporting objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type reporting -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving reporting objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type reporting -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving reporting configuration for property ''"

            } else {
                Write-Verbose "Retrieving reporting configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type reporting -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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

function Invoke-ADCAddServer {
<#
    .SYNOPSIS
        Add Basic configuration Object
    .DESCRIPTION
        Add Basic configuration Object 
    .PARAMETER name 
        Name for the server.  
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
        Can be changed after the name is created.  
        Minimum length = 1 
    .PARAMETER ipaddress 
        IPv4 or IPv6 address of the server. If you create an IP address based server, you can specify the name of the server, instead of its IP address, when creating a service. Note: If you do not create a server entry, the server IP address that you enter when you create a service becomes the name of the server. 
    .PARAMETER domain 
        Domain name of the server. For a domain based configuration, you must create the server first.  
        Minimum length = 1 
    .PARAMETER translationip 
        IP address used to transform the server's DNS-resolved IP address. 
    .PARAMETER translationmask 
        The netmask of the translation ip. 
    .PARAMETER domainresolveretry 
        Time, in seconds, for which the Citrix ADC must wait, after DNS resolution fails, before sending the next DNS query to resolve the domain name.  
        Default value: 5  
        Minimum value = 5  
        Maximum value = 20939 
    .PARAMETER state 
        Initial state of the server.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ipv6address 
        Support IPv6 addressing mode. If you configure a server with the IPv6 addressing mode, you cannot use the server in the IPv4 addressing mode.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER comment 
        Any information about the server. 
    .PARAMETER td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0.  
        Minimum value = 0  
        Maximum value = 4094 
    .PARAMETER querytype 
        Specify the type of DNS resolution to be done on the configured domain to get the backend services. Valid query types are A, AAAA and SRV with A being the default querytype. The type of DNS resolution done on the domains in SRV records is inherited from ipv6 argument.  
        Default value: A  
        Possible values = A, AAAA, SRV 
    .PARAMETER PassThru 
        Return details about the created server item.
    .EXAMPLE
        Invoke-ADCAddServer -name <string>
    .NOTES
        File Name : Invoke-ADCAddServer
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [string]$ipaddress ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [string]$translationip ,

        [string]$translationmask ,

        [ValidateRange(5, 20939)]
        [int]$domainresolveretry = '5' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' ,

        [ValidateSet('YES', 'NO')]
        [string]$ipv6address = 'NO' ,

        [string]$comment ,

        [ValidateRange(0, 4094)]
        [double]$td ,

        [ValidateSet('A', 'AAAA', 'SRV')]
        [string]$querytype = 'A' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddServer: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Payload.Add('ipaddress', $ipaddress) }
            if ($PSBoundParameters.ContainsKey('domain')) { $Payload.Add('domain', $domain) }
            if ($PSBoundParameters.ContainsKey('translationip')) { $Payload.Add('translationip', $translationip) }
            if ($PSBoundParameters.ContainsKey('translationmask')) { $Payload.Add('translationmask', $translationmask) }
            if ($PSBoundParameters.ContainsKey('domainresolveretry')) { $Payload.Add('domainresolveretry', $domainresolveretry) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('ipv6address')) { $Payload.Add('ipv6address', $ipv6address) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('td')) { $Payload.Add('td', $td) }
            if ($PSBoundParameters.ContainsKey('querytype')) { $Payload.Add('querytype', $querytype) }
 
            if ($PSCmdlet.ShouldProcess("server", "Add Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type server -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetServer -Filter $Payload)
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
        Delete Basic configuration Object
    .DESCRIPTION
        Delete Basic configuration Object
    .PARAMETER name 
       Name for the server.  
       Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
       Can be changed after the name is created.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteServer -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteServer
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server/
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
        Write-Verbose "Invoke-ADCDeleteServer: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type server -Resource $name -Arguments $Arguments
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

function Invoke-ADCUpdateServer {
<#
    .SYNOPSIS
        Update Basic configuration Object
    .DESCRIPTION
        Update Basic configuration Object 
    .PARAMETER name 
        Name for the server.  
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
        Can be changed after the name is created.  
        Minimum length = 1 
    .PARAMETER ipaddress 
        IPv4 or IPv6 address of the server. If you create an IP address based server, you can specify the name of the server, instead of its IP address, when creating a service. Note: If you do not create a server entry, the server IP address that you enter when you create a service becomes the name of the server. 
    .PARAMETER domainresolveretry 
        Time, in seconds, for which the Citrix ADC must wait, after DNS resolution fails, before sending the next DNS query to resolve the domain name.  
        Default value: 5  
        Minimum value = 5  
        Maximum value = 20939 
    .PARAMETER translationip 
        IP address used to transform the server's DNS-resolved IP address. 
    .PARAMETER translationmask 
        The netmask of the translation ip. 
    .PARAMETER domainresolvenow 
        Immediately send a DNS query to resolve the server's domain name. 
    .PARAMETER comment 
        Any information about the server. 
    .PARAMETER PassThru 
        Return details about the created server item.
    .EXAMPLE
        Invoke-ADCUpdateServer -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateServer
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [string]$ipaddress ,

        [ValidateRange(5, 20939)]
        [int]$domainresolveretry ,

        [string]$translationip ,

        [string]$translationmask ,

        [boolean]$domainresolvenow ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateServer: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Payload.Add('ipaddress', $ipaddress) }
            if ($PSBoundParameters.ContainsKey('domainresolveretry')) { $Payload.Add('domainresolveretry', $domainresolveretry) }
            if ($PSBoundParameters.ContainsKey('translationip')) { $Payload.Add('translationip', $translationip) }
            if ($PSBoundParameters.ContainsKey('translationmask')) { $Payload.Add('translationmask', $translationmask) }
            if ($PSBoundParameters.ContainsKey('domainresolvenow')) { $Payload.Add('domainresolvenow', $domainresolvenow) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("server", "Update Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type server -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetServer -Filter $Payload)
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

function Invoke-ADCUnsetServer {
<#
    .SYNOPSIS
        Unset Basic configuration Object
    .DESCRIPTION
        Unset Basic configuration Object 
   .PARAMETER name 
       Name for the server.  
       Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
       Can be changed after the name is created. 
   .PARAMETER comment 
       Any information about the server.
    .EXAMPLE
        Invoke-ADCUnsetServer -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetServer
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetServer: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type server -Action unset -Payload $Payload -GetWarning
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

function Invoke-ADCEnableServer {
<#
    .SYNOPSIS
        Enable Basic configuration Object
    .DESCRIPTION
        Enable Basic configuration Object 
    .PARAMETER name 
        Name for the server.  
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
        Can be changed after the name is created.
    .EXAMPLE
        Invoke-ADCEnableServer -name <string>
    .NOTES
        File Name : Invoke-ADCEnableServer
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableServer: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

            if ($PSCmdlet.ShouldProcess($Name, "Enable Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type server -Action enable -Payload $Payload -GetWarning
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

function Invoke-ADCDisableServer {
<#
    .SYNOPSIS
        Disable Basic configuration Object
    .DESCRIPTION
        Disable Basic configuration Object 
    .PARAMETER name 
        Name for the server.  
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
        Can be changed after the name is created. 
    .PARAMETER delay 
        Time, in seconds, after which all the services configured on the server are disabled. 
    .PARAMETER graceful 
        Shut down gracefully, without accepting any new connections, and disabling each service when all of its connections are closed.  
        Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCDisableServer -name <string>
    .NOTES
        File Name : Invoke-ADCDisableServer
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [double]$delay ,

        [ValidateSet('YES', 'NO')]
        [string]$graceful 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableServer: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('delay')) { $Payload.Add('delay', $delay) }
            if ($PSBoundParameters.ContainsKey('graceful')) { $Payload.Add('graceful', $graceful) }
            if ($PSCmdlet.ShouldProcess($Name, "Disable Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type server -Action disable -Payload $Payload -GetWarning
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

function Invoke-ADCRenameServer {
<#
    .SYNOPSIS
        Rename Basic configuration Object
    .DESCRIPTION
        Rename Basic configuration Object 
    .PARAMETER name 
        Name for the server.  
        Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
        Can be changed after the name is created.  
        Minimum length = 1 
    .PARAMETER newname 
        New name for the server. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created server item.
    .EXAMPLE
        Invoke-ADCRenameServer -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameServer
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameServer: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("server", "Rename Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type server -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetServer -Filter $Payload)
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

function Invoke-ADCGetServer {
<#
    .SYNOPSIS
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER name 
       Name for the server.  
       Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
       Can be changed after the name is created. 
    .PARAMETER GetAll 
        Retreive all server object(s)
    .PARAMETER Count
        If specified, the count of the server object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetServer
    .EXAMPLE 
        Invoke-ADCGetServer -GetAll 
    .EXAMPLE 
        Invoke-ADCGetServer -Count
    .EXAMPLE
        Invoke-ADCGetServer -name <string>
    .EXAMPLE
        Invoke-ADCGetServer -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetServer
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
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
        Write-Verbose "Invoke-ADCGetServer: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all server objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for server objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving server objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving server configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving server configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER name 
       Name of the server for which to display parameters. 
    .PARAMETER GetAll 
        Retreive all server_binding object(s)
    .PARAMETER Count
        If specified, the count of the server_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetServerbinding
    .EXAMPLE 
        Invoke-ADCGetServerbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetServerbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetServerbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetServerbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server_binding/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetServerbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all server_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for server_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving server_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving server_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving server_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER name 
       Name of the server for which to display parameters. 
    .PARAMETER GetAll 
        Retreive all server_gslbservicegroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the server_gslbservicegroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetServergslbservicegroupbinding
    .EXAMPLE 
        Invoke-ADCGetServergslbservicegroupbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetServergslbservicegroupbinding -Count
    .EXAMPLE
        Invoke-ADCGetServergslbservicegroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetServergslbservicegroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetServergslbservicegroupbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server_gslbservicegroup_binding/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all server_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservicegroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for server_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservicegroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving server_gslbservicegroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservicegroup_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving server_gslbservicegroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservicegroup_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving server_gslbservicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservicegroup_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER name 
       Name of the server for which to display parameters. 
    .PARAMETER GetAll 
        Retreive all server_gslbservice_binding object(s)
    .PARAMETER Count
        If specified, the count of the server_gslbservice_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetServergslbservicebinding
    .EXAMPLE 
        Invoke-ADCGetServergslbservicebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetServergslbservicebinding -Count
    .EXAMPLE
        Invoke-ADCGetServergslbservicebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetServergslbservicebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetServergslbservicebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server_gslbservice_binding/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all server_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservice_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for server_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservice_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving server_gslbservice_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservice_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving server_gslbservice_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservice_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving server_gslbservice_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_gslbservice_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER name 
       Name of the server for which to display parameters. 
    .PARAMETER GetAll 
        Retreive all server_servicegroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the server_servicegroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetServerservicegroupbinding
    .EXAMPLE 
        Invoke-ADCGetServerservicegroupbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetServerservicegroupbinding -Count
    .EXAMPLE
        Invoke-ADCGetServerservicegroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetServerservicegroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetServerservicegroupbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server_servicegroup_binding/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all server_servicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_servicegroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for server_servicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_servicegroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving server_servicegroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_servicegroup_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving server_servicegroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_servicegroup_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving server_servicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_servicegroup_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER name 
       Name of the server for which to display parameters. 
    .PARAMETER GetAll 
        Retreive all server_service_binding object(s)
    .PARAMETER Count
        If specified, the count of the server_service_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetServerservicebinding
    .EXAMPLE 
        Invoke-ADCGetServerservicebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetServerservicebinding -Count
    .EXAMPLE
        Invoke-ADCGetServerservicebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetServerservicebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetServerservicebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/server_service_binding/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all server_service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_service_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for server_service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_service_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving server_service_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_service_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving server_service_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_service_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving server_service_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type server_service_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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

function Invoke-ADCAddService {
<#
    .SYNOPSIS
        Add Basic configuration Object
    .DESCRIPTION
        Add Basic configuration Object 
    .PARAMETER name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created.  
        Minimum length = 1 
    .PARAMETER ip 
        IP to assign to the service.  
        Minimum length = 1 
    .PARAMETER servername 
        Name of the server that hosts the service.  
        Minimum length = 1 
    .PARAMETER servicetype 
        Protocol in which data is exchanged with the service.  
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, DTLS, NNTP, RPCSVR, DNS, ADNS, SNMP, RTSP, DHCPRA, ANY, SIP_UDP, SIP_TCP, SIP_SSL, DNS_TCP, ADNS_TCP, MYSQL, MSSQL, ORACLE, MONGO, MONGO_TLS, RADIUS, RADIUSListener, RDP, DIAMETER, SSL_DIAMETER, TFTP, SMPP, PPTP, GRE, SYSLOGTCP, SYSLOGUDP, FIX, SSL_FIX, USER_TCP, USER_SSL_TCP, QUIC, IPFIX, LOGSTREAM, LOGSTREAM_SSL 
    .PARAMETER port 
        Port number of the service.  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER cleartextport 
        Port to which clear text data must be sent after the appliance decrypts incoming SSL traffic. Applicable to transparent SSL services.  
        Minimum value = 1 
    .PARAMETER cachetype 
        Cache type supported by the cache server.  
        Possible values = TRANSPARENT, REVERSE, FORWARD 
    .PARAMETER maxclient 
        Maximum number of simultaneous open connections to the service.  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER healthmonitor 
        Monitor the health of this service. Available settings function as follows:  
        YES - Send probes to check the health of the service.  
        NO - Do not send probes to check the health of the service. With the NO option, the appliance shows the service as UP at all times.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER maxreq 
        Maximum number of requests that can be sent on a persistent connection to the service.  
        Note: Connection requests beyond this value are rejected.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER cacheable 
        Use the transparent cache redirection virtual server to forward requests to the cache server.  
        Note: Do not specify this parameter if you set the Cache Type parameter.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER cip 
        Before forwarding a request to the service, insert an HTTP header with the client's IPv4 or IPv6 address as its value. Used if the server needs the client's IP address for security, accounting, or other purposes, and setting the Use Source IP parameter is not a viable option.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cipheader 
        Name for the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If you set the Client IP parameter, and you do not specify a name for the header, the appliance uses the header name specified for the global Client IP Header parameter (the cipHeader parameter in the set ns param CLI command or the Client IP Header parameter in the Configure HTTP Parameters dialog box at System > Settings > Change HTTP parameters). If the global Client IP Header parameter is not specified, the appliance inserts a header with the name "client-ip.".  
        Minimum length = 1 
    .PARAMETER usip 
        Use the client's IP address as the source IP address when initiating a connection to the server. When creating a service, if you do not set this parameter, the service inherits the global Use Source IP setting (available in the enable ns mode and disable ns mode CLI commands, or in the System > Settings > Configure modes > Configure Modes dialog box). However, you can override this setting after you create the service.  
        Possible values = YES, NO 
    .PARAMETER pathmonitor 
        Path monitoring for clustering.  
        Possible values = YES, NO 
    .PARAMETER pathmonitorindv 
        Individual Path monitoring decisions.  
        Possible values = YES, NO 
    .PARAMETER useproxyport 
        Use the proxy port as the source port when initiating connections with the server. With the NO setting, the client-side connection port is used as the source port for the server-side connection.  
        Note: This parameter is available only when the Use Source IP (USIP) parameter is set to YES.  
        Possible values = YES, NO 
    .PARAMETER sc 
        State of SureConnect for the service.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER sp 
        Enable surge protection for the service.  
        Possible values = ON, OFF 
    .PARAMETER rtspsessionidremap 
        Enable RTSP session ID mapping for the service.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER clttimeout 
        Time, in seconds, after which to terminate an idle client connection.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER svrtimeout 
        Time, in seconds, after which to terminate an idle server connection.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER customserverid 
        Unique identifier for the service. Used when the persistency type for the virtual server is set to Custom Server ID.  
        Default value: "None" 
    .PARAMETER serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER cka 
        Enable client keep-alive for the service.  
        Possible values = YES, NO 
    .PARAMETER tcpb 
        Enable TCP buffering for the service.  
        Possible values = YES, NO 
    .PARAMETER cmp 
        Enable compression for the service.  
        Possible values = YES, NO 
    .PARAMETER maxbandwidth 
        Maximum bandwidth, in Kbps, allocated to the service.  
        Minimum value = 0  
        Maximum value = 4294967287 
    .PARAMETER accessdown 
        Use Layer 2 mode to bridge the packets sent to this service if it is marked as DOWN. If the service is DOWN, and this parameter is disabled, the packets are dropped.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER monthreshold 
        Minimum sum of weights of the monitors that are bound to this service. Used to determine whether to mark a service as UP or DOWN.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER state 
        Initial state of the service.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER downstateflush 
        Flush all active transactions associated with a service whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tcpprofilename 
        Name of the TCP profile that contains TCP configuration settings for the service.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER httpprofilename 
        Name of the HTTP profile that contains HTTP configuration settings for the service.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER contentinspectionprofilename 
        Name of the ContentInspection profile that contains IPS/IDS communication related setting for the service.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER hashid 
        A numerical identifier that can be used by hash based load balancing methods. Must be unique for each service.  
        Minimum value = 1 
    .PARAMETER comment 
        Any information about the service. 
    .PARAMETER appflowlog 
        Enable logging of AppFlow information.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER netprofile 
        Network profile to use for the service.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0.  
        Minimum value = 0  
        Maximum value = 4094 
    .PARAMETER processlocal 
        By turning on this option packets destined to a service in a cluster will not under go any steering. Turn this option for single packet request response mode or when the upstream device is performing a proper RSS for connection based distribution.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dnsprofilename 
        Name of the DNS profile to be associated with the service. DNS profile properties will applied to the transactions processed by a service. This parameter is valid only for ADNS and ADNS-TCP services.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER monconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set.  
        Default value: NONE  
        Possible values = RESET, FIN 
    .PARAMETER PassThru 
        Return details about the created service item.
    .EXAMPLE
        Invoke-ADCAddService -name <string> -servicetype <string> -port <int>
    .NOTES
        File Name : Invoke-ADCAddService
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servername ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'DTLS', 'NNTP', 'RPCSVR', 'DNS', 'ADNS', 'SNMP', 'RTSP', 'DHCPRA', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'DNS_TCP', 'ADNS_TCP', 'MYSQL', 'MSSQL', 'ORACLE', 'MONGO', 'MONGO_TLS', 'RADIUS', 'RADIUSListener', 'RDP', 'DIAMETER', 'SSL_DIAMETER', 'TFTP', 'SMPP', 'PPTP', 'GRE', 'SYSLOGTCP', 'SYSLOGUDP', 'FIX', 'SSL_FIX', 'USER_TCP', 'USER_SSL_TCP', 'QUIC', 'IPFIX', 'LOGSTREAM', 'LOGSTREAM_SSL')]
        [string]$servicetype ,

        [Parameter(Mandatory = $true)]
        [ValidateRange(1, 65535)]
        [int]$port ,

        [int]$cleartextport ,

        [ValidateSet('TRANSPARENT', 'REVERSE', 'FORWARD')]
        [string]$cachetype ,

        [ValidateRange(0, 4294967294)]
        [double]$maxclient ,

        [ValidateSet('YES', 'NO')]
        [string]$healthmonitor = 'YES' ,

        [ValidateRange(0, 65535)]
        [double]$maxreq ,

        [ValidateSet('YES', 'NO')]
        [string]$cacheable = 'NO' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cipheader ,

        [ValidateSet('YES', 'NO')]
        [string]$usip ,

        [ValidateSet('YES', 'NO')]
        [string]$pathmonitor ,

        [ValidateSet('YES', 'NO')]
        [string]$pathmonitorindv ,

        [ValidateSet('YES', 'NO')]
        [string]$useproxyport ,

        [ValidateSet('ON', 'OFF')]
        [string]$sc = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$sp ,

        [ValidateSet('ON', 'OFF')]
        [string]$rtspsessionidremap = 'OFF' ,

        [ValidateRange(0, 31536000)]
        [double]$clttimeout ,

        [ValidateRange(0, 31536000)]
        [double]$svrtimeout ,

        [string]$customserverid = '"None"' ,

        [double]$serverid ,

        [ValidateSet('YES', 'NO')]
        [string]$cka ,

        [ValidateSet('YES', 'NO')]
        [string]$tcpb ,

        [ValidateSet('YES', 'NO')]
        [string]$cmp ,

        [ValidateRange(0, 4294967287)]
        [double]$maxbandwidth ,

        [ValidateSet('YES', 'NO')]
        [string]$accessdown = 'NO' ,

        [ValidateRange(0, 65535)]
        [double]$monthreshold ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$downstateflush = 'ENABLED' ,

        [ValidateLength(1, 127)]
        [string]$tcpprofilename ,

        [ValidateLength(1, 127)]
        [string]$httpprofilename ,

        [ValidateLength(1, 127)]
        [string]$contentinspectionprofilename ,

        [double]$hashid ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowlog = 'ENABLED' ,

        [ValidateLength(1, 127)]
        [string]$netprofile ,

        [ValidateRange(0, 4094)]
        [double]$td ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$processlocal = 'DISABLED' ,

        [ValidateLength(1, 127)]
        [string]$dnsprofilename ,

        [ValidateSet('RESET', 'FIN')]
        [string]$monconnectionclose = 'NONE' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddService: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                servicetype = $servicetype
                port = $port
            }
            if ($PSBoundParameters.ContainsKey('ip')) { $Payload.Add('ip', $ip) }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('cleartextport')) { $Payload.Add('cleartextport', $cleartextport) }
            if ($PSBoundParameters.ContainsKey('cachetype')) { $Payload.Add('cachetype', $cachetype) }
            if ($PSBoundParameters.ContainsKey('maxclient')) { $Payload.Add('maxclient', $maxclient) }
            if ($PSBoundParameters.ContainsKey('healthmonitor')) { $Payload.Add('healthmonitor', $healthmonitor) }
            if ($PSBoundParameters.ContainsKey('maxreq')) { $Payload.Add('maxreq', $maxreq) }
            if ($PSBoundParameters.ContainsKey('cacheable')) { $Payload.Add('cacheable', $cacheable) }
            if ($PSBoundParameters.ContainsKey('cip')) { $Payload.Add('cip', $cip) }
            if ($PSBoundParameters.ContainsKey('cipheader')) { $Payload.Add('cipheader', $cipheader) }
            if ($PSBoundParameters.ContainsKey('usip')) { $Payload.Add('usip', $usip) }
            if ($PSBoundParameters.ContainsKey('pathmonitor')) { $Payload.Add('pathmonitor', $pathmonitor) }
            if ($PSBoundParameters.ContainsKey('pathmonitorindv')) { $Payload.Add('pathmonitorindv', $pathmonitorindv) }
            if ($PSBoundParameters.ContainsKey('useproxyport')) { $Payload.Add('useproxyport', $useproxyport) }
            if ($PSBoundParameters.ContainsKey('sc')) { $Payload.Add('sc', $sc) }
            if ($PSBoundParameters.ContainsKey('sp')) { $Payload.Add('sp', $sp) }
            if ($PSBoundParameters.ContainsKey('rtspsessionidremap')) { $Payload.Add('rtspsessionidremap', $rtspsessionidremap) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('svrtimeout')) { $Payload.Add('svrtimeout', $svrtimeout) }
            if ($PSBoundParameters.ContainsKey('customserverid')) { $Payload.Add('customserverid', $customserverid) }
            if ($PSBoundParameters.ContainsKey('serverid')) { $Payload.Add('serverid', $serverid) }
            if ($PSBoundParameters.ContainsKey('cka')) { $Payload.Add('cka', $cka) }
            if ($PSBoundParameters.ContainsKey('tcpb')) { $Payload.Add('tcpb', $tcpb) }
            if ($PSBoundParameters.ContainsKey('cmp')) { $Payload.Add('cmp', $cmp) }
            if ($PSBoundParameters.ContainsKey('maxbandwidth')) { $Payload.Add('maxbandwidth', $maxbandwidth) }
            if ($PSBoundParameters.ContainsKey('accessdown')) { $Payload.Add('accessdown', $accessdown) }
            if ($PSBoundParameters.ContainsKey('monthreshold')) { $Payload.Add('monthreshold', $monthreshold) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('tcpprofilename')) { $Payload.Add('tcpprofilename', $tcpprofilename) }
            if ($PSBoundParameters.ContainsKey('httpprofilename')) { $Payload.Add('httpprofilename', $httpprofilename) }
            if ($PSBoundParameters.ContainsKey('contentinspectionprofilename')) { $Payload.Add('contentinspectionprofilename', $contentinspectionprofilename) }
            if ($PSBoundParameters.ContainsKey('hashid')) { $Payload.Add('hashid', $hashid) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('td')) { $Payload.Add('td', $td) }
            if ($PSBoundParameters.ContainsKey('processlocal')) { $Payload.Add('processlocal', $processlocal) }
            if ($PSBoundParameters.ContainsKey('dnsprofilename')) { $Payload.Add('dnsprofilename', $dnsprofilename) }
            if ($PSBoundParameters.ContainsKey('monconnectionclose')) { $Payload.Add('monconnectionclose', $monconnectionclose) }
 
            if ($PSCmdlet.ShouldProcess("service", "Add Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type service -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetService -Filter $Payload)
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

function Invoke-ADCDeleteService {
<#
    .SYNOPSIS
        Delete Basic configuration Object
    .DESCRIPTION
        Delete Basic configuration Object
    .PARAMETER name 
       Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteService -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteService
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service/
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
        Write-Verbose "Invoke-ADCDeleteService: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type service -Resource $name -Arguments $Arguments
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
        Update Basic configuration Object
    .DESCRIPTION
        Update Basic configuration Object 
    .PARAMETER name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created.  
        Minimum length = 1 
    .PARAMETER ipaddress 
        The new IP address of the service. 
    .PARAMETER maxclient 
        Maximum number of simultaneous open connections to the service.  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER maxreq 
        Maximum number of requests that can be sent on a persistent connection to the service.  
        Note: Connection requests beyond this value are rejected.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER cacheable 
        Use the transparent cache redirection virtual server to forward requests to the cache server.  
        Note: Do not specify this parameter if you set the Cache Type parameter.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER cip 
        Before forwarding a request to the service, insert an HTTP header with the client's IPv4 or IPv6 address as its value. Used if the server needs the client's IP address for security, accounting, or other purposes, and setting the Use Source IP parameter is not a viable option.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cipheader 
        Name for the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If you set the Client IP parameter, and you do not specify a name for the header, the appliance uses the header name specified for the global Client IP Header parameter (the cipHeader parameter in the set ns param CLI command or the Client IP Header parameter in the Configure HTTP Parameters dialog box at System > Settings > Change HTTP parameters). If the global Client IP Header parameter is not specified, the appliance inserts a header with the name "client-ip.".  
        Minimum length = 1 
    .PARAMETER usip 
        Use the client's IP address as the source IP address when initiating a connection to the server. When creating a service, if you do not set this parameter, the service inherits the global Use Source IP setting (available in the enable ns mode and disable ns mode CLI commands, or in the System > Settings > Configure modes > Configure Modes dialog box). However, you can override this setting after you create the service.  
        Possible values = YES, NO 
    .PARAMETER pathmonitor 
        Path monitoring for clustering.  
        Possible values = YES, NO 
    .PARAMETER pathmonitorindv 
        Individual Path monitoring decisions.  
        Possible values = YES, NO 
    .PARAMETER useproxyport 
        Use the proxy port as the source port when initiating connections with the server. With the NO setting, the client-side connection port is used as the source port for the server-side connection.  
        Note: This parameter is available only when the Use Source IP (USIP) parameter is set to YES.  
        Possible values = YES, NO 
    .PARAMETER sc 
        State of SureConnect for the service.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER sp 
        Enable surge protection for the service.  
        Possible values = ON, OFF 
    .PARAMETER rtspsessionidremap 
        Enable RTSP session ID mapping for the service.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER healthmonitor 
        Monitor the health of this service. Available settings function as follows:  
        YES - Send probes to check the health of the service.  
        NO - Do not send probes to check the health of the service. With the NO option, the appliance shows the service as UP at all times.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER clttimeout 
        Time, in seconds, after which to terminate an idle client connection.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER svrtimeout 
        Time, in seconds, after which to terminate an idle server connection.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER customserverid 
        Unique identifier for the service. Used when the persistency type for the virtual server is set to Custom Server ID.  
        Default value: "None" 
    .PARAMETER serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER cka 
        Enable client keep-alive for the service.  
        Possible values = YES, NO 
    .PARAMETER tcpb 
        Enable TCP buffering for the service.  
        Possible values = YES, NO 
    .PARAMETER cmp 
        Enable compression for the service.  
        Possible values = YES, NO 
    .PARAMETER maxbandwidth 
        Maximum bandwidth, in Kbps, allocated to the service.  
        Minimum value = 0  
        Maximum value = 4294967287 
    .PARAMETER accessdown 
        Use Layer 2 mode to bridge the packets sent to this service if it is marked as DOWN. If the service is DOWN, and this parameter is disabled, the packets are dropped.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER monthreshold 
        Minimum sum of weights of the monitors that are bound to this service. Used to determine whether to mark a service as UP or DOWN.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER weight 
        Weight to assign to the monitor-service binding. When a monitor is UP, the weight assigned to its binding with the service determines how much the monitor contributes toward keeping the health of the service above the value configured for the Monitor Threshold parameter.  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER monitor_name_svc 
        Name of the monitor bound to the specified service.  
        Minimum length = 1 
    .PARAMETER downstateflush 
        Flush all active transactions associated with a service whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tcpprofilename 
        Name of the TCP profile that contains TCP configuration settings for the service.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER httpprofilename 
        Name of the HTTP profile that contains HTTP configuration settings for the service.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER contentinspectionprofilename 
        Name of the ContentInspection profile that contains IPS/IDS communication related setting for the service.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER hashid 
        A numerical identifier that can be used by hash based load balancing methods. Must be unique for each service.  
        Minimum value = 1 
    .PARAMETER comment 
        Any information about the service. 
    .PARAMETER appflowlog 
        Enable logging of AppFlow information.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER netprofile 
        Network profile to use for the service.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER processlocal 
        By turning on this option packets destined to a service in a cluster will not under go any steering. Turn this option for single packet request response mode or when the upstream device is performing a proper RSS for connection based distribution.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dnsprofilename 
        Name of the DNS profile to be associated with the service. DNS profile properties will applied to the transactions processed by a service. This parameter is valid only for ADNS and ADNS-TCP services.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER monconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set.  
        Default value: NONE  
        Possible values = RESET, FIN 
    .PARAMETER PassThru 
        Return details about the created service item.
    .EXAMPLE
        Invoke-ADCUpdateService -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateService
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [string]$ipaddress ,

        [ValidateRange(0, 4294967294)]
        [double]$maxclient ,

        [ValidateRange(0, 65535)]
        [double]$maxreq ,

        [ValidateSet('YES', 'NO')]
        [string]$cacheable ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cipheader ,

        [ValidateSet('YES', 'NO')]
        [string]$usip ,

        [ValidateSet('YES', 'NO')]
        [string]$pathmonitor ,

        [ValidateSet('YES', 'NO')]
        [string]$pathmonitorindv ,

        [ValidateSet('YES', 'NO')]
        [string]$useproxyport ,

        [ValidateSet('ON', 'OFF')]
        [string]$sc ,

        [ValidateSet('ON', 'OFF')]
        [string]$sp ,

        [ValidateSet('ON', 'OFF')]
        [string]$rtspsessionidremap ,

        [ValidateSet('YES', 'NO')]
        [string]$healthmonitor ,

        [ValidateRange(0, 31536000)]
        [double]$clttimeout ,

        [ValidateRange(0, 31536000)]
        [double]$svrtimeout ,

        [string]$customserverid ,

        [double]$serverid ,

        [ValidateSet('YES', 'NO')]
        [string]$cka ,

        [ValidateSet('YES', 'NO')]
        [string]$tcpb ,

        [ValidateSet('YES', 'NO')]
        [string]$cmp ,

        [ValidateRange(0, 4294967287)]
        [double]$maxbandwidth ,

        [ValidateSet('YES', 'NO')]
        [string]$accessdown ,

        [ValidateRange(0, 65535)]
        [double]$monthreshold ,

        [ValidateRange(1, 100)]
        [double]$weight ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$monitor_name_svc ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$downstateflush ,

        [ValidateLength(1, 127)]
        [string]$tcpprofilename ,

        [ValidateLength(1, 127)]
        [string]$httpprofilename ,

        [ValidateLength(1, 127)]
        [string]$contentinspectionprofilename ,

        [double]$hashid ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowlog ,

        [ValidateLength(1, 127)]
        [string]$netprofile ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$processlocal ,

        [ValidateLength(1, 127)]
        [string]$dnsprofilename ,

        [ValidateSet('RESET', 'FIN')]
        [string]$monconnectionclose ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateService: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Payload.Add('ipaddress', $ipaddress) }
            if ($PSBoundParameters.ContainsKey('maxclient')) { $Payload.Add('maxclient', $maxclient) }
            if ($PSBoundParameters.ContainsKey('maxreq')) { $Payload.Add('maxreq', $maxreq) }
            if ($PSBoundParameters.ContainsKey('cacheable')) { $Payload.Add('cacheable', $cacheable) }
            if ($PSBoundParameters.ContainsKey('cip')) { $Payload.Add('cip', $cip) }
            if ($PSBoundParameters.ContainsKey('cipheader')) { $Payload.Add('cipheader', $cipheader) }
            if ($PSBoundParameters.ContainsKey('usip')) { $Payload.Add('usip', $usip) }
            if ($PSBoundParameters.ContainsKey('pathmonitor')) { $Payload.Add('pathmonitor', $pathmonitor) }
            if ($PSBoundParameters.ContainsKey('pathmonitorindv')) { $Payload.Add('pathmonitorindv', $pathmonitorindv) }
            if ($PSBoundParameters.ContainsKey('useproxyport')) { $Payload.Add('useproxyport', $useproxyport) }
            if ($PSBoundParameters.ContainsKey('sc')) { $Payload.Add('sc', $sc) }
            if ($PSBoundParameters.ContainsKey('sp')) { $Payload.Add('sp', $sp) }
            if ($PSBoundParameters.ContainsKey('rtspsessionidremap')) { $Payload.Add('rtspsessionidremap', $rtspsessionidremap) }
            if ($PSBoundParameters.ContainsKey('healthmonitor')) { $Payload.Add('healthmonitor', $healthmonitor) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('svrtimeout')) { $Payload.Add('svrtimeout', $svrtimeout) }
            if ($PSBoundParameters.ContainsKey('customserverid')) { $Payload.Add('customserverid', $customserverid) }
            if ($PSBoundParameters.ContainsKey('serverid')) { $Payload.Add('serverid', $serverid) }
            if ($PSBoundParameters.ContainsKey('cka')) { $Payload.Add('cka', $cka) }
            if ($PSBoundParameters.ContainsKey('tcpb')) { $Payload.Add('tcpb', $tcpb) }
            if ($PSBoundParameters.ContainsKey('cmp')) { $Payload.Add('cmp', $cmp) }
            if ($PSBoundParameters.ContainsKey('maxbandwidth')) { $Payload.Add('maxbandwidth', $maxbandwidth) }
            if ($PSBoundParameters.ContainsKey('accessdown')) { $Payload.Add('accessdown', $accessdown) }
            if ($PSBoundParameters.ContainsKey('monthreshold')) { $Payload.Add('monthreshold', $monthreshold) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('monitor_name_svc')) { $Payload.Add('monitor_name_svc', $monitor_name_svc) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('tcpprofilename')) { $Payload.Add('tcpprofilename', $tcpprofilename) }
            if ($PSBoundParameters.ContainsKey('httpprofilename')) { $Payload.Add('httpprofilename', $httpprofilename) }
            if ($PSBoundParameters.ContainsKey('contentinspectionprofilename')) { $Payload.Add('contentinspectionprofilename', $contentinspectionprofilename) }
            if ($PSBoundParameters.ContainsKey('hashid')) { $Payload.Add('hashid', $hashid) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('processlocal')) { $Payload.Add('processlocal', $processlocal) }
            if ($PSBoundParameters.ContainsKey('dnsprofilename')) { $Payload.Add('dnsprofilename', $dnsprofilename) }
            if ($PSBoundParameters.ContainsKey('monconnectionclose')) { $Payload.Add('monconnectionclose', $monconnectionclose) }
 
            if ($PSCmdlet.ShouldProcess("service", "Update Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type service -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetService -Filter $Payload)
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

function Invoke-ADCUnsetService {
<#
    .SYNOPSIS
        Unset Basic configuration Object
    .DESCRIPTION
        Unset Basic configuration Object 
   .PARAMETER name 
       Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created. 
   .PARAMETER maxclient 
       Maximum number of simultaneous open connections to the service. 
   .PARAMETER maxreq 
       Maximum number of requests that can be sent on a persistent connection to the service.  
       Note: Connection requests beyond this value are rejected. 
   .PARAMETER cacheable 
       Use the transparent cache redirection virtual server to forward requests to the cache server.  
       Note: Do not specify this parameter if you set the Cache Type parameter.  
       Possible values = YES, NO 
   .PARAMETER cip 
       Before forwarding a request to the service, insert an HTTP header with the client's IPv4 or IPv6 address as its value. Used if the server needs the client's IP address for security, accounting, or other purposes, and setting the Use Source IP parameter is not a viable option.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER usip 
       Use the client's IP address as the source IP address when initiating a connection to the server. When creating a service, if you do not set this parameter, the service inherits the global Use Source IP setting (available in the enable ns mode and disable ns mode CLI commands, or in the System > Settings > Configure modes > Configure Modes dialog box). However, you can override this setting after you create the service.  
       Possible values = YES, NO 
   .PARAMETER pathmonitor 
       Path monitoring for clustering.  
       Possible values = YES, NO 
   .PARAMETER pathmonitorindv 
       Individual Path monitoring decisions.  
       Possible values = YES, NO 
   .PARAMETER useproxyport 
       Use the proxy port as the source port when initiating connections with the server. With the NO setting, the client-side connection port is used as the source port for the server-side connection.  
       Note: This parameter is available only when the Use Source IP (USIP) parameter is set to YES.  
       Possible values = YES, NO 
   .PARAMETER sc 
       State of SureConnect for the service.  
       Possible values = ON, OFF 
   .PARAMETER sp 
       Enable surge protection for the service.  
       Possible values = ON, OFF 
   .PARAMETER rtspsessionidremap 
       Enable RTSP session ID mapping for the service.  
       Possible values = ON, OFF 
   .PARAMETER customserverid 
       Unique identifier for the service. Used when the persistency type for the virtual server is set to Custom Server ID. 
   .PARAMETER serverid 
       The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
   .PARAMETER cka 
       Enable client keep-alive for the service.  
       Possible values = YES, NO 
   .PARAMETER tcpb 
       Enable TCP buffering for the service.  
       Possible values = YES, NO 
   .PARAMETER cmp 
       Enable compression for the service.  
       Possible values = YES, NO 
   .PARAMETER maxbandwidth 
       Maximum bandwidth, in Kbps, allocated to the service. 
   .PARAMETER accessdown 
       Use Layer 2 mode to bridge the packets sent to this service if it is marked as DOWN. If the service is DOWN, and this parameter is disabled, the packets are dropped.  
       Possible values = YES, NO 
   .PARAMETER monthreshold 
       Minimum sum of weights of the monitors that are bound to this service. Used to determine whether to mark a service as UP or DOWN. 
   .PARAMETER clttimeout 
       Time, in seconds, after which to terminate an idle client connection. 
   .PARAMETER svrtimeout 
       Time, in seconds, after which to terminate an idle server connection. 
   .PARAMETER tcpprofilename 
       Name of the TCP profile that contains TCP configuration settings for the service. 
   .PARAMETER httpprofilename 
       Name of the HTTP profile that contains HTTP configuration settings for the service. 
   .PARAMETER contentinspectionprofilename 
       Name of the ContentInspection profile that contains IPS/IDS communication related setting for the service. 
   .PARAMETER hashid 
       A numerical identifier that can be used by hash based load balancing methods. Must be unique for each service. 
   .PARAMETER appflowlog 
       Enable logging of AppFlow information.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER netprofile 
       Network profile to use for the service. 
   .PARAMETER processlocal 
       By turning on this option packets destined to a service in a cluster will not under go any steering. Turn this option for single packet request response mode or when the upstream device is performing a proper RSS for connection based distribution.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER dnsprofilename 
       Name of the DNS profile to be associated with the service. DNS profile properties will applied to the transactions processed by a service. This parameter is valid only for ADNS and ADNS-TCP services. 
   .PARAMETER monconnectionclose 
       Close monitoring connections by sending the service a connection termination message with the specified bit set.  
       Possible values = RESET, FIN 
   .PARAMETER cipheader 
       Name for the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If you set the Client IP parameter, and you do not specify a name for the header, the appliance uses the header name specified for the global Client IP Header parameter (the cipHeader parameter in the set ns param CLI command or the Client IP Header parameter in the Configure HTTP Parameters dialog box at System > Settings > Change HTTP parameters). If the global Client IP Header parameter is not specified, the appliance inserts a header with the name "client-ip.". 
   .PARAMETER healthmonitor 
       Monitor the health of this service. Available settings function as follows:  
       YES - Send probes to check the health of the service.  
       NO - Do not send probes to check the health of the service. With the NO option, the appliance shows the service as UP at all times.  
       Possible values = YES, NO 
   .PARAMETER downstateflush 
       Flush all active transactions associated with a service whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER comment 
       Any information about the service.
    .EXAMPLE
        Invoke-ADCUnsetService -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetService
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [Boolean]$maxclient ,

        [Boolean]$maxreq ,

        [Boolean]$cacheable ,

        [Boolean]$cip ,

        [Boolean]$usip ,

        [Boolean]$pathmonitor ,

        [Boolean]$pathmonitorindv ,

        [Boolean]$useproxyport ,

        [Boolean]$sc ,

        [Boolean]$sp ,

        [Boolean]$rtspsessionidremap ,

        [Boolean]$customserverid ,

        [Boolean]$serverid ,

        [Boolean]$cka ,

        [Boolean]$tcpb ,

        [Boolean]$cmp ,

        [Boolean]$maxbandwidth ,

        [Boolean]$accessdown ,

        [Boolean]$monthreshold ,

        [Boolean]$clttimeout ,

        [Boolean]$svrtimeout ,

        [Boolean]$tcpprofilename ,

        [Boolean]$httpprofilename ,

        [Boolean]$contentinspectionprofilename ,

        [Boolean]$hashid ,

        [Boolean]$appflowlog ,

        [Boolean]$netprofile ,

        [Boolean]$processlocal ,

        [Boolean]$dnsprofilename ,

        [Boolean]$monconnectionclose ,

        [Boolean]$cipheader ,

        [Boolean]$healthmonitor ,

        [Boolean]$downstateflush ,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetService: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('maxclient')) { $Payload.Add('maxclient', $maxclient) }
            if ($PSBoundParameters.ContainsKey('maxreq')) { $Payload.Add('maxreq', $maxreq) }
            if ($PSBoundParameters.ContainsKey('cacheable')) { $Payload.Add('cacheable', $cacheable) }
            if ($PSBoundParameters.ContainsKey('cip')) { $Payload.Add('cip', $cip) }
            if ($PSBoundParameters.ContainsKey('usip')) { $Payload.Add('usip', $usip) }
            if ($PSBoundParameters.ContainsKey('pathmonitor')) { $Payload.Add('pathmonitor', $pathmonitor) }
            if ($PSBoundParameters.ContainsKey('pathmonitorindv')) { $Payload.Add('pathmonitorindv', $pathmonitorindv) }
            if ($PSBoundParameters.ContainsKey('useproxyport')) { $Payload.Add('useproxyport', $useproxyport) }
            if ($PSBoundParameters.ContainsKey('sc')) { $Payload.Add('sc', $sc) }
            if ($PSBoundParameters.ContainsKey('sp')) { $Payload.Add('sp', $sp) }
            if ($PSBoundParameters.ContainsKey('rtspsessionidremap')) { $Payload.Add('rtspsessionidremap', $rtspsessionidremap) }
            if ($PSBoundParameters.ContainsKey('customserverid')) { $Payload.Add('customserverid', $customserverid) }
            if ($PSBoundParameters.ContainsKey('serverid')) { $Payload.Add('serverid', $serverid) }
            if ($PSBoundParameters.ContainsKey('cka')) { $Payload.Add('cka', $cka) }
            if ($PSBoundParameters.ContainsKey('tcpb')) { $Payload.Add('tcpb', $tcpb) }
            if ($PSBoundParameters.ContainsKey('cmp')) { $Payload.Add('cmp', $cmp) }
            if ($PSBoundParameters.ContainsKey('maxbandwidth')) { $Payload.Add('maxbandwidth', $maxbandwidth) }
            if ($PSBoundParameters.ContainsKey('accessdown')) { $Payload.Add('accessdown', $accessdown) }
            if ($PSBoundParameters.ContainsKey('monthreshold')) { $Payload.Add('monthreshold', $monthreshold) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('svrtimeout')) { $Payload.Add('svrtimeout', $svrtimeout) }
            if ($PSBoundParameters.ContainsKey('tcpprofilename')) { $Payload.Add('tcpprofilename', $tcpprofilename) }
            if ($PSBoundParameters.ContainsKey('httpprofilename')) { $Payload.Add('httpprofilename', $httpprofilename) }
            if ($PSBoundParameters.ContainsKey('contentinspectionprofilename')) { $Payload.Add('contentinspectionprofilename', $contentinspectionprofilename) }
            if ($PSBoundParameters.ContainsKey('hashid')) { $Payload.Add('hashid', $hashid) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('processlocal')) { $Payload.Add('processlocal', $processlocal) }
            if ($PSBoundParameters.ContainsKey('dnsprofilename')) { $Payload.Add('dnsprofilename', $dnsprofilename) }
            if ($PSBoundParameters.ContainsKey('monconnectionclose')) { $Payload.Add('monconnectionclose', $monconnectionclose) }
            if ($PSBoundParameters.ContainsKey('cipheader')) { $Payload.Add('cipheader', $cipheader) }
            if ($PSBoundParameters.ContainsKey('healthmonitor')) { $Payload.Add('healthmonitor', $healthmonitor) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type service -Action unset -Payload $Payload -GetWarning
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

function Invoke-ADCEnableService {
<#
    .SYNOPSIS
        Enable Basic configuration Object
    .DESCRIPTION
        Enable Basic configuration Object 
    .PARAMETER name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created.
    .EXAMPLE
        Invoke-ADCEnableService -name <string>
    .NOTES
        File Name : Invoke-ADCEnableService
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableService: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

            if ($PSCmdlet.ShouldProcess($Name, "Enable Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type service -Action enable -Payload $Payload -GetWarning
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
        Disable Basic configuration Object
    .DESCRIPTION
        Disable Basic configuration Object 
    .PARAMETER name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created. 
    .PARAMETER delay 
        Time, in seconds, allocated to the Citrix ADC for a graceful shutdown of the service. During this period, new requests are sent to the service only for clients who already have persistent sessions on the appliance. Requests from new clients are load balanced among other available services. After the delay time expires, no requests are sent to the service, and the service is marked as unavailable (OUT OF SERVICE). 
    .PARAMETER graceful 
        Shut down gracefully, not accepting any new connections, and disabling the service when all of its connections are closed.  
        Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCDisableService -name <string>
    .NOTES
        File Name : Invoke-ADCDisableService
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [double]$delay ,

        [ValidateSet('YES', 'NO')]
        [string]$graceful 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableService: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('delay')) { $Payload.Add('delay', $delay) }
            if ($PSBoundParameters.ContainsKey('graceful')) { $Payload.Add('graceful', $graceful) }
            if ($PSCmdlet.ShouldProcess($Name, "Disable Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type service -Action disable -Payload $Payload -GetWarning
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

function Invoke-ADCRenameService {
<#
    .SYNOPSIS
        Rename Basic configuration Object
    .DESCRIPTION
        Rename Basic configuration Object 
    .PARAMETER name 
        Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created.  
        Minimum length = 1 
    .PARAMETER newname 
        New name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created service item.
    .EXAMPLE
        Invoke-ADCRenameService -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameService
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameService: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("service", "Rename Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type service -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetService -Filter $Payload)
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

function Invoke-ADCGetService {
<#
    .SYNOPSIS
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER name 
       Name for the service. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the service has been created. 
    .PARAMETER GetAll 
        Retreive all service object(s)
    .PARAMETER Count
        If specified, the count of the service object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetService
    .EXAMPLE 
        Invoke-ADCGetService -GetAll 
    .EXAMPLE 
        Invoke-ADCGetService -Count
    .EXAMPLE
        Invoke-ADCGetService -name <string>
    .EXAMPLE
        Invoke-ADCGetService -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetService
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
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
        Write-Verbose "Invoke-ADCGetService: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all service objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for service objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving service objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving service configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving service configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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

function Invoke-ADCAddServicegroup {
<#
    .SYNOPSIS
        Add Basic configuration Object
    .DESCRIPTION
        Add Basic configuration Object 
    .PARAMETER servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created.  
        Minimum length = 1 
    .PARAMETER servicetype 
        Protocol used to exchange data with the service.  
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, DTLS, NNTP, RPCSVR, DNS, ADNS, SNMP, RTSP, DHCPRA, ANY, SIP_UDP, SIP_TCP, SIP_SSL, DNS_TCP, ADNS_TCP, MYSQL, MSSQL, ORACLE, MONGO, MONGO_TLS, RADIUS, RADIUSListener, RDP, DIAMETER, SSL_DIAMETER, TFTP, SMPP, PPTP, GRE, SYSLOGTCP, SYSLOGUDP, FIX, SSL_FIX, USER_TCP, USER_SSL_TCP, QUIC, IPFIX, LOGSTREAM, LOGSTREAM_SSL 
    .PARAMETER cachetype 
        Cache type supported by the cache server.  
        Possible values = TRANSPARENT, REVERSE, FORWARD 
    .PARAMETER td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0.  
        Minimum value = 0  
        Maximum value = 4094 
    .PARAMETER maxclient 
        Maximum number of simultaneous open connections for the service group.  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER maxreq 
        Maximum number of requests that can be sent on a persistent connection to the service group.  
        Note: Connection requests beyond this value are rejected.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER cacheable 
        Use the transparent cache redirection virtual server to forward the request to the cache server.  
        Note: Do not set this parameter if you set the Cache Type.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER cip 
        Insert the Client IP header in requests forwarded to the service.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cipheader 
        Name of the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If client IP insertion is enabled, and the client IP header is not specified, the value of Client IP Header parameter or the value set by the set ns config command is used as client's IP header name.  
        Minimum length = 1 
    .PARAMETER usip 
        Use client's IP address as the source IP address when initiating connection to the server. With the NO setting, which is the default, a mapped IP (MIP) address or subnet IP (SNIP) address is used as the source IP address to initiate server side connections.  
        Possible values = YES, NO 
    .PARAMETER pathmonitor 
        Path monitoring for clustering.  
        Possible values = YES, NO 
    .PARAMETER pathmonitorindv 
        Individual Path monitoring decisions.  
        Possible values = YES, NO 
    .PARAMETER useproxyport 
        Use the proxy port as the source port when initiating connections with the server. With the NO setting, the client-side connection port is used as the source port for the server-side connection.  
        Note: This parameter is available only when the Use Source IP (USIP) parameter is set to YES.  
        Possible values = YES, NO 
    .PARAMETER healthmonitor 
        Monitor the health of this service. Available settings function as follows:  
        YES - Send probes to check the health of the service.  
        NO - Do not send probes to check the health of the service. With the NO option, the appliance shows the service as UP at all times.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER sc 
        State of the SureConnect feature for the service group.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER sp 
        Enable surge protection for the service group.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER rtspsessionidremap 
        Enable RTSP session ID mapping for the service group.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER clttimeout 
        Time, in seconds, after which to terminate an idle client connection.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER svrtimeout 
        Time, in seconds, after which to terminate an idle server connection.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER cka 
        Enable client keep-alive for the service group.  
        Possible values = YES, NO 
    .PARAMETER tcpb 
        Enable TCP buffering for the service group.  
        Possible values = YES, NO 
    .PARAMETER cmp 
        Enable compression for the specified service.  
        Possible values = YES, NO 
    .PARAMETER maxbandwidth 
        Maximum bandwidth, in Kbps, allocated for all the services in the service group.  
        Minimum value = 0  
        Maximum value = 4294967287 
    .PARAMETER monthreshold 
        Minimum sum of weights of the monitors that are bound to this service. Used to determine whether to mark a service as UP or DOWN.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER state 
        Initial state of the service group.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER downstateflush 
        Flush all active transactions associated with all the services in the service group whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tcpprofilename 
        Name of the TCP profile that contains TCP configuration settings for the service group.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER httpprofilename 
        Name of the HTTP profile that contains HTTP configuration settings for the service group.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER comment 
        Any information about the service group. 
    .PARAMETER appflowlog 
        Enable logging of AppFlow information for the specified service group.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER netprofile 
        Network profile for the service group.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER autoscale 
        Auto scale option for a servicegroup.  
        Default value: DISABLED  
        Possible values = DISABLED, DNS, POLICY, CLOUD, API 
    .PARAMETER memberport 
        member port. 
    .PARAMETER autodisablegraceful 
        Indicates graceful shutdown of the service. System will wait for all outstanding connections to this service to be closed before disabling the service.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER autodisabledelay 
        The time allowed (in seconds) for a graceful shutdown. During this period, new connections or requests will continue to be sent to this service for clients who already have a persistent session on the system. Connections or requests from fresh or new clients who do not yet have a persistence sessions on the system will not be sent to the service. Instead, they will be load balanced among other available services. After the delay time expires, no new requests or connections will be sent to the service. 
    .PARAMETER monconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set.  
        Default value: NONE  
        Possible values = RESET, FIN 
    .PARAMETER PassThru 
        Return details about the created servicegroup item.
    .EXAMPLE
        Invoke-ADCAddServicegroup -servicegroupname <string> -servicetype <string>
    .NOTES
        File Name : Invoke-ADCAddServicegroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicegroupname ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'DTLS', 'NNTP', 'RPCSVR', 'DNS', 'ADNS', 'SNMP', 'RTSP', 'DHCPRA', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'DNS_TCP', 'ADNS_TCP', 'MYSQL', 'MSSQL', 'ORACLE', 'MONGO', 'MONGO_TLS', 'RADIUS', 'RADIUSListener', 'RDP', 'DIAMETER', 'SSL_DIAMETER', 'TFTP', 'SMPP', 'PPTP', 'GRE', 'SYSLOGTCP', 'SYSLOGUDP', 'FIX', 'SSL_FIX', 'USER_TCP', 'USER_SSL_TCP', 'QUIC', 'IPFIX', 'LOGSTREAM', 'LOGSTREAM_SSL')]
        [string]$servicetype ,

        [ValidateSet('TRANSPARENT', 'REVERSE', 'FORWARD')]
        [string]$cachetype ,

        [ValidateRange(0, 4094)]
        [double]$td ,

        [ValidateRange(0, 4294967294)]
        [double]$maxclient ,

        [ValidateRange(0, 65535)]
        [double]$maxreq ,

        [ValidateSet('YES', 'NO')]
        [string]$cacheable = 'NO' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cipheader ,

        [ValidateSet('YES', 'NO')]
        [string]$usip ,

        [ValidateSet('YES', 'NO')]
        [string]$pathmonitor ,

        [ValidateSet('YES', 'NO')]
        [string]$pathmonitorindv ,

        [ValidateSet('YES', 'NO')]
        [string]$useproxyport ,

        [ValidateSet('YES', 'NO')]
        [string]$healthmonitor = 'YES' ,

        [ValidateSet('ON', 'OFF')]
        [string]$sc = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$sp = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$rtspsessionidremap = 'OFF' ,

        [ValidateRange(0, 31536000)]
        [double]$clttimeout ,

        [ValidateRange(0, 31536000)]
        [double]$svrtimeout ,

        [ValidateSet('YES', 'NO')]
        [string]$cka ,

        [ValidateSet('YES', 'NO')]
        [string]$tcpb ,

        [ValidateSet('YES', 'NO')]
        [string]$cmp ,

        [ValidateRange(0, 4294967287)]
        [double]$maxbandwidth ,

        [ValidateRange(0, 65535)]
        [double]$monthreshold ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$downstateflush = 'ENABLED' ,

        [ValidateLength(1, 127)]
        [string]$tcpprofilename ,

        [ValidateLength(1, 127)]
        [string]$httpprofilename ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowlog = 'ENABLED' ,

        [ValidateLength(1, 127)]
        [string]$netprofile ,

        [ValidateSet('DISABLED', 'DNS', 'POLICY', 'CLOUD', 'API')]
        [string]$autoscale = 'DISABLED' ,

        [int]$memberport ,

        [ValidateSet('YES', 'NO')]
        [string]$autodisablegraceful = 'NO' ,

        [double]$autodisabledelay ,

        [ValidateSet('RESET', 'FIN')]
        [string]$monconnectionclose = 'NONE' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddServicegroup: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
                servicetype = $servicetype
            }
            if ($PSBoundParameters.ContainsKey('cachetype')) { $Payload.Add('cachetype', $cachetype) }
            if ($PSBoundParameters.ContainsKey('td')) { $Payload.Add('td', $td) }
            if ($PSBoundParameters.ContainsKey('maxclient')) { $Payload.Add('maxclient', $maxclient) }
            if ($PSBoundParameters.ContainsKey('maxreq')) { $Payload.Add('maxreq', $maxreq) }
            if ($PSBoundParameters.ContainsKey('cacheable')) { $Payload.Add('cacheable', $cacheable) }
            if ($PSBoundParameters.ContainsKey('cip')) { $Payload.Add('cip', $cip) }
            if ($PSBoundParameters.ContainsKey('cipheader')) { $Payload.Add('cipheader', $cipheader) }
            if ($PSBoundParameters.ContainsKey('usip')) { $Payload.Add('usip', $usip) }
            if ($PSBoundParameters.ContainsKey('pathmonitor')) { $Payload.Add('pathmonitor', $pathmonitor) }
            if ($PSBoundParameters.ContainsKey('pathmonitorindv')) { $Payload.Add('pathmonitorindv', $pathmonitorindv) }
            if ($PSBoundParameters.ContainsKey('useproxyport')) { $Payload.Add('useproxyport', $useproxyport) }
            if ($PSBoundParameters.ContainsKey('healthmonitor')) { $Payload.Add('healthmonitor', $healthmonitor) }
            if ($PSBoundParameters.ContainsKey('sc')) { $Payload.Add('sc', $sc) }
            if ($PSBoundParameters.ContainsKey('sp')) { $Payload.Add('sp', $sp) }
            if ($PSBoundParameters.ContainsKey('rtspsessionidremap')) { $Payload.Add('rtspsessionidremap', $rtspsessionidremap) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('svrtimeout')) { $Payload.Add('svrtimeout', $svrtimeout) }
            if ($PSBoundParameters.ContainsKey('cka')) { $Payload.Add('cka', $cka) }
            if ($PSBoundParameters.ContainsKey('tcpb')) { $Payload.Add('tcpb', $tcpb) }
            if ($PSBoundParameters.ContainsKey('cmp')) { $Payload.Add('cmp', $cmp) }
            if ($PSBoundParameters.ContainsKey('maxbandwidth')) { $Payload.Add('maxbandwidth', $maxbandwidth) }
            if ($PSBoundParameters.ContainsKey('monthreshold')) { $Payload.Add('monthreshold', $monthreshold) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('tcpprofilename')) { $Payload.Add('tcpprofilename', $tcpprofilename) }
            if ($PSBoundParameters.ContainsKey('httpprofilename')) { $Payload.Add('httpprofilename', $httpprofilename) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('autoscale')) { $Payload.Add('autoscale', $autoscale) }
            if ($PSBoundParameters.ContainsKey('memberport')) { $Payload.Add('memberport', $memberport) }
            if ($PSBoundParameters.ContainsKey('autodisablegraceful')) { $Payload.Add('autodisablegraceful', $autodisablegraceful) }
            if ($PSBoundParameters.ContainsKey('autodisabledelay')) { $Payload.Add('autodisabledelay', $autodisabledelay) }
            if ($PSBoundParameters.ContainsKey('monconnectionclose')) { $Payload.Add('monconnectionclose', $monconnectionclose) }
 
            if ($PSCmdlet.ShouldProcess("servicegroup", "Add Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type servicegroup -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetServicegroup -Filter $Payload)
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

function Invoke-ADCDeleteServicegroup {
<#
    .SYNOPSIS
        Delete Basic configuration Object
    .DESCRIPTION
        Delete Basic configuration Object
    .PARAMETER servicegroupname 
       Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteServicegroup -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteServicegroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup/
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
        [string]$servicegroupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteServicegroup: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$servicegroupname", "Delete Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type servicegroup -Resource $servicegroupname -Arguments $Arguments
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
        Update Basic configuration Object
    .DESCRIPTION
        Update Basic configuration Object 
    .PARAMETER servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created.  
        Minimum length = 1 
    .PARAMETER servername 
        Name of the server to which to bind the service group.  
        Minimum length = 1 
    .PARAMETER port 
        Server port number.  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service.  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER customserverid 
        The identifier for this IP:Port pair. Used when the persistency type is set to Custom Server ID.  
        Default value: "None" 
    .PARAMETER serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER hashid 
        The hash identifier for the service. This must be unique for each service. This parameter is used by hash based load balancing methods.  
        Minimum value = 1 
    .PARAMETER nameserver 
        Specify the nameserver to which the query for bound domain needs to be sent. If not specified, use the global nameserver. 
    .PARAMETER dbsttl 
        Specify the TTL for DNS record for domain based service.The default value of ttl is 0 which indicates to use the TTL received in DNS response for monitors.  
        Default value: 0 
    .PARAMETER monitor_name_svc 
        Name of the monitor bound to the service group. Used to assign a weight to the monitor.  
        Minimum length = 1 
    .PARAMETER dup_weight 
        weight of the monitor that is bound to servicegroup.  
        Minimum value = 1 
    .PARAMETER maxclient 
        Maximum number of simultaneous open connections for the service group.  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER maxreq 
        Maximum number of requests that can be sent on a persistent connection to the service group.  
        Note: Connection requests beyond this value are rejected.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER healthmonitor 
        Monitor the health of this service. Available settings function as follows:  
        YES - Send probes to check the health of the service.  
        NO - Do not send probes to check the health of the service. With the NO option, the appliance shows the service as UP at all times.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER cacheable 
        Use the transparent cache redirection virtual server to forward the request to the cache server.  
        Note: Do not set this parameter if you set the Cache Type.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER cip 
        Insert the Client IP header in requests forwarded to the service.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cipheader 
        Name of the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If client IP insertion is enabled, and the client IP header is not specified, the value of Client IP Header parameter or the value set by the set ns config command is used as client's IP header name.  
        Minimum length = 1 
    .PARAMETER usip 
        Use client's IP address as the source IP address when initiating connection to the server. With the NO setting, which is the default, a mapped IP (MIP) address or subnet IP (SNIP) address is used as the source IP address to initiate server side connections.  
        Possible values = YES, NO 
    .PARAMETER pathmonitor 
        Path monitoring for clustering.  
        Possible values = YES, NO 
    .PARAMETER pathmonitorindv 
        Individual Path monitoring decisions.  
        Possible values = YES, NO 
    .PARAMETER useproxyport 
        Use the proxy port as the source port when initiating connections with the server. With the NO setting, the client-side connection port is used as the source port for the server-side connection.  
        Note: This parameter is available only when the Use Source IP (USIP) parameter is set to YES.  
        Possible values = YES, NO 
    .PARAMETER sc 
        State of the SureConnect feature for the service group.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER sp 
        Enable surge protection for the service group.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER rtspsessionidremap 
        Enable RTSP session ID mapping for the service group.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER clttimeout 
        Time, in seconds, after which to terminate an idle client connection.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER svrtimeout 
        Time, in seconds, after which to terminate an idle server connection.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER cka 
        Enable client keep-alive for the service group.  
        Possible values = YES, NO 
    .PARAMETER tcpb 
        Enable TCP buffering for the service group.  
        Possible values = YES, NO 
    .PARAMETER cmp 
        Enable compression for the specified service.  
        Possible values = YES, NO 
    .PARAMETER maxbandwidth 
        Maximum bandwidth, in Kbps, allocated for all the services in the service group.  
        Minimum value = 0  
        Maximum value = 4294967287 
    .PARAMETER monthreshold 
        Minimum sum of weights of the monitors that are bound to this service. Used to determine whether to mark a service as UP or DOWN.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER downstateflush 
        Flush all active transactions associated with all the services in the service group whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tcpprofilename 
        Name of the TCP profile that contains TCP configuration settings for the service group.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER httpprofilename 
        Name of the HTTP profile that contains HTTP configuration settings for the service group.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER comment 
        Any information about the service group. 
    .PARAMETER appflowlog 
        Enable logging of AppFlow information for the specified service group.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER netprofile 
        Network profile for the service group.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER autodisablegraceful 
        Indicates graceful shutdown of the service. System will wait for all outstanding connections to this service to be closed before disabling the service.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER autodisabledelay 
        The time allowed (in seconds) for a graceful shutdown. During this period, new connections or requests will continue to be sent to this service for clients who already have a persistent session on the system. Connections or requests from fresh or new clients who do not yet have a persistence sessions on the system will not be sent to the service. Instead, they will be load balanced among other available services. After the delay time expires, no new requests or connections will be sent to the service. 
    .PARAMETER monconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set.  
        Default value: NONE  
        Possible values = RESET, FIN 
    .PARAMETER autoscale 
        Auto scale option for a servicegroup.  
        Default value: DISABLED  
        Possible values = DISABLED, DNS, POLICY, CLOUD, API 
    .PARAMETER PassThru 
        Return details about the created servicegroup item.
    .EXAMPLE
        Invoke-ADCUpdateServicegroup -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCUpdateServicegroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicegroupname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servername ,

        [ValidateRange(1, 65535)]
        [int]$port ,

        [ValidateRange(1, 100)]
        [double]$weight ,

        [string]$customserverid ,

        [double]$serverid ,

        [double]$hashid ,

        [string]$nameserver ,

        [double]$dbsttl ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$monitor_name_svc ,

        [double]$dup_weight ,

        [ValidateRange(0, 4294967294)]
        [double]$maxclient ,

        [ValidateRange(0, 65535)]
        [double]$maxreq ,

        [ValidateSet('YES', 'NO')]
        [string]$healthmonitor ,

        [ValidateSet('YES', 'NO')]
        [string]$cacheable ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cipheader ,

        [ValidateSet('YES', 'NO')]
        [string]$usip ,

        [ValidateSet('YES', 'NO')]
        [string]$pathmonitor ,

        [ValidateSet('YES', 'NO')]
        [string]$pathmonitorindv ,

        [ValidateSet('YES', 'NO')]
        [string]$useproxyport ,

        [ValidateSet('ON', 'OFF')]
        [string]$sc ,

        [ValidateSet('ON', 'OFF')]
        [string]$sp ,

        [ValidateSet('ON', 'OFF')]
        [string]$rtspsessionidremap ,

        [ValidateRange(0, 31536000)]
        [double]$clttimeout ,

        [ValidateRange(0, 31536000)]
        [double]$svrtimeout ,

        [ValidateSet('YES', 'NO')]
        [string]$cka ,

        [ValidateSet('YES', 'NO')]
        [string]$tcpb ,

        [ValidateSet('YES', 'NO')]
        [string]$cmp ,

        [ValidateRange(0, 4294967287)]
        [double]$maxbandwidth ,

        [ValidateRange(0, 65535)]
        [double]$monthreshold ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$downstateflush ,

        [ValidateLength(1, 127)]
        [string]$tcpprofilename ,

        [ValidateLength(1, 127)]
        [string]$httpprofilename ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowlog ,

        [ValidateLength(1, 127)]
        [string]$netprofile ,

        [ValidateSet('YES', 'NO')]
        [string]$autodisablegraceful ,

        [double]$autodisabledelay ,

        [ValidateSet('RESET', 'FIN')]
        [string]$monconnectionclose ,

        [ValidateSet('DISABLED', 'DNS', 'POLICY', 'CLOUD', 'API')]
        [string]$autoscale ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateServicegroup: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('customserverid')) { $Payload.Add('customserverid', $customserverid) }
            if ($PSBoundParameters.ContainsKey('serverid')) { $Payload.Add('serverid', $serverid) }
            if ($PSBoundParameters.ContainsKey('hashid')) { $Payload.Add('hashid', $hashid) }
            if ($PSBoundParameters.ContainsKey('nameserver')) { $Payload.Add('nameserver', $nameserver) }
            if ($PSBoundParameters.ContainsKey('dbsttl')) { $Payload.Add('dbsttl', $dbsttl) }
            if ($PSBoundParameters.ContainsKey('monitor_name_svc')) { $Payload.Add('monitor_name_svc', $monitor_name_svc) }
            if ($PSBoundParameters.ContainsKey('dup_weight')) { $Payload.Add('dup_weight', $dup_weight) }
            if ($PSBoundParameters.ContainsKey('maxclient')) { $Payload.Add('maxclient', $maxclient) }
            if ($PSBoundParameters.ContainsKey('maxreq')) { $Payload.Add('maxreq', $maxreq) }
            if ($PSBoundParameters.ContainsKey('healthmonitor')) { $Payload.Add('healthmonitor', $healthmonitor) }
            if ($PSBoundParameters.ContainsKey('cacheable')) { $Payload.Add('cacheable', $cacheable) }
            if ($PSBoundParameters.ContainsKey('cip')) { $Payload.Add('cip', $cip) }
            if ($PSBoundParameters.ContainsKey('cipheader')) { $Payload.Add('cipheader', $cipheader) }
            if ($PSBoundParameters.ContainsKey('usip')) { $Payload.Add('usip', $usip) }
            if ($PSBoundParameters.ContainsKey('pathmonitor')) { $Payload.Add('pathmonitor', $pathmonitor) }
            if ($PSBoundParameters.ContainsKey('pathmonitorindv')) { $Payload.Add('pathmonitorindv', $pathmonitorindv) }
            if ($PSBoundParameters.ContainsKey('useproxyport')) { $Payload.Add('useproxyport', $useproxyport) }
            if ($PSBoundParameters.ContainsKey('sc')) { $Payload.Add('sc', $sc) }
            if ($PSBoundParameters.ContainsKey('sp')) { $Payload.Add('sp', $sp) }
            if ($PSBoundParameters.ContainsKey('rtspsessionidremap')) { $Payload.Add('rtspsessionidremap', $rtspsessionidremap) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('svrtimeout')) { $Payload.Add('svrtimeout', $svrtimeout) }
            if ($PSBoundParameters.ContainsKey('cka')) { $Payload.Add('cka', $cka) }
            if ($PSBoundParameters.ContainsKey('tcpb')) { $Payload.Add('tcpb', $tcpb) }
            if ($PSBoundParameters.ContainsKey('cmp')) { $Payload.Add('cmp', $cmp) }
            if ($PSBoundParameters.ContainsKey('maxbandwidth')) { $Payload.Add('maxbandwidth', $maxbandwidth) }
            if ($PSBoundParameters.ContainsKey('monthreshold')) { $Payload.Add('monthreshold', $monthreshold) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('tcpprofilename')) { $Payload.Add('tcpprofilename', $tcpprofilename) }
            if ($PSBoundParameters.ContainsKey('httpprofilename')) { $Payload.Add('httpprofilename', $httpprofilename) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('autodisablegraceful')) { $Payload.Add('autodisablegraceful', $autodisablegraceful) }
            if ($PSBoundParameters.ContainsKey('autodisabledelay')) { $Payload.Add('autodisabledelay', $autodisabledelay) }
            if ($PSBoundParameters.ContainsKey('monconnectionclose')) { $Payload.Add('monconnectionclose', $monconnectionclose) }
            if ($PSBoundParameters.ContainsKey('autoscale')) { $Payload.Add('autoscale', $autoscale) }
 
            if ($PSCmdlet.ShouldProcess("servicegroup", "Update Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type servicegroup -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetServicegroup -Filter $Payload)
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

function Invoke-ADCUnsetServicegroup {
<#
    .SYNOPSIS
        Unset Basic configuration Object
    .DESCRIPTION
        Unset Basic configuration Object 
   .PARAMETER servicegroupname 
       Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
   .PARAMETER servername 
       Name of the server to which to bind the service group. 
   .PARAMETER port 
       Server port number.  
       * in CLI is represented as 65535 in NITRO API 
   .PARAMETER weight 
       Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service. 
   .PARAMETER customserverid 
       The identifier for this IP:Port pair. Used when the persistency type is set to Custom Server ID. 
   .PARAMETER serverid 
       The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
   .PARAMETER hashid 
       The hash identifier for the service. This must be unique for each service. This parameter is used by hash based load balancing methods. 
   .PARAMETER nameserver 
       Specify the nameserver to which the query for bound domain needs to be sent. If not specified, use the global nameserver. 
   .PARAMETER dbsttl 
       Specify the TTL for DNS record for domain based service.The default value of ttl is 0 which indicates to use the TTL received in DNS response for monitors. 
   .PARAMETER maxclient 
       Maximum number of simultaneous open connections for the service group. 
   .PARAMETER maxreq 
       Maximum number of requests that can be sent on a persistent connection to the service group.  
       Note: Connection requests beyond this value are rejected. 
   .PARAMETER cacheable 
       Use the transparent cache redirection virtual server to forward the request to the cache server.  
       Note: Do not set this parameter if you set the Cache Type.  
       Possible values = YES, NO 
   .PARAMETER cip 
       Insert the Client IP header in requests forwarded to the service.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER usip 
       Use client's IP address as the source IP address when initiating connection to the server. With the NO setting, which is the default, a mapped IP (MIP) address or subnet IP (SNIP) address is used as the source IP address to initiate server side connections.  
       Possible values = YES, NO 
   .PARAMETER useproxyport 
       Use the proxy port as the source port when initiating connections with the server. With the NO setting, the client-side connection port is used as the source port for the server-side connection.  
       Note: This parameter is available only when the Use Source IP (USIP) parameter is set to YES.  
       Possible values = YES, NO 
   .PARAMETER sc 
       State of the SureConnect feature for the service group.  
       Possible values = ON, OFF 
   .PARAMETER sp 
       Enable surge protection for the service group.  
       Possible values = ON, OFF 
   .PARAMETER rtspsessionidremap 
       Enable RTSP session ID mapping for the service group.  
       Possible values = ON, OFF 
   .PARAMETER clttimeout 
       Time, in seconds, after which to terminate an idle client connection. 
   .PARAMETER svrtimeout 
       Time, in seconds, after which to terminate an idle server connection. 
   .PARAMETER cka 
       Enable client keep-alive for the service group.  
       Possible values = YES, NO 
   .PARAMETER tcpb 
       Enable TCP buffering for the service group.  
       Possible values = YES, NO 
   .PARAMETER cmp 
       Enable compression for the specified service.  
       Possible values = YES, NO 
   .PARAMETER maxbandwidth 
       Maximum bandwidth, in Kbps, allocated for all the services in the service group. 
   .PARAMETER monthreshold 
       Minimum sum of weights of the monitors that are bound to this service. Used to determine whether to mark a service as UP or DOWN. 
   .PARAMETER tcpprofilename 
       Name of the TCP profile that contains TCP configuration settings for the service group. 
   .PARAMETER httpprofilename 
       Name of the HTTP profile that contains HTTP configuration settings for the service group. 
   .PARAMETER appflowlog 
       Enable logging of AppFlow information for the specified service group.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER netprofile 
       Network profile for the service group. 
   .PARAMETER autodisablegraceful 
       Indicates graceful shutdown of the service. System will wait for all outstanding connections to this service to be closed before disabling the service.  
       Possible values = YES, NO 
   .PARAMETER autodisabledelay 
       The time allowed (in seconds) for a graceful shutdown. During this period, new connections or requests will continue to be sent to this service for clients who already have a persistent session on the system. Connections or requests from fresh or new clients who do not yet have a persistence sessions on the system will not be sent to the service. Instead, they will be load balanced among other available services. After the delay time expires, no new requests or connections will be sent to the service. 
   .PARAMETER monitor_name_svc 
       Name of the monitor bound to the service group. Used to assign a weight to the monitor. 
   .PARAMETER dup_weight 
       weight of the monitor that is bound to servicegroup. 
   .PARAMETER healthmonitor 
       Monitor the health of this service. Available settings function as follows:  
       YES - Send probes to check the health of the service.  
       NO - Do not send probes to check the health of the service. With the NO option, the appliance shows the service as UP at all times.  
       Possible values = YES, NO 
   .PARAMETER cipheader 
       Name of the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If client IP insertion is enabled, and the client IP header is not specified, the value of Client IP Header parameter or the value set by the set ns config command is used as client's IP header name. 
   .PARAMETER pathmonitor 
       Path monitoring for clustering.  
       Possible values = YES, NO 
   .PARAMETER pathmonitorindv 
       Individual Path monitoring decisions.  
       Possible values = YES, NO 
   .PARAMETER downstateflush 
       Flush all active transactions associated with all the services in the service group whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER comment 
       Any information about the service group. 
   .PARAMETER monconnectionclose 
       Close monitoring connections by sending the service a connection termination message with the specified bit set.  
       Possible values = RESET, FIN
    .EXAMPLE
        Invoke-ADCUnsetServicegroup -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCUnsetServicegroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicegroupname ,

        [Boolean]$servername ,

        [Boolean]$port ,

        [Boolean]$weight ,

        [Boolean]$customserverid ,

        [Boolean]$serverid ,

        [Boolean]$hashid ,

        [Boolean]$nameserver ,

        [Boolean]$dbsttl ,

        [Boolean]$maxclient ,

        [Boolean]$maxreq ,

        [Boolean]$cacheable ,

        [Boolean]$cip ,

        [Boolean]$usip ,

        [Boolean]$useproxyport ,

        [Boolean]$sc ,

        [Boolean]$sp ,

        [Boolean]$rtspsessionidremap ,

        [Boolean]$clttimeout ,

        [Boolean]$svrtimeout ,

        [Boolean]$cka ,

        [Boolean]$tcpb ,

        [Boolean]$cmp ,

        [Boolean]$maxbandwidth ,

        [Boolean]$monthreshold ,

        [Boolean]$tcpprofilename ,

        [Boolean]$httpprofilename ,

        [Boolean]$appflowlog ,

        [Boolean]$netprofile ,

        [Boolean]$autodisablegraceful ,

        [Boolean]$autodisabledelay ,

        [Boolean]$monitor_name_svc ,

        [Boolean]$dup_weight ,

        [Boolean]$healthmonitor ,

        [Boolean]$cipheader ,

        [Boolean]$pathmonitor ,

        [Boolean]$pathmonitorindv ,

        [Boolean]$downstateflush ,

        [Boolean]$comment ,

        [Boolean]$monconnectionclose 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetServicegroup: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('customserverid')) { $Payload.Add('customserverid', $customserverid) }
            if ($PSBoundParameters.ContainsKey('serverid')) { $Payload.Add('serverid', $serverid) }
            if ($PSBoundParameters.ContainsKey('hashid')) { $Payload.Add('hashid', $hashid) }
            if ($PSBoundParameters.ContainsKey('nameserver')) { $Payload.Add('nameserver', $nameserver) }
            if ($PSBoundParameters.ContainsKey('dbsttl')) { $Payload.Add('dbsttl', $dbsttl) }
            if ($PSBoundParameters.ContainsKey('maxclient')) { $Payload.Add('maxclient', $maxclient) }
            if ($PSBoundParameters.ContainsKey('maxreq')) { $Payload.Add('maxreq', $maxreq) }
            if ($PSBoundParameters.ContainsKey('cacheable')) { $Payload.Add('cacheable', $cacheable) }
            if ($PSBoundParameters.ContainsKey('cip')) { $Payload.Add('cip', $cip) }
            if ($PSBoundParameters.ContainsKey('usip')) { $Payload.Add('usip', $usip) }
            if ($PSBoundParameters.ContainsKey('useproxyport')) { $Payload.Add('useproxyport', $useproxyport) }
            if ($PSBoundParameters.ContainsKey('sc')) { $Payload.Add('sc', $sc) }
            if ($PSBoundParameters.ContainsKey('sp')) { $Payload.Add('sp', $sp) }
            if ($PSBoundParameters.ContainsKey('rtspsessionidremap')) { $Payload.Add('rtspsessionidremap', $rtspsessionidremap) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('svrtimeout')) { $Payload.Add('svrtimeout', $svrtimeout) }
            if ($PSBoundParameters.ContainsKey('cka')) { $Payload.Add('cka', $cka) }
            if ($PSBoundParameters.ContainsKey('tcpb')) { $Payload.Add('tcpb', $tcpb) }
            if ($PSBoundParameters.ContainsKey('cmp')) { $Payload.Add('cmp', $cmp) }
            if ($PSBoundParameters.ContainsKey('maxbandwidth')) { $Payload.Add('maxbandwidth', $maxbandwidth) }
            if ($PSBoundParameters.ContainsKey('monthreshold')) { $Payload.Add('monthreshold', $monthreshold) }
            if ($PSBoundParameters.ContainsKey('tcpprofilename')) { $Payload.Add('tcpprofilename', $tcpprofilename) }
            if ($PSBoundParameters.ContainsKey('httpprofilename')) { $Payload.Add('httpprofilename', $httpprofilename) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('autodisablegraceful')) { $Payload.Add('autodisablegraceful', $autodisablegraceful) }
            if ($PSBoundParameters.ContainsKey('autodisabledelay')) { $Payload.Add('autodisabledelay', $autodisabledelay) }
            if ($PSBoundParameters.ContainsKey('monitor_name_svc')) { $Payload.Add('monitor_name_svc', $monitor_name_svc) }
            if ($PSBoundParameters.ContainsKey('dup_weight')) { $Payload.Add('dup_weight', $dup_weight) }
            if ($PSBoundParameters.ContainsKey('healthmonitor')) { $Payload.Add('healthmonitor', $healthmonitor) }
            if ($PSBoundParameters.ContainsKey('cipheader')) { $Payload.Add('cipheader', $cipheader) }
            if ($PSBoundParameters.ContainsKey('pathmonitor')) { $Payload.Add('pathmonitor', $pathmonitor) }
            if ($PSBoundParameters.ContainsKey('pathmonitorindv')) { $Payload.Add('pathmonitorindv', $pathmonitorindv) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('monconnectionclose')) { $Payload.Add('monconnectionclose', $monconnectionclose) }
            if ($PSCmdlet.ShouldProcess("$servicegroupname", "Unset Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type servicegroup -Action unset -Payload $Payload -GetWarning
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

function Invoke-ADCEnableServicegroup {
<#
    .SYNOPSIS
        Enable Basic configuration Object
    .DESCRIPTION
        Enable Basic configuration Object 
    .PARAMETER servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER servername 
        Name of the server to which to bind the service group. 
    .PARAMETER port 
        Server port number.  
        * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        Invoke-ADCEnableServicegroup -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCEnableServicegroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicegroupname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servername ,

        [ValidateRange(1, 65535)]
        [int]$port 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableServicegroup: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSCmdlet.ShouldProcess($Name, "Enable Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type servicegroup -Action enable -Payload $Payload -GetWarning
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
        Disable Basic configuration Object
    .DESCRIPTION
        Disable Basic configuration Object 
    .PARAMETER servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER servername 
        Name of the server to which to bind the service group. 
    .PARAMETER port 
        Server port number.  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER delay 
        Time, in seconds, allocated for a shutdown of the services in the service group. During this period, new requests are sent to the service only for clients who already have persistent sessions on the appliance. Requests from new clients are load balanced among other available services. After the delay time expires, no requests are sent to the service, and the service is marked as unavailable (OUT OF SERVICE). 
    .PARAMETER graceful 
        Wait for all existing connections to the service to terminate before shutting down the service.  
        Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCDisableServicegroup -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCDisableServicegroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicegroupname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servername ,

        [ValidateRange(1, 65535)]
        [int]$port ,

        [double]$delay ,

        [ValidateSet('YES', 'NO')]
        [string]$graceful 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableServicegroup: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('delay')) { $Payload.Add('delay', $delay) }
            if ($PSBoundParameters.ContainsKey('graceful')) { $Payload.Add('graceful', $graceful) }
            if ($PSCmdlet.ShouldProcess($Name, "Disable Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type servicegroup -Action disable -Payload $Payload -GetWarning
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

function Invoke-ADCRenameServicegroup {
<#
    .SYNOPSIS
        Rename Basic configuration Object
    .DESCRIPTION
        Rename Basic configuration Object 
    .PARAMETER servicegroupname 
        Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created.  
        Minimum length = 1 
    .PARAMETER newname 
        New name for the service group.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created servicegroup item.
    .EXAMPLE
        Invoke-ADCRenameServicegroup -servicegroupname <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameServicegroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicegroupname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameServicegroup: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("servicegroup", "Rename Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type servicegroup -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetServicegroup -Filter $Payload)
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

function Invoke-ADCGetServicegroup {
<#
    .SYNOPSIS
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER servicegroupname 
       Name of the service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER GetAll 
        Retreive all servicegroup object(s)
    .PARAMETER Count
        If specified, the count of the servicegroup object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetServicegroup
    .EXAMPLE 
        Invoke-ADCGetServicegroup -GetAll 
    .EXAMPLE 
        Invoke-ADCGetServicegroup -Count
    .EXAMPLE
        Invoke-ADCGetServicegroup -name <string>
    .EXAMPLE
        Invoke-ADCGetServicegroup -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetServicegroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicegroupname,

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
        Write-Verbose "Invoke-ADCGetServicegroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all servicegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroup objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroup configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER servicegroupname 
       The name of the service. 
    .PARAMETER GetAll 
        Retreive all servicegroupbindings object(s)
    .PARAMETER Count
        If specified, the count of the servicegroupbindings object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetServicegroupbindings
    .EXAMPLE 
        Invoke-ADCGetServicegroupbindings -GetAll 
    .EXAMPLE 
        Invoke-ADCGetServicegroupbindings -Count
    .EXAMPLE
        Invoke-ADCGetServicegroupbindings -name <string>
    .EXAMPLE
        Invoke-ADCGetServicegroupbindings -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetServicegroupbindings
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroupbindings/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servicegroupname,
			
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all servicegroupbindings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroupbindings -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroupbindings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroupbindings -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroupbindings objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroupbindings -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroupbindings configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroupbindings -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroupbindings configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroupbindings -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER servicegroupname 
       Name of the service group. 
    .PARAMETER GetAll 
        Retreive all servicegroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the servicegroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetServicegroupbinding
    .EXAMPLE 
        Invoke-ADCGetServicegroupbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetServicegroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetServicegroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetServicegroupbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_binding/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servicegroupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetServicegroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all servicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroup_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_binding -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Basic configuration Object
    .DESCRIPTION
        Add Basic configuration Object 
    .PARAMETER servicegroupname 
        Name of the service group.  
        Minimum length = 1 
    .PARAMETER port 
        Port number of the service. Each service must have a unique port number.  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER monitor_name 
        Monitor name. 
    .PARAMETER monstate 
        Monitor state.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER passive 
        Indicates if load monitor is passive. A passive load monitor does not remove service from LB decision when threshold is breached. 
    .PARAMETER weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service.  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER customserverid 
        Unique service identifier. Used when the persistency type for the virtual server is set to Custom Server ID.  
        Default value: "None" 
    .PARAMETER serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER state 
        Initial state of the service after binding.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER hashid 
        Unique numerical identifier used by hash based load balancing methods to identify a service.  
        Minimum value = 1 
    .PARAMETER nameserver 
        Specify the nameserver to which the query for bound domain needs to be sent. If not specified, use the global nameserver. 
    .PARAMETER dbsttl 
        Specify the TTL for DNS record for domain based service.The default value of ttl is 0 which indicates to use the TTL received in DNS response for monitors.  
        Default value: 0 
    .PARAMETER PassThru 
        Return details about the created servicegroup_lbmonitor_binding item.
    .EXAMPLE
        Invoke-ADCAddServicegrouplbmonitorbinding -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCAddServicegrouplbmonitorbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_lbmonitor_binding/
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
        [string]$servicegroupname ,

        [ValidateRange(1, 65535)]
        [int]$port ,

        [string]$monitor_name ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$monstate ,

        [boolean]$passive ,

        [ValidateRange(1, 100)]
        [double]$weight ,

        [string]$customserverid = '"None"' ,

        [double]$serverid ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' ,

        [double]$hashid ,

        [string]$nameserver ,

        [double]$dbsttl = '0' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddServicegrouplbmonitorbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('monitor_name')) { $Payload.Add('monitor_name', $monitor_name) }
            if ($PSBoundParameters.ContainsKey('monstate')) { $Payload.Add('monstate', $monstate) }
            if ($PSBoundParameters.ContainsKey('passive')) { $Payload.Add('passive', $passive) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('customserverid')) { $Payload.Add('customserverid', $customserverid) }
            if ($PSBoundParameters.ContainsKey('serverid')) { $Payload.Add('serverid', $serverid) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('hashid')) { $Payload.Add('hashid', $hashid) }
            if ($PSBoundParameters.ContainsKey('nameserver')) { $Payload.Add('nameserver', $nameserver) }
            if ($PSBoundParameters.ContainsKey('dbsttl')) { $Payload.Add('dbsttl', $dbsttl) }
 
            if ($PSCmdlet.ShouldProcess("servicegroup_lbmonitor_binding", "Add Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type servicegroup_lbmonitor_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetServicegrouplbmonitorbinding -Filter $Payload)
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
        Delete Basic configuration Object
    .DESCRIPTION
        Delete Basic configuration Object
    .PARAMETER servicegroupname 
       Name of the service group.  
       Minimum length = 1    .PARAMETER port 
       Port number of the service. Each service must have a unique port number.  
       Range 1 - 65535  
       * in CLI is represented as 65535 in NITRO API    .PARAMETER monitor_name 
       Monitor name.
    .EXAMPLE
        Invoke-ADCDeleteServicegrouplbmonitorbinding -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteServicegrouplbmonitorbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_lbmonitor_binding/
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
        [string]$servicegroupname ,

        [int]$port ,

        [string]$monitor_name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteServicegrouplbmonitorbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('port')) { $Arguments.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('monitor_name')) { $Arguments.Add('monitor_name', $monitor_name) }
            if ($PSCmdlet.ShouldProcess("$servicegroupname", "Delete Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type servicegroup_lbmonitor_binding -Resource $servicegroupname -Arguments $Arguments
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
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER servicegroupname 
       Name of the service group. 
    .PARAMETER GetAll 
        Retreive all servicegroup_lbmonitor_binding object(s)
    .PARAMETER Count
        If specified, the count of the servicegroup_lbmonitor_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetServicegrouplbmonitorbinding
    .EXAMPLE 
        Invoke-ADCGetServicegrouplbmonitorbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetServicegrouplbmonitorbinding -Count
    .EXAMPLE
        Invoke-ADCGetServicegrouplbmonitorbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetServicegrouplbmonitorbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetServicegrouplbmonitorbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_lbmonitor_binding/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servicegroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all servicegroup_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_lbmonitor_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroup_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_lbmonitor_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroup_lbmonitor_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_lbmonitor_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroup_lbmonitor_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_lbmonitor_binding -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroup_lbmonitor_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_lbmonitor_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER servicegroupname 
       Name of the service group. 
    .PARAMETER GetAll 
        Retreive all servicegroup_servicegroupentitymonbindings_binding object(s)
    .PARAMETER Count
        If specified, the count of the servicegroup_servicegroupentitymonbindings_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetServicegroupservicegroupentitymonbindingsbinding
    .EXAMPLE 
        Invoke-ADCGetServicegroupservicegroupentitymonbindingsbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetServicegroupservicegroupentitymonbindingsbinding -Count
    .EXAMPLE
        Invoke-ADCGetServicegroupservicegroupentitymonbindingsbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetServicegroupservicegroupentitymonbindingsbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetServicegroupservicegroupentitymonbindingsbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_servicegroupentitymonbindings_binding/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servicegroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all servicegroup_servicegroupentitymonbindings_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupentitymonbindings_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroup_servicegroupentitymonbindings_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupentitymonbindings_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroup_servicegroupentitymonbindings_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupentitymonbindings_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroup_servicegroupentitymonbindings_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupentitymonbindings_binding -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroup_servicegroupentitymonbindings_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupentitymonbindings_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Basic configuration Object
    .DESCRIPTION
        Add Basic configuration Object 
    .PARAMETER servicegroupname 
        Name of the service group.  
        Minimum length = 1 
    .PARAMETER members 
        Desired servicegroupmember binding set. Any existing servicegroupmember which is not part of the input will be deleted or disabled based on graceful setting on servicegroup.
    .EXAMPLE
        Invoke-ADCAddServicegroupservicegroupmemberlistbinding -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCAddServicegroupservicegroupmemberlistbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_servicegroupmemberlist_binding/
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
        [string]$servicegroupname ,

        [object[]]$members 

    )
    begin {
        Write-Verbose "Invoke-ADCAddServicegroupservicegroupmemberlistbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('members')) { $Payload.Add('members', $members) }
 
            if ($PSCmdlet.ShouldProcess("servicegroup_servicegroupmemberlist_binding", "Add Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type servicegroup_servicegroupmemberlist_binding -Payload $Payload -GetWarning
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
        Delete Basic configuration Object
    .DESCRIPTION
        Delete Basic configuration Object
    .PARAMETER servicegroupname 
       Name of the service group.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteServicegroupservicegroupmemberlistbinding -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteServicegroupservicegroupmemberlistbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_servicegroupmemberlist_binding/
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
        [string]$servicegroupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteServicegroupservicegroupmemberlistbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$servicegroupname", "Delete Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type servicegroup_servicegroupmemberlist_binding -Resource $servicegroupname -Arguments $Arguments
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
        Add Basic configuration Object
    .DESCRIPTION
        Add Basic configuration Object 
    .PARAMETER servicegroupname 
        Name of the service group.  
        Minimum length = 1 
    .PARAMETER ip 
        IP Address. 
    .PARAMETER servername 
        Name of the server to which to bind the service group.  
        Minimum length = 1 
    .PARAMETER port 
        Server port number.  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service.  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER customserverid 
        The identifier for this IP:Port pair. Used when the persistency type is set to Custom Server ID.  
        Default value: "None" 
    .PARAMETER serverid 
        The identifier for the service. This is used when the persistency type is set to Custom Server ID. 
    .PARAMETER state 
        Initial state of the service group.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER hashid 
        The hash identifier for the service. This must be unique for each service. This parameter is used by hash based load balancing methods.  
        Minimum value = 1 
    .PARAMETER nameserver 
        Specify the nameserver to which the query for bound domain needs to be sent. If not specified, use the global nameserver. 
    .PARAMETER dbsttl 
        Specify the TTL for DNS record for domain based service.The default value of ttl is 0 which indicates to use the TTL received in DNS response for monitors.  
        Default value: 0 
    .PARAMETER PassThru 
        Return details about the created servicegroup_servicegroupmember_binding item.
    .EXAMPLE
        Invoke-ADCAddServicegroupservicegroupmemberbinding -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCAddServicegroupservicegroupmemberbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_servicegroupmember_binding/
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
        [string]$servicegroupname ,

        [string]$ip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servername ,

        [ValidateRange(1, 65535)]
        [int]$port ,

        [ValidateRange(1, 100)]
        [double]$weight ,

        [string]$customserverid = '"None"' ,

        [double]$serverid ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' ,

        [double]$hashid ,

        [string]$nameserver ,

        [double]$dbsttl = '0' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddServicegroupservicegroupmemberbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('ip')) { $Payload.Add('ip', $ip) }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('customserverid')) { $Payload.Add('customserverid', $customserverid) }
            if ($PSBoundParameters.ContainsKey('serverid')) { $Payload.Add('serverid', $serverid) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('hashid')) { $Payload.Add('hashid', $hashid) }
            if ($PSBoundParameters.ContainsKey('nameserver')) { $Payload.Add('nameserver', $nameserver) }
            if ($PSBoundParameters.ContainsKey('dbsttl')) { $Payload.Add('dbsttl', $dbsttl) }
 
            if ($PSCmdlet.ShouldProcess("servicegroup_servicegroupmember_binding", "Add Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type servicegroup_servicegroupmember_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetServicegroupservicegroupmemberbinding -Filter $Payload)
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
        Delete Basic configuration Object
    .DESCRIPTION
        Delete Basic configuration Object
    .PARAMETER servicegroupname 
       Name of the service group.  
       Minimum length = 1    .PARAMETER ip 
       IP Address.    .PARAMETER servername 
       Name of the server to which to bind the service group.  
       Minimum length = 1    .PARAMETER port 
       Server port number.  
       Range 1 - 65535  
       * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        Invoke-ADCDeleteServicegroupservicegroupmemberbinding -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteServicegroupservicegroupmemberbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_servicegroupmember_binding/
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
        [string]$servicegroupname ,

        [string]$ip ,

        [string]$servername ,

        [int]$port 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteServicegroupservicegroupmemberbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ip')) { $Arguments.Add('ip', $ip) }
            if ($PSBoundParameters.ContainsKey('servername')) { $Arguments.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('port')) { $Arguments.Add('port', $port) }
            if ($PSCmdlet.ShouldProcess("$servicegroupname", "Delete Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type servicegroup_servicegroupmember_binding -Resource $servicegroupname -Arguments $Arguments
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
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER servicegroupname 
       Name of the service group. 
    .PARAMETER GetAll 
        Retreive all servicegroup_servicegroupmember_binding object(s)
    .PARAMETER Count
        If specified, the count of the servicegroup_servicegroupmember_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetServicegroupservicegroupmemberbinding
    .EXAMPLE 
        Invoke-ADCGetServicegroupservicegroupmemberbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetServicegroupservicegroupmemberbinding -Count
    .EXAMPLE
        Invoke-ADCGetServicegroupservicegroupmemberbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetServicegroupservicegroupmemberbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetServicegroupservicegroupmemberbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/servicegroup_servicegroupmember_binding/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servicegroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all servicegroup_servicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupmember_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroup_servicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupmember_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroup_servicegroupmember_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupmember_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroup_servicegroupmember_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupmember_binding -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroup_servicegroupmember_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup_servicegroupmember_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER name 
       Name of the service for which to display configuration details. 
    .PARAMETER GetAll 
        Retreive all service_binding object(s)
    .PARAMETER Count
        If specified, the count of the service_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetServicebinding
    .EXAMPLE 
        Invoke-ADCGetServicebinding -GetAll
    .EXAMPLE
        Invoke-ADCGetServicebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetServicebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetServicebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_binding/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetServicebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving service_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving service_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving service_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Basic configuration Object
    .DESCRIPTION
        Add Basic configuration Object 
    .PARAMETER name 
        Name of the service to which to bind a policy or monitor.  
        Minimum length = 1 
    .PARAMETER policyname 
        The name of the policyname for which this service is bound. 
    .PARAMETER PassThru 
        Return details about the created service_dospolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddServicedospolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddServicedospolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_dospolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddServicedospolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
 
            if ($PSCmdlet.ShouldProcess("service_dospolicy_binding", "Add Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type service_dospolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetServicedospolicybinding -Filter $Payload)
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
        Delete Basic configuration Object
    .DESCRIPTION
        Delete Basic configuration Object
    .PARAMETER name 
       Name of the service to which to bind a policy or monitor.  
       Minimum length = 1    .PARAMETER policyname 
       The name of the policyname for which this service is bound.
    .EXAMPLE
        Invoke-ADCDeleteServicedospolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteServicedospolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_dospolicy_binding/
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
        [string]$name ,

        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteServicedospolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type service_dospolicy_binding -Resource $name -Arguments $Arguments
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
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER name 
       Name of the service to which to bind a policy or monitor. 
    .PARAMETER GetAll 
        Retreive all service_dospolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the service_dospolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetServicedospolicybinding
    .EXAMPLE 
        Invoke-ADCGetServicedospolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetServicedospolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetServicedospolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetServicedospolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetServicedospolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_dospolicy_binding/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all service_dospolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_dospolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for service_dospolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_dospolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving service_dospolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_dospolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving service_dospolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_dospolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving service_dospolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_dospolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Basic configuration Object
    .DESCRIPTION
        Add Basic configuration Object 
    .PARAMETER name 
        Name of the service to which to bind a policy or monitor.  
        Minimum length = 1 
    .PARAMETER monitor_name 
        The monitor Names. 
    .PARAMETER monstate 
        The configured state (enable/disable) of the monitor on this server.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER weight 
        Weight to assign to the monitor-service binding. When a monitor is UP, the weight assigned to its binding with the service determines how much the monitor contributes toward keeping the health of the service above the value configured for the Monitor Threshold parameter.  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER passive 
        Indicates if load monitor is passive. A passive load monitor does not remove service from LB decision when threshold is breached. 
    .PARAMETER PassThru 
        Return details about the created service_lbmonitor_binding item.
    .EXAMPLE
        Invoke-ADCAddServicelbmonitorbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddServicelbmonitorbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_lbmonitor_binding/
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
        [string]$name ,

        [string]$monitor_name ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$monstate ,

        [ValidateRange(1, 100)]
        [double]$weight ,

        [boolean]$passive ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddServicelbmonitorbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('monitor_name')) { $Payload.Add('monitor_name', $monitor_name) }
            if ($PSBoundParameters.ContainsKey('monstate')) { $Payload.Add('monstate', $monstate) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('passive')) { $Payload.Add('passive', $passive) }
 
            if ($PSCmdlet.ShouldProcess("service_lbmonitor_binding", "Add Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type service_lbmonitor_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetServicelbmonitorbinding -Filter $Payload)
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
        Delete Basic configuration Object
    .DESCRIPTION
        Delete Basic configuration Object
    .PARAMETER name 
       Name of the service to which to bind a policy or monitor.  
       Minimum length = 1    .PARAMETER monitor_name 
       The monitor Names.
    .EXAMPLE
        Invoke-ADCDeleteServicelbmonitorbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteServicelbmonitorbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_lbmonitor_binding/
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
        [string]$name ,

        [string]$monitor_name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteServicelbmonitorbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('monitor_name')) { $Arguments.Add('monitor_name', $monitor_name) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type service_lbmonitor_binding -Resource $name -Arguments $Arguments
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
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER name 
       Name of the service to which to bind a policy or monitor. 
    .PARAMETER GetAll 
        Retreive all service_lbmonitor_binding object(s)
    .PARAMETER Count
        If specified, the count of the service_lbmonitor_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetServicelbmonitorbinding
    .EXAMPLE 
        Invoke-ADCGetServicelbmonitorbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetServicelbmonitorbinding -Count
    .EXAMPLE
        Invoke-ADCGetServicelbmonitorbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetServicelbmonitorbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetServicelbmonitorbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_lbmonitor_binding/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all service_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_lbmonitor_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for service_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_lbmonitor_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving service_lbmonitor_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_lbmonitor_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving service_lbmonitor_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_lbmonitor_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving service_lbmonitor_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_lbmonitor_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Basic configuration Object
    .DESCRIPTION
        Add Basic configuration Object 
    .PARAMETER name 
        Name of the service to which to bind a policy or monitor.  
        Minimum length = 1 
    .PARAMETER policyname 
        The name of the policyname for which this service is bound. 
    .PARAMETER PassThru 
        Return details about the created service_scpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddServicescpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddServicescpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_scpolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddServicescpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
 
            if ($PSCmdlet.ShouldProcess("service_scpolicy_binding", "Add Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type service_scpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetServicescpolicybinding -Filter $Payload)
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
        Delete Basic configuration Object
    .DESCRIPTION
        Delete Basic configuration Object
    .PARAMETER name 
       Name of the service to which to bind a policy or monitor.  
       Minimum length = 1    .PARAMETER policyname 
       The name of the policyname for which this service is bound.
    .EXAMPLE
        Invoke-ADCDeleteServicescpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteServicescpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_scpolicy_binding/
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
        [string]$name ,

        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteServicescpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type service_scpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER name 
       Name of the service to which to bind a policy or monitor. 
    .PARAMETER GetAll 
        Retreive all service_scpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the service_scpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetServicescpolicybinding
    .EXAMPLE 
        Invoke-ADCGetServicescpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetServicescpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetServicescpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetServicescpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetServicescpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/service_scpolicy_binding/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all service_scpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_scpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for service_scpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_scpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving service_scpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_scpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving service_scpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_scpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving service_scpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service_scpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Basic configuration object(s)
    .DESCRIPTION
        Get Basic configuration object(s)
    .PARAMETER servicename 
       The name of the service. 
    .PARAMETER GetAll 
        Retreive all svcbindings object(s)
    .PARAMETER Count
        If specified, the count of the svcbindings object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSvcbindings
    .EXAMPLE 
        Invoke-ADCGetSvcbindings -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSvcbindings -Count
    .EXAMPLE
        Invoke-ADCGetSvcbindings -name <string>
    .EXAMPLE
        Invoke-ADCGetSvcbindings -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSvcbindings
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/svcbindings/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servicename,
			
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all svcbindings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type svcbindings -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for svcbindings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type svcbindings -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving svcbindings objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type svcbindings -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving svcbindings configuration for property 'servicename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type svcbindings -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving svcbindings configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type svcbindings -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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

function Invoke-ADCDeleteVserver {
<#
    .SYNOPSIS
        Delete Basic configuration Object
    .DESCRIPTION
        Delete Basic configuration Object
    .PARAMETER name 
       The name of the virtual server to be removed.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteVserver -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteVserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/vserver/
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
        Write-Verbose "Invoke-ADCDeleteVserver: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Basic configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type vserver -Resource $name -Arguments $Arguments
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
        Update Basic configuration Object
    .DESCRIPTION
        Update Basic configuration Object 
    .PARAMETER name 
        The name of the virtual server to be removed.  
        Minimum length = 1 
    .PARAMETER backupvserver 
        The name of the backup virtual server for this virtual server.  
        Minimum length = 1 
    .PARAMETER redirecturl 
        The URL where traffic is redirected if the virtual server in the system becomes unavailable.  
        Minimum length = 1 
    .PARAMETER cacheable 
        Use this option to specify whether a virtual server (used for load balancing or content switching) routes requests to the cache redirection virtual server before sending it to the configured servers.  
        Possible values = YES, NO 
    .PARAMETER clttimeout 
        The timeout value in seconds for idle client connection.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER somethod 
        The spillover factor. The system will use this value to determine if it should send traffic to the backupvserver when the main virtual server reaches the spillover threshold.  
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER sopersistence 
        The state of the spillover persistence.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sopersistencetimeout 
        The spillover persistence entry timeout.  
        Default value: 2  
        Minimum value = 2  
        Maximum value = 1440 
    .PARAMETER sothreshold 
        The spillver threshold value.  
        Minimum value = 1  
        Maximum value = 4294967294 
    .PARAMETER pushvserver 
        The lb vserver of type PUSH/SSL_PUSH to which server pushes the updates received on the client facing non-push lb vserver.  
        Minimum length = 1
    .EXAMPLE
        Invoke-ADCUpdateVserver -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateVserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/vserver/
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
        [string]$name ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$backupvserver ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$redirecturl ,

        [ValidateSet('YES', 'NO')]
        [string]$cacheable ,

        [ValidateRange(0, 31536000)]
        [double]$clttimeout ,

        [ValidateSet('CONNECTION', 'DYNAMICCONNECTION', 'BANDWIDTH', 'HEALTH', 'NONE')]
        [string]$somethod ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sopersistence ,

        [ValidateRange(2, 1440)]
        [double]$sopersistencetimeout ,

        [ValidateRange(1, 4294967294)]
        [double]$sothreshold ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$pushvserver 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateVserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('backupvserver')) { $Payload.Add('backupvserver', $backupvserver) }
            if ($PSBoundParameters.ContainsKey('redirecturl')) { $Payload.Add('redirecturl', $redirecturl) }
            if ($PSBoundParameters.ContainsKey('cacheable')) { $Payload.Add('cacheable', $cacheable) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('somethod')) { $Payload.Add('somethod', $somethod) }
            if ($PSBoundParameters.ContainsKey('sopersistence')) { $Payload.Add('sopersistence', $sopersistence) }
            if ($PSBoundParameters.ContainsKey('sopersistencetimeout')) { $Payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('sothreshold')) { $Payload.Add('sothreshold', $sothreshold) }
            if ($PSBoundParameters.ContainsKey('pushvserver')) { $Payload.Add('pushvserver', $pushvserver) }
 
            if ($PSCmdlet.ShouldProcess("vserver", "Update Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type vserver -Payload $Payload -GetWarning
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

function Invoke-ADCEnableVserver {
<#
    .SYNOPSIS
        Enable Basic configuration Object
    .DESCRIPTION
        Enable Basic configuration Object 
    .PARAMETER name 
        The name of the virtual server to be removed.
    .EXAMPLE
        Invoke-ADCEnableVserver -name <string>
    .NOTES
        File Name : Invoke-ADCEnableVserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/vserver/
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
        [string]$name 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableVserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

            if ($PSCmdlet.ShouldProcess($Name, "Enable Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type vserver -Action enable -Payload $Payload -GetWarning
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
        Disable Basic configuration Object
    .DESCRIPTION
        Disable Basic configuration Object 
    .PARAMETER name 
        The name of the virtual server to be removed.
    .EXAMPLE
        Invoke-ADCDisableVserver -name <string>
    .NOTES
        File Name : Invoke-ADCDisableVserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/basic/vserver/
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
        [string]$name 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableVserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

            if ($PSCmdlet.ShouldProcess($Name, "Disable Basic configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type vserver -Action disable -Payload $Payload -GetWarning
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


