function Invoke-ADCAddLbgroup {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for LB group resource.
    .PARAMETER Name 
        Name of the load balancing virtual server group. 
    .PARAMETER Persistencetype 
        Type of persistence for the group. Available settings function as follows: 
        * SOURCEIP - Create persistence sessions based on the client IP. 
        * COOKIEINSERT - Create persistence sessions based on a cookie in client requests. The cookie is inserted by a Set-Cookie directive from the server, in its first response to a client. 
        * RULE - Create persistence sessions based on a user defined rule. 
        * NONE - Disable persistence for the group. 
        Possible values = SOURCEIP, COOKIEINSERT, RULE, NONE 
    .PARAMETER Persistencebackup 
        Type of backup persistence for the group. 
        Possible values = SOURCEIP, NONE 
    .PARAMETER Backuppersistencetimeout 
        Time period, in minutes, for which backup persistence is in effect. 
    .PARAMETER Persistmask 
        Persistence mask to apply to source IPv4 addresses when creating source IP based persistence sessions. 
    .PARAMETER Cookiename 
        Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
    .PARAMETER V6persistmasklen 
        Persistence mask to apply to source IPv6 addresses when creating source IP based persistence sessions. 
    .PARAMETER Cookiedomain 
        Domain attribute for the HTTP cookie. 
    .PARAMETER Timeout 
        Time period for which a persistence session is in effect. 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Usevserverpersistency 
        Use this parameter to enable vserver level persistence on group members. This allows member vservers to have their own persistence, but need to be compatible with other members persistence rules. When this setting is enabled persistence sessions created by any of the members can be shared by other member vservers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lbgroup item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbgroup -name <string>
        An example how to add lbgroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbgroup
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup/
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

        [ValidateSet('SOURCEIP', 'COOKIEINSERT', 'RULE', 'NONE')]
        [string]$Persistencetype,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$Persistencebackup,

        [ValidateRange(2, 1440)]
        [double]$Backuppersistencetimeout = '2',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Persistmask,

        [string]$Cookiename,

        [ValidateRange(1, 128)]
        [double]$V6persistmasklen = '128',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cookiedomain,

        [ValidateRange(0, 1440)]
        [double]$Timeout = '2',

        [string]$Rule = '"None"',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Usevserverpersistency = 'DISABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbgroup: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('persistencetype') ) { $payload.Add('persistencetype', $persistencetype) }
            if ( $PSBoundParameters.ContainsKey('persistencebackup') ) { $payload.Add('persistencebackup', $persistencebackup) }
            if ( $PSBoundParameters.ContainsKey('backuppersistencetimeout') ) { $payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('persistmask') ) { $payload.Add('persistmask', $persistmask) }
            if ( $PSBoundParameters.ContainsKey('cookiename') ) { $payload.Add('cookiename', $cookiename) }
            if ( $PSBoundParameters.ContainsKey('v6persistmasklen') ) { $payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ( $PSBoundParameters.ContainsKey('cookiedomain') ) { $payload.Add('cookiedomain', $cookiedomain) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('usevserverpersistency') ) { $payload.Add('usevserverpersistency', $usevserverpersistency) }
            if ( $PSCmdlet.ShouldProcess("lbgroup", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lbgroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbgroup -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbgroup: Finished"
    }
}

function Invoke-ADCUpdateLbgroup {
    <#
    .SYNOPSIS
        Update Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for LB group resource.
    .PARAMETER Name 
        Name of the load balancing virtual server group. 
    .PARAMETER Persistencetype 
        Type of persistence for the group. Available settings function as follows: 
        * SOURCEIP - Create persistence sessions based on the client IP. 
        * COOKIEINSERT - Create persistence sessions based on a cookie in client requests. The cookie is inserted by a Set-Cookie directive from the server, in its first response to a client. 
        * RULE - Create persistence sessions based on a user defined rule. 
        * NONE - Disable persistence for the group. 
        Possible values = SOURCEIP, COOKIEINSERT, RULE, NONE 
    .PARAMETER Persistencebackup 
        Type of backup persistence for the group. 
        Possible values = SOURCEIP, NONE 
    .PARAMETER Backuppersistencetimeout 
        Time period, in minutes, for which backup persistence is in effect. 
    .PARAMETER Persistmask 
        Persistence mask to apply to source IPv4 addresses when creating source IP based persistence sessions. 
    .PARAMETER Cookiename 
        Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
    .PARAMETER V6persistmasklen 
        Persistence mask to apply to source IPv6 addresses when creating source IP based persistence sessions. 
    .PARAMETER Cookiedomain 
        Domain attribute for the HTTP cookie. 
    .PARAMETER Timeout 
        Time period for which a persistence session is in effect. 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Usevserverpersistency 
        Use this parameter to enable vserver level persistence on group members. This allows member vservers to have their own persistence, but need to be compatible with other members persistence rules. When this setting is enabled persistence sessions created by any of the members can be shared by other member vservers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Mastervserver 
        When USE_VSERVER_PERSISTENCE is enabled, one can use this setting to designate a member vserver as master which is responsible to create the persistence sessions. 
    .PARAMETER PassThru 
        Return details about the created lbgroup item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLbgroup -name <string>
        An example how to update lbgroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLbgroup
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup/
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

        [ValidateSet('SOURCEIP', 'COOKIEINSERT', 'RULE', 'NONE')]
        [string]$Persistencetype,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$Persistencebackup,

        [ValidateRange(2, 1440)]
        [double]$Backuppersistencetimeout,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Persistmask,

        [string]$Cookiename,

        [ValidateRange(1, 128)]
        [double]$V6persistmasklen,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cookiedomain,

        [ValidateRange(0, 1440)]
        [double]$Timeout,

        [string]$Rule,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Usevserverpersistency,

        [string]$Mastervserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLbgroup: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('persistencetype') ) { $payload.Add('persistencetype', $persistencetype) }
            if ( $PSBoundParameters.ContainsKey('persistencebackup') ) { $payload.Add('persistencebackup', $persistencebackup) }
            if ( $PSBoundParameters.ContainsKey('backuppersistencetimeout') ) { $payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('persistmask') ) { $payload.Add('persistmask', $persistmask) }
            if ( $PSBoundParameters.ContainsKey('cookiename') ) { $payload.Add('cookiename', $cookiename) }
            if ( $PSBoundParameters.ContainsKey('v6persistmasklen') ) { $payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ( $PSBoundParameters.ContainsKey('cookiedomain') ) { $payload.Add('cookiedomain', $cookiedomain) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('usevserverpersistency') ) { $payload.Add('usevserverpersistency', $usevserverpersistency) }
            if ( $PSBoundParameters.ContainsKey('mastervserver') ) { $payload.Add('mastervserver', $mastervserver) }
            if ( $PSCmdlet.ShouldProcess("lbgroup", "Update Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbgroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbgroup -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateLbgroup: Finished"
    }
}

function Invoke-ADCUnsetLbgroup {
    <#
    .SYNOPSIS
        Unset Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for LB group resource.
    .PARAMETER Name 
        Name of the load balancing virtual server group. 
    .PARAMETER Persistencetype 
        Type of persistence for the group. Available settings function as follows: 
        * SOURCEIP - Create persistence sessions based on the client IP. 
        * COOKIEINSERT - Create persistence sessions based on a cookie in client requests. The cookie is inserted by a Set-Cookie directive from the server, in its first response to a client. 
        * RULE - Create persistence sessions based on a user defined rule. 
        * NONE - Disable persistence for the group. 
        Possible values = SOURCEIP, COOKIEINSERT, RULE, NONE 
    .PARAMETER Persistencebackup 
        Type of backup persistence for the group. 
        Possible values = SOURCEIP, NONE 
    .PARAMETER Backuppersistencetimeout 
        Time period, in minutes, for which backup persistence is in effect. 
    .PARAMETER Persistmask 
        Persistence mask to apply to source IPv4 addresses when creating source IP based persistence sessions. 
    .PARAMETER Cookiename 
        Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
    .PARAMETER V6persistmasklen 
        Persistence mask to apply to source IPv6 addresses when creating source IP based persistence sessions. 
    .PARAMETER Cookiedomain 
        Domain attribute for the HTTP cookie. 
    .PARAMETER Timeout 
        Time period for which a persistence session is in effect. 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Usevserverpersistency 
        Use this parameter to enable vserver level persistence on group members. This allows member vservers to have their own persistence, but need to be compatible with other members persistence rules. When this setting is enabled persistence sessions created by any of the members can be shared by other member vservers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Mastervserver 
        When USE_VSERVER_PERSISTENCE is enabled, one can use this setting to designate a member vserver as master which is responsible to create the persistence sessions.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLbgroup -name <string>
        An example how to unset lbgroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLbgroup
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup
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
        [string]$Name,

        [Boolean]$persistencetype,

        [Boolean]$persistencebackup,

        [Boolean]$backuppersistencetimeout,

        [Boolean]$persistmask,

        [Boolean]$cookiename,

        [Boolean]$v6persistmasklen,

        [Boolean]$cookiedomain,

        [Boolean]$timeout,

        [Boolean]$rule,

        [Boolean]$usevserverpersistency,

        [Boolean]$mastervserver 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLbgroup: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('persistencetype') ) { $payload.Add('persistencetype', $persistencetype) }
            if ( $PSBoundParameters.ContainsKey('persistencebackup') ) { $payload.Add('persistencebackup', $persistencebackup) }
            if ( $PSBoundParameters.ContainsKey('backuppersistencetimeout') ) { $payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('persistmask') ) { $payload.Add('persistmask', $persistmask) }
            if ( $PSBoundParameters.ContainsKey('cookiename') ) { $payload.Add('cookiename', $cookiename) }
            if ( $PSBoundParameters.ContainsKey('v6persistmasklen') ) { $payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ( $PSBoundParameters.ContainsKey('cookiedomain') ) { $payload.Add('cookiedomain', $cookiedomain) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('usevserverpersistency') ) { $payload.Add('usevserverpersistency', $usevserverpersistency) }
            if ( $PSBoundParameters.ContainsKey('mastervserver') ) { $payload.Add('mastervserver', $mastervserver) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbgroup -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLbgroup: Finished"
    }
}

function Invoke-ADCDeleteLbgroup {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for LB group resource.
    .PARAMETER Name 
        Name of the load balancing virtual server group.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbgroup -Name <string>
        An example how to delete lbgroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbgroup
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup/
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
        Write-Verbose "Invoke-ADCDeleteLbgroup: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbgroup -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbgroup: Finished"
    }
}

function Invoke-ADCRenameLbgroup {
    <#
    .SYNOPSIS
        Rename Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for LB group resource.
    .PARAMETER Name 
        Name of the load balancing virtual server group. 
    .PARAMETER Newname 
        New name for the load balancing virtual server group. 
    .PARAMETER PassThru 
        Return details about the created lbgroup item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameLbgroup -name <string> -newname <string>
        An example how to rename lbgroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameLbgroup
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup/
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

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameLbgroup: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("lbgroup", "Rename Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lbgroup -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbgroup -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameLbgroup: Finished"
    }
}

function Invoke-ADCGetLbgroup {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for LB group resource.
    .PARAMETER Name 
        Name of the load balancing virtual server group. 
    .PARAMETER GetAll 
        Retrieve all lbgroup object(s).
    .PARAMETER Count
        If specified, the count of the lbgroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbgroup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbgroup -GetAll 
        Get all lbgroup data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbgroup -Count 
        Get the number of lbgroup objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbgroup -name <string>
        Get lbgroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbgroup -Filter @{ 'name'='<value>' }
        Get lbgroup data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbgroup
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup/
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
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetLbgroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lbgroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbgroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbgroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbgroup configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbgroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbgroup: Ended"
    }
}

function Invoke-ADCGetLbgroupbinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to lbgroup.
    .PARAMETER Name 
        Name of the load balancing virtual server group. 
    .PARAMETER GetAll 
        Retrieve all lbgroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbgroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbgroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbgroupbinding -GetAll 
        Get all lbgroup_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbgroupbinding -name <string>
        Get lbgroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbgroupbinding -Filter @{ 'name'='<value>' }
        Get lbgroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbgroupbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup_binding/
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
        Write-Verbose "Invoke-ADCGetLbgroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbgroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbgroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbgroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbgroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbgroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbgroupbinding: Ended"
    }
}

function Invoke-ADCAddLbgrouplbvserverbinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to lbgroup.
    .PARAMETER Name 
        Name for the load balancing virtual server group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my lbgroup" or 'my lbgroup'). 
    .PARAMETER Vservername 
        Virtual server name. 
    .PARAMETER PassThru 
        Return details about the created lbgroup_lbvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbgrouplbvserverbinding -name <string> -vservername <string>
        An example how to add lbgroup_lbvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbgrouplbvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup_lbvserver_binding/
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
        [string]$Vservername,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbgrouplbvserverbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                vservername    = $vservername
            }

            if ( $PSCmdlet.ShouldProcess("lbgroup_lbvserver_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbgroup_lbvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbgrouplbvserverbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbgrouplbvserverbinding: Finished"
    }
}

function Invoke-ADCDeleteLbgrouplbvserverbinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to lbgroup.
    .PARAMETER Name 
        Name for the load balancing virtual server group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my lbgroup" or 'my lbgroup'). 
    .PARAMETER Vservername 
        Virtual server name.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbgrouplbvserverbinding -Name <string>
        An example how to delete lbgroup_lbvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbgrouplbvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup_lbvserver_binding/
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

        [string]$Vservername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbgrouplbvserverbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Vservername') ) { $arguments.Add('vservername', $Vservername) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbgroup_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbgrouplbvserverbinding: Finished"
    }
}

function Invoke-ADCGetLbgrouplbvserverbinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to lbgroup.
    .PARAMETER Name 
        Name for the load balancing virtual server group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my lbgroup" or 'my lbgroup'). 
    .PARAMETER GetAll 
        Retrieve all lbgroup_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbgroup_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbgrouplbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbgrouplbvserverbinding -GetAll 
        Get all lbgroup_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbgrouplbvserverbinding -Count 
        Get the number of lbgroup_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbgrouplbvserverbinding -name <string>
        Get lbgroup_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbgrouplbvserverbinding -Filter @{ 'name'='<value>' }
        Get lbgroup_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbgrouplbvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup_lbvserver_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbgrouplbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbgroup_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbgroup_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbgroup_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbgroup_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbgroup_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbgrouplbvserverbinding: Ended"
    }
}

function Invoke-ADCAddLbmetrictable {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for metric table resource.
    .PARAMETER Metrictable 
        Name for the metric table. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my metrictable" or 'my metrictable'). 
    .PARAMETER PassThru 
        Return details about the created lbmetrictable item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbmetrictable -metrictable <string>
        An example how to add lbmetrictable configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbmetrictable
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmetrictable/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 31)]
        [string]$Metrictable,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbmetrictable: Starting"
    }
    process {
        try {
            $payload = @{ metrictable = $metrictable }

            if ( $PSCmdlet.ShouldProcess("lbmetrictable", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lbmetrictable -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbmetrictable -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbmetrictable: Finished"
    }
}

function Invoke-ADCDeleteLbmetrictable {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for metric table resource.
    .PARAMETER Metrictable 
        Name for the metric table. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my metrictable" or 'my metrictable').
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbmetrictable -Metrictable <string>
        An example how to delete lbmetrictable configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbmetrictable
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmetrictable/
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
        [string]$Metrictable 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbmetrictable: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$metrictable", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbmetrictable -NitroPath nitro/v1/config -Resource $metrictable -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbmetrictable: Finished"
    }
}

function Invoke-ADCUpdateLbmetrictable {
    <#
    .SYNOPSIS
        Update Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for metric table resource.
    .PARAMETER Metrictable 
        Name for the metric table. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my metrictable" or 'my metrictable'). 
    .PARAMETER Metric 
        Name of the metric for which to change the SNMP OID. 
    .PARAMETER Snmpoid 
        New SNMP OID of the metric. 
    .PARAMETER PassThru 
        Return details about the created lbmetrictable item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLbmetrictable -metrictable <string> -metric <string> -Snmpoid <string>
        An example how to update lbmetrictable configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLbmetrictable
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmetrictable/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 31)]
        [string]$Metrictable,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Metric,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Snmpoid,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLbmetrictable: Starting"
    }
    process {
        try {
            $payload = @{ metrictable = $metrictable
                metric                = $metric
                Snmpoid               = $Snmpoid
            }

            if ( $PSCmdlet.ShouldProcess("lbmetrictable", "Update Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbmetrictable -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbmetrictable -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateLbmetrictable: Finished"
    }
}

function Invoke-ADCGetLbmetrictable {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for metric table resource.
    .PARAMETER Metrictable 
        Name for the metric table. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my metrictable" or 'my metrictable'). 
    .PARAMETER GetAll 
        Retrieve all lbmetrictable object(s).
    .PARAMETER Count
        If specified, the count of the lbmetrictable object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmetrictable
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmetrictable -GetAll 
        Get all lbmetrictable data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmetrictable -Count 
        Get the number of lbmetrictable objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmetrictable -name <string>
        Get lbmetrictable object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmetrictable -Filter @{ 'name'='<value>' }
        Get lbmetrictable data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbmetrictable
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmetrictable/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 31)]
        [string]$Metrictable,

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
        Write-Verbose "Invoke-ADCGetLbmetrictable: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lbmetrictable objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmetrictable objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmetrictable objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmetrictable configuration for property 'metrictable'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable -NitroPath nitro/v1/config -Resource $metrictable -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmetrictable configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbmetrictable: Ended"
    }
}

function Invoke-ADCGetLbmetrictablebinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to lbmetrictable.
    .PARAMETER Metrictable 
        Name of the metric table. 
    .PARAMETER GetAll 
        Retrieve all lbmetrictable_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbmetrictable_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmetrictablebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmetrictablebinding -GetAll 
        Get all lbmetrictable_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmetrictablebinding -name <string>
        Get lbmetrictable_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmetrictablebinding -Filter @{ 'name'='<value>' }
        Get lbmetrictable_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbmetrictablebinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmetrictable_binding/
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
        [ValidateLength(1, 31)]
        [string]$Metrictable,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbmetrictablebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbmetrictable_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmetrictable_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmetrictable_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmetrictable_binding configuration for property 'metrictable'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_binding -NitroPath nitro/v1/config -Resource $metrictable -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmetrictable_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbmetrictablebinding: Ended"
    }
}

function Invoke-ADCAddLbmetrictablemetricbinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the metric that can be bound to lbmetrictable.
    .PARAMETER Metrictable 
        Name of the metric table. 
    .PARAMETER Metric 
        Name of the metric for which to change the SNMP OID. 
    .PARAMETER Snmpoid 
        New SNMP OID of the metric. 
    .PARAMETER PassThru 
        Return details about the created lbmetrictable_metric_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbmetrictablemetricbinding -metrictable <string> -metric <string> -Snmpoid <string>
        An example how to add lbmetrictable_metric_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbmetrictablemetricbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmetrictable_metric_binding/
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
        [ValidateLength(1, 31)]
        [string]$Metrictable,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Metric,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Snmpoid,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbmetrictablemetricbinding: Starting"
    }
    process {
        try {
            $payload = @{ metrictable = $metrictable
                metric                = $metric
                Snmpoid               = $Snmpoid
            }

            if ( $PSCmdlet.ShouldProcess("lbmetrictable_metric_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbmetrictable_metric_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbmetrictablemetricbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbmetrictablemetricbinding: Finished"
    }
}

function Invoke-ADCDeleteLbmetrictablemetricbinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the metric that can be bound to lbmetrictable.
    .PARAMETER Metrictable 
        Name of the metric table. 
    .PARAMETER Metric 
        Name of the metric for which to change the SNMP OID.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbmetrictablemetricbinding -Metrictable <string>
        An example how to delete lbmetrictable_metric_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbmetrictablemetricbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmetrictable_metric_binding/
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
        [string]$Metrictable,

        [string]$Metric 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbmetrictablemetricbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Metric') ) { $arguments.Add('metric', $Metric) }
            if ( $PSCmdlet.ShouldProcess("$metrictable", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbmetrictable_metric_binding -NitroPath nitro/v1/config -Resource $metrictable -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbmetrictablemetricbinding: Finished"
    }
}

function Invoke-ADCGetLbmetrictablemetricbinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the metric that can be bound to lbmetrictable.
    .PARAMETER Metrictable 
        Name of the metric table. 
    .PARAMETER GetAll 
        Retrieve all lbmetrictable_metric_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbmetrictable_metric_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmetrictablemetricbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmetrictablemetricbinding -GetAll 
        Get all lbmetrictable_metric_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmetrictablemetricbinding -Count 
        Get the number of lbmetrictable_metric_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmetrictablemetricbinding -name <string>
        Get lbmetrictable_metric_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmetrictablemetricbinding -Filter @{ 'name'='<value>' }
        Get lbmetrictable_metric_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbmetrictablemetricbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmetrictable_metric_binding/
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
        [ValidateLength(1, 31)]
        [string]$Metrictable,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbmetrictablemetricbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbmetrictable_metric_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_metric_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmetrictable_metric_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_metric_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmetrictable_metric_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_metric_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmetrictable_metric_binding configuration for property 'metrictable'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_metric_binding -NitroPath nitro/v1/config -Resource $metrictable -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmetrictable_metric_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_metric_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbmetrictablemetricbinding: Ended"
    }
}

function Invoke-ADCGetLbmonbindings {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for monitro bindings resource.
    .PARAMETER Monitorname 
        The name of the monitor. 
    .PARAMETER GetAll 
        Retrieve all lbmonbindings object(s).
    .PARAMETER Count
        If specified, the count of the lbmonbindings object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonbindings
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmonbindings -GetAll 
        Get all lbmonbindings data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmonbindings -Count 
        Get the number of lbmonbindings objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonbindings -name <string>
        Get lbmonbindings object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonbindings -Filter @{ 'name'='<value>' }
        Get lbmonbindings data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbmonbindings
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonbindings/
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
        [string]$Monitorname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetLbmonbindings: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lbmonbindings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmonbindings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmonbindings objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmonbindings configuration for property 'monitorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings -NitroPath nitro/v1/config -Resource $monitorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmonbindings configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbmonbindings: Ended"
    }
}

function Invoke-ADCGetLbmonbindingsbinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to lbmonbindings.
    .PARAMETER Monitorname 
        The name of the monitor. 
    .PARAMETER GetAll 
        Retrieve all lbmonbindings_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbmonbindings_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonbindingsbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmonbindingsbinding -GetAll 
        Get all lbmonbindings_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonbindingsbinding -name <string>
        Get lbmonbindings_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonbindingsbinding -Filter @{ 'name'='<value>' }
        Get lbmonbindings_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbmonbindingsbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonbindings_binding/
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
        [string]$Monitorname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbmonbindingsbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbmonbindings_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmonbindings_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmonbindings_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmonbindings_binding configuration for property 'monitorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_binding -NitroPath nitro/v1/config -Resource $monitorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmonbindings_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbmonbindingsbinding: Ended"
    }
}

function Invoke-ADCGetLbmonbindingsgslbservicegroupbinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbservicegroup that can be bound to lbmonbindings.
    .PARAMETER Monitorname 
        The name of the monitor. 
    .PARAMETER GetAll 
        Retrieve all lbmonbindings_gslbservicegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbmonbindings_gslbservicegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonbindingsgslbservicegroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmonbindingsgslbservicegroupbinding -GetAll 
        Get all lbmonbindings_gslbservicegroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmonbindingsgslbservicegroupbinding -Count 
        Get the number of lbmonbindings_gslbservicegroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonbindingsgslbservicegroupbinding -name <string>
        Get lbmonbindings_gslbservicegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonbindingsgslbservicegroupbinding -Filter @{ 'name'='<value>' }
        Get lbmonbindings_gslbservicegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbmonbindingsgslbservicegroupbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonbindings_gslbservicegroup_binding/
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
        [string]$Monitorname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbmonbindingsgslbservicegroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbmonbindings_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmonbindings_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmonbindings_gslbservicegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_gslbservicegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmonbindings_gslbservicegroup_binding configuration for property 'monitorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_gslbservicegroup_binding -NitroPath nitro/v1/config -Resource $monitorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmonbindings_gslbservicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_gslbservicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbmonbindingsgslbservicegroupbinding: Ended"
    }
}

function Invoke-ADCGetLbmonbindingsservicegroupbinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the servicegroup that can be bound to lbmonbindings.
    .PARAMETER Monitorname 
        The name of the monitor. 
    .PARAMETER GetAll 
        Retrieve all lbmonbindings_servicegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbmonbindings_servicegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonbindingsservicegroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmonbindingsservicegroupbinding -GetAll 
        Get all lbmonbindings_servicegroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmonbindingsservicegroupbinding -Count 
        Get the number of lbmonbindings_servicegroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonbindingsservicegroupbinding -name <string>
        Get lbmonbindings_servicegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonbindingsservicegroupbinding -Filter @{ 'name'='<value>' }
        Get lbmonbindings_servicegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbmonbindingsservicegroupbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonbindings_servicegroup_binding/
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
        [string]$Monitorname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbmonbindingsservicegroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbmonbindings_servicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_servicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmonbindings_servicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_servicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmonbindings_servicegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_servicegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmonbindings_servicegroup_binding configuration for property 'monitorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_servicegroup_binding -NitroPath nitro/v1/config -Resource $monitorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmonbindings_servicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_servicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbmonbindingsservicegroupbinding: Ended"
    }
}

function Invoke-ADCGetLbmonbindingsservicebinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the service that can be bound to lbmonbindings.
    .PARAMETER Monitorname 
        The name of the monitor. 
    .PARAMETER GetAll 
        Retrieve all lbmonbindings_service_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbmonbindings_service_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonbindingsservicebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmonbindingsservicebinding -GetAll 
        Get all lbmonbindings_service_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmonbindingsservicebinding -Count 
        Get the number of lbmonbindings_service_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonbindingsservicebinding -name <string>
        Get lbmonbindings_service_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonbindingsservicebinding -Filter @{ 'name'='<value>' }
        Get lbmonbindings_service_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbmonbindingsservicebinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonbindings_service_binding/
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
        [string]$Monitorname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbmonbindingsservicebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbmonbindings_service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_service_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmonbindings_service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_service_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmonbindings_service_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_service_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmonbindings_service_binding configuration for property 'monitorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_service_binding -NitroPath nitro/v1/config -Resource $monitorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmonbindings_service_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_service_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbmonbindingsservicebinding: Ended"
    }
}

function Invoke-ADCAddLbmonitor {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for monitor resource.
    .PARAMETER Monitorname 
        Name for the monitor. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my monitor" or 'my monitor'). 
    .PARAMETER Type 
        Type of monitor that you want to create. 
        Possible values = PING, TCP, HTTP, TCP-ECV, HTTP-ECV, UDP-ECV, DNS, FTP, LDNS-PING, LDNS-TCP, LDNS-DNS, RADIUS, USER, HTTP-INLINE, SIP-UDP, SIP-TCP, LOAD, FTP-EXTENDED, SMTP, SNMP, NNTP, MYSQL, MYSQL-ECV, MSSQL-ECV, ORACLE-ECV, LDAP, POP3, CITRIX-XML-SERVICE, CITRIX-WEB-INTERFACE, DNS-TCP, RTSP, ARP, CITRIX-AG, CITRIX-AAC-LOGINPAGE, CITRIX-AAC-LAS, CITRIX-XD-DDC, ND6, CITRIX-WI-EXTENDED, DIAMETER, RADIUS_ACCOUNTING, STOREFRONT, APPC, SMPP, CITRIX-XNC-ECV, CITRIX-XDM, CITRIX-STA-SERVICE, CITRIX-STA-SERVICE-NHOP, MQTT, HTTP2 
    .PARAMETER Action 
        Action to perform when the response to an inline monitor (a monitor of type HTTP-INLINE) indicates that the service is down. A service monitored by an inline monitor is considered DOWN if the response code is not one of the codes that have been specified for the Response Code parameter. 
        Available settings function as follows: 
        * NONE - Do not take any action. However, the show service command and the show lb monitor command indicate the total number of responses that were checked and the number of consecutive error responses received after the last successful probe. 
        * LOG - Log the event in NSLOG or SYSLOG. 
        * DOWN - Mark the service as being down, and then do not direct any traffic to the service until the configured down time has expired. Persistent connections to the service are terminated as soon as the service is marked as DOWN. Also, log the event in NSLOG or SYSLOG. 
        Possible values = NONE, LOG, DOWN 
    .PARAMETER Respcode 
        Response codes for which to mark the service as UP. For any other response code, the action performed depends on the monitor type. HTTP monitors and RADIUS monitors mark the service as DOWN, while HTTP-INLINE monitors perform the action indicated by the Action parameter. 
    .PARAMETER Httprequest 
        HTTP request to send to the server (for example, "HEAD /file.html"). 
    .PARAMETER Rtsprequest 
        RTSP request to send to the server (for example, "OPTIONS *"). 
    .PARAMETER Customheaders 
        Custom header string to include in the monitoring probes. 
    .PARAMETER Maxforwards 
        Maximum number of hops that the SIP request used for monitoring can traverse to reach the server. Applicable only to monitors of type SIP-UDP. 
    .PARAMETER Sipmethod 
        SIP method to use for the query. Applicable only to monitors of type SIP-UDP. 
        Possible values = OPTIONS, INVITE, REGISTER 
    .PARAMETER Sipuri 
        SIP URI string to send to the service (for example, sip:sip.test). Applicable only to monitors of type SIP-UDP. 
    .PARAMETER Sipreguri 
        SIP user to be registered. Applicable only if the monitor is of type SIP-UDP and the SIP Method parameter is set to REGISTER. 
    .PARAMETER Send 
        String to send to the service. Applicable to TCP-ECV, HTTP-ECV, and UDP-ECV monitors. 
    .PARAMETER Recv 
        String expected from the server for the service to be marked as UP. Applicable to TCP-ECV, HTTP-ECV, and UDP-ECV monitors. 
    .PARAMETER Query 
        Domain name to resolve as part of monitoring the DNS service (for example, example.com). 
    .PARAMETER Querytype 
        Type of DNS record for which to send monitoring queries. Set to Address for querying A records, AAAA for querying AAAA records, and Zone for querying the SOA record. 
        Possible values = Address, Zone, AAAA 
    .PARAMETER Scriptname 
        Path and name of the script to execute. The script must be available on the Citrix ADC, in the /nsconfig/monitors/ directory. 
    .PARAMETER Scriptargs 
        String of arguments for the script. The string is copied verbatim into the request. 
    .PARAMETER Secureargs 
        List of arguments for the script which should be secure. 
    .PARAMETER Dispatcherip 
        IP address of the dispatcher to which to send the probe. 
    .PARAMETER Dispatcherport 
        Port number on which the dispatcher listens for the monitoring probe. 
    .PARAMETER Username 
        User name with which to probe the RADIUS, NNTP, FTP, FTP-EXTENDED, MYSQL, MSSQL, POP3, CITRIX-AG, CITRIX-XD-DDC, CITRIX-WI-EXTENDED, CITRIX-XNC or CITRIX-XDM server. 
    .PARAMETER Password 
        Password that is required for logging on to the RADIUS, NNTP, FTP, FTP-EXTENDED, MYSQL, MSSQL, POP3, CITRIX-AG, CITRIX-XD-DDC, CITRIX-WI-EXTENDED, CITRIX-XNC-ECV or CITRIX-XDM server. Used in conjunction with the user name specified for the User Name parameter. 
    .PARAMETER Secondarypassword 
        Secondary password that users might have to provide to log on to the Access Gateway server. Applicable to CITRIX-AG monitors. 
    .PARAMETER Logonpointname 
        Name of the logon point that is configured for the Citrix Access Gateway Advanced Access Control software. Required if you want to monitor the associated login page or Logon Agent. Applicable to CITRIX-AAC-LAS and CITRIX-AAC-LOGINPAGE monitors. 
    .PARAMETER Lasversion 
        Version number of the Citrix Advanced Access Control Logon Agent. Required by the CITRIX-AAC-LAS monitor. 
    .PARAMETER Radkey 
        Authentication key (shared secret text string) for RADIUS clients and servers to exchange. Applicable to monitors of type RADIUS and RADIUS_ACCOUNTING. 
    .PARAMETER Radnasid 
        NAS-Identifier to send in the Access-Request packet. Applicable to monitors of type RADIUS. 
    .PARAMETER Radnasip 
        Network Access Server (NAS) IP address to use as the source IP address when monitoring a RADIUS server. Applicable to monitors of type RADIUS and RADIUS_ACCOUNTING. 
    .PARAMETER Radaccounttype 
        Account Type to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING. 
    .PARAMETER Radframedip 
        Source ip with which the packet will go out . Applicable to monitors of type RADIUS_ACCOUNTING. 
    .PARAMETER Radapn 
        Called Station Id to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING. 
    .PARAMETER Radmsisdn 
        Calling Stations Id to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING. 
    .PARAMETER Radaccountsession 
        Account Session ID to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING. 
    .PARAMETER Lrtm 
        Calculate the least response times for bound services. If this parameter is not enabled, the appliance does not learn the response times of the bound services. Also used for LRTM load balancing. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Deviation 
        Time value added to the learned average response time in dynamic response time monitoring (DRTM). When a deviation is specified, the appliance learns the average response time of bound services and adds the deviation to the average. The final value is then continually adjusted to accommodate response time variations over time. Specified in milliseconds, seconds, or minutes. 
    .PARAMETER Units1 
        Unit of measurement for the Deviation parameter. Cannot be changed after the monitor is created. 
        Possible values = SEC, MSEC, MIN 
    .PARAMETER Interval 
        Time interval between two successive probes. Must be greater than the value of Response Time-out. 
    .PARAMETER Units3 
        monitor interval units. 
        Possible values = SEC, MSEC, MIN 
    .PARAMETER Resptimeout 
        Amount of time for which the appliance must wait before it marks a probe as FAILED. Must be less than the value specified for the Interval parameter. 
        Note: For UDP-ECV monitors for which a receive string is not configured, response timeout does not apply. For UDP-ECV monitors with no receive string, probe failure is indicated by an ICMP port unreachable error received from the service. 
    .PARAMETER Units4 
        monitor response timeout units. 
        Possible values = SEC, MSEC, MIN 
    .PARAMETER Resptimeoutthresh 
        Response time threshold, specified as a percentage of the Response Time-out parameter. If the response to a monitor probe has not arrived when the threshold is reached, the appliance generates an SNMP trap called monRespTimeoutAboveThresh. After the response time returns to a value below the threshold, the appliance generates a monRespTimeoutBelowThresh SNMP trap. For the traps to be generated, the "MONITOR-RTO-THRESHOLD" alarm must also be enabled. 
    .PARAMETER Retries 
        Maximum number of probes to send to establish the state of a service for which a monitoring probe failed. 
    .PARAMETER Failureretries 
        Number of retries that must fail, out of the number specified for the Retries parameter, for a service to be marked as DOWN. For example, if the Retries parameter is set to 10 and the Failure Retries parameter is set to 6, out of the ten probes sent, at least six probes must fail if the service is to be marked as DOWN. The default value of 0 means that all the retries must fail if the service is to be marked as DOWN. 
    .PARAMETER Alertretries 
        Number of consecutive probe failures after which the appliance generates an SNMP trap called monProbeFailed. 
    .PARAMETER Successretries 
        Number of consecutive successful probes required to transition a service's state from DOWN to UP. 
    .PARAMETER Downtime 
        Time duration for which to wait before probing a service that has been marked as DOWN. Expressed in milliseconds, seconds, or minutes. 
    .PARAMETER Units2 
        Unit of measurement for the Down Time parameter. Cannot be changed after the monitor is created. 
        Possible values = SEC, MSEC, MIN 
    .PARAMETER Destip 
        IP address of the service to which to send probes. If the parameter is set to 0, the IP address of the server to which the monitor is bound is considered the destination IP address. 
    .PARAMETER Destport 
        TCP or UDP port to which to send the probe. If the parameter is set to 0, the port number of the service to which the monitor is bound is considered the destination port. For a monitor of type USER, however, the destination port is the port number that is included in the HTTP request sent to the dispatcher. Does not apply to monitors of type PING. 
    .PARAMETER State 
        State of the monitor. The DISABLED setting disables not only the monitor being configured, but all monitors of the same type, until the parameter is set to ENABLED. If the monitor is bound to a service, the state of the monitor is not taken into account when the state of the service is determined. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Reverse 
        Mark a service as DOWN, instead of UP, when probe criteria are satisfied, and as UP instead of DOWN when probe criteria are not satisfied. 
        Possible values = YES, NO 
    .PARAMETER Transparent 
        The monitor is bound to a transparent device such as a firewall or router. The state of a transparent device depends on the responsiveness of the services behind it. If a transparent device is being monitored, a destination IP address must be specified. The probe is sent to the specified IP address by using the MAC address of the transparent device. 
        Possible values = YES, NO 
    .PARAMETER Iptunnel 
        Send the monitoring probe to the service through an IP tunnel. A destination IP address must be specified. 
        Possible values = YES, NO 
    .PARAMETER Tos 
        Probe the service by encoding the destination IP address in the IP TOS (6) bits. 
        Possible values = YES, NO 
    .PARAMETER Tosid 
        The TOS ID of the specified destination IP. Applicable only when the TOS parameter is set. 
    .PARAMETER Secure 
        Use a secure SSL connection when monitoring a service. Applicable only to TCP based monitors. The secure option cannot be used with a CITRIX-AG monitor, because a CITRIX-AG monitor uses a secure connection by default. 
        Possible values = YES, NO 
    .PARAMETER Validatecred 
        Validate the credentials of the Xen Desktop DDC server user. Applicable to monitors of type CITRIX-XD-DDC. 
        Possible values = YES, NO 
    .PARAMETER Domain 
        Domain in which the XenDesktop Desktop Delivery Controller (DDC) servers or Web Interface servers are present. Required by CITRIX-XD-DDC and CITRIX-WI-EXTENDED monitors for logging on to the DDC servers and Web Interface servers, respectively. 
    .PARAMETER Ipaddress 
        Set of IP addresses expected in the monitoring response from the DNS server, if the record type is A or AAAA. Applicable to DNS monitors. 
    .PARAMETER Group 
        Name of a newsgroup available on the NNTP service that is to be monitored. The appliance periodically generates an NNTP query for the name of the newsgroup and evaluates the response. If the newsgroup is found on the server, the service is marked as UP. If the newsgroup does not exist or if the search fails, the service is marked as DOWN. Applicable to NNTP monitors. 
    .PARAMETER Filename 
        Name of a file on the FTP server. The appliance monitors the FTP service by periodically checking the existence of the file on the server. Applicable to FTP-EXTENDED monitors. 
    .PARAMETER Basedn 
        The base distinguished name of the LDAP service, from where the LDAP server can begin the search for the attributes in the monitoring query. Required for LDAP service monitoring. 
    .PARAMETER Binddn 
        The distinguished name with which an LDAP monitor can perform the Bind operation on the LDAP server. Optional. Applicable to LDAP monitors. 
    .PARAMETER Filter 
        Filter criteria for the LDAP query. Optional. 
    .PARAMETER Attribute 
        Attribute to evaluate when the LDAP server responds to the query. Success or failure of the monitoring probe depends on whether the attribute exists in the response. Optional. 
    .PARAMETER Database 
        Name of the database to connect to during authentication. 
    .PARAMETER Oraclesid 
        Name of the service identifier that is used to connect to the Oracle database during authentication. 
    .PARAMETER Sqlquery 
        SQL query for a MYSQL-ECV or MSSQL-ECV monitor. Sent to the database server after the server authenticates the connection. 
    .PARAMETER Evalrule 
        Expression that evaluates the database server's response to a MYSQL-ECV or MSSQL-ECV monitoring query. Must produce a Boolean result. The result determines the state of the server. If the expression returns TRUE, the probe succeeds. 
        For example, if you want the appliance to evaluate the error message to determine the state of the server, use the rule MYSQL.RES.ROW(10) .TEXT_ELEM(2).EQ("MySQL"). 
    .PARAMETER Mssqlprotocolversion 
        Version of MSSQL server that is to be monitored. 
        Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
    .PARAMETER Snmpoid 
        SNMP OID for SNMP monitors. 
    .PARAMETER Snmpcommunity 
        Community name for SNMP monitors. 
    .PARAMETER Snmpthreshold 
        Threshold for SNMP monitors. 
    .PARAMETER Snmpversion 
        SNMP version to be used for SNMP monitors. 
        Possible values = V1, V2 
    .PARAMETER Metrictable 
        Metric table to which to bind metrics. 
    .PARAMETER Application 
        Name of the application used to determine the state of the service. Applicable to monitors of type CITRIX-XML-SERVICE. 
    .PARAMETER Sitepath 
        URL of the logon page. For monitors of type CITRIX-WEB-INTERFACE, to monitor a dynamic page under the site path, terminate the site path with a slash (/). Applicable to CITRIX-WEB-INTERFACE, CITRIX-WI-EXTENDED and CITRIX-XDM monitors. 
    .PARAMETER Storename 
        Store Name. For monitors of type STOREFRONT, STORENAME is an optional argument defining storefront service store name. Applicable to STOREFRONT monitors. 
    .PARAMETER Storefrontacctservice 
        Enable/Disable probing for Account Service. Applicable only to Store Front monitors. For multi-tenancy configuration users my skip account service. 
        Possible values = YES, NO 
    .PARAMETER Hostname 
        Hostname in the FQDN format (Example: porche.cars.org). Applicable to STOREFRONT monitors. 
    .PARAMETER Netprofile 
        Name of the network profile. 
    .PARAMETER Originhost 
        Origin-Host value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER Originrealm 
        Origin-Realm value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER Hostipaddress 
        Host-IP-Address value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. If Host-IP-Address is not specified, the appliance inserts the mapped IP (MIP) address or subnet IP (SNIP) address from which the CER request (the monitoring probe) is sent. 
    .PARAMETER Vendorid 
        Vendor-Id value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER Productname 
        Product-Name value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER Firmwarerevision 
        Firmware-Revision value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER Authapplicationid 
        List of Auth-Application-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring CER message. 
    .PARAMETER Acctapplicationid 
        List of Acct-Application-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring message. 
    .PARAMETER Inbandsecurityid 
        Inband-Security-Id for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
        Possible values = NO_INBAND_SECURITY, TLS 
    .PARAMETER Supportedvendorids 
        List of Supported-Vendor-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum eight of these AVPs are supported in a monitoring message. 
    .PARAMETER Vendorspecificvendorid 
        Vendor-Id to use in the Vendor-Specific-Application-Id grouped attribute-value pair (AVP) in the monitoring CER message. To specify Auth-Application-Id or Acct-Application-Id in Vendor-Specific-Application-Id, use vendorSpecificAuthApplicationIds or vendorSpecificAcctApplicationIds, respectively. Only one Vendor-Id is supported for all the Vendor-Specific-Application-Id AVPs in a CER monitoring message. 
    .PARAMETER Vendorspecificauthapplicationids 
        List of Vendor-Specific-Auth-Application-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring message. The specified value is combined with the value of vendorSpecificVendorId to obtain the Vendor-Specific-Application-Id AVP in the CER monitoring message. 
    .PARAMETER Vendorspecificacctapplicationids 
        List of Vendor-Specific-Acct-Application-Id attribute value pairs (AVPs) to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring message. The specified value is combined with the value of vendorSpecificVendorId to obtain the Vendor-Specific-Application-Id AVP in the CER monitoring message. 
    .PARAMETER Kcdaccount 
        KCD Account used by MSSQL monitor. 
    .PARAMETER Storedb 
        Store the database list populated with the responses to monitor probes. Used in database specific load balancing if MSSQL-ECV/MYSQL-ECV monitor is configured. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Storefrontcheckbackendservices 
        This option will enable monitoring of services running on storefront server. Storefront services are monitored by probing to a Windows service that runs on the Storefront server and exposes details of which storefront services are running. 
        Possible values = YES, NO 
    .PARAMETER Trofscode 
        Code expected when the server is under maintenance. 
    .PARAMETER Trofsstring 
        String expected from the server for the service to be marked as trofs. Applicable to HTTP-ECV/TCP-ECV monitors. 
    .PARAMETER Sslprofile 
        SSL Profile associated with the monitor. 
    .PARAMETER Mqttclientidentifier 
        Client id to be used in Connect command. 
    .PARAMETER Mqttversion 
        Version of MQTT protocol used in connect message, default is version 3.1.1 [4]. 
    .PARAMETER PassThru 
        Return details about the created lbmonitor item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbmonitor -monitorname <string> -type <string>
        An example how to add lbmonitor configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbmonitor
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor/
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
        [string]$Monitorname,

        [Parameter(Mandatory)]
        [ValidateSet('PING', 'TCP', 'HTTP', 'TCP-ECV', 'HTTP-ECV', 'UDP-ECV', 'DNS', 'FTP', 'LDNS-PING', 'LDNS-TCP', 'LDNS-DNS', 'RADIUS', 'USER', 'HTTP-INLINE', 'SIP-UDP', 'SIP-TCP', 'LOAD', 'FTP-EXTENDED', 'SMTP', 'SNMP', 'NNTP', 'MYSQL', 'MYSQL-ECV', 'MSSQL-ECV', 'ORACLE-ECV', 'LDAP', 'POP3', 'CITRIX-XML-SERVICE', 'CITRIX-WEB-INTERFACE', 'DNS-TCP', 'RTSP', 'ARP', 'CITRIX-AG', 'CITRIX-AAC-LOGINPAGE', 'CITRIX-AAC-LAS', 'CITRIX-XD-DDC', 'ND6', 'CITRIX-WI-EXTENDED', 'DIAMETER', 'RADIUS_ACCOUNTING', 'STOREFRONT', 'APPC', 'SMPP', 'CITRIX-XNC-ECV', 'CITRIX-XDM', 'CITRIX-STA-SERVICE', 'CITRIX-STA-SERVICE-NHOP', 'MQTT', 'HTTP2')]
        [string]$Type,

        [ValidateSet('NONE', 'LOG', 'DOWN')]
        [string]$Action = 'DOWN',

        [string[]]$Respcode,

        [string]$Httprequest,

        [string]$Rtsprequest,

        [string]$Customheaders,

        [ValidateRange(0, 255)]
        [double]$Maxforwards = '1',

        [ValidateSet('OPTIONS', 'INVITE', 'REGISTER')]
        [string]$Sipmethod,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sipuri,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sipreguri,

        [string]$Send,

        [string]$Recv,

        [string]$Query,

        [ValidateSet('Address', 'Zone', 'AAAA')]
        [string]$Querytype,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Scriptname,

        [string]$Scriptargs,

        [string]$Secureargs,

        [string]$Dispatcherip,

        [int]$Dispatcherport,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [string]$Secondarypassword,

        [string]$Logonpointname,

        [string]$Lasversion,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Radkey,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Radnasid,

        [string]$Radnasip,

        [ValidateRange(0, 15)]
        [double]$Radaccounttype = '1',

        [string]$Radframedip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Radapn,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Radmsisdn,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Radaccountsession,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Lrtm,

        [ValidateRange(0, 20939)]
        [double]$Deviation,

        [ValidateSet('SEC', 'MSEC', 'MIN')]
        [string]$Units1 = 'SEC',

        [ValidateRange(1, 20940)]
        [int]$Interval = '5',

        [ValidateSet('SEC', 'MSEC', 'MIN')]
        [string]$Units3 = 'SEC',

        [ValidateRange(1, 20939)]
        [int]$Resptimeout = '2',

        [ValidateSet('SEC', 'MSEC', 'MIN')]
        [string]$Units4 = 'SEC',

        [ValidateRange(0, 100)]
        [double]$Resptimeoutthresh,

        [ValidateRange(1, 127)]
        [int]$Retries = '3',

        [ValidateRange(0, 32)]
        [int]$Failureretries,

        [ValidateRange(0, 32)]
        [int]$Alertretries,

        [ValidateRange(1, 32)]
        [int]$Successretries = '1',

        [ValidateRange(1, 20939)]
        [int]$Downtime = '30',

        [ValidateSet('SEC', 'MSEC', 'MIN')]
        [string]$Units2 = 'SEC',

        [string]$Destip,

        [int]$Destport,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('YES', 'NO')]
        [string]$Reverse = 'NO',

        [ValidateSet('YES', 'NO')]
        [string]$Transparent = 'NO',

        [ValidateSet('YES', 'NO')]
        [string]$Iptunnel = 'NO',

        [ValidateSet('YES', 'NO')]
        [string]$Tos,

        [ValidateRange(1, 63)]
        [double]$Tosid,

        [ValidateSet('YES', 'NO')]
        [string]$Secure = 'NO',

        [ValidateSet('YES', 'NO')]
        [string]$Validatecred = 'NO',

        [string]$Domain,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Ipaddress,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Group,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Filename,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Basedn,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Binddn,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Filter,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Attribute,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Database,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Oraclesid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sqlquery,

        [string]$Evalrule,

        [ValidateSet('70', '2000', '2000SP1', '2005', '2008', '2008R2', '2012', '2014')]
        [string]$Mssqlprotocolversion = '70',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Snmpoid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Snmpcommunity,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Snmpthreshold,

        [ValidateSet('V1', 'V2')]
        [string]$Snmpversion,

        [ValidateLength(1, 99)]
        [string]$Metrictable,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Application,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sitepath,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Storename,

        [ValidateSet('YES', 'NO')]
        [string]$Storefrontacctservice = 'YES',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Hostname,

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Originhost,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Originrealm,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Hostipaddress,

        [double]$Vendorid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Productname,

        [double]$Firmwarerevision,

        [ValidateRange(0, 4294967295)]
        [double[]]$Authapplicationid,

        [ValidateRange(0, 4294967295)]
        [double[]]$Acctapplicationid,

        [ValidateSet('NO_INBAND_SECURITY', 'TLS')]
        [string]$Inbandsecurityid,

        [ValidateRange(1, 4294967295)]
        [double[]]$Supportedvendorids,

        [double]$Vendorspecificvendorid,

        [ValidateRange(0, 4294967295)]
        [double[]]$Vendorspecificauthapplicationids,

        [ValidateRange(0, 4294967295)]
        [double[]]$Vendorspecificacctapplicationids,

        [ValidateLength(1, 32)]
        [string]$Kcdaccount,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Storedb = 'DISABLED',

        [ValidateSet('YES', 'NO')]
        [string]$Storefrontcheckbackendservices = 'NO',

        [double]$Trofscode,

        [string]$Trofsstring,

        [ValidateLength(1, 127)]
        [string]$Sslprofile,

        [string]$Mqttclientidentifier,

        [double]$Mqttversion = '4',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbmonitor: Starting"
    }
    process {
        try {
            $payload = @{ monitorname = $monitorname
                type                  = $type
            }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('respcode') ) { $payload.Add('respcode', $respcode) }
            if ( $PSBoundParameters.ContainsKey('httprequest') ) { $payload.Add('httprequest', $httprequest) }
            if ( $PSBoundParameters.ContainsKey('rtsprequest') ) { $payload.Add('rtsprequest', $rtsprequest) }
            if ( $PSBoundParameters.ContainsKey('customheaders') ) { $payload.Add('customheaders', $customheaders) }
            if ( $PSBoundParameters.ContainsKey('maxforwards') ) { $payload.Add('maxforwards', $maxforwards) }
            if ( $PSBoundParameters.ContainsKey('sipmethod') ) { $payload.Add('sipmethod', $sipmethod) }
            if ( $PSBoundParameters.ContainsKey('sipuri') ) { $payload.Add('sipuri', $sipuri) }
            if ( $PSBoundParameters.ContainsKey('sipreguri') ) { $payload.Add('sipreguri', $sipreguri) }
            if ( $PSBoundParameters.ContainsKey('send') ) { $payload.Add('send', $send) }
            if ( $PSBoundParameters.ContainsKey('recv') ) { $payload.Add('recv', $recv) }
            if ( $PSBoundParameters.ContainsKey('query') ) { $payload.Add('query', $query) }
            if ( $PSBoundParameters.ContainsKey('querytype') ) { $payload.Add('querytype', $querytype) }
            if ( $PSBoundParameters.ContainsKey('scriptname') ) { $payload.Add('scriptname', $scriptname) }
            if ( $PSBoundParameters.ContainsKey('scriptargs') ) { $payload.Add('scriptargs', $scriptargs) }
            if ( $PSBoundParameters.ContainsKey('secureargs') ) { $payload.Add('secureargs', $secureargs) }
            if ( $PSBoundParameters.ContainsKey('dispatcherip') ) { $payload.Add('dispatcherip', $dispatcherip) }
            if ( $PSBoundParameters.ContainsKey('dispatcherport') ) { $payload.Add('dispatcherport', $dispatcherport) }
            if ( $PSBoundParameters.ContainsKey('username') ) { $payload.Add('username', $username) }
            if ( $PSBoundParameters.ContainsKey('password') ) { $payload.Add('password', $password) }
            if ( $PSBoundParameters.ContainsKey('secondarypassword') ) { $payload.Add('secondarypassword', $secondarypassword) }
            if ( $PSBoundParameters.ContainsKey('logonpointname') ) { $payload.Add('logonpointname', $logonpointname) }
            if ( $PSBoundParameters.ContainsKey('lasversion') ) { $payload.Add('lasversion', $lasversion) }
            if ( $PSBoundParameters.ContainsKey('radkey') ) { $payload.Add('radkey', $radkey) }
            if ( $PSBoundParameters.ContainsKey('radnasid') ) { $payload.Add('radnasid', $radnasid) }
            if ( $PSBoundParameters.ContainsKey('radnasip') ) { $payload.Add('radnasip', $radnasip) }
            if ( $PSBoundParameters.ContainsKey('radaccounttype') ) { $payload.Add('radaccounttype', $radaccounttype) }
            if ( $PSBoundParameters.ContainsKey('radframedip') ) { $payload.Add('radframedip', $radframedip) }
            if ( $PSBoundParameters.ContainsKey('radapn') ) { $payload.Add('radapn', $radapn) }
            if ( $PSBoundParameters.ContainsKey('radmsisdn') ) { $payload.Add('radmsisdn', $radmsisdn) }
            if ( $PSBoundParameters.ContainsKey('radaccountsession') ) { $payload.Add('radaccountsession', $radaccountsession) }
            if ( $PSBoundParameters.ContainsKey('lrtm') ) { $payload.Add('lrtm', $lrtm) }
            if ( $PSBoundParameters.ContainsKey('deviation') ) { $payload.Add('deviation', $deviation) }
            if ( $PSBoundParameters.ContainsKey('units1') ) { $payload.Add('units1', $units1) }
            if ( $PSBoundParameters.ContainsKey('interval') ) { $payload.Add('interval', $interval) }
            if ( $PSBoundParameters.ContainsKey('units3') ) { $payload.Add('units3', $units3) }
            if ( $PSBoundParameters.ContainsKey('resptimeout') ) { $payload.Add('resptimeout', $resptimeout) }
            if ( $PSBoundParameters.ContainsKey('units4') ) { $payload.Add('units4', $units4) }
            if ( $PSBoundParameters.ContainsKey('resptimeoutthresh') ) { $payload.Add('resptimeoutthresh', $resptimeoutthresh) }
            if ( $PSBoundParameters.ContainsKey('retries') ) { $payload.Add('retries', $retries) }
            if ( $PSBoundParameters.ContainsKey('failureretries') ) { $payload.Add('failureretries', $failureretries) }
            if ( $PSBoundParameters.ContainsKey('alertretries') ) { $payload.Add('alertretries', $alertretries) }
            if ( $PSBoundParameters.ContainsKey('successretries') ) { $payload.Add('successretries', $successretries) }
            if ( $PSBoundParameters.ContainsKey('downtime') ) { $payload.Add('downtime', $downtime) }
            if ( $PSBoundParameters.ContainsKey('units2') ) { $payload.Add('units2', $units2) }
            if ( $PSBoundParameters.ContainsKey('destip') ) { $payload.Add('destip', $destip) }
            if ( $PSBoundParameters.ContainsKey('destport') ) { $payload.Add('destport', $destport) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('reverse') ) { $payload.Add('reverse', $reverse) }
            if ( $PSBoundParameters.ContainsKey('transparent') ) { $payload.Add('transparent', $transparent) }
            if ( $PSBoundParameters.ContainsKey('iptunnel') ) { $payload.Add('iptunnel', $iptunnel) }
            if ( $PSBoundParameters.ContainsKey('tos') ) { $payload.Add('tos', $tos) }
            if ( $PSBoundParameters.ContainsKey('tosid') ) { $payload.Add('tosid', $tosid) }
            if ( $PSBoundParameters.ContainsKey('secure') ) { $payload.Add('secure', $secure) }
            if ( $PSBoundParameters.ContainsKey('validatecred') ) { $payload.Add('validatecred', $validatecred) }
            if ( $PSBoundParameters.ContainsKey('domain') ) { $payload.Add('domain', $domain) }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('group') ) { $payload.Add('group', $group) }
            if ( $PSBoundParameters.ContainsKey('filename') ) { $payload.Add('filename', $filename) }
            if ( $PSBoundParameters.ContainsKey('basedn') ) { $payload.Add('basedn', $basedn) }
            if ( $PSBoundParameters.ContainsKey('binddn') ) { $payload.Add('binddn', $binddn) }
            if ( $PSBoundParameters.ContainsKey('filter') ) { $payload.Add('filter', $filter) }
            if ( $PSBoundParameters.ContainsKey('attribute') ) { $payload.Add('attribute', $attribute) }
            if ( $PSBoundParameters.ContainsKey('database') ) { $payload.Add('database', $database) }
            if ( $PSBoundParameters.ContainsKey('oraclesid') ) { $payload.Add('oraclesid', $oraclesid) }
            if ( $PSBoundParameters.ContainsKey('sqlquery') ) { $payload.Add('sqlquery', $sqlquery) }
            if ( $PSBoundParameters.ContainsKey('evalrule') ) { $payload.Add('evalrule', $evalrule) }
            if ( $PSBoundParameters.ContainsKey('mssqlprotocolversion') ) { $payload.Add('mssqlprotocolversion', $mssqlprotocolversion) }
            if ( $PSBoundParameters.ContainsKey('Snmpoid') ) { $payload.Add('Snmpoid', $Snmpoid) }
            if ( $PSBoundParameters.ContainsKey('snmpcommunity') ) { $payload.Add('snmpcommunity', $snmpcommunity) }
            if ( $PSBoundParameters.ContainsKey('snmpthreshold') ) { $payload.Add('snmpthreshold', $snmpthreshold) }
            if ( $PSBoundParameters.ContainsKey('snmpversion') ) { $payload.Add('snmpversion', $snmpversion) }
            if ( $PSBoundParameters.ContainsKey('metrictable') ) { $payload.Add('metrictable', $metrictable) }
            if ( $PSBoundParameters.ContainsKey('application') ) { $payload.Add('application', $application) }
            if ( $PSBoundParameters.ContainsKey('sitepath') ) { $payload.Add('sitepath', $sitepath) }
            if ( $PSBoundParameters.ContainsKey('storename') ) { $payload.Add('storename', $storename) }
            if ( $PSBoundParameters.ContainsKey('storefrontacctservice') ) { $payload.Add('storefrontacctservice', $storefrontacctservice) }
            if ( $PSBoundParameters.ContainsKey('hostname') ) { $payload.Add('hostname', $hostname) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('originhost') ) { $payload.Add('originhost', $originhost) }
            if ( $PSBoundParameters.ContainsKey('originrealm') ) { $payload.Add('originrealm', $originrealm) }
            if ( $PSBoundParameters.ContainsKey('hostipaddress') ) { $payload.Add('hostipaddress', $hostipaddress) }
            if ( $PSBoundParameters.ContainsKey('vendorid') ) { $payload.Add('vendorid', $vendorid) }
            if ( $PSBoundParameters.ContainsKey('productname') ) { $payload.Add('productname', $productname) }
            if ( $PSBoundParameters.ContainsKey('firmwarerevision') ) { $payload.Add('firmwarerevision', $firmwarerevision) }
            if ( $PSBoundParameters.ContainsKey('authapplicationid') ) { $payload.Add('authapplicationid', $authapplicationid) }
            if ( $PSBoundParameters.ContainsKey('acctapplicationid') ) { $payload.Add('acctapplicationid', $acctapplicationid) }
            if ( $PSBoundParameters.ContainsKey('inbandsecurityid') ) { $payload.Add('inbandsecurityid', $inbandsecurityid) }
            if ( $PSBoundParameters.ContainsKey('supportedvendorids') ) { $payload.Add('supportedvendorids', $supportedvendorids) }
            if ( $PSBoundParameters.ContainsKey('vendorspecificvendorid') ) { $payload.Add('vendorspecificvendorid', $vendorspecificvendorid) }
            if ( $PSBoundParameters.ContainsKey('vendorspecificauthapplicationids') ) { $payload.Add('vendorspecificauthapplicationids', $vendorspecificauthapplicationids) }
            if ( $PSBoundParameters.ContainsKey('vendorspecificacctapplicationids') ) { $payload.Add('vendorspecificacctapplicationids', $vendorspecificacctapplicationids) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('storedb') ) { $payload.Add('storedb', $storedb) }
            if ( $PSBoundParameters.ContainsKey('storefrontcheckbackendservices') ) { $payload.Add('storefrontcheckbackendservices', $storefrontcheckbackendservices) }
            if ( $PSBoundParameters.ContainsKey('trofscode') ) { $payload.Add('trofscode', $trofscode) }
            if ( $PSBoundParameters.ContainsKey('trofsstring') ) { $payload.Add('trofsstring', $trofsstring) }
            if ( $PSBoundParameters.ContainsKey('sslprofile') ) { $payload.Add('sslprofile', $sslprofile) }
            if ( $PSBoundParameters.ContainsKey('mqttclientidentifier') ) { $payload.Add('mqttclientidentifier', $mqttclientidentifier) }
            if ( $PSBoundParameters.ContainsKey('mqttversion') ) { $payload.Add('mqttversion', $mqttversion) }
            if ( $PSCmdlet.ShouldProcess("lbmonitor", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lbmonitor -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbmonitor -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbmonitor: Finished"
    }
}

function Invoke-ADCDeleteLbmonitor {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for monitor resource.
    .PARAMETER Monitorname 
        Name for the monitor. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my monitor" or 'my monitor'). 
    .PARAMETER Type 
        Type of monitor that you want to create. 
        Possible values = PING, TCP, HTTP, TCP-ECV, HTTP-ECV, UDP-ECV, DNS, FTP, LDNS-PING, LDNS-TCP, LDNS-DNS, RADIUS, USER, HTTP-INLINE, SIP-UDP, SIP-TCP, LOAD, FTP-EXTENDED, SMTP, SNMP, NNTP, MYSQL, MYSQL-ECV, MSSQL-ECV, ORACLE-ECV, LDAP, POP3, CITRIX-XML-SERVICE, CITRIX-WEB-INTERFACE, DNS-TCP, RTSP, ARP, CITRIX-AG, CITRIX-AAC-LOGINPAGE, CITRIX-AAC-LAS, CITRIX-XD-DDC, ND6, CITRIX-WI-EXTENDED, DIAMETER, RADIUS_ACCOUNTING, STOREFRONT, APPC, SMPP, CITRIX-XNC-ECV, CITRIX-XDM, CITRIX-STA-SERVICE, CITRIX-STA-SERVICE-NHOP, MQTT, HTTP2 
    .PARAMETER Respcode 
        Response codes for which to mark the service as UP. For any other response code, the action performed depends on the monitor type. HTTP monitors and RADIUS monitors mark the service as DOWN, while HTTP-INLINE monitors perform the action indicated by the Action parameter.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbmonitor -Monitorname <string>
        An example how to delete lbmonitor configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbmonitor
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor/
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
        [string]$Monitorname,

        [string]$Type,

        [string[]]$Respcode 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbmonitor: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Respcode') ) { $arguments.Add('respcode', $Respcode) }
            if ( $PSCmdlet.ShouldProcess("$monitorname", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbmonitor -NitroPath nitro/v1/config -Resource $monitorname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbmonitor: Finished"
    }
}

function Invoke-ADCUpdateLbmonitor {
    <#
    .SYNOPSIS
        Update Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for monitor resource.
    .PARAMETER Monitorname 
        Name for the monitor. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my monitor" or 'my monitor'). 
    .PARAMETER Type 
        Type of monitor that you want to create. 
        Possible values = PING, TCP, HTTP, TCP-ECV, HTTP-ECV, UDP-ECV, DNS, FTP, LDNS-PING, LDNS-TCP, LDNS-DNS, RADIUS, USER, HTTP-INLINE, SIP-UDP, SIP-TCP, LOAD, FTP-EXTENDED, SMTP, SNMP, NNTP, MYSQL, MYSQL-ECV, MSSQL-ECV, ORACLE-ECV, LDAP, POP3, CITRIX-XML-SERVICE, CITRIX-WEB-INTERFACE, DNS-TCP, RTSP, ARP, CITRIX-AG, CITRIX-AAC-LOGINPAGE, CITRIX-AAC-LAS, CITRIX-XD-DDC, ND6, CITRIX-WI-EXTENDED, DIAMETER, RADIUS_ACCOUNTING, STOREFRONT, APPC, SMPP, CITRIX-XNC-ECV, CITRIX-XDM, CITRIX-STA-SERVICE, CITRIX-STA-SERVICE-NHOP, MQTT, HTTP2 
    .PARAMETER Action 
        Action to perform when the response to an inline monitor (a monitor of type HTTP-INLINE) indicates that the service is down. A service monitored by an inline monitor is considered DOWN if the response code is not one of the codes that have been specified for the Response Code parameter. 
        Available settings function as follows: 
        * NONE - Do not take any action. However, the show service command and the show lb monitor command indicate the total number of responses that were checked and the number of consecutive error responses received after the last successful probe. 
        * LOG - Log the event in NSLOG or SYSLOG. 
        * DOWN - Mark the service as being down, and then do not direct any traffic to the service until the configured down time has expired. Persistent connections to the service are terminated as soon as the service is marked as DOWN. Also, log the event in NSLOG or SYSLOG. 
        Possible values = NONE, LOG, DOWN 
    .PARAMETER Respcode 
        Response codes for which to mark the service as UP. For any other response code, the action performed depends on the monitor type. HTTP monitors and RADIUS monitors mark the service as DOWN, while HTTP-INLINE monitors perform the action indicated by the Action parameter. 
    .PARAMETER Httprequest 
        HTTP request to send to the server (for example, "HEAD /file.html"). 
    .PARAMETER Rtsprequest 
        RTSP request to send to the server (for example, "OPTIONS *"). 
    .PARAMETER Customheaders 
        Custom header string to include in the monitoring probes. 
    .PARAMETER Maxforwards 
        Maximum number of hops that the SIP request used for monitoring can traverse to reach the server. Applicable only to monitors of type SIP-UDP. 
    .PARAMETER Sipmethod 
        SIP method to use for the query. Applicable only to monitors of type SIP-UDP. 
        Possible values = OPTIONS, INVITE, REGISTER 
    .PARAMETER Sipreguri 
        SIP user to be registered. Applicable only if the monitor is of type SIP-UDP and the SIP Method parameter is set to REGISTER. 
    .PARAMETER Sipuri 
        SIP URI string to send to the service (for example, sip:sip.test). Applicable only to monitors of type SIP-UDP. 
    .PARAMETER Send 
        String to send to the service. Applicable to TCP-ECV, HTTP-ECV, and UDP-ECV monitors. 
    .PARAMETER Recv 
        String expected from the server for the service to be marked as UP. Applicable to TCP-ECV, HTTP-ECV, and UDP-ECV monitors. 
    .PARAMETER Query 
        Domain name to resolve as part of monitoring the DNS service (for example, example.com). 
    .PARAMETER Querytype 
        Type of DNS record for which to send monitoring queries. Set to Address for querying A records, AAAA for querying AAAA records, and Zone for querying the SOA record. 
        Possible values = Address, Zone, AAAA 
    .PARAMETER Username 
        User name with which to probe the RADIUS, NNTP, FTP, FTP-EXTENDED, MYSQL, MSSQL, POP3, CITRIX-AG, CITRIX-XD-DDC, CITRIX-WI-EXTENDED, CITRIX-XNC or CITRIX-XDM server. 
    .PARAMETER Password 
        Password that is required for logging on to the RADIUS, NNTP, FTP, FTP-EXTENDED, MYSQL, MSSQL, POP3, CITRIX-AG, CITRIX-XD-DDC, CITRIX-WI-EXTENDED, CITRIX-XNC-ECV or CITRIX-XDM server. Used in conjunction with the user name specified for the User Name parameter. 
    .PARAMETER Secondarypassword 
        Secondary password that users might have to provide to log on to the Access Gateway server. Applicable to CITRIX-AG monitors. 
    .PARAMETER Logonpointname 
        Name of the logon point that is configured for the Citrix Access Gateway Advanced Access Control software. Required if you want to monitor the associated login page or Logon Agent. Applicable to CITRIX-AAC-LAS and CITRIX-AAC-LOGINPAGE monitors. 
    .PARAMETER Lasversion 
        Version number of the Citrix Advanced Access Control Logon Agent. Required by the CITRIX-AAC-LAS monitor. 
    .PARAMETER Radkey 
        Authentication key (shared secret text string) for RADIUS clients and servers to exchange. Applicable to monitors of type RADIUS and RADIUS_ACCOUNTING. 
    .PARAMETER Radnasid 
        NAS-Identifier to send in the Access-Request packet. Applicable to monitors of type RADIUS. 
    .PARAMETER Radnasip 
        Network Access Server (NAS) IP address to use as the source IP address when monitoring a RADIUS server. Applicable to monitors of type RADIUS and RADIUS_ACCOUNTING. 
    .PARAMETER Radaccounttype 
        Account Type to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING. 
    .PARAMETER Radframedip 
        Source ip with which the packet will go out . Applicable to monitors of type RADIUS_ACCOUNTING. 
    .PARAMETER Radapn 
        Called Station Id to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING. 
    .PARAMETER Radmsisdn 
        Calling Stations Id to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING. 
    .PARAMETER Radaccountsession 
        Account Session ID to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING. 
    .PARAMETER Lrtm 
        Calculate the least response times for bound services. If this parameter is not enabled, the appliance does not learn the response times of the bound services. Also used for LRTM load balancing. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Deviation 
        Time value added to the learned average response time in dynamic response time monitoring (DRTM). When a deviation is specified, the appliance learns the average response time of bound services and adds the deviation to the average. The final value is then continually adjusted to accommodate response time variations over time. Specified in milliseconds, seconds, or minutes. 
    .PARAMETER Units1 
        Unit of measurement for the Deviation parameter. Cannot be changed after the monitor is created. 
        Possible values = SEC, MSEC, MIN 
    .PARAMETER Scriptname 
        Path and name of the script to execute. The script must be available on the Citrix ADC, in the /nsconfig/monitors/ directory. 
    .PARAMETER Scriptargs 
        String of arguments for the script. The string is copied verbatim into the request. 
    .PARAMETER Secureargs 
        List of arguments for the script which should be secure. 
    .PARAMETER Validatecred 
        Validate the credentials of the Xen Desktop DDC server user. Applicable to monitors of type CITRIX-XD-DDC. 
        Possible values = YES, NO 
    .PARAMETER Domain 
        Domain in which the XenDesktop Desktop Delivery Controller (DDC) servers or Web Interface servers are present. Required by CITRIX-XD-DDC and CITRIX-WI-EXTENDED monitors for logging on to the DDC servers and Web Interface servers, respectively. 
    .PARAMETER Dispatcherip 
        IP address of the dispatcher to which to send the probe. 
    .PARAMETER Dispatcherport 
        Port number on which the dispatcher listens for the monitoring probe. 
    .PARAMETER Interval 
        Time interval between two successive probes. Must be greater than the value of Response Time-out. 
    .PARAMETER Units3 
        monitor interval units. 
        Possible values = SEC, MSEC, MIN 
    .PARAMETER Resptimeout 
        Amount of time for which the appliance must wait before it marks a probe as FAILED. Must be less than the value specified for the Interval parameter. 
        Note: For UDP-ECV monitors for which a receive string is not configured, response timeout does not apply. For UDP-ECV monitors with no receive string, probe failure is indicated by an ICMP port unreachable error received from the service. 
    .PARAMETER Units4 
        monitor response timeout units. 
        Possible values = SEC, MSEC, MIN 
    .PARAMETER Resptimeoutthresh 
        Response time threshold, specified as a percentage of the Response Time-out parameter. If the response to a monitor probe has not arrived when the threshold is reached, the appliance generates an SNMP trap called monRespTimeoutAboveThresh. After the response time returns to a value below the threshold, the appliance generates a monRespTimeoutBelowThresh SNMP trap. For the traps to be generated, the "MONITOR-RTO-THRESHOLD" alarm must also be enabled. 
    .PARAMETER Retries 
        Maximum number of probes to send to establish the state of a service for which a monitoring probe failed. 
    .PARAMETER Failureretries 
        Number of retries that must fail, out of the number specified for the Retries parameter, for a service to be marked as DOWN. For example, if the Retries parameter is set to 10 and the Failure Retries parameter is set to 6, out of the ten probes sent, at least six probes must fail if the service is to be marked as DOWN. The default value of 0 means that all the retries must fail if the service is to be marked as DOWN. 
    .PARAMETER Alertretries 
        Number of consecutive probe failures after which the appliance generates an SNMP trap called monProbeFailed. 
    .PARAMETER Successretries 
        Number of consecutive successful probes required to transition a service's state from DOWN to UP. 
    .PARAMETER Downtime 
        Time duration for which to wait before probing a service that has been marked as DOWN. Expressed in milliseconds, seconds, or minutes. 
    .PARAMETER Units2 
        Unit of measurement for the Down Time parameter. Cannot be changed after the monitor is created. 
        Possible values = SEC, MSEC, MIN 
    .PARAMETER Destip 
        IP address of the service to which to send probes. If the parameter is set to 0, the IP address of the server to which the monitor is bound is considered the destination IP address. 
    .PARAMETER Destport 
        TCP or UDP port to which to send the probe. If the parameter is set to 0, the port number of the service to which the monitor is bound is considered the destination port. For a monitor of type USER, however, the destination port is the port number that is included in the HTTP request sent to the dispatcher. Does not apply to monitors of type PING. 
    .PARAMETER State 
        State of the monitor. The DISABLED setting disables not only the monitor being configured, but all monitors of the same type, until the parameter is set to ENABLED. If the monitor is bound to a service, the state of the monitor is not taken into account when the state of the service is determined. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Reverse 
        Mark a service as DOWN, instead of UP, when probe criteria are satisfied, and as UP instead of DOWN when probe criteria are not satisfied. 
        Possible values = YES, NO 
    .PARAMETER Transparent 
        The monitor is bound to a transparent device such as a firewall or router. The state of a transparent device depends on the responsiveness of the services behind it. If a transparent device is being monitored, a destination IP address must be specified. The probe is sent to the specified IP address by using the MAC address of the transparent device. 
        Possible values = YES, NO 
    .PARAMETER Iptunnel 
        Send the monitoring probe to the service through an IP tunnel. A destination IP address must be specified. 
        Possible values = YES, NO 
    .PARAMETER Tos 
        Probe the service by encoding the destination IP address in the IP TOS (6) bits. 
        Possible values = YES, NO 
    .PARAMETER Tosid 
        The TOS ID of the specified destination IP. Applicable only when the TOS parameter is set. 
    .PARAMETER Secure 
        Use a secure SSL connection when monitoring a service. Applicable only to TCP based monitors. The secure option cannot be used with a CITRIX-AG monitor, because a CITRIX-AG monitor uses a secure connection by default. 
        Possible values = YES, NO 
    .PARAMETER Ipaddress 
        Set of IP addresses expected in the monitoring response from the DNS server, if the record type is A or AAAA. Applicable to DNS monitors. 
    .PARAMETER Group 
        Name of a newsgroup available on the NNTP service that is to be monitored. The appliance periodically generates an NNTP query for the name of the newsgroup and evaluates the response. If the newsgroup is found on the server, the service is marked as UP. If the newsgroup does not exist or if the search fails, the service is marked as DOWN. Applicable to NNTP monitors. 
    .PARAMETER Filename 
        Name of a file on the FTP server. The appliance monitors the FTP service by periodically checking the existence of the file on the server. Applicable to FTP-EXTENDED monitors. 
    .PARAMETER Basedn 
        The base distinguished name of the LDAP service, from where the LDAP server can begin the search for the attributes in the monitoring query. Required for LDAP service monitoring. 
    .PARAMETER Binddn 
        The distinguished name with which an LDAP monitor can perform the Bind operation on the LDAP server. Optional. Applicable to LDAP monitors. 
    .PARAMETER Filter 
        Filter criteria for the LDAP query. Optional. 
    .PARAMETER Attribute 
        Attribute to evaluate when the LDAP server responds to the query. Success or failure of the monitoring probe depends on whether the attribute exists in the response. Optional. 
    .PARAMETER Database 
        Name of the database to connect to during authentication. 
    .PARAMETER Oraclesid 
        Name of the service identifier that is used to connect to the Oracle database during authentication. 
    .PARAMETER Sqlquery 
        SQL query for a MYSQL-ECV or MSSQL-ECV monitor. Sent to the database server after the server authenticates the connection. 
    .PARAMETER Evalrule 
        Expression that evaluates the database server's response to a MYSQL-ECV or MSSQL-ECV monitoring query. Must produce a Boolean result. The result determines the state of the server. If the expression returns TRUE, the probe succeeds. 
        For example, if you want the appliance to evaluate the error message to determine the state of the server, use the rule MYSQL.RES.ROW(10) .TEXT_ELEM(2).EQ("MySQL"). 
    .PARAMETER Snmpoid 
        SNMP OID for SNMP monitors. 
    .PARAMETER Snmpcommunity 
        Community name for SNMP monitors. 
    .PARAMETER Snmpthreshold 
        Threshold for SNMP monitors. 
    .PARAMETER Snmpversion 
        SNMP version to be used for SNMP monitors. 
        Possible values = V1, V2 
    .PARAMETER Metrictable 
        Metric table to which to bind metrics. 
    .PARAMETER Metric 
        Metric name in the metric table, whose setting is changed. A value zero disables the metric and it will not be used for load calculation. 
    .PARAMETER Metricthreshold 
        Threshold to be used for that metric. 
    .PARAMETER Metricweight 
        The weight for the specified service metric with respect to others. 
    .PARAMETER Application 
        Name of the application used to determine the state of the service. Applicable to monitors of type CITRIX-XML-SERVICE. 
    .PARAMETER Sitepath 
        URL of the logon page. For monitors of type CITRIX-WEB-INTERFACE, to monitor a dynamic page under the site path, terminate the site path with a slash (/). Applicable to CITRIX-WEB-INTERFACE, CITRIX-WI-EXTENDED and CITRIX-XDM monitors. 
    .PARAMETER Storename 
        Store Name. For monitors of type STOREFRONT, STORENAME is an optional argument defining storefront service store name. Applicable to STOREFRONT monitors. 
    .PARAMETER Storefrontacctservice 
        Enable/Disable probing for Account Service. Applicable only to Store Front monitors. For multi-tenancy configuration users my skip account service. 
        Possible values = YES, NO 
    .PARAMETER Storefrontcheckbackendservices 
        This option will enable monitoring of services running on storefront server. Storefront services are monitored by probing to a Windows service that runs on the Storefront server and exposes details of which storefront services are running. 
        Possible values = YES, NO 
    .PARAMETER Hostname 
        Hostname in the FQDN format (Example: porche.cars.org). Applicable to STOREFRONT monitors. 
    .PARAMETER Netprofile 
        Name of the network profile. 
    .PARAMETER Mssqlprotocolversion 
        Version of MSSQL server that is to be monitored. 
        Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
    .PARAMETER Originhost 
        Origin-Host value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER Originrealm 
        Origin-Realm value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER Hostipaddress 
        Host-IP-Address value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. If Host-IP-Address is not specified, the appliance inserts the mapped IP (MIP) address or subnet IP (SNIP) address from which the CER request (the monitoring probe) is sent. 
    .PARAMETER Vendorid 
        Vendor-Id value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER Productname 
        Product-Name value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER Firmwarerevision 
        Firmware-Revision value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER Authapplicationid 
        List of Auth-Application-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring CER message. 
    .PARAMETER Acctapplicationid 
        List of Acct-Application-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring message. 
    .PARAMETER Inbandsecurityid 
        Inband-Security-Id for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
        Possible values = NO_INBAND_SECURITY, TLS 
    .PARAMETER Supportedvendorids 
        List of Supported-Vendor-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum eight of these AVPs are supported in a monitoring message. 
    .PARAMETER Vendorspecificvendorid 
        Vendor-Id to use in the Vendor-Specific-Application-Id grouped attribute-value pair (AVP) in the monitoring CER message. To specify Auth-Application-Id or Acct-Application-Id in Vendor-Specific-Application-Id, use vendorSpecificAuthApplicationIds or vendorSpecificAcctApplicationIds, respectively. Only one Vendor-Id is supported for all the Vendor-Specific-Application-Id AVPs in a CER monitoring message. 
    .PARAMETER Vendorspecificauthapplicationids 
        List of Vendor-Specific-Auth-Application-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring message. The specified value is combined with the value of vendorSpecificVendorId to obtain the Vendor-Specific-Application-Id AVP in the CER monitoring message. 
    .PARAMETER Vendorspecificacctapplicationids 
        List of Vendor-Specific-Acct-Application-Id attribute value pairs (AVPs) to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring message. The specified value is combined with the value of vendorSpecificVendorId to obtain the Vendor-Specific-Application-Id AVP in the CER monitoring message. 
    .PARAMETER Kcdaccount 
        KCD Account used by MSSQL monitor. 
    .PARAMETER Storedb 
        Store the database list populated with the responses to monitor probes. Used in database specific load balancing if MSSQL-ECV/MYSQL-ECV monitor is configured. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Trofscode 
        Code expected when the server is under maintenance. 
    .PARAMETER Trofsstring 
        String expected from the server for the service to be marked as trofs. Applicable to HTTP-ECV/TCP-ECV monitors. 
    .PARAMETER Sslprofile 
        SSL Profile associated with the monitor. 
    .PARAMETER Mqttclientidentifier 
        Client id to be used in Connect command. 
    .PARAMETER Mqttversion 
        Version of MQTT protocol used in connect message, default is version 3.1.1 [4]. 
    .PARAMETER PassThru 
        Return details about the created lbmonitor item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLbmonitor -monitorname <string> -type <string>
        An example how to update lbmonitor configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLbmonitor
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor/
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
        [string]$Monitorname,

        [Parameter(Mandatory)]
        [ValidateSet('PING', 'TCP', 'HTTP', 'TCP-ECV', 'HTTP-ECV', 'UDP-ECV', 'DNS', 'FTP', 'LDNS-PING', 'LDNS-TCP', 'LDNS-DNS', 'RADIUS', 'USER', 'HTTP-INLINE', 'SIP-UDP', 'SIP-TCP', 'LOAD', 'FTP-EXTENDED', 'SMTP', 'SNMP', 'NNTP', 'MYSQL', 'MYSQL-ECV', 'MSSQL-ECV', 'ORACLE-ECV', 'LDAP', 'POP3', 'CITRIX-XML-SERVICE', 'CITRIX-WEB-INTERFACE', 'DNS-TCP', 'RTSP', 'ARP', 'CITRIX-AG', 'CITRIX-AAC-LOGINPAGE', 'CITRIX-AAC-LAS', 'CITRIX-XD-DDC', 'ND6', 'CITRIX-WI-EXTENDED', 'DIAMETER', 'RADIUS_ACCOUNTING', 'STOREFRONT', 'APPC', 'SMPP', 'CITRIX-XNC-ECV', 'CITRIX-XDM', 'CITRIX-STA-SERVICE', 'CITRIX-STA-SERVICE-NHOP', 'MQTT', 'HTTP2')]
        [string]$Type,

        [ValidateSet('NONE', 'LOG', 'DOWN')]
        [string]$Action,

        [string[]]$Respcode,

        [string]$Httprequest,

        [string]$Rtsprequest,

        [string]$Customheaders,

        [ValidateRange(0, 255)]
        [double]$Maxforwards,

        [ValidateSet('OPTIONS', 'INVITE', 'REGISTER')]
        [string]$Sipmethod,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sipreguri,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sipuri,

        [string]$Send,

        [string]$Recv,

        [string]$Query,

        [ValidateSet('Address', 'Zone', 'AAAA')]
        [string]$Querytype,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [string]$Secondarypassword,

        [string]$Logonpointname,

        [string]$Lasversion,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Radkey,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Radnasid,

        [string]$Radnasip,

        [ValidateRange(0, 15)]
        [double]$Radaccounttype,

        [string]$Radframedip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Radapn,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Radmsisdn,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Radaccountsession,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Lrtm,

        [ValidateRange(0, 20939)]
        [double]$Deviation,

        [ValidateSet('SEC', 'MSEC', 'MIN')]
        [string]$Units1,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Scriptname,

        [string]$Scriptargs,

        [string]$Secureargs,

        [ValidateSet('YES', 'NO')]
        [string]$Validatecred,

        [string]$Domain,

        [string]$Dispatcherip,

        [int]$Dispatcherport,

        [ValidateRange(1, 20940)]
        [int]$Interval,

        [ValidateSet('SEC', 'MSEC', 'MIN')]
        [string]$Units3,

        [ValidateRange(1, 20939)]
        [int]$Resptimeout,

        [ValidateSet('SEC', 'MSEC', 'MIN')]
        [string]$Units4,

        [ValidateRange(0, 100)]
        [double]$Resptimeoutthresh,

        [ValidateRange(1, 127)]
        [int]$Retries,

        [ValidateRange(0, 32)]
        [int]$Failureretries,

        [ValidateRange(0, 32)]
        [int]$Alertretries,

        [ValidateRange(1, 32)]
        [int]$Successretries,

        [ValidateRange(1, 20939)]
        [int]$Downtime,

        [ValidateSet('SEC', 'MSEC', 'MIN')]
        [string]$Units2,

        [string]$Destip,

        [int]$Destport,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [ValidateSet('YES', 'NO')]
        [string]$Reverse,

        [ValidateSet('YES', 'NO')]
        [string]$Transparent,

        [ValidateSet('YES', 'NO')]
        [string]$Iptunnel,

        [ValidateSet('YES', 'NO')]
        [string]$Tos,

        [ValidateRange(1, 63)]
        [double]$Tosid,

        [ValidateSet('YES', 'NO')]
        [string]$Secure,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Ipaddress,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Group,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Filename,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Basedn,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Binddn,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Filter,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Attribute,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Database,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Oraclesid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sqlquery,

        [string]$Evalrule,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Snmpoid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Snmpcommunity,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Snmpthreshold,

        [ValidateSet('V1', 'V2')]
        [string]$Snmpversion,

        [ValidateLength(1, 99)]
        [string]$Metrictable,

        [ValidateLength(1, 37)]
        [string]$Metric,

        [double]$Metricthreshold,

        [ValidateRange(1, 100)]
        [double]$Metricweight,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Application,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sitepath,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Storename,

        [ValidateSet('YES', 'NO')]
        [string]$Storefrontacctservice,

        [ValidateSet('YES', 'NO')]
        [string]$Storefrontcheckbackendservices,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Hostname,

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateSet('70', '2000', '2000SP1', '2005', '2008', '2008R2', '2012', '2014')]
        [string]$Mssqlprotocolversion,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Originhost,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Originrealm,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Hostipaddress,

        [double]$Vendorid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Productname,

        [double]$Firmwarerevision,

        [ValidateRange(0, 4294967295)]
        [double[]]$Authapplicationid,

        [ValidateRange(0, 4294967295)]
        [double[]]$Acctapplicationid,

        [ValidateSet('NO_INBAND_SECURITY', 'TLS')]
        [string]$Inbandsecurityid,

        [ValidateRange(1, 4294967295)]
        [double[]]$Supportedvendorids,

        [double]$Vendorspecificvendorid,

        [ValidateRange(0, 4294967295)]
        [double[]]$Vendorspecificauthapplicationids,

        [ValidateRange(0, 4294967295)]
        [double[]]$Vendorspecificacctapplicationids,

        [ValidateLength(1, 32)]
        [string]$Kcdaccount,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Storedb,

        [double]$Trofscode,

        [string]$Trofsstring,

        [ValidateLength(1, 127)]
        [string]$Sslprofile,

        [string]$Mqttclientidentifier,

        [double]$Mqttversion,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLbmonitor: Starting"
    }
    process {
        try {
            $payload = @{ monitorname = $monitorname
                type                  = $type
            }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('respcode') ) { $payload.Add('respcode', $respcode) }
            if ( $PSBoundParameters.ContainsKey('httprequest') ) { $payload.Add('httprequest', $httprequest) }
            if ( $PSBoundParameters.ContainsKey('rtsprequest') ) { $payload.Add('rtsprequest', $rtsprequest) }
            if ( $PSBoundParameters.ContainsKey('customheaders') ) { $payload.Add('customheaders', $customheaders) }
            if ( $PSBoundParameters.ContainsKey('maxforwards') ) { $payload.Add('maxforwards', $maxforwards) }
            if ( $PSBoundParameters.ContainsKey('sipmethod') ) { $payload.Add('sipmethod', $sipmethod) }
            if ( $PSBoundParameters.ContainsKey('sipreguri') ) { $payload.Add('sipreguri', $sipreguri) }
            if ( $PSBoundParameters.ContainsKey('sipuri') ) { $payload.Add('sipuri', $sipuri) }
            if ( $PSBoundParameters.ContainsKey('send') ) { $payload.Add('send', $send) }
            if ( $PSBoundParameters.ContainsKey('recv') ) { $payload.Add('recv', $recv) }
            if ( $PSBoundParameters.ContainsKey('query') ) { $payload.Add('query', $query) }
            if ( $PSBoundParameters.ContainsKey('querytype') ) { $payload.Add('querytype', $querytype) }
            if ( $PSBoundParameters.ContainsKey('username') ) { $payload.Add('username', $username) }
            if ( $PSBoundParameters.ContainsKey('password') ) { $payload.Add('password', $password) }
            if ( $PSBoundParameters.ContainsKey('secondarypassword') ) { $payload.Add('secondarypassword', $secondarypassword) }
            if ( $PSBoundParameters.ContainsKey('logonpointname') ) { $payload.Add('logonpointname', $logonpointname) }
            if ( $PSBoundParameters.ContainsKey('lasversion') ) { $payload.Add('lasversion', $lasversion) }
            if ( $PSBoundParameters.ContainsKey('radkey') ) { $payload.Add('radkey', $radkey) }
            if ( $PSBoundParameters.ContainsKey('radnasid') ) { $payload.Add('radnasid', $radnasid) }
            if ( $PSBoundParameters.ContainsKey('radnasip') ) { $payload.Add('radnasip', $radnasip) }
            if ( $PSBoundParameters.ContainsKey('radaccounttype') ) { $payload.Add('radaccounttype', $radaccounttype) }
            if ( $PSBoundParameters.ContainsKey('radframedip') ) { $payload.Add('radframedip', $radframedip) }
            if ( $PSBoundParameters.ContainsKey('radapn') ) { $payload.Add('radapn', $radapn) }
            if ( $PSBoundParameters.ContainsKey('radmsisdn') ) { $payload.Add('radmsisdn', $radmsisdn) }
            if ( $PSBoundParameters.ContainsKey('radaccountsession') ) { $payload.Add('radaccountsession', $radaccountsession) }
            if ( $PSBoundParameters.ContainsKey('lrtm') ) { $payload.Add('lrtm', $lrtm) }
            if ( $PSBoundParameters.ContainsKey('deviation') ) { $payload.Add('deviation', $deviation) }
            if ( $PSBoundParameters.ContainsKey('units1') ) { $payload.Add('units1', $units1) }
            if ( $PSBoundParameters.ContainsKey('scriptname') ) { $payload.Add('scriptname', $scriptname) }
            if ( $PSBoundParameters.ContainsKey('scriptargs') ) { $payload.Add('scriptargs', $scriptargs) }
            if ( $PSBoundParameters.ContainsKey('secureargs') ) { $payload.Add('secureargs', $secureargs) }
            if ( $PSBoundParameters.ContainsKey('validatecred') ) { $payload.Add('validatecred', $validatecred) }
            if ( $PSBoundParameters.ContainsKey('domain') ) { $payload.Add('domain', $domain) }
            if ( $PSBoundParameters.ContainsKey('dispatcherip') ) { $payload.Add('dispatcherip', $dispatcherip) }
            if ( $PSBoundParameters.ContainsKey('dispatcherport') ) { $payload.Add('dispatcherport', $dispatcherport) }
            if ( $PSBoundParameters.ContainsKey('interval') ) { $payload.Add('interval', $interval) }
            if ( $PSBoundParameters.ContainsKey('units3') ) { $payload.Add('units3', $units3) }
            if ( $PSBoundParameters.ContainsKey('resptimeout') ) { $payload.Add('resptimeout', $resptimeout) }
            if ( $PSBoundParameters.ContainsKey('units4') ) { $payload.Add('units4', $units4) }
            if ( $PSBoundParameters.ContainsKey('resptimeoutthresh') ) { $payload.Add('resptimeoutthresh', $resptimeoutthresh) }
            if ( $PSBoundParameters.ContainsKey('retries') ) { $payload.Add('retries', $retries) }
            if ( $PSBoundParameters.ContainsKey('failureretries') ) { $payload.Add('failureretries', $failureretries) }
            if ( $PSBoundParameters.ContainsKey('alertretries') ) { $payload.Add('alertretries', $alertretries) }
            if ( $PSBoundParameters.ContainsKey('successretries') ) { $payload.Add('successretries', $successretries) }
            if ( $PSBoundParameters.ContainsKey('downtime') ) { $payload.Add('downtime', $downtime) }
            if ( $PSBoundParameters.ContainsKey('units2') ) { $payload.Add('units2', $units2) }
            if ( $PSBoundParameters.ContainsKey('destip') ) { $payload.Add('destip', $destip) }
            if ( $PSBoundParameters.ContainsKey('destport') ) { $payload.Add('destport', $destport) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('reverse') ) { $payload.Add('reverse', $reverse) }
            if ( $PSBoundParameters.ContainsKey('transparent') ) { $payload.Add('transparent', $transparent) }
            if ( $PSBoundParameters.ContainsKey('iptunnel') ) { $payload.Add('iptunnel', $iptunnel) }
            if ( $PSBoundParameters.ContainsKey('tos') ) { $payload.Add('tos', $tos) }
            if ( $PSBoundParameters.ContainsKey('tosid') ) { $payload.Add('tosid', $tosid) }
            if ( $PSBoundParameters.ContainsKey('secure') ) { $payload.Add('secure', $secure) }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('group') ) { $payload.Add('group', $group) }
            if ( $PSBoundParameters.ContainsKey('filename') ) { $payload.Add('filename', $filename) }
            if ( $PSBoundParameters.ContainsKey('basedn') ) { $payload.Add('basedn', $basedn) }
            if ( $PSBoundParameters.ContainsKey('binddn') ) { $payload.Add('binddn', $binddn) }
            if ( $PSBoundParameters.ContainsKey('filter') ) { $payload.Add('filter', $filter) }
            if ( $PSBoundParameters.ContainsKey('attribute') ) { $payload.Add('attribute', $attribute) }
            if ( $PSBoundParameters.ContainsKey('database') ) { $payload.Add('database', $database) }
            if ( $PSBoundParameters.ContainsKey('oraclesid') ) { $payload.Add('oraclesid', $oraclesid) }
            if ( $PSBoundParameters.ContainsKey('sqlquery') ) { $payload.Add('sqlquery', $sqlquery) }
            if ( $PSBoundParameters.ContainsKey('evalrule') ) { $payload.Add('evalrule', $evalrule) }
            if ( $PSBoundParameters.ContainsKey('Snmpoid') ) { $payload.Add('Snmpoid', $Snmpoid) }
            if ( $PSBoundParameters.ContainsKey('snmpcommunity') ) { $payload.Add('snmpcommunity', $snmpcommunity) }
            if ( $PSBoundParameters.ContainsKey('snmpthreshold') ) { $payload.Add('snmpthreshold', $snmpthreshold) }
            if ( $PSBoundParameters.ContainsKey('snmpversion') ) { $payload.Add('snmpversion', $snmpversion) }
            if ( $PSBoundParameters.ContainsKey('metrictable') ) { $payload.Add('metrictable', $metrictable) }
            if ( $PSBoundParameters.ContainsKey('metric') ) { $payload.Add('metric', $metric) }
            if ( $PSBoundParameters.ContainsKey('metricthreshold') ) { $payload.Add('metricthreshold', $metricthreshold) }
            if ( $PSBoundParameters.ContainsKey('metricweight') ) { $payload.Add('metricweight', $metricweight) }
            if ( $PSBoundParameters.ContainsKey('application') ) { $payload.Add('application', $application) }
            if ( $PSBoundParameters.ContainsKey('sitepath') ) { $payload.Add('sitepath', $sitepath) }
            if ( $PSBoundParameters.ContainsKey('storename') ) { $payload.Add('storename', $storename) }
            if ( $PSBoundParameters.ContainsKey('storefrontacctservice') ) { $payload.Add('storefrontacctservice', $storefrontacctservice) }
            if ( $PSBoundParameters.ContainsKey('storefrontcheckbackendservices') ) { $payload.Add('storefrontcheckbackendservices', $storefrontcheckbackendservices) }
            if ( $PSBoundParameters.ContainsKey('hostname') ) { $payload.Add('hostname', $hostname) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('mssqlprotocolversion') ) { $payload.Add('mssqlprotocolversion', $mssqlprotocolversion) }
            if ( $PSBoundParameters.ContainsKey('originhost') ) { $payload.Add('originhost', $originhost) }
            if ( $PSBoundParameters.ContainsKey('originrealm') ) { $payload.Add('originrealm', $originrealm) }
            if ( $PSBoundParameters.ContainsKey('hostipaddress') ) { $payload.Add('hostipaddress', $hostipaddress) }
            if ( $PSBoundParameters.ContainsKey('vendorid') ) { $payload.Add('vendorid', $vendorid) }
            if ( $PSBoundParameters.ContainsKey('productname') ) { $payload.Add('productname', $productname) }
            if ( $PSBoundParameters.ContainsKey('firmwarerevision') ) { $payload.Add('firmwarerevision', $firmwarerevision) }
            if ( $PSBoundParameters.ContainsKey('authapplicationid') ) { $payload.Add('authapplicationid', $authapplicationid) }
            if ( $PSBoundParameters.ContainsKey('acctapplicationid') ) { $payload.Add('acctapplicationid', $acctapplicationid) }
            if ( $PSBoundParameters.ContainsKey('inbandsecurityid') ) { $payload.Add('inbandsecurityid', $inbandsecurityid) }
            if ( $PSBoundParameters.ContainsKey('supportedvendorids') ) { $payload.Add('supportedvendorids', $supportedvendorids) }
            if ( $PSBoundParameters.ContainsKey('vendorspecificvendorid') ) { $payload.Add('vendorspecificvendorid', $vendorspecificvendorid) }
            if ( $PSBoundParameters.ContainsKey('vendorspecificauthapplicationids') ) { $payload.Add('vendorspecificauthapplicationids', $vendorspecificauthapplicationids) }
            if ( $PSBoundParameters.ContainsKey('vendorspecificacctapplicationids') ) { $payload.Add('vendorspecificacctapplicationids', $vendorspecificacctapplicationids) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('storedb') ) { $payload.Add('storedb', $storedb) }
            if ( $PSBoundParameters.ContainsKey('trofscode') ) { $payload.Add('trofscode', $trofscode) }
            if ( $PSBoundParameters.ContainsKey('trofsstring') ) { $payload.Add('trofsstring', $trofsstring) }
            if ( $PSBoundParameters.ContainsKey('sslprofile') ) { $payload.Add('sslprofile', $sslprofile) }
            if ( $PSBoundParameters.ContainsKey('mqttclientidentifier') ) { $payload.Add('mqttclientidentifier', $mqttclientidentifier) }
            if ( $PSBoundParameters.ContainsKey('mqttversion') ) { $payload.Add('mqttversion', $mqttversion) }
            if ( $PSCmdlet.ShouldProcess("lbmonitor", "Update Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbmonitor -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbmonitor -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateLbmonitor: Finished"
    }
}

function Invoke-ADCUnsetLbmonitor {
    <#
    .SYNOPSIS
        Unset Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for monitor resource.
    .PARAMETER Monitorname 
        Name for the monitor. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my monitor" or 'my monitor'). 
    .PARAMETER Type 
        Type of monitor that you want to create. 
        Possible values = PING, TCP, HTTP, TCP-ECV, HTTP-ECV, UDP-ECV, DNS, FTP, LDNS-PING, LDNS-TCP, LDNS-DNS, RADIUS, USER, HTTP-INLINE, SIP-UDP, SIP-TCP, LOAD, FTP-EXTENDED, SMTP, SNMP, NNTP, MYSQL, MYSQL-ECV, MSSQL-ECV, ORACLE-ECV, LDAP, POP3, CITRIX-XML-SERVICE, CITRIX-WEB-INTERFACE, DNS-TCP, RTSP, ARP, CITRIX-AG, CITRIX-AAC-LOGINPAGE, CITRIX-AAC-LAS, CITRIX-XD-DDC, ND6, CITRIX-WI-EXTENDED, DIAMETER, RADIUS_ACCOUNTING, STOREFRONT, APPC, SMPP, CITRIX-XNC-ECV, CITRIX-XDM, CITRIX-STA-SERVICE, CITRIX-STA-SERVICE-NHOP, MQTT, HTTP2 
    .PARAMETER Ipaddress 
        Set of IP addresses expected in the monitoring response from the DNS server, if the record type is A or AAAA. Applicable to DNS monitors. 
    .PARAMETER Scriptname 
        Path and name of the script to execute. The script must be available on the Citrix ADC, in the /nsconfig/monitors/ directory. 
    .PARAMETER Destport 
        TCP or UDP port to which to send the probe. If the parameter is set to 0, the port number of the service to which the monitor is bound is considered the destination port. For a monitor of type USER, however, the destination port is the port number that is included in the HTTP request sent to the dispatcher. Does not apply to monitors of type PING. 
    .PARAMETER Netprofile 
        Name of the network profile. 
    .PARAMETER Sslprofile 
        SSL Profile associated with the monitor. 
    .PARAMETER Action 
        Action to perform when the response to an inline monitor (a monitor of type HTTP-INLINE) indicates that the service is down. A service monitored by an inline monitor is considered DOWN if the response code is not one of the codes that have been specified for the Response Code parameter. 
        Available settings function as follows: 
        * NONE - Do not take any action. However, the show service command and the show lb monitor command indicate the total number of responses that were checked and the number of consecutive error responses received after the last successful probe. 
        * LOG - Log the event in NSLOG or SYSLOG. 
        * DOWN - Mark the service as being down, and then do not direct any traffic to the service until the configured down time has expired. Persistent connections to the service are terminated as soon as the service is marked as DOWN. Also, log the event in NSLOG or SYSLOG. 
        Possible values = NONE, LOG, DOWN 
    .PARAMETER Respcode 
        Response codes for which to mark the service as UP. For any other response code, the action performed depends on the monitor type. HTTP monitors and RADIUS monitors mark the service as DOWN, while HTTP-INLINE monitors perform the action indicated by the Action parameter. 
    .PARAMETER Httprequest 
        HTTP request to send to the server (for example, "HEAD /file.html"). 
    .PARAMETER Rtsprequest 
        RTSP request to send to the server (for example, "OPTIONS *"). 
    .PARAMETER Customheaders 
        Custom header string to include in the monitoring probes. 
    .PARAMETER Maxforwards 
        Maximum number of hops that the SIP request used for monitoring can traverse to reach the server. Applicable only to monitors of type SIP-UDP. 
    .PARAMETER Sipmethod 
        SIP method to use for the query. Applicable only to monitors of type SIP-UDP. 
        Possible values = OPTIONS, INVITE, REGISTER 
    .PARAMETER Sipreguri 
        SIP user to be registered. Applicable only if the monitor is of type SIP-UDP and the SIP Method parameter is set to REGISTER. 
    .PARAMETER Send 
        String to send to the service. Applicable to TCP-ECV, HTTP-ECV, and UDP-ECV monitors. 
    .PARAMETER Recv 
        String expected from the server for the service to be marked as UP. Applicable to TCP-ECV, HTTP-ECV, and UDP-ECV monitors. 
    .PARAMETER Query 
        Domain name to resolve as part of monitoring the DNS service (for example, example.com). 
    .PARAMETER Querytype 
        Type of DNS record for which to send monitoring queries. Set to Address for querying A records, AAAA for querying AAAA records, and Zone for querying the SOA record. 
        Possible values = Address, Zone, AAAA 
    .PARAMETER Username 
        User name with which to probe the RADIUS, NNTP, FTP, FTP-EXTENDED, MYSQL, MSSQL, POP3, CITRIX-AG, CITRIX-XD-DDC, CITRIX-WI-EXTENDED, CITRIX-XNC or CITRIX-XDM server. 
    .PARAMETER Password 
        Password that is required for logging on to the RADIUS, NNTP, FTP, FTP-EXTENDED, MYSQL, MSSQL, POP3, CITRIX-AG, CITRIX-XD-DDC, CITRIX-WI-EXTENDED, CITRIX-XNC-ECV or CITRIX-XDM server. Used in conjunction with the user name specified for the User Name parameter. 
    .PARAMETER Secondarypassword 
        Secondary password that users might have to provide to log on to the Access Gateway server. Applicable to CITRIX-AG monitors. 
    .PARAMETER Logonpointname 
        Name of the logon point that is configured for the Citrix Access Gateway Advanced Access Control software. Required if you want to monitor the associated login page or Logon Agent. Applicable to CITRIX-AAC-LAS and CITRIX-AAC-LOGINPAGE monitors. 
    .PARAMETER Lasversion 
        Version number of the Citrix Advanced Access Control Logon Agent. Required by the CITRIX-AAC-LAS monitor. 
    .PARAMETER Radkey 
        Authentication key (shared secret text string) for RADIUS clients and servers to exchange. Applicable to monitors of type RADIUS and RADIUS_ACCOUNTING. 
    .PARAMETER Radnasid 
        NAS-Identifier to send in the Access-Request packet. Applicable to monitors of type RADIUS. 
    .PARAMETER Radnasip 
        Network Access Server (NAS) IP address to use as the source IP address when monitoring a RADIUS server. Applicable to monitors of type RADIUS and RADIUS_ACCOUNTING. 
    .PARAMETER Radaccounttype 
        Account Type to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING. 
    .PARAMETER Radframedip 
        Source ip with which the packet will go out . Applicable to monitors of type RADIUS_ACCOUNTING. 
    .PARAMETER Radapn 
        Called Station Id to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING. 
    .PARAMETER Radmsisdn 
        Calling Stations Id to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING. 
    .PARAMETER Radaccountsession 
        Account Session ID to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING. 
    .PARAMETER Lrtm 
        Calculate the least response times for bound services. If this parameter is not enabled, the appliance does not learn the response times of the bound services. Also used for LRTM load balancing. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Deviation 
        Time value added to the learned average response time in dynamic response time monitoring (DRTM). When a deviation is specified, the appliance learns the average response time of bound services and adds the deviation to the average. The final value is then continually adjusted to accommodate response time variations over time. Specified in milliseconds, seconds, or minutes. 
    .PARAMETER Scriptargs 
        String of arguments for the script. The string is copied verbatim into the request. 
    .PARAMETER Secureargs 
        List of arguments for the script which should be secure. 
    .PARAMETER Validatecred 
        Validate the credentials of the Xen Desktop DDC server user. Applicable to monitors of type CITRIX-XD-DDC. 
        Possible values = YES, NO 
    .PARAMETER Domain 
        Domain in which the XenDesktop Desktop Delivery Controller (DDC) servers or Web Interface servers are present. Required by CITRIX-XD-DDC and CITRIX-WI-EXTENDED monitors for logging on to the DDC servers and Web Interface servers, respectively. 
    .PARAMETER Dispatcherip 
        IP address of the dispatcher to which to send the probe. 
    .PARAMETER Dispatcherport 
        Port number on which the dispatcher listens for the monitoring probe. 
    .PARAMETER Interval 
        Time interval between two successive probes. Must be greater than the value of Response Time-out. 
    .PARAMETER Resptimeout 
        Amount of time for which the appliance must wait before it marks a probe as FAILED. Must be less than the value specified for the Interval parameter. 
        Note: For UDP-ECV monitors for which a receive string is not configured, response timeout does not apply. For UDP-ECV monitors with no receive string, probe failure is indicated by an ICMP port unreachable error received from the service. 
    .PARAMETER Resptimeoutthresh 
        Response time threshold, specified as a percentage of the Response Time-out parameter. If the response to a monitor probe has not arrived when the threshold is reached, the appliance generates an SNMP trap called monRespTimeoutAboveThresh. After the response time returns to a value below the threshold, the appliance generates a monRespTimeoutBelowThresh SNMP trap. For the traps to be generated, the "MONITOR-RTO-THRESHOLD" alarm must also be enabled. 
    .PARAMETER Retries 
        Maximum number of probes to send to establish the state of a service for which a monitoring probe failed. 
    .PARAMETER Failureretries 
        Number of retries that must fail, out of the number specified for the Retries parameter, for a service to be marked as DOWN. For example, if the Retries parameter is set to 10 and the Failure Retries parameter is set to 6, out of the ten probes sent, at least six probes must fail if the service is to be marked as DOWN. The default value of 0 means that all the retries must fail if the service is to be marked as DOWN. 
    .PARAMETER Alertretries 
        Number of consecutive probe failures after which the appliance generates an SNMP trap called monProbeFailed. 
    .PARAMETER Successretries 
        Number of consecutive successful probes required to transition a service's state from DOWN to UP. 
    .PARAMETER Downtime 
        Time duration for which to wait before probing a service that has been marked as DOWN. Expressed in milliseconds, seconds, or minutes. 
    .PARAMETER Destip 
        IP address of the service to which to send probes. If the parameter is set to 0, the IP address of the server to which the monitor is bound is considered the destination IP address. 
    .PARAMETER State 
        State of the monitor. The DISABLED setting disables not only the monitor being configured, but all monitors of the same type, until the parameter is set to ENABLED. If the monitor is bound to a service, the state of the monitor is not taken into account when the state of the service is determined. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Reverse 
        Mark a service as DOWN, instead of UP, when probe criteria are satisfied, and as UP instead of DOWN when probe criteria are not satisfied. 
        Possible values = YES, NO 
    .PARAMETER Transparent 
        The monitor is bound to a transparent device such as a firewall or router. The state of a transparent device depends on the responsiveness of the services behind it. If a transparent device is being monitored, a destination IP address must be specified. The probe is sent to the specified IP address by using the MAC address of the transparent device. 
        Possible values = YES, NO 
    .PARAMETER Iptunnel 
        Send the monitoring probe to the service through an IP tunnel. A destination IP address must be specified. 
        Possible values = YES, NO 
    .PARAMETER Tos 
        Probe the service by encoding the destination IP address in the IP TOS (6) bits. 
        Possible values = YES, NO 
    .PARAMETER Tosid 
        The TOS ID of the specified destination IP. Applicable only when the TOS parameter is set. 
    .PARAMETER Secure 
        Use a secure SSL connection when monitoring a service. Applicable only to TCP based monitors. The secure option cannot be used with a CITRIX-AG monitor, because a CITRIX-AG monitor uses a secure connection by default. 
        Possible values = YES, NO 
    .PARAMETER Group 
        Name of a newsgroup available on the NNTP service that is to be monitored. The appliance periodically generates an NNTP query for the name of the newsgroup and evaluates the response. If the newsgroup is found on the server, the service is marked as UP. If the newsgroup does not exist or if the search fails, the service is marked as DOWN. Applicable to NNTP monitors. 
    .PARAMETER Filename 
        Name of a file on the FTP server. The appliance monitors the FTP service by periodically checking the existence of the file on the server. Applicable to FTP-EXTENDED monitors. 
    .PARAMETER Basedn 
        The base distinguished name of the LDAP service, from where the LDAP server can begin the search for the attributes in the monitoring query. Required for LDAP service monitoring. 
    .PARAMETER Binddn 
        The distinguished name with which an LDAP monitor can perform the Bind operation on the LDAP server. Optional. Applicable to LDAP monitors. 
    .PARAMETER Filter 
        Filter criteria for the LDAP query. Optional. 
    .PARAMETER Attribute 
        Attribute to evaluate when the LDAP server responds to the query. Success or failure of the monitoring probe depends on whether the attribute exists in the response. Optional. 
    .PARAMETER Database 
        Name of the database to connect to during authentication. 
    .PARAMETER Oraclesid 
        Name of the service identifier that is used to connect to the Oracle database during authentication. 
    .PARAMETER Sqlquery 
        SQL query for a MYSQL-ECV or MSSQL-ECV monitor. Sent to the database server after the server authenticates the connection. 
    .PARAMETER Snmpoid 
        SNMP OID for SNMP monitors. 
    .PARAMETER Snmpcommunity 
        Community name for SNMP monitors. 
    .PARAMETER Snmpthreshold 
        Threshold for SNMP monitors. 
    .PARAMETER Snmpversion 
        SNMP version to be used for SNMP monitors. 
        Possible values = V1, V2 
    .PARAMETER Metrictable 
        Metric table to which to bind metrics. 
    .PARAMETER Mssqlprotocolversion 
        Version of MSSQL server that is to be monitored. 
        Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
    .PARAMETER Originhost 
        Origin-Host value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER Originrealm 
        Origin-Realm value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER Hostipaddress 
        Host-IP-Address value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. If Host-IP-Address is not specified, the appliance inserts the mapped IP (MIP) address or subnet IP (SNIP) address from which the CER request (the monitoring probe) is sent. 
    .PARAMETER Vendorid 
        Vendor-Id value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER Productname 
        Product-Name value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER Firmwarerevision 
        Firmware-Revision value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER Authapplicationid 
        List of Auth-Application-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring CER message. 
    .PARAMETER Acctapplicationid 
        List of Acct-Application-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring message. 
    .PARAMETER Inbandsecurityid 
        Inband-Security-Id for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
        Possible values = NO_INBAND_SECURITY, TLS 
    .PARAMETER Supportedvendorids 
        List of Supported-Vendor-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum eight of these AVPs are supported in a monitoring message. 
    .PARAMETER Vendorspecificvendorid 
        Vendor-Id to use in the Vendor-Specific-Application-Id grouped attribute-value pair (AVP) in the monitoring CER message. To specify Auth-Application-Id or Acct-Application-Id in Vendor-Specific-Application-Id, use vendorSpecificAuthApplicationIds or vendorSpecificAcctApplicationIds, respectively. Only one Vendor-Id is supported for all the Vendor-Specific-Application-Id AVPs in a CER monitoring message. 
    .PARAMETER Vendorspecificauthapplicationids 
        List of Vendor-Specific-Auth-Application-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring message. The specified value is combined with the value of vendorSpecificVendorId to obtain the Vendor-Specific-Application-Id AVP in the CER monitoring message. 
    .PARAMETER Vendorspecificacctapplicationids 
        List of Vendor-Specific-Acct-Application-Id attribute value pairs (AVPs) to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring message. The specified value is combined with the value of vendorSpecificVendorId to obtain the Vendor-Specific-Application-Id AVP in the CER monitoring message. 
    .PARAMETER Kcdaccount 
        KCD Account used by MSSQL monitor. 
    .PARAMETER Storedb 
        Store the database list populated with the responses to monitor probes. Used in database specific load balancing if MSSQL-ECV/MYSQL-ECV monitor is configured. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Trofscode 
        Code expected when the server is under maintenance. 
    .PARAMETER Trofsstring 
        String expected from the server for the service to be marked as trofs. Applicable to HTTP-ECV/TCP-ECV monitors. 
    .PARAMETER Mqttclientidentifier 
        Client id to be used in Connect command. 
    .PARAMETER Mqttversion 
        Version of MQTT protocol used in connect message, default is version 3.1.1 [4].
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLbmonitor -monitorname <string> -type <string>
        An example how to unset lbmonitor configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLbmonitor
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor
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
        [string]$Monitorname,

        [ValidateSet('PING', 'TCP', 'HTTP', 'TCP-ECV', 'HTTP-ECV', 'UDP-ECV', 'DNS', 'FTP', 'LDNS-PING', 'LDNS-TCP', 'LDNS-DNS', 'RADIUS', 'USER', 'HTTP-INLINE', 'SIP-UDP', 'SIP-TCP', 'LOAD', 'FTP-EXTENDED', 'SMTP', 'SNMP', 'NNTP', 'MYSQL', 'MYSQL-ECV', 'MSSQL-ECV', 'ORACLE-ECV', 'LDAP', 'POP3', 'CITRIX-XML-SERVICE', 'CITRIX-WEB-INTERFACE', 'DNS-TCP', 'RTSP', 'ARP', 'CITRIX-AG', 'CITRIX-AAC-LOGINPAGE', 'CITRIX-AAC-LAS', 'CITRIX-XD-DDC', 'ND6', 'CITRIX-WI-EXTENDED', 'DIAMETER', 'RADIUS_ACCOUNTING', 'STOREFRONT', 'APPC', 'SMPP', 'CITRIX-XNC-ECV', 'CITRIX-XDM', 'CITRIX-STA-SERVICE', 'CITRIX-STA-SERVICE-NHOP', 'MQTT', 'HTTP2')]
        [string]$Type,

        [Boolean]$ipaddress,

        [Boolean]$scriptname,

        [Boolean]$destport,

        [Boolean]$netprofile,

        [Boolean]$sslprofile,

        [Boolean]$action,

        [Boolean]$respcode,

        [Boolean]$httprequest,

        [Boolean]$rtsprequest,

        [Boolean]$customheaders,

        [Boolean]$maxforwards,

        [Boolean]$sipmethod,

        [Boolean]$sipreguri,

        [Boolean]$send,

        [Boolean]$recv,

        [Boolean]$query,

        [Boolean]$querytype,

        [Boolean]$username,

        [Boolean]$password,

        [Boolean]$secondarypassword,

        [Boolean]$logonpointname,

        [Boolean]$lasversion,

        [Boolean]$radkey,

        [Boolean]$radnasid,

        [Boolean]$radnasip,

        [Boolean]$radaccounttype,

        [Boolean]$radframedip,

        [Boolean]$radapn,

        [Boolean]$radmsisdn,

        [Boolean]$radaccountsession,

        [Boolean]$lrtm,

        [Boolean]$deviation,

        [Boolean]$scriptargs,

        [Boolean]$secureargs,

        [Boolean]$validatecred,

        [Boolean]$domain,

        [Boolean]$dispatcherip,

        [Boolean]$dispatcherport,

        [Boolean]$interval,

        [Boolean]$resptimeout,

        [Boolean]$resptimeoutthresh,

        [Boolean]$retries,

        [Boolean]$failureretries,

        [Boolean]$alertretries,

        [Boolean]$successretries,

        [Boolean]$downtime,

        [Boolean]$destip,

        [Boolean]$state,

        [Boolean]$reverse,

        [Boolean]$transparent,

        [Boolean]$iptunnel,

        [Boolean]$tos,

        [Boolean]$tosid,

        [Boolean]$secure,

        [Boolean]$group,

        [Boolean]$filename,

        [Boolean]$basedn,

        [Boolean]$binddn,

        [Boolean]$filter,

        [Boolean]$attribute,

        [Boolean]$database,

        [Boolean]$oraclesid,

        [Boolean]$sqlquery,

        [Boolean]$Snmpoid,

        [Boolean]$snmpcommunity,

        [Boolean]$snmpthreshold,

        [Boolean]$snmpversion,

        [Boolean]$metrictable,

        [Boolean]$mssqlprotocolversion,

        [Boolean]$originhost,

        [Boolean]$originrealm,

        [Boolean]$hostipaddress,

        [Boolean]$vendorid,

        [Boolean]$productname,

        [Boolean]$firmwarerevision,

        [Boolean]$authapplicationid,

        [Boolean]$acctapplicationid,

        [Boolean]$inbandsecurityid,

        [Boolean]$supportedvendorids,

        [Boolean]$vendorspecificvendorid,

        [Boolean]$vendorspecificauthapplicationids,

        [Boolean]$vendorspecificacctapplicationids,

        [Boolean]$kcdaccount,

        [Boolean]$storedb,

        [Boolean]$trofscode,

        [Boolean]$trofsstring,

        [Boolean]$mqttclientidentifier,

        [Boolean]$mqttversion 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLbmonitor: Starting"
    }
    process {
        try {
            $payload = @{ monitorname = $monitorname
                type                  = $type
            }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('scriptname') ) { $payload.Add('scriptname', $scriptname) }
            if ( $PSBoundParameters.ContainsKey('destport') ) { $payload.Add('destport', $destport) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('sslprofile') ) { $payload.Add('sslprofile', $sslprofile) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('respcode') ) { $payload.Add('respcode', $respcode) }
            if ( $PSBoundParameters.ContainsKey('httprequest') ) { $payload.Add('httprequest', $httprequest) }
            if ( $PSBoundParameters.ContainsKey('rtsprequest') ) { $payload.Add('rtsprequest', $rtsprequest) }
            if ( $PSBoundParameters.ContainsKey('customheaders') ) { $payload.Add('customheaders', $customheaders) }
            if ( $PSBoundParameters.ContainsKey('maxforwards') ) { $payload.Add('maxforwards', $maxforwards) }
            if ( $PSBoundParameters.ContainsKey('sipmethod') ) { $payload.Add('sipmethod', $sipmethod) }
            if ( $PSBoundParameters.ContainsKey('sipreguri') ) { $payload.Add('sipreguri', $sipreguri) }
            if ( $PSBoundParameters.ContainsKey('send') ) { $payload.Add('send', $send) }
            if ( $PSBoundParameters.ContainsKey('recv') ) { $payload.Add('recv', $recv) }
            if ( $PSBoundParameters.ContainsKey('query') ) { $payload.Add('query', $query) }
            if ( $PSBoundParameters.ContainsKey('querytype') ) { $payload.Add('querytype', $querytype) }
            if ( $PSBoundParameters.ContainsKey('username') ) { $payload.Add('username', $username) }
            if ( $PSBoundParameters.ContainsKey('password') ) { $payload.Add('password', $password) }
            if ( $PSBoundParameters.ContainsKey('secondarypassword') ) { $payload.Add('secondarypassword', $secondarypassword) }
            if ( $PSBoundParameters.ContainsKey('logonpointname') ) { $payload.Add('logonpointname', $logonpointname) }
            if ( $PSBoundParameters.ContainsKey('lasversion') ) { $payload.Add('lasversion', $lasversion) }
            if ( $PSBoundParameters.ContainsKey('radkey') ) { $payload.Add('radkey', $radkey) }
            if ( $PSBoundParameters.ContainsKey('radnasid') ) { $payload.Add('radnasid', $radnasid) }
            if ( $PSBoundParameters.ContainsKey('radnasip') ) { $payload.Add('radnasip', $radnasip) }
            if ( $PSBoundParameters.ContainsKey('radaccounttype') ) { $payload.Add('radaccounttype', $radaccounttype) }
            if ( $PSBoundParameters.ContainsKey('radframedip') ) { $payload.Add('radframedip', $radframedip) }
            if ( $PSBoundParameters.ContainsKey('radapn') ) { $payload.Add('radapn', $radapn) }
            if ( $PSBoundParameters.ContainsKey('radmsisdn') ) { $payload.Add('radmsisdn', $radmsisdn) }
            if ( $PSBoundParameters.ContainsKey('radaccountsession') ) { $payload.Add('radaccountsession', $radaccountsession) }
            if ( $PSBoundParameters.ContainsKey('lrtm') ) { $payload.Add('lrtm', $lrtm) }
            if ( $PSBoundParameters.ContainsKey('deviation') ) { $payload.Add('deviation', $deviation) }
            if ( $PSBoundParameters.ContainsKey('scriptargs') ) { $payload.Add('scriptargs', $scriptargs) }
            if ( $PSBoundParameters.ContainsKey('secureargs') ) { $payload.Add('secureargs', $secureargs) }
            if ( $PSBoundParameters.ContainsKey('validatecred') ) { $payload.Add('validatecred', $validatecred) }
            if ( $PSBoundParameters.ContainsKey('domain') ) { $payload.Add('domain', $domain) }
            if ( $PSBoundParameters.ContainsKey('dispatcherip') ) { $payload.Add('dispatcherip', $dispatcherip) }
            if ( $PSBoundParameters.ContainsKey('dispatcherport') ) { $payload.Add('dispatcherport', $dispatcherport) }
            if ( $PSBoundParameters.ContainsKey('interval') ) { $payload.Add('interval', $interval) }
            if ( $PSBoundParameters.ContainsKey('resptimeout') ) { $payload.Add('resptimeout', $resptimeout) }
            if ( $PSBoundParameters.ContainsKey('resptimeoutthresh') ) { $payload.Add('resptimeoutthresh', $resptimeoutthresh) }
            if ( $PSBoundParameters.ContainsKey('retries') ) { $payload.Add('retries', $retries) }
            if ( $PSBoundParameters.ContainsKey('failureretries') ) { $payload.Add('failureretries', $failureretries) }
            if ( $PSBoundParameters.ContainsKey('alertretries') ) { $payload.Add('alertretries', $alertretries) }
            if ( $PSBoundParameters.ContainsKey('successretries') ) { $payload.Add('successretries', $successretries) }
            if ( $PSBoundParameters.ContainsKey('downtime') ) { $payload.Add('downtime', $downtime) }
            if ( $PSBoundParameters.ContainsKey('destip') ) { $payload.Add('destip', $destip) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('reverse') ) { $payload.Add('reverse', $reverse) }
            if ( $PSBoundParameters.ContainsKey('transparent') ) { $payload.Add('transparent', $transparent) }
            if ( $PSBoundParameters.ContainsKey('iptunnel') ) { $payload.Add('iptunnel', $iptunnel) }
            if ( $PSBoundParameters.ContainsKey('tos') ) { $payload.Add('tos', $tos) }
            if ( $PSBoundParameters.ContainsKey('tosid') ) { $payload.Add('tosid', $tosid) }
            if ( $PSBoundParameters.ContainsKey('secure') ) { $payload.Add('secure', $secure) }
            if ( $PSBoundParameters.ContainsKey('group') ) { $payload.Add('group', $group) }
            if ( $PSBoundParameters.ContainsKey('filename') ) { $payload.Add('filename', $filename) }
            if ( $PSBoundParameters.ContainsKey('basedn') ) { $payload.Add('basedn', $basedn) }
            if ( $PSBoundParameters.ContainsKey('binddn') ) { $payload.Add('binddn', $binddn) }
            if ( $PSBoundParameters.ContainsKey('filter') ) { $payload.Add('filter', $filter) }
            if ( $PSBoundParameters.ContainsKey('attribute') ) { $payload.Add('attribute', $attribute) }
            if ( $PSBoundParameters.ContainsKey('database') ) { $payload.Add('database', $database) }
            if ( $PSBoundParameters.ContainsKey('oraclesid') ) { $payload.Add('oraclesid', $oraclesid) }
            if ( $PSBoundParameters.ContainsKey('sqlquery') ) { $payload.Add('sqlquery', $sqlquery) }
            if ( $PSBoundParameters.ContainsKey('Snmpoid') ) { $payload.Add('Snmpoid', $Snmpoid) }
            if ( $PSBoundParameters.ContainsKey('snmpcommunity') ) { $payload.Add('snmpcommunity', $snmpcommunity) }
            if ( $PSBoundParameters.ContainsKey('snmpthreshold') ) { $payload.Add('snmpthreshold', $snmpthreshold) }
            if ( $PSBoundParameters.ContainsKey('snmpversion') ) { $payload.Add('snmpversion', $snmpversion) }
            if ( $PSBoundParameters.ContainsKey('metrictable') ) { $payload.Add('metrictable', $metrictable) }
            if ( $PSBoundParameters.ContainsKey('mssqlprotocolversion') ) { $payload.Add('mssqlprotocolversion', $mssqlprotocolversion) }
            if ( $PSBoundParameters.ContainsKey('originhost') ) { $payload.Add('originhost', $originhost) }
            if ( $PSBoundParameters.ContainsKey('originrealm') ) { $payload.Add('originrealm', $originrealm) }
            if ( $PSBoundParameters.ContainsKey('hostipaddress') ) { $payload.Add('hostipaddress', $hostipaddress) }
            if ( $PSBoundParameters.ContainsKey('vendorid') ) { $payload.Add('vendorid', $vendorid) }
            if ( $PSBoundParameters.ContainsKey('productname') ) { $payload.Add('productname', $productname) }
            if ( $PSBoundParameters.ContainsKey('firmwarerevision') ) { $payload.Add('firmwarerevision', $firmwarerevision) }
            if ( $PSBoundParameters.ContainsKey('authapplicationid') ) { $payload.Add('authapplicationid', $authapplicationid) }
            if ( $PSBoundParameters.ContainsKey('acctapplicationid') ) { $payload.Add('acctapplicationid', $acctapplicationid) }
            if ( $PSBoundParameters.ContainsKey('inbandsecurityid') ) { $payload.Add('inbandsecurityid', $inbandsecurityid) }
            if ( $PSBoundParameters.ContainsKey('supportedvendorids') ) { $payload.Add('supportedvendorids', $supportedvendorids) }
            if ( $PSBoundParameters.ContainsKey('vendorspecificvendorid') ) { $payload.Add('vendorspecificvendorid', $vendorspecificvendorid) }
            if ( $PSBoundParameters.ContainsKey('vendorspecificauthapplicationids') ) { $payload.Add('vendorspecificauthapplicationids', $vendorspecificauthapplicationids) }
            if ( $PSBoundParameters.ContainsKey('vendorspecificacctapplicationids') ) { $payload.Add('vendorspecificacctapplicationids', $vendorspecificacctapplicationids) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('storedb') ) { $payload.Add('storedb', $storedb) }
            if ( $PSBoundParameters.ContainsKey('trofscode') ) { $payload.Add('trofscode', $trofscode) }
            if ( $PSBoundParameters.ContainsKey('trofsstring') ) { $payload.Add('trofsstring', $trofsstring) }
            if ( $PSBoundParameters.ContainsKey('mqttclientidentifier') ) { $payload.Add('mqttclientidentifier', $mqttclientidentifier) }
            if ( $PSBoundParameters.ContainsKey('mqttversion') ) { $payload.Add('mqttversion', $mqttversion) }
            if ( $PSCmdlet.ShouldProcess("$monitorname type", "Unset Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbmonitor -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLbmonitor: Finished"
    }
}

function Invoke-ADCEnableLbmonitor {
    <#
    .SYNOPSIS
        Enable Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for monitor resource.
    .PARAMETER Servicename 
        The name of the service to which the monitor is bound. 
    .PARAMETER Servicegroupname 
        The name of the service group to which the monitor is to be bound. 
    .PARAMETER Monitorname 
        Name for the monitor. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my monitor" or 'my monitor').
    .EXAMPLE
        PS C:\>Invoke-ADCEnableLbmonitor 
        An example how to enable lbmonitor configuration Object(s).
    .NOTES
        File Name : Invoke-ADCEnableLbmonitor
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor/
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
        [string]$Servicename,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servicegroupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Monitorname 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableLbmonitor: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('servicename') ) { $payload.Add('servicename', $servicename) }
            if ( $PSBoundParameters.ContainsKey('servicegroupname') ) { $payload.Add('servicegroupname', $servicegroupname) }
            if ( $PSBoundParameters.ContainsKey('monitorname') ) { $payload.Add('monitorname', $monitorname) }
            if ( $PSCmdlet.ShouldProcess($Name, "Enable Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lbmonitor -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCEnableLbmonitor: Finished"
    }
}

function Invoke-ADCDisableLbmonitor {
    <#
    .SYNOPSIS
        Disable Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for monitor resource.
    .PARAMETER Servicename 
        The name of the service to which the monitor is bound. 
    .PARAMETER Servicegroupname 
        The name of the service group to which the monitor is to be bound. 
    .PARAMETER Monitorname 
        Name for the monitor. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my monitor" or 'my monitor').
    .EXAMPLE
        PS C:\>Invoke-ADCDisableLbmonitor 
        An example how to disable lbmonitor configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDisableLbmonitor
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor/
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
        [string]$Servicename,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servicegroupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Monitorname 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableLbmonitor: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('servicename') ) { $payload.Add('servicename', $servicename) }
            if ( $PSBoundParameters.ContainsKey('servicegroupname') ) { $payload.Add('servicegroupname', $servicegroupname) }
            if ( $PSBoundParameters.ContainsKey('monitorname') ) { $payload.Add('monitorname', $monitorname) }
            if ( $PSCmdlet.ShouldProcess($Name, "Disable Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lbmonitor -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCDisableLbmonitor: Finished"
    }
}

function Invoke-ADCGetLbmonitor {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for monitor resource.
    .PARAMETER Monitorname 
        Name for the monitor. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my monitor" or 'my monitor'). 
    .PARAMETER GetAll 
        Retrieve all lbmonitor object(s).
    .PARAMETER Count
        If specified, the count of the lbmonitor object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonitor
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmonitor -GetAll 
        Get all lbmonitor data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmonitor -Count 
        Get the number of lbmonitor objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonitor -name <string>
        Get lbmonitor object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonitor -Filter @{ 'name'='<value>' }
        Get lbmonitor data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbmonitor
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor/
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
        [string]$Monitorname,

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
        Write-Verbose "Invoke-ADCGetLbmonitor: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lbmonitor objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmonitor objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmonitor objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmonitor configuration for property 'monitorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor -NitroPath nitro/v1/config -Resource $monitorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmonitor configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbmonitor: Ended"
    }
}

function Invoke-ADCGetLbmonitorbinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to lbmonitor.
    .PARAMETER Monitorname 
        Name of the monitor. 
    .PARAMETER GetAll 
        Retrieve all lbmonitor_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbmonitor_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonitorbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmonitorbinding -GetAll 
        Get all lbmonitor_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonitorbinding -name <string>
        Get lbmonitor_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonitorbinding -Filter @{ 'name'='<value>' }
        Get lbmonitor_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbmonitorbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_binding/
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
        [string]$Monitorname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbmonitorbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmonitor_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmonitor_binding configuration for property 'monitorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_binding -NitroPath nitro/v1/config -Resource $monitorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmonitor_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbmonitorbinding: Ended"
    }
}

function Invoke-ADCAddLbmonitormetricbinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the metric that can be bound to lbmonitor.
    .PARAMETER Monitorname 
        Name of the monitor. 
    .PARAMETER Metric 
        Metric name in the metric table, whose setting is changed. A value zero disables the metric and it will not be used for load calculation. 
    .PARAMETER Metricthreshold 
        Threshold to be used for that metric. 
    .PARAMETER Metricweight 
        The weight for the specified service metric with respect to others. 
    .PARAMETER PassThru 
        Return details about the created lbmonitor_metric_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbmonitormetricbinding -monitorname <string>
        An example how to add lbmonitor_metric_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbmonitormetricbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_metric_binding/
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
        [string]$Monitorname,

        [ValidateLength(1, 37)]
        [string]$Metric,

        [double]$Metricthreshold,

        [ValidateRange(1, 100)]
        [double]$Metricweight,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbmonitormetricbinding: Starting"
    }
    process {
        try {
            $payload = @{ monitorname = $monitorname }
            if ( $PSBoundParameters.ContainsKey('metric') ) { $payload.Add('metric', $metric) }
            if ( $PSBoundParameters.ContainsKey('metricthreshold') ) { $payload.Add('metricthreshold', $metricthreshold) }
            if ( $PSBoundParameters.ContainsKey('metricweight') ) { $payload.Add('metricweight', $metricweight) }
            if ( $PSCmdlet.ShouldProcess("lbmonitor_metric_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbmonitor_metric_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbmonitormetricbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbmonitormetricbinding: Finished"
    }
}

function Invoke-ADCDeleteLbmonitormetricbinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the metric that can be bound to lbmonitor.
    .PARAMETER Monitorname 
        Name of the monitor. 
    .PARAMETER Metric 
        Metric name in the metric table, whose setting is changed. A value zero disables the metric and it will not be used for load calculation.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbmonitormetricbinding -Monitorname <string>
        An example how to delete lbmonitor_metric_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbmonitormetricbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_metric_binding/
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
        [string]$Monitorname,

        [string]$Metric 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbmonitormetricbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Metric') ) { $arguments.Add('metric', $Metric) }
            if ( $PSCmdlet.ShouldProcess("$monitorname", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbmonitor_metric_binding -NitroPath nitro/v1/config -Resource $monitorname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbmonitormetricbinding: Finished"
    }
}

function Invoke-ADCGetLbmonitormetricbinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the metric that can be bound to lbmonitor.
    .PARAMETER Monitorname 
        Name of the monitor. 
    .PARAMETER GetAll 
        Retrieve all lbmonitor_metric_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbmonitor_metric_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonitormetricbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmonitormetricbinding -GetAll 
        Get all lbmonitor_metric_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmonitormetricbinding -Count 
        Get the number of lbmonitor_metric_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonitormetricbinding -name <string>
        Get lbmonitor_metric_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonitormetricbinding -Filter @{ 'name'='<value>' }
        Get lbmonitor_metric_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbmonitormetricbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_metric_binding/
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
        [string]$Monitorname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbmonitormetricbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbmonitor_metric_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_metric_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmonitor_metric_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_metric_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmonitor_metric_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_metric_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmonitor_metric_binding configuration for property 'monitorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_metric_binding -NitroPath nitro/v1/config -Resource $monitorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmonitor_metric_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_metric_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbmonitormetricbinding: Ended"
    }
}

function Invoke-ADCAddLbmonitorservicegroupbinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the servicegroup that can be bound to lbmonitor.
    .PARAMETER Monitorname 
        Name of the monitor. 
    .PARAMETER Servicename 
        Name of the service or service group. 
    .PARAMETER Dup_state 
        State of the monitor. The state setting for a monitor of a given type affects all monitors of that type. For example, if an HTTP monitor is enabled, all HTTP monitors on the appliance are (or remain) enabled. If an HTTP monitor is disabled, all HTTP monitors on the appliance are disabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dup_weight 
        Weight to assign to the binding between the monitor and service. 
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER State 
        State of the monitor. The state setting for a monitor of a given type affects all monitors of that type. For example, if an HTTP monitor is enabled, all HTTP monitors on the appliance are (or remain) enabled. If an HTTP monitor is disabled, all HTTP monitors on the appliance are disabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Weight 
        Weight to assign to the binding between the monitor and service.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbmonitorservicegroupbinding -monitorname <string>
        An example how to add lbmonitor_servicegroup_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbmonitorservicegroupbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_servicegroup_binding/
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
        [string]$Monitorname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servicename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dup_state = 'ENABLED',

        [ValidateRange(1, 100)]
        [double]$Dup_weight = '1',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servicegroupname,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateRange(1, 100)]
        [double]$Weight 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbmonitorservicegroupbinding: Starting"
    }
    process {
        try {
            $payload = @{ monitorname = $monitorname }
            if ( $PSBoundParameters.ContainsKey('servicename') ) { $payload.Add('servicename', $servicename) }
            if ( $PSBoundParameters.ContainsKey('dup_state') ) { $payload.Add('dup_state', $dup_state) }
            if ( $PSBoundParameters.ContainsKey('dup_weight') ) { $payload.Add('dup_weight', $dup_weight) }
            if ( $PSBoundParameters.ContainsKey('servicegroupname') ) { $payload.Add('servicegroupname', $servicegroupname) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSCmdlet.ShouldProcess("lbmonitor_servicegroup_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbmonitor_servicegroup_binding -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCAddLbmonitorservicegroupbinding: Finished"
    }
}

function Invoke-ADCDeleteLbmonitorservicegroupbinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the servicegroup that can be bound to lbmonitor.
    .PARAMETER Monitorname 
        Name of the monitor. 
    .PARAMETER Servicename 
        Name of the service or service group. 
    .PARAMETER Servicegroupname 
        Name of the service group.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbmonitorservicegroupbinding -Monitorname <string>
        An example how to delete lbmonitor_servicegroup_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbmonitorservicegroupbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_servicegroup_binding/
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
        [string]$Monitorname,

        [string]$Servicename,

        [string]$Servicegroupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbmonitorservicegroupbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Servicename') ) { $arguments.Add('servicename', $Servicename) }
            if ( $PSBoundParameters.ContainsKey('Servicegroupname') ) { $arguments.Add('servicegroupname', $Servicegroupname) }
            if ( $PSCmdlet.ShouldProcess("$monitorname", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbmonitor_servicegroup_binding -NitroPath nitro/v1/config -Resource $monitorname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbmonitorservicegroupbinding: Finished"
    }
}

function Invoke-ADCAddLbmonitorservicebinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the service that can be bound to lbmonitor.
    .PARAMETER Monitorname 
        Name of the monitor. 
    .PARAMETER Servicename 
        Name of the service or service group. 
    .PARAMETER Dup_state 
        State of the monitor. The state setting for a monitor of a given type affects all monitors of that type. For example, if an HTTP monitor is enabled, all HTTP monitors on the appliance are (or remain) enabled. If an HTTP monitor is disabled, all HTTP monitors on the appliance are disabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dup_weight 
        Weight to assign to the binding between the monitor and service. 
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER State 
        State of the monitor. The state setting for a monitor of a given type affects all monitors of that type. For example, if an HTTP monitor is enabled, all HTTP monitors on the appliance are (or remain) enabled. If an HTTP monitor is disabled, all HTTP monitors on the appliance are disabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Weight 
        Weight to assign to the binding between the monitor and service.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbmonitorservicebinding -monitorname <string>
        An example how to add lbmonitor_service_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbmonitorservicebinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_service_binding/
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
        [string]$Monitorname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servicename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dup_state = 'ENABLED',

        [ValidateRange(1, 100)]
        [double]$Dup_weight = '1',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servicegroupname,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateRange(1, 100)]
        [double]$Weight 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbmonitorservicebinding: Starting"
    }
    process {
        try {
            $payload = @{ monitorname = $monitorname }
            if ( $PSBoundParameters.ContainsKey('servicename') ) { $payload.Add('servicename', $servicename) }
            if ( $PSBoundParameters.ContainsKey('dup_state') ) { $payload.Add('dup_state', $dup_state) }
            if ( $PSBoundParameters.ContainsKey('dup_weight') ) { $payload.Add('dup_weight', $dup_weight) }
            if ( $PSBoundParameters.ContainsKey('servicegroupname') ) { $payload.Add('servicegroupname', $servicegroupname) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSCmdlet.ShouldProcess("lbmonitor_service_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbmonitor_service_binding -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCAddLbmonitorservicebinding: Finished"
    }
}

function Invoke-ADCDeleteLbmonitorservicebinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the service that can be bound to lbmonitor.
    .PARAMETER Monitorname 
        Name of the monitor. 
    .PARAMETER Servicename 
        Name of the service or service group. 
    .PARAMETER Servicegroupname 
        Name of the service group.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbmonitorservicebinding -Monitorname <string>
        An example how to delete lbmonitor_service_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbmonitorservicebinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_service_binding/
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
        [string]$Monitorname,

        [string]$Servicename,

        [string]$Servicegroupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbmonitorservicebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Servicename') ) { $arguments.Add('servicename', $Servicename) }
            if ( $PSBoundParameters.ContainsKey('Servicegroupname') ) { $arguments.Add('servicegroupname', $Servicegroupname) }
            if ( $PSCmdlet.ShouldProcess("$monitorname", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbmonitor_service_binding -NitroPath nitro/v1/config -Resource $monitorname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbmonitorservicebinding: Finished"
    }
}

function Invoke-ADCAddLbmonitorsslcertkeybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the sslcertkey that can be bound to lbmonitor.
    .PARAMETER Monitorname 
        Name of the monitor. 
    .PARAMETER Certkeyname 
        The name of the certificate bound to the monitor. 
    .PARAMETER Ca 
        The rule for use of CRL corresponding to this CA certificate during client authentication. If crlCheck is set to Mandatory, the system will deny all SSL clients if the CRL is missing, expired - NextUpdate date is in the past, or is incomplete with remote CRL refresh enabled. If crlCheck is set to optional, the system will allow SSL clients in the above error cases.However, in any case if the client certificate is revoked in the CRL, the SSL client will be denied access. 
    .PARAMETER Crlcheck 
        The state of the CRL check parameter. (Mandatory/Optional). 
        Possible values = Mandatory, Optional 
    .PARAMETER Ocspcheck 
        The state of the OCSP check parameter. (Mandatory/Optional). 
        Possible values = Mandatory, Optional 
    .PARAMETER PassThru 
        Return details about the created lbmonitor_sslcertkey_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbmonitorsslcertkeybinding -monitorname <string>
        An example how to add lbmonitor_sslcertkey_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbmonitorsslcertkeybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_sslcertkey_binding/
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
        [string]$Monitorname,

        [string]$Certkeyname,

        [boolean]$Ca,

        [ValidateSet('Mandatory', 'Optional')]
        [string]$Crlcheck,

        [ValidateSet('Mandatory', 'Optional')]
        [string]$Ocspcheck,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbmonitorsslcertkeybinding: Starting"
    }
    process {
        try {
            $payload = @{ monitorname = $monitorname }
            if ( $PSBoundParameters.ContainsKey('certkeyname') ) { $payload.Add('certkeyname', $certkeyname) }
            if ( $PSBoundParameters.ContainsKey('ca') ) { $payload.Add('ca', $ca) }
            if ( $PSBoundParameters.ContainsKey('crlcheck') ) { $payload.Add('crlcheck', $crlcheck) }
            if ( $PSBoundParameters.ContainsKey('ocspcheck') ) { $payload.Add('ocspcheck', $ocspcheck) }
            if ( $PSCmdlet.ShouldProcess("lbmonitor_sslcertkey_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbmonitor_sslcertkey_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbmonitorsslcertkeybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbmonitorsslcertkeybinding: Finished"
    }
}

function Invoke-ADCDeleteLbmonitorsslcertkeybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the sslcertkey that can be bound to lbmonitor.
    .PARAMETER Monitorname 
        Name of the monitor. 
    .PARAMETER Certkeyname 
        The name of the certificate bound to the monitor. 
    .PARAMETER Ca 
        The rule for use of CRL corresponding to this CA certificate during client authentication. If crlCheck is set to Mandatory, the system will deny all SSL clients if the CRL is missing, expired - NextUpdate date is in the past, or is incomplete with remote CRL refresh enabled. If crlCheck is set to optional, the system will allow SSL clients in the above error cases.However, in any case if the client certificate is revoked in the CRL, the SSL client will be denied access.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbmonitorsslcertkeybinding -Monitorname <string>
        An example how to delete lbmonitor_sslcertkey_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbmonitorsslcertkeybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_sslcertkey_binding/
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
        [string]$Monitorname,

        [string]$Certkeyname,

        [boolean]$Ca 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbmonitorsslcertkeybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Certkeyname') ) { $arguments.Add('certkeyname', $Certkeyname) }
            if ( $PSBoundParameters.ContainsKey('Ca') ) { $arguments.Add('ca', $Ca) }
            if ( $PSCmdlet.ShouldProcess("$monitorname", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbmonitor_sslcertkey_binding -NitroPath nitro/v1/config -Resource $monitorname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbmonitorsslcertkeybinding: Finished"
    }
}

function Invoke-ADCGetLbmonitorsslcertkeybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the sslcertkey that can be bound to lbmonitor.
    .PARAMETER Monitorname 
        Name of the monitor. 
    .PARAMETER GetAll 
        Retrieve all lbmonitor_sslcertkey_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbmonitor_sslcertkey_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonitorsslcertkeybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmonitorsslcertkeybinding -GetAll 
        Get all lbmonitor_sslcertkey_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbmonitorsslcertkeybinding -Count 
        Get the number of lbmonitor_sslcertkey_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonitorsslcertkeybinding -name <string>
        Get lbmonitor_sslcertkey_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbmonitorsslcertkeybinding -Filter @{ 'name'='<value>' }
        Get lbmonitor_sslcertkey_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbmonitorsslcertkeybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_sslcertkey_binding/
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
        [string]$Monitorname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbmonitorsslcertkeybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbmonitor_sslcertkey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_sslcertkey_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmonitor_sslcertkey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_sslcertkey_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmonitor_sslcertkey_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_sslcertkey_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmonitor_sslcertkey_binding configuration for property 'monitorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_sslcertkey_binding -NitroPath nitro/v1/config -Resource $monitorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmonitor_sslcertkey_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_sslcertkey_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbmonitorsslcertkeybinding: Ended"
    }
}

function Invoke-ADCUpdateLbparameter {
    <#
    .SYNOPSIS
        Update Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for LB parameter resource.
    .PARAMETER Httponlycookieflag 
        Include the HttpOnly attribute in persistence cookies. The HttpOnly attribute limits the scope of a cookie to HTTP requests and helps mitigate the risk of cross-site scripting attacks. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Usesecuredpersistencecookie 
        Encode persistence cookie values using SHA2 hash. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Useencryptedpersistencecookie 
        Encode persistence cookie values using SHA2 hash. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cookiepassphrase 
        Use this parameter to specify the passphrase used to generate secured persistence cookie value. It specifies the passphrase with a maximum of 31 characters. 
    .PARAMETER Consolidatedlconn 
        To find the service with the fewest connections, the virtual server uses the consolidated connection statistics from all the packet engines. The NO setting allows consideration of only the number of connections on the packet engine that received the new connection. 
        Possible values = YES, NO 
    .PARAMETER Useportforhashlb 
        Include the port number of the service when creating a hash for hash based load balancing methods. With the NO setting, only the IP address of the service is considered when creating a hash. 
        Possible values = YES, NO 
    .PARAMETER Preferdirectroute 
        Perform route lookup for traffic received by the Citrix ADC, and forward the traffic according to configured routes. Do not set this parameter if you want a wildcard virtual server to direct packets received by the appliance to an intermediary device, such as a firewall, even if their destination is directly connected to the appliance. Route lookup is performed after the packets have been processed and returned by the intermediary device. 
        Possible values = YES, NO 
    .PARAMETER Startuprrfactor 
        Number of requests, per service, for which to apply the round robin load balancing method before switching to the configured load balancing method, thus allowing services to ramp up gradually to full load. Until the specified number of requests is distributed, the Citrix ADC is said to be implementing the slow start mode (or startup round robin). Implemented for a virtual server when one of the following is true: 
        * The virtual server is newly created. 
        * One or more services are newly bound to the virtual server. 
        * One or more services bound to the virtual server are enabled. 
        * The load balancing method is changed. 
        This parameter applies to all the load balancing virtual servers configured on the Citrix ADC, except for those virtual servers for which the virtual server-level slow start parameters (New Service Startup Request Rate and Increment Interval) are configured. If the global slow start parameter and the slow start parameters for a given virtual server are not set, the appliance implements a default slow start for the virtual server, as follows: 
        * For a newly configured virtual server, the appliance implements slow start for the first 100 requests received by the virtual server. 
        * For an existing virtual server, if one or more services are newly bound or newly enabled, or if the load balancing method is changed, the appliance dynamically computes the number of requests for which to implement startup round robin. It obtains this number by multiplying the request rate by the number of bound services (it includes services that are marked as DOWN). For example, if the current request rate is 20 requests/s and ten services are bound to the virtual server, the appliance performs startup round robin for 200 requests. 
        Not applicable to a virtual server for which a hash based load balancing method is configured. 
    .PARAMETER Monitorskipmaxclient 
        When a monitor initiates a connection to a service, do not check to determine whether the number of connections to the service has reached the limit specified by the service's Max Clients setting. Enables monitoring to continue even if the service has reached its connection limit. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Monitorconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set. 
        Possible values = RESET, FIN 
    .PARAMETER Vserverspecificmac 
        Allow a MAC-mode virtual server to accept traffic returned by an intermediary device, such as a firewall, to which the traffic was previously forwarded by another MAC-mode virtual server. The second virtual server can then distribute that traffic across the destination server farm. Also useful when load balancing Branch Repeater appliances. 
        Note: The second virtual server can also send the traffic to another set of intermediary devices, such as another set of firewalls. If necessary, you can configure multiple MAC-mode virtual servers to pass traffic successively through multiple sets of intermediary devices. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Allowboundsvcremoval 
        This is used, to enable/disable the option of svc/svcgroup removal, if it is bound to one or more vserver. If it is enabled, the svc/svcgroup can be removed, even if it bound to vservers. If disabled, an error will be thrown, when the user tries to remove a svc/svcgroup without unbinding from its vservers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Retainservicestate 
        This option is used to retain the original state of service or servicegroup member when an enable server command is issued. 
        Possible values = ON, OFF 
    .PARAMETER Dbsttl 
        Specify the TTL for DNS record for domain based service. The default value of ttl is 0 which indicates to use the TTL received in DNS response for monitors. 
    .PARAMETER Maxpipelinenat 
        Maximum number of concurrent requests to allow on a single client connection, which is identified by the <clientip:port>-<vserver ip:port> tuple. This parameter is applicable to ANY service type and all UDP service types (except DNS) and only when "svrTimeout" is set to zero. A value of 0 (zero) applies no limit to the number of concurrent requests allowed on a single client connection. 
    .PARAMETER Literaladccookieattribute 
        String configured as LiteralADCCookieAttribute will be appended as attribute for Citrix ADC cookie (for example: LB cookie persistence, GSLB site persistence, CS cookie persistence, LB group cookie persistence). 
        Sample usage - 
        set lb parameter -LiteralADCCookieAttribute ";SameSite=None". 
    .PARAMETER Computedadccookieattribute 
        ComputedADCCookieAttribute accepts ns variable as input in form of string starting with $ (to understand how to configure ns variable, please check man add ns variable). policies can be configured to modify this variable for every transaction and the final value of the variable after policy evaluation will be appended as attribute to Citrix ADC cookie (for example: LB cookie persistence, GSLB sitepersistence, CS cookie persistence, LB group cookie persistence). Only one of ComputedADCCookieAttribute, LiteralADCCookieAttribute can be set. 
        Sample usage - 
        add ns variable lbvar -type TEXT(100) -scope Transaction 
        add ns assignment lbassign -variable $lbvar -set "\\";SameSite=Strict\\"" 
        add rewrite policy lbpol <valid policy expression> lbassign 
        bind rewrite global lbpol 100 next -type RES_OVERRIDE 
        set lb param -ComputedADCCookieAttribute "$lbvar" 
        For incoming client request, if above policy evaluates TRUE, then SameSite=Strict will be appended to ADC generated cookie. 
    .PARAMETER Storemqttclientidandusername 
        This option allows to store the MQTT clientid and username in transactional logs. 
        Possible values = YES, NO 
    .PARAMETER Dropmqttjumbomessage 
        When this option is enabled, MQTT messages of length greater than 64k will be dropped and the client/server connections will be reset. 
        Possible values = YES, NO 
    .PARAMETER Lbhashalgorithm 
        This option dictates the hashing algorithm used for hash based LB methods (URLHASH, DOMAINHASH, SOURCEIPHASH, DESTINATIONIPHASH, SRCIPDESTIPHASH, SRCIPSRCPORTHASH, TOKEN, USER_TOKEN, CALLIDHASH). 
        Possible values = DEFAULT, PRAC, JARH 
    .PARAMETER Lbhashfingers 
        This option is used to specify the number of fingers to be used in PRAC and JARH algorithms for hash based LB methods. Increasing the number of fingers might give better distribution of traffic at the expense of additional memory.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLbparameter 
        An example how to update lbparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLbparameter
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbparameter/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httponlycookieflag,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Usesecuredpersistencecookie,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Useencryptedpersistencecookie,

        [string]$Cookiepassphrase,

        [ValidateSet('YES', 'NO')]
        [string]$Consolidatedlconn,

        [ValidateSet('YES', 'NO')]
        [string]$Useportforhashlb,

        [ValidateSet('YES', 'NO')]
        [string]$Preferdirectroute,

        [double]$Startuprrfactor,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Monitorskipmaxclient,

        [ValidateSet('RESET', 'FIN')]
        [string]$Monitorconnectionclose,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Vserverspecificmac,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Allowboundsvcremoval,

        [ValidateSet('ON', 'OFF')]
        [string]$Retainservicestate,

        [double]$Dbsttl,

        [double]$Maxpipelinenat,

        [string]$Literaladccookieattribute,

        [string]$Computedadccookieattribute,

        [ValidateSet('YES', 'NO')]
        [string]$Storemqttclientidandusername,

        [ValidateSet('YES', 'NO')]
        [string]$Dropmqttjumbomessage,

        [ValidateSet('DEFAULT', 'PRAC', 'JARH')]
        [string]$Lbhashalgorithm,

        [ValidateRange(1, 1024)]
        [double]$Lbhashfingers 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLbparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('httponlycookieflag') ) { $payload.Add('httponlycookieflag', $httponlycookieflag) }
            if ( $PSBoundParameters.ContainsKey('usesecuredpersistencecookie') ) { $payload.Add('usesecuredpersistencecookie', $usesecuredpersistencecookie) }
            if ( $PSBoundParameters.ContainsKey('useencryptedpersistencecookie') ) { $payload.Add('useencryptedpersistencecookie', $useencryptedpersistencecookie) }
            if ( $PSBoundParameters.ContainsKey('cookiepassphrase') ) { $payload.Add('cookiepassphrase', $cookiepassphrase) }
            if ( $PSBoundParameters.ContainsKey('consolidatedlconn') ) { $payload.Add('consolidatedlconn', $consolidatedlconn) }
            if ( $PSBoundParameters.ContainsKey('useportforhashlb') ) { $payload.Add('useportforhashlb', $useportforhashlb) }
            if ( $PSBoundParameters.ContainsKey('preferdirectroute') ) { $payload.Add('preferdirectroute', $preferdirectroute) }
            if ( $PSBoundParameters.ContainsKey('startuprrfactor') ) { $payload.Add('startuprrfactor', $startuprrfactor) }
            if ( $PSBoundParameters.ContainsKey('monitorskipmaxclient') ) { $payload.Add('monitorskipmaxclient', $monitorskipmaxclient) }
            if ( $PSBoundParameters.ContainsKey('monitorconnectionclose') ) { $payload.Add('monitorconnectionclose', $monitorconnectionclose) }
            if ( $PSBoundParameters.ContainsKey('vserverspecificmac') ) { $payload.Add('vserverspecificmac', $vserverspecificmac) }
            if ( $PSBoundParameters.ContainsKey('allowboundsvcremoval') ) { $payload.Add('allowboundsvcremoval', $allowboundsvcremoval) }
            if ( $PSBoundParameters.ContainsKey('retainservicestate') ) { $payload.Add('retainservicestate', $retainservicestate) }
            if ( $PSBoundParameters.ContainsKey('dbsttl') ) { $payload.Add('dbsttl', $dbsttl) }
            if ( $PSBoundParameters.ContainsKey('maxpipelinenat') ) { $payload.Add('maxpipelinenat', $maxpipelinenat) }
            if ( $PSBoundParameters.ContainsKey('literaladccookieattribute') ) { $payload.Add('literaladccookieattribute', $literaladccookieattribute) }
            if ( $PSBoundParameters.ContainsKey('computedadccookieattribute') ) { $payload.Add('computedadccookieattribute', $computedadccookieattribute) }
            if ( $PSBoundParameters.ContainsKey('storemqttclientidandusername') ) { $payload.Add('storemqttclientidandusername', $storemqttclientidandusername) }
            if ( $PSBoundParameters.ContainsKey('dropmqttjumbomessage') ) { $payload.Add('dropmqttjumbomessage', $dropmqttjumbomessage) }
            if ( $PSBoundParameters.ContainsKey('lbhashalgorithm') ) { $payload.Add('lbhashalgorithm', $lbhashalgorithm) }
            if ( $PSBoundParameters.ContainsKey('lbhashfingers') ) { $payload.Add('lbhashfingers', $lbhashfingers) }
            if ( $PSCmdlet.ShouldProcess("lbparameter", "Update Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateLbparameter: Finished"
    }
}

function Invoke-ADCUnsetLbparameter {
    <#
    .SYNOPSIS
        Unset Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for LB parameter resource.
    .PARAMETER Httponlycookieflag 
        Include the HttpOnly attribute in persistence cookies. The HttpOnly attribute limits the scope of a cookie to HTTP requests and helps mitigate the risk of cross-site scripting attacks. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Usesecuredpersistencecookie 
        Encode persistence cookie values using SHA2 hash. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Useencryptedpersistencecookie 
        Encode persistence cookie values using SHA2 hash. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cookiepassphrase 
        Use this parameter to specify the passphrase used to generate secured persistence cookie value. It specifies the passphrase with a maximum of 31 characters. 
    .PARAMETER Consolidatedlconn 
        To find the service with the fewest connections, the virtual server uses the consolidated connection statistics from all the packet engines. The NO setting allows consideration of only the number of connections on the packet engine that received the new connection. 
        Possible values = YES, NO 
    .PARAMETER Useportforhashlb 
        Include the port number of the service when creating a hash for hash based load balancing methods. With the NO setting, only the IP address of the service is considered when creating a hash. 
        Possible values = YES, NO 
    .PARAMETER Preferdirectroute 
        Perform route lookup for traffic received by the Citrix ADC, and forward the traffic according to configured routes. Do not set this parameter if you want a wildcard virtual server to direct packets received by the appliance to an intermediary device, such as a firewall, even if their destination is directly connected to the appliance. Route lookup is performed after the packets have been processed and returned by the intermediary device. 
        Possible values = YES, NO 
    .PARAMETER Startuprrfactor 
        Number of requests, per service, for which to apply the round robin load balancing method before switching to the configured load balancing method, thus allowing services to ramp up gradually to full load. Until the specified number of requests is distributed, the Citrix ADC is said to be implementing the slow start mode (or startup round robin). Implemented for a virtual server when one of the following is true: 
        * The virtual server is newly created. 
        * One or more services are newly bound to the virtual server. 
        * One or more services bound to the virtual server are enabled. 
        * The load balancing method is changed. 
        This parameter applies to all the load balancing virtual servers configured on the Citrix ADC, except for those virtual servers for which the virtual server-level slow start parameters (New Service Startup Request Rate and Increment Interval) are configured. If the global slow start parameter and the slow start parameters for a given virtual server are not set, the appliance implements a default slow start for the virtual server, as follows: 
        * For a newly configured virtual server, the appliance implements slow start for the first 100 requests received by the virtual server. 
        * For an existing virtual server, if one or more services are newly bound or newly enabled, or if the load balancing method is changed, the appliance dynamically computes the number of requests for which to implement startup round robin. It obtains this number by multiplying the request rate by the number of bound services (it includes services that are marked as DOWN). For example, if the current request rate is 20 requests/s and ten services are bound to the virtual server, the appliance performs startup round robin for 200 requests. 
        Not applicable to a virtual server for which a hash based load balancing method is configured. 
    .PARAMETER Monitorskipmaxclient 
        When a monitor initiates a connection to a service, do not check to determine whether the number of connections to the service has reached the limit specified by the service's Max Clients setting. Enables monitoring to continue even if the service has reached its connection limit. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Monitorconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set. 
        Possible values = RESET, FIN 
    .PARAMETER Vserverspecificmac 
        Allow a MAC-mode virtual server to accept traffic returned by an intermediary device, such as a firewall, to which the traffic was previously forwarded by another MAC-mode virtual server. The second virtual server can then distribute that traffic across the destination server farm. Also useful when load balancing Branch Repeater appliances. 
        Note: The second virtual server can also send the traffic to another set of intermediary devices, such as another set of firewalls. If necessary, you can configure multiple MAC-mode virtual servers to pass traffic successively through multiple sets of intermediary devices. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Allowboundsvcremoval 
        This is used, to enable/disable the option of svc/svcgroup removal, if it is bound to one or more vserver. If it is enabled, the svc/svcgroup can be removed, even if it bound to vservers. If disabled, an error will be thrown, when the user tries to remove a svc/svcgroup without unbinding from its vservers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Retainservicestate 
        This option is used to retain the original state of service or servicegroup member when an enable server command is issued. 
        Possible values = ON, OFF 
    .PARAMETER Dbsttl 
        Specify the TTL for DNS record for domain based service. The default value of ttl is 0 which indicates to use the TTL received in DNS response for monitors. 
    .PARAMETER Maxpipelinenat 
        Maximum number of concurrent requests to allow on a single client connection, which is identified by the <clientip:port>-<vserver ip:port> tuple. This parameter is applicable to ANY service type and all UDP service types (except DNS) and only when "svrTimeout" is set to zero. A value of 0 (zero) applies no limit to the number of concurrent requests allowed on a single client connection. 
    .PARAMETER Literaladccookieattribute 
        String configured as LiteralADCCookieAttribute will be appended as attribute for Citrix ADC cookie (for example: LB cookie persistence, GSLB site persistence, CS cookie persistence, LB group cookie persistence). 
        Sample usage - 
        set lb parameter -LiteralADCCookieAttribute ";SameSite=None". 
    .PARAMETER Computedadccookieattribute 
        ComputedADCCookieAttribute accepts ns variable as input in form of string starting with $ (to understand how to configure ns variable, please check man add ns variable). policies can be configured to modify this variable for every transaction and the final value of the variable after policy evaluation will be appended as attribute to Citrix ADC cookie (for example: LB cookie persistence, GSLB sitepersistence, CS cookie persistence, LB group cookie persistence). Only one of ComputedADCCookieAttribute, LiteralADCCookieAttribute can be set. 
        Sample usage - 
        add ns variable lbvar -type TEXT(100) -scope Transaction 
        add ns assignment lbassign -variable $lbvar -set "\\";SameSite=Strict\\"" 
        add rewrite policy lbpol <valid policy expression> lbassign 
        bind rewrite global lbpol 100 next -type RES_OVERRIDE 
        set lb param -ComputedADCCookieAttribute "$lbvar" 
        For incoming client request, if above policy evaluates TRUE, then SameSite=Strict will be appended to ADC generated cookie. 
    .PARAMETER Storemqttclientidandusername 
        This option allows to store the MQTT clientid and username in transactional logs. 
        Possible values = YES, NO 
    .PARAMETER Dropmqttjumbomessage 
        When this option is enabled, MQTT messages of length greater than 64k will be dropped and the client/server connections will be reset. 
        Possible values = YES, NO 
    .PARAMETER Lbhashalgorithm 
        This option dictates the hashing algorithm used for hash based LB methods (URLHASH, DOMAINHASH, SOURCEIPHASH, DESTINATIONIPHASH, SRCIPDESTIPHASH, SRCIPSRCPORTHASH, TOKEN, USER_TOKEN, CALLIDHASH). 
        Possible values = DEFAULT, PRAC, JARH 
    .PARAMETER Lbhashfingers 
        This option is used to specify the number of fingers to be used in PRAC and JARH algorithms for hash based LB methods. Increasing the number of fingers might give better distribution of traffic at the expense of additional memory.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLbparameter 
        An example how to unset lbparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLbparameter
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbparameter
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

        [Boolean]$httponlycookieflag,

        [Boolean]$usesecuredpersistencecookie,

        [Boolean]$useencryptedpersistencecookie,

        [Boolean]$cookiepassphrase,

        [Boolean]$consolidatedlconn,

        [Boolean]$useportforhashlb,

        [Boolean]$preferdirectroute,

        [Boolean]$startuprrfactor,

        [Boolean]$monitorskipmaxclient,

        [Boolean]$monitorconnectionclose,

        [Boolean]$vserverspecificmac,

        [Boolean]$allowboundsvcremoval,

        [Boolean]$retainservicestate,

        [Boolean]$dbsttl,

        [Boolean]$maxpipelinenat,

        [Boolean]$literaladccookieattribute,

        [Boolean]$computedadccookieattribute,

        [Boolean]$storemqttclientidandusername,

        [Boolean]$dropmqttjumbomessage,

        [Boolean]$lbhashalgorithm,

        [Boolean]$lbhashfingers 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLbparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('httponlycookieflag') ) { $payload.Add('httponlycookieflag', $httponlycookieflag) }
            if ( $PSBoundParameters.ContainsKey('usesecuredpersistencecookie') ) { $payload.Add('usesecuredpersistencecookie', $usesecuredpersistencecookie) }
            if ( $PSBoundParameters.ContainsKey('useencryptedpersistencecookie') ) { $payload.Add('useencryptedpersistencecookie', $useencryptedpersistencecookie) }
            if ( $PSBoundParameters.ContainsKey('cookiepassphrase') ) { $payload.Add('cookiepassphrase', $cookiepassphrase) }
            if ( $PSBoundParameters.ContainsKey('consolidatedlconn') ) { $payload.Add('consolidatedlconn', $consolidatedlconn) }
            if ( $PSBoundParameters.ContainsKey('useportforhashlb') ) { $payload.Add('useportforhashlb', $useportforhashlb) }
            if ( $PSBoundParameters.ContainsKey('preferdirectroute') ) { $payload.Add('preferdirectroute', $preferdirectroute) }
            if ( $PSBoundParameters.ContainsKey('startuprrfactor') ) { $payload.Add('startuprrfactor', $startuprrfactor) }
            if ( $PSBoundParameters.ContainsKey('monitorskipmaxclient') ) { $payload.Add('monitorskipmaxclient', $monitorskipmaxclient) }
            if ( $PSBoundParameters.ContainsKey('monitorconnectionclose') ) { $payload.Add('monitorconnectionclose', $monitorconnectionclose) }
            if ( $PSBoundParameters.ContainsKey('vserverspecificmac') ) { $payload.Add('vserverspecificmac', $vserverspecificmac) }
            if ( $PSBoundParameters.ContainsKey('allowboundsvcremoval') ) { $payload.Add('allowboundsvcremoval', $allowboundsvcremoval) }
            if ( $PSBoundParameters.ContainsKey('retainservicestate') ) { $payload.Add('retainservicestate', $retainservicestate) }
            if ( $PSBoundParameters.ContainsKey('dbsttl') ) { $payload.Add('dbsttl', $dbsttl) }
            if ( $PSBoundParameters.ContainsKey('maxpipelinenat') ) { $payload.Add('maxpipelinenat', $maxpipelinenat) }
            if ( $PSBoundParameters.ContainsKey('literaladccookieattribute') ) { $payload.Add('literaladccookieattribute', $literaladccookieattribute) }
            if ( $PSBoundParameters.ContainsKey('computedadccookieattribute') ) { $payload.Add('computedadccookieattribute', $computedadccookieattribute) }
            if ( $PSBoundParameters.ContainsKey('storemqttclientidandusername') ) { $payload.Add('storemqttclientidandusername', $storemqttclientidandusername) }
            if ( $PSBoundParameters.ContainsKey('dropmqttjumbomessage') ) { $payload.Add('dropmqttjumbomessage', $dropmqttjumbomessage) }
            if ( $PSBoundParameters.ContainsKey('lbhashalgorithm') ) { $payload.Add('lbhashalgorithm', $lbhashalgorithm) }
            if ( $PSBoundParameters.ContainsKey('lbhashfingers') ) { $payload.Add('lbhashfingers', $lbhashfingers) }
            if ( $PSCmdlet.ShouldProcess("lbparameter", "Unset Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLbparameter: Finished"
    }
}

function Invoke-ADCGetLbparameter {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for LB parameter resource.
    .PARAMETER GetAll 
        Retrieve all lbparameter object(s).
    .PARAMETER Count
        If specified, the count of the lbparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbparameter -GetAll 
        Get all lbparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbparameter -name <string>
        Get lbparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbparameter -Filter @{ 'name'='<value>' }
        Get lbparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbparameter
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbparameter/
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
        Write-Verbose "Invoke-ADCGetLbparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lbparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving lbparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbparameter: Ended"
    }
}

function Invoke-ADCClearLbpersistentsessions {
    <#
    .SYNOPSIS
        Clear Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for persistence session resource.
    .PARAMETER Vserver 
        The name of the virtual server. 
    .PARAMETER Persistenceparameter 
        The persistence parameter whose persistence sessions are to be flushed.
    .EXAMPLE
        PS C:\>Invoke-ADCClearLbpersistentsessions 
        An example how to clear lbpersistentsessions configuration Object(s).
    .NOTES
        File Name : Invoke-ADCClearLbpersistentsessions
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbpersistentsessions/
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

        [string]$Vserver,

        [string]$Persistenceparameter 

    )
    begin {
        Write-Verbose "Invoke-ADCClearLbpersistentsessions: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSBoundParameters.ContainsKey('persistenceparameter') ) { $payload.Add('persistenceparameter', $persistenceparameter) }
            if ( $PSCmdlet.ShouldProcess($Name, "Clear Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lbpersistentsessions -Action clear -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCClearLbpersistentsessions: Finished"
    }
}

function Invoke-ADCGetLbpersistentsessions {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for persistence session resource.
    .PARAMETER Vserver 
        The name of the virtual server. 
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retrieve all lbpersistentsessions object(s).
    .PARAMETER Count
        If specified, the count of the lbpersistentsessions object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbpersistentsessions
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbpersistentsessions -GetAll 
        Get all lbpersistentsessions data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbpersistentsessions -Count 
        Get the number of lbpersistentsessions objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbpersistentsessions -name <string>
        Get lbpersistentsessions object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbpersistentsessions -Filter @{ 'name'='<value>' }
        Get lbpersistentsessions data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbpersistentsessions
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbpersistentsessions/
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
        [string]$Vserver,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 31)]
        [double]$Nodeid,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetLbpersistentsessions: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lbpersistentsessions objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbpersistentsessions -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbpersistentsessions objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbpersistentsessions -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbpersistentsessions objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('vserver') ) { $arguments.Add('vserver', $vserver) } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbpersistentsessions -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbpersistentsessions configuration for property ''"

            } else {
                Write-Verbose "Retrieving lbpersistentsessions configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbpersistentsessions -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbpersistentsessions: Ended"
    }
}

function Invoke-ADCAddLbprofile {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for LB profile resource.
    .PARAMETER Lbprofilename 
        Name of the LB profile. 
    .PARAMETER Dbslb 
        Enable database specific load balancing for MySQL and MSSQL service types. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Processlocal 
        By turning on this option packets destined to a vserver in a cluster will not under go any steering. Turn this option for single pa 
        cket request response mode or when the upstream device is performing a proper RSS for connection based distribution. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httponlycookieflag 
        Include the HttpOnly attribute in persistence cookies. The HttpOnly attribute limits the scope of a cookie to HTTP requests and helps mitigate the risk of cross-site scripting attacks. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cookiepassphrase 
        Use this parameter to specify the passphrase used to generate secured persistence cookie value. It specifies the passphrase with a maximum of 31 characters. 
    .PARAMETER Usesecuredpersistencecookie 
        Encode persistence cookie values using SHA2 hash. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Useencryptedpersistencecookie 
        Encode persistence cookie values using SHA2 hash. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Literaladccookieattribute 
        String configured as LiteralADCCookieAttribute will be appended as attribute for Citrix ADC cookie (for example: LB cookie persistence, GSLB site persistence, CS cookie persistence, LB group cookie persistence). 
        Sample usage - 
        add lb profile lbprof -LiteralADCCookieAttribute ";SameSite=None". 
    .PARAMETER Computedadccookieattribute 
        ComputedADCCookieAttribute accepts ns variable as input in form of string starting with $ (to understand how to configure ns variable, please check man add ns variable). policies can be configured to modify this variable for every transaction and the final value of the variable after policy evaluation will be appended as attribute to Citrix ADC cookie (for example: LB cookie persistence, GSLB sitepersistence, CS cookie persistence, LB group cookie persistence). Only one of ComputedADCCookieAttribute, LiteralADCCookieAttribute can be set. 
        Sample usage - 
        add ns variable lbvar -type TEXT(100) -scope Transaction 
        add ns assignment lbassign -variable $lbvar -set "\\";SameSite=Strict\\"" 
        add rewrite policy lbpol <valid policy expression> lbassign 
        bind rewrite global lbpol 100 next -type RES_OVERRIDE 
        add lb profile lbprof -ComputedADCCookieAttribute "$lbvar" 
        For incoming client request, if above policy evaluates TRUE, then SameSite=Strict will be appended to ADC generated cookie. 
    .PARAMETER Storemqttclientidandusername 
        This option allows to store the MQTT clientid and username in transactional logs. 
        Possible values = YES, NO 
    .PARAMETER Lbhashalgorithm 
        This option dictates the hashing algorithm used for hash based LB methods (URLHASH, DOMAINHASH, SOURCEIPHASH, DESTINATIONIPHASH, SRCIPDESTIPHASH, SRCIPSRCPORTHASH, TOKEN, USER_TOKEN, CALLIDHASH). 
        Possible values = DEFAULT, PRAC, JARH 
    .PARAMETER Lbhashfingers 
        This option is used to specify the number of fingers to be used in PRAC and JARH algorithms for hash based LB methods. Increasing the number of fingers might give better distribution of traffic at the expense of additional memory. 
    .PARAMETER PassThru 
        Return details about the created lbprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbprofile -lbprofilename <string>
        An example how to add lbprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbprofile/
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
        [string]$Lbprofilename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dbslb = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Processlocal = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httponlycookieflag = 'ENABLED',

        [string]$Cookiepassphrase,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Usesecuredpersistencecookie = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Useencryptedpersistencecookie = 'DISABLED',

        [string]$Literaladccookieattribute,

        [string]$Computedadccookieattribute,

        [ValidateSet('YES', 'NO')]
        [string]$Storemqttclientidandusername = 'NO',

        [ValidateSet('DEFAULT', 'PRAC', 'JARH')]
        [string]$Lbhashalgorithm = 'DEFAULT',

        [ValidateRange(1, 1024)]
        [double]$Lbhashfingers = '256',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbprofile: Starting"
    }
    process {
        try {
            $payload = @{ lbprofilename = $lbprofilename }
            if ( $PSBoundParameters.ContainsKey('dbslb') ) { $payload.Add('dbslb', $dbslb) }
            if ( $PSBoundParameters.ContainsKey('processlocal') ) { $payload.Add('processlocal', $processlocal) }
            if ( $PSBoundParameters.ContainsKey('httponlycookieflag') ) { $payload.Add('httponlycookieflag', $httponlycookieflag) }
            if ( $PSBoundParameters.ContainsKey('cookiepassphrase') ) { $payload.Add('cookiepassphrase', $cookiepassphrase) }
            if ( $PSBoundParameters.ContainsKey('usesecuredpersistencecookie') ) { $payload.Add('usesecuredpersistencecookie', $usesecuredpersistencecookie) }
            if ( $PSBoundParameters.ContainsKey('useencryptedpersistencecookie') ) { $payload.Add('useencryptedpersistencecookie', $useencryptedpersistencecookie) }
            if ( $PSBoundParameters.ContainsKey('literaladccookieattribute') ) { $payload.Add('literaladccookieattribute', $literaladccookieattribute) }
            if ( $PSBoundParameters.ContainsKey('computedadccookieattribute') ) { $payload.Add('computedadccookieattribute', $computedadccookieattribute) }
            if ( $PSBoundParameters.ContainsKey('storemqttclientidandusername') ) { $payload.Add('storemqttclientidandusername', $storemqttclientidandusername) }
            if ( $PSBoundParameters.ContainsKey('lbhashalgorithm') ) { $payload.Add('lbhashalgorithm', $lbhashalgorithm) }
            if ( $PSBoundParameters.ContainsKey('lbhashfingers') ) { $payload.Add('lbhashfingers', $lbhashfingers) }
            if ( $PSCmdlet.ShouldProcess("lbprofile", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lbprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbprofile: Finished"
    }
}

function Invoke-ADCDeleteLbprofile {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for LB profile resource.
    .PARAMETER Lbprofilename 
        Name of the LB profile.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbprofile -Lbprofilename <string>
        An example how to delete lbprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbprofile/
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
        [string]$Lbprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$lbprofilename", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbprofile -NitroPath nitro/v1/config -Resource $lbprofilename -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbprofile: Finished"
    }
}

function Invoke-ADCUpdateLbprofile {
    <#
    .SYNOPSIS
        Update Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for LB profile resource.
    .PARAMETER Lbprofilename 
        Name of the LB profile. 
    .PARAMETER Dbslb 
        Enable database specific load balancing for MySQL and MSSQL service types. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Processlocal 
        By turning on this option packets destined to a vserver in a cluster will not under go any steering. Turn this option for single pa 
        cket request response mode or when the upstream device is performing a proper RSS for connection based distribution. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httponlycookieflag 
        Include the HttpOnly attribute in persistence cookies. The HttpOnly attribute limits the scope of a cookie to HTTP requests and helps mitigate the risk of cross-site scripting attacks. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cookiepassphrase 
        Use this parameter to specify the passphrase used to generate secured persistence cookie value. It specifies the passphrase with a maximum of 31 characters. 
    .PARAMETER Usesecuredpersistencecookie 
        Encode persistence cookie values using SHA2 hash. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Useencryptedpersistencecookie 
        Encode persistence cookie values using SHA2 hash. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Literaladccookieattribute 
        String configured as LiteralADCCookieAttribute will be appended as attribute for Citrix ADC cookie (for example: LB cookie persistence, GSLB site persistence, CS cookie persistence, LB group cookie persistence). 
        Sample usage - 
        add lb profile lbprof -LiteralADCCookieAttribute ";SameSite=None". 
    .PARAMETER Computedadccookieattribute 
        ComputedADCCookieAttribute accepts ns variable as input in form of string starting with $ (to understand how to configure ns variable, please check man add ns variable). policies can be configured to modify this variable for every transaction and the final value of the variable after policy evaluation will be appended as attribute to Citrix ADC cookie (for example: LB cookie persistence, GSLB sitepersistence, CS cookie persistence, LB group cookie persistence). Only one of ComputedADCCookieAttribute, LiteralADCCookieAttribute can be set. 
        Sample usage - 
        add ns variable lbvar -type TEXT(100) -scope Transaction 
        add ns assignment lbassign -variable $lbvar -set "\\";SameSite=Strict\\"" 
        add rewrite policy lbpol <valid policy expression> lbassign 
        bind rewrite global lbpol 100 next -type RES_OVERRIDE 
        add lb profile lbprof -ComputedADCCookieAttribute "$lbvar" 
        For incoming client request, if above policy evaluates TRUE, then SameSite=Strict will be appended to ADC generated cookie. 
    .PARAMETER Storemqttclientidandusername 
        This option allows to store the MQTT clientid and username in transactional logs. 
        Possible values = YES, NO 
    .PARAMETER Lbhashalgorithm 
        This option dictates the hashing algorithm used for hash based LB methods (URLHASH, DOMAINHASH, SOURCEIPHASH, DESTINATIONIPHASH, SRCIPDESTIPHASH, SRCIPSRCPORTHASH, TOKEN, USER_TOKEN, CALLIDHASH). 
        Possible values = DEFAULT, PRAC, JARH 
    .PARAMETER Lbhashfingers 
        This option is used to specify the number of fingers to be used in PRAC and JARH algorithms for hash based LB methods. Increasing the number of fingers might give better distribution of traffic at the expense of additional memory. 
    .PARAMETER PassThru 
        Return details about the created lbprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLbprofile -lbprofilename <string>
        An example how to update lbprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLbprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbprofile/
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
        [string]$Lbprofilename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dbslb,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Processlocal,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httponlycookieflag,

        [string]$Cookiepassphrase,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Usesecuredpersistencecookie,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Useencryptedpersistencecookie,

        [string]$Literaladccookieattribute,

        [string]$Computedadccookieattribute,

        [ValidateSet('YES', 'NO')]
        [string]$Storemqttclientidandusername,

        [ValidateSet('DEFAULT', 'PRAC', 'JARH')]
        [string]$Lbhashalgorithm,

        [ValidateRange(1, 1024)]
        [double]$Lbhashfingers,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLbprofile: Starting"
    }
    process {
        try {
            $payload = @{ lbprofilename = $lbprofilename }
            if ( $PSBoundParameters.ContainsKey('dbslb') ) { $payload.Add('dbslb', $dbslb) }
            if ( $PSBoundParameters.ContainsKey('processlocal') ) { $payload.Add('processlocal', $processlocal) }
            if ( $PSBoundParameters.ContainsKey('httponlycookieflag') ) { $payload.Add('httponlycookieflag', $httponlycookieflag) }
            if ( $PSBoundParameters.ContainsKey('cookiepassphrase') ) { $payload.Add('cookiepassphrase', $cookiepassphrase) }
            if ( $PSBoundParameters.ContainsKey('usesecuredpersistencecookie') ) { $payload.Add('usesecuredpersistencecookie', $usesecuredpersistencecookie) }
            if ( $PSBoundParameters.ContainsKey('useencryptedpersistencecookie') ) { $payload.Add('useencryptedpersistencecookie', $useencryptedpersistencecookie) }
            if ( $PSBoundParameters.ContainsKey('literaladccookieattribute') ) { $payload.Add('literaladccookieattribute', $literaladccookieattribute) }
            if ( $PSBoundParameters.ContainsKey('computedadccookieattribute') ) { $payload.Add('computedadccookieattribute', $computedadccookieattribute) }
            if ( $PSBoundParameters.ContainsKey('storemqttclientidandusername') ) { $payload.Add('storemqttclientidandusername', $storemqttclientidandusername) }
            if ( $PSBoundParameters.ContainsKey('lbhashalgorithm') ) { $payload.Add('lbhashalgorithm', $lbhashalgorithm) }
            if ( $PSBoundParameters.ContainsKey('lbhashfingers') ) { $payload.Add('lbhashfingers', $lbhashfingers) }
            if ( $PSCmdlet.ShouldProcess("lbprofile", "Update Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateLbprofile: Finished"
    }
}

function Invoke-ADCUnsetLbprofile {
    <#
    .SYNOPSIS
        Unset Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for LB profile resource.
    .PARAMETER Lbprofilename 
        Name of the LB profile. 
    .PARAMETER Dbslb 
        Enable database specific load balancing for MySQL and MSSQL service types. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Processlocal 
        By turning on this option packets destined to a vserver in a cluster will not under go any steering. Turn this option for single pa 
        cket request response mode or when the upstream device is performing a proper RSS for connection based distribution. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httponlycookieflag 
        Include the HttpOnly attribute in persistence cookies. The HttpOnly attribute limits the scope of a cookie to HTTP requests and helps mitigate the risk of cross-site scripting attacks. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cookiepassphrase 
        Use this parameter to specify the passphrase used to generate secured persistence cookie value. It specifies the passphrase with a maximum of 31 characters. 
    .PARAMETER Usesecuredpersistencecookie 
        Encode persistence cookie values using SHA2 hash. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Useencryptedpersistencecookie 
        Encode persistence cookie values using SHA2 hash. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Literaladccookieattribute 
        String configured as LiteralADCCookieAttribute will be appended as attribute for Citrix ADC cookie (for example: LB cookie persistence, GSLB site persistence, CS cookie persistence, LB group cookie persistence). 
        Sample usage - 
        add lb profile lbprof -LiteralADCCookieAttribute ";SameSite=None". 
    .PARAMETER Computedadccookieattribute 
        ComputedADCCookieAttribute accepts ns variable as input in form of string starting with $ (to understand how to configure ns variable, please check man add ns variable). policies can be configured to modify this variable for every transaction and the final value of the variable after policy evaluation will be appended as attribute to Citrix ADC cookie (for example: LB cookie persistence, GSLB sitepersistence, CS cookie persistence, LB group cookie persistence). Only one of ComputedADCCookieAttribute, LiteralADCCookieAttribute can be set. 
        Sample usage - 
        add ns variable lbvar -type TEXT(100) -scope Transaction 
        add ns assignment lbassign -variable $lbvar -set "\\";SameSite=Strict\\"" 
        add rewrite policy lbpol <valid policy expression> lbassign 
        bind rewrite global lbpol 100 next -type RES_OVERRIDE 
        add lb profile lbprof -ComputedADCCookieAttribute "$lbvar" 
        For incoming client request, if above policy evaluates TRUE, then SameSite=Strict will be appended to ADC generated cookie. 
    .PARAMETER Storemqttclientidandusername 
        This option allows to store the MQTT clientid and username in transactional logs. 
        Possible values = YES, NO 
    .PARAMETER Lbhashalgorithm 
        This option dictates the hashing algorithm used for hash based LB methods (URLHASH, DOMAINHASH, SOURCEIPHASH, DESTINATIONIPHASH, SRCIPDESTIPHASH, SRCIPSRCPORTHASH, TOKEN, USER_TOKEN, CALLIDHASH). 
        Possible values = DEFAULT, PRAC, JARH 
    .PARAMETER Lbhashfingers 
        This option is used to specify the number of fingers to be used in PRAC and JARH algorithms for hash based LB methods. Increasing the number of fingers might give better distribution of traffic at the expense of additional memory.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLbprofile -lbprofilename <string>
        An example how to unset lbprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLbprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbprofile
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
        [string]$Lbprofilename,

        [Boolean]$dbslb,

        [Boolean]$processlocal,

        [Boolean]$httponlycookieflag,

        [Boolean]$cookiepassphrase,

        [Boolean]$usesecuredpersistencecookie,

        [Boolean]$useencryptedpersistencecookie,

        [Boolean]$literaladccookieattribute,

        [Boolean]$computedadccookieattribute,

        [Boolean]$storemqttclientidandusername,

        [Boolean]$lbhashalgorithm,

        [Boolean]$lbhashfingers 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLbprofile: Starting"
    }
    process {
        try {
            $payload = @{ lbprofilename = $lbprofilename }
            if ( $PSBoundParameters.ContainsKey('dbslb') ) { $payload.Add('dbslb', $dbslb) }
            if ( $PSBoundParameters.ContainsKey('processlocal') ) { $payload.Add('processlocal', $processlocal) }
            if ( $PSBoundParameters.ContainsKey('httponlycookieflag') ) { $payload.Add('httponlycookieflag', $httponlycookieflag) }
            if ( $PSBoundParameters.ContainsKey('cookiepassphrase') ) { $payload.Add('cookiepassphrase', $cookiepassphrase) }
            if ( $PSBoundParameters.ContainsKey('usesecuredpersistencecookie') ) { $payload.Add('usesecuredpersistencecookie', $usesecuredpersistencecookie) }
            if ( $PSBoundParameters.ContainsKey('useencryptedpersistencecookie') ) { $payload.Add('useencryptedpersistencecookie', $useencryptedpersistencecookie) }
            if ( $PSBoundParameters.ContainsKey('literaladccookieattribute') ) { $payload.Add('literaladccookieattribute', $literaladccookieattribute) }
            if ( $PSBoundParameters.ContainsKey('computedadccookieattribute') ) { $payload.Add('computedadccookieattribute', $computedadccookieattribute) }
            if ( $PSBoundParameters.ContainsKey('storemqttclientidandusername') ) { $payload.Add('storemqttclientidandusername', $storemqttclientidandusername) }
            if ( $PSBoundParameters.ContainsKey('lbhashalgorithm') ) { $payload.Add('lbhashalgorithm', $lbhashalgorithm) }
            if ( $PSBoundParameters.ContainsKey('lbhashfingers') ) { $payload.Add('lbhashfingers', $lbhashfingers) }
            if ( $PSCmdlet.ShouldProcess("$lbprofilename", "Unset Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLbprofile: Finished"
    }
}

function Invoke-ADCGetLbprofile {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for LB profile resource.
    .PARAMETER Lbprofilename 
        Name of the LB profile. 
    .PARAMETER GetAll 
        Retrieve all lbprofile object(s).
    .PARAMETER Count
        If specified, the count of the lbprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbprofile -GetAll 
        Get all lbprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbprofile -Count 
        Get the number of lbprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbprofile -name <string>
        Get lbprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbprofile -Filter @{ 'name'='<value>' }
        Get lbprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbprofile/
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
        [string]$Lbprofilename,

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
        Write-Verbose "Invoke-ADCGetLbprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lbprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbprofile configuration for property 'lbprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbprofile -NitroPath nitro/v1/config -Resource $lbprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbprofile: Ended"
    }
}

function Invoke-ADCAddLbroute {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for LB route resource.
    .PARAMETER Network 
        The IP address of the network to which the route belongs. 
    .PARAMETER Netmask 
        The netmask to which the route belongs. 
    .PARAMETER Gatewayname 
        The name of the route. 
    .PARAMETER Td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbroute -network <string> -netmask <string> -gatewayname <string>
        An example how to add lbroute configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbroute
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbroute/
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
        [string]$Network,

        [Parameter(Mandatory)]
        [string]$Netmask,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Gatewayname,

        [ValidateRange(0, 4094)]
        [double]$Td = '0' 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbroute: Starting"
    }
    process {
        try {
            $payload = @{ network = $network
                netmask           = $netmask
                gatewayname       = $gatewayname
            }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSCmdlet.ShouldProcess("lbroute", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lbroute -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCAddLbroute: Finished"
    }
}

function Invoke-ADCDeleteLbroute {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for LB route resource.
    .PARAMETER Network 
        The IP address of the network to which the route belongs. 
    .PARAMETER Netmask 
        The netmask to which the route belongs. 
    .PARAMETER Td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbroute -Network <string>
        An example how to delete lbroute configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbroute
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbroute/
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
        [string]$Network,

        [string]$Netmask,

        [double]$Td 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbroute: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Netmask') ) { $arguments.Add('netmask', $Netmask) }
            if ( $PSBoundParameters.ContainsKey('Td') ) { $arguments.Add('td', $Td) }
            if ( $PSCmdlet.ShouldProcess("$network", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbroute -NitroPath nitro/v1/config -Resource $network -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbroute: Finished"
    }
}

function Invoke-ADCGetLbroute {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for LB route resource.
    .PARAMETER GetAll 
        Retrieve all lbroute object(s).
    .PARAMETER Count
        If specified, the count of the lbroute object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbroute
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbroute -GetAll 
        Get all lbroute data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbroute -Count 
        Get the number of lbroute objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbroute -name <string>
        Get lbroute object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbroute -Filter @{ 'name'='<value>' }
        Get lbroute data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbroute
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbroute/
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
        Write-Verbose "Invoke-ADCGetLbroute: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lbroute objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbroute -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbroute objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbroute -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbroute objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbroute -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbroute configuration for property ''"

            } else {
                Write-Verbose "Retrieving lbroute configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbroute -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbroute: Ended"
    }
}

function Invoke-ADCAddLbroute6 {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for LB route6 resource.
    .PARAMETER Network 
        The destination network. 
    .PARAMETER Gatewayname 
        The name of the route. 
    .PARAMETER Td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbroute6 -network <string> -gatewayname <string>
        An example how to add lbroute6 configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbroute6
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbroute6/
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
        [string]$Network,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Gatewayname,

        [ValidateRange(0, 4094)]
        [double]$Td = '0' 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbroute6: Starting"
    }
    process {
        try {
            $payload = @{ network = $network
                gatewayname       = $gatewayname
            }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSCmdlet.ShouldProcess("lbroute6", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lbroute6 -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCAddLbroute6: Finished"
    }
}

function Invoke-ADCDeleteLbroute6 {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for LB route6 resource.
    .PARAMETER Network 
        The destination network. 
    .PARAMETER Td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbroute6 -Network <string>
        An example how to delete lbroute6 configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbroute6
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbroute6/
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
        [string]$Network,

        [double]$Td 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbroute6: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Td') ) { $arguments.Add('td', $Td) }
            if ( $PSCmdlet.ShouldProcess("$network", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbroute6 -NitroPath nitro/v1/config -Resource $network -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbroute6: Finished"
    }
}

function Invoke-ADCGetLbroute6 {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for LB route6 resource.
    .PARAMETER GetAll 
        Retrieve all lbroute6 object(s).
    .PARAMETER Count
        If specified, the count of the lbroute6 object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbroute6
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbroute6 -GetAll 
        Get all lbroute6 data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbroute6 -Count 
        Get the number of lbroute6 objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbroute6 -name <string>
        Get lbroute6 object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbroute6 -Filter @{ 'name'='<value>' }
        Get lbroute6 data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbroute6
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbroute6/
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
        Write-Verbose "Invoke-ADCGetLbroute6: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lbroute6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbroute6 -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbroute6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbroute6 -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbroute6 objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbroute6 -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbroute6 configuration for property ''"

            } else {
                Write-Verbose "Retrieving lbroute6 configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbroute6 -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbroute6: Ended"
    }
}

function Invoke-ADCUpdateLbsipparameters {
    <#
    .SYNOPSIS
        Update Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for SIP parameters resource.
    .PARAMETER Rnatsrcport 
        Port number with which to match the source port in server-initiated SIP traffic. The rport parameter is added, without a value, to SIP packets that have a matching source port number, and CALL-ID based persistence is implemented for the responses received by the virtual server. 
    .PARAMETER Rnatdstport 
        Port number with which to match the destination port in server-initiated SIP traffic. The rport parameter is added, without a value, to SIP packets that have a matching destination port number, and CALL-ID based persistence is implemented for the responses received by the virtual server. 
    .PARAMETER Retrydur 
        Time, in seconds, for which a client must wait before initiating a connection after receiving a 503 Service Unavailable response from the SIP server. The time value is sent in the "Retry-After" header in the 503 response. 
    .PARAMETER Addrportvip 
        Add the rport parameter to the VIA headers of SIP requests that virtual servers receive from clients or servers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sip503ratethreshold 
        Maximum number of 503 Service Unavailable responses to generate, once every 10 milliseconds, when a SIP virtual server becomes unavailable. 
    .PARAMETER Rnatsecuresrcport 
        Port number with which to match the source port in server-initiated SIP over SSL traffic. The rport parameter is added, without a value, to SIP packets that have a matching source port number, and CALL-ID based persistence is implemented for the responses received by the virtual server. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Rnatsecuredstport 
        Port number with which to match the destination port in server-initiated SIP over SSL traffic. The rport parameter is added, without a value, to SIP packets that have a matching destination port number, and CALL-ID based persistence is implemented for the responses received by the virtual server. 
        * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLbsipparameters 
        An example how to update lbsipparameters configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLbsipparameters
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbsipparameters/
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

        [int]$Rnatsrcport,

        [int]$Rnatdstport,

        [int]$Retrydur,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Addrportvip,

        [double]$Sip503ratethreshold,

        [ValidateRange(1, 65535)]
        [int]$Rnatsecuresrcport,

        [ValidateRange(1, 65535)]
        [int]$Rnatsecuredstport 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLbsipparameters: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('rnatsrcport') ) { $payload.Add('rnatsrcport', $rnatsrcport) }
            if ( $PSBoundParameters.ContainsKey('rnatdstport') ) { $payload.Add('rnatdstport', $rnatdstport) }
            if ( $PSBoundParameters.ContainsKey('retrydur') ) { $payload.Add('retrydur', $retrydur) }
            if ( $PSBoundParameters.ContainsKey('addrportvip') ) { $payload.Add('addrportvip', $addrportvip) }
            if ( $PSBoundParameters.ContainsKey('sip503ratethreshold') ) { $payload.Add('sip503ratethreshold', $sip503ratethreshold) }
            if ( $PSBoundParameters.ContainsKey('rnatsecuresrcport') ) { $payload.Add('rnatsecuresrcport', $rnatsecuresrcport) }
            if ( $PSBoundParameters.ContainsKey('rnatsecuredstport') ) { $payload.Add('rnatsecuredstport', $rnatsecuredstport) }
            if ( $PSCmdlet.ShouldProcess("lbsipparameters", "Update Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbsipparameters -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateLbsipparameters: Finished"
    }
}

function Invoke-ADCUnsetLbsipparameters {
    <#
    .SYNOPSIS
        Unset Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for SIP parameters resource.
    .PARAMETER Rnatsrcport 
        Port number with which to match the source port in server-initiated SIP traffic. The rport parameter is added, without a value, to SIP packets that have a matching source port number, and CALL-ID based persistence is implemented for the responses received by the virtual server. 
    .PARAMETER Rnatdstport 
        Port number with which to match the destination port in server-initiated SIP traffic. The rport parameter is added, without a value, to SIP packets that have a matching destination port number, and CALL-ID based persistence is implemented for the responses received by the virtual server. 
    .PARAMETER Retrydur 
        Time, in seconds, for which a client must wait before initiating a connection after receiving a 503 Service Unavailable response from the SIP server. The time value is sent in the "Retry-After" header in the 503 response. 
    .PARAMETER Addrportvip 
        Add the rport parameter to the VIA headers of SIP requests that virtual servers receive from clients or servers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sip503ratethreshold 
        Maximum number of 503 Service Unavailable responses to generate, once every 10 milliseconds, when a SIP virtual server becomes unavailable. 
    .PARAMETER Rnatsecuresrcport 
        Port number with which to match the source port in server-initiated SIP over SSL traffic. The rport parameter is added, without a value, to SIP packets that have a matching source port number, and CALL-ID based persistence is implemented for the responses received by the virtual server. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Rnatsecuredstport 
        Port number with which to match the destination port in server-initiated SIP over SSL traffic. The rport parameter is added, without a value, to SIP packets that have a matching destination port number, and CALL-ID based persistence is implemented for the responses received by the virtual server. 
        * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLbsipparameters 
        An example how to unset lbsipparameters configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLbsipparameters
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbsipparameters
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

        [Boolean]$rnatsrcport,

        [Boolean]$rnatdstport,

        [Boolean]$retrydur,

        [Boolean]$addrportvip,

        [Boolean]$sip503ratethreshold,

        [Boolean]$rnatsecuresrcport,

        [Boolean]$rnatsecuredstport 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLbsipparameters: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('rnatsrcport') ) { $payload.Add('rnatsrcport', $rnatsrcport) }
            if ( $PSBoundParameters.ContainsKey('rnatdstport') ) { $payload.Add('rnatdstport', $rnatdstport) }
            if ( $PSBoundParameters.ContainsKey('retrydur') ) { $payload.Add('retrydur', $retrydur) }
            if ( $PSBoundParameters.ContainsKey('addrportvip') ) { $payload.Add('addrportvip', $addrportvip) }
            if ( $PSBoundParameters.ContainsKey('sip503ratethreshold') ) { $payload.Add('sip503ratethreshold', $sip503ratethreshold) }
            if ( $PSBoundParameters.ContainsKey('rnatsecuresrcport') ) { $payload.Add('rnatsecuresrcport', $rnatsecuresrcport) }
            if ( $PSBoundParameters.ContainsKey('rnatsecuredstport') ) { $payload.Add('rnatsecuredstport', $rnatsecuredstport) }
            if ( $PSCmdlet.ShouldProcess("lbsipparameters", "Unset Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbsipparameters -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLbsipparameters: Finished"
    }
}

function Invoke-ADCGetLbsipparameters {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for SIP parameters resource.
    .PARAMETER GetAll 
        Retrieve all lbsipparameters object(s).
    .PARAMETER Count
        If specified, the count of the lbsipparameters object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbsipparameters
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbsipparameters -GetAll 
        Get all lbsipparameters data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbsipparameters -name <string>
        Get lbsipparameters object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbsipparameters -Filter @{ 'name'='<value>' }
        Get lbsipparameters data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbsipparameters
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbsipparameters/
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
        Write-Verbose "Invoke-ADCGetLbsipparameters: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lbsipparameters objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbsipparameters -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbsipparameters objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbsipparameters -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbsipparameters objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbsipparameters -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbsipparameters configuration for property ''"

            } else {
                Write-Verbose "Retrieving lbsipparameters configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbsipparameters -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbsipparameters: Ended"
    }
}

function Invoke-ADCAddLbvserver {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Servicetype 
        Protocol used by the service (also called the service type). 
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, DTLS, NNTP, DNS, DHCPRA, ANY, SIP_UDP, SIP_TCP, SIP_SSL, DNS_TCP, RTSP, PUSH, SSL_PUSH, RADIUS, RDP, MYSQL, MSSQL, DIAMETER, SSL_DIAMETER, TFTP, ORACLE, SMPP, SYSLOGTCP, SYSLOGUDP, FIX, SSL_FIX, PROXY, USER_TCP, USER_SSL_TCP, QUIC, IPFIX, LOGSTREAM, MONGO, MONGO_TLS, MQTT, MQTT_TLS, QUIC_BRIDGE, HTTP_QUIC 
    .PARAMETER Ipv46 
        IPv4 or IPv6 address to assign to the virtual server. 
    .PARAMETER Ippattern 
        IP address pattern, in dotted decimal notation, for identifying packets to be accepted by the virtual server. The IP Mask parameter specifies which part of the destination IP address is matched against the pattern. Mutually exclusive with the IP Address parameter. 
        For example, if the IP pattern assigned to the virtual server is 198.51.100.0 and the IP mask is 255.255.240.0 (a forward mask), the first 20 bits in the destination IP addresses are matched with the first 20 bits in the pattern. The virtual server accepts requests with IP addresses that range from 198.51.96.1 to 198.51.111.254. You can also use a pattern such as 0.0.2.2 and a mask such as 0.0.255.255 (a reverse mask). 
        If a destination IP address matches more than one IP pattern, the pattern with the longest match is selected, and the associated virtual server processes the request. For example, if virtual servers vs1 and vs2 have the same IP pattern, 0.0.100.128, but different IP masks of 0.0.255.255 and 0.0.224.255, a destination IP address of 198.51.100.128 has the longest match with the IP pattern of vs1. If a destination IP address matches two or more virtual servers to the same extent, the request is processed by the virtual server whose port number matches the port number in the request. 
    .PARAMETER Ipmask 
        IP mask, in dotted decimal notation, for the IP Pattern parameter. Can have leading or trailing non-zero octets (for example, 255.255.240.0 or 0.0.255.255). Accordingly, the mask specifies whether the first n bits or the last n bits of the destination IP address in a client request are to be matched with the corresponding bits in the IP pattern. The former is called a forward mask. The latter is called a reverse mask. 
    .PARAMETER Port 
        Port number for the virtual server. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current lb vserver. 
    .PARAMETER Range 
        Number of IP addresses that the appliance must generate and assign to the virtual server. The virtual server then functions as a network virtual server, accepting traffic on any of the generated IP addresses. The IP addresses are generated automatically, as follows: 
        * For a range of n, the last octet of the address specified by the IP Address parameter increments n-1 times. 
        * If the last octet exceeds 255, it rolls over to 0 and the third octet increments by 1. 
        Note: The Range parameter assigns multiple IP addresses to one virtual server. To generate an array of virtual servers, each of which owns only one IP address, use brackets in the IP Address and Name parameters to specify the range. For example: 
        add lb vserver my_vserver[1-3] HTTP 192.0.2.[1-3] 80. 
    .PARAMETER Persistencetype 
        Type of persistence for the virtual server. Available settings function as follows: 
        * SOURCEIP - Connections from the same client IP address belong to the same persistence session. 
        * COOKIEINSERT - Connections that have the same HTTP Cookie, inserted by a Set-Cookie directive from a server, belong to the same persistence session. 
        * SSLSESSION - Connections that have the same SSL Session ID belong to the same persistence session. 
        * CUSTOMSERVERID - Connections with the same server ID form part of the same session. For this persistence type, set the Server ID (CustomServerID) parameter for each service and configure the Rule parameter to identify the server ID in a request. 
        * RULE - All connections that match a user defined rule belong to the same persistence session. 
        * URLPASSIVE - Requests that have the same server ID in the URL query belong to the same persistence session. The server ID is the hexadecimal representation of the IP address and port of the service to which the request must be forwarded. This persistence type requires a rule to identify the server ID in the request. 
        * DESTIP - Connections to the same destination IP address belong to the same persistence session. 
        * SRCIPDESTIP - Connections that have the same source IP address and destination IP address belong to the same persistence session. 
        * CALLID - Connections that have the same CALL-ID SIP header belong to the same persistence session. 
        * RTSPSID - Connections that have the same RTSP Session ID belong to the same persistence session. 
        * FIXSESSION - Connections that have the same SenderCompID and TargetCompID values belong to the same persistence session. 
        * USERSESSION - Persistence session is created based on the persistence parameter value provided from an extension. 
        Possible values = SOURCEIP, COOKIEINSERT, SSLSESSION, RULE, URLPASSIVE, CUSTOMSERVERID, DESTIP, SRCIPDESTIP, CALLID, RTSPSID, DIAMETER, FIXSESSION, USERSESSION, NONE 
    .PARAMETER Timeout 
        Time period for which a persistence session is in effect. 
    .PARAMETER Persistencebackup 
        Backup persistence type for the virtual server. Becomes operational if the primary persistence mechanism fails. 
        Possible values = SOURCEIP, NONE 
    .PARAMETER Backuppersistencetimeout 
        Time period for which backup persistence is in effect. 
    .PARAMETER Lbmethod 
        Load balancing method. The available settings function as follows: 
        * ROUNDROBIN - Distribute requests in rotation, regardless of the load. Weights can be assigned to services to enforce weighted round robin distribution. 
        * LEASTCONNECTION (default) - Select the service with the fewest connections. 
        * LEASTRESPONSETIME - Select the service with the lowest average response time. 
        * LEASTBANDWIDTH - Select the service currently handling the least traffic. 
        * LEASTPACKETS - Select the service currently serving the lowest number of packets per second. 
        * CUSTOMLOAD - Base service selection on the SNMP metrics obtained by custom load monitors. 
        * LRTM - Select the service with the lowest response time. Response times are learned through monitoring probes. This method also takes the number of active connections into account. 
        Also available are a number of hashing methods, in which the appliance extracts a predetermined portion of the request, creates a hash of the portion, and then checks whether any previous requests had the same hash value. If it finds a match, it forwards the request to the service that served those previous requests. Following are the hashing methods: 
        * URLHASH - Create a hash of the request URL (or part of the URL). 
        * DOMAINHASH - Create a hash of the domain name in the request (or part of the domain name). The domain name is taken from either the URL or the Host header. If the domain name appears in both locations, the URL is preferred. If the request does not contain a domain name, the load balancing method defaults to LEASTCONNECTION. 
        * DESTINATIONIPHASH - Create a hash of the destination IP address in the IP header. 
        * SOURCEIPHASH - Create a hash of the source IP address in the IP header. 
        * TOKEN - Extract a token from the request, create a hash of the token, and then select the service to which any previous requests with the same token hash value were sent. 
        * SRCIPDESTIPHASH - Create a hash of the string obtained by concatenating the source IP address and destination IP address in the IP header. 
        * SRCIPSRCPORTHASH - Create a hash of the source IP address and source port in the IP header. 
        * CALLIDHASH - Create a hash of the SIP Call-ID header. 
        * USER_TOKEN - Same as TOKEN LB method but token needs to be provided from an extension. 
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, URLHASH, DOMAINHASH, DESTINATIONIPHASH, SOURCEIPHASH, SRCIPDESTIPHASH, LEASTBANDWIDTH, LEASTPACKETS, TOKEN, SRCIPSRCPORTHASH, LRTM, CALLIDHASH, CUSTOMLOAD, LEASTREQUEST, AUDITLOGHASH, STATICPROXIMITY, USER_TOKEN 
    .PARAMETER Hashlength 
        Number of bytes to consider for the hash value used in the URLHASH and DOMAINHASH load balancing methods. 
    .PARAMETER Netmask 
        IPv4 subnet mask to apply to the destination IP address or source IP address when the load balancing method is DESTINATIONIPHASH or SOURCEIPHASH. 
    .PARAMETER V6netmasklen 
        Number of bits to consider in an IPv6 destination or source IP address, for creating the hash that is required by the DESTINATIONIPHASH and SOURCEIPHASH load balancing methods. 
    .PARAMETER Backuplbmethod 
        Backup load balancing method. Becomes operational if the primary load balancing me 
        thod fails or cannot be used. 
        Valid only if the primary method is based on static proximity. 
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, CUSTOMLOAD 
    .PARAMETER Cookiename 
        Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Listenpolicy 
        Expression identifying traffic accepted by the virtual server. Can be either an expression (for example, CLIENT.IP.DST.IN_SUBNET(192.0.2.0/24) or the name of a named expression. In the above example, the virtual server accepts all requests whose destination IP address is in the 192.0.2.0/24 subnet. 
    .PARAMETER Listenpriority 
        Integer specifying the priority of the listen policy. A higher number specifies a lower priority. If a request matches the listen policies of more than one virtual server the virtual server whose listen policy has the highest priority (the lowest priority number) accepts the request. 
    .PARAMETER Resrule 
        Expression specifying which part of a server's response to use for creating rule based persistence sessions (persistence type RULE). Can be either an expression or the name of a named expression. 
        Example: 
        HTTP.RES.HEADER("setcookie").VALUE(0).TYPECAST_NVLIST_T('=',';').VALUE("server1"). 
    .PARAMETER Persistmask 
        Persistence mask for IP based persistence types, for IPv4 virtual servers. 
    .PARAMETER V6persistmasklen 
        Persistence mask for IP based persistence types, for IPv6 virtual servers. 
    .PARAMETER Rtspnat 
        Use network address translation (NAT) for RTSP data connections. 
        Possible values = ON, OFF 
    .PARAMETER M 
        Redirection mode for load balancing. Available settings function as follows: 
        * IP - Before forwarding a request to a server, change the destination IP address to the server's IP address. 
        * MAC - Before forwarding a request to a server, change the destination MAC address to the server's MAC address. The destination IP address is not changed. MAC-based redirection mode is used mostly in firewall load balancing deployments. 
        * IPTUNNEL - Perform IP-in-IP encapsulation for client IP packets. In the outer IP headers, set the destination IP address to the IP address of the server and the source IP address to the subnet IP (SNIP). The client IP packets are not modified. Applicable to both IPv4 and IPv6 packets. 
        * TOS - Encode the virtual server's TOS ID in the TOS field of the IP header. 
        You can use either the IPTUNNEL or the TOS option to implement Direct Server Return (DSR). 
        Possible values = IP, MAC, IPTUNNEL, TOS 
    .PARAMETER Tosid 
        TOS ID of the virtual server. Applicable only when the load balancing redirection mode is set to TOS. 
    .PARAMETER Datalength 
        Length of the token to be extracted from the data segment of an incoming packet, for use in the token method of load balancing. The length of the token, specified in bytes, must not be greater than 24 KB. Applicable to virtual servers of type TCP. 
    .PARAMETER Dataoffset 
        Offset to be considered when extracting a token from the TCP payload. Applicable to virtual servers, of type TCP, using the token method of load balancing. Must be within the first 24 KB of the TCP payload. 
    .PARAMETER Sessionless 
        Perform load balancing on a per-packet basis, without establishing sessions. Recommended for load balancing of intrusion detection system (IDS) servers and scenarios involving direct server return (DSR), where session information is unnecessary. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Trofspersistence 
        When value is ENABLED, Trofs persistence is honored. When value is DISABLED, Trofs persistence is not honored. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER State 
        State of the load balancing virtual server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Connfailover 
        Mode in which the connection failover feature must operate for the virtual server. After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary appliance. Clients remain connected to the same servers. Available settings function as follows: 
        * STATEFUL - The primary appliance shares state information with the secondary appliance, in real time, resulting in some runtime processing overhead. 
        * STATELESS - State information is not shared, and the new primary appliance tries to re-create the packet flow on the basis of the information contained in the packets it receives. 
        * DISABLED - Connection failover does not occur. 
        Possible values = DISABLED, STATEFUL, STATELESS 
    .PARAMETER Redirurl 
        URL to which to redirect traffic if the virtual server becomes unavailable. 
        WARNING! Make sure that the domain in the URL does not match the domain specified for a content switching policy. If it does, requests are continuously redirected to the unavailable virtual server. 
    .PARAMETER Cacheable 
        Route cacheable requests to a cache redirection virtual server. The load balancing virtual server can forward requests only to a transparent cache redirection virtual server that has an IP address and port combination of *:80, so such a cache redirection virtual server must be configured on the appliance. 
        Possible values = YES, NO 
    .PARAMETER Clttimeout 
        Idle time, in seconds, after which a client connection is terminated. 
    .PARAMETER Somethod 
        Type of threshold that, when exceeded, triggers spillover. Available settings function as follows: 
        * CONNECTION - Spillover occurs when the number of client connections exceeds the threshold. 
        * DYNAMICCONNECTION - Spillover occurs when the number of client connections at the virtual server exceeds the sum of the maximum client (Max Clients) settings for bound services. Do not specify a spillover threshold for this setting, because the threshold is implied by the Max Clients settings of bound services. 
        * BANDWIDTH - Spillover occurs when the bandwidth consumed by the virtual server's incoming and outgoing traffic exceeds the threshold. 
        * HEALTH - Spillover occurs when the percentage of weights of the services that are UP drops below the threshold. For example, if services svc1, svc2, and svc3 are bound to a virtual server, with weights 1, 2, and 3, and the spillover threshold is 50%, spillover occurs if svc1 and svc3 or svc2 and svc3 transition to DOWN. 
        * NONE - Spillover does not occur. 
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER Sopersistence 
        If spillover occurs, maintain source IP address based persistence for both primary and backup virtual servers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sopersistencetimeout 
        Timeout for spillover persistence, in minutes. 
    .PARAMETER Healththreshold 
        Threshold in percent of active services below which vserver state is made down. If this threshold is 0, vserver state will be up even if one bound service is up. 
    .PARAMETER Sothreshold 
        Threshold at which spillover occurs. Specify an integer for the CONNECTION spillover method, a bandwidth value in kilobits per second for the BANDWIDTH method (do not enter the units), or a percentage for the HEALTH method (do not enter the percentage symbol). 
    .PARAMETER Sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists. 
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER Redirectportrewrite 
        Rewrite the port and change the protocol to ensure successful HTTP redirects from services. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with a virtual server whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Backupvserver 
        Name of the backup virtual server to which to forward requests if the primary virtual server goes DOWN or reaches its spillover threshold. 
    .PARAMETER Disableprimaryondown 
        If the primary virtual server goes down, do not allow it to return to primary status until manually enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Insertvserveripport 
        Insert an HTTP header, whose value is the IP address and port number of the virtual server, before forwarding a request to the server. The format of the header is <vipHeader>: <virtual server IP address>_<port number >, where vipHeader is the name that you specify for the header. If the virtual server has an IPv6 address, the address in the header is enclosed in brackets ([ and ]) to separate it from the port number. If you have mapped an IPv4 address to a virtual server's IPv6 address, the value of this parameter determines which IP address is inserted in the header, as follows: 
        * VIPADDR - Insert the IP address of the virtual server in the HTTP header regardless of whether the virtual server has an IPv4 address or an IPv6 address. A mapped IPv4 address, if configured, is ignored. 
        * V6TOV4MAPPING - Insert the IPv4 address that is mapped to the virtual server's IPv6 address. If a mapped IPv4 address is not configured, insert the IPv6 address. 
        * OFF - Disable header insertion. 
        Possible values = OFF, VIPADDR, V6TOV4MAPPING 
    .PARAMETER Vipheader 
        Name for the inserted header. The default name is vip-header. 
    .PARAMETER Authenticationhost 
        Fully qualified domain name (FQDN) of the authentication virtual server to which the user must be redirected for authentication. Make sure that the Authentication parameter is set to ENABLED. 
    .PARAMETER Authentication 
        Enable or disable user authentication. 
        Possible values = ON, OFF 
    .PARAMETER Authn401 
        Enable or disable user authentication with HTTP 401 responses. 
        Possible values = ON, OFF 
    .PARAMETER Authnvsname 
        Name of an authentication virtual server with which to authenticate users. 
    .PARAMETER Push 
        Process traffic with the push virtual server that is bound to this load balancing virtual server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pushvserver 
        Name of the load balancing virtual server, of type PUSH or SSL_PUSH, to which the server pushes updates received on the load balancing virtual server that you are configuring. 
    .PARAMETER Pushlabel 
        Expression for extracting a label from the server's response. Can be either an expression or the name of a named expression. 
    .PARAMETER Pushmulticlients 
        Allow multiple Web 2.0 connections from the same client to connect to the virtual server and expect updates. 
        Possible values = YES, NO 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile whose settings are to be applied to the virtual server. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile whose settings are to be applied to the virtual server. 
    .PARAMETER Dbprofilename 
        Name of the DB profile whose settings are to be applied to the virtual server. 
    .PARAMETER Comment 
        Any comments that you might want to associate with the virtual server. 
    .PARAMETER L2conn 
        Use Layer 2 parameters (channel number, MAC address, and VLAN ID) in addition to the 4-tuple (<source IP>:<source port>::<destination IP>:<destination port>) that is used to identify a connection. Allows multiple TCP and non-TCP connections with the same 4-tuple to co-exist on the Citrix ADC. 
        Possible values = ON, OFF 
    .PARAMETER Oracleserverversion 
        Oracle server version. 
        Possible values = 10G, 11G 
    .PARAMETER Mssqlserverversion 
        For a load balancing virtual server of type MSSQL, the Microsoft SQL Server version. Set this parameter if you expect some clients to run a version different from the version of the database. This setting provides compatibility between the client-side and server-side connections by ensuring that all communication conforms to the server's version. 
        Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
    .PARAMETER Mysqlprotocolversion 
        MySQL protocol version that the virtual server advertises to clients. 
    .PARAMETER Mysqlserverversion 
        MySQL server version string that the virtual server advertises to clients. 
    .PARAMETER Mysqlcharacterset 
        Character set that the virtual server advertises to clients. 
    .PARAMETER Mysqlservercapabilities 
        Server capabilities that the virtual server advertises to clients. 
    .PARAMETER Appflowlog 
        Apply AppFlow logging to the virtual server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Name of the network profile to associate with the virtual server. If you set this parameter, the virtual server uses only the IP addresses in the network profile as source IP addresses when initiating connections with servers. 
    .PARAMETER Icmpvsrresponse 
        How the Citrix ADC responds to ping requests received for an IP address that is common to one or more virtual servers. Available settings function as follows: 
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always responds to the ping requests. 
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance responds to the ping requests if at least one of the virtual servers is UP. Otherwise, the appliance does not respond. 
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance responds if at least one virtual server with the ACTIVE setting is UP. Otherwise, the appliance does not respond. 
        Note: This parameter is available at the virtual server level. A similar parameter, ICMP Response, is available at the IP address level, for IPv4 addresses of type VIP. To set that parameter, use the add ip command in the CLI or the Create IP dialog box in the GUI. 
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Rhistate 
        Route Health Injection (RHI) functionality of the NetSaler appliance for advertising the route of the VIP address associated with the virtual server. When Vserver RHI Level (RHI) parameter is set to VSVR_CNTRLD, the following are different RHI behaviors for the VIP address on the basis of RHIstate (RHI STATE) settings on the virtual servers associated with the VIP address: 
        * If you set RHI STATE to PASSIVE on all virtual servers, the Citrix ADC always advertises the route for the VIP address. 
        * If you set RHI STATE to ACTIVE on all virtual servers, the Citrix ADC advertises the route for the VIP address if at least one of the associated virtual servers is in UP state. 
        * If you set RHI STATE to ACTIVE on some and PASSIVE on others, the Citrix ADC advertises the route for the VIP address if at least one of the associated virtual servers, whose RHI STATE set to ACTIVE, is in UP state. 
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Newservicerequest 
        Number of requests, or percentage of the load on existing services, by which to increase the load on a new service at each interval in slow-start mode. A non-zero value indicates that slow-start is applicable. A zero value indicates that the global RR startup parameter is applied. Changing the value to zero will cause services currently in slow start to take the full traffic as determined by the LB method. Subsequently, any new services added will use the global RR factor. 
    .PARAMETER Newservicerequestunit 
        Units in which to increment load at each interval in slow-start mode. 
        Possible values = PER_SECOND, PERCENT 
    .PARAMETER Newservicerequestincrementinterval 
        Interval, in seconds, between successive increments in the load on a new service or a service whose state has just changed from DOWN to UP. A value of 0 (zero) specifies manual slow start. 
    .PARAMETER Minautoscalemembers 
        Minimum number of members expected to be present when vserver is used in Autoscale. 
    .PARAMETER Maxautoscalemembers 
        Maximum number of members expected to be present when vserver is used in Autoscale. 
    .PARAMETER Persistavpno 
        Persist AVP number for Diameter Persistency. 
        In case this AVP is not defined in Base RFC 3588 and it is nested inside a Grouped AVP, 
        define a sequence of AVP numbers (max 3) in order of parent to child. So say persist AVP number X 
        is nested inside AVP Y which is nested in Z, then define the list as Z Y X. 
    .PARAMETER Skippersistency 
        This argument decides the behavior incase the service which is selected from an existing persistence session has reached threshold. 
        Possible values = Bypass, ReLb, None 
    .PARAMETER Td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0. 
    .PARAMETER Authnprofile 
        Name of the authentication profile to be used when authentication is turned on. 
    .PARAMETER Macmoderetainvlan 
        This option is used to retain vlan information of incoming packet when macmode is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dbslb 
        Enable database specific load balancing for MySQL and MSSQL service types. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dns64 
        This argument is for enabling/disabling the dns64 on lbvserver. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Bypassaaaa 
        If this option is enabled while resolving DNS64 query AAAA queries are not sent to back end dns server. 
        Possible values = YES, NO 
    .PARAMETER Recursionavailable 
        When set to YES, this option causes the DNS replies from this vserver to have the RA bit turned on. Typically one would set this option to YES, when the vserver is load balancing a set of DNS servers thatsupport recursive queries. 
        Possible values = YES, NO 
    .PARAMETER Processlocal 
        By turning on this option packets destined to a vserver in a cluster will not under go any steering. Turn this option for single packet request response mode or when the upstream device is performing a proper RSS for connection based distribution. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the VServer. DNS profile properties will be applied to the transactions processed by a VServer. This parameter is valid only for DNS and DNS-TCP VServers. 
    .PARAMETER Lbprofilename 
        Name of the LB profile which is associated to the vserver. 
    .PARAMETER Redirectfromport 
        Port number for the virtual server, from which we absorb the traffic for http redirect. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Httpsredirecturl 
        URL to which all HTTP traffic received on the port specified in the -redirectFromPort parameter is redirected. 
    .PARAMETER Retainconnectionsoncluster 
        This option enables you to retain existing connections on a node joining a Cluster system or when a node is being configured for passive timeout. By default, this option is disabled. 
        Possible values = YES, NO 
    .PARAMETER Adfsproxyprofile 
        Name of the adfsProxy profile to be used to support ADFSPIP protocol for ADFS servers. 
    .PARAMETER Tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Quicprofilename 
        Name of QUIC profile which will be attached to the VServer. 
    .PARAMETER Quicbridgeprofilename 
        Name of the QUIC Bridge profile whose settings are to be applied to the virtual server. 
    .PARAMETER Probeprotocol 
        Citrix ADC provides support for external health check of the vserver status. Select HTTP or TCP probes for healthcheck. 
        Possible values = TCP, HTTP 
    .PARAMETER Probesuccessresponsecode 
        HTTP code to return in SUCCESS case. 
    .PARAMETER Probeport 
        Citrix ADC provides support for external health check of the vserver status. Select port for HTTP/TCP monitring. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER PassThru 
        Return details about the created lbvserver item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserver -name <string> -servicetype <string>
        An example how to add lbvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver/
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
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'DTLS', 'NNTP', 'DNS', 'DHCPRA', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'DNS_TCP', 'RTSP', 'PUSH', 'SSL_PUSH', 'RADIUS', 'RDP', 'MYSQL', 'MSSQL', 'DIAMETER', 'SSL_DIAMETER', 'TFTP', 'ORACLE', 'SMPP', 'SYSLOGTCP', 'SYSLOGUDP', 'FIX', 'SSL_FIX', 'PROXY', 'USER_TCP', 'USER_SSL_TCP', 'QUIC', 'IPFIX', 'LOGSTREAM', 'MONGO', 'MONGO_TLS', 'MQTT', 'MQTT_TLS', 'QUIC_BRIDGE', 'HTTP_QUIC')]
        [string]$Servicetype,

        [string]$Ipv46,

        [string]$Ippattern,

        [string]$Ipmask,

        [ValidateRange(1, 65535)]
        [int]$Port,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipset,

        [ValidateRange(1, 254)]
        [double]$Range = '1',

        [ValidateSet('SOURCEIP', 'COOKIEINSERT', 'SSLSESSION', 'RULE', 'URLPASSIVE', 'CUSTOMSERVERID', 'DESTIP', 'SRCIPDESTIP', 'CALLID', 'RTSPSID', 'DIAMETER', 'FIXSESSION', 'USERSESSION', 'NONE')]
        [string]$Persistencetype,

        [ValidateRange(0, 1440)]
        [double]$Timeout = '2',

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$Persistencebackup,

        [ValidateRange(2, 1440)]
        [double]$Backuppersistencetimeout = '2',

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'URLHASH', 'DOMAINHASH', 'DESTINATIONIPHASH', 'SOURCEIPHASH', 'SRCIPDESTIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'TOKEN', 'SRCIPSRCPORTHASH', 'LRTM', 'CALLIDHASH', 'CUSTOMLOAD', 'LEASTREQUEST', 'AUDITLOGHASH', 'STATICPROXIMITY', 'USER_TOKEN')]
        [string]$Lbmethod = 'LEASTCONNECTION',

        [ValidateRange(1, 4096)]
        [double]$Hashlength = '80',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Netmask,

        [ValidateRange(1, 128)]
        [double]$V6netmasklen = '128',

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'SOURCEIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'CUSTOMLOAD')]
        [string]$Backuplbmethod = 'ROUNDROBIN',

        [string]$Cookiename,

        [string]$Rule = '"none"',

        [string]$Listenpolicy = '"NONE"',

        [ValidateRange(0, 101)]
        [double]$Listenpriority = '101',

        [string]$Resrule = '"none"',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Persistmask,

        [ValidateRange(1, 128)]
        [double]$V6persistmasklen = '128',

        [ValidateSet('ON', 'OFF')]
        [string]$Rtspnat = 'OFF',

        [ValidateSet('IP', 'MAC', 'IPTUNNEL', 'TOS')]
        [string]$M = 'IP',

        [ValidateRange(1, 63)]
        [double]$Tosid,

        [ValidateRange(1, 100)]
        [double]$Datalength,

        [ValidateRange(0, 25400)]
        [double]$Dataoffset,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sessionless = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Trofspersistence = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('DISABLED', 'STATEFUL', 'STATELESS')]
        [string]$Connfailover = 'DISABLED',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Redirurl,

        [ValidateSet('YES', 'NO')]
        [string]$Cacheable = 'NO',

        [ValidateRange(0, 31536000)]
        [double]$Clttimeout,

        [ValidateSet('CONNECTION', 'DYNAMICCONNECTION', 'BANDWIDTH', 'HEALTH', 'NONE')]
        [string]$Somethod,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sopersistence = 'DISABLED',

        [ValidateRange(2, 1440)]
        [double]$Sopersistencetimeout = '2',

        [ValidateRange(0, 100)]
        [double]$Healththreshold = '0',

        [ValidateRange(1, 4294967287)]
        [double]$Sothreshold,

        [ValidateSet('DROP', 'ACCEPT', 'REDIRECT')]
        [string]$Sobackupaction,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Redirectportrewrite = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush = 'ENABLED',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backupvserver,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Disableprimaryondown = 'DISABLED',

        [ValidateSet('OFF', 'VIPADDR', 'V6TOV4MAPPING')]
        [string]$Insertvserveripport,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Vipheader,

        [ValidateLength(3, 252)]
        [string]$Authenticationhost,

        [ValidateSet('ON', 'OFF')]
        [string]$Authentication = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Authn401 = 'OFF',

        [ValidateLength(1, 252)]
        [string]$Authnvsname,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Push = 'DISABLED',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Pushvserver,

        [string]$Pushlabel = '"none"',

        [ValidateSet('YES', 'NO')]
        [string]$Pushmulticlients = 'NO',

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateLength(1, 127)]
        [string]$Httpprofilename,

        [ValidateLength(1, 127)]
        [string]$Dbprofilename,

        [string]$Comment,

        [ValidateSet('ON', 'OFF')]
        [string]$L2conn,

        [ValidateSet('10G', '11G')]
        [string]$Oracleserverversion = '10G',

        [ValidateSet('70', '2000', '2000SP1', '2005', '2008', '2008R2', '2012', '2014')]
        [string]$Mssqlserverversion = '2008R2',

        [double]$Mysqlprotocolversion,

        [ValidateLength(1, 31)]
        [string]$Mysqlserverversion,

        [double]$Mysqlcharacterset,

        [double]$Mysqlservercapabilities,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog = 'ENABLED',

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Icmpvsrresponse = 'PASSIVE',

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Rhistate = 'PASSIVE',

        [double]$Newservicerequest = '0',

        [ValidateSet('PER_SECOND', 'PERCENT')]
        [string]$Newservicerequestunit = 'PER_SECOND',

        [ValidateRange(0, 3600)]
        [double]$Newservicerequestincrementinterval = '0',

        [ValidateRange(0, 5000)]
        [double]$Minautoscalemembers = '0',

        [ValidateRange(0, 5000)]
        [double]$Maxautoscalemembers = '0',

        [double[]]$Persistavpno,

        [ValidateSet('Bypass', 'ReLb', 'None')]
        [string]$Skippersistency = 'None',

        [ValidateRange(0, 4094)]
        [double]$Td,

        [string]$Authnprofile,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Macmoderetainvlan = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dbslb = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dns64,

        [ValidateSet('YES', 'NO')]
        [string]$Bypassaaaa = 'NO',

        [ValidateSet('YES', 'NO')]
        [string]$Recursionavailable = 'NO',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Processlocal = 'DISABLED',

        [ValidateLength(1, 127)]
        [string]$Dnsprofilename,

        [string]$Lbprofilename,

        [ValidateRange(1, 65535)]
        [int]$Redirectfromport,

        [string]$Httpsredirecturl,

        [ValidateSet('YES', 'NO')]
        [string]$Retainconnectionsoncluster = 'NO',

        [string]$Adfsproxyprofile,

        [ValidateRange(1, 65535)]
        [int]$Tcpprobeport,

        [ValidateLength(1, 255)]
        [string]$Quicprofilename,

        [ValidateLength(1, 127)]
        [string]$Quicbridgeprofilename,

        [ValidateSet('TCP', 'HTTP')]
        [string]$Probeprotocol,

        [ValidateLength(1, 64)]
        [string]$Probesuccessresponsecode = '"200 OK"',

        [ValidateRange(1, 65535)]
        [int]$Probeport = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                servicetype    = $servicetype
            }
            if ( $PSBoundParameters.ContainsKey('ipv46') ) { $payload.Add('ipv46', $ipv46) }
            if ( $PSBoundParameters.ContainsKey('ippattern') ) { $payload.Add('ippattern', $ippattern) }
            if ( $PSBoundParameters.ContainsKey('ipmask') ) { $payload.Add('ipmask', $ipmask) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('ipset') ) { $payload.Add('ipset', $ipset) }
            if ( $PSBoundParameters.ContainsKey('range') ) { $payload.Add('range', $range) }
            if ( $PSBoundParameters.ContainsKey('persistencetype') ) { $payload.Add('persistencetype', $persistencetype) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('persistencebackup') ) { $payload.Add('persistencebackup', $persistencebackup) }
            if ( $PSBoundParameters.ContainsKey('backuppersistencetimeout') ) { $payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('lbmethod') ) { $payload.Add('lbmethod', $lbmethod) }
            if ( $PSBoundParameters.ContainsKey('hashlength') ) { $payload.Add('hashlength', $hashlength) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('v6netmasklen') ) { $payload.Add('v6netmasklen', $v6netmasklen) }
            if ( $PSBoundParameters.ContainsKey('backuplbmethod') ) { $payload.Add('backuplbmethod', $backuplbmethod) }
            if ( $PSBoundParameters.ContainsKey('cookiename') ) { $payload.Add('cookiename', $cookiename) }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('listenpolicy') ) { $payload.Add('listenpolicy', $listenpolicy) }
            if ( $PSBoundParameters.ContainsKey('listenpriority') ) { $payload.Add('listenpriority', $listenpriority) }
            if ( $PSBoundParameters.ContainsKey('resrule') ) { $payload.Add('resrule', $resrule) }
            if ( $PSBoundParameters.ContainsKey('persistmask') ) { $payload.Add('persistmask', $persistmask) }
            if ( $PSBoundParameters.ContainsKey('v6persistmasklen') ) { $payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ( $PSBoundParameters.ContainsKey('rtspnat') ) { $payload.Add('rtspnat', $rtspnat) }
            if ( $PSBoundParameters.ContainsKey('m') ) { $payload.Add('m', $m) }
            if ( $PSBoundParameters.ContainsKey('tosid') ) { $payload.Add('tosid', $tosid) }
            if ( $PSBoundParameters.ContainsKey('datalength') ) { $payload.Add('datalength', $datalength) }
            if ( $PSBoundParameters.ContainsKey('dataoffset') ) { $payload.Add('dataoffset', $dataoffset) }
            if ( $PSBoundParameters.ContainsKey('sessionless') ) { $payload.Add('sessionless', $sessionless) }
            if ( $PSBoundParameters.ContainsKey('trofspersistence') ) { $payload.Add('trofspersistence', $trofspersistence) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('connfailover') ) { $payload.Add('connfailover', $connfailover) }
            if ( $PSBoundParameters.ContainsKey('redirurl') ) { $payload.Add('redirurl', $redirurl) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('somethod') ) { $payload.Add('somethod', $somethod) }
            if ( $PSBoundParameters.ContainsKey('sopersistence') ) { $payload.Add('sopersistence', $sopersistence) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('healththreshold') ) { $payload.Add('healththreshold', $healththreshold) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('sobackupaction') ) { $payload.Add('sobackupaction', $sobackupaction) }
            if ( $PSBoundParameters.ContainsKey('redirectportrewrite') ) { $payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('insertvserveripport') ) { $payload.Add('insertvserveripport', $insertvserveripport) }
            if ( $PSBoundParameters.ContainsKey('vipheader') ) { $payload.Add('vipheader', $vipheader) }
            if ( $PSBoundParameters.ContainsKey('authenticationhost') ) { $payload.Add('authenticationhost', $authenticationhost) }
            if ( $PSBoundParameters.ContainsKey('authentication') ) { $payload.Add('authentication', $authentication) }
            if ( $PSBoundParameters.ContainsKey('authn401') ) { $payload.Add('authn401', $authn401) }
            if ( $PSBoundParameters.ContainsKey('authnvsname') ) { $payload.Add('authnvsname', $authnvsname) }
            if ( $PSBoundParameters.ContainsKey('push') ) { $payload.Add('push', $push) }
            if ( $PSBoundParameters.ContainsKey('pushvserver') ) { $payload.Add('pushvserver', $pushvserver) }
            if ( $PSBoundParameters.ContainsKey('pushlabel') ) { $payload.Add('pushlabel', $pushlabel) }
            if ( $PSBoundParameters.ContainsKey('pushmulticlients') ) { $payload.Add('pushmulticlients', $pushmulticlients) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('dbprofilename') ) { $payload.Add('dbprofilename', $dbprofilename) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('l2conn') ) { $payload.Add('l2conn', $l2conn) }
            if ( $PSBoundParameters.ContainsKey('oracleserverversion') ) { $payload.Add('oracleserverversion', $oracleserverversion) }
            if ( $PSBoundParameters.ContainsKey('mssqlserverversion') ) { $payload.Add('mssqlserverversion', $mssqlserverversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlprotocolversion') ) { $payload.Add('mysqlprotocolversion', $mysqlprotocolversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlserverversion') ) { $payload.Add('mysqlserverversion', $mysqlserverversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlcharacterset') ) { $payload.Add('mysqlcharacterset', $mysqlcharacterset) }
            if ( $PSBoundParameters.ContainsKey('mysqlservercapabilities') ) { $payload.Add('mysqlservercapabilities', $mysqlservercapabilities) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('icmpvsrresponse') ) { $payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ( $PSBoundParameters.ContainsKey('rhistate') ) { $payload.Add('rhistate', $rhistate) }
            if ( $PSBoundParameters.ContainsKey('newservicerequest') ) { $payload.Add('newservicerequest', $newservicerequest) }
            if ( $PSBoundParameters.ContainsKey('newservicerequestunit') ) { $payload.Add('newservicerequestunit', $newservicerequestunit) }
            if ( $PSBoundParameters.ContainsKey('newservicerequestincrementinterval') ) { $payload.Add('newservicerequestincrementinterval', $newservicerequestincrementinterval) }
            if ( $PSBoundParameters.ContainsKey('minautoscalemembers') ) { $payload.Add('minautoscalemembers', $minautoscalemembers) }
            if ( $PSBoundParameters.ContainsKey('maxautoscalemembers') ) { $payload.Add('maxautoscalemembers', $maxautoscalemembers) }
            if ( $PSBoundParameters.ContainsKey('persistavpno') ) { $payload.Add('persistavpno', $persistavpno) }
            if ( $PSBoundParameters.ContainsKey('skippersistency') ) { $payload.Add('skippersistency', $skippersistency) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('authnprofile') ) { $payload.Add('authnprofile', $authnprofile) }
            if ( $PSBoundParameters.ContainsKey('macmoderetainvlan') ) { $payload.Add('macmoderetainvlan', $macmoderetainvlan) }
            if ( $PSBoundParameters.ContainsKey('dbslb') ) { $payload.Add('dbslb', $dbslb) }
            if ( $PSBoundParameters.ContainsKey('dns64') ) { $payload.Add('dns64', $dns64) }
            if ( $PSBoundParameters.ContainsKey('bypassaaaa') ) { $payload.Add('bypassaaaa', $bypassaaaa) }
            if ( $PSBoundParameters.ContainsKey('recursionavailable') ) { $payload.Add('recursionavailable', $recursionavailable) }
            if ( $PSBoundParameters.ContainsKey('processlocal') ) { $payload.Add('processlocal', $processlocal) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('lbprofilename') ) { $payload.Add('lbprofilename', $lbprofilename) }
            if ( $PSBoundParameters.ContainsKey('redirectfromport') ) { $payload.Add('redirectfromport', $redirectfromport) }
            if ( $PSBoundParameters.ContainsKey('httpsredirecturl') ) { $payload.Add('httpsredirecturl', $httpsredirecturl) }
            if ( $PSBoundParameters.ContainsKey('retainconnectionsoncluster') ) { $payload.Add('retainconnectionsoncluster', $retainconnectionsoncluster) }
            if ( $PSBoundParameters.ContainsKey('adfsproxyprofile') ) { $payload.Add('adfsproxyprofile', $adfsproxyprofile) }
            if ( $PSBoundParameters.ContainsKey('tcpprobeport') ) { $payload.Add('tcpprobeport', $tcpprobeport) }
            if ( $PSBoundParameters.ContainsKey('quicprofilename') ) { $payload.Add('quicprofilename', $quicprofilename) }
            if ( $PSBoundParameters.ContainsKey('quicbridgeprofilename') ) { $payload.Add('quicbridgeprofilename', $quicbridgeprofilename) }
            if ( $PSBoundParameters.ContainsKey('probeprotocol') ) { $payload.Add('probeprotocol', $probeprotocol) }
            if ( $PSBoundParameters.ContainsKey('probesuccessresponsecode') ) { $payload.Add('probesuccessresponsecode', $probesuccessresponsecode) }
            if ( $PSBoundParameters.ContainsKey('probeport') ) { $payload.Add('probeport', $probeport) }
            if ( $PSCmdlet.ShouldProcess("lbvserver", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lbvserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserver -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserver: Finished"
    }
}

function Invoke-ADCDeleteLbvserver {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserver -Name <string>
        An example how to delete lbvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver/
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
        Write-Verbose "Invoke-ADCDeleteLbvserver: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserver: Finished"
    }
}

function Invoke-ADCUpdateLbvserver {
    <#
    .SYNOPSIS
        Update Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Ipv46 
        IPv4 or IPv6 address to assign to the virtual server. 
    .PARAMETER Ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current lb vserver. 
    .PARAMETER Ippattern 
        IP address pattern, in dotted decimal notation, for identifying packets to be accepted by the virtual server. The IP Mask parameter specifies which part of the destination IP address is matched against the pattern. Mutually exclusive with the IP Address parameter. 
        For example, if the IP pattern assigned to the virtual server is 198.51.100.0 and the IP mask is 255.255.240.0 (a forward mask), the first 20 bits in the destination IP addresses are matched with the first 20 bits in the pattern. The virtual server accepts requests with IP addresses that range from 198.51.96.1 to 198.51.111.254. You can also use a pattern such as 0.0.2.2 and a mask such as 0.0.255.255 (a reverse mask). 
        If a destination IP address matches more than one IP pattern, the pattern with the longest match is selected, and the associated virtual server processes the request. For example, if virtual servers vs1 and vs2 have the same IP pattern, 0.0.100.128, but different IP masks of 0.0.255.255 and 0.0.224.255, a destination IP address of 198.51.100.128 has the longest match with the IP pattern of vs1. If a destination IP address matches two or more virtual servers to the same extent, the request is processed by the virtual server whose port number matches the port number in the request. 
    .PARAMETER Ipmask 
        IP mask, in dotted decimal notation, for the IP Pattern parameter. Can have leading or trailing non-zero octets (for example, 255.255.240.0 or 0.0.255.255). Accordingly, the mask specifies whether the first n bits or the last n bits of the destination IP address in a client request are to be matched with the corresponding bits in the IP pattern. The former is called a forward mask. The latter is called a reverse mask. 
    .PARAMETER Weight 
        Weight to assign to the specified service. 
    .PARAMETER Servicename 
        Service to bind to the virtual server. 
    .PARAMETER Persistencetype 
        Type of persistence for the virtual server. Available settings function as follows: 
        * SOURCEIP - Connections from the same client IP address belong to the same persistence session. 
        * COOKIEINSERT - Connections that have the same HTTP Cookie, inserted by a Set-Cookie directive from a server, belong to the same persistence session. 
        * SSLSESSION - Connections that have the same SSL Session ID belong to the same persistence session. 
        * CUSTOMSERVERID - Connections with the same server ID form part of the same session. For this persistence type, set the Server ID (CustomServerID) parameter for each service and configure the Rule parameter to identify the server ID in a request. 
        * RULE - All connections that match a user defined rule belong to the same persistence session. 
        * URLPASSIVE - Requests that have the same server ID in the URL query belong to the same persistence session. The server ID is the hexadecimal representation of the IP address and port of the service to which the request must be forwarded. This persistence type requires a rule to identify the server ID in the request. 
        * DESTIP - Connections to the same destination IP address belong to the same persistence session. 
        * SRCIPDESTIP - Connections that have the same source IP address and destination IP address belong to the same persistence session. 
        * CALLID - Connections that have the same CALL-ID SIP header belong to the same persistence session. 
        * RTSPSID - Connections that have the same RTSP Session ID belong to the same persistence session. 
        * FIXSESSION - Connections that have the same SenderCompID and TargetCompID values belong to the same persistence session. 
        * USERSESSION - Persistence session is created based on the persistence parameter value provided from an extension. 
        Possible values = SOURCEIP, COOKIEINSERT, SSLSESSION, RULE, URLPASSIVE, CUSTOMSERVERID, DESTIP, SRCIPDESTIP, CALLID, RTSPSID, DIAMETER, FIXSESSION, USERSESSION, NONE 
    .PARAMETER Timeout 
        Time period for which a persistence session is in effect. 
    .PARAMETER Persistencebackup 
        Backup persistence type for the virtual server. Becomes operational if the primary persistence mechanism fails. 
        Possible values = SOURCEIP, NONE 
    .PARAMETER Backuppersistencetimeout 
        Time period for which backup persistence is in effect. 
    .PARAMETER Lbmethod 
        Load balancing method. The available settings function as follows: 
        * ROUNDROBIN - Distribute requests in rotation, regardless of the load. Weights can be assigned to services to enforce weighted round robin distribution. 
        * LEASTCONNECTION (default) - Select the service with the fewest connections. 
        * LEASTRESPONSETIME - Select the service with the lowest average response time. 
        * LEASTBANDWIDTH - Select the service currently handling the least traffic. 
        * LEASTPACKETS - Select the service currently serving the lowest number of packets per second. 
        * CUSTOMLOAD - Base service selection on the SNMP metrics obtained by custom load monitors. 
        * LRTM - Select the service with the lowest response time. Response times are learned through monitoring probes. This method also takes the number of active connections into account. 
        Also available are a number of hashing methods, in which the appliance extracts a predetermined portion of the request, creates a hash of the portion, and then checks whether any previous requests had the same hash value. If it finds a match, it forwards the request to the service that served those previous requests. Following are the hashing methods: 
        * URLHASH - Create a hash of the request URL (or part of the URL). 
        * DOMAINHASH - Create a hash of the domain name in the request (or part of the domain name). The domain name is taken from either the URL or the Host header. If the domain name appears in both locations, the URL is preferred. If the request does not contain a domain name, the load balancing method defaults to LEASTCONNECTION. 
        * DESTINATIONIPHASH - Create a hash of the destination IP address in the IP header. 
        * SOURCEIPHASH - Create a hash of the source IP address in the IP header. 
        * TOKEN - Extract a token from the request, create a hash of the token, and then select the service to which any previous requests with the same token hash value were sent. 
        * SRCIPDESTIPHASH - Create a hash of the string obtained by concatenating the source IP address and destination IP address in the IP header. 
        * SRCIPSRCPORTHASH - Create a hash of the source IP address and source port in the IP header. 
        * CALLIDHASH - Create a hash of the SIP Call-ID header. 
        * USER_TOKEN - Same as TOKEN LB method but token needs to be provided from an extension. 
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, URLHASH, DOMAINHASH, DESTINATIONIPHASH, SOURCEIPHASH, SRCIPDESTIPHASH, LEASTBANDWIDTH, LEASTPACKETS, TOKEN, SRCIPSRCPORTHASH, LRTM, CALLIDHASH, CUSTOMLOAD, LEASTREQUEST, AUDITLOGHASH, STATICPROXIMITY, USER_TOKEN 
    .PARAMETER Hashlength 
        Number of bytes to consider for the hash value used in the URLHASH and DOMAINHASH load balancing methods. 
    .PARAMETER Netmask 
        IPv4 subnet mask to apply to the destination IP address or source IP address when the load balancing method is DESTINATIONIPHASH or SOURCEIPHASH. 
    .PARAMETER V6netmasklen 
        Number of bits to consider in an IPv6 destination or source IP address, for creating the hash that is required by the DESTINATIONIPHASH and SOURCEIPHASH load balancing methods. 
    .PARAMETER Backuplbmethod 
        Backup load balancing method. Becomes operational if the primary load balancing me 
        thod fails or cannot be used. 
        Valid only if the primary method is based on static proximity. 
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, CUSTOMLOAD 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Cookiename 
        Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
    .PARAMETER Resrule 
        Expression specifying which part of a server's response to use for creating rule based persistence sessions (persistence type RULE). Can be either an expression or the name of a named expression. 
        Example: 
        HTTP.RES.HEADER("setcookie").VALUE(0).TYPECAST_NVLIST_T('=',';').VALUE("server1"). 
    .PARAMETER Persistmask 
        Persistence mask for IP based persistence types, for IPv4 virtual servers. 
    .PARAMETER V6persistmasklen 
        Persistence mask for IP based persistence types, for IPv6 virtual servers. 
    .PARAMETER Rtspnat 
        Use network address translation (NAT) for RTSP data connections. 
        Possible values = ON, OFF 
    .PARAMETER M 
        Redirection mode for load balancing. Available settings function as follows: 
        * IP - Before forwarding a request to a server, change the destination IP address to the server's IP address. 
        * MAC - Before forwarding a request to a server, change the destination MAC address to the server's MAC address. The destination IP address is not changed. MAC-based redirection mode is used mostly in firewall load balancing deployments. 
        * IPTUNNEL - Perform IP-in-IP encapsulation for client IP packets. In the outer IP headers, set the destination IP address to the IP address of the server and the source IP address to the subnet IP (SNIP). The client IP packets are not modified. Applicable to both IPv4 and IPv6 packets. 
        * TOS - Encode the virtual server's TOS ID in the TOS field of the IP header. 
        You can use either the IPTUNNEL or the TOS option to implement Direct Server Return (DSR). 
        Possible values = IP, MAC, IPTUNNEL, TOS 
    .PARAMETER Tosid 
        TOS ID of the virtual server. Applicable only when the load balancing redirection mode is set to TOS. 
    .PARAMETER Datalength 
        Length of the token to be extracted from the data segment of an incoming packet, for use in the token method of load balancing. The length of the token, specified in bytes, must not be greater than 24 KB. Applicable to virtual servers of type TCP. 
    .PARAMETER Dataoffset 
        Offset to be considered when extracting a token from the TCP payload. Applicable to virtual servers, of type TCP, using the token method of load balancing. Must be within the first 24 KB of the TCP payload. 
    .PARAMETER Sessionless 
        Perform load balancing on a per-packet basis, without establishing sessions. Recommended for load balancing of intrusion detection system (IDS) servers and scenarios involving direct server return (DSR), where session information is unnecessary. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Trofspersistence 
        When value is ENABLED, Trofs persistence is honored. When value is DISABLED, Trofs persistence is not honored. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Connfailover 
        Mode in which the connection failover feature must operate for the virtual server. After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary appliance. Clients remain connected to the same servers. Available settings function as follows: 
        * STATEFUL - The primary appliance shares state information with the secondary appliance, in real time, resulting in some runtime processing overhead. 
        * STATELESS - State information is not shared, and the new primary appliance tries to re-create the packet flow on the basis of the information contained in the packets it receives. 
        * DISABLED - Connection failover does not occur. 
        Possible values = DISABLED, STATEFUL, STATELESS 
    .PARAMETER Backupvserver 
        Name of the backup virtual server to which to forward requests if the primary virtual server goes DOWN or reaches its spillover threshold. 
    .PARAMETER Redirurl 
        URL to which to redirect traffic if the virtual server becomes unavailable. 
        WARNING! Make sure that the domain in the URL does not match the domain specified for a content switching policy. If it does, requests are continuously redirected to the unavailable virtual server. 
    .PARAMETER Cacheable 
        Route cacheable requests to a cache redirection virtual server. The load balancing virtual server can forward requests only to a transparent cache redirection virtual server that has an IP address and port combination of *:80, so such a cache redirection virtual server must be configured on the appliance. 
        Possible values = YES, NO 
    .PARAMETER Clttimeout 
        Idle time, in seconds, after which a client connection is terminated. 
    .PARAMETER Somethod 
        Type of threshold that, when exceeded, triggers spillover. Available settings function as follows: 
        * CONNECTION - Spillover occurs when the number of client connections exceeds the threshold. 
        * DYNAMICCONNECTION - Spillover occurs when the number of client connections at the virtual server exceeds the sum of the maximum client (Max Clients) settings for bound services. Do not specify a spillover threshold for this setting, because the threshold is implied by the Max Clients settings of bound services. 
        * BANDWIDTH - Spillover occurs when the bandwidth consumed by the virtual server's incoming and outgoing traffic exceeds the threshold. 
        * HEALTH - Spillover occurs when the percentage of weights of the services that are UP drops below the threshold. For example, if services svc1, svc2, and svc3 are bound to a virtual server, with weights 1, 2, and 3, and the spillover threshold is 50%, spillover occurs if svc1 and svc3 or svc2 and svc3 transition to DOWN. 
        * NONE - Spillover does not occur. 
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER Sothreshold 
        Threshold at which spillover occurs. Specify an integer for the CONNECTION spillover method, a bandwidth value in kilobits per second for the BANDWIDTH method (do not enter the units), or a percentage for the HEALTH method (do not enter the percentage symbol). 
    .PARAMETER Sopersistence 
        If spillover occurs, maintain source IP address based persistence for both primary and backup virtual servers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sopersistencetimeout 
        Timeout for spillover persistence, in minutes. 
    .PARAMETER Healththreshold 
        Threshold in percent of active services below which vserver state is made down. If this threshold is 0, vserver state will be up even if one bound service is up. 
    .PARAMETER Sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists. 
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER Redirectportrewrite 
        Rewrite the port and change the protocol to ensure successful HTTP redirects from services. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with a virtual server whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Insertvserveripport 
        Insert an HTTP header, whose value is the IP address and port number of the virtual server, before forwarding a request to the server. The format of the header is <vipHeader>: <virtual server IP address>_<port number >, where vipHeader is the name that you specify for the header. If the virtual server has an IPv6 address, the address in the header is enclosed in brackets ([ and ]) to separate it from the port number. If you have mapped an IPv4 address to a virtual server's IPv6 address, the value of this parameter determines which IP address is inserted in the header, as follows: 
        * VIPADDR - Insert the IP address of the virtual server in the HTTP header regardless of whether the virtual server has an IPv4 address or an IPv6 address. A mapped IPv4 address, if configured, is ignored. 
        * V6TOV4MAPPING - Insert the IPv4 address that is mapped to the virtual server's IPv6 address. If a mapped IPv4 address is not configured, insert the IPv6 address. 
        * OFF - Disable header insertion. 
        Possible values = OFF, VIPADDR, V6TOV4MAPPING 
    .PARAMETER Vipheader 
        Name for the inserted header. The default name is vip-header. 
    .PARAMETER Disableprimaryondown 
        If the primary virtual server goes down, do not allow it to return to primary status until manually enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Authenticationhost 
        Fully qualified domain name (FQDN) of the authentication virtual server to which the user must be redirected for authentication. Make sure that the Authentication parameter is set to ENABLED. 
    .PARAMETER Authentication 
        Enable or disable user authentication. 
        Possible values = ON, OFF 
    .PARAMETER Authn401 
        Enable or disable user authentication with HTTP 401 responses. 
        Possible values = ON, OFF 
    .PARAMETER Authnvsname 
        Name of an authentication virtual server with which to authenticate users. 
    .PARAMETER Push 
        Process traffic with the push virtual server that is bound to this load balancing virtual server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pushvserver 
        Name of the load balancing virtual server, of type PUSH or SSL_PUSH, to which the server pushes updates received on the load balancing virtual server that you are configuring. 
    .PARAMETER Pushlabel 
        Expression for extracting a label from the server's response. Can be either an expression or the name of a named expression. 
    .PARAMETER Pushmulticlients 
        Allow multiple Web 2.0 connections from the same client to connect to the virtual server and expect updates. 
        Possible values = YES, NO 
    .PARAMETER Listenpolicy 
        Expression identifying traffic accepted by the virtual server. Can be either an expression (for example, CLIENT.IP.DST.IN_SUBNET(192.0.2.0/24) or the name of a named expression. In the above example, the virtual server accepts all requests whose destination IP address is in the 192.0.2.0/24 subnet. 
    .PARAMETER Listenpriority 
        Integer specifying the priority of the listen policy. A higher number specifies a lower priority. If a request matches the listen policies of more than one virtual server the virtual server whose listen policy has the highest priority (the lowest priority number) accepts the request. 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile whose settings are to be applied to the virtual server. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile whose settings are to be applied to the virtual server. 
    .PARAMETER Dbprofilename 
        Name of the DB profile whose settings are to be applied to the virtual server. 
    .PARAMETER Comment 
        Any comments that you might want to associate with the virtual server. 
    .PARAMETER L2conn 
        Use Layer 2 parameters (channel number, MAC address, and VLAN ID) in addition to the 4-tuple (<source IP>:<source port>::<destination IP>:<destination port>) that is used to identify a connection. Allows multiple TCP and non-TCP connections with the same 4-tuple to co-exist on the Citrix ADC. 
        Possible values = ON, OFF 
    .PARAMETER Oracleserverversion 
        Oracle server version. 
        Possible values = 10G, 11G 
    .PARAMETER Mssqlserverversion 
        For a load balancing virtual server of type MSSQL, the Microsoft SQL Server version. Set this parameter if you expect some clients to run a version different from the version of the database. This setting provides compatibility between the client-side and server-side connections by ensuring that all communication conforms to the server's version. 
        Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
    .PARAMETER Mysqlprotocolversion 
        MySQL protocol version that the virtual server advertises to clients. 
    .PARAMETER Mysqlserverversion 
        MySQL server version string that the virtual server advertises to clients. 
    .PARAMETER Mysqlcharacterset 
        Character set that the virtual server advertises to clients. 
    .PARAMETER Mysqlservercapabilities 
        Server capabilities that the virtual server advertises to clients. 
    .PARAMETER Appflowlog 
        Apply AppFlow logging to the virtual server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Name of the network profile to associate with the virtual server. If you set this parameter, the virtual server uses only the IP addresses in the network profile as source IP addresses when initiating connections with servers. 
    .PARAMETER Icmpvsrresponse 
        How the Citrix ADC responds to ping requests received for an IP address that is common to one or more virtual servers. Available settings function as follows: 
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always responds to the ping requests. 
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance responds to the ping requests if at least one of the virtual servers is UP. Otherwise, the appliance does not respond. 
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance responds if at least one virtual server with the ACTIVE setting is UP. Otherwise, the appliance does not respond. 
        Note: This parameter is available at the virtual server level. A similar parameter, ICMP Response, is available at the IP address level, for IPv4 addresses of type VIP. To set that parameter, use the add ip command in the CLI or the Create IP dialog box in the GUI. 
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Rhistate 
        Route Health Injection (RHI) functionality of the NetSaler appliance for advertising the route of the VIP address associated with the virtual server. When Vserver RHI Level (RHI) parameter is set to VSVR_CNTRLD, the following are different RHI behaviors for the VIP address on the basis of RHIstate (RHI STATE) settings on the virtual servers associated with the VIP address: 
        * If you set RHI STATE to PASSIVE on all virtual servers, the Citrix ADC always advertises the route for the VIP address. 
        * If you set RHI STATE to ACTIVE on all virtual servers, the Citrix ADC advertises the route for the VIP address if at least one of the associated virtual servers is in UP state. 
        * If you set RHI STATE to ACTIVE on some and PASSIVE on others, the Citrix ADC advertises the route for the VIP address if at least one of the associated virtual servers, whose RHI STATE set to ACTIVE, is in UP state. 
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Newservicerequest 
        Number of requests, or percentage of the load on existing services, by which to increase the load on a new service at each interval in slow-start mode. A non-zero value indicates that slow-start is applicable. A zero value indicates that the global RR startup parameter is applied. Changing the value to zero will cause services currently in slow start to take the full traffic as determined by the LB method. Subsequently, any new services added will use the global RR factor. 
    .PARAMETER Newservicerequestunit 
        Units in which to increment load at each interval in slow-start mode. 
        Possible values = PER_SECOND, PERCENT 
    .PARAMETER Newservicerequestincrementinterval 
        Interval, in seconds, between successive increments in the load on a new service or a service whose state has just changed from DOWN to UP. A value of 0 (zero) specifies manual slow start. 
    .PARAMETER Minautoscalemembers 
        Minimum number of members expected to be present when vserver is used in Autoscale. 
    .PARAMETER Maxautoscalemembers 
        Maximum number of members expected to be present when vserver is used in Autoscale. 
    .PARAMETER Persistavpno 
        Persist AVP number for Diameter Persistency. 
        In case this AVP is not defined in Base RFC 3588 and it is nested inside a Grouped AVP, 
        define a sequence of AVP numbers (max 3) in order of parent to child. So say persist AVP number X 
        is nested inside AVP Y which is nested in Z, then define the list as Z Y X. 
    .PARAMETER Skippersistency 
        This argument decides the behavior incase the service which is selected from an existing persistence session has reached threshold. 
        Possible values = Bypass, ReLb, None 
    .PARAMETER Authnprofile 
        Name of the authentication profile to be used when authentication is turned on. 
    .PARAMETER Macmoderetainvlan 
        This option is used to retain vlan information of incoming packet when macmode is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dbslb 
        Enable database specific load balancing for MySQL and MSSQL service types. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dns64 
        This argument is for enabling/disabling the dns64 on lbvserver. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Bypassaaaa 
        If this option is enabled while resolving DNS64 query AAAA queries are not sent to back end dns server. 
        Possible values = YES, NO 
    .PARAMETER Recursionavailable 
        When set to YES, this option causes the DNS replies from this vserver to have the RA bit turned on. Typically one would set this option to YES, when the vserver is load balancing a set of DNS servers thatsupport recursive queries. 
        Possible values = YES, NO 
    .PARAMETER Processlocal 
        By turning on this option packets destined to a vserver in a cluster will not under go any steering. Turn this option for single packet request response mode or when the upstream device is performing a proper RSS for connection based distribution. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the VServer. DNS profile properties will be applied to the transactions processed by a VServer. This parameter is valid only for DNS and DNS-TCP VServers. 
    .PARAMETER Lbprofilename 
        Name of the LB profile which is associated to the vserver. 
    .PARAMETER Redirectfromport 
        Port number for the virtual server, from which we absorb the traffic for http redirect. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Httpsredirecturl 
        URL to which all HTTP traffic received on the port specified in the -redirectFromPort parameter is redirected. 
    .PARAMETER Retainconnectionsoncluster 
        This option enables you to retain existing connections on a node joining a Cluster system or when a node is being configured for passive timeout. By default, this option is disabled. 
        Possible values = YES, NO 
    .PARAMETER Adfsproxyprofile 
        Name of the adfsProxy profile to be used to support ADFSPIP protocol for ADFS servers. 
    .PARAMETER Tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Quicprofilename 
        Name of QUIC profile which will be attached to the VServer. 
    .PARAMETER Quicbridgeprofilename 
        Name of the QUIC Bridge profile whose settings are to be applied to the virtual server. 
    .PARAMETER Probeport 
        Citrix ADC provides support for external health check of the vserver status. Select port for HTTP/TCP monitring. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Probeprotocol 
        Citrix ADC provides support for external health check of the vserver status. Select HTTP or TCP probes for healthcheck. 
        Possible values = TCP, HTTP 
    .PARAMETER Probesuccessresponsecode 
        HTTP code to return in SUCCESS case. 
    .PARAMETER PassThru 
        Return details about the created lbvserver item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLbvserver -name <string>
        An example how to update lbvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLbvserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver/
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

        [string]$Ipv46,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipset,

        [string]$Ippattern,

        [string]$Ipmask,

        [ValidateRange(1, 100)]
        [double]$Weight,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servicename,

        [ValidateSet('SOURCEIP', 'COOKIEINSERT', 'SSLSESSION', 'RULE', 'URLPASSIVE', 'CUSTOMSERVERID', 'DESTIP', 'SRCIPDESTIP', 'CALLID', 'RTSPSID', 'DIAMETER', 'FIXSESSION', 'USERSESSION', 'NONE')]
        [string]$Persistencetype,

        [ValidateRange(0, 1440)]
        [double]$Timeout,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$Persistencebackup,

        [ValidateRange(2, 1440)]
        [double]$Backuppersistencetimeout,

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'URLHASH', 'DOMAINHASH', 'DESTINATIONIPHASH', 'SOURCEIPHASH', 'SRCIPDESTIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'TOKEN', 'SRCIPSRCPORTHASH', 'LRTM', 'CALLIDHASH', 'CUSTOMLOAD', 'LEASTREQUEST', 'AUDITLOGHASH', 'STATICPROXIMITY', 'USER_TOKEN')]
        [string]$Lbmethod,

        [ValidateRange(1, 4096)]
        [double]$Hashlength,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Netmask,

        [ValidateRange(1, 128)]
        [double]$V6netmasklen,

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'SOURCEIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'CUSTOMLOAD')]
        [string]$Backuplbmethod,

        [string]$Rule,

        [string]$Cookiename,

        [string]$Resrule,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Persistmask,

        [ValidateRange(1, 128)]
        [double]$V6persistmasklen,

        [ValidateSet('ON', 'OFF')]
        [string]$Rtspnat,

        [ValidateSet('IP', 'MAC', 'IPTUNNEL', 'TOS')]
        [string]$M,

        [ValidateRange(1, 63)]
        [double]$Tosid,

        [ValidateRange(1, 100)]
        [double]$Datalength,

        [ValidateRange(0, 25400)]
        [double]$Dataoffset,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sessionless,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Trofspersistence,

        [ValidateSet('DISABLED', 'STATEFUL', 'STATELESS')]
        [string]$Connfailover,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backupvserver,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Redirurl,

        [ValidateSet('YES', 'NO')]
        [string]$Cacheable,

        [ValidateRange(0, 31536000)]
        [double]$Clttimeout,

        [ValidateSet('CONNECTION', 'DYNAMICCONNECTION', 'BANDWIDTH', 'HEALTH', 'NONE')]
        [string]$Somethod,

        [ValidateRange(1, 4294967287)]
        [double]$Sothreshold,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sopersistence,

        [ValidateRange(2, 1440)]
        [double]$Sopersistencetimeout,

        [ValidateRange(0, 100)]
        [double]$Healththreshold,

        [ValidateSet('DROP', 'ACCEPT', 'REDIRECT')]
        [string]$Sobackupaction,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Redirectportrewrite,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush,

        [ValidateSet('OFF', 'VIPADDR', 'V6TOV4MAPPING')]
        [string]$Insertvserveripport,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Vipheader,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Disableprimaryondown,

        [ValidateLength(3, 252)]
        [string]$Authenticationhost,

        [ValidateSet('ON', 'OFF')]
        [string]$Authentication,

        [ValidateSet('ON', 'OFF')]
        [string]$Authn401,

        [ValidateLength(1, 252)]
        [string]$Authnvsname,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Push,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Pushvserver,

        [string]$Pushlabel,

        [ValidateSet('YES', 'NO')]
        [string]$Pushmulticlients,

        [string]$Listenpolicy,

        [ValidateRange(0, 101)]
        [double]$Listenpriority,

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateLength(1, 127)]
        [string]$Httpprofilename,

        [ValidateLength(1, 127)]
        [string]$Dbprofilename,

        [string]$Comment,

        [ValidateSet('ON', 'OFF')]
        [string]$L2conn,

        [ValidateSet('10G', '11G')]
        [string]$Oracleserverversion,

        [ValidateSet('70', '2000', '2000SP1', '2005', '2008', '2008R2', '2012', '2014')]
        [string]$Mssqlserverversion,

        [double]$Mysqlprotocolversion,

        [ValidateLength(1, 31)]
        [string]$Mysqlserverversion,

        [double]$Mysqlcharacterset,

        [double]$Mysqlservercapabilities,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog,

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Icmpvsrresponse,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Rhistate,

        [double]$Newservicerequest,

        [ValidateSet('PER_SECOND', 'PERCENT')]
        [string]$Newservicerequestunit,

        [ValidateRange(0, 3600)]
        [double]$Newservicerequestincrementinterval,

        [ValidateRange(0, 5000)]
        [double]$Minautoscalemembers,

        [ValidateRange(0, 5000)]
        [double]$Maxautoscalemembers,

        [double[]]$Persistavpno,

        [ValidateSet('Bypass', 'ReLb', 'None')]
        [string]$Skippersistency,

        [string]$Authnprofile,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Macmoderetainvlan,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dbslb,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dns64,

        [ValidateSet('YES', 'NO')]
        [string]$Bypassaaaa,

        [ValidateSet('YES', 'NO')]
        [string]$Recursionavailable,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Processlocal,

        [ValidateLength(1, 127)]
        [string]$Dnsprofilename,

        [string]$Lbprofilename,

        [ValidateRange(1, 65535)]
        [int]$Redirectfromport,

        [string]$Httpsredirecturl,

        [ValidateSet('YES', 'NO')]
        [string]$Retainconnectionsoncluster,

        [string]$Adfsproxyprofile,

        [ValidateRange(1, 65535)]
        [int]$Tcpprobeport,

        [ValidateLength(1, 255)]
        [string]$Quicprofilename,

        [ValidateLength(1, 127)]
        [string]$Quicbridgeprofilename,

        [ValidateRange(1, 65535)]
        [int]$Probeport,

        [ValidateSet('TCP', 'HTTP')]
        [string]$Probeprotocol,

        [ValidateLength(1, 64)]
        [string]$Probesuccessresponsecode,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLbvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipv46') ) { $payload.Add('ipv46', $ipv46) }
            if ( $PSBoundParameters.ContainsKey('ipset') ) { $payload.Add('ipset', $ipset) }
            if ( $PSBoundParameters.ContainsKey('ippattern') ) { $payload.Add('ippattern', $ippattern) }
            if ( $PSBoundParameters.ContainsKey('ipmask') ) { $payload.Add('ipmask', $ipmask) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('servicename') ) { $payload.Add('servicename', $servicename) }
            if ( $PSBoundParameters.ContainsKey('persistencetype') ) { $payload.Add('persistencetype', $persistencetype) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('persistencebackup') ) { $payload.Add('persistencebackup', $persistencebackup) }
            if ( $PSBoundParameters.ContainsKey('backuppersistencetimeout') ) { $payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('lbmethod') ) { $payload.Add('lbmethod', $lbmethod) }
            if ( $PSBoundParameters.ContainsKey('hashlength') ) { $payload.Add('hashlength', $hashlength) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('v6netmasklen') ) { $payload.Add('v6netmasklen', $v6netmasklen) }
            if ( $PSBoundParameters.ContainsKey('backuplbmethod') ) { $payload.Add('backuplbmethod', $backuplbmethod) }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('cookiename') ) { $payload.Add('cookiename', $cookiename) }
            if ( $PSBoundParameters.ContainsKey('resrule') ) { $payload.Add('resrule', $resrule) }
            if ( $PSBoundParameters.ContainsKey('persistmask') ) { $payload.Add('persistmask', $persistmask) }
            if ( $PSBoundParameters.ContainsKey('v6persistmasklen') ) { $payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ( $PSBoundParameters.ContainsKey('rtspnat') ) { $payload.Add('rtspnat', $rtspnat) }
            if ( $PSBoundParameters.ContainsKey('m') ) { $payload.Add('m', $m) }
            if ( $PSBoundParameters.ContainsKey('tosid') ) { $payload.Add('tosid', $tosid) }
            if ( $PSBoundParameters.ContainsKey('datalength') ) { $payload.Add('datalength', $datalength) }
            if ( $PSBoundParameters.ContainsKey('dataoffset') ) { $payload.Add('dataoffset', $dataoffset) }
            if ( $PSBoundParameters.ContainsKey('sessionless') ) { $payload.Add('sessionless', $sessionless) }
            if ( $PSBoundParameters.ContainsKey('trofspersistence') ) { $payload.Add('trofspersistence', $trofspersistence) }
            if ( $PSBoundParameters.ContainsKey('connfailover') ) { $payload.Add('connfailover', $connfailover) }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('redirurl') ) { $payload.Add('redirurl', $redirurl) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('somethod') ) { $payload.Add('somethod', $somethod) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('sopersistence') ) { $payload.Add('sopersistence', $sopersistence) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('healththreshold') ) { $payload.Add('healththreshold', $healththreshold) }
            if ( $PSBoundParameters.ContainsKey('sobackupaction') ) { $payload.Add('sobackupaction', $sobackupaction) }
            if ( $PSBoundParameters.ContainsKey('redirectportrewrite') ) { $payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('insertvserveripport') ) { $payload.Add('insertvserveripport', $insertvserveripport) }
            if ( $PSBoundParameters.ContainsKey('vipheader') ) { $payload.Add('vipheader', $vipheader) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('authenticationhost') ) { $payload.Add('authenticationhost', $authenticationhost) }
            if ( $PSBoundParameters.ContainsKey('authentication') ) { $payload.Add('authentication', $authentication) }
            if ( $PSBoundParameters.ContainsKey('authn401') ) { $payload.Add('authn401', $authn401) }
            if ( $PSBoundParameters.ContainsKey('authnvsname') ) { $payload.Add('authnvsname', $authnvsname) }
            if ( $PSBoundParameters.ContainsKey('push') ) { $payload.Add('push', $push) }
            if ( $PSBoundParameters.ContainsKey('pushvserver') ) { $payload.Add('pushvserver', $pushvserver) }
            if ( $PSBoundParameters.ContainsKey('pushlabel') ) { $payload.Add('pushlabel', $pushlabel) }
            if ( $PSBoundParameters.ContainsKey('pushmulticlients') ) { $payload.Add('pushmulticlients', $pushmulticlients) }
            if ( $PSBoundParameters.ContainsKey('listenpolicy') ) { $payload.Add('listenpolicy', $listenpolicy) }
            if ( $PSBoundParameters.ContainsKey('listenpriority') ) { $payload.Add('listenpriority', $listenpriority) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('dbprofilename') ) { $payload.Add('dbprofilename', $dbprofilename) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('l2conn') ) { $payload.Add('l2conn', $l2conn) }
            if ( $PSBoundParameters.ContainsKey('oracleserverversion') ) { $payload.Add('oracleserverversion', $oracleserverversion) }
            if ( $PSBoundParameters.ContainsKey('mssqlserverversion') ) { $payload.Add('mssqlserverversion', $mssqlserverversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlprotocolversion') ) { $payload.Add('mysqlprotocolversion', $mysqlprotocolversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlserverversion') ) { $payload.Add('mysqlserverversion', $mysqlserverversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlcharacterset') ) { $payload.Add('mysqlcharacterset', $mysqlcharacterset) }
            if ( $PSBoundParameters.ContainsKey('mysqlservercapabilities') ) { $payload.Add('mysqlservercapabilities', $mysqlservercapabilities) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('icmpvsrresponse') ) { $payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ( $PSBoundParameters.ContainsKey('rhistate') ) { $payload.Add('rhistate', $rhistate) }
            if ( $PSBoundParameters.ContainsKey('newservicerequest') ) { $payload.Add('newservicerequest', $newservicerequest) }
            if ( $PSBoundParameters.ContainsKey('newservicerequestunit') ) { $payload.Add('newservicerequestunit', $newservicerequestunit) }
            if ( $PSBoundParameters.ContainsKey('newservicerequestincrementinterval') ) { $payload.Add('newservicerequestincrementinterval', $newservicerequestincrementinterval) }
            if ( $PSBoundParameters.ContainsKey('minautoscalemembers') ) { $payload.Add('minautoscalemembers', $minautoscalemembers) }
            if ( $PSBoundParameters.ContainsKey('maxautoscalemembers') ) { $payload.Add('maxautoscalemembers', $maxautoscalemembers) }
            if ( $PSBoundParameters.ContainsKey('persistavpno') ) { $payload.Add('persistavpno', $persistavpno) }
            if ( $PSBoundParameters.ContainsKey('skippersistency') ) { $payload.Add('skippersistency', $skippersistency) }
            if ( $PSBoundParameters.ContainsKey('authnprofile') ) { $payload.Add('authnprofile', $authnprofile) }
            if ( $PSBoundParameters.ContainsKey('macmoderetainvlan') ) { $payload.Add('macmoderetainvlan', $macmoderetainvlan) }
            if ( $PSBoundParameters.ContainsKey('dbslb') ) { $payload.Add('dbslb', $dbslb) }
            if ( $PSBoundParameters.ContainsKey('dns64') ) { $payload.Add('dns64', $dns64) }
            if ( $PSBoundParameters.ContainsKey('bypassaaaa') ) { $payload.Add('bypassaaaa', $bypassaaaa) }
            if ( $PSBoundParameters.ContainsKey('recursionavailable') ) { $payload.Add('recursionavailable', $recursionavailable) }
            if ( $PSBoundParameters.ContainsKey('processlocal') ) { $payload.Add('processlocal', $processlocal) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('lbprofilename') ) { $payload.Add('lbprofilename', $lbprofilename) }
            if ( $PSBoundParameters.ContainsKey('redirectfromport') ) { $payload.Add('redirectfromport', $redirectfromport) }
            if ( $PSBoundParameters.ContainsKey('httpsredirecturl') ) { $payload.Add('httpsredirecturl', $httpsredirecturl) }
            if ( $PSBoundParameters.ContainsKey('retainconnectionsoncluster') ) { $payload.Add('retainconnectionsoncluster', $retainconnectionsoncluster) }
            if ( $PSBoundParameters.ContainsKey('adfsproxyprofile') ) { $payload.Add('adfsproxyprofile', $adfsproxyprofile) }
            if ( $PSBoundParameters.ContainsKey('tcpprobeport') ) { $payload.Add('tcpprobeport', $tcpprobeport) }
            if ( $PSBoundParameters.ContainsKey('quicprofilename') ) { $payload.Add('quicprofilename', $quicprofilename) }
            if ( $PSBoundParameters.ContainsKey('quicbridgeprofilename') ) { $payload.Add('quicbridgeprofilename', $quicbridgeprofilename) }
            if ( $PSBoundParameters.ContainsKey('probeport') ) { $payload.Add('probeport', $probeport) }
            if ( $PSBoundParameters.ContainsKey('probeprotocol') ) { $payload.Add('probeprotocol', $probeprotocol) }
            if ( $PSBoundParameters.ContainsKey('probesuccessresponsecode') ) { $payload.Add('probesuccessresponsecode', $probesuccessresponsecode) }
            if ( $PSCmdlet.ShouldProcess("lbvserver", "Update Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserver -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateLbvserver: Finished"
    }
}

function Invoke-ADCUnsetLbvserver {
    <#
    .SYNOPSIS
        Unset Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Backupvserver 
        Name of the backup virtual server to which to forward requests if the primary virtual server goes DOWN or reaches its spillover threshold. 
    .PARAMETER Clttimeout 
        Idle time, in seconds, after which a client connection is terminated. 
    .PARAMETER Redirurl 
        URL to which to redirect traffic if the virtual server becomes unavailable. 
        WARNING! Make sure that the domain in the URL does not match the domain specified for a content switching policy. If it does, requests are continuously redirected to the unavailable virtual server. 
    .PARAMETER Redirurlflags 
        The redirect URL to be unset. 
    .PARAMETER Authn401 
        Enable or disable user authentication with HTTP 401 responses. 
        Possible values = ON, OFF 
    .PARAMETER Authentication 
        Enable or disable user authentication. 
        Possible values = ON, OFF 
    .PARAMETER Authenticationhost 
        Fully qualified domain name (FQDN) of the authentication virtual server to which the user must be redirected for authentication. Make sure that the Authentication parameter is set to ENABLED. 
    .PARAMETER Authnvsname 
        Name of an authentication virtual server with which to authenticate users. 
    .PARAMETER Pushvserver 
        Name of the load balancing virtual server, of type PUSH or SSL_PUSH, to which the server pushes updates received on the load balancing virtual server that you are configuring. 
    .PARAMETER Pushlabel 
        Expression for extracting a label from the server's response. Can be either an expression or the name of a named expression. 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile whose settings are to be applied to the virtual server. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile whose settings are to be applied to the virtual server. 
    .PARAMETER Dbprofilename 
        Name of the DB profile whose settings are to be applied to the virtual server. 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Sothreshold 
        Threshold at which spillover occurs. Specify an integer for the CONNECTION spillover method, a bandwidth value in kilobits per second for the BANDWIDTH method (do not enter the units), or a percentage for the HEALTH method (do not enter the percentage symbol). 
    .PARAMETER L2conn 
        Use Layer 2 parameters (channel number, MAC address, and VLAN ID) in addition to the 4-tuple (<source IP>:<source port>::<destination IP>:<destination port>) that is used to identify a connection. Allows multiple TCP and non-TCP connections with the same 4-tuple to co-exist on the Citrix ADC. 
        Possible values = ON, OFF 
    .PARAMETER Mysqlprotocolversion 
        MySQL protocol version that the virtual server advertises to clients. 
    .PARAMETER Mysqlserverversion 
        MySQL server version string that the virtual server advertises to clients. 
    .PARAMETER Mysqlcharacterset 
        Character set that the virtual server advertises to clients. 
    .PARAMETER Mysqlservercapabilities 
        Server capabilities that the virtual server advertises to clients. 
    .PARAMETER Appflowlog 
        Apply AppFlow logging to the virtual server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Name of the network profile to associate with the virtual server. If you set this parameter, the virtual server uses only the IP addresses in the network profile as source IP addresses when initiating connections with servers. 
    .PARAMETER Icmpvsrresponse 
        How the Citrix ADC responds to ping requests received for an IP address that is common to one or more virtual servers. Available settings function as follows: 
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always responds to the ping requests. 
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance responds to the ping requests if at least one of the virtual servers is UP. Otherwise, the appliance does not respond. 
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance responds if at least one virtual server with the ACTIVE setting is UP. Otherwise, the appliance does not respond. 
        Note: This parameter is available at the virtual server level. A similar parameter, ICMP Response, is available at the IP address level, for IPv4 addresses of type VIP. To set that parameter, use the add ip command in the CLI or the Create IP dialog box in the GUI. 
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Skippersistency 
        This argument decides the behavior incase the service which is selected from an existing persistence session has reached threshold. 
        Possible values = Bypass, ReLb, None 
    .PARAMETER Minautoscalemembers 
        Minimum number of members expected to be present when vserver is used in Autoscale. 
    .PARAMETER Maxautoscalemembers 
        Maximum number of members expected to be present when vserver is used in Autoscale. 
    .PARAMETER Authnprofile 
        Name of the authentication profile to be used when authentication is turned on. 
    .PARAMETER Macmoderetainvlan 
        This option is used to retain vlan information of incoming packet when macmode is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dbslb 
        Enable database specific load balancing for MySQL and MSSQL service types. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the VServer. DNS profile properties will be applied to the transactions processed by a VServer. This parameter is valid only for DNS and DNS-TCP VServers. 
    .PARAMETER Lbprofilename 
        Name of the LB profile which is associated to the vserver. 
    .PARAMETER Redirectfromport 
        Port number for the virtual server, from which we absorb the traffic for http redirect. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Httpsredirecturl 
        URL to which all HTTP traffic received on the port specified in the -redirectFromPort parameter is redirected. 
    .PARAMETER Adfsproxyprofile 
        Name of the adfsProxy profile to be used to support ADFSPIP protocol for ADFS servers. 
    .PARAMETER Tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Quicprofilename 
        Name of QUIC profile which will be attached to the VServer. 
    .PARAMETER Quicbridgeprofilename 
        Name of the QUIC Bridge profile whose settings are to be applied to the virtual server. 
    .PARAMETER Probeprotocol 
        Citrix ADC provides support for external health check of the vserver status. Select HTTP or TCP probes for healthcheck. 
        Possible values = TCP, HTTP 
    .PARAMETER Ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current lb vserver. 
    .PARAMETER Servicename 
        Service to bind to the virtual server. 
    .PARAMETER Persistencetype 
        Type of persistence for the virtual server. Available settings function as follows: 
        * SOURCEIP - Connections from the same client IP address belong to the same persistence session. 
        * COOKIEINSERT - Connections that have the same HTTP Cookie, inserted by a Set-Cookie directive from a server, belong to the same persistence session. 
        * SSLSESSION - Connections that have the same SSL Session ID belong to the same persistence session. 
        * CUSTOMSERVERID - Connections with the same server ID form part of the same session. For this persistence type, set the Server ID (CustomServerID) parameter for each service and configure the Rule parameter to identify the server ID in a request. 
        * RULE - All connections that match a user defined rule belong to the same persistence session. 
        * URLPASSIVE - Requests that have the same server ID in the URL query belong to the same persistence session. The server ID is the hexadecimal representation of the IP address and port of the service to which the request must be forwarded. This persistence type requires a rule to identify the server ID in the request. 
        * DESTIP - Connections to the same destination IP address belong to the same persistence session. 
        * SRCIPDESTIP - Connections that have the same source IP address and destination IP address belong to the same persistence session. 
        * CALLID - Connections that have the same CALL-ID SIP header belong to the same persistence session. 
        * RTSPSID - Connections that have the same RTSP Session ID belong to the same persistence session. 
        * FIXSESSION - Connections that have the same SenderCompID and TargetCompID values belong to the same persistence session. 
        * USERSESSION - Persistence session is created based on the persistence parameter value provided from an extension. 
        Possible values = SOURCEIP, COOKIEINSERT, SSLSESSION, RULE, URLPASSIVE, CUSTOMSERVERID, DESTIP, SRCIPDESTIP, CALLID, RTSPSID, DIAMETER, FIXSESSION, USERSESSION, NONE 
    .PARAMETER Timeout 
        Time period for which a persistence session is in effect. 
    .PARAMETER Persistencebackup 
        Backup persistence type for the virtual server. Becomes operational if the primary persistence mechanism fails. 
        Possible values = SOURCEIP, NONE 
    .PARAMETER Backuppersistencetimeout 
        Time period for which backup persistence is in effect. 
    .PARAMETER Lbmethod 
        Load balancing method. The available settings function as follows: 
        * ROUNDROBIN - Distribute requests in rotation, regardless of the load. Weights can be assigned to services to enforce weighted round robin distribution. 
        * LEASTCONNECTION (default) - Select the service with the fewest connections. 
        * LEASTRESPONSETIME - Select the service with the lowest average response time. 
        * LEASTBANDWIDTH - Select the service currently handling the least traffic. 
        * LEASTPACKETS - Select the service currently serving the lowest number of packets per second. 
        * CUSTOMLOAD - Base service selection on the SNMP metrics obtained by custom load monitors. 
        * LRTM - Select the service with the lowest response time. Response times are learned through monitoring probes. This method also takes the number of active connections into account. 
        Also available are a number of hashing methods, in which the appliance extracts a predetermined portion of the request, creates a hash of the portion, and then checks whether any previous requests had the same hash value. If it finds a match, it forwards the request to the service that served those previous requests. Following are the hashing methods: 
        * URLHASH - Create a hash of the request URL (or part of the URL). 
        * DOMAINHASH - Create a hash of the domain name in the request (or part of the domain name). The domain name is taken from either the URL or the Host header. If the domain name appears in both locations, the URL is preferred. If the request does not contain a domain name, the load balancing method defaults to LEASTCONNECTION. 
        * DESTINATIONIPHASH - Create a hash of the destination IP address in the IP header. 
        * SOURCEIPHASH - Create a hash of the source IP address in the IP header. 
        * TOKEN - Extract a token from the request, create a hash of the token, and then select the service to which any previous requests with the same token hash value were sent. 
        * SRCIPDESTIPHASH - Create a hash of the string obtained by concatenating the source IP address and destination IP address in the IP header. 
        * SRCIPSRCPORTHASH - Create a hash of the source IP address and source port in the IP header. 
        * CALLIDHASH - Create a hash of the SIP Call-ID header. 
        * USER_TOKEN - Same as TOKEN LB method but token needs to be provided from an extension. 
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, URLHASH, DOMAINHASH, DESTINATIONIPHASH, SOURCEIPHASH, SRCIPDESTIPHASH, LEASTBANDWIDTH, LEASTPACKETS, TOKEN, SRCIPSRCPORTHASH, LRTM, CALLIDHASH, CUSTOMLOAD, LEASTREQUEST, AUDITLOGHASH, STATICPROXIMITY, USER_TOKEN 
    .PARAMETER Hashlength 
        Number of bytes to consider for the hash value used in the URLHASH and DOMAINHASH load balancing methods. 
    .PARAMETER Netmask 
        IPv4 subnet mask to apply to the destination IP address or source IP address when the load balancing method is DESTINATIONIPHASH or SOURCEIPHASH. 
    .PARAMETER V6netmasklen 
        Number of bits to consider in an IPv6 destination or source IP address, for creating the hash that is required by the DESTINATIONIPHASH and SOURCEIPHASH load balancing methods. 
    .PARAMETER Backuplbmethod 
        Backup load balancing method. Becomes operational if the primary load balancing me 
        thod fails or cannot be used. 
        Valid only if the primary method is based on static proximity. 
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, CUSTOMLOAD 
    .PARAMETER Cookiename 
        Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
    .PARAMETER Resrule 
        Expression specifying which part of a server's response to use for creating rule based persistence sessions (persistence type RULE). Can be either an expression or the name of a named expression. 
        Example: 
        HTTP.RES.HEADER("setcookie").VALUE(0).TYPECAST_NVLIST_T('=',';').VALUE("server1"). 
    .PARAMETER Persistmask 
        Persistence mask for IP based persistence types, for IPv4 virtual servers. 
    .PARAMETER V6persistmasklen 
        Persistence mask for IP based persistence types, for IPv6 virtual servers. 
    .PARAMETER Rtspnat 
        Use network address translation (NAT) for RTSP data connections. 
        Possible values = ON, OFF 
    .PARAMETER M 
        Redirection mode for load balancing. Available settings function as follows: 
        * IP - Before forwarding a request to a server, change the destination IP address to the server's IP address. 
        * MAC - Before forwarding a request to a server, change the destination MAC address to the server's MAC address. The destination IP address is not changed. MAC-based redirection mode is used mostly in firewall load balancing deployments. 
        * IPTUNNEL - Perform IP-in-IP encapsulation for client IP packets. In the outer IP headers, set the destination IP address to the IP address of the server and the source IP address to the subnet IP (SNIP). The client IP packets are not modified. Applicable to both IPv4 and IPv6 packets. 
        * TOS - Encode the virtual server's TOS ID in the TOS field of the IP header. 
        You can use either the IPTUNNEL or the TOS option to implement Direct Server Return (DSR). 
        Possible values = IP, MAC, IPTUNNEL, TOS 
    .PARAMETER Tosid 
        TOS ID of the virtual server. Applicable only when the load balancing redirection mode is set to TOS. 
    .PARAMETER Datalength 
        Length of the token to be extracted from the data segment of an incoming packet, for use in the token method of load balancing. The length of the token, specified in bytes, must not be greater than 24 KB. Applicable to virtual servers of type TCP. 
    .PARAMETER Dataoffset 
        Offset to be considered when extracting a token from the TCP payload. Applicable to virtual servers, of type TCP, using the token method of load balancing. Must be within the first 24 KB of the TCP payload. 
    .PARAMETER Sessionless 
        Perform load balancing on a per-packet basis, without establishing sessions. Recommended for load balancing of intrusion detection system (IDS) servers and scenarios involving direct server return (DSR), where session information is unnecessary. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Trofspersistence 
        When value is ENABLED, Trofs persistence is honored. When value is DISABLED, Trofs persistence is not honored. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Connfailover 
        Mode in which the connection failover feature must operate for the virtual server. After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary appliance. Clients remain connected to the same servers. Available settings function as follows: 
        * STATEFUL - The primary appliance shares state information with the secondary appliance, in real time, resulting in some runtime processing overhead. 
        * STATELESS - State information is not shared, and the new primary appliance tries to re-create the packet flow on the basis of the information contained in the packets it receives. 
        * DISABLED - Connection failover does not occur. 
        Possible values = DISABLED, STATEFUL, STATELESS 
    .PARAMETER Cacheable 
        Route cacheable requests to a cache redirection virtual server. The load balancing virtual server can forward requests only to a transparent cache redirection virtual server that has an IP address and port combination of *:80, so such a cache redirection virtual server must be configured on the appliance. 
        Possible values = YES, NO 
    .PARAMETER Somethod 
        Type of threshold that, when exceeded, triggers spillover. Available settings function as follows: 
        * CONNECTION - Spillover occurs when the number of client connections exceeds the threshold. 
        * DYNAMICCONNECTION - Spillover occurs when the number of client connections at the virtual server exceeds the sum of the maximum client (Max Clients) settings for bound services. Do not specify a spillover threshold for this setting, because the threshold is implied by the Max Clients settings of bound services. 
        * BANDWIDTH - Spillover occurs when the bandwidth consumed by the virtual server's incoming and outgoing traffic exceeds the threshold. 
        * HEALTH - Spillover occurs when the percentage of weights of the services that are UP drops below the threshold. For example, if services svc1, svc2, and svc3 are bound to a virtual server, with weights 1, 2, and 3, and the spillover threshold is 50%, spillover occurs if svc1 and svc3 or svc2 and svc3 transition to DOWN. 
        * NONE - Spillover does not occur. 
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER Sopersistence 
        If spillover occurs, maintain source IP address based persistence for both primary and backup virtual servers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sopersistencetimeout 
        Timeout for spillover persistence, in minutes. 
    .PARAMETER Healththreshold 
        Threshold in percent of active services below which vserver state is made down. If this threshold is 0, vserver state will be up even if one bound service is up. 
    .PARAMETER Sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists. 
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER Redirectportrewrite 
        Rewrite the port and change the protocol to ensure successful HTTP redirects from services. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with a virtual server whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Insertvserveripport 
        Insert an HTTP header, whose value is the IP address and port number of the virtual server, before forwarding a request to the server. The format of the header is <vipHeader>: <virtual server IP address>_<port number >, where vipHeader is the name that you specify for the header. If the virtual server has an IPv6 address, the address in the header is enclosed in brackets ([ and ]) to separate it from the port number. If you have mapped an IPv4 address to a virtual server's IPv6 address, the value of this parameter determines which IP address is inserted in the header, as follows: 
        * VIPADDR - Insert the IP address of the virtual server in the HTTP header regardless of whether the virtual server has an IPv4 address or an IPv6 address. A mapped IPv4 address, if configured, is ignored. 
        * V6TOV4MAPPING - Insert the IPv4 address that is mapped to the virtual server's IPv6 address. If a mapped IPv4 address is not configured, insert the IPv6 address. 
        * OFF - Disable header insertion. 
        Possible values = OFF, VIPADDR, V6TOV4MAPPING 
    .PARAMETER Vipheader 
        Name for the inserted header. The default name is vip-header. 
    .PARAMETER Disableprimaryondown 
        If the primary virtual server goes down, do not allow it to return to primary status until manually enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Push 
        Process traffic with the push virtual server that is bound to this load balancing virtual server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pushmulticlients 
        Allow multiple Web 2.0 connections from the same client to connect to the virtual server and expect updates. 
        Possible values = YES, NO 
    .PARAMETER Listenpolicy 
        Expression identifying traffic accepted by the virtual server. Can be either an expression (for example, CLIENT.IP.DST.IN_SUBNET(192.0.2.0/24) or the name of a named expression. In the above example, the virtual server accepts all requests whose destination IP address is in the 192.0.2.0/24 subnet. 
    .PARAMETER Listenpriority 
        Integer specifying the priority of the listen policy. A higher number specifies a lower priority. If a request matches the listen policies of more than one virtual server the virtual server whose listen policy has the highest priority (the lowest priority number) accepts the request. 
    .PARAMETER Comment 
        Any comments that you might want to associate with the virtual server. 
    .PARAMETER Oracleserverversion 
        Oracle server version. 
        Possible values = 10G, 11G 
    .PARAMETER Mssqlserverversion 
        For a load balancing virtual server of type MSSQL, the Microsoft SQL Server version. Set this parameter if you expect some clients to run a version different from the version of the database. This setting provides compatibility between the client-side and server-side connections by ensuring that all communication conforms to the server's version. 
        Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
    .PARAMETER Rhistate 
        Route Health Injection (RHI) functionality of the NetSaler appliance for advertising the route of the VIP address associated with the virtual server. When Vserver RHI Level (RHI) parameter is set to VSVR_CNTRLD, the following are different RHI behaviors for the VIP address on the basis of RHIstate (RHI STATE) settings on the virtual servers associated with the VIP address: 
        * If you set RHI STATE to PASSIVE on all virtual servers, the Citrix ADC always advertises the route for the VIP address. 
        * If you set RHI STATE to ACTIVE on all virtual servers, the Citrix ADC advertises the route for the VIP address if at least one of the associated virtual servers is in UP state. 
        * If you set RHI STATE to ACTIVE on some and PASSIVE on others, the Citrix ADC advertises the route for the VIP address if at least one of the associated virtual servers, whose RHI STATE set to ACTIVE, is in UP state. 
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Newservicerequest 
        Number of requests, or percentage of the load on existing services, by which to increase the load on a new service at each interval in slow-start mode. A non-zero value indicates that slow-start is applicable. A zero value indicates that the global RR startup parameter is applied. Changing the value to zero will cause services currently in slow start to take the full traffic as determined by the LB method. Subsequently, any new services added will use the global RR factor. 
    .PARAMETER Newservicerequestunit 
        Units in which to increment load at each interval in slow-start mode. 
        Possible values = PER_SECOND, PERCENT 
    .PARAMETER Newservicerequestincrementinterval 
        Interval, in seconds, between successive increments in the load on a new service or a service whose state has just changed from DOWN to UP. A value of 0 (zero) specifies manual slow start. 
    .PARAMETER Persistavpno 
        Persist AVP number for Diameter Persistency. 
        In case this AVP is not defined in Base RFC 3588 and it is nested inside a Grouped AVP, 
        define a sequence of AVP numbers (max 3) in order of parent to child. So say persist AVP number X 
        is nested inside AVP Y which is nested in Z, then define the list as Z Y X. 
    .PARAMETER Recursionavailable 
        When set to YES, this option causes the DNS replies from this vserver to have the RA bit turned on. Typically one would set this option to YES, when the vserver is load balancing a set of DNS servers thatsupport recursive queries. 
        Possible values = YES, NO 
    .PARAMETER Retainconnectionsoncluster 
        This option enables you to retain existing connections on a node joining a Cluster system or when a node is being configured for passive timeout. By default, this option is disabled. 
        Possible values = YES, NO 
    .PARAMETER Probesuccessresponsecode 
        HTTP code to return in SUCCESS case.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLbvserver -name <string>
        An example how to unset lbvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLbvserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver
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

        [Boolean]$backupvserver,

        [Boolean]$clttimeout,

        [Boolean]$redirurl,

        [Boolean]$redirurlflags,

        [Boolean]$authn401,

        [Boolean]$authentication,

        [Boolean]$authenticationhost,

        [Boolean]$authnvsname,

        [Boolean]$pushvserver,

        [Boolean]$pushlabel,

        [Boolean]$tcpprofilename,

        [Boolean]$httpprofilename,

        [Boolean]$dbprofilename,

        [Boolean]$rule,

        [Boolean]$sothreshold,

        [Boolean]$l2conn,

        [Boolean]$mysqlprotocolversion,

        [Boolean]$mysqlserverversion,

        [Boolean]$mysqlcharacterset,

        [Boolean]$mysqlservercapabilities,

        [Boolean]$appflowlog,

        [Boolean]$netprofile,

        [Boolean]$icmpvsrresponse,

        [Boolean]$skippersistency,

        [Boolean]$minautoscalemembers,

        [Boolean]$maxautoscalemembers,

        [Boolean]$authnprofile,

        [Boolean]$macmoderetainvlan,

        [Boolean]$dbslb,

        [Boolean]$dnsprofilename,

        [Boolean]$lbprofilename,

        [Boolean]$redirectfromport,

        [Boolean]$httpsredirecturl,

        [Boolean]$adfsproxyprofile,

        [Boolean]$tcpprobeport,

        [Boolean]$quicprofilename,

        [Boolean]$quicbridgeprofilename,

        [Boolean]$probeprotocol,

        [Boolean]$ipset,

        [Boolean]$servicename,

        [Boolean]$persistencetype,

        [Boolean]$timeout,

        [Boolean]$persistencebackup,

        [Boolean]$backuppersistencetimeout,

        [Boolean]$lbmethod,

        [Boolean]$hashlength,

        [Boolean]$netmask,

        [Boolean]$v6netmasklen,

        [Boolean]$backuplbmethod,

        [Boolean]$cookiename,

        [Boolean]$resrule,

        [Boolean]$persistmask,

        [Boolean]$v6persistmasklen,

        [Boolean]$rtspnat,

        [Boolean]$m,

        [Boolean]$tosid,

        [Boolean]$datalength,

        [Boolean]$dataoffset,

        [Boolean]$sessionless,

        [Boolean]$trofspersistence,

        [Boolean]$connfailover,

        [Boolean]$cacheable,

        [Boolean]$somethod,

        [Boolean]$sopersistence,

        [Boolean]$sopersistencetimeout,

        [Boolean]$healththreshold,

        [Boolean]$sobackupaction,

        [Boolean]$redirectportrewrite,

        [Boolean]$downstateflush,

        [Boolean]$insertvserveripport,

        [Boolean]$vipheader,

        [Boolean]$disableprimaryondown,

        [Boolean]$push,

        [Boolean]$pushmulticlients,

        [Boolean]$listenpolicy,

        [Boolean]$listenpriority,

        [Boolean]$comment,

        [Boolean]$oracleserverversion,

        [Boolean]$mssqlserverversion,

        [Boolean]$rhistate,

        [Boolean]$newservicerequest,

        [Boolean]$newservicerequestunit,

        [Boolean]$newservicerequestincrementinterval,

        [Boolean]$persistavpno,

        [Boolean]$recursionavailable,

        [Boolean]$retainconnectionsoncluster,

        [Boolean]$probesuccessresponsecode 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLbvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('redirurl') ) { $payload.Add('redirurl', $redirurl) }
            if ( $PSBoundParameters.ContainsKey('redirurlflags') ) { $payload.Add('redirurlflags', $redirurlflags) }
            if ( $PSBoundParameters.ContainsKey('authn401') ) { $payload.Add('authn401', $authn401) }
            if ( $PSBoundParameters.ContainsKey('authentication') ) { $payload.Add('authentication', $authentication) }
            if ( $PSBoundParameters.ContainsKey('authenticationhost') ) { $payload.Add('authenticationhost', $authenticationhost) }
            if ( $PSBoundParameters.ContainsKey('authnvsname') ) { $payload.Add('authnvsname', $authnvsname) }
            if ( $PSBoundParameters.ContainsKey('pushvserver') ) { $payload.Add('pushvserver', $pushvserver) }
            if ( $PSBoundParameters.ContainsKey('pushlabel') ) { $payload.Add('pushlabel', $pushlabel) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('dbprofilename') ) { $payload.Add('dbprofilename', $dbprofilename) }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('l2conn') ) { $payload.Add('l2conn', $l2conn) }
            if ( $PSBoundParameters.ContainsKey('mysqlprotocolversion') ) { $payload.Add('mysqlprotocolversion', $mysqlprotocolversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlserverversion') ) { $payload.Add('mysqlserverversion', $mysqlserverversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlcharacterset') ) { $payload.Add('mysqlcharacterset', $mysqlcharacterset) }
            if ( $PSBoundParameters.ContainsKey('mysqlservercapabilities') ) { $payload.Add('mysqlservercapabilities', $mysqlservercapabilities) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('icmpvsrresponse') ) { $payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ( $PSBoundParameters.ContainsKey('skippersistency') ) { $payload.Add('skippersistency', $skippersistency) }
            if ( $PSBoundParameters.ContainsKey('minautoscalemembers') ) { $payload.Add('minautoscalemembers', $minautoscalemembers) }
            if ( $PSBoundParameters.ContainsKey('maxautoscalemembers') ) { $payload.Add('maxautoscalemembers', $maxautoscalemembers) }
            if ( $PSBoundParameters.ContainsKey('authnprofile') ) { $payload.Add('authnprofile', $authnprofile) }
            if ( $PSBoundParameters.ContainsKey('macmoderetainvlan') ) { $payload.Add('macmoderetainvlan', $macmoderetainvlan) }
            if ( $PSBoundParameters.ContainsKey('dbslb') ) { $payload.Add('dbslb', $dbslb) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('lbprofilename') ) { $payload.Add('lbprofilename', $lbprofilename) }
            if ( $PSBoundParameters.ContainsKey('redirectfromport') ) { $payload.Add('redirectfromport', $redirectfromport) }
            if ( $PSBoundParameters.ContainsKey('httpsredirecturl') ) { $payload.Add('httpsredirecturl', $httpsredirecturl) }
            if ( $PSBoundParameters.ContainsKey('adfsproxyprofile') ) { $payload.Add('adfsproxyprofile', $adfsproxyprofile) }
            if ( $PSBoundParameters.ContainsKey('tcpprobeport') ) { $payload.Add('tcpprobeport', $tcpprobeport) }
            if ( $PSBoundParameters.ContainsKey('quicprofilename') ) { $payload.Add('quicprofilename', $quicprofilename) }
            if ( $PSBoundParameters.ContainsKey('quicbridgeprofilename') ) { $payload.Add('quicbridgeprofilename', $quicbridgeprofilename) }
            if ( $PSBoundParameters.ContainsKey('probeprotocol') ) { $payload.Add('probeprotocol', $probeprotocol) }
            if ( $PSBoundParameters.ContainsKey('ipset') ) { $payload.Add('ipset', $ipset) }
            if ( $PSBoundParameters.ContainsKey('servicename') ) { $payload.Add('servicename', $servicename) }
            if ( $PSBoundParameters.ContainsKey('persistencetype') ) { $payload.Add('persistencetype', $persistencetype) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('persistencebackup') ) { $payload.Add('persistencebackup', $persistencebackup) }
            if ( $PSBoundParameters.ContainsKey('backuppersistencetimeout') ) { $payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('lbmethod') ) { $payload.Add('lbmethod', $lbmethod) }
            if ( $PSBoundParameters.ContainsKey('hashlength') ) { $payload.Add('hashlength', $hashlength) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('v6netmasklen') ) { $payload.Add('v6netmasklen', $v6netmasklen) }
            if ( $PSBoundParameters.ContainsKey('backuplbmethod') ) { $payload.Add('backuplbmethod', $backuplbmethod) }
            if ( $PSBoundParameters.ContainsKey('cookiename') ) { $payload.Add('cookiename', $cookiename) }
            if ( $PSBoundParameters.ContainsKey('resrule') ) { $payload.Add('resrule', $resrule) }
            if ( $PSBoundParameters.ContainsKey('persistmask') ) { $payload.Add('persistmask', $persistmask) }
            if ( $PSBoundParameters.ContainsKey('v6persistmasklen') ) { $payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ( $PSBoundParameters.ContainsKey('rtspnat') ) { $payload.Add('rtspnat', $rtspnat) }
            if ( $PSBoundParameters.ContainsKey('m') ) { $payload.Add('m', $m) }
            if ( $PSBoundParameters.ContainsKey('tosid') ) { $payload.Add('tosid', $tosid) }
            if ( $PSBoundParameters.ContainsKey('datalength') ) { $payload.Add('datalength', $datalength) }
            if ( $PSBoundParameters.ContainsKey('dataoffset') ) { $payload.Add('dataoffset', $dataoffset) }
            if ( $PSBoundParameters.ContainsKey('sessionless') ) { $payload.Add('sessionless', $sessionless) }
            if ( $PSBoundParameters.ContainsKey('trofspersistence') ) { $payload.Add('trofspersistence', $trofspersistence) }
            if ( $PSBoundParameters.ContainsKey('connfailover') ) { $payload.Add('connfailover', $connfailover) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('somethod') ) { $payload.Add('somethod', $somethod) }
            if ( $PSBoundParameters.ContainsKey('sopersistence') ) { $payload.Add('sopersistence', $sopersistence) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('healththreshold') ) { $payload.Add('healththreshold', $healththreshold) }
            if ( $PSBoundParameters.ContainsKey('sobackupaction') ) { $payload.Add('sobackupaction', $sobackupaction) }
            if ( $PSBoundParameters.ContainsKey('redirectportrewrite') ) { $payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('insertvserveripport') ) { $payload.Add('insertvserveripport', $insertvserveripport) }
            if ( $PSBoundParameters.ContainsKey('vipheader') ) { $payload.Add('vipheader', $vipheader) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('push') ) { $payload.Add('push', $push) }
            if ( $PSBoundParameters.ContainsKey('pushmulticlients') ) { $payload.Add('pushmulticlients', $pushmulticlients) }
            if ( $PSBoundParameters.ContainsKey('listenpolicy') ) { $payload.Add('listenpolicy', $listenpolicy) }
            if ( $PSBoundParameters.ContainsKey('listenpriority') ) { $payload.Add('listenpriority', $listenpriority) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('oracleserverversion') ) { $payload.Add('oracleserverversion', $oracleserverversion) }
            if ( $PSBoundParameters.ContainsKey('mssqlserverversion') ) { $payload.Add('mssqlserverversion', $mssqlserverversion) }
            if ( $PSBoundParameters.ContainsKey('rhistate') ) { $payload.Add('rhistate', $rhistate) }
            if ( $PSBoundParameters.ContainsKey('newservicerequest') ) { $payload.Add('newservicerequest', $newservicerequest) }
            if ( $PSBoundParameters.ContainsKey('newservicerequestunit') ) { $payload.Add('newservicerequestunit', $newservicerequestunit) }
            if ( $PSBoundParameters.ContainsKey('newservicerequestincrementinterval') ) { $payload.Add('newservicerequestincrementinterval', $newservicerequestincrementinterval) }
            if ( $PSBoundParameters.ContainsKey('persistavpno') ) { $payload.Add('persistavpno', $persistavpno) }
            if ( $PSBoundParameters.ContainsKey('recursionavailable') ) { $payload.Add('recursionavailable', $recursionavailable) }
            if ( $PSBoundParameters.ContainsKey('retainconnectionsoncluster') ) { $payload.Add('retainconnectionsoncluster', $retainconnectionsoncluster) }
            if ( $PSBoundParameters.ContainsKey('probesuccessresponsecode') ) { $payload.Add('probesuccessresponsecode', $probesuccessresponsecode) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbvserver -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLbvserver: Finished"
    }
}

function Invoke-ADCEnableLbvserver {
    <#
    .SYNOPSIS
        Enable Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .
    .EXAMPLE
        PS C:\>Invoke-ADCEnableLbvserver -name <string>
        An example how to enable lbvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCEnableLbvserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver/
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
        Write-Verbose "Invoke-ADCEnableLbvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lbvserver -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCEnableLbvserver: Finished"
    }
}

function Invoke-ADCDisableLbvserver {
    <#
    .SYNOPSIS
        Disable Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .
    .EXAMPLE
        PS C:\>Invoke-ADCDisableLbvserver -name <string>
        An example how to disable lbvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDisableLbvserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver/
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
        Write-Verbose "Invoke-ADCDisableLbvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lbvserver -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCDisableLbvserver: Finished"
    }
}

function Invoke-ADCRenameLbvserver {
    <#
    .SYNOPSIS
        Rename Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Newname 
        New name for the virtual server. 
    .PARAMETER PassThru 
        Return details about the created lbvserver item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameLbvserver -name <string> -newname <string>
        An example how to rename lbvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameLbvserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver/
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
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameLbvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("lbvserver", "Rename Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lbvserver -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserver -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameLbvserver: Finished"
    }
}

function Invoke-ADCGetLbvserver {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserver
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserver -GetAll 
        Get all lbvserver data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserver -Count 
        Get the number of lbvserver objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserver -name <string>
        Get lbvserver object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserver -Filter @{ 'name'='<value>' }
        Get lbvserver data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver/
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
        Write-Verbose "Invoke-ADCGetLbvserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lbvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserver: Ended"
    }
}

function Invoke-ADCAddLbvserveranalyticsprofilebinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Analyticsprofile 
        Name of the analytics profile bound to the LB vserver. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_analyticsprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserveranalyticsprofilebinding -name <string>
        An example how to add lbvserver_analyticsprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserveranalyticsprofilebinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_analyticsprofile_binding/
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

        [string]$Analyticsprofile,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserveranalyticsprofilebinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('analyticsprofile') ) { $payload.Add('analyticsprofile', $analyticsprofile) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_analyticsprofile_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_analyticsprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserveranalyticsprofilebinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserveranalyticsprofilebinding: Finished"
    }
}

function Invoke-ADCDeleteLbvserveranalyticsprofilebinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Analyticsprofile 
        Name of the analytics profile bound to the LB vserver.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserveranalyticsprofilebinding -Name <string>
        An example how to delete lbvserver_analyticsprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserveranalyticsprofilebinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_analyticsprofile_binding/
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

        [string]$Analyticsprofile 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserveranalyticsprofilebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Analyticsprofile') ) { $arguments.Add('analyticsprofile', $Analyticsprofile) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserveranalyticsprofilebinding: Finished"
    }
}

function Invoke-ADCGetLbvserveranalyticsprofilebinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_analyticsprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_analyticsprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserveranalyticsprofilebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserveranalyticsprofilebinding -GetAll 
        Get all lbvserver_analyticsprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserveranalyticsprofilebinding -Count 
        Get the number of lbvserver_analyticsprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserveranalyticsprofilebinding -name <string>
        Get lbvserver_analyticsprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserveranalyticsprofilebinding -Filter @{ 'name'='<value>' }
        Get lbvserver_analyticsprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserveranalyticsprofilebinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_analyticsprofile_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserveranalyticsprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_analyticsprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_analyticsprofile_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_analyticsprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserveranalyticsprofilebinding: Ended"
    }
}

function Invoke-ADCAddLbvserverappflowpolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_appflowpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserverappflowpolicybinding -name <string>
        An example how to add lbvserver_appflowpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserverappflowpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_appflowpolicy_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverappflowpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_appflowpolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_appflowpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserverappflowpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserverappflowpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvserverappflowpolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserverappflowpolicybinding -Name <string>
        An example how to delete lbvserver_appflowpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverappflowpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_appflowpolicy_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverappflowpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserverappflowpolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvserverappflowpolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_appflowpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_appflowpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverappflowpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverappflowpolicybinding -GetAll 
        Get all lbvserver_appflowpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverappflowpolicybinding -Count 
        Get the number of lbvserver_appflowpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverappflowpolicybinding -name <string>
        Get lbvserver_appflowpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverappflowpolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_appflowpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverappflowpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_appflowpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverappflowpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_appflowpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_appflowpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_appflowpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverappflowpolicybinding: Ended"
    }
}

function Invoke-ADCAddLbvserverappfwpolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_appfwpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserverappfwpolicybinding -name <string>
        An example how to add lbvserver_appfwpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserverappfwpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_appfwpolicy_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverappfwpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_appfwpolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_appfwpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserverappfwpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserverappfwpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvserverappfwpolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserverappfwpolicybinding -Name <string>
        An example how to delete lbvserver_appfwpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverappfwpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_appfwpolicy_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverappfwpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserverappfwpolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvserverappfwpolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_appfwpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_appfwpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverappfwpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverappfwpolicybinding -GetAll 
        Get all lbvserver_appfwpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverappfwpolicybinding -Count 
        Get the number of lbvserver_appfwpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverappfwpolicybinding -name <string>
        Get lbvserver_appfwpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverappfwpolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_appfwpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverappfwpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_appfwpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverappfwpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_appfwpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_appfwpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_appfwpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverappfwpolicybinding: Ended"
    }
}

function Invoke-ADCAddLbvserverappqoepolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the appqoepolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_appqoepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserverappqoepolicybinding -name <string>
        An example how to add lbvserver_appqoepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserverappqoepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_appqoepolicy_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverappqoepolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_appqoepolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_appqoepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserverappqoepolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserverappqoepolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvserverappqoepolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the appqoepolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserverappqoepolicybinding -Name <string>
        An example how to delete lbvserver_appqoepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverappqoepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_appqoepolicy_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverappqoepolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserverappqoepolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvserverappqoepolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the appqoepolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_appqoepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_appqoepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverappqoepolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverappqoepolicybinding -GetAll 
        Get all lbvserver_appqoepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverappqoepolicybinding -Count 
        Get the number of lbvserver_appqoepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverappqoepolicybinding -name <string>
        Get lbvserver_appqoepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverappqoepolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_appqoepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverappqoepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_appqoepolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverappqoepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_appqoepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_appqoepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_appqoepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_appqoepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_appqoepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverappqoepolicybinding: Ended"
    }
}

function Invoke-ADCAddLbvserverauditnslogpolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Bindpoint 
        Bind point to which to bind the policy. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_auditnslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserverauditnslogpolicybinding -name <string>
        An example how to add lbvserver_auditnslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserverauditnslogpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_auditnslogpolicy_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_auditnslogpolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_auditnslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserverauditnslogpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserverauditnslogpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvserverauditnslogpolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        Bind point to which to bind the policy. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserverauditnslogpolicybinding -Name <string>
        An example how to delete lbvserver_auditnslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverauditnslogpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_auditnslogpolicy_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserverauditnslogpolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvserverauditnslogpolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_auditnslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_auditnslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverauditnslogpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverauditnslogpolicybinding -GetAll 
        Get all lbvserver_auditnslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverauditnslogpolicybinding -Count 
        Get the number of lbvserver_auditnslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverauditnslogpolicybinding -name <string>
        Get lbvserver_auditnslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverauditnslogpolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_auditnslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverauditnslogpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_auditnslogpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverauditnslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_auditnslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_auditnslogpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_auditnslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverauditnslogpolicybinding: Ended"
    }
}

function Invoke-ADCAddLbvserverauditsyslogpolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Bindpoint 
        Bind point to which to bind the policy. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_auditsyslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserverauditsyslogpolicybinding -name <string>
        An example how to add lbvserver_auditsyslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserverauditsyslogpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_auditsyslogpolicy_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_auditsyslogpolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_auditsyslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserverauditsyslogpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserverauditsyslogpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvserverauditsyslogpolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        Bind point to which to bind the policy. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserverauditsyslogpolicybinding -Name <string>
        An example how to delete lbvserver_auditsyslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverauditsyslogpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_auditsyslogpolicy_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserverauditsyslogpolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvserverauditsyslogpolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_auditsyslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_auditsyslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverauditsyslogpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverauditsyslogpolicybinding -GetAll 
        Get all lbvserver_auditsyslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverauditsyslogpolicybinding -Count 
        Get the number of lbvserver_auditsyslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverauditsyslogpolicybinding -name <string>
        Get lbvserver_auditsyslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverauditsyslogpolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_auditsyslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverauditsyslogpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_auditsyslogpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverauditsyslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_auditsyslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_auditsyslogpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverauditsyslogpolicybinding: Ended"
    }
}

function Invoke-ADCAddLbvserverauthorizationpolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_authorizationpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserverauthorizationpolicybinding -name <string>
        An example how to add lbvserver_authorizationpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserverauthorizationpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_authorizationpolicy_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverauthorizationpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_authorizationpolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_authorizationpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserverauthorizationpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserverauthorizationpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvserverauthorizationpolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserverauthorizationpolicybinding -Name <string>
        An example how to delete lbvserver_authorizationpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverauthorizationpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_authorizationpolicy_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverauthorizationpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserverauthorizationpolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvserverauthorizationpolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_authorizationpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_authorizationpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverauthorizationpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverauthorizationpolicybinding -GetAll 
        Get all lbvserver_authorizationpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverauthorizationpolicybinding -Count 
        Get the number of lbvserver_authorizationpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverauthorizationpolicybinding -name <string>
        Get lbvserver_authorizationpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverauthorizationpolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_authorizationpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverauthorizationpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_authorizationpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverauthorizationpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_authorizationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_authorizationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_authorizationpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_authorizationpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_authorizationpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverauthorizationpolicybinding: Ended"
    }
}

function Invoke-ADCGetLbvserverbinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to lbvserver.
    .PARAMETER Name 
        Name of the virtual server. If no name is provided, statistical data of all configured virtual servers is displayed. 
    .PARAMETER GetAll 
        Retrieve all lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverbinding -GetAll 
        Get all lbvserver_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverbinding -name <string>
        Get lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverbinding -Filter @{ 'name'='<value>' }
        Get lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetLbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverbinding: Ended"
    }
}

function Invoke-ADCAddLbvserverbotpolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        Bind point to which to bind the policy. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_botpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserverbotpolicybinding -name <string>
        An example how to add lbvserver_botpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserverbotpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_botpolicy_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverbotpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_botpolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_botpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserverbotpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserverbotpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvserverbotpolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        Bind point to which to bind the policy. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserverbotpolicybinding -Name <string>
        An example how to delete lbvserver_botpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverbotpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_botpolicy_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverbotpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_botpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserverbotpolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvserverbotpolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_botpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_botpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverbotpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverbotpolicybinding -GetAll 
        Get all lbvserver_botpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverbotpolicybinding -Count 
        Get the number of lbvserver_botpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverbotpolicybinding -name <string>
        Get lbvserver_botpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverbotpolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_botpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverbotpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_botpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverbotpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_botpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_botpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_botpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_botpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_botpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_botpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_botpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_botpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverbotpolicybinding: Ended"
    }
}

function Invoke-ADCAddLbvservercachepolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_cachepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvservercachepolicybinding -name <string>
        An example how to add lbvserver_cachepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvservercachepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_cachepolicy_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvservercachepolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_cachepolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_cachepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvservercachepolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvservercachepolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvservercachepolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvservercachepolicybinding -Name <string>
        An example how to delete lbvserver_cachepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvservercachepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_cachepolicy_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvservercachepolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_cachepolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvservercachepolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvservercachepolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_cachepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_cachepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservercachepolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvservercachepolicybinding -GetAll 
        Get all lbvserver_cachepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvservercachepolicybinding -Count 
        Get the number of lbvserver_cachepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservercachepolicybinding -name <string>
        Get lbvserver_cachepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservercachepolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_cachepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvservercachepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_cachepolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvservercachepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_cachepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cachepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_cachepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cachepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_cachepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cachepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_cachepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cachepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_cachepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cachepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvservercachepolicybinding: Ended"
    }
}

function Invoke-ADCAddLbvservercmppolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_cmppolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvservercmppolicybinding -name <string>
        An example how to add lbvserver_cmppolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvservercmppolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_cmppolicy_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvservercmppolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_cmppolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_cmppolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvservercmppolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvservercmppolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvservercmppolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvservercmppolicybinding -Name <string>
        An example how to delete lbvserver_cmppolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvservercmppolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_cmppolicy_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvservercmppolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_cmppolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvservercmppolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvservercmppolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_cmppolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_cmppolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservercmppolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvservercmppolicybinding -GetAll 
        Get all lbvserver_cmppolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvservercmppolicybinding -Count 
        Get the number of lbvserver_cmppolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservercmppolicybinding -name <string>
        Get lbvserver_cmppolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservercmppolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_cmppolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvservercmppolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_cmppolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvservercmppolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_cmppolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cmppolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_cmppolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cmppolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_cmppolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cmppolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_cmppolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cmppolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_cmppolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cmppolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvservercmppolicybinding: Ended"
    }
}

function Invoke-ADCAddLbvservercontentinspectionpolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the contentinspectionpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_contentinspectionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvservercontentinspectionpolicybinding -name <string>
        An example how to add lbvserver_contentinspectionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvservercontentinspectionpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_contentinspectionpolicy_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvservercontentinspectionpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_contentinspectionpolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_contentinspectionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvservercontentinspectionpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvservercontentinspectionpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvservercontentinspectionpolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the contentinspectionpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvservercontentinspectionpolicybinding -Name <string>
        An example how to delete lbvserver_contentinspectionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvservercontentinspectionpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_contentinspectionpolicy_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvservercontentinspectionpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvservercontentinspectionpolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvservercontentinspectionpolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the contentinspectionpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_contentinspectionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_contentinspectionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservercontentinspectionpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvservercontentinspectionpolicybinding -GetAll 
        Get all lbvserver_contentinspectionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvservercontentinspectionpolicybinding -Count 
        Get the number of lbvserver_contentinspectionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservercontentinspectionpolicybinding -name <string>
        Get lbvserver_contentinspectionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservercontentinspectionpolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_contentinspectionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvservercontentinspectionpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_contentinspectionpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvservercontentinspectionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_contentinspectionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_contentinspectionpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_contentinspectionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvservercontentinspectionpolicybinding: Ended"
    }
}

function Invoke-ADCGetLbvservercsvserverbinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservercsvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvservercsvserverbinding -GetAll 
        Get all lbvserver_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvservercsvserverbinding -Count 
        Get the number of lbvserver_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservercsvserverbinding -name <string>
        Get lbvserver_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservercsvserverbinding -Filter @{ 'name'='<value>' }
        Get lbvserver_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvservercsvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_csvserver_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvservercsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvservercsvserverbinding: Ended"
    }
}

function Invoke-ADCAddLbvserverdnspolicy64binding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the dnspolicy64 that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        Bind point to which to bind the policy. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_dnspolicy64_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserverdnspolicy64binding -name <string>
        An example how to add lbvserver_dnspolicy64_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserverdnspolicy64binding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_dnspolicy64_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverdnspolicy64binding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_dnspolicy64_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_dnspolicy64_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserverdnspolicy64binding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserverdnspolicy64binding: Finished"
    }
}

function Invoke-ADCDeleteLbvserverdnspolicy64binding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the dnspolicy64 that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        Bind point to which to bind the policy. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserverdnspolicy64binding -Name <string>
        An example how to delete lbvserver_dnspolicy64_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverdnspolicy64binding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_dnspolicy64_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverdnspolicy64binding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_dnspolicy64_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserverdnspolicy64binding: Finished"
    }
}

function Invoke-ADCGetLbvserverdnspolicy64binding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the dnspolicy64 that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_dnspolicy64_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_dnspolicy64_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverdnspolicy64binding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverdnspolicy64binding -GetAll 
        Get all lbvserver_dnspolicy64_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverdnspolicy64binding -Count 
        Get the number of lbvserver_dnspolicy64_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverdnspolicy64binding -name <string>
        Get lbvserver_dnspolicy64_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverdnspolicy64binding -Filter @{ 'name'='<value>' }
        Get lbvserver_dnspolicy64_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverdnspolicy64binding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_dnspolicy64_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverdnspolicy64binding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_dnspolicy64_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dnspolicy64_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_dnspolicy64_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dnspolicy64_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_dnspolicy64_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dnspolicy64_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_dnspolicy64_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dnspolicy64_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_dnspolicy64_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dnspolicy64_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverdnspolicy64binding: Ended"
    }
}

function Invoke-ADCGetLbvserverdospolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the dospolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_dospolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_dospolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverdospolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverdospolicybinding -GetAll 
        Get all lbvserver_dospolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverdospolicybinding -Count 
        Get the number of lbvserver_dospolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverdospolicybinding -name <string>
        Get lbvserver_dospolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverdospolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_dospolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverdospolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_dospolicy_binding.md/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverdospolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_dospolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dospolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_dospolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dospolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_dospolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dospolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_dospolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dospolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_dospolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dospolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverdospolicybinding: Ended"
    }
}

function Invoke-ADCAddLbvserverfeopolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the feopolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_feopolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserverfeopolicybinding -name <string>
        An example how to add lbvserver_feopolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserverfeopolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_feopolicy_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverfeopolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_feopolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_feopolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserverfeopolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserverfeopolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvserverfeopolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the feopolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserverfeopolicybinding -Name <string>
        An example how to delete lbvserver_feopolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverfeopolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_feopolicy_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverfeopolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_feopolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserverfeopolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvserverfeopolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the feopolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_feopolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_feopolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverfeopolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverfeopolicybinding -GetAll 
        Get all lbvserver_feopolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverfeopolicybinding -Count 
        Get the number of lbvserver_feopolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverfeopolicybinding -name <string>
        Get lbvserver_feopolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverfeopolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_feopolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverfeopolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_feopolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverfeopolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_feopolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_feopolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_feopolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_feopolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_feopolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_feopolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_feopolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_feopolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_feopolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_feopolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverfeopolicybinding: Ended"
    }
}

function Invoke-ADCAddLbvserverfilterpolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the filterpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Bindpoint 
        Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies. 
        Possible values = REQUEST, RESPONSE 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_filterpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserverfilterpolicybinding -name <string>
        An example how to add lbvserver_filterpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserverfilterpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_filterpolicy_binding.md/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverfilterpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_filterpolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_filterpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserverfilterpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserverfilterpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvserverfilterpolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the filterpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies. 
        Possible values = REQUEST, RESPONSE 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserverfilterpolicybinding -Name <string>
        An example how to delete lbvserver_filterpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverfilterpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_filterpolicy_binding.md/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverfilterpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_filterpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserverfilterpolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvserverfilterpolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the filterpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_filterpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_filterpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverfilterpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverfilterpolicybinding -GetAll 
        Get all lbvserver_filterpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverfilterpolicybinding -Count 
        Get the number of lbvserver_filterpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverfilterpolicybinding -name <string>
        Get lbvserver_filterpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverfilterpolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_filterpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverfilterpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_filterpolicy_binding.md/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverfilterpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_filterpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_filterpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_filterpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_filterpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_filterpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_filterpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_filterpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_filterpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverfilterpolicybinding: Ended"
    }
}

function Invoke-ADCAddLbvserverpqpolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the pqpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Integer specifying the policy's priority. The lower the priority number, the higher the policy's priority. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Bindpoint 
        Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies. 
        Possible values = REQUEST, RESPONSE 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_pqpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserverpqpolicybinding -name <string>
        An example how to add lbvserver_pqpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserverpqpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_pqpolicy_binding.md/
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

        [string]$Policyname,

        [ValidateRange(1, 2147483647)]
        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverpqpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_pqpolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_pqpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserverpqpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserverpqpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvserverpqpolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the pqpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies. 
        Possible values = REQUEST, RESPONSE 
    .PARAMETER Priority 
        Integer specifying the policy's priority. The lower the priority number, the higher the policy's priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserverpqpolicybinding -Name <string>
        An example how to delete lbvserver_pqpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverpqpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_pqpolicy_binding.md/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverpqpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_pqpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserverpqpolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvserverpqpolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the pqpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_pqpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_pqpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverpqpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverpqpolicybinding -GetAll 
        Get all lbvserver_pqpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverpqpolicybinding -Count 
        Get the number of lbvserver_pqpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverpqpolicybinding -name <string>
        Get lbvserver_pqpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverpqpolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_pqpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverpqpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_pqpolicy_binding.md/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverpqpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_pqpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_pqpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_pqpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_pqpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_pqpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_pqpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_pqpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_pqpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_pqpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_pqpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverpqpolicybinding: Ended"
    }
}

function Invoke-ADCAddLbvserverresponderpolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the responderpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_responderpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserverresponderpolicybinding -name <string>
        An example how to add lbvserver_responderpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserverresponderpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_responderpolicy_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverresponderpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_responderpolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_responderpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserverresponderpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserverresponderpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvserverresponderpolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the responderpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserverresponderpolicybinding -Name <string>
        An example how to delete lbvserver_responderpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverresponderpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_responderpolicy_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverresponderpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_responderpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserverresponderpolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvserverresponderpolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the responderpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_responderpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_responderpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverresponderpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverresponderpolicybinding -GetAll 
        Get all lbvserver_responderpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverresponderpolicybinding -Count 
        Get the number of lbvserver_responderpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverresponderpolicybinding -name <string>
        Get lbvserver_responderpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverresponderpolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_responderpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverresponderpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_responderpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverresponderpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_responderpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_responderpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_responderpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_responderpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_responderpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_responderpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_responderpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_responderpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_responderpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_responderpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverresponderpolicybinding: Ended"
    }
}

function Invoke-ADCAddLbvserverrewritepolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_rewritepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserverrewritepolicybinding -name <string>
        An example how to add lbvserver_rewritepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserverrewritepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_rewritepolicy_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverrewritepolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_rewritepolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_rewritepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserverrewritepolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserverrewritepolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvserverrewritepolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserverrewritepolicybinding -Name <string>
        An example how to delete lbvserver_rewritepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverrewritepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_rewritepolicy_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverrewritepolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserverrewritepolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvserverrewritepolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_rewritepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_rewritepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverrewritepolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverrewritepolicybinding -GetAll 
        Get all lbvserver_rewritepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverrewritepolicybinding -Count 
        Get the number of lbvserver_rewritepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverrewritepolicybinding -name <string>
        Get lbvserver_rewritepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverrewritepolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_rewritepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverrewritepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_rewritepolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverrewritepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_rewritepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_rewritepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_rewritepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_rewritepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_rewritepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverrewritepolicybinding: Ended"
    }
}

function Invoke-ADCAddLbvserverscpolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the scpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Bindpoint 
        Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies. 
        Possible values = REQUEST, RESPONSE 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_scpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserverscpolicybinding -name <string>
        An example how to add lbvserver_scpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserverscpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_scpolicy_binding.md/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverscpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_scpolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_scpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserverscpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserverscpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvserverscpolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the scpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies. 
        Possible values = REQUEST, RESPONSE 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserverscpolicybinding -Name <string>
        An example how to delete lbvserver_scpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverscpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_scpolicy_binding.md/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverscpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_scpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserverscpolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvserverscpolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the scpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_scpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_scpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverscpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverscpolicybinding -GetAll 
        Get all lbvserver_scpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverscpolicybinding -Count 
        Get the number of lbvserver_scpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverscpolicybinding -name <string>
        Get lbvserver_scpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverscpolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_scpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverscpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_scpolicy_binding.md/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverscpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_scpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_scpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_scpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_scpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_scpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_scpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_scpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_scpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_scpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_scpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverscpolicybinding: Ended"
    }
}

function Invoke-ADCGetLbvserverservicegroupmemberbinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the servicegroupmember that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_servicegroupmember_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_servicegroupmember_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverservicegroupmemberbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverservicegroupmemberbinding -GetAll 
        Get all lbvserver_servicegroupmember_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverservicegroupmemberbinding -Count 
        Get the number of lbvserver_servicegroupmember_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverservicegroupmemberbinding -name <string>
        Get lbvserver_servicegroupmember_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverservicegroupmemberbinding -Filter @{ 'name'='<value>' }
        Get lbvserver_servicegroupmember_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverservicegroupmemberbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_servicegroupmember_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverservicegroupmemberbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_servicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_servicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_servicegroupmember_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroupmember_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_servicegroupmember_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroupmember_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_servicegroupmember_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroupmember_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverservicegroupmemberbinding: Ended"
    }
}

function Invoke-ADCAddLbvserverservicegroupbinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the servicegroup that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Servicename 
        Service to bind to the virtual server. 
    .PARAMETER Weight 
        Integer specifying the weight of the service. A larger number specifies a greater weight. Defines the capacity of the service relative to the other services in the load balancing configuration. Determines the priority given to the service in load balancing decisions. 
    .PARAMETER Servicegroupname 
        The service group name bound to the selected load balancing virtual server. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_servicegroup_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserverservicegroupbinding -name <string>
        An example how to add lbvserver_servicegroup_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserverservicegroupbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_servicegroup_binding/
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
        [string]$Servicename,

        [ValidateRange(1, 100)]
        [double]$Weight = '1',

        [string]$Servicegroupname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverservicegroupbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('servicename') ) { $payload.Add('servicename', $servicename) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('servicegroupname') ) { $payload.Add('servicegroupname', $servicegroupname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_servicegroup_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_servicegroup_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserverservicegroupbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserverservicegroupbinding: Finished"
    }
}

function Invoke-ADCDeleteLbvserverservicegroupbinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the servicegroup that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Servicename 
        Service to bind to the virtual server. 
    .PARAMETER Servicegroupname 
        The service group name bound to the selected load balancing virtual server.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserverservicegroupbinding -Name <string>
        An example how to delete lbvserver_servicegroup_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverservicegroupbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_servicegroup_binding/
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

        [string]$Servicename,

        [string]$Servicegroupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverservicegroupbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Servicename') ) { $arguments.Add('servicename', $Servicename) }
            if ( $PSBoundParameters.ContainsKey('Servicegroupname') ) { $arguments.Add('servicegroupname', $Servicegroupname) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_servicegroup_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserverservicegroupbinding: Finished"
    }
}

function Invoke-ADCGetLbvserverservicegroupbinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the servicegroup that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_servicegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_servicegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverservicegroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverservicegroupbinding -GetAll 
        Get all lbvserver_servicegroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverservicegroupbinding -Count 
        Get the number of lbvserver_servicegroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverservicegroupbinding -name <string>
        Get lbvserver_servicegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverservicegroupbinding -Filter @{ 'name'='<value>' }
        Get lbvserver_servicegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverservicegroupbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_servicegroup_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverservicegroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_servicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_servicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_servicegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_servicegroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_servicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverservicegroupbinding: Ended"
    }
}

function Invoke-ADCAddLbvserverservicebinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the service that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Servicename 
        Service to bind to the virtual server. 
    .PARAMETER Weight 
        Weight to assign to the specified service. 
    .PARAMETER Servicegroupname 
        Name of the service group. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_service_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserverservicebinding -name <string>
        An example how to add lbvserver_service_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserverservicebinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_service_binding/
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
        [string]$Servicename,

        [ValidateRange(1, 100)]
        [double]$Weight,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servicegroupname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverservicebinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('servicename') ) { $payload.Add('servicename', $servicename) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('servicegroupname') ) { $payload.Add('servicegroupname', $servicegroupname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_service_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_service_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserverservicebinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserverservicebinding: Finished"
    }
}

function Invoke-ADCDeleteLbvserverservicebinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the service that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Servicename 
        Service to bind to the virtual server. 
    .PARAMETER Servicegroupname 
        Name of the service group.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserverservicebinding -Name <string>
        An example how to delete lbvserver_service_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverservicebinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_service_binding/
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

        [string]$Servicename,

        [string]$Servicegroupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverservicebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Servicename') ) { $arguments.Add('servicename', $Servicename) }
            if ( $PSBoundParameters.ContainsKey('Servicegroupname') ) { $arguments.Add('servicegroupname', $Servicegroupname) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_service_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserverservicebinding: Finished"
    }
}

function Invoke-ADCGetLbvserverservicebinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the service that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_service_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_service_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverservicebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverservicebinding -GetAll 
        Get all lbvserver_service_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverservicebinding -Count 
        Get the number of lbvserver_service_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverservicebinding -name <string>
        Get lbvserver_service_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverservicebinding -Filter @{ 'name'='<value>' }
        Get lbvserver_service_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverservicebinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_service_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverservicebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_service_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_service_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_service_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_service_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_service_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_service_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_service_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_service_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverservicebinding: Ended"
    }
}

function Invoke-ADCAddLbvserverspilloverpolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_spilloverpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvserverspilloverpolicybinding -name <string>
        An example how to add lbvserver_spilloverpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvserverspilloverpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_spilloverpolicy_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverspilloverpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_spilloverpolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_spilloverpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvserverspilloverpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvserverspilloverpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvserverspilloverpolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvserverspilloverpolicybinding -Name <string>
        An example how to delete lbvserver_spilloverpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverspilloverpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_spilloverpolicy_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverspilloverpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvserverspilloverpolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvserverspilloverpolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_spilloverpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_spilloverpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverspilloverpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverspilloverpolicybinding -GetAll 
        Get all lbvserver_spilloverpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverspilloverpolicybinding -Count 
        Get the number of lbvserver_spilloverpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverspilloverpolicybinding -name <string>
        Get lbvserver_spilloverpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverspilloverpolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_spilloverpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverspilloverpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_spilloverpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverspilloverpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_spilloverpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_spilloverpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_spilloverpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverspilloverpolicybinding: Ended"
    }
}

function Invoke-ADCAddLbvservertmtrafficpolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the tmtrafficpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Bindpoint 
        Bind point to which to bind the policy. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_tmtrafficpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvservertmtrafficpolicybinding -name <string>
        An example how to add lbvserver_tmtrafficpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvservertmtrafficpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_tmtrafficpolicy_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvservertmtrafficpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_tmtrafficpolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_tmtrafficpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvservertmtrafficpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvservertmtrafficpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvservertmtrafficpolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the tmtrafficpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        Bind point to which to bind the policy. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvservertmtrafficpolicybinding -Name <string>
        An example how to delete lbvserver_tmtrafficpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvservertmtrafficpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_tmtrafficpolicy_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvservertmtrafficpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvservertmtrafficpolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvservertmtrafficpolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the tmtrafficpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_tmtrafficpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_tmtrafficpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservertmtrafficpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvservertmtrafficpolicybinding -GetAll 
        Get all lbvserver_tmtrafficpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvservertmtrafficpolicybinding -Count 
        Get the number of lbvserver_tmtrafficpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservertmtrafficpolicybinding -name <string>
        Get lbvserver_tmtrafficpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservertmtrafficpolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_tmtrafficpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvservertmtrafficpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_tmtrafficpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvservertmtrafficpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_tmtrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_tmtrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_tmtrafficpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_tmtrafficpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_tmtrafficpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvservertmtrafficpolicybinding: Ended"
    }
}

function Invoke-ADCAddLbvservertransformpolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the transformpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_transformpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvservertransformpolicybinding -name <string>
        An example how to add lbvserver_transformpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvservertransformpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_transformpolicy_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvservertransformpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_transformpolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_transformpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvservertransformpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvservertransformpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvservertransformpolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the transformpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvservertransformpolicybinding -Name <string>
        An example how to delete lbvserver_transformpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvservertransformpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_transformpolicy_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvservertransformpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_transformpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvservertransformpolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvservertransformpolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the transformpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_transformpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_transformpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservertransformpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvservertransformpolicybinding -GetAll 
        Get all lbvserver_transformpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvservertransformpolicybinding -Count 
        Get the number of lbvserver_transformpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservertransformpolicybinding -name <string>
        Get lbvserver_transformpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservertransformpolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_transformpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvservertransformpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_transformpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvservertransformpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_transformpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_transformpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_transformpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_transformpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_transformpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_transformpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_transformpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_transformpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_transformpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_transformpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvservertransformpolicybinding: Ended"
    }
}

function Invoke-ADCAddLbvservervideooptimizationdetectionpolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the videooptimizationdetectionpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_videooptimizationdetectionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvservervideooptimizationdetectionpolicybinding -name <string>
        An example how to add lbvserver_videooptimizationdetectionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvservervideooptimizationdetectionpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_videooptimizationdetectionpolicy_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvservervideooptimizationdetectionpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_videooptimizationdetectionpolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_videooptimizationdetectionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvservervideooptimizationdetectionpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvservervideooptimizationdetectionpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvservervideooptimizationdetectionpolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the videooptimizationdetectionpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvservervideooptimizationdetectionpolicybinding -Name <string>
        An example how to delete lbvserver_videooptimizationdetectionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvservervideooptimizationdetectionpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_videooptimizationdetectionpolicy_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvservervideooptimizationdetectionpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvservervideooptimizationdetectionpolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvservervideooptimizationdetectionpolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the videooptimizationdetectionpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_videooptimizationdetectionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_videooptimizationdetectionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservervideooptimizationdetectionpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvservervideooptimizationdetectionpolicybinding -GetAll 
        Get all lbvserver_videooptimizationdetectionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvservervideooptimizationdetectionpolicybinding -Count 
        Get the number of lbvserver_videooptimizationdetectionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservervideooptimizationdetectionpolicybinding -name <string>
        Get lbvserver_videooptimizationdetectionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservervideooptimizationdetectionpolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_videooptimizationdetectionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvservervideooptimizationdetectionpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_videooptimizationdetectionpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvservervideooptimizationdetectionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_videooptimizationdetectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_videooptimizationdetectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_videooptimizationdetectionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_videooptimizationdetectionpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_videooptimizationdetectionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvservervideooptimizationdetectionpolicybinding: Ended"
    }
}

function Invoke-ADCAddLbvservervideooptimizationpacingpolicybinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the videooptimizationpacingpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_videooptimizationpacingpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbvservervideooptimizationpacingpolicybinding -name <string>
        An example how to add lbvserver_videooptimizationpacingpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbvservervideooptimizationpacingpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_videooptimizationpacingpolicy_binding/
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

        [string]$Policyname,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvservervideooptimizationpacingpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("lbvserver_videooptimizationpacingpolicy_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbvserver_videooptimizationpacingpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbvservervideooptimizationpacingpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbvservervideooptimizationpacingpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteLbvservervideooptimizationpacingpolicybinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the videooptimizationpacingpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER Policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbvservervideooptimizationpacingpolicybinding -Name <string>
        An example how to delete lbvserver_videooptimizationpacingpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbvservervideooptimizationpacingpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_videooptimizationpacingpolicy_binding/
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

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvservervideooptimizationpacingpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbvservervideooptimizationpacingpolicybinding: Finished"
    }
}

function Invoke-ADCGetLbvservervideooptimizationpacingpolicybinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the videooptimizationpacingpolicy that can be bound to lbvserver.
    .PARAMETER Name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retrieve all lbvserver_videooptimizationpacingpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver_videooptimizationpacingpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservervideooptimizationpacingpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvservervideooptimizationpacingpolicybinding -GetAll 
        Get all lbvserver_videooptimizationpacingpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvservervideooptimizationpacingpolicybinding -Count 
        Get the number of lbvserver_videooptimizationpacingpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservervideooptimizationpacingpolicybinding -name <string>
        Get lbvserver_videooptimizationpacingpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvservervideooptimizationpacingpolicybinding -Filter @{ 'name'='<value>' }
        Get lbvserver_videooptimizationpacingpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvservervideooptimizationpacingpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_videooptimizationpacingpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvservervideooptimizationpacingpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbvserver_videooptimizationpacingpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_videooptimizationpacingpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_videooptimizationpacingpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_videooptimizationpacingpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_videooptimizationpacingpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvservervideooptimizationpacingpolicybinding: Ended"
    }
}

function Invoke-ADCAddLbwlm {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for web log manager resource.
    .PARAMETER Wlmname 
        The name of the Work Load Manager. 
    .PARAMETER Ipaddress 
        The IP address of the WLM. 
    .PARAMETER Port 
        The port of the WLM. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Lbuid 
        The LBUID for the Load Balancer to communicate to the Work Load Manager. 
    .PARAMETER Katimeout 
        The idle time period after which Citrix ADC would probe the WLM. The value ranges from 1 to 1440 minutes. 
    .PARAMETER PassThru 
        Return details about the created lbwlm item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbwlm -wlmname <string> -lbuid <string>
        An example how to add lbwlm configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbwlm
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbwlm/
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
        [string]$Wlmname,

        [string]$Ipaddress,

        [ValidateRange(1, 65535)]
        [int]$Port,

        [Parameter(Mandatory)]
        [string]$Lbuid,

        [ValidateRange(0, 1440)]
        [double]$Katimeout = '2',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbwlm: Starting"
    }
    process {
        try {
            $payload = @{ wlmname = $wlmname
                lbuid             = $lbuid
            }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('katimeout') ) { $payload.Add('katimeout', $katimeout) }
            if ( $PSCmdlet.ShouldProcess("lbwlm", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lbwlm -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbwlm -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbwlm: Finished"
    }
}

function Invoke-ADCDeleteLbwlm {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for web log manager resource.
    .PARAMETER Wlmname 
        The name of the Work Load Manager.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbwlm -Wlmname <string>
        An example how to delete lbwlm configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbwlm
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbwlm/
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
        [string]$Wlmname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbwlm: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$wlmname", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbwlm -NitroPath nitro/v1/config -Resource $wlmname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbwlm: Finished"
    }
}

function Invoke-ADCUpdateLbwlm {
    <#
    .SYNOPSIS
        Update Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for web log manager resource.
    .PARAMETER Wlmname 
        The name of the Work Load Manager. 
    .PARAMETER Katimeout 
        The idle time period after which Citrix ADC would probe the WLM. The value ranges from 1 to 1440 minutes. 
    .PARAMETER PassThru 
        Return details about the created lbwlm item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLbwlm -wlmname <string>
        An example how to update lbwlm configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLbwlm
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbwlm/
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
        [string]$Wlmname,

        [ValidateRange(0, 1440)]
        [double]$Katimeout,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLbwlm: Starting"
    }
    process {
        try {
            $payload = @{ wlmname = $wlmname }
            if ( $PSBoundParameters.ContainsKey('katimeout') ) { $payload.Add('katimeout', $katimeout) }
            if ( $PSCmdlet.ShouldProcess("lbwlm", "Update Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbwlm -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbwlm -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateLbwlm: Finished"
    }
}

function Invoke-ADCUnsetLbwlm {
    <#
    .SYNOPSIS
        Unset Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for web log manager resource.
    .PARAMETER Wlmname 
        The name of the Work Load Manager. 
    .PARAMETER Katimeout 
        The idle time period after which Citrix ADC would probe the WLM. The value ranges from 1 to 1440 minutes.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLbwlm -wlmname <string>
        An example how to unset lbwlm configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLbwlm
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbwlm
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
        [string]$Wlmname,

        [Boolean]$katimeout 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLbwlm: Starting"
    }
    process {
        try {
            $payload = @{ wlmname = $wlmname }
            if ( $PSBoundParameters.ContainsKey('katimeout') ) { $payload.Add('katimeout', $katimeout) }
            if ( $PSCmdlet.ShouldProcess("$wlmname", "Unset Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbwlm -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLbwlm: Finished"
    }
}

function Invoke-ADCGetLbwlm {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for web log manager resource.
    .PARAMETER Wlmname 
        The name of the Work Load Manager. 
    .PARAMETER GetAll 
        Retrieve all lbwlm object(s).
    .PARAMETER Count
        If specified, the count of the lbwlm object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbwlm
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbwlm -GetAll 
        Get all lbwlm data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbwlm -Count 
        Get the number of lbwlm objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbwlm -name <string>
        Get lbwlm object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbwlm -Filter @{ 'name'='<value>' }
        Get lbwlm data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbwlm
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbwlm/
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
        [string]$Wlmname,

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
        Write-Verbose "Invoke-ADCGetLbwlm: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lbwlm objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbwlm objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbwlm objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbwlm configuration for property 'wlmname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm -NitroPath nitro/v1/config -Resource $wlmname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbwlm configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbwlm: Ended"
    }
}

function Invoke-ADCGetLbwlmbinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to lbwlm.
    .PARAMETER Wlmname 
        The name of the work load manager. 
    .PARAMETER GetAll 
        Retrieve all lbwlm_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbwlm_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbwlmbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbwlmbinding -GetAll 
        Get all lbwlm_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbwlmbinding -name <string>
        Get lbwlm_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbwlmbinding -Filter @{ 'name'='<value>' }
        Get lbwlm_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbwlmbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbwlm_binding/
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
        [string]$Wlmname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbwlmbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbwlm_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbwlm_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbwlm_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbwlm_binding configuration for property 'wlmname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_binding -NitroPath nitro/v1/config -Resource $wlmname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbwlm_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbwlmbinding: Ended"
    }
}

function Invoke-ADCAddLbwlmlbvserverbinding {
    <#
    .SYNOPSIS
        Add Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to lbwlm.
    .PARAMETER Wlmname 
        The name of the Work Load Manager. 
    .PARAMETER Vservername 
        Name of the virtual server which is to be bound to the WLM. 
    .PARAMETER PassThru 
        Return details about the created lbwlm_lbvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLbwlmlbvserverbinding -wlmname <string> -vservername <string>
        An example how to add lbwlm_lbvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLbwlmlbvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbwlm_lbvserver_binding/
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
        [string]$Wlmname,

        [Parameter(Mandatory)]
        [string]$Vservername,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLbwlmlbvserverbinding: Starting"
    }
    process {
        try {
            $payload = @{ wlmname = $wlmname
                vservername       = $vservername
            }

            if ( $PSCmdlet.ShouldProcess("lbwlm_lbvserver_binding", "Add Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lbwlm_lbvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLbwlmlbvserverbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLbwlmlbvserverbinding: Finished"
    }
}

function Invoke-ADCDeleteLbwlmlbvserverbinding {
    <#
    .SYNOPSIS
        Delete Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to lbwlm.
    .PARAMETER Wlmname 
        The name of the Work Load Manager. 
    .PARAMETER Vservername 
        Name of the virtual server which is to be bound to the WLM.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLbwlmlbvserverbinding -Wlmname <string>
        An example how to delete lbwlm_lbvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLbwlmlbvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbwlm_lbvserver_binding/
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
        [string]$Wlmname,

        [string]$Vservername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbwlmlbvserverbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Vservername') ) { $arguments.Add('vservername', $Vservername) }
            if ( $PSCmdlet.ShouldProcess("$wlmname", "Delete Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbwlm_lbvserver_binding -NitroPath nitro/v1/config -Resource $wlmname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLbwlmlbvserverbinding: Finished"
    }
}

function Invoke-ADCGetLbwlmlbvserverbinding {
    <#
    .SYNOPSIS
        Get Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to lbwlm.
    .PARAMETER Wlmname 
        The name of the Work Load Manager. 
    .PARAMETER GetAll 
        Retrieve all lbwlm_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the lbwlm_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbwlmlbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbwlmlbvserverbinding -GetAll 
        Get all lbwlm_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbwlmlbvserverbinding -Count 
        Get the number of lbwlm_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbwlmlbvserverbinding -name <string>
        Get lbwlm_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbwlmlbvserverbinding -Filter @{ 'name'='<value>' }
        Get lbwlm_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbwlmlbvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbwlm_lbvserver_binding/
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
        [string]$Wlmname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbwlmlbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lbwlm_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbwlm_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbwlm_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbwlm_lbvserver_binding configuration for property 'wlmname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_lbvserver_binding -NitroPath nitro/v1/config -Resource $wlmname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbwlm_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbwlmlbvserverbinding: Ended"
    }
}


