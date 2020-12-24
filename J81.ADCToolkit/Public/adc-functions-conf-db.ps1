function Invoke-ADCAddDbdbprofile {
<#
    .SYNOPSIS
        Add Db configuration Object
    .DESCRIPTION
        Add Db configuration Object 
    .PARAMETER name 
        Name for the database profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the profile is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my profile" or 'my profile'). .  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER interpretquery 
        If ENABLED, inspect the query and update the connection information, if required. If DISABLED, forward the query to the server.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER stickiness 
        If the queries are related to each other, forward to the same backend server.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER kcdaccount 
        Name of the KCD account that is used for Windows authentication.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER conmultiplex 
        Use the same server-side connection for multiple client-side requests. Default is enabled.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER enablecachingconmuxoff 
        Enable caching when connection multiplexing is OFF.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created dbdbprofile item.
    .EXAMPLE
        Invoke-ADCAddDbdbprofile -name <string>
    .NOTES
        File Name : Invoke-ADCAddDbdbprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/db/dbdbprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$name ,

        [ValidateSet('YES', 'NO')]
        [string]$interpretquery = 'YES' ,

        [ValidateSet('YES', 'NO')]
        [string]$stickiness = 'NO' ,

        [ValidateLength(1, 127)]
        [string]$kcdaccount ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$conmultiplex = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$enablecachingconmuxoff = 'DISABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDbdbprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('interpretquery')) { $Payload.Add('interpretquery', $interpretquery) }
            if ($PSBoundParameters.ContainsKey('stickiness')) { $Payload.Add('stickiness', $stickiness) }
            if ($PSBoundParameters.ContainsKey('kcdaccount')) { $Payload.Add('kcdaccount', $kcdaccount) }
            if ($PSBoundParameters.ContainsKey('conmultiplex')) { $Payload.Add('conmultiplex', $conmultiplex) }
            if ($PSBoundParameters.ContainsKey('enablecachingconmuxoff')) { $Payload.Add('enablecachingconmuxoff', $enablecachingconmuxoff) }
 
            if ($PSCmdlet.ShouldProcess("dbdbprofile", "Add Db configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dbdbprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDbdbprofile -Filter $Payload)
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
        Delete Db configuration Object
    .DESCRIPTION
        Delete Db configuration Object
    .PARAMETER name 
       Name for the database profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the profile is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my profile" or 'my profile'). .  
       Minimum length = 1  
       Maximum length = 127 
    .EXAMPLE
        Invoke-ADCDeleteDbdbprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteDbdbprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/db/dbdbprofile/
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
        Write-Verbose "Invoke-ADCDeleteDbdbprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Db configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dbdbprofile -Resource $name -Arguments $Arguments
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
        Update Db configuration Object
    .DESCRIPTION
        Update Db configuration Object 
    .PARAMETER name 
        Name for the database profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the profile is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my profile" or 'my profile'). .  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER interpretquery 
        If ENABLED, inspect the query and update the connection information, if required. If DISABLED, forward the query to the server.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER stickiness 
        If the queries are related to each other, forward to the same backend server.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER kcdaccount 
        Name of the KCD account that is used for Windows authentication.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER conmultiplex 
        Use the same server-side connection for multiple client-side requests. Default is enabled.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER enablecachingconmuxoff 
        Enable caching when connection multiplexing is OFF.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created dbdbprofile item.
    .EXAMPLE
        Invoke-ADCUpdateDbdbprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateDbdbprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/db/dbdbprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$name ,

        [ValidateSet('YES', 'NO')]
        [string]$interpretquery ,

        [ValidateSet('YES', 'NO')]
        [string]$stickiness ,

        [ValidateLength(1, 127)]
        [string]$kcdaccount ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$conmultiplex ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$enablecachingconmuxoff ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDbdbprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('interpretquery')) { $Payload.Add('interpretquery', $interpretquery) }
            if ($PSBoundParameters.ContainsKey('stickiness')) { $Payload.Add('stickiness', $stickiness) }
            if ($PSBoundParameters.ContainsKey('kcdaccount')) { $Payload.Add('kcdaccount', $kcdaccount) }
            if ($PSBoundParameters.ContainsKey('conmultiplex')) { $Payload.Add('conmultiplex', $conmultiplex) }
            if ($PSBoundParameters.ContainsKey('enablecachingconmuxoff')) { $Payload.Add('enablecachingconmuxoff', $enablecachingconmuxoff) }
 
            if ($PSCmdlet.ShouldProcess("dbdbprofile", "Update Db configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type dbdbprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDbdbprofile -Filter $Payload)
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
        Unset Db configuration Object
    .DESCRIPTION
        Unset Db configuration Object 
   .PARAMETER name 
       Name for the database profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the profile is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my profile" or 'my profile'). . 
   .PARAMETER interpretquery 
       If ENABLED, inspect the query and update the connection information, if required. If DISABLED, forward the query to the server.  
       Possible values = YES, NO 
   .PARAMETER stickiness 
       If the queries are related to each other, forward to the same backend server.  
       Possible values = YES, NO 
   .PARAMETER kcdaccount 
       Name of the KCD account that is used for Windows authentication. 
   .PARAMETER conmultiplex 
       Use the same server-side connection for multiple client-side requests. Default is enabled.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER enablecachingconmuxoff 
       Enable caching when connection multiplexing is OFF.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetDbdbprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetDbdbprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/db/dbdbprofile
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$name ,

        [Boolean]$interpretquery ,

        [Boolean]$stickiness ,

        [Boolean]$kcdaccount ,

        [Boolean]$conmultiplex ,

        [Boolean]$enablecachingconmuxoff 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDbdbprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('interpretquery')) { $Payload.Add('interpretquery', $interpretquery) }
            if ($PSBoundParameters.ContainsKey('stickiness')) { $Payload.Add('stickiness', $stickiness) }
            if ($PSBoundParameters.ContainsKey('kcdaccount')) { $Payload.Add('kcdaccount', $kcdaccount) }
            if ($PSBoundParameters.ContainsKey('conmultiplex')) { $Payload.Add('conmultiplex', $conmultiplex) }
            if ($PSBoundParameters.ContainsKey('enablecachingconmuxoff')) { $Payload.Add('enablecachingconmuxoff', $enablecachingconmuxoff) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Db configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dbdbprofile -Action unset -Payload $Payload -GetWarning
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
        Get Db configuration object(s)
    .DESCRIPTION
        Get Db configuration object(s)
    .PARAMETER name 
       Name for the database profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the profile is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my profile" or 'my profile'). . 
    .PARAMETER GetAll 
        Retreive all dbdbprofile object(s)
    .PARAMETER Count
        If specified, the count of the dbdbprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDbdbprofile
    .EXAMPLE 
        Invoke-ADCGetDbdbprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDbdbprofile -Count
    .EXAMPLE
        Invoke-ADCGetDbdbprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetDbdbprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDbdbprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/db/dbdbprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-ADCGetDbdbprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dbdbprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbdbprofile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dbdbprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbdbprofile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dbdbprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbdbprofile -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dbdbprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbdbprofile -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dbdbprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbdbprofile -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Db configuration Object
    .DESCRIPTION
        Add Db configuration Object 
    .PARAMETER username 
        Name of the database user. Must be the same as the user name specified in the database.  
        Minimum length = 1 
    .PARAMETER password 
        Password for logging on to the database. Must be the same as the password specified in the database.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created dbuser item.
    .EXAMPLE
        Invoke-ADCAddDbuser -username <string>
    .NOTES
        File Name : Invoke-ADCAddDbuser
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/db/dbuser/
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
        [string]$username ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDbuser: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
 
            if ($PSCmdlet.ShouldProcess("dbuser", "Add Db configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dbuser -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDbuser -Filter $Payload)
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
        Delete Db configuration Object
    .DESCRIPTION
        Delete Db configuration Object
    .PARAMETER username 
       Name of the database user. Must be the same as the user name specified in the database.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteDbuser -username <string>
    .NOTES
        File Name : Invoke-ADCDeleteDbuser
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/db/dbuser/
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
        [string]$username 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDbuser: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$username", "Delete Db configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dbuser -Resource $username -Arguments $Arguments
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
        Update Db configuration Object
    .DESCRIPTION
        Update Db configuration Object 
    .PARAMETER username 
        Name of the database user. Must be the same as the user name specified in the database.  
        Minimum length = 1 
    .PARAMETER password 
        Password for logging on to the database. Must be the same as the password specified in the database.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created dbuser item.
    .EXAMPLE
        Invoke-ADCUpdateDbuser -username <string> -password <string>
    .NOTES
        File Name : Invoke-ADCUpdateDbuser
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/db/dbuser/
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
        [string]$username ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDbuser: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
                password = $password
            }

 
            if ($PSCmdlet.ShouldProcess("dbuser", "Update Db configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type dbuser -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDbuser -Filter $Payload)
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
        Get Db configuration object(s)
    .DESCRIPTION
        Get Db configuration object(s)
    .PARAMETER username 
       Name of the database user. Must be the same as the user name specified in the database. 
    .PARAMETER GetAll 
        Retreive all dbuser object(s)
    .PARAMETER Count
        If specified, the count of the dbuser object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDbuser
    .EXAMPLE 
        Invoke-ADCGetDbuser -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDbuser -Count
    .EXAMPLE
        Invoke-ADCGetDbuser -name <string>
    .EXAMPLE
        Invoke-ADCGetDbuser -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDbuser
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/db/dbuser/
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
        [string]$username,

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
        Write-Verbose "Invoke-ADCGetDbuser: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dbuser objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbuser -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dbuser objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbuser -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dbuser objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbuser -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dbuser configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbuser -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dbuser configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dbuser -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


