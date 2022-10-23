function Invoke-ADCGetPcpmap {
    <#
    .SYNOPSIS
        Get Pcp configuration object(s).
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Nattype 
        Type of sessions to be displayed. 
        Possible values = NAT44, DS-Lite, NAT64 
    .PARAMETER GetAll 
        Retrieve all pcpmap object(s).
    .PARAMETER Count
        If specified, the count of the pcpmap object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPcpmap
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPcpmap -GetAll 
        Get all pcpmap data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPcpmap -Count 
        Get the number of pcpmap objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPcpmap -name <string>
        Get pcpmap object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPcpmap -Filter @{ 'name'='<value>' }
        Get pcpmap data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPcpmap
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpmap/
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
        [ValidateSet('NAT44', 'DS-Lite', 'NAT64')]
        [string]$Nattype,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all pcpmap objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpmap -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for pcpmap objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpmap -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving pcpmap objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('nattype') ) { $arguments.Add('nattype', $nattype) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpmap -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving pcpmap configuration for property ''"

            } else {
                Write-Verbose "Retrieving pcpmap configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpmap -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Pcp configuration Object.
    .DESCRIPTION
        Configuration for PCP Profile resource.
    .PARAMETER Name 
        Name for the PCP Profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpProfile" or my pcpProfile). 
    .PARAMETER Mapping 
        This argument is for enabling/disabling the MAP opcode of current PCP Profile. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Peer 
        This argument is for enabling/disabling the PEER opcode of current PCP Profile. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Minmaplife 
        Integer value that identify the minimum mapping lifetime (in seconds) for a pcp profile. default(120s). 
    .PARAMETER Maxmaplife 
        Integer value that identify the maximum mapping lifetime (in seconds) for a pcp profile. default(86400s = 24Hours). 
    .PARAMETER Announcemulticount 
        Integer value that identify the number announce message to be send. 
    .PARAMETER Thirdparty 
        This argument is for enabling/disabling the THIRD PARTY opcode of current PCP Profile. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created pcpprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddPcpprofile -name <string>
        An example how to add pcpprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddPcpprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpprofile/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Mapping = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Peer = 'ENABLED',

        [ValidateRange(1, 2147483647)]
        [double]$Minmaplife,

        [ValidateRange(1, 2147483647)]
        [double]$Maxmaplife,

        [ValidateRange(0, 65535)]
        [double]$Announcemulticount = '10',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Thirdparty = 'DISABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddPcpprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('mapping') ) { $payload.Add('mapping', $mapping) }
            if ( $PSBoundParameters.ContainsKey('peer') ) { $payload.Add('peer', $peer) }
            if ( $PSBoundParameters.ContainsKey('minmaplife') ) { $payload.Add('minmaplife', $minmaplife) }
            if ( $PSBoundParameters.ContainsKey('maxmaplife') ) { $payload.Add('maxmaplife', $maxmaplife) }
            if ( $PSBoundParameters.ContainsKey('announcemulticount') ) { $payload.Add('announcemulticount', $announcemulticount) }
            if ( $PSBoundParameters.ContainsKey('thirdparty') ) { $payload.Add('thirdparty', $thirdparty) }
            if ( $PSCmdlet.ShouldProcess("pcpprofile", "Add Pcp configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type pcpprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetPcpprofile -Filter $payload)
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
        Delete Pcp configuration Object.
    .DESCRIPTION
        Configuration for PCP Profile resource.
    .PARAMETER Name 
        Name for the PCP Profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpProfile" or my pcpProfile).
    .EXAMPLE
        PS C:\>Invoke-ADCDeletePcpprofile -Name <string>
        An example how to delete pcpprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeletePcpprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpprofile/
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
        Write-Verbose "Invoke-ADCDeletePcpprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Pcp configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type pcpprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update Pcp configuration Object.
    .DESCRIPTION
        Configuration for PCP Profile resource.
    .PARAMETER Name 
        Name for the PCP Profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpProfile" or my pcpProfile). 
    .PARAMETER Mapping 
        This argument is for enabling/disabling the MAP opcode of current PCP Profile. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Peer 
        This argument is for enabling/disabling the PEER opcode of current PCP Profile. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Minmaplife 
        Integer value that identify the minimum mapping lifetime (in seconds) for a pcp profile. default(120s). 
    .PARAMETER Maxmaplife 
        Integer value that identify the maximum mapping lifetime (in seconds) for a pcp profile. default(86400s = 24Hours). 
    .PARAMETER Announcemulticount 
        Integer value that identify the number announce message to be send. 
    .PARAMETER Thirdparty 
        This argument is for enabling/disabling the THIRD PARTY opcode of current PCP Profile. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created pcpprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdatePcpprofile -name <string>
        An example how to update pcpprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdatePcpprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpprofile/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Mapping,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Peer,

        [ValidateRange(1, 2147483647)]
        [double]$Minmaplife,

        [ValidateRange(1, 2147483647)]
        [double]$Maxmaplife,

        [ValidateRange(0, 65535)]
        [double]$Announcemulticount,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Thirdparty,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdatePcpprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('mapping') ) { $payload.Add('mapping', $mapping) }
            if ( $PSBoundParameters.ContainsKey('peer') ) { $payload.Add('peer', $peer) }
            if ( $PSBoundParameters.ContainsKey('minmaplife') ) { $payload.Add('minmaplife', $minmaplife) }
            if ( $PSBoundParameters.ContainsKey('maxmaplife') ) { $payload.Add('maxmaplife', $maxmaplife) }
            if ( $PSBoundParameters.ContainsKey('announcemulticount') ) { $payload.Add('announcemulticount', $announcemulticount) }
            if ( $PSBoundParameters.ContainsKey('thirdparty') ) { $payload.Add('thirdparty', $thirdparty) }
            if ( $PSCmdlet.ShouldProcess("pcpprofile", "Update Pcp configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type pcpprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetPcpprofile -Filter $payload)
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
        Unset Pcp configuration Object.
    .DESCRIPTION
        Configuration for PCP Profile resource.
    .PARAMETER Name 
        Name for the PCP Profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpProfile" or my pcpProfile). 
    .PARAMETER Mapping 
        This argument is for enabling/disabling the MAP opcode of current PCP Profile. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Peer 
        This argument is for enabling/disabling the PEER opcode of current PCP Profile. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Minmaplife 
        Integer value that identify the minimum mapping lifetime (in seconds) for a pcp profile. default(120s). 
    .PARAMETER Maxmaplife 
        Integer value that identify the maximum mapping lifetime (in seconds) for a pcp profile. default(86400s = 24Hours). 
    .PARAMETER Announcemulticount 
        Integer value that identify the number announce message to be send. 
    .PARAMETER Thirdparty 
        This argument is for enabling/disabling the THIRD PARTY opcode of current PCP Profile. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetPcpprofile -name <string>
        An example how to unset pcpprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetPcpprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpprofile
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

        [string]$Name,

        [Boolean]$mapping,

        [Boolean]$peer,

        [Boolean]$minmaplife,

        [Boolean]$maxmaplife,

        [Boolean]$announcemulticount,

        [Boolean]$thirdparty 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetPcpprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('mapping') ) { $payload.Add('mapping', $mapping) }
            if ( $PSBoundParameters.ContainsKey('peer') ) { $payload.Add('peer', $peer) }
            if ( $PSBoundParameters.ContainsKey('minmaplife') ) { $payload.Add('minmaplife', $minmaplife) }
            if ( $PSBoundParameters.ContainsKey('maxmaplife') ) { $payload.Add('maxmaplife', $maxmaplife) }
            if ( $PSBoundParameters.ContainsKey('announcemulticount') ) { $payload.Add('announcemulticount', $announcemulticount) }
            if ( $PSBoundParameters.ContainsKey('thirdparty') ) { $payload.Add('thirdparty', $thirdparty) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Pcp configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type pcpprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get Pcp configuration object(s).
    .DESCRIPTION
        Configuration for PCP Profile resource.
    .PARAMETER Name 
        Name for the PCP Profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpProfile" or my pcpProfile). 
    .PARAMETER GetAll 
        Retrieve all pcpprofile object(s).
    .PARAMETER Count
        If specified, the count of the pcpprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPcpprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPcpprofile -GetAll 
        Get all pcpprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPcpprofile -Count 
        Get the number of pcpprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPcpprofile -name <string>
        Get pcpprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPcpprofile -Filter @{ 'name'='<value>' }
        Get pcpprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPcpprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpprofile/
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
        Write-Verbose "Invoke-ADCGetPcpprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all pcpprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for pcpprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving pcpprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving pcpprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving pcpprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Pcp configuration Object.
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the PCP server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpServer" or my pcpServer). 
    .PARAMETER Ipaddress 
        The IP address of the PCP server. 
    .PARAMETER Port 
        Port number for the PCP server. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Pcpprofile 
        pcp profile name. 
    .PARAMETER PassThru 
        Return details about the created pcpserver item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddPcpserver -name <string> -ipaddress <string>
        An example how to add pcpserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddPcpserver
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpserver/
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

        [Parameter(Mandatory)]
        [string]$Ipaddress,

        [ValidateRange(1, 65535)]
        [int]$Port = '5351',

        [string]$Pcpprofile,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddPcpserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                ipaddress      = $ipaddress
            }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('pcpprofile') ) { $payload.Add('pcpprofile', $pcpprofile) }
            if ( $PSCmdlet.ShouldProcess("pcpserver", "Add Pcp configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type pcpserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetPcpserver -Filter $payload)
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
        Delete Pcp configuration Object.
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the PCP server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpServer" or my pcpServer).
    .EXAMPLE
        PS C:\>Invoke-ADCDeletePcpserver -Name <string>
        An example how to delete pcpserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeletePcpserver
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpserver/
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
        Write-Verbose "Invoke-ADCDeletePcpserver: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Pcp configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type pcpserver -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update Pcp configuration Object.
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the PCP server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpServer" or my pcpServer). 
    .PARAMETER Port 
        Port number for the PCP server. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Pcpprofile 
        pcp profile name. 
    .PARAMETER PassThru 
        Return details about the created pcpserver item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdatePcpserver -name <string>
        An example how to update pcpserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdatePcpserver
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpserver/
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

        [ValidateRange(1, 65535)]
        [int]$Port,

        [string]$Pcpprofile,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdatePcpserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('pcpprofile') ) { $payload.Add('pcpprofile', $pcpprofile) }
            if ( $PSCmdlet.ShouldProcess("pcpserver", "Update Pcp configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type pcpserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetPcpserver -Filter $payload)
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
        Unset Pcp configuration Object.
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the PCP server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpServer" or my pcpServer). 
    .PARAMETER Port 
        Port number for the PCP server. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Pcpprofile 
        pcp profile name.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetPcpserver -name <string>
        An example how to unset pcpserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetPcpserver
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpserver
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

        [string]$Name,

        [Boolean]$port,

        [Boolean]$pcpprofile 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetPcpserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('pcpprofile') ) { $payload.Add('pcpprofile', $pcpprofile) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Pcp configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type pcpserver -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get Pcp configuration object(s).
    .DESCRIPTION
        Configuration for server resource.
    .PARAMETER Name 
        Name for the PCP server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my pcpServer" or my pcpServer). 
    .PARAMETER GetAll 
        Retrieve all pcpserver object(s).
    .PARAMETER Count
        If specified, the count of the pcpserver object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPcpserver
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPcpserver -GetAll 
        Get all pcpserver data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPcpserver -Count 
        Get the number of pcpserver objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPcpserver -name <string>
        Get pcpserver object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPcpserver -Filter @{ 'name'='<value>' }
        Get pcpserver data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPcpserver
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pcp/pcpserver/
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
        Write-Verbose "Invoke-ADCGetPcpserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all pcpserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for pcpserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving pcpserver objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpserver -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving pcpserver configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpserver -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving pcpserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pcpserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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


