function Invoke-ADCAddDbdbprofile {
    <#
    .SYNOPSIS
        Add Db configuration Object.
    .DESCRIPTION
        Configuration for DB profile resource.
    .PARAMETER Name 
        Name for the database profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the profile is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my profile" or 'my profile'). . 
    .PARAMETER Interpretquery 
        If ENABLED, inspect the query and update the connection information, if required. If DISABLED, forward the query to the server. 
        Possible values = YES, NO 
    .PARAMETER Stickiness 
        If the queries are related to each other, forward to the same backend server. 
        Possible values = YES, NO 
    .PARAMETER Kcdaccount 
        Name of the KCD account that is used for Windows authentication. 
    .PARAMETER Conmultiplex 
        Use the same server-side connection for multiple client-side requests. Default is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Enablecachingconmuxoff 
        Enable caching when connection multiplexing is OFF. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created dbdbprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDbdbprofile -name <string>
        An example how to add dbdbprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDbdbprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/db/dbdbprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [ValidateLength(1, 127)]
        [string]$Name,

        [ValidateSet('YES', 'NO')]
        [string]$Interpretquery = 'YES',

        [ValidateSet('YES', 'NO')]
        [string]$Stickiness = 'NO',

        [ValidateLength(1, 127)]
        [string]$Kcdaccount,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Conmultiplex = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Enablecachingconmuxoff = 'DISABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDbdbprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('interpretquery') ) { $payload.Add('interpretquery', $interpretquery) }
            if ( $PSBoundParameters.ContainsKey('stickiness') ) { $payload.Add('stickiness', $stickiness) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('conmultiplex') ) { $payload.Add('conmultiplex', $conmultiplex) }
            if ( $PSBoundParameters.ContainsKey('enablecachingconmuxoff') ) { $payload.Add('enablecachingconmuxoff', $enablecachingconmuxoff) }
            if ( $PSCmdlet.ShouldProcess("dbdbprofile", "Add Db configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dbdbprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDbdbprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddDbdbprofile: Finished"
    }
}

function Invoke-ADCDeleteDbdbprofile {
    <#
    .SYNOPSIS
        Delete Db configuration Object.
    .DESCRIPTION
        Configuration for DB profile resource.
    .PARAMETER Name 
        Name for the database profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the profile is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my profile" or 'my profile'). .
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDbdbprofile -Name <string>
        An example how to delete dbdbprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDbdbprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/db/dbdbprofile/
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
        Write-Verbose "Invoke-ADCDeleteDbdbprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Db configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dbdbprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteDbdbprofile: Finished"
    }
}

function Invoke-ADCUpdateDbdbprofile {
    <#
    .SYNOPSIS
        Update Db configuration Object.
    .DESCRIPTION
        Configuration for DB profile resource.
    .PARAMETER Name 
        Name for the database profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the profile is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my profile" or 'my profile'). . 
    .PARAMETER Interpretquery 
        If ENABLED, inspect the query and update the connection information, if required. If DISABLED, forward the query to the server. 
        Possible values = YES, NO 
    .PARAMETER Stickiness 
        If the queries are related to each other, forward to the same backend server. 
        Possible values = YES, NO 
    .PARAMETER Kcdaccount 
        Name of the KCD account that is used for Windows authentication. 
    .PARAMETER Conmultiplex 
        Use the same server-side connection for multiple client-side requests. Default is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Enablecachingconmuxoff 
        Enable caching when connection multiplexing is OFF. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created dbdbprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateDbdbprofile -name <string>
        An example how to update dbdbprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateDbdbprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/db/dbdbprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [ValidateLength(1, 127)]
        [string]$Name,

        [ValidateSet('YES', 'NO')]
        [string]$Interpretquery,

        [ValidateSet('YES', 'NO')]
        [string]$Stickiness,

        [ValidateLength(1, 127)]
        [string]$Kcdaccount,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Conmultiplex,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Enablecachingconmuxoff,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDbdbprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('interpretquery') ) { $payload.Add('interpretquery', $interpretquery) }
            if ( $PSBoundParameters.ContainsKey('stickiness') ) { $payload.Add('stickiness', $stickiness) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('conmultiplex') ) { $payload.Add('conmultiplex', $conmultiplex) }
            if ( $PSBoundParameters.ContainsKey('enablecachingconmuxoff') ) { $payload.Add('enablecachingconmuxoff', $enablecachingconmuxoff) }
            if ( $PSCmdlet.ShouldProcess("dbdbprofile", "Update Db configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dbdbprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDbdbprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateDbdbprofile: Finished"
    }
}

function Invoke-ADCUnsetDbdbprofile {
    <#
    .SYNOPSIS
        Unset Db configuration Object.
    .DESCRIPTION
        Configuration for DB profile resource.
    .PARAMETER Name 
        Name for the database profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the profile is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my profile" or 'my profile'). . 
    .PARAMETER Interpretquery 
        If ENABLED, inspect the query and update the connection information, if required. If DISABLED, forward the query to the server. 
        Possible values = YES, NO 
    .PARAMETER Stickiness 
        If the queries are related to each other, forward to the same backend server. 
        Possible values = YES, NO 
    .PARAMETER Kcdaccount 
        Name of the KCD account that is used for Windows authentication. 
    .PARAMETER Conmultiplex 
        Use the same server-side connection for multiple client-side requests. Default is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Enablecachingconmuxoff 
        Enable caching when connection multiplexing is OFF. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetDbdbprofile -name <string>
        An example how to unset dbdbprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetDbdbprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/db/dbdbprofile
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

        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [ValidateLength(1, 127)]
        [string]$Name,

        [Boolean]$interpretquery,

        [Boolean]$stickiness,

        [Boolean]$kcdaccount,

        [Boolean]$conmultiplex,

        [Boolean]$enablecachingconmuxoff 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDbdbprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('interpretquery') ) { $payload.Add('interpretquery', $interpretquery) }
            if ( $PSBoundParameters.ContainsKey('stickiness') ) { $payload.Add('stickiness', $stickiness) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('conmultiplex') ) { $payload.Add('conmultiplex', $conmultiplex) }
            if ( $PSBoundParameters.ContainsKey('enablecachingconmuxoff') ) { $payload.Add('enablecachingconmuxoff', $enablecachingconmuxoff) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Db configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dbdbprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetDbdbprofile: Finished"
    }
}

function Invoke-ADCGetDbdbprofile {
    <#
    .SYNOPSIS
        Get Db configuration object(s).
    .DESCRIPTION
        Configuration for DB profile resource.
    .PARAMETER Name 
        Name for the database profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the profile is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my profile" or 'my profile'). . 
    .PARAMETER GetAll 
        Retrieve all dbdbprofile object(s).
    .PARAMETER Count
        If specified, the count of the dbdbprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDbdbprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDbdbprofile -GetAll 
        Get all dbdbprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDbdbprofile -Count 
        Get the number of dbdbprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDbdbprofile -name <string>
        Get dbdbprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDbdbprofile -Filter @{ 'name'='<value>' }
        Get dbdbprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDbdbprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/db/dbdbprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-ADCGetDbdbprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dbdbprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbdbprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dbdbprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbdbprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dbdbprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbdbprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dbdbprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbdbprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dbdbprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbdbprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDbdbprofile: Ended"
    }
}

function Invoke-ADCAddDbuser {
    <#
    .SYNOPSIS
        Add Db configuration Object.
    .DESCRIPTION
        Configuration for DB user resource.
    .PARAMETER Username 
        Name of the database user. Must be the same as the user name specified in the database. 
    .PARAMETER Password 
        Password for logging on to the database. Must be the same as the password specified in the database. 
    .PARAMETER PassThru 
        Return details about the created dbuser item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDbuser -username <string>
        An example how to add dbuser configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDbuser
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/db/dbuser/
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
        [string]$Username,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDbuser: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('password') ) { $payload.Add('password', $password) }
            if ( $PSCmdlet.ShouldProcess("dbuser", "Add Db configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dbuser -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDbuser -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddDbuser: Finished"
    }
}

function Invoke-ADCDeleteDbuser {
    <#
    .SYNOPSIS
        Delete Db configuration Object.
    .DESCRIPTION
        Configuration for DB user resource.
    .PARAMETER Username 
        Name of the database user. Must be the same as the user name specified in the database.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDbuser -Username <string>
        An example how to delete dbuser configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDbuser
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/db/dbuser/
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
        [string]$Username 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDbuser: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$username", "Delete Db configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dbuser -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteDbuser: Finished"
    }
}

function Invoke-ADCUpdateDbuser {
    <#
    .SYNOPSIS
        Update Db configuration Object.
    .DESCRIPTION
        Configuration for DB user resource.
    .PARAMETER Username 
        Name of the database user. Must be the same as the user name specified in the database. 
    .PARAMETER Password 
        Password for logging on to the database. Must be the same as the password specified in the database. 
    .PARAMETER PassThru 
        Return details about the created dbuser item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateDbuser -username <string> -password <string>
        An example how to update dbuser configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateDbuser
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/db/dbuser/
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
        [string]$Username,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDbuser: Starting"
    }
    process {
        try {
            $payload = @{ username = $username
                password           = $password
            }

            if ( $PSCmdlet.ShouldProcess("dbuser", "Update Db configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dbuser -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDbuser -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateDbuser: Finished"
    }
}

function Invoke-ADCGetDbuser {
    <#
    .SYNOPSIS
        Get Db configuration object(s).
    .DESCRIPTION
        Configuration for DB user resource.
    .PARAMETER Username 
        Name of the database user. Must be the same as the user name specified in the database. 
    .PARAMETER GetAll 
        Retrieve all dbuser object(s).
    .PARAMETER Count
        If specified, the count of the dbuser object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDbuser
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDbuser -GetAll 
        Get all dbuser data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDbuser -Count 
        Get the number of dbuser objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDbuser -name <string>
        Get dbuser object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDbuser -Filter @{ 'name'='<value>' }
        Get dbuser data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDbuser
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/db/dbuser/
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
        [string]$Username,

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
        Write-Verbose "Invoke-ADCGetDbuser: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dbuser objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbuser -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dbuser objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbuser -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dbuser objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbuser -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dbuser configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbuser -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dbuser configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbuser -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDbuser: Ended"
    }
}


