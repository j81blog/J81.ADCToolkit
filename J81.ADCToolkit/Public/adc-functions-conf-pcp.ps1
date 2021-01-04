function Invoke-ADCGetPcpmap {
<#
    .SYNOPSIS
        Get Pcp configuration object(s)
    .DESCRIPTION
        Get Pcp configuration object(s)
    .PARAMETER nattype 
       Type of sessions to be displayed.  
       Possible values = NAT44, DS-Lite, NAT64 
    .PARAMETER GetAll 
        Retreive all pcpmap object(s)
    .PARAMETER Count
        If specified, the count of the pcpmap object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPcpmap
    .EXAMPLE 
        Invoke-ADCGetPcpmap -GetAll 
    .EXAMPLE 
        Invoke-ADCGetPcpmap -Count
    .EXAMPLE
        Invoke-ADCGetPcpmap -name <string>
    .EXAMPLE
        Invoke-ADCGetPcpmap -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPcpmap
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpmap/
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
        [ValidateSet('NAT44', 'DS-Lite', 'NAT64')]
        [string]$nattype,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetPcpmap: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all pcpmap objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpmap -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for pcpmap objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpmap -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving pcpmap objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('nattype')) { $Arguments.Add('nattype', $nattype) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpmap -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving pcpmap configuration for property ''"

            } else {
                Write-Verbose "Retrieving pcpmap configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpmap -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPcpmap: Ended"
    }
}

function Invoke-ADCAddPcpprofile {
<#
    .SYNOPSIS
        Add Pcp configuration Object
    .DESCRIPTION
        Add Pcp configuration Object 
    .PARAMETER name 
        Name for the PCP Profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpProfile" or my pcpProfile). 
    .PARAMETER mapping 
        This argument is for enabling/disabling the MAP opcode of current PCP Profile.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER peer 
        This argument is for enabling/disabling the PEER opcode of current PCP Profile.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER minmaplife 
        Integer value that identify the minimum mapping lifetime (in seconds) for a pcp profile. default(120s).  
        Minimum value = 1  
        Maximum value = 2147483647 
    .PARAMETER maxmaplife 
        Integer value that identify the maximum mapping lifetime (in seconds) for a pcp profile. default(86400s = 24Hours).  
        Minimum value = 1  
        Maximum value = 2147483647 
    .PARAMETER announcemulticount 
        Integer value that identify the number announce message to be send.  
        Default value: 10  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER thirdparty 
        This argument is for enabling/disabling the THIRD PARTY opcode of current PCP Profile.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created pcpprofile item.
    .EXAMPLE
        Invoke-ADCAddPcpprofile -name <string>
    .NOTES
        File Name : Invoke-ADCAddPcpprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpprofile/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$mapping = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$peer = 'ENABLED' ,

        [ValidateRange(1, 2147483647)]
        [double]$minmaplife ,

        [ValidateRange(1, 2147483647)]
        [double]$maxmaplife ,

        [ValidateRange(0, 65535)]
        [double]$announcemulticount = '10' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$thirdparty = 'DISABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddPcpprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('mapping')) { $Payload.Add('mapping', $mapping) }
            if ($PSBoundParameters.ContainsKey('peer')) { $Payload.Add('peer', $peer) }
            if ($PSBoundParameters.ContainsKey('minmaplife')) { $Payload.Add('minmaplife', $minmaplife) }
            if ($PSBoundParameters.ContainsKey('maxmaplife')) { $Payload.Add('maxmaplife', $maxmaplife) }
            if ($PSBoundParameters.ContainsKey('announcemulticount')) { $Payload.Add('announcemulticount', $announcemulticount) }
            if ($PSBoundParameters.ContainsKey('thirdparty')) { $Payload.Add('thirdparty', $thirdparty) }
 
            if ($PSCmdlet.ShouldProcess("pcpprofile", "Add Pcp configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type pcpprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPcpprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddPcpprofile: Finished"
    }
}

function Invoke-ADCDeletePcpprofile {
<#
    .SYNOPSIS
        Delete Pcp configuration Object
    .DESCRIPTION
        Delete Pcp configuration Object
    .PARAMETER name 
       Name for the PCP Profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpProfile" or my pcpProfile). 
    .EXAMPLE
        Invoke-ADCDeletePcpprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeletePcpprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpprofile/
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
        Write-Verbose "Invoke-ADCDeletePcpprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Pcp configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type pcpprofile -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeletePcpprofile: Finished"
    }
}

function Invoke-ADCUpdatePcpprofile {
<#
    .SYNOPSIS
        Update Pcp configuration Object
    .DESCRIPTION
        Update Pcp configuration Object 
    .PARAMETER name 
        Name for the PCP Profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpProfile" or my pcpProfile). 
    .PARAMETER mapping 
        This argument is for enabling/disabling the MAP opcode of current PCP Profile.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER peer 
        This argument is for enabling/disabling the PEER opcode of current PCP Profile.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER minmaplife 
        Integer value that identify the minimum mapping lifetime (in seconds) for a pcp profile. default(120s).  
        Minimum value = 1  
        Maximum value = 2147483647 
    .PARAMETER maxmaplife 
        Integer value that identify the maximum mapping lifetime (in seconds) for a pcp profile. default(86400s = 24Hours).  
        Minimum value = 1  
        Maximum value = 2147483647 
    .PARAMETER announcemulticount 
        Integer value that identify the number announce message to be send.  
        Default value: 10  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER thirdparty 
        This argument is for enabling/disabling the THIRD PARTY opcode of current PCP Profile.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created pcpprofile item.
    .EXAMPLE
        Invoke-ADCUpdatePcpprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUpdatePcpprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpprofile/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$mapping ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$peer ,

        [ValidateRange(1, 2147483647)]
        [double]$minmaplife ,

        [ValidateRange(1, 2147483647)]
        [double]$maxmaplife ,

        [ValidateRange(0, 65535)]
        [double]$announcemulticount ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$thirdparty ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdatePcpprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('mapping')) { $Payload.Add('mapping', $mapping) }
            if ($PSBoundParameters.ContainsKey('peer')) { $Payload.Add('peer', $peer) }
            if ($PSBoundParameters.ContainsKey('minmaplife')) { $Payload.Add('minmaplife', $minmaplife) }
            if ($PSBoundParameters.ContainsKey('maxmaplife')) { $Payload.Add('maxmaplife', $maxmaplife) }
            if ($PSBoundParameters.ContainsKey('announcemulticount')) { $Payload.Add('announcemulticount', $announcemulticount) }
            if ($PSBoundParameters.ContainsKey('thirdparty')) { $Payload.Add('thirdparty', $thirdparty) }
 
            if ($PSCmdlet.ShouldProcess("pcpprofile", "Update Pcp configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type pcpprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPcpprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdatePcpprofile: Finished"
    }
}

function Invoke-ADCUnsetPcpprofile {
<#
    .SYNOPSIS
        Unset Pcp configuration Object
    .DESCRIPTION
        Unset Pcp configuration Object 
   .PARAMETER name 
       Name for the PCP Profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpProfile" or my pcpProfile). 
   .PARAMETER mapping 
       This argument is for enabling/disabling the MAP opcode of current PCP Profile.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER peer 
       This argument is for enabling/disabling the PEER opcode of current PCP Profile.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER minmaplife 
       Integer value that identify the minimum mapping lifetime (in seconds) for a pcp profile. default(120s). 
   .PARAMETER maxmaplife 
       Integer value that identify the maximum mapping lifetime (in seconds) for a pcp profile. default(86400s = 24Hours). 
   .PARAMETER announcemulticount 
       Integer value that identify the number announce message to be send. 
   .PARAMETER thirdparty 
       This argument is for enabling/disabling the THIRD PARTY opcode of current PCP Profile.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetPcpprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetPcpprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpprofile
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

        [Boolean]$mapping ,

        [Boolean]$peer ,

        [Boolean]$minmaplife ,

        [Boolean]$maxmaplife ,

        [Boolean]$announcemulticount ,

        [Boolean]$thirdparty 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetPcpprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('mapping')) { $Payload.Add('mapping', $mapping) }
            if ($PSBoundParameters.ContainsKey('peer')) { $Payload.Add('peer', $peer) }
            if ($PSBoundParameters.ContainsKey('minmaplife')) { $Payload.Add('minmaplife', $minmaplife) }
            if ($PSBoundParameters.ContainsKey('maxmaplife')) { $Payload.Add('maxmaplife', $maxmaplife) }
            if ($PSBoundParameters.ContainsKey('announcemulticount')) { $Payload.Add('announcemulticount', $announcemulticount) }
            if ($PSBoundParameters.ContainsKey('thirdparty')) { $Payload.Add('thirdparty', $thirdparty) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Pcp configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type pcpprofile -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetPcpprofile: Finished"
    }
}

function Invoke-ADCGetPcpprofile {
<#
    .SYNOPSIS
        Get Pcp configuration object(s)
    .DESCRIPTION
        Get Pcp configuration object(s)
    .PARAMETER name 
       Name for the PCP Profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpProfile" or my pcpProfile). 
    .PARAMETER GetAll 
        Retreive all pcpprofile object(s)
    .PARAMETER Count
        If specified, the count of the pcpprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPcpprofile
    .EXAMPLE 
        Invoke-ADCGetPcpprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetPcpprofile -Count
    .EXAMPLE
        Invoke-ADCGetPcpprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetPcpprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPcpprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpprofile/
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
        Write-Verbose "Invoke-ADCGetPcpprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all pcpprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for pcpprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving pcpprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving pcpprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving pcpprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPcpprofile: Ended"
    }
}

function Invoke-ADCAddPcpserver {
<#
    .SYNOPSIS
        Add Pcp configuration Object
    .DESCRIPTION
        Add Pcp configuration Object 
    .PARAMETER name 
        Name for the PCP server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpServer" or my pcpServer). 
    .PARAMETER ipaddress 
        The IP address of the PCP server. 
    .PARAMETER port 
        Port number for the PCP server.  
        Default value: 5351  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER pcpprofile 
        pcp profile name. 
    .PARAMETER PassThru 
        Return details about the created pcpserver item.
    .EXAMPLE
        Invoke-ADCAddPcpserver -name <string> -ipaddress <string>
    .NOTES
        File Name : Invoke-ADCAddPcpserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpserver/
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

        [Parameter(Mandatory = $true)]
        [string]$ipaddress ,

        [ValidateRange(1, 65535)]
        [int]$port = '5351' ,

        [string]$pcpprofile ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddPcpserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                ipaddress = $ipaddress
            }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('pcpprofile')) { $Payload.Add('pcpprofile', $pcpprofile) }
 
            if ($PSCmdlet.ShouldProcess("pcpserver", "Add Pcp configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type pcpserver -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPcpserver -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddPcpserver: Finished"
    }
}

function Invoke-ADCDeletePcpserver {
<#
    .SYNOPSIS
        Delete Pcp configuration Object
    .DESCRIPTION
        Delete Pcp configuration Object
    .PARAMETER name 
       Name for the PCP server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpServer" or my pcpServer). 
    .EXAMPLE
        Invoke-ADCDeletePcpserver -name <string>
    .NOTES
        File Name : Invoke-ADCDeletePcpserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpserver/
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
        Write-Verbose "Invoke-ADCDeletePcpserver: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Pcp configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type pcpserver -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeletePcpserver: Finished"
    }
}

function Invoke-ADCUpdatePcpserver {
<#
    .SYNOPSIS
        Update Pcp configuration Object
    .DESCRIPTION
        Update Pcp configuration Object 
    .PARAMETER name 
        Name for the PCP server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpServer" or my pcpServer). 
    .PARAMETER port 
        Port number for the PCP server.  
        Default value: 5351  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER pcpprofile 
        pcp profile name. 
    .PARAMETER PassThru 
        Return details about the created pcpserver item.
    .EXAMPLE
        Invoke-ADCUpdatePcpserver -name <string>
    .NOTES
        File Name : Invoke-ADCUpdatePcpserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpserver/
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

        [ValidateRange(1, 65535)]
        [int]$port ,

        [string]$pcpprofile ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdatePcpserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('pcpprofile')) { $Payload.Add('pcpprofile', $pcpprofile) }
 
            if ($PSCmdlet.ShouldProcess("pcpserver", "Update Pcp configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type pcpserver -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPcpserver -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdatePcpserver: Finished"
    }
}

function Invoke-ADCUnsetPcpserver {
<#
    .SYNOPSIS
        Unset Pcp configuration Object
    .DESCRIPTION
        Unset Pcp configuration Object 
   .PARAMETER name 
       Name for the PCP server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpServer" or my pcpServer). 
   .PARAMETER port 
       Port number for the PCP server.  
       * in CLI is represented as 65535 in NITRO API 
   .PARAMETER pcpprofile 
       pcp profile name.
    .EXAMPLE
        Invoke-ADCUnsetPcpserver -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetPcpserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpserver
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

        [Boolean]$port ,

        [Boolean]$pcpprofile 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetPcpserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('pcpprofile')) { $Payload.Add('pcpprofile', $pcpprofile) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Pcp configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type pcpserver -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetPcpserver: Finished"
    }
}

function Invoke-ADCGetPcpserver {
<#
    .SYNOPSIS
        Get Pcp configuration object(s)
    .DESCRIPTION
        Get Pcp configuration object(s)
    .PARAMETER name 
       Name for the PCP server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpServer" or my pcpServer). 
    .PARAMETER GetAll 
        Retreive all pcpserver object(s)
    .PARAMETER Count
        If specified, the count of the pcpserver object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPcpserver
    .EXAMPLE 
        Invoke-ADCGetPcpserver -GetAll 
    .EXAMPLE 
        Invoke-ADCGetPcpserver -Count
    .EXAMPLE
        Invoke-ADCGetPcpserver -name <string>
    .EXAMPLE
        Invoke-ADCGetPcpserver -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPcpserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpserver/
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
        Write-Verbose "Invoke-ADCGetPcpserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all pcpserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpserver -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for pcpserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpserver -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving pcpserver objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpserver -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving pcpserver configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpserver -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving pcpserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPcpserver: Ended"
    }
}


