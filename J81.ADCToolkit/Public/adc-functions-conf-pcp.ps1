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

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCA7QaFuRVcxJTQ1
# vuMhOByF26ZQHdIp+1BaAHTmSxUf+6CCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# LqPzW0sH3DJZ84enGm1YMYICQzCCAj8CAQEwgZAwfDELMAkGA1UEBhMCR0IxGzAZ
# BgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
# A1UEChMPU2VjdGlnbyBMaW1pdGVkMSQwIgYDVQQDExtTZWN0aWdvIFJTQSBDb2Rl
# IFNpZ25pbmcgQ0ECECwnTfNkELSL/bju5S9Y3lMwDQYJYIZIAWUDBAIBBQCggYQw
# GAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGC
# NwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQx
# IgQgC0rxZ5YF0tlO6v2BztZ/T4+mMBZxIQBdeougeoH9tscwDQYJKoZIhvcNAQEB
# BQAEggEAhTR21WrVWe6kN6IPqcqesfCLZLQpbjcxCm6faYM+W0nMCG2l53j05D8G
# D2ukKPkER30D2DUa9NfBMo9gvbQrPDQinnpEXQYkqAgTBxpvaPszDx+IyklH8HkZ
# Zk/ncu02EyWwCUDVbKhH0/EevQBEawpjgLrKQgMIzKX87k3504jbNHFuOhuOjC3L
# rHzkdN1TWBtourp7fnWzG9iQD6pvi0qxGrnpY7n9xw1EZYOQWSr+nWqYvSxEdNUc
# MKn3rGqtifBYtLLf9su4q6QK4XjvHLoIm/vfWo2rzw3P+Pd5RT2mUg2f1bqfsIVK
# obXXFWsrY38mfmAlflMBFsrdkdM9gA==
# SIG # End signature block
