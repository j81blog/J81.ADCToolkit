function Invoke-ADCAddLbgroup {
<#
    .SYNOPSIS
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name of the load balancing virtual server group.  
        Minimum length = 1 
    .PARAMETER persistencetype 
        Type of persistence for the group. Available settings function as follows:  
        * SOURCEIP - Create persistence sessions based on the client IP.  
        * COOKIEINSERT - Create persistence sessions based on a cookie in client requests. The cookie is inserted by a Set-Cookie directive from the server, in its first response to a client.  
        * RULE - Create persistence sessions based on a user defined rule.  
        * NONE - Disable persistence for the group.  
        Possible values = SOURCEIP, COOKIEINSERT, RULE, NONE 
    .PARAMETER persistencebackup 
        Type of backup persistence for the group.  
        Possible values = SOURCEIP, NONE 
    .PARAMETER backuppersistencetimeout 
        Time period, in minutes, for which backup persistence is in effect.  
        Default value: 2  
        Minimum value = 2  
        Maximum value = 1440 
    .PARAMETER persistmask 
        Persistence mask to apply to source IPv4 addresses when creating source IP based persistence sessions.  
        Minimum length = 1 
    .PARAMETER cookiename 
        Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
    .PARAMETER v6persistmasklen 
        Persistence mask to apply to source IPv6 addresses when creating source IP based persistence sessions.  
        Default value: 128  
        Minimum value = 1  
        Maximum value = 128 
    .PARAMETER cookiedomain 
        Domain attribute for the HTTP cookie.  
        Minimum length = 1 
    .PARAMETER timeout 
        Time period for which a persistence session is in effect.  
        Default value: 2  
        Minimum value = 0  
        Maximum value = 1440 
    .PARAMETER rule 
        Expression, or name of a named expression, against which traffic is evaluated.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks.  
        Default value: "None" 
    .PARAMETER usevserverpersistency 
        Use this parameter to enable vserver level persistence on group members. This allows member vservers to have their own persistence, but need to be compatible with other members persistence rules. When this setting is enabled persistence sessions created by any of the members can be shared by other member vservers.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lbgroup item.
    .EXAMPLE
        Invoke-ADCAddLbgroup -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbgroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup/
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

        [ValidateSet('SOURCEIP', 'COOKIEINSERT', 'RULE', 'NONE')]
        [string]$persistencetype ,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$persistencebackup ,

        [ValidateRange(2, 1440)]
        [double]$backuppersistencetimeout = '2' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$persistmask ,

        [string]$cookiename ,

        [ValidateRange(1, 128)]
        [double]$v6persistmasklen = '128' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cookiedomain ,

        [ValidateRange(0, 1440)]
        [double]$timeout = '2' ,

        [string]$rule = '"None"' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$usevserverpersistency = 'DISABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbgroup: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('persistencetype')) { $Payload.Add('persistencetype', $persistencetype) }
            if ($PSBoundParameters.ContainsKey('persistencebackup')) { $Payload.Add('persistencebackup', $persistencebackup) }
            if ($PSBoundParameters.ContainsKey('backuppersistencetimeout')) { $Payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('persistmask')) { $Payload.Add('persistmask', $persistmask) }
            if ($PSBoundParameters.ContainsKey('cookiename')) { $Payload.Add('cookiename', $cookiename) }
            if ($PSBoundParameters.ContainsKey('v6persistmasklen')) { $Payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ($PSBoundParameters.ContainsKey('cookiedomain')) { $Payload.Add('cookiedomain', $cookiedomain) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('usevserverpersistency')) { $Payload.Add('usevserverpersistency', $usevserverpersistency) }
 
            if ($PSCmdlet.ShouldProcess("lbgroup", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbgroup -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbgroup -Filter $Payload)
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
        Update Load Balancing configuration Object
    .DESCRIPTION
        Update Load Balancing configuration Object 
    .PARAMETER name 
        Name of the load balancing virtual server group.  
        Minimum length = 1 
    .PARAMETER persistencetype 
        Type of persistence for the group. Available settings function as follows:  
        * SOURCEIP - Create persistence sessions based on the client IP.  
        * COOKIEINSERT - Create persistence sessions based on a cookie in client requests. The cookie is inserted by a Set-Cookie directive from the server, in its first response to a client.  
        * RULE - Create persistence sessions based on a user defined rule.  
        * NONE - Disable persistence for the group.  
        Possible values = SOURCEIP, COOKIEINSERT, RULE, NONE 
    .PARAMETER persistencebackup 
        Type of backup persistence for the group.  
        Possible values = SOURCEIP, NONE 
    .PARAMETER backuppersistencetimeout 
        Time period, in minutes, for which backup persistence is in effect.  
        Default value: 2  
        Minimum value = 2  
        Maximum value = 1440 
    .PARAMETER persistmask 
        Persistence mask to apply to source IPv4 addresses when creating source IP based persistence sessions.  
        Minimum length = 1 
    .PARAMETER cookiename 
        Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
    .PARAMETER v6persistmasklen 
        Persistence mask to apply to source IPv6 addresses when creating source IP based persistence sessions.  
        Default value: 128  
        Minimum value = 1  
        Maximum value = 128 
    .PARAMETER cookiedomain 
        Domain attribute for the HTTP cookie.  
        Minimum length = 1 
    .PARAMETER timeout 
        Time period for which a persistence session is in effect.  
        Default value: 2  
        Minimum value = 0  
        Maximum value = 1440 
    .PARAMETER rule 
        Expression, or name of a named expression, against which traffic is evaluated.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks.  
        Default value: "None" 
    .PARAMETER usevserverpersistency 
        Use this parameter to enable vserver level persistence on group members. This allows member vservers to have their own persistence, but need to be compatible with other members persistence rules. When this setting is enabled persistence sessions created by any of the members can be shared by other member vservers.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER mastervserver 
        When USE_VSERVER_PERSISTENCE is enabled, one can use this setting to designate a member vserver as master which is responsible to create the persistence sessions. 
    .PARAMETER PassThru 
        Return details about the created lbgroup item.
    .EXAMPLE
        Invoke-ADCUpdateLbgroup -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateLbgroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup/
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

        [ValidateSet('SOURCEIP', 'COOKIEINSERT', 'RULE', 'NONE')]
        [string]$persistencetype ,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$persistencebackup ,

        [ValidateRange(2, 1440)]
        [double]$backuppersistencetimeout ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$persistmask ,

        [string]$cookiename ,

        [ValidateRange(1, 128)]
        [double]$v6persistmasklen ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cookiedomain ,

        [ValidateRange(0, 1440)]
        [double]$timeout ,

        [string]$rule ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$usevserverpersistency ,

        [string]$mastervserver ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLbgroup: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('persistencetype')) { $Payload.Add('persistencetype', $persistencetype) }
            if ($PSBoundParameters.ContainsKey('persistencebackup')) { $Payload.Add('persistencebackup', $persistencebackup) }
            if ($PSBoundParameters.ContainsKey('backuppersistencetimeout')) { $Payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('persistmask')) { $Payload.Add('persistmask', $persistmask) }
            if ($PSBoundParameters.ContainsKey('cookiename')) { $Payload.Add('cookiename', $cookiename) }
            if ($PSBoundParameters.ContainsKey('v6persistmasklen')) { $Payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ($PSBoundParameters.ContainsKey('cookiedomain')) { $Payload.Add('cookiedomain', $cookiedomain) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('usevserverpersistency')) { $Payload.Add('usevserverpersistency', $usevserverpersistency) }
            if ($PSBoundParameters.ContainsKey('mastervserver')) { $Payload.Add('mastervserver', $mastervserver) }
 
            if ($PSCmdlet.ShouldProcess("lbgroup", "Update Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbgroup -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbgroup -Filter $Payload)
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
        Unset Load Balancing configuration Object
    .DESCRIPTION
        Unset Load Balancing configuration Object 
   .PARAMETER name 
       Name of the load balancing virtual server group. 
   .PARAMETER persistencetype 
       Type of persistence for the group. Available settings function as follows:  
       * SOURCEIP - Create persistence sessions based on the client IP.  
       * COOKIEINSERT - Create persistence sessions based on a cookie in client requests. The cookie is inserted by a Set-Cookie directive from the server, in its first response to a client.  
       * RULE - Create persistence sessions based on a user defined rule.  
       * NONE - Disable persistence for the group.  
       Possible values = SOURCEIP, COOKIEINSERT, RULE, NONE 
   .PARAMETER persistencebackup 
       Type of backup persistence for the group.  
       Possible values = SOURCEIP, NONE 
   .PARAMETER backuppersistencetimeout 
       Time period, in minutes, for which backup persistence is in effect. 
   .PARAMETER persistmask 
       Persistence mask to apply to source IPv4 addresses when creating source IP based persistence sessions. 
   .PARAMETER cookiename 
       Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
   .PARAMETER v6persistmasklen 
       Persistence mask to apply to source IPv6 addresses when creating source IP based persistence sessions. 
   .PARAMETER cookiedomain 
       Domain attribute for the HTTP cookie. 
   .PARAMETER timeout 
       Time period for which a persistence session is in effect. 
   .PARAMETER rule 
       Expression, or name of a named expression, against which traffic is evaluated.  
       The following requirements apply only to the Citrix ADC CLI:  
       * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
       * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
       * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
   .PARAMETER usevserverpersistency 
       Use this parameter to enable vserver level persistence on group members. This allows member vservers to have their own persistence, but need to be compatible with other members persistence rules. When this setting is enabled persistence sessions created by any of the members can be shared by other member vservers.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER mastervserver 
       When USE_VSERVER_PERSISTENCE is enabled, one can use this setting to designate a member vserver as master which is responsible to create the persistence sessions.
    .EXAMPLE
        Invoke-ADCUnsetLbgroup -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetLbgroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup
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

        [Boolean]$persistencetype ,

        [Boolean]$persistencebackup ,

        [Boolean]$backuppersistencetimeout ,

        [Boolean]$persistmask ,

        [Boolean]$cookiename ,

        [Boolean]$v6persistmasklen ,

        [Boolean]$cookiedomain ,

        [Boolean]$timeout ,

        [Boolean]$rule ,

        [Boolean]$usevserverpersistency ,

        [Boolean]$mastervserver 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLbgroup: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('persistencetype')) { $Payload.Add('persistencetype', $persistencetype) }
            if ($PSBoundParameters.ContainsKey('persistencebackup')) { $Payload.Add('persistencebackup', $persistencebackup) }
            if ($PSBoundParameters.ContainsKey('backuppersistencetimeout')) { $Payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('persistmask')) { $Payload.Add('persistmask', $persistmask) }
            if ($PSBoundParameters.ContainsKey('cookiename')) { $Payload.Add('cookiename', $cookiename) }
            if ($PSBoundParameters.ContainsKey('v6persistmasklen')) { $Payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ($PSBoundParameters.ContainsKey('cookiedomain')) { $Payload.Add('cookiedomain', $cookiedomain) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('usevserverpersistency')) { $Payload.Add('usevserverpersistency', $usevserverpersistency) }
            if ($PSBoundParameters.ContainsKey('mastervserver')) { $Payload.Add('mastervserver', $mastervserver) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbgroup -Action unset -Payload $Payload -GetWarning
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name of the load balancing virtual server group.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteLbgroup -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbgroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup/
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
        Write-Verbose "Invoke-ADCDeleteLbgroup: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbgroup -Resource $name -Arguments $Arguments
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
        Rename Load Balancing configuration Object
    .DESCRIPTION
        Rename Load Balancing configuration Object 
    .PARAMETER name 
        Name of the load balancing virtual server group.  
        Minimum length = 1 
    .PARAMETER newname 
        New name for the load balancing virtual server group.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created lbgroup item.
    .EXAMPLE
        Invoke-ADCRenameLbgroup -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameLbgroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup/
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

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameLbgroup: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("lbgroup", "Rename Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbgroup -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbgroup -Filter $Payload)
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name of the load balancing virtual server group. 
    .PARAMETER GetAll 
        Retreive all lbgroup object(s)
    .PARAMETER Count
        If specified, the count of the lbgroup object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbgroup
    .EXAMPLE 
        Invoke-ADCGetLbgroup -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbgroup -Count
    .EXAMPLE
        Invoke-ADCGetLbgroup -name <string>
    .EXAMPLE
        Invoke-ADCGetLbgroup -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbgroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup/
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lbgroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbgroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbgroup objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbgroup configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbgroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name of the load balancing virtual server group. 
    .PARAMETER GetAll 
        Retreive all lbgroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbgroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbgroupbinding
    .EXAMPLE 
        Invoke-ADCGetLbgroupbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetLbgroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbgroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbgroupbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup_binding/
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
        Write-Verbose "Invoke-ADCGetLbgroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbgroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbgroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbgroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbgroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbgroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the load balancing virtual server group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my lbgroup" or 'my lbgroup').  
        Minimum length = 1 
    .PARAMETER vservername 
        Virtual server name. 
    .PARAMETER PassThru 
        Return details about the created lbgroup_lbvserver_binding item.
    .EXAMPLE
        Invoke-ADCAddLbgrouplbvserverbinding -name <string> -vservername <string>
    .NOTES
        File Name : Invoke-ADCAddLbgrouplbvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup_lbvserver_binding/
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
        [string]$vservername ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbgrouplbvserverbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                vservername = $vservername
            }

 
            if ($PSCmdlet.ShouldProcess("lbgroup_lbvserver_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbgroup_lbvserver_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbgrouplbvserverbinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the load balancing virtual server group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my lbgroup" or 'my lbgroup').  
       Minimum length = 1    .PARAMETER vservername 
       Virtual server name.
    .EXAMPLE
        Invoke-ADCDeleteLbgrouplbvserverbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbgrouplbvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup_lbvserver_binding/
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

        [string]$vservername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbgrouplbvserverbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('vservername')) { $Arguments.Add('vservername', $vservername) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbgroup_lbvserver_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the load balancing virtual server group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my lbgroup" or 'my lbgroup'). 
    .PARAMETER GetAll 
        Retreive all lbgroup_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbgroup_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbgrouplbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetLbgrouplbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbgrouplbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetLbgrouplbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbgrouplbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbgrouplbvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbgroup_lbvserver_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbgrouplbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbgroup_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_lbvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbgroup_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_lbvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbgroup_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_lbvserver_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbgroup_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_lbvserver_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbgroup_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbgroup_lbvserver_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER metrictable 
        Name for the metric table. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my metrictable" or 'my metrictable').  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER PassThru 
        Return details about the created lbmetrictable item.
    .EXAMPLE
        Invoke-ADCAddLbmetrictable -metrictable <string>
    .NOTES
        File Name : Invoke-ADCAddLbmetrictable
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmetrictable/
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
        [ValidateLength(1, 31)]
        [string]$metrictable ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbmetrictable: Starting"
    }
    process {
        try {
            $Payload = @{
                metrictable = $metrictable
            }

 
            if ($PSCmdlet.ShouldProcess("lbmetrictable", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbmetrictable -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbmetrictable -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER metrictable 
       Name for the metric table. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my metrictable" or 'my metrictable').  
       Minimum length = 1  
       Maximum length = 31 
    .EXAMPLE
        Invoke-ADCDeleteLbmetrictable -metrictable <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbmetrictable
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmetrictable/
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
        [string]$metrictable 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbmetrictable: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$metrictable", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbmetrictable -Resource $metrictable -Arguments $Arguments
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
        Update Load Balancing configuration Object
    .DESCRIPTION
        Update Load Balancing configuration Object 
    .PARAMETER metrictable 
        Name for the metric table. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my metrictable" or 'my metrictable').  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER metric 
        Name of the metric for which to change the SNMP OID.  
        Minimum length = 1 
    .PARAMETER Snmpoid 
        New SNMP OID of the metric.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created lbmetrictable item.
    .EXAMPLE
        Invoke-ADCUpdateLbmetrictable -metrictable <string> -metric <string> -Snmpoid <string>
    .NOTES
        File Name : Invoke-ADCUpdateLbmetrictable
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmetrictable/
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
        [ValidateLength(1, 31)]
        [string]$metrictable ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$metric ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Snmpoid ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLbmetrictable: Starting"
    }
    process {
        try {
            $Payload = @{
                metrictable = $metrictable
                metric = $metric
                Snmpoid = $Snmpoid
            }

 
            if ($PSCmdlet.ShouldProcess("lbmetrictable", "Update Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbmetrictable -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbmetrictable -Filter $Payload)
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER metrictable 
       Name for the metric table. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my metrictable" or 'my metrictable'). 
    .PARAMETER GetAll 
        Retreive all lbmetrictable object(s)
    .PARAMETER Count
        If specified, the count of the lbmetrictable object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbmetrictable
    .EXAMPLE 
        Invoke-ADCGetLbmetrictable -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbmetrictable -Count
    .EXAMPLE
        Invoke-ADCGetLbmetrictable -name <string>
    .EXAMPLE
        Invoke-ADCGetLbmetrictable -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbmetrictable
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmetrictable/
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
        [ValidateLength(1, 31)]
        [string]$metrictable,

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
        Write-Verbose "Invoke-ADCGetLbmetrictable: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lbmetrictable objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmetrictable objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmetrictable objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmetrictable configuration for property 'metrictable'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable -Resource $metrictable -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmetrictable configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER metrictable 
       Name of the metric table. 
    .PARAMETER GetAll 
        Retreive all lbmetrictable_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbmetrictable_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbmetrictablebinding
    .EXAMPLE 
        Invoke-ADCGetLbmetrictablebinding -GetAll
    .EXAMPLE
        Invoke-ADCGetLbmetrictablebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbmetrictablebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbmetrictablebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmetrictable_binding/
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
        [ValidateLength(1, 31)]
        [string]$metrictable,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbmetrictablebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbmetrictable_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmetrictable_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmetrictable_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmetrictable_binding configuration for property 'metrictable'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_binding -Resource $metrictable -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmetrictable_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER metrictable 
        Name of the metric table.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER metric 
        Name of the metric for which to change the SNMP OID.  
        Minimum length = 1 
    .PARAMETER Snmpoid 
        New SNMP OID of the metric.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created lbmetrictable_metric_binding item.
    .EXAMPLE
        Invoke-ADCAddLbmetrictablemetricbinding -metrictable <string> -metric <string> -Snmpoid <string>
    .NOTES
        File Name : Invoke-ADCAddLbmetrictablemetricbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmetrictable_metric_binding/
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
        [ValidateLength(1, 31)]
        [string]$metrictable ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$metric ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Snmpoid ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbmetrictablemetricbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                metrictable = $metrictable
                metric = $metric
                Snmpoid = $Snmpoid
            }

 
            if ($PSCmdlet.ShouldProcess("lbmetrictable_metric_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbmetrictable_metric_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbmetrictablemetricbinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER metrictable 
       Name of the metric table.  
       Minimum length = 1  
       Maximum length = 31    .PARAMETER metric 
       Name of the metric for which to change the SNMP OID.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteLbmetrictablemetricbinding -metrictable <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbmetrictablemetricbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmetrictable_metric_binding/
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
        [string]$metrictable ,

        [string]$metric 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbmetrictablemetricbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('metric')) { $Arguments.Add('metric', $metric) }
            if ($PSCmdlet.ShouldProcess("$metrictable", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbmetrictable_metric_binding -Resource $metrictable -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER metrictable 
       Name of the metric table. 
    .PARAMETER GetAll 
        Retreive all lbmetrictable_metric_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbmetrictable_metric_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbmetrictablemetricbinding
    .EXAMPLE 
        Invoke-ADCGetLbmetrictablemetricbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbmetrictablemetricbinding -Count
    .EXAMPLE
        Invoke-ADCGetLbmetrictablemetricbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbmetrictablemetricbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbmetrictablemetricbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmetrictable_metric_binding/
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
        [ValidateLength(1, 31)]
        [string]$metrictable,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbmetrictable_metric_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_metric_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmetrictable_metric_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_metric_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmetrictable_metric_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_metric_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmetrictable_metric_binding configuration for property 'metrictable'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_metric_binding -Resource $metrictable -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmetrictable_metric_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmetrictable_metric_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER monitorname 
       The name of the monitor. 
    .PARAMETER GetAll 
        Retreive all lbmonbindings object(s)
    .PARAMETER Count
        If specified, the count of the lbmonbindings object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbmonbindings
    .EXAMPLE 
        Invoke-ADCGetLbmonbindings -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbmonbindings -Count
    .EXAMPLE
        Invoke-ADCGetLbmonbindings -name <string>
    .EXAMPLE
        Invoke-ADCGetLbmonbindings -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbmonbindings
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonbindings/
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
        [string]$monitorname,
			
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lbmonbindings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmonbindings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmonbindings objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmonbindings configuration for property 'monitorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings -Resource $monitorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmonbindings configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER monitorname 
       The name of the monitor. 
    .PARAMETER GetAll 
        Retreive all lbmonbindings_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbmonbindings_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbmonbindingsbinding
    .EXAMPLE 
        Invoke-ADCGetLbmonbindingsbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetLbmonbindingsbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbmonbindingsbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbmonbindingsbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonbindings_binding/
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
        [string]$monitorname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbmonbindingsbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbmonbindings_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmonbindings_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmonbindings_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmonbindings_binding configuration for property 'monitorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_binding -Resource $monitorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmonbindings_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER monitorname 
       The name of the monitor. 
    .PARAMETER GetAll 
        Retreive all lbmonbindings_gslbservicegroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbmonbindings_gslbservicegroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbmonbindingsgslbservicegroupbinding
    .EXAMPLE 
        Invoke-ADCGetLbmonbindingsgslbservicegroupbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbmonbindingsgslbservicegroupbinding -Count
    .EXAMPLE
        Invoke-ADCGetLbmonbindingsgslbservicegroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbmonbindingsgslbservicegroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbmonbindingsgslbservicegroupbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonbindings_gslbservicegroup_binding/
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
        [string]$monitorname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbmonbindings_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_gslbservicegroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmonbindings_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_gslbservicegroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmonbindings_gslbservicegroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_gslbservicegroup_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmonbindings_gslbservicegroup_binding configuration for property 'monitorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_gslbservicegroup_binding -Resource $monitorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmonbindings_gslbservicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_gslbservicegroup_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER monitorname 
       The name of the monitor. 
    .PARAMETER GetAll 
        Retreive all lbmonbindings_servicegroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbmonbindings_servicegroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbmonbindingsservicegroupbinding
    .EXAMPLE 
        Invoke-ADCGetLbmonbindingsservicegroupbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbmonbindingsservicegroupbinding -Count
    .EXAMPLE
        Invoke-ADCGetLbmonbindingsservicegroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbmonbindingsservicegroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbmonbindingsservicegroupbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonbindings_servicegroup_binding/
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
        [string]$monitorname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbmonbindings_servicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_servicegroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmonbindings_servicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_servicegroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmonbindings_servicegroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_servicegroup_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmonbindings_servicegroup_binding configuration for property 'monitorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_servicegroup_binding -Resource $monitorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmonbindings_servicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_servicegroup_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER monitorname 
       The name of the monitor. 
    .PARAMETER GetAll 
        Retreive all lbmonbindings_service_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbmonbindings_service_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbmonbindingsservicebinding
    .EXAMPLE 
        Invoke-ADCGetLbmonbindingsservicebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbmonbindingsservicebinding -Count
    .EXAMPLE
        Invoke-ADCGetLbmonbindingsservicebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbmonbindingsservicebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbmonbindingsservicebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonbindings_service_binding/
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
        [string]$monitorname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbmonbindings_service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_service_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmonbindings_service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_service_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmonbindings_service_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_service_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmonbindings_service_binding configuration for property 'monitorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_service_binding -Resource $monitorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmonbindings_service_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonbindings_service_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER monitorname 
        Name for the monitor. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my monitor" or 'my monitor').  
        Minimum length = 1 
    .PARAMETER type 
        Type of monitor that you want to create.  
        Possible values = PING, TCP, HTTP, TCP-ECV, HTTP-ECV, UDP-ECV, DNS, FTP, LDNS-PING, LDNS-TCP, LDNS-DNS, RADIUS, USER, HTTP-INLINE, SIP-UDP, SIP-TCP, LOAD, FTP-EXTENDED, SMTP, SNMP, NNTP, MYSQL, MYSQL-ECV, MSSQL-ECV, ORACLE-ECV, LDAP, POP3, CITRIX-XML-SERVICE, CITRIX-WEB-INTERFACE, DNS-TCP, RTSP, ARP, CITRIX-AG, CITRIX-AAC-LOGINPAGE, CITRIX-AAC-LAS, CITRIX-XD-DDC, ND6, CITRIX-WI-EXTENDED, DIAMETER, RADIUS_ACCOUNTING, STOREFRONT, APPC, SMPP, CITRIX-XNC-ECV, CITRIX-XDM, CITRIX-STA-SERVICE, CITRIX-STA-SERVICE-NHOP 
    .PARAMETER action 
        Action to perform when the response to an inline monitor (a monitor of type HTTP-INLINE) indicates that the service is down. A service monitored by an inline monitor is considered DOWN if the response code is not one of the codes that have been specified for the Response Code parameter.  
        Available settings function as follows:  
        * NONE - Do not take any action. However, the show service command and the show lb monitor command indicate the total number of responses that were checked and the number of consecutive error responses received after the last successful probe.  
        * LOG - Log the event in NSLOG or SYSLOG.  
        * DOWN - Mark the service as being down, and then do not direct any traffic to the service until the configured down time has expired. Persistent connections to the service are terminated as soon as the service is marked as DOWN. Also, log the event in NSLOG or SYSLOG.  
        Default value: DOWN  
        Possible values = NONE, LOG, DOWN 
    .PARAMETER respcode 
        Response codes for which to mark the service as UP. For any other response code, the action performed depends on the monitor type. HTTP monitors and RADIUS monitors mark the service as DOWN, while HTTP-INLINE monitors perform the action indicated by the Action parameter. 
    .PARAMETER httprequest 
        HTTP request to send to the server (for example, "HEAD /file.html"). 
    .PARAMETER rtsprequest 
        RTSP request to send to the server (for example, "OPTIONS *"). 
    .PARAMETER customheaders 
        Custom header string to include in the monitoring probes. 
    .PARAMETER maxforwards 
        Maximum number of hops that the SIP request used for monitoring can traverse to reach the server. Applicable only to monitors of type SIP-UDP.  
        Default value: 1  
        Minimum value = 0  
        Maximum value = 255 
    .PARAMETER sipmethod 
        SIP method to use for the query. Applicable only to monitors of type SIP-UDP.  
        Possible values = OPTIONS, INVITE, REGISTER 
    .PARAMETER sipuri 
        SIP URI string to send to the service (for example, sip:sip.test). Applicable only to monitors of type SIP-UDP.  
        Minimum length = 1 
    .PARAMETER sipreguri 
        SIP user to be registered. Applicable only if the monitor is of type SIP-UDP and the SIP Method parameter is set to REGISTER.  
        Minimum length = 1 
    .PARAMETER send 
        String to send to the service. Applicable to TCP-ECV, HTTP-ECV, and UDP-ECV monitors. 
    .PARAMETER recv 
        String expected from the server for the service to be marked as UP. Applicable to TCP-ECV, HTTP-ECV, and UDP-ECV monitors. 
    .PARAMETER query 
        Domain name to resolve as part of monitoring the DNS service (for example, example.com). 
    .PARAMETER querytype 
        Type of DNS record for which to send monitoring queries. Set to Address for querying A records, AAAA for querying AAAA records, and Zone for querying the SOA record.  
        Possible values = Address, Zone, AAAA 
    .PARAMETER scriptname 
        Path and name of the script to execute. The script must be available on the Citrix ADC, in the /nsconfig/monitors/ directory.  
        Minimum length = 1 
    .PARAMETER scriptargs 
        String of arguments for the script. The string is copied verbatim into the request. 
    .PARAMETER dispatcherip 
        IP address of the dispatcher to which to send the probe. 
    .PARAMETER dispatcherport 
        Port number on which the dispatcher listens for the monitoring probe. 
    .PARAMETER username 
        User name with which to probe the RADIUS, NNTP, FTP, FTP-EXTENDED, MYSQL, MSSQL, POP3, CITRIX-AG, CITRIX-XD-DDC, CITRIX-WI-EXTENDED, CITRIX-XNC or CITRIX-XDM server.  
        Minimum length = 1 
    .PARAMETER password 
        Password that is required for logging on to the RADIUS, NNTP, FTP, FTP-EXTENDED, MYSQL, MSSQL, POP3, CITRIX-AG, CITRIX-XD-DDC, CITRIX-WI-EXTENDED, CITRIX-XNC-ECV or CITRIX-XDM server. Used in conjunction with the user name specified for the User Name parameter.  
        Minimum length = 1 
    .PARAMETER secondarypassword 
        Secondary password that users might have to provide to log on to the Access Gateway server. Applicable to CITRIX-AG monitors. 
    .PARAMETER logonpointname 
        Name of the logon point that is configured for the Citrix Access Gateway Advanced Access Control software. Required if you want to monitor the associated login page or Logon Agent. Applicable to CITRIX-AAC-LAS and CITRIX-AAC-LOGINPAGE monitors. 
    .PARAMETER lasversion 
        Version number of the Citrix Advanced Access Control Logon Agent. Required by the CITRIX-AAC-LAS monitor. 
    .PARAMETER radkey 
        Authentication key (shared secret text string) for RADIUS clients and servers to exchange. Applicable to monitors of type RADIUS and RADIUS_ACCOUNTING.  
        Minimum length = 1 
    .PARAMETER radnasid 
        NAS-Identifier to send in the Access-Request packet. Applicable to monitors of type RADIUS.  
        Minimum length = 1 
    .PARAMETER radnasip 
        Network Access Server (NAS) IP address to use as the source IP address when monitoring a RADIUS server. Applicable to monitors of type RADIUS and RADIUS_ACCOUNTING. 
    .PARAMETER radaccounttype 
        Account Type to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING.  
        Default value: 1  
        Minimum value = 0  
        Maximum value = 15 
    .PARAMETER radframedip 
        Source ip with which the packet will go out . Applicable to monitors of type RADIUS_ACCOUNTING. 
    .PARAMETER radapn 
        Called Station Id to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING.  
        Minimum length = 1 
    .PARAMETER radmsisdn 
        Calling Stations Id to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING.  
        Minimum length = 1 
    .PARAMETER radaccountsession 
        Account Session ID to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING.  
        Minimum length = 1 
    .PARAMETER lrtm 
        Calculate the least response times for bound services. If this parameter is not enabled, the appliance does not learn the response times of the bound services. Also used for LRTM load balancing.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER deviation 
        Time value added to the learned average response time in dynamic response time monitoring (DRTM). When a deviation is specified, the appliance learns the average response time of bound services and adds the deviation to the average. The final value is then continually adjusted to accommodate response time variations over time. Specified in milliseconds, seconds, or minutes.  
        Minimum value = 0  
        Maximum value = 20939 
    .PARAMETER units1 
        Unit of measurement for the Deviation parameter. Cannot be changed after the monitor is created.  
        Default value: SEC  
        Possible values = SEC, MSEC, MIN 
    .PARAMETER interval 
        Time interval between two successive probes. Must be greater than the value of Response Time-out.  
        Default value: 5  
        Minimum value = 1  
        Maximum value = 20940 
    .PARAMETER units3 
        monitor interval units.  
        Default value: SEC  
        Possible values = SEC, MSEC, MIN 
    .PARAMETER resptimeout 
        Amount of time for which the appliance must wait before it marks a probe as FAILED. Must be less than the value specified for the Interval parameter.  
        Note: For UDP-ECV monitors for which a receive string is not configured, response timeout does not apply. For UDP-ECV monitors with no receive string, probe failure is indicated by an ICMP port unreachable error received from the service.  
        Default value: 2  
        Minimum value = 1  
        Maximum value = 20939 
    .PARAMETER units4 
        monitor response timeout units.  
        Default value: SEC  
        Possible values = SEC, MSEC, MIN 
    .PARAMETER resptimeoutthresh 
        Response time threshold, specified as a percentage of the Response Time-out parameter. If the response to a monitor probe has not arrived when the threshold is reached, the appliance generates an SNMP trap called monRespTimeoutAboveThresh. After the response time returns to a value below the threshold, the appliance generates a monRespTimeoutBelowThresh SNMP trap. For the traps to be generated, the "MONITOR-RTO-THRESHOLD" alarm must also be enabled.  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER retries 
        Maximum number of probes to send to establish the state of a service for which a monitoring probe failed.  
        Default value: 3  
        Minimum value = 1  
        Maximum value = 127 
    .PARAMETER failureretries 
        Number of retries that must fail, out of the number specified for the Retries parameter, for a service to be marked as DOWN. For example, if the Retries parameter is set to 10 and the Failure Retries parameter is set to 6, out of the ten probes sent, at least six probes must fail if the service is to be marked as DOWN. The default value of 0 means that all the retries must fail if the service is to be marked as DOWN.  
        Minimum value = 0  
        Maximum value = 32 
    .PARAMETER alertretries 
        Number of consecutive probe failures after which the appliance generates an SNMP trap called monProbeFailed.  
        Minimum value = 0  
        Maximum value = 32 
    .PARAMETER successretries 
        Number of consecutive successful probes required to transition a service's state from DOWN to UP.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 32 
    .PARAMETER downtime 
        Time duration for which to wait before probing a service that has been marked as DOWN. Expressed in milliseconds, seconds, or minutes.  
        Default value: 30  
        Minimum value = 1  
        Maximum value = 20939 
    .PARAMETER units2 
        Unit of measurement for the Down Time parameter. Cannot be changed after the monitor is created.  
        Default value: SEC  
        Possible values = SEC, MSEC, MIN 
    .PARAMETER destip 
        IP address of the service to which to send probes. If the parameter is set to 0, the IP address of the server to which the monitor is bound is considered the destination IP address. 
    .PARAMETER destport 
        TCP or UDP port to which to send the probe. If the parameter is set to 0, the port number of the service to which the monitor is bound is considered the destination port. For a monitor of type USER, however, the destination port is the port number that is included in the HTTP request sent to the dispatcher. Does not apply to monitors of type PING. 
    .PARAMETER state 
        State of the monitor. The DISABLED setting disables not only the monitor being configured, but all monitors of the same type, until the parameter is set to ENABLED. If the monitor is bound to a service, the state of the monitor is not taken into account when the state of the service is determined.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER reverse 
        Mark a service as DOWN, instead of UP, when probe criteria are satisfied, and as UP instead of DOWN when probe criteria are not satisfied.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER transparent 
        The monitor is bound to a transparent device such as a firewall or router. The state of a transparent device depends on the responsiveness of the services behind it. If a transparent device is being monitored, a destination IP address must be specified. The probe is sent to the specified IP address by using the MAC address of the transparent device.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER iptunnel 
        Send the monitoring probe to the service through an IP tunnel. A destination IP address must be specified.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER tos 
        Probe the service by encoding the destination IP address in the IP TOS (6) bits.  
        Possible values = YES, NO 
    .PARAMETER tosid 
        The TOS ID of the specified destination IP. Applicable only when the TOS parameter is set.  
        Minimum value = 1  
        Maximum value = 63 
    .PARAMETER secure 
        Use a secure SSL connection when monitoring a service. Applicable only to TCP based monitors. The secure option cannot be used with a CITRIX-AG monitor, because a CITRIX-AG monitor uses a secure connection by default.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER validatecred 
        Validate the credentials of the Xen Desktop DDC server user. Applicable to monitors of type CITRIX-XD-DDC.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER domain 
        Domain in which the XenDesktop Desktop Delivery Controller (DDC) servers or Web Interface servers are present. Required by CITRIX-XD-DDC and CITRIX-WI-EXTENDED monitors for logging on to the DDC servers and Web Interface servers, respectively. 
    .PARAMETER ipaddress 
        Set of IP addresses expected in the monitoring response from the DNS server, if the record type is A or AAAA. Applicable to DNS monitors.  
        Minimum length = 1 
    .PARAMETER group 
        Name of a newsgroup available on the NNTP service that is to be monitored. The appliance periodically generates an NNTP query for the name of the newsgroup and evaluates the response. If the newsgroup is found on the server, the service is marked as UP. If the newsgroup does not exist or if the search fails, the service is marked as DOWN. Applicable to NNTP monitors.  
        Minimum length = 1 
    .PARAMETER filename 
        Name of a file on the FTP server. The appliance monitors the FTP service by periodically checking the existence of the file on the server. Applicable to FTP-EXTENDED monitors.  
        Minimum length = 1 
    .PARAMETER basedn 
        The base distinguished name of the LDAP service, from where the LDAP server can begin the search for the attributes in the monitoring query. Required for LDAP service monitoring.  
        Minimum length = 1 
    .PARAMETER binddn 
        The distinguished name with which an LDAP monitor can perform the Bind operation on the LDAP server. Optional. Applicable to LDAP monitors.  
        Minimum length = 1 
    .PARAMETER filter 
        Filter criteria for the LDAP query. Optional.  
        Minimum length = 1 
    .PARAMETER attribute 
        Attribute to evaluate when the LDAP server responds to the query. Success or failure of the monitoring probe depends on whether the attribute exists in the response. Optional.  
        Minimum length = 1 
    .PARAMETER database 
        Name of the database to connect to during authentication.  
        Minimum length = 1 
    .PARAMETER oraclesid 
        Name of the service identifier that is used to connect to the Oracle database during authentication.  
        Minimum length = 1 
    .PARAMETER sqlquery 
        SQL query for a MYSQL-ECV or MSSQL-ECV monitor. Sent to the database server after the server authenticates the connection.  
        Minimum length = 1 
    .PARAMETER evalrule 
        Expression that evaluates the database server's response to a MYSQL-ECV or MSSQL-ECV monitoring query. Must produce a Boolean result. The result determines the state of the server. If the expression returns TRUE, the probe succeeds.  
        For example, if you want the appliance to evaluate the error message to determine the state of the server, use the rule MYSQL.RES.ROW(10) .TEXT_ELEM(2).EQ("MySQL"). 
    .PARAMETER mssqlprotocolversion 
        Version of MSSQL server that is to be monitored.  
        Default value: 70  
        Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
    .PARAMETER Snmpoid 
        SNMP OID for SNMP monitors.  
        Minimum length = 1 
    .PARAMETER snmpcommunity 
        Community name for SNMP monitors.  
        Minimum length = 1 
    .PARAMETER snmpthreshold 
        Threshold for SNMP monitors.  
        Minimum length = 1 
    .PARAMETER snmpversion 
        SNMP version to be used for SNMP monitors.  
        Possible values = V1, V2 
    .PARAMETER metrictable 
        Metric table to which to bind metrics.  
        Minimum length = 1  
        Maximum length = 99 
    .PARAMETER application 
        Name of the application used to determine the state of the service. Applicable to monitors of type CITRIX-XML-SERVICE.  
        Minimum length = 1 
    .PARAMETER sitepath 
        URL of the logon page. For monitors of type CITRIX-WEB-INTERFACE, to monitor a dynamic page under the site path, terminate the site path with a slash (/). Applicable to CITRIX-WEB-INTERFACE, CITRIX-WI-EXTENDED and CITRIX-XDM monitors.  
        Minimum length = 1 
    .PARAMETER storename 
        Store Name. For monitors of type STOREFRONT, STORENAME is an optional argument defining storefront service store name. Applicable to STOREFRONT monitors.  
        Minimum length = 1 
    .PARAMETER storefrontacctservice 
        Enable/Disable probing for Account Service. Applicable only to Store Front monitors. For multi-tenancy configuration users my skip account service.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER hostname 
        Hostname in the FQDN format (Example: porche.cars.org). Applicable to STOREFRONT monitors.  
        Minimum length = 1 
    .PARAMETER netprofile 
        Name of the network profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER originhost 
        Origin-Host value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers.  
        Minimum length = 1 
    .PARAMETER originrealm 
        Origin-Realm value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers.  
        Minimum length = 1 
    .PARAMETER hostipaddress 
        Host-IP-Address value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. If Host-IP-Address is not specified, the appliance inserts the mapped IP (MIP) address or subnet IP (SNIP) address from which the CER request (the monitoring probe) is sent.  
        Minimum length = 1 
    .PARAMETER vendorid 
        Vendor-Id value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER productname 
        Product-Name value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers.  
        Minimum length = 1 
    .PARAMETER firmwarerevision 
        Firmware-Revision value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER authapplicationid 
        List of Auth-Application-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring CER message.  
        Minimum value = 0  
        Maximum value = 4294967295 
    .PARAMETER acctapplicationid 
        List of Acct-Application-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring message.  
        Minimum value = 0  
        Maximum value = 4294967295 
    .PARAMETER inbandsecurityid 
        Inband-Security-Id for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers.  
        Possible values = NO_INBAND_SECURITY, TLS 
    .PARAMETER supportedvendorids 
        List of Supported-Vendor-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum eight of these AVPs are supported in a monitoring message.  
        Minimum value = 1  
        Maximum value = 4294967295 
    .PARAMETER vendorspecificvendorid 
        Vendor-Id to use in the Vendor-Specific-Application-Id grouped attribute-value pair (AVP) in the monitoring CER message. To specify Auth-Application-Id or Acct-Application-Id in Vendor-Specific-Application-Id, use vendorSpecificAuthApplicationIds or vendorSpecificAcctApplicationIds, respectively. Only one Vendor-Id is supported for all the Vendor-Specific-Application-Id AVPs in a CER monitoring message.  
        Minimum value = 1 
    .PARAMETER vendorspecificauthapplicationids 
        List of Vendor-Specific-Auth-Application-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring message. The specified value is combined with the value of vendorSpecificVendorId to obtain the Vendor-Specific-Application-Id AVP in the CER monitoring message.  
        Minimum value = 0  
        Maximum value = 4294967295 
    .PARAMETER vendorspecificacctapplicationids 
        List of Vendor-Specific-Acct-Application-Id attribute value pairs (AVPs) to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring message. The specified value is combined with the value of vendorSpecificVendorId to obtain the Vendor-Specific-Application-Id AVP in the CER monitoring message.  
        Minimum value = 0  
        Maximum value = 4294967295 
    .PARAMETER kcdaccount 
        KCD Account used by MSSQL monitor.  
        Minimum length = 1  
        Maximum length = 32 
    .PARAMETER storedb 
        Store the database list populated with the responses to monitor probes. Used in database specific load balancing if MSSQL-ECV/MYSQL-ECV monitor is configured.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER storefrontcheckbackendservices 
        This option will enable monitoring of services running on storefront server. Storefront services are monitored by probing to a Windows service that runs on the Storefront server and exposes details of which storefront services are running.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER trofscode 
        Code expected when the server is under maintenance. 
    .PARAMETER trofsstring 
        String expected from the server for the service to be marked as trofs. Applicable to HTTP-ECV/TCP-ECV monitors. 
    .PARAMETER sslprofile 
        SSL Profile associated with the monitor.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER PassThru 
        Return details about the created lbmonitor item.
    .EXAMPLE
        Invoke-ADCAddLbmonitor -monitorname <string> -type <string>
    .NOTES
        File Name : Invoke-ADCAddLbmonitor
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor/
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
        [string]$monitorname ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('PING', 'TCP', 'HTTP', 'TCP-ECV', 'HTTP-ECV', 'UDP-ECV', 'DNS', 'FTP', 'LDNS-PING', 'LDNS-TCP', 'LDNS-DNS', 'RADIUS', 'USER', 'HTTP-INLINE', 'SIP-UDP', 'SIP-TCP', 'LOAD', 'FTP-EXTENDED', 'SMTP', 'SNMP', 'NNTP', 'MYSQL', 'MYSQL-ECV', 'MSSQL-ECV', 'ORACLE-ECV', 'LDAP', 'POP3', 'CITRIX-XML-SERVICE', 'CITRIX-WEB-INTERFACE', 'DNS-TCP', 'RTSP', 'ARP', 'CITRIX-AG', 'CITRIX-AAC-LOGINPAGE', 'CITRIX-AAC-LAS', 'CITRIX-XD-DDC', 'ND6', 'CITRIX-WI-EXTENDED', 'DIAMETER', 'RADIUS_ACCOUNTING', 'STOREFRONT', 'APPC', 'SMPP', 'CITRIX-XNC-ECV', 'CITRIX-XDM', 'CITRIX-STA-SERVICE', 'CITRIX-STA-SERVICE-NHOP')]
        [string]$type ,

        [ValidateSet('NONE', 'LOG', 'DOWN')]
        [string]$action = 'DOWN' ,

        [string[]]$respcode ,

        [string]$httprequest ,

        [string]$rtsprequest ,

        [string]$customheaders ,

        [ValidateRange(0, 255)]
        [double]$maxforwards = '1' ,

        [ValidateSet('OPTIONS', 'INVITE', 'REGISTER')]
        [string]$sipmethod ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$sipuri ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$sipreguri ,

        [string]$send ,

        [string]$recv ,

        [string]$query ,

        [ValidateSet('Address', 'Zone', 'AAAA')]
        [string]$querytype ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$scriptname ,

        [string]$scriptargs ,

        [string]$dispatcherip ,

        [int]$dispatcherport ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$username ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password ,

        [string]$secondarypassword ,

        [string]$logonpointname ,

        [string]$lasversion ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$radkey ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$radnasid ,

        [string]$radnasip ,

        [ValidateRange(0, 15)]
        [double]$radaccounttype = '1' ,

        [string]$radframedip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$radapn ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$radmsisdn ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$radaccountsession ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$lrtm ,

        [ValidateRange(0, 20939)]
        [double]$deviation ,

        [ValidateSet('SEC', 'MSEC', 'MIN')]
        [string]$units1 = 'SEC' ,

        [ValidateRange(1, 20940)]
        [int]$interval = '5' ,

        [ValidateSet('SEC', 'MSEC', 'MIN')]
        [string]$units3 = 'SEC' ,

        [ValidateRange(1, 20939)]
        [int]$resptimeout = '2' ,

        [ValidateSet('SEC', 'MSEC', 'MIN')]
        [string]$units4 = 'SEC' ,

        [ValidateRange(0, 100)]
        [double]$resptimeoutthresh ,

        [ValidateRange(1, 127)]
        [int]$retries = '3' ,

        [ValidateRange(0, 32)]
        [int]$failureretries ,

        [ValidateRange(0, 32)]
        [int]$alertretries ,

        [ValidateRange(1, 32)]
        [int]$successretries = '1' ,

        [ValidateRange(1, 20939)]
        [int]$downtime = '30' ,

        [ValidateSet('SEC', 'MSEC', 'MIN')]
        [string]$units2 = 'SEC' ,

        [string]$destip ,

        [int]$destport ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' ,

        [ValidateSet('YES', 'NO')]
        [string]$reverse = 'NO' ,

        [ValidateSet('YES', 'NO')]
        [string]$transparent = 'NO' ,

        [ValidateSet('YES', 'NO')]
        [string]$iptunnel = 'NO' ,

        [ValidateSet('YES', 'NO')]
        [string]$tos ,

        [ValidateRange(1, 63)]
        [double]$tosid ,

        [ValidateSet('YES', 'NO')]
        [string]$secure = 'NO' ,

        [ValidateSet('YES', 'NO')]
        [string]$validatecred = 'NO' ,

        [string]$domain ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$ipaddress ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$group ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$filename ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$basedn ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$binddn ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$filter ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$attribute ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$database ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$oraclesid ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$sqlquery ,

        [string]$evalrule ,

        [ValidateSet('70', '2000', '2000SP1', '2005', '2008', '2008R2', '2012', '2014')]
        [string]$mssqlprotocolversion = '70' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Snmpoid ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$snmpcommunity ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$snmpthreshold ,

        [ValidateSet('V1', 'V2')]
        [string]$snmpversion ,

        [ValidateLength(1, 99)]
        [string]$metrictable ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$application ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$sitepath ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$storename ,

        [ValidateSet('YES', 'NO')]
        [string]$storefrontacctservice = 'YES' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$hostname ,

        [ValidateLength(1, 127)]
        [string]$netprofile ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$originhost ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$originrealm ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$hostipaddress ,

        [double]$vendorid ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$productname ,

        [double]$firmwarerevision ,

        [ValidateRange(0, 4294967295)]
        [double[]]$authapplicationid ,

        [ValidateRange(0, 4294967295)]
        [double[]]$acctapplicationid ,

        [ValidateSet('NO_INBAND_SECURITY', 'TLS')]
        [string]$inbandsecurityid ,

        [ValidateRange(1, 4294967295)]
        [double[]]$supportedvendorids ,

        [double]$vendorspecificvendorid ,

        [ValidateRange(0, 4294967295)]
        [double[]]$vendorspecificauthapplicationids ,

        [ValidateRange(0, 4294967295)]
        [double[]]$vendorspecificacctapplicationids ,

        [ValidateLength(1, 32)]
        [string]$kcdaccount ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$storedb = 'DISABLED' ,

        [ValidateSet('YES', 'NO')]
        [string]$storefrontcheckbackendservices = 'NO' ,

        [double]$trofscode ,

        [string]$trofsstring ,

        [ValidateLength(1, 127)]
        [string]$sslprofile ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbmonitor: Starting"
    }
    process {
        try {
            $Payload = @{
                monitorname = $monitorname
                type = $type
            }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSBoundParameters.ContainsKey('respcode')) { $Payload.Add('respcode', $respcode) }
            if ($PSBoundParameters.ContainsKey('httprequest')) { $Payload.Add('httprequest', $httprequest) }
            if ($PSBoundParameters.ContainsKey('rtsprequest')) { $Payload.Add('rtsprequest', $rtsprequest) }
            if ($PSBoundParameters.ContainsKey('customheaders')) { $Payload.Add('customheaders', $customheaders) }
            if ($PSBoundParameters.ContainsKey('maxforwards')) { $Payload.Add('maxforwards', $maxforwards) }
            if ($PSBoundParameters.ContainsKey('sipmethod')) { $Payload.Add('sipmethod', $sipmethod) }
            if ($PSBoundParameters.ContainsKey('sipuri')) { $Payload.Add('sipuri', $sipuri) }
            if ($PSBoundParameters.ContainsKey('sipreguri')) { $Payload.Add('sipreguri', $sipreguri) }
            if ($PSBoundParameters.ContainsKey('send')) { $Payload.Add('send', $send) }
            if ($PSBoundParameters.ContainsKey('recv')) { $Payload.Add('recv', $recv) }
            if ($PSBoundParameters.ContainsKey('query')) { $Payload.Add('query', $query) }
            if ($PSBoundParameters.ContainsKey('querytype')) { $Payload.Add('querytype', $querytype) }
            if ($PSBoundParameters.ContainsKey('scriptname')) { $Payload.Add('scriptname', $scriptname) }
            if ($PSBoundParameters.ContainsKey('scriptargs')) { $Payload.Add('scriptargs', $scriptargs) }
            if ($PSBoundParameters.ContainsKey('dispatcherip')) { $Payload.Add('dispatcherip', $dispatcherip) }
            if ($PSBoundParameters.ContainsKey('dispatcherport')) { $Payload.Add('dispatcherport', $dispatcherport) }
            if ($PSBoundParameters.ContainsKey('username')) { $Payload.Add('username', $username) }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSBoundParameters.ContainsKey('secondarypassword')) { $Payload.Add('secondarypassword', $secondarypassword) }
            if ($PSBoundParameters.ContainsKey('logonpointname')) { $Payload.Add('logonpointname', $logonpointname) }
            if ($PSBoundParameters.ContainsKey('lasversion')) { $Payload.Add('lasversion', $lasversion) }
            if ($PSBoundParameters.ContainsKey('radkey')) { $Payload.Add('radkey', $radkey) }
            if ($PSBoundParameters.ContainsKey('radnasid')) { $Payload.Add('radnasid', $radnasid) }
            if ($PSBoundParameters.ContainsKey('radnasip')) { $Payload.Add('radnasip', $radnasip) }
            if ($PSBoundParameters.ContainsKey('radaccounttype')) { $Payload.Add('radaccounttype', $radaccounttype) }
            if ($PSBoundParameters.ContainsKey('radframedip')) { $Payload.Add('radframedip', $radframedip) }
            if ($PSBoundParameters.ContainsKey('radapn')) { $Payload.Add('radapn', $radapn) }
            if ($PSBoundParameters.ContainsKey('radmsisdn')) { $Payload.Add('radmsisdn', $radmsisdn) }
            if ($PSBoundParameters.ContainsKey('radaccountsession')) { $Payload.Add('radaccountsession', $radaccountsession) }
            if ($PSBoundParameters.ContainsKey('lrtm')) { $Payload.Add('lrtm', $lrtm) }
            if ($PSBoundParameters.ContainsKey('deviation')) { $Payload.Add('deviation', $deviation) }
            if ($PSBoundParameters.ContainsKey('units1')) { $Payload.Add('units1', $units1) }
            if ($PSBoundParameters.ContainsKey('interval')) { $Payload.Add('interval', $interval) }
            if ($PSBoundParameters.ContainsKey('units3')) { $Payload.Add('units3', $units3) }
            if ($PSBoundParameters.ContainsKey('resptimeout')) { $Payload.Add('resptimeout', $resptimeout) }
            if ($PSBoundParameters.ContainsKey('units4')) { $Payload.Add('units4', $units4) }
            if ($PSBoundParameters.ContainsKey('resptimeoutthresh')) { $Payload.Add('resptimeoutthresh', $resptimeoutthresh) }
            if ($PSBoundParameters.ContainsKey('retries')) { $Payload.Add('retries', $retries) }
            if ($PSBoundParameters.ContainsKey('failureretries')) { $Payload.Add('failureretries', $failureretries) }
            if ($PSBoundParameters.ContainsKey('alertretries')) { $Payload.Add('alertretries', $alertretries) }
            if ($PSBoundParameters.ContainsKey('successretries')) { $Payload.Add('successretries', $successretries) }
            if ($PSBoundParameters.ContainsKey('downtime')) { $Payload.Add('downtime', $downtime) }
            if ($PSBoundParameters.ContainsKey('units2')) { $Payload.Add('units2', $units2) }
            if ($PSBoundParameters.ContainsKey('destip')) { $Payload.Add('destip', $destip) }
            if ($PSBoundParameters.ContainsKey('destport')) { $Payload.Add('destport', $destport) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('reverse')) { $Payload.Add('reverse', $reverse) }
            if ($PSBoundParameters.ContainsKey('transparent')) { $Payload.Add('transparent', $transparent) }
            if ($PSBoundParameters.ContainsKey('iptunnel')) { $Payload.Add('iptunnel', $iptunnel) }
            if ($PSBoundParameters.ContainsKey('tos')) { $Payload.Add('tos', $tos) }
            if ($PSBoundParameters.ContainsKey('tosid')) { $Payload.Add('tosid', $tosid) }
            if ($PSBoundParameters.ContainsKey('secure')) { $Payload.Add('secure', $secure) }
            if ($PSBoundParameters.ContainsKey('validatecred')) { $Payload.Add('validatecred', $validatecred) }
            if ($PSBoundParameters.ContainsKey('domain')) { $Payload.Add('domain', $domain) }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Payload.Add('ipaddress', $ipaddress) }
            if ($PSBoundParameters.ContainsKey('group')) { $Payload.Add('group', $group) }
            if ($PSBoundParameters.ContainsKey('filename')) { $Payload.Add('filename', $filename) }
            if ($PSBoundParameters.ContainsKey('basedn')) { $Payload.Add('basedn', $basedn) }
            if ($PSBoundParameters.ContainsKey('binddn')) { $Payload.Add('binddn', $binddn) }
            if ($PSBoundParameters.ContainsKey('filter')) { $Payload.Add('filter', $filter) }
            if ($PSBoundParameters.ContainsKey('attribute')) { $Payload.Add('attribute', $attribute) }
            if ($PSBoundParameters.ContainsKey('database')) { $Payload.Add('database', $database) }
            if ($PSBoundParameters.ContainsKey('oraclesid')) { $Payload.Add('oraclesid', $oraclesid) }
            if ($PSBoundParameters.ContainsKey('sqlquery')) { $Payload.Add('sqlquery', $sqlquery) }
            if ($PSBoundParameters.ContainsKey('evalrule')) { $Payload.Add('evalrule', $evalrule) }
            if ($PSBoundParameters.ContainsKey('mssqlprotocolversion')) { $Payload.Add('mssqlprotocolversion', $mssqlprotocolversion) }
            if ($PSBoundParameters.ContainsKey('Snmpoid')) { $Payload.Add('Snmpoid', $Snmpoid) }
            if ($PSBoundParameters.ContainsKey('snmpcommunity')) { $Payload.Add('snmpcommunity', $snmpcommunity) }
            if ($PSBoundParameters.ContainsKey('snmpthreshold')) { $Payload.Add('snmpthreshold', $snmpthreshold) }
            if ($PSBoundParameters.ContainsKey('snmpversion')) { $Payload.Add('snmpversion', $snmpversion) }
            if ($PSBoundParameters.ContainsKey('metrictable')) { $Payload.Add('metrictable', $metrictable) }
            if ($PSBoundParameters.ContainsKey('application')) { $Payload.Add('application', $application) }
            if ($PSBoundParameters.ContainsKey('sitepath')) { $Payload.Add('sitepath', $sitepath) }
            if ($PSBoundParameters.ContainsKey('storename')) { $Payload.Add('storename', $storename) }
            if ($PSBoundParameters.ContainsKey('storefrontacctservice')) { $Payload.Add('storefrontacctservice', $storefrontacctservice) }
            if ($PSBoundParameters.ContainsKey('hostname')) { $Payload.Add('hostname', $hostname) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('originhost')) { $Payload.Add('originhost', $originhost) }
            if ($PSBoundParameters.ContainsKey('originrealm')) { $Payload.Add('originrealm', $originrealm) }
            if ($PSBoundParameters.ContainsKey('hostipaddress')) { $Payload.Add('hostipaddress', $hostipaddress) }
            if ($PSBoundParameters.ContainsKey('vendorid')) { $Payload.Add('vendorid', $vendorid) }
            if ($PSBoundParameters.ContainsKey('productname')) { $Payload.Add('productname', $productname) }
            if ($PSBoundParameters.ContainsKey('firmwarerevision')) { $Payload.Add('firmwarerevision', $firmwarerevision) }
            if ($PSBoundParameters.ContainsKey('authapplicationid')) { $Payload.Add('authapplicationid', $authapplicationid) }
            if ($PSBoundParameters.ContainsKey('acctapplicationid')) { $Payload.Add('acctapplicationid', $acctapplicationid) }
            if ($PSBoundParameters.ContainsKey('inbandsecurityid')) { $Payload.Add('inbandsecurityid', $inbandsecurityid) }
            if ($PSBoundParameters.ContainsKey('supportedvendorids')) { $Payload.Add('supportedvendorids', $supportedvendorids) }
            if ($PSBoundParameters.ContainsKey('vendorspecificvendorid')) { $Payload.Add('vendorspecificvendorid', $vendorspecificvendorid) }
            if ($PSBoundParameters.ContainsKey('vendorspecificauthapplicationids')) { $Payload.Add('vendorspecificauthapplicationids', $vendorspecificauthapplicationids) }
            if ($PSBoundParameters.ContainsKey('vendorspecificacctapplicationids')) { $Payload.Add('vendorspecificacctapplicationids', $vendorspecificacctapplicationids) }
            if ($PSBoundParameters.ContainsKey('kcdaccount')) { $Payload.Add('kcdaccount', $kcdaccount) }
            if ($PSBoundParameters.ContainsKey('storedb')) { $Payload.Add('storedb', $storedb) }
            if ($PSBoundParameters.ContainsKey('storefrontcheckbackendservices')) { $Payload.Add('storefrontcheckbackendservices', $storefrontcheckbackendservices) }
            if ($PSBoundParameters.ContainsKey('trofscode')) { $Payload.Add('trofscode', $trofscode) }
            if ($PSBoundParameters.ContainsKey('trofsstring')) { $Payload.Add('trofsstring', $trofsstring) }
            if ($PSBoundParameters.ContainsKey('sslprofile')) { $Payload.Add('sslprofile', $sslprofile) }
 
            if ($PSCmdlet.ShouldProcess("lbmonitor", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbmonitor -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbmonitor -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER monitorname 
       Name for the monitor. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my monitor" or 'my monitor').  
       Minimum length = 1    .PARAMETER type 
       Type of monitor that you want to create.  
       Possible values = PING, TCP, HTTP, TCP-ECV, HTTP-ECV, UDP-ECV, DNS, FTP, LDNS-PING, LDNS-TCP, LDNS-DNS, RADIUS, USER, HTTP-INLINE, SIP-UDP, SIP-TCP, LOAD, FTP-EXTENDED, SMTP, SNMP, NNTP, MYSQL, MYSQL-ECV, MSSQL-ECV, ORACLE-ECV, LDAP, POP3, CITRIX-XML-SERVICE, CITRIX-WEB-INTERFACE, DNS-TCP, RTSP, ARP, CITRIX-AG, CITRIX-AAC-LOGINPAGE, CITRIX-AAC-LAS, CITRIX-XD-DDC, ND6, CITRIX-WI-EXTENDED, DIAMETER, RADIUS_ACCOUNTING, STOREFRONT, APPC, SMPP, CITRIX-XNC-ECV, CITRIX-XDM, CITRIX-STA-SERVICE, CITRIX-STA-SERVICE-NHOP    .PARAMETER respcode 
       Response codes for which to mark the service as UP. For any other response code, the action performed depends on the monitor type. HTTP monitors and RADIUS monitors mark the service as DOWN, while HTTP-INLINE monitors perform the action indicated by the Action parameter.
    .EXAMPLE
        Invoke-ADCDeleteLbmonitor -monitorname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbmonitor
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor/
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
        [string]$monitorname ,

        [string]$type ,

        [string[]]$respcode 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbmonitor: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('respcode')) { $Arguments.Add('respcode', $respcode) }
            if ($PSCmdlet.ShouldProcess("$monitorname", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbmonitor -Resource $monitorname -Arguments $Arguments
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
        Update Load Balancing configuration Object
    .DESCRIPTION
        Update Load Balancing configuration Object 
    .PARAMETER monitorname 
        Name for the monitor. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my monitor" or 'my monitor').  
        Minimum length = 1 
    .PARAMETER type 
        Type of monitor that you want to create.  
        Possible values = PING, TCP, HTTP, TCP-ECV, HTTP-ECV, UDP-ECV, DNS, FTP, LDNS-PING, LDNS-TCP, LDNS-DNS, RADIUS, USER, HTTP-INLINE, SIP-UDP, SIP-TCP, LOAD, FTP-EXTENDED, SMTP, SNMP, NNTP, MYSQL, MYSQL-ECV, MSSQL-ECV, ORACLE-ECV, LDAP, POP3, CITRIX-XML-SERVICE, CITRIX-WEB-INTERFACE, DNS-TCP, RTSP, ARP, CITRIX-AG, CITRIX-AAC-LOGINPAGE, CITRIX-AAC-LAS, CITRIX-XD-DDC, ND6, CITRIX-WI-EXTENDED, DIAMETER, RADIUS_ACCOUNTING, STOREFRONT, APPC, SMPP, CITRIX-XNC-ECV, CITRIX-XDM, CITRIX-STA-SERVICE, CITRIX-STA-SERVICE-NHOP 
    .PARAMETER action 
        Action to perform when the response to an inline monitor (a monitor of type HTTP-INLINE) indicates that the service is down. A service monitored by an inline monitor is considered DOWN if the response code is not one of the codes that have been specified for the Response Code parameter.  
        Available settings function as follows:  
        * NONE - Do not take any action. However, the show service command and the show lb monitor command indicate the total number of responses that were checked and the number of consecutive error responses received after the last successful probe.  
        * LOG - Log the event in NSLOG or SYSLOG.  
        * DOWN - Mark the service as being down, and then do not direct any traffic to the service until the configured down time has expired. Persistent connections to the service are terminated as soon as the service is marked as DOWN. Also, log the event in NSLOG or SYSLOG.  
        Default value: DOWN  
        Possible values = NONE, LOG, DOWN 
    .PARAMETER respcode 
        Response codes for which to mark the service as UP. For any other response code, the action performed depends on the monitor type. HTTP monitors and RADIUS monitors mark the service as DOWN, while HTTP-INLINE monitors perform the action indicated by the Action parameter. 
    .PARAMETER httprequest 
        HTTP request to send to the server (for example, "HEAD /file.html"). 
    .PARAMETER rtsprequest 
        RTSP request to send to the server (for example, "OPTIONS *"). 
    .PARAMETER customheaders 
        Custom header string to include in the monitoring probes. 
    .PARAMETER maxforwards 
        Maximum number of hops that the SIP request used for monitoring can traverse to reach the server. Applicable only to monitors of type SIP-UDP.  
        Default value: 1  
        Minimum value = 0  
        Maximum value = 255 
    .PARAMETER sipmethod 
        SIP method to use for the query. Applicable only to monitors of type SIP-UDP.  
        Possible values = OPTIONS, INVITE, REGISTER 
    .PARAMETER sipreguri 
        SIP user to be registered. Applicable only if the monitor is of type SIP-UDP and the SIP Method parameter is set to REGISTER.  
        Minimum length = 1 
    .PARAMETER sipuri 
        SIP URI string to send to the service (for example, sip:sip.test). Applicable only to monitors of type SIP-UDP.  
        Minimum length = 1 
    .PARAMETER send 
        String to send to the service. Applicable to TCP-ECV, HTTP-ECV, and UDP-ECV monitors. 
    .PARAMETER recv 
        String expected from the server for the service to be marked as UP. Applicable to TCP-ECV, HTTP-ECV, and UDP-ECV monitors. 
    .PARAMETER query 
        Domain name to resolve as part of monitoring the DNS service (for example, example.com). 
    .PARAMETER querytype 
        Type of DNS record for which to send monitoring queries. Set to Address for querying A records, AAAA for querying AAAA records, and Zone for querying the SOA record.  
        Possible values = Address, Zone, AAAA 
    .PARAMETER username 
        User name with which to probe the RADIUS, NNTP, FTP, FTP-EXTENDED, MYSQL, MSSQL, POP3, CITRIX-AG, CITRIX-XD-DDC, CITRIX-WI-EXTENDED, CITRIX-XNC or CITRIX-XDM server.  
        Minimum length = 1 
    .PARAMETER password 
        Password that is required for logging on to the RADIUS, NNTP, FTP, FTP-EXTENDED, MYSQL, MSSQL, POP3, CITRIX-AG, CITRIX-XD-DDC, CITRIX-WI-EXTENDED, CITRIX-XNC-ECV or CITRIX-XDM server. Used in conjunction with the user name specified for the User Name parameter.  
        Minimum length = 1 
    .PARAMETER secondarypassword 
        Secondary password that users might have to provide to log on to the Access Gateway server. Applicable to CITRIX-AG monitors. 
    .PARAMETER logonpointname 
        Name of the logon point that is configured for the Citrix Access Gateway Advanced Access Control software. Required if you want to monitor the associated login page or Logon Agent. Applicable to CITRIX-AAC-LAS and CITRIX-AAC-LOGINPAGE monitors. 
    .PARAMETER lasversion 
        Version number of the Citrix Advanced Access Control Logon Agent. Required by the CITRIX-AAC-LAS monitor. 
    .PARAMETER radkey 
        Authentication key (shared secret text string) for RADIUS clients and servers to exchange. Applicable to monitors of type RADIUS and RADIUS_ACCOUNTING.  
        Minimum length = 1 
    .PARAMETER radnasid 
        NAS-Identifier to send in the Access-Request packet. Applicable to monitors of type RADIUS.  
        Minimum length = 1 
    .PARAMETER radnasip 
        Network Access Server (NAS) IP address to use as the source IP address when monitoring a RADIUS server. Applicable to monitors of type RADIUS and RADIUS_ACCOUNTING. 
    .PARAMETER radaccounttype 
        Account Type to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING.  
        Default value: 1  
        Minimum value = 0  
        Maximum value = 15 
    .PARAMETER radframedip 
        Source ip with which the packet will go out . Applicable to monitors of type RADIUS_ACCOUNTING. 
    .PARAMETER radapn 
        Called Station Id to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING.  
        Minimum length = 1 
    .PARAMETER radmsisdn 
        Calling Stations Id to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING.  
        Minimum length = 1 
    .PARAMETER radaccountsession 
        Account Session ID to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING.  
        Minimum length = 1 
    .PARAMETER lrtm 
        Calculate the least response times for bound services. If this parameter is not enabled, the appliance does not learn the response times of the bound services. Also used for LRTM load balancing.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER deviation 
        Time value added to the learned average response time in dynamic response time monitoring (DRTM). When a deviation is specified, the appliance learns the average response time of bound services and adds the deviation to the average. The final value is then continually adjusted to accommodate response time variations over time. Specified in milliseconds, seconds, or minutes.  
        Minimum value = 0  
        Maximum value = 20939 
    .PARAMETER units1 
        Unit of measurement for the Deviation parameter. Cannot be changed after the monitor is created.  
        Default value: SEC  
        Possible values = SEC, MSEC, MIN 
    .PARAMETER scriptname 
        Path and name of the script to execute. The script must be available on the Citrix ADC, in the /nsconfig/monitors/ directory.  
        Minimum length = 1 
    .PARAMETER scriptargs 
        String of arguments for the script. The string is copied verbatim into the request. 
    .PARAMETER validatecred 
        Validate the credentials of the Xen Desktop DDC server user. Applicable to monitors of type CITRIX-XD-DDC.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER domain 
        Domain in which the XenDesktop Desktop Delivery Controller (DDC) servers or Web Interface servers are present. Required by CITRIX-XD-DDC and CITRIX-WI-EXTENDED monitors for logging on to the DDC servers and Web Interface servers, respectively. 
    .PARAMETER dispatcherip 
        IP address of the dispatcher to which to send the probe. 
    .PARAMETER dispatcherport 
        Port number on which the dispatcher listens for the monitoring probe. 
    .PARAMETER interval 
        Time interval between two successive probes. Must be greater than the value of Response Time-out.  
        Default value: 5  
        Minimum value = 1  
        Maximum value = 20940 
    .PARAMETER units3 
        monitor interval units.  
        Default value: SEC  
        Possible values = SEC, MSEC, MIN 
    .PARAMETER resptimeout 
        Amount of time for which the appliance must wait before it marks a probe as FAILED. Must be less than the value specified for the Interval parameter.  
        Note: For UDP-ECV monitors for which a receive string is not configured, response timeout does not apply. For UDP-ECV monitors with no receive string, probe failure is indicated by an ICMP port unreachable error received from the service.  
        Default value: 2  
        Minimum value = 1  
        Maximum value = 20939 
    .PARAMETER units4 
        monitor response timeout units.  
        Default value: SEC  
        Possible values = SEC, MSEC, MIN 
    .PARAMETER resptimeoutthresh 
        Response time threshold, specified as a percentage of the Response Time-out parameter. If the response to a monitor probe has not arrived when the threshold is reached, the appliance generates an SNMP trap called monRespTimeoutAboveThresh. After the response time returns to a value below the threshold, the appliance generates a monRespTimeoutBelowThresh SNMP trap. For the traps to be generated, the "MONITOR-RTO-THRESHOLD" alarm must also be enabled.  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER retries 
        Maximum number of probes to send to establish the state of a service for which a monitoring probe failed.  
        Default value: 3  
        Minimum value = 1  
        Maximum value = 127 
    .PARAMETER failureretries 
        Number of retries that must fail, out of the number specified for the Retries parameter, for a service to be marked as DOWN. For example, if the Retries parameter is set to 10 and the Failure Retries parameter is set to 6, out of the ten probes sent, at least six probes must fail if the service is to be marked as DOWN. The default value of 0 means that all the retries must fail if the service is to be marked as DOWN.  
        Minimum value = 0  
        Maximum value = 32 
    .PARAMETER alertretries 
        Number of consecutive probe failures after which the appliance generates an SNMP trap called monProbeFailed.  
        Minimum value = 0  
        Maximum value = 32 
    .PARAMETER successretries 
        Number of consecutive successful probes required to transition a service's state from DOWN to UP.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 32 
    .PARAMETER downtime 
        Time duration for which to wait before probing a service that has been marked as DOWN. Expressed in milliseconds, seconds, or minutes.  
        Default value: 30  
        Minimum value = 1  
        Maximum value = 20939 
    .PARAMETER units2 
        Unit of measurement for the Down Time parameter. Cannot be changed after the monitor is created.  
        Default value: SEC  
        Possible values = SEC, MSEC, MIN 
    .PARAMETER destip 
        IP address of the service to which to send probes. If the parameter is set to 0, the IP address of the server to which the monitor is bound is considered the destination IP address. 
    .PARAMETER destport 
        TCP or UDP port to which to send the probe. If the parameter is set to 0, the port number of the service to which the monitor is bound is considered the destination port. For a monitor of type USER, however, the destination port is the port number that is included in the HTTP request sent to the dispatcher. Does not apply to monitors of type PING. 
    .PARAMETER state 
        State of the monitor. The DISABLED setting disables not only the monitor being configured, but all monitors of the same type, until the parameter is set to ENABLED. If the monitor is bound to a service, the state of the monitor is not taken into account when the state of the service is determined.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER reverse 
        Mark a service as DOWN, instead of UP, when probe criteria are satisfied, and as UP instead of DOWN when probe criteria are not satisfied.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER transparent 
        The monitor is bound to a transparent device such as a firewall or router. The state of a transparent device depends on the responsiveness of the services behind it. If a transparent device is being monitored, a destination IP address must be specified. The probe is sent to the specified IP address by using the MAC address of the transparent device.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER iptunnel 
        Send the monitoring probe to the service through an IP tunnel. A destination IP address must be specified.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER tos 
        Probe the service by encoding the destination IP address in the IP TOS (6) bits.  
        Possible values = YES, NO 
    .PARAMETER tosid 
        The TOS ID of the specified destination IP. Applicable only when the TOS parameter is set.  
        Minimum value = 1  
        Maximum value = 63 
    .PARAMETER secure 
        Use a secure SSL connection when monitoring a service. Applicable only to TCP based monitors. The secure option cannot be used with a CITRIX-AG monitor, because a CITRIX-AG monitor uses a secure connection by default.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER ipaddress 
        Set of IP addresses expected in the monitoring response from the DNS server, if the record type is A or AAAA. Applicable to DNS monitors.  
        Minimum length = 1 
    .PARAMETER group 
        Name of a newsgroup available on the NNTP service that is to be monitored. The appliance periodically generates an NNTP query for the name of the newsgroup and evaluates the response. If the newsgroup is found on the server, the service is marked as UP. If the newsgroup does not exist or if the search fails, the service is marked as DOWN. Applicable to NNTP monitors.  
        Minimum length = 1 
    .PARAMETER filename 
        Name of a file on the FTP server. The appliance monitors the FTP service by periodically checking the existence of the file on the server. Applicable to FTP-EXTENDED monitors.  
        Minimum length = 1 
    .PARAMETER basedn 
        The base distinguished name of the LDAP service, from where the LDAP server can begin the search for the attributes in the monitoring query. Required for LDAP service monitoring.  
        Minimum length = 1 
    .PARAMETER binddn 
        The distinguished name with which an LDAP monitor can perform the Bind operation on the LDAP server. Optional. Applicable to LDAP monitors.  
        Minimum length = 1 
    .PARAMETER filter 
        Filter criteria for the LDAP query. Optional.  
        Minimum length = 1 
    .PARAMETER attribute 
        Attribute to evaluate when the LDAP server responds to the query. Success or failure of the monitoring probe depends on whether the attribute exists in the response. Optional.  
        Minimum length = 1 
    .PARAMETER database 
        Name of the database to connect to during authentication.  
        Minimum length = 1 
    .PARAMETER oraclesid 
        Name of the service identifier that is used to connect to the Oracle database during authentication.  
        Minimum length = 1 
    .PARAMETER sqlquery 
        SQL query for a MYSQL-ECV or MSSQL-ECV monitor. Sent to the database server after the server authenticates the connection.  
        Minimum length = 1 
    .PARAMETER evalrule 
        Expression that evaluates the database server's response to a MYSQL-ECV or MSSQL-ECV monitoring query. Must produce a Boolean result. The result determines the state of the server. If the expression returns TRUE, the probe succeeds.  
        For example, if you want the appliance to evaluate the error message to determine the state of the server, use the rule MYSQL.RES.ROW(10) .TEXT_ELEM(2).EQ("MySQL"). 
    .PARAMETER Snmpoid 
        SNMP OID for SNMP monitors.  
        Minimum length = 1 
    .PARAMETER snmpcommunity 
        Community name for SNMP monitors.  
        Minimum length = 1 
    .PARAMETER snmpthreshold 
        Threshold for SNMP monitors.  
        Minimum length = 1 
    .PARAMETER snmpversion 
        SNMP version to be used for SNMP monitors.  
        Possible values = V1, V2 
    .PARAMETER metrictable 
        Metric table to which to bind metrics.  
        Minimum length = 1  
        Maximum length = 99 
    .PARAMETER metric 
        Metric name in the metric table, whose setting is changed. A value zero disables the metric and it will not be used for load calculation.  
        Minimum length = 1  
        Maximum length = 37 
    .PARAMETER metricthreshold 
        Threshold to be used for that metric. 
    .PARAMETER metricweight 
        The weight for the specified service metric with respect to others.  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER application 
        Name of the application used to determine the state of the service. Applicable to monitors of type CITRIX-XML-SERVICE.  
        Minimum length = 1 
    .PARAMETER sitepath 
        URL of the logon page. For monitors of type CITRIX-WEB-INTERFACE, to monitor a dynamic page under the site path, terminate the site path with a slash (/). Applicable to CITRIX-WEB-INTERFACE, CITRIX-WI-EXTENDED and CITRIX-XDM monitors.  
        Minimum length = 1 
    .PARAMETER storename 
        Store Name. For monitors of type STOREFRONT, STORENAME is an optional argument defining storefront service store name. Applicable to STOREFRONT monitors.  
        Minimum length = 1 
    .PARAMETER storefrontacctservice 
        Enable/Disable probing for Account Service. Applicable only to Store Front monitors. For multi-tenancy configuration users my skip account service.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER storefrontcheckbackendservices 
        This option will enable monitoring of services running on storefront server. Storefront services are monitored by probing to a Windows service that runs on the Storefront server and exposes details of which storefront services are running.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER hostname 
        Hostname in the FQDN format (Example: porche.cars.org). Applicable to STOREFRONT monitors.  
        Minimum length = 1 
    .PARAMETER netprofile 
        Name of the network profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER mssqlprotocolversion 
        Version of MSSQL server that is to be monitored.  
        Default value: 70  
        Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
    .PARAMETER originhost 
        Origin-Host value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers.  
        Minimum length = 1 
    .PARAMETER originrealm 
        Origin-Realm value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers.  
        Minimum length = 1 
    .PARAMETER hostipaddress 
        Host-IP-Address value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. If Host-IP-Address is not specified, the appliance inserts the mapped IP (MIP) address or subnet IP (SNIP) address from which the CER request (the monitoring probe) is sent.  
        Minimum length = 1 
    .PARAMETER vendorid 
        Vendor-Id value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER productname 
        Product-Name value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers.  
        Minimum length = 1 
    .PARAMETER firmwarerevision 
        Firmware-Revision value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
    .PARAMETER authapplicationid 
        List of Auth-Application-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring CER message.  
        Minimum value = 0  
        Maximum value = 4294967295 
    .PARAMETER acctapplicationid 
        List of Acct-Application-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring message.  
        Minimum value = 0  
        Maximum value = 4294967295 
    .PARAMETER inbandsecurityid 
        Inband-Security-Id for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers.  
        Possible values = NO_INBAND_SECURITY, TLS 
    .PARAMETER supportedvendorids 
        List of Supported-Vendor-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum eight of these AVPs are supported in a monitoring message.  
        Minimum value = 1  
        Maximum value = 4294967295 
    .PARAMETER vendorspecificvendorid 
        Vendor-Id to use in the Vendor-Specific-Application-Id grouped attribute-value pair (AVP) in the monitoring CER message. To specify Auth-Application-Id or Acct-Application-Id in Vendor-Specific-Application-Id, use vendorSpecificAuthApplicationIds or vendorSpecificAcctApplicationIds, respectively. Only one Vendor-Id is supported for all the Vendor-Specific-Application-Id AVPs in a CER monitoring message.  
        Minimum value = 1 
    .PARAMETER vendorspecificauthapplicationids 
        List of Vendor-Specific-Auth-Application-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring message. The specified value is combined with the value of vendorSpecificVendorId to obtain the Vendor-Specific-Application-Id AVP in the CER monitoring message.  
        Minimum value = 0  
        Maximum value = 4294967295 
    .PARAMETER vendorspecificacctapplicationids 
        List of Vendor-Specific-Acct-Application-Id attribute value pairs (AVPs) to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring message. The specified value is combined with the value of vendorSpecificVendorId to obtain the Vendor-Specific-Application-Id AVP in the CER monitoring message.  
        Minimum value = 0  
        Maximum value = 4294967295 
    .PARAMETER kcdaccount 
        KCD Account used by MSSQL monitor.  
        Minimum length = 1  
        Maximum length = 32 
    .PARAMETER storedb 
        Store the database list populated with the responses to monitor probes. Used in database specific load balancing if MSSQL-ECV/MYSQL-ECV monitor is configured.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER trofscode 
        Code expected when the server is under maintenance. 
    .PARAMETER trofsstring 
        String expected from the server for the service to be marked as trofs. Applicable to HTTP-ECV/TCP-ECV monitors. 
    .PARAMETER sslprofile 
        SSL Profile associated with the monitor.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER PassThru 
        Return details about the created lbmonitor item.
    .EXAMPLE
        Invoke-ADCUpdateLbmonitor -monitorname <string> -type <string>
    .NOTES
        File Name : Invoke-ADCUpdateLbmonitor
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor/
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
        [string]$monitorname ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('PING', 'TCP', 'HTTP', 'TCP-ECV', 'HTTP-ECV', 'UDP-ECV', 'DNS', 'FTP', 'LDNS-PING', 'LDNS-TCP', 'LDNS-DNS', 'RADIUS', 'USER', 'HTTP-INLINE', 'SIP-UDP', 'SIP-TCP', 'LOAD', 'FTP-EXTENDED', 'SMTP', 'SNMP', 'NNTP', 'MYSQL', 'MYSQL-ECV', 'MSSQL-ECV', 'ORACLE-ECV', 'LDAP', 'POP3', 'CITRIX-XML-SERVICE', 'CITRIX-WEB-INTERFACE', 'DNS-TCP', 'RTSP', 'ARP', 'CITRIX-AG', 'CITRIX-AAC-LOGINPAGE', 'CITRIX-AAC-LAS', 'CITRIX-XD-DDC', 'ND6', 'CITRIX-WI-EXTENDED', 'DIAMETER', 'RADIUS_ACCOUNTING', 'STOREFRONT', 'APPC', 'SMPP', 'CITRIX-XNC-ECV', 'CITRIX-XDM', 'CITRIX-STA-SERVICE', 'CITRIX-STA-SERVICE-NHOP')]
        [string]$type ,

        [ValidateSet('NONE', 'LOG', 'DOWN')]
        [string]$action ,

        [string[]]$respcode ,

        [string]$httprequest ,

        [string]$rtsprequest ,

        [string]$customheaders ,

        [ValidateRange(0, 255)]
        [double]$maxforwards ,

        [ValidateSet('OPTIONS', 'INVITE', 'REGISTER')]
        [string]$sipmethod ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$sipreguri ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$sipuri ,

        [string]$send ,

        [string]$recv ,

        [string]$query ,

        [ValidateSet('Address', 'Zone', 'AAAA')]
        [string]$querytype ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$username ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password ,

        [string]$secondarypassword ,

        [string]$logonpointname ,

        [string]$lasversion ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$radkey ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$radnasid ,

        [string]$radnasip ,

        [ValidateRange(0, 15)]
        [double]$radaccounttype ,

        [string]$radframedip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$radapn ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$radmsisdn ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$radaccountsession ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$lrtm ,

        [ValidateRange(0, 20939)]
        [double]$deviation ,

        [ValidateSet('SEC', 'MSEC', 'MIN')]
        [string]$units1 ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$scriptname ,

        [string]$scriptargs ,

        [ValidateSet('YES', 'NO')]
        [string]$validatecred ,

        [string]$domain ,

        [string]$dispatcherip ,

        [int]$dispatcherport ,

        [ValidateRange(1, 20940)]
        [int]$interval ,

        [ValidateSet('SEC', 'MSEC', 'MIN')]
        [string]$units3 ,

        [ValidateRange(1, 20939)]
        [int]$resptimeout ,

        [ValidateSet('SEC', 'MSEC', 'MIN')]
        [string]$units4 ,

        [ValidateRange(0, 100)]
        [double]$resptimeoutthresh ,

        [ValidateRange(1, 127)]
        [int]$retries ,

        [ValidateRange(0, 32)]
        [int]$failureretries ,

        [ValidateRange(0, 32)]
        [int]$alertretries ,

        [ValidateRange(1, 32)]
        [int]$successretries ,

        [ValidateRange(1, 20939)]
        [int]$downtime ,

        [ValidateSet('SEC', 'MSEC', 'MIN')]
        [string]$units2 ,

        [string]$destip ,

        [int]$destport ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [ValidateSet('YES', 'NO')]
        [string]$reverse ,

        [ValidateSet('YES', 'NO')]
        [string]$transparent ,

        [ValidateSet('YES', 'NO')]
        [string]$iptunnel ,

        [ValidateSet('YES', 'NO')]
        [string]$tos ,

        [ValidateRange(1, 63)]
        [double]$tosid ,

        [ValidateSet('YES', 'NO')]
        [string]$secure ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$ipaddress ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$group ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$filename ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$basedn ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$binddn ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$filter ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$attribute ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$database ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$oraclesid ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$sqlquery ,

        [string]$evalrule ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Snmpoid ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$snmpcommunity ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$snmpthreshold ,

        [ValidateSet('V1', 'V2')]
        [string]$snmpversion ,

        [ValidateLength(1, 99)]
        [string]$metrictable ,

        [ValidateLength(1, 37)]
        [string]$metric ,

        [double]$metricthreshold ,

        [ValidateRange(1, 100)]
        [double]$metricweight ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$application ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$sitepath ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$storename ,

        [ValidateSet('YES', 'NO')]
        [string]$storefrontacctservice ,

        [ValidateSet('YES', 'NO')]
        [string]$storefrontcheckbackendservices ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$hostname ,

        [ValidateLength(1, 127)]
        [string]$netprofile ,

        [ValidateSet('70', '2000', '2000SP1', '2005', '2008', '2008R2', '2012', '2014')]
        [string]$mssqlprotocolversion ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$originhost ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$originrealm ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$hostipaddress ,

        [double]$vendorid ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$productname ,

        [double]$firmwarerevision ,

        [ValidateRange(0, 4294967295)]
        [double[]]$authapplicationid ,

        [ValidateRange(0, 4294967295)]
        [double[]]$acctapplicationid ,

        [ValidateSet('NO_INBAND_SECURITY', 'TLS')]
        [string]$inbandsecurityid ,

        [ValidateRange(1, 4294967295)]
        [double[]]$supportedvendorids ,

        [double]$vendorspecificvendorid ,

        [ValidateRange(0, 4294967295)]
        [double[]]$vendorspecificauthapplicationids ,

        [ValidateRange(0, 4294967295)]
        [double[]]$vendorspecificacctapplicationids ,

        [ValidateLength(1, 32)]
        [string]$kcdaccount ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$storedb ,

        [double]$trofscode ,

        [string]$trofsstring ,

        [ValidateLength(1, 127)]
        [string]$sslprofile ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLbmonitor: Starting"
    }
    process {
        try {
            $Payload = @{
                monitorname = $monitorname
                type = $type
            }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSBoundParameters.ContainsKey('respcode')) { $Payload.Add('respcode', $respcode) }
            if ($PSBoundParameters.ContainsKey('httprequest')) { $Payload.Add('httprequest', $httprequest) }
            if ($PSBoundParameters.ContainsKey('rtsprequest')) { $Payload.Add('rtsprequest', $rtsprequest) }
            if ($PSBoundParameters.ContainsKey('customheaders')) { $Payload.Add('customheaders', $customheaders) }
            if ($PSBoundParameters.ContainsKey('maxforwards')) { $Payload.Add('maxforwards', $maxforwards) }
            if ($PSBoundParameters.ContainsKey('sipmethod')) { $Payload.Add('sipmethod', $sipmethod) }
            if ($PSBoundParameters.ContainsKey('sipreguri')) { $Payload.Add('sipreguri', $sipreguri) }
            if ($PSBoundParameters.ContainsKey('sipuri')) { $Payload.Add('sipuri', $sipuri) }
            if ($PSBoundParameters.ContainsKey('send')) { $Payload.Add('send', $send) }
            if ($PSBoundParameters.ContainsKey('recv')) { $Payload.Add('recv', $recv) }
            if ($PSBoundParameters.ContainsKey('query')) { $Payload.Add('query', $query) }
            if ($PSBoundParameters.ContainsKey('querytype')) { $Payload.Add('querytype', $querytype) }
            if ($PSBoundParameters.ContainsKey('username')) { $Payload.Add('username', $username) }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSBoundParameters.ContainsKey('secondarypassword')) { $Payload.Add('secondarypassword', $secondarypassword) }
            if ($PSBoundParameters.ContainsKey('logonpointname')) { $Payload.Add('logonpointname', $logonpointname) }
            if ($PSBoundParameters.ContainsKey('lasversion')) { $Payload.Add('lasversion', $lasversion) }
            if ($PSBoundParameters.ContainsKey('radkey')) { $Payload.Add('radkey', $radkey) }
            if ($PSBoundParameters.ContainsKey('radnasid')) { $Payload.Add('radnasid', $radnasid) }
            if ($PSBoundParameters.ContainsKey('radnasip')) { $Payload.Add('radnasip', $radnasip) }
            if ($PSBoundParameters.ContainsKey('radaccounttype')) { $Payload.Add('radaccounttype', $radaccounttype) }
            if ($PSBoundParameters.ContainsKey('radframedip')) { $Payload.Add('radframedip', $radframedip) }
            if ($PSBoundParameters.ContainsKey('radapn')) { $Payload.Add('radapn', $radapn) }
            if ($PSBoundParameters.ContainsKey('radmsisdn')) { $Payload.Add('radmsisdn', $radmsisdn) }
            if ($PSBoundParameters.ContainsKey('radaccountsession')) { $Payload.Add('radaccountsession', $radaccountsession) }
            if ($PSBoundParameters.ContainsKey('lrtm')) { $Payload.Add('lrtm', $lrtm) }
            if ($PSBoundParameters.ContainsKey('deviation')) { $Payload.Add('deviation', $deviation) }
            if ($PSBoundParameters.ContainsKey('units1')) { $Payload.Add('units1', $units1) }
            if ($PSBoundParameters.ContainsKey('scriptname')) { $Payload.Add('scriptname', $scriptname) }
            if ($PSBoundParameters.ContainsKey('scriptargs')) { $Payload.Add('scriptargs', $scriptargs) }
            if ($PSBoundParameters.ContainsKey('validatecred')) { $Payload.Add('validatecred', $validatecred) }
            if ($PSBoundParameters.ContainsKey('domain')) { $Payload.Add('domain', $domain) }
            if ($PSBoundParameters.ContainsKey('dispatcherip')) { $Payload.Add('dispatcherip', $dispatcherip) }
            if ($PSBoundParameters.ContainsKey('dispatcherport')) { $Payload.Add('dispatcherport', $dispatcherport) }
            if ($PSBoundParameters.ContainsKey('interval')) { $Payload.Add('interval', $interval) }
            if ($PSBoundParameters.ContainsKey('units3')) { $Payload.Add('units3', $units3) }
            if ($PSBoundParameters.ContainsKey('resptimeout')) { $Payload.Add('resptimeout', $resptimeout) }
            if ($PSBoundParameters.ContainsKey('units4')) { $Payload.Add('units4', $units4) }
            if ($PSBoundParameters.ContainsKey('resptimeoutthresh')) { $Payload.Add('resptimeoutthresh', $resptimeoutthresh) }
            if ($PSBoundParameters.ContainsKey('retries')) { $Payload.Add('retries', $retries) }
            if ($PSBoundParameters.ContainsKey('failureretries')) { $Payload.Add('failureretries', $failureretries) }
            if ($PSBoundParameters.ContainsKey('alertretries')) { $Payload.Add('alertretries', $alertretries) }
            if ($PSBoundParameters.ContainsKey('successretries')) { $Payload.Add('successretries', $successretries) }
            if ($PSBoundParameters.ContainsKey('downtime')) { $Payload.Add('downtime', $downtime) }
            if ($PSBoundParameters.ContainsKey('units2')) { $Payload.Add('units2', $units2) }
            if ($PSBoundParameters.ContainsKey('destip')) { $Payload.Add('destip', $destip) }
            if ($PSBoundParameters.ContainsKey('destport')) { $Payload.Add('destport', $destport) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('reverse')) { $Payload.Add('reverse', $reverse) }
            if ($PSBoundParameters.ContainsKey('transparent')) { $Payload.Add('transparent', $transparent) }
            if ($PSBoundParameters.ContainsKey('iptunnel')) { $Payload.Add('iptunnel', $iptunnel) }
            if ($PSBoundParameters.ContainsKey('tos')) { $Payload.Add('tos', $tos) }
            if ($PSBoundParameters.ContainsKey('tosid')) { $Payload.Add('tosid', $tosid) }
            if ($PSBoundParameters.ContainsKey('secure')) { $Payload.Add('secure', $secure) }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Payload.Add('ipaddress', $ipaddress) }
            if ($PSBoundParameters.ContainsKey('group')) { $Payload.Add('group', $group) }
            if ($PSBoundParameters.ContainsKey('filename')) { $Payload.Add('filename', $filename) }
            if ($PSBoundParameters.ContainsKey('basedn')) { $Payload.Add('basedn', $basedn) }
            if ($PSBoundParameters.ContainsKey('binddn')) { $Payload.Add('binddn', $binddn) }
            if ($PSBoundParameters.ContainsKey('filter')) { $Payload.Add('filter', $filter) }
            if ($PSBoundParameters.ContainsKey('attribute')) { $Payload.Add('attribute', $attribute) }
            if ($PSBoundParameters.ContainsKey('database')) { $Payload.Add('database', $database) }
            if ($PSBoundParameters.ContainsKey('oraclesid')) { $Payload.Add('oraclesid', $oraclesid) }
            if ($PSBoundParameters.ContainsKey('sqlquery')) { $Payload.Add('sqlquery', $sqlquery) }
            if ($PSBoundParameters.ContainsKey('evalrule')) { $Payload.Add('evalrule', $evalrule) }
            if ($PSBoundParameters.ContainsKey('Snmpoid')) { $Payload.Add('Snmpoid', $Snmpoid) }
            if ($PSBoundParameters.ContainsKey('snmpcommunity')) { $Payload.Add('snmpcommunity', $snmpcommunity) }
            if ($PSBoundParameters.ContainsKey('snmpthreshold')) { $Payload.Add('snmpthreshold', $snmpthreshold) }
            if ($PSBoundParameters.ContainsKey('snmpversion')) { $Payload.Add('snmpversion', $snmpversion) }
            if ($PSBoundParameters.ContainsKey('metrictable')) { $Payload.Add('metrictable', $metrictable) }
            if ($PSBoundParameters.ContainsKey('metric')) { $Payload.Add('metric', $metric) }
            if ($PSBoundParameters.ContainsKey('metricthreshold')) { $Payload.Add('metricthreshold', $metricthreshold) }
            if ($PSBoundParameters.ContainsKey('metricweight')) { $Payload.Add('metricweight', $metricweight) }
            if ($PSBoundParameters.ContainsKey('application')) { $Payload.Add('application', $application) }
            if ($PSBoundParameters.ContainsKey('sitepath')) { $Payload.Add('sitepath', $sitepath) }
            if ($PSBoundParameters.ContainsKey('storename')) { $Payload.Add('storename', $storename) }
            if ($PSBoundParameters.ContainsKey('storefrontacctservice')) { $Payload.Add('storefrontacctservice', $storefrontacctservice) }
            if ($PSBoundParameters.ContainsKey('storefrontcheckbackendservices')) { $Payload.Add('storefrontcheckbackendservices', $storefrontcheckbackendservices) }
            if ($PSBoundParameters.ContainsKey('hostname')) { $Payload.Add('hostname', $hostname) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('mssqlprotocolversion')) { $Payload.Add('mssqlprotocolversion', $mssqlprotocolversion) }
            if ($PSBoundParameters.ContainsKey('originhost')) { $Payload.Add('originhost', $originhost) }
            if ($PSBoundParameters.ContainsKey('originrealm')) { $Payload.Add('originrealm', $originrealm) }
            if ($PSBoundParameters.ContainsKey('hostipaddress')) { $Payload.Add('hostipaddress', $hostipaddress) }
            if ($PSBoundParameters.ContainsKey('vendorid')) { $Payload.Add('vendorid', $vendorid) }
            if ($PSBoundParameters.ContainsKey('productname')) { $Payload.Add('productname', $productname) }
            if ($PSBoundParameters.ContainsKey('firmwarerevision')) { $Payload.Add('firmwarerevision', $firmwarerevision) }
            if ($PSBoundParameters.ContainsKey('authapplicationid')) { $Payload.Add('authapplicationid', $authapplicationid) }
            if ($PSBoundParameters.ContainsKey('acctapplicationid')) { $Payload.Add('acctapplicationid', $acctapplicationid) }
            if ($PSBoundParameters.ContainsKey('inbandsecurityid')) { $Payload.Add('inbandsecurityid', $inbandsecurityid) }
            if ($PSBoundParameters.ContainsKey('supportedvendorids')) { $Payload.Add('supportedvendorids', $supportedvendorids) }
            if ($PSBoundParameters.ContainsKey('vendorspecificvendorid')) { $Payload.Add('vendorspecificvendorid', $vendorspecificvendorid) }
            if ($PSBoundParameters.ContainsKey('vendorspecificauthapplicationids')) { $Payload.Add('vendorspecificauthapplicationids', $vendorspecificauthapplicationids) }
            if ($PSBoundParameters.ContainsKey('vendorspecificacctapplicationids')) { $Payload.Add('vendorspecificacctapplicationids', $vendorspecificacctapplicationids) }
            if ($PSBoundParameters.ContainsKey('kcdaccount')) { $Payload.Add('kcdaccount', $kcdaccount) }
            if ($PSBoundParameters.ContainsKey('storedb')) { $Payload.Add('storedb', $storedb) }
            if ($PSBoundParameters.ContainsKey('trofscode')) { $Payload.Add('trofscode', $trofscode) }
            if ($PSBoundParameters.ContainsKey('trofsstring')) { $Payload.Add('trofsstring', $trofsstring) }
            if ($PSBoundParameters.ContainsKey('sslprofile')) { $Payload.Add('sslprofile', $sslprofile) }
 
            if ($PSCmdlet.ShouldProcess("lbmonitor", "Update Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbmonitor -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbmonitor -Filter $Payload)
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
        Unset Load Balancing configuration Object
    .DESCRIPTION
        Unset Load Balancing configuration Object 
   .PARAMETER monitorname 
       Name for the monitor. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my monitor" or 'my monitor'). 
   .PARAMETER type 
       Type of monitor that you want to create.  
       Possible values = PING, TCP, HTTP, TCP-ECV, HTTP-ECV, UDP-ECV, DNS, FTP, LDNS-PING, LDNS-TCP, LDNS-DNS, RADIUS, USER, HTTP-INLINE, SIP-UDP, SIP-TCP, LOAD, FTP-EXTENDED, SMTP, SNMP, NNTP, MYSQL, MYSQL-ECV, MSSQL-ECV, ORACLE-ECV, LDAP, POP3, CITRIX-XML-SERVICE, CITRIX-WEB-INTERFACE, DNS-TCP, RTSP, ARP, CITRIX-AG, CITRIX-AAC-LOGINPAGE, CITRIX-AAC-LAS, CITRIX-XD-DDC, ND6, CITRIX-WI-EXTENDED, DIAMETER, RADIUS_ACCOUNTING, STOREFRONT, APPC, SMPP, CITRIX-XNC-ECV, CITRIX-XDM, CITRIX-STA-SERVICE, CITRIX-STA-SERVICE-NHOP 
   .PARAMETER ipaddress 
       Set of IP addresses expected in the monitoring response from the DNS server, if the record type is A or AAAA. Applicable to DNS monitors. 
   .PARAMETER scriptname 
       Path and name of the script to execute. The script must be available on the Citrix ADC, in the /nsconfig/monitors/ directory. 
   .PARAMETER destport 
       TCP or UDP port to which to send the probe. If the parameter is set to 0, the port number of the service to which the monitor is bound is considered the destination port. For a monitor of type USER, however, the destination port is the port number that is included in the HTTP request sent to the dispatcher. Does not apply to monitors of type PING. 
   .PARAMETER netprofile 
       Name of the network profile. 
   .PARAMETER sslprofile 
       SSL Profile associated with the monitor. 
   .PARAMETER action 
       Action to perform when the response to an inline monitor (a monitor of type HTTP-INLINE) indicates that the service is down. A service monitored by an inline monitor is considered DOWN if the response code is not one of the codes that have been specified for the Response Code parameter.  
       Available settings function as follows:  
       * NONE - Do not take any action. However, the show service command and the show lb monitor command indicate the total number of responses that were checked and the number of consecutive error responses received after the last successful probe.  
       * LOG - Log the event in NSLOG or SYSLOG.  
       * DOWN - Mark the service as being down, and then do not direct any traffic to the service until the configured down time has expired. Persistent connections to the service are terminated as soon as the service is marked as DOWN. Also, log the event in NSLOG or SYSLOG.  
       Possible values = NONE, LOG, DOWN 
   .PARAMETER respcode 
       Response codes for which to mark the service as UP. For any other response code, the action performed depends on the monitor type. HTTP monitors and RADIUS monitors mark the service as DOWN, while HTTP-INLINE monitors perform the action indicated by the Action parameter. 
   .PARAMETER httprequest 
       HTTP request to send to the server (for example, "HEAD /file.html"). 
   .PARAMETER rtsprequest 
       RTSP request to send to the server (for example, "OPTIONS *"). 
   .PARAMETER customheaders 
       Custom header string to include in the monitoring probes. 
   .PARAMETER maxforwards 
       Maximum number of hops that the SIP request used for monitoring can traverse to reach the server. Applicable only to monitors of type SIP-UDP. 
   .PARAMETER sipmethod 
       SIP method to use for the query. Applicable only to monitors of type SIP-UDP.  
       Possible values = OPTIONS, INVITE, REGISTER 
   .PARAMETER sipreguri 
       SIP user to be registered. Applicable only if the monitor is of type SIP-UDP and the SIP Method parameter is set to REGISTER. 
   .PARAMETER send 
       String to send to the service. Applicable to TCP-ECV, HTTP-ECV, and UDP-ECV monitors. 
   .PARAMETER recv 
       String expected from the server for the service to be marked as UP. Applicable to TCP-ECV, HTTP-ECV, and UDP-ECV monitors. 
   .PARAMETER query 
       Domain name to resolve as part of monitoring the DNS service (for example, example.com). 
   .PARAMETER querytype 
       Type of DNS record for which to send monitoring queries. Set to Address for querying A records, AAAA for querying AAAA records, and Zone for querying the SOA record.  
       Possible values = Address, Zone, AAAA 
   .PARAMETER username 
       User name with which to probe the RADIUS, NNTP, FTP, FTP-EXTENDED, MYSQL, MSSQL, POP3, CITRIX-AG, CITRIX-XD-DDC, CITRIX-WI-EXTENDED, CITRIX-XNC or CITRIX-XDM server. 
   .PARAMETER password 
       Password that is required for logging on to the RADIUS, NNTP, FTP, FTP-EXTENDED, MYSQL, MSSQL, POP3, CITRIX-AG, CITRIX-XD-DDC, CITRIX-WI-EXTENDED, CITRIX-XNC-ECV or CITRIX-XDM server. Used in conjunction with the user name specified for the User Name parameter. 
   .PARAMETER secondarypassword 
       Secondary password that users might have to provide to log on to the Access Gateway server. Applicable to CITRIX-AG monitors. 
   .PARAMETER logonpointname 
       Name of the logon point that is configured for the Citrix Access Gateway Advanced Access Control software. Required if you want to monitor the associated login page or Logon Agent. Applicable to CITRIX-AAC-LAS and CITRIX-AAC-LOGINPAGE monitors. 
   .PARAMETER lasversion 
       Version number of the Citrix Advanced Access Control Logon Agent. Required by the CITRIX-AAC-LAS monitor. 
   .PARAMETER radkey 
       Authentication key (shared secret text string) for RADIUS clients and servers to exchange. Applicable to monitors of type RADIUS and RADIUS_ACCOUNTING. 
   .PARAMETER radnasid 
       NAS-Identifier to send in the Access-Request packet. Applicable to monitors of type RADIUS. 
   .PARAMETER radnasip 
       Network Access Server (NAS) IP address to use as the source IP address when monitoring a RADIUS server. Applicable to monitors of type RADIUS and RADIUS_ACCOUNTING. 
   .PARAMETER radaccounttype 
       Account Type to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING. 
   .PARAMETER radframedip 
       Source ip with which the packet will go out . Applicable to monitors of type RADIUS_ACCOUNTING. 
   .PARAMETER radapn 
       Called Station Id to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING. 
   .PARAMETER radmsisdn 
       Calling Stations Id to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING. 
   .PARAMETER radaccountsession 
       Account Session ID to be used in Account Request Packet. Applicable to monitors of type RADIUS_ACCOUNTING. 
   .PARAMETER lrtm 
       Calculate the least response times for bound services. If this parameter is not enabled, the appliance does not learn the response times of the bound services. Also used for LRTM load balancing.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER deviation 
       Time value added to the learned average response time in dynamic response time monitoring (DRTM). When a deviation is specified, the appliance learns the average response time of bound services and adds the deviation to the average. The final value is then continually adjusted to accommodate response time variations over time. Specified in milliseconds, seconds, or minutes. 
   .PARAMETER scriptargs 
       String of arguments for the script. The string is copied verbatim into the request. 
   .PARAMETER validatecred 
       Validate the credentials of the Xen Desktop DDC server user. Applicable to monitors of type CITRIX-XD-DDC.  
       Possible values = YES, NO 
   .PARAMETER domain 
       Domain in which the XenDesktop Desktop Delivery Controller (DDC) servers or Web Interface servers are present. Required by CITRIX-XD-DDC and CITRIX-WI-EXTENDED monitors for logging on to the DDC servers and Web Interface servers, respectively. 
   .PARAMETER dispatcherip 
       IP address of the dispatcher to which to send the probe. 
   .PARAMETER dispatcherport 
       Port number on which the dispatcher listens for the monitoring probe. 
   .PARAMETER interval 
       Time interval between two successive probes. Must be greater than the value of Response Time-out. 
   .PARAMETER resptimeout 
       Amount of time for which the appliance must wait before it marks a probe as FAILED. Must be less than the value specified for the Interval parameter.  
       Note: For UDP-ECV monitors for which a receive string is not configured, response timeout does not apply. For UDP-ECV monitors with no receive string, probe failure is indicated by an ICMP port unreachable error received from the service. 
   .PARAMETER resptimeoutthresh 
       Response time threshold, specified as a percentage of the Response Time-out parameter. If the response to a monitor probe has not arrived when the threshold is reached, the appliance generates an SNMP trap called monRespTimeoutAboveThresh. After the response time returns to a value below the threshold, the appliance generates a monRespTimeoutBelowThresh SNMP trap. For the traps to be generated, the "MONITOR-RTO-THRESHOLD" alarm must also be enabled. 
   .PARAMETER retries 
       Maximum number of probes to send to establish the state of a service for which a monitoring probe failed. 
   .PARAMETER failureretries 
       Number of retries that must fail, out of the number specified for the Retries parameter, for a service to be marked as DOWN. For example, if the Retries parameter is set to 10 and the Failure Retries parameter is set to 6, out of the ten probes sent, at least six probes must fail if the service is to be marked as DOWN. The default value of 0 means that all the retries must fail if the service is to be marked as DOWN. 
   .PARAMETER alertretries 
       Number of consecutive probe failures after which the appliance generates an SNMP trap called monProbeFailed. 
   .PARAMETER successretries 
       Number of consecutive successful probes required to transition a service's state from DOWN to UP. 
   .PARAMETER downtime 
       Time duration for which to wait before probing a service that has been marked as DOWN. Expressed in milliseconds, seconds, or minutes. 
   .PARAMETER destip 
       IP address of the service to which to send probes. If the parameter is set to 0, the IP address of the server to which the monitor is bound is considered the destination IP address. 
   .PARAMETER state 
       State of the monitor. The DISABLED setting disables not only the monitor being configured, but all monitors of the same type, until the parameter is set to ENABLED. If the monitor is bound to a service, the state of the monitor is not taken into account when the state of the service is determined.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER reverse 
       Mark a service as DOWN, instead of UP, when probe criteria are satisfied, and as UP instead of DOWN when probe criteria are not satisfied.  
       Possible values = YES, NO 
   .PARAMETER transparent 
       The monitor is bound to a transparent device such as a firewall or router. The state of a transparent device depends on the responsiveness of the services behind it. If a transparent device is being monitored, a destination IP address must be specified. The probe is sent to the specified IP address by using the MAC address of the transparent device.  
       Possible values = YES, NO 
   .PARAMETER iptunnel 
       Send the monitoring probe to the service through an IP tunnel. A destination IP address must be specified.  
       Possible values = YES, NO 
   .PARAMETER tos 
       Probe the service by encoding the destination IP address in the IP TOS (6) bits.  
       Possible values = YES, NO 
   .PARAMETER tosid 
       The TOS ID of the specified destination IP. Applicable only when the TOS parameter is set. 
   .PARAMETER secure 
       Use a secure SSL connection when monitoring a service. Applicable only to TCP based monitors. The secure option cannot be used with a CITRIX-AG monitor, because a CITRIX-AG monitor uses a secure connection by default.  
       Possible values = YES, NO 
   .PARAMETER group 
       Name of a newsgroup available on the NNTP service that is to be monitored. The appliance periodically generates an NNTP query for the name of the newsgroup and evaluates the response. If the newsgroup is found on the server, the service is marked as UP. If the newsgroup does not exist or if the search fails, the service is marked as DOWN. Applicable to NNTP monitors. 
   .PARAMETER filename 
       Name of a file on the FTP server. The appliance monitors the FTP service by periodically checking the existence of the file on the server. Applicable to FTP-EXTENDED monitors. 
   .PARAMETER basedn 
       The base distinguished name of the LDAP service, from where the LDAP server can begin the search for the attributes in the monitoring query. Required for LDAP service monitoring. 
   .PARAMETER binddn 
       The distinguished name with which an LDAP monitor can perform the Bind operation on the LDAP server. Optional. Applicable to LDAP monitors. 
   .PARAMETER filter 
       Filter criteria for the LDAP query. Optional. 
   .PARAMETER attribute 
       Attribute to evaluate when the LDAP server responds to the query. Success or failure of the monitoring probe depends on whether the attribute exists in the response. Optional. 
   .PARAMETER database 
       Name of the database to connect to during authentication. 
   .PARAMETER oraclesid 
       Name of the service identifier that is used to connect to the Oracle database during authentication. 
   .PARAMETER sqlquery 
       SQL query for a MYSQL-ECV or MSSQL-ECV monitor. Sent to the database server after the server authenticates the connection. 
   .PARAMETER Snmpoid 
       SNMP OID for SNMP monitors. 
   .PARAMETER snmpcommunity 
       Community name for SNMP monitors. 
   .PARAMETER snmpthreshold 
       Threshold for SNMP monitors. 
   .PARAMETER snmpversion 
       SNMP version to be used for SNMP monitors.  
       Possible values = V1, V2 
   .PARAMETER metrictable 
       Metric table to which to bind metrics. 
   .PARAMETER mssqlprotocolversion 
       Version of MSSQL server that is to be monitored.  
       Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
   .PARAMETER originhost 
       Origin-Host value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
   .PARAMETER originrealm 
       Origin-Realm value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
   .PARAMETER hostipaddress 
       Host-IP-Address value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. If Host-IP-Address is not specified, the appliance inserts the mapped IP (MIP) address or subnet IP (SNIP) address from which the CER request (the monitoring probe) is sent. 
   .PARAMETER vendorid 
       Vendor-Id value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
   .PARAMETER productname 
       Product-Name value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
   .PARAMETER firmwarerevision 
       Firmware-Revision value for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. 
   .PARAMETER authapplicationid 
       List of Auth-Application-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring CER message. 
   .PARAMETER acctapplicationid 
       List of Acct-Application-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring message. 
   .PARAMETER inbandsecurityid 
       Inband-Security-Id for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers.  
       Possible values = NO_INBAND_SECURITY, TLS 
   .PARAMETER supportedvendorids 
       List of Supported-Vendor-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum eight of these AVPs are supported in a monitoring message. 
   .PARAMETER vendorspecificvendorid 
       Vendor-Id to use in the Vendor-Specific-Application-Id grouped attribute-value pair (AVP) in the monitoring CER message. To specify Auth-Application-Id or Acct-Application-Id in Vendor-Specific-Application-Id, use vendorSpecificAuthApplicationIds or vendorSpecificAcctApplicationIds, respectively. Only one Vendor-Id is supported for all the Vendor-Specific-Application-Id AVPs in a CER monitoring message. 
   .PARAMETER vendorspecificauthapplicationids 
       List of Vendor-Specific-Auth-Application-Id attribute value pairs (AVPs) for the Capabilities-Exchange-Request (CER) message to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring message. The specified value is combined with the value of vendorSpecificVendorId to obtain the Vendor-Specific-Application-Id AVP in the CER monitoring message. 
   .PARAMETER vendorspecificacctapplicationids 
       List of Vendor-Specific-Acct-Application-Id attribute value pairs (AVPs) to use for monitoring Diameter servers. A maximum of eight of these AVPs are supported in a monitoring message. The specified value is combined with the value of vendorSpecificVendorId to obtain the Vendor-Specific-Application-Id AVP in the CER monitoring message. 
   .PARAMETER kcdaccount 
       KCD Account used by MSSQL monitor. 
   .PARAMETER storedb 
       Store the database list populated with the responses to monitor probes. Used in database specific load balancing if MSSQL-ECV/MYSQL-ECV monitor is configured.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER trofscode 
       Code expected when the server is under maintenance. 
   .PARAMETER trofsstring 
       String expected from the server for the service to be marked as trofs. Applicable to HTTP-ECV/TCP-ECV monitors.
    .EXAMPLE
        Invoke-ADCUnsetLbmonitor -monitorname <string> -type <string>
    .NOTES
        File Name : Invoke-ADCUnsetLbmonitor
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor
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
        [string]$monitorname ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('PING', 'TCP', 'HTTP', 'TCP-ECV', 'HTTP-ECV', 'UDP-ECV', 'DNS', 'FTP', 'LDNS-PING', 'LDNS-TCP', 'LDNS-DNS', 'RADIUS', 'USER', 'HTTP-INLINE', 'SIP-UDP', 'SIP-TCP', 'LOAD', 'FTP-EXTENDED', 'SMTP', 'SNMP', 'NNTP', 'MYSQL', 'MYSQL-ECV', 'MSSQL-ECV', 'ORACLE-ECV', 'LDAP', 'POP3', 'CITRIX-XML-SERVICE', 'CITRIX-WEB-INTERFACE', 'DNS-TCP', 'RTSP', 'ARP', 'CITRIX-AG', 'CITRIX-AAC-LOGINPAGE', 'CITRIX-AAC-LAS', 'CITRIX-XD-DDC', 'ND6', 'CITRIX-WI-EXTENDED', 'DIAMETER', 'RADIUS_ACCOUNTING', 'STOREFRONT', 'APPC', 'SMPP', 'CITRIX-XNC-ECV', 'CITRIX-XDM', 'CITRIX-STA-SERVICE', 'CITRIX-STA-SERVICE-NHOP')]
        [string]$type ,

        [Boolean]$ipaddress ,

        [Boolean]$scriptname ,

        [Boolean]$destport ,

        [Boolean]$netprofile ,

        [Boolean]$sslprofile ,

        [Boolean]$action ,

        [Boolean]$respcode ,

        [Boolean]$httprequest ,

        [Boolean]$rtsprequest ,

        [Boolean]$customheaders ,

        [Boolean]$maxforwards ,

        [Boolean]$sipmethod ,

        [Boolean]$sipreguri ,

        [Boolean]$send ,

        [Boolean]$recv ,

        [Boolean]$query ,

        [Boolean]$querytype ,

        [Boolean]$username ,

        [Boolean]$password ,

        [Boolean]$secondarypassword ,

        [Boolean]$logonpointname ,

        [Boolean]$lasversion ,

        [Boolean]$radkey ,

        [Boolean]$radnasid ,

        [Boolean]$radnasip ,

        [Boolean]$radaccounttype ,

        [Boolean]$radframedip ,

        [Boolean]$radapn ,

        [Boolean]$radmsisdn ,

        [Boolean]$radaccountsession ,

        [Boolean]$lrtm ,

        [Boolean]$deviation ,

        [Boolean]$scriptargs ,

        [Boolean]$validatecred ,

        [Boolean]$domain ,

        [Boolean]$dispatcherip ,

        [Boolean]$dispatcherport ,

        [Boolean]$interval ,

        [Boolean]$resptimeout ,

        [Boolean]$resptimeoutthresh ,

        [Boolean]$retries ,

        [Boolean]$failureretries ,

        [Boolean]$alertretries ,

        [Boolean]$successretries ,

        [Boolean]$downtime ,

        [Boolean]$destip ,

        [Boolean]$state ,

        [Boolean]$reverse ,

        [Boolean]$transparent ,

        [Boolean]$iptunnel ,

        [Boolean]$tos ,

        [Boolean]$tosid ,

        [Boolean]$secure ,

        [Boolean]$group ,

        [Boolean]$filename ,

        [Boolean]$basedn ,

        [Boolean]$binddn ,

        [Boolean]$filter ,

        [Boolean]$attribute ,

        [Boolean]$database ,

        [Boolean]$oraclesid ,

        [Boolean]$sqlquery ,

        [Boolean]$Snmpoid ,

        [Boolean]$snmpcommunity ,

        [Boolean]$snmpthreshold ,

        [Boolean]$snmpversion ,

        [Boolean]$metrictable ,

        [Boolean]$mssqlprotocolversion ,

        [Boolean]$originhost ,

        [Boolean]$originrealm ,

        [Boolean]$hostipaddress ,

        [Boolean]$vendorid ,

        [Boolean]$productname ,

        [Boolean]$firmwarerevision ,

        [Boolean]$authapplicationid ,

        [Boolean]$acctapplicationid ,

        [Boolean]$inbandsecurityid ,

        [Boolean]$supportedvendorids ,

        [Boolean]$vendorspecificvendorid ,

        [Boolean]$vendorspecificauthapplicationids ,

        [Boolean]$vendorspecificacctapplicationids ,

        [Boolean]$kcdaccount ,

        [Boolean]$storedb ,

        [Boolean]$trofscode ,

        [Boolean]$trofsstring 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLbmonitor: Starting"
    }
    process {
        try {
            $Payload = @{
                monitorname = $monitorname
                type = $type
            }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Payload.Add('ipaddress', $ipaddress) }
            if ($PSBoundParameters.ContainsKey('scriptname')) { $Payload.Add('scriptname', $scriptname) }
            if ($PSBoundParameters.ContainsKey('destport')) { $Payload.Add('destport', $destport) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('sslprofile')) { $Payload.Add('sslprofile', $sslprofile) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSBoundParameters.ContainsKey('respcode')) { $Payload.Add('respcode', $respcode) }
            if ($PSBoundParameters.ContainsKey('httprequest')) { $Payload.Add('httprequest', $httprequest) }
            if ($PSBoundParameters.ContainsKey('rtsprequest')) { $Payload.Add('rtsprequest', $rtsprequest) }
            if ($PSBoundParameters.ContainsKey('customheaders')) { $Payload.Add('customheaders', $customheaders) }
            if ($PSBoundParameters.ContainsKey('maxforwards')) { $Payload.Add('maxforwards', $maxforwards) }
            if ($PSBoundParameters.ContainsKey('sipmethod')) { $Payload.Add('sipmethod', $sipmethod) }
            if ($PSBoundParameters.ContainsKey('sipreguri')) { $Payload.Add('sipreguri', $sipreguri) }
            if ($PSBoundParameters.ContainsKey('send')) { $Payload.Add('send', $send) }
            if ($PSBoundParameters.ContainsKey('recv')) { $Payload.Add('recv', $recv) }
            if ($PSBoundParameters.ContainsKey('query')) { $Payload.Add('query', $query) }
            if ($PSBoundParameters.ContainsKey('querytype')) { $Payload.Add('querytype', $querytype) }
            if ($PSBoundParameters.ContainsKey('username')) { $Payload.Add('username', $username) }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSBoundParameters.ContainsKey('secondarypassword')) { $Payload.Add('secondarypassword', $secondarypassword) }
            if ($PSBoundParameters.ContainsKey('logonpointname')) { $Payload.Add('logonpointname', $logonpointname) }
            if ($PSBoundParameters.ContainsKey('lasversion')) { $Payload.Add('lasversion', $lasversion) }
            if ($PSBoundParameters.ContainsKey('radkey')) { $Payload.Add('radkey', $radkey) }
            if ($PSBoundParameters.ContainsKey('radnasid')) { $Payload.Add('radnasid', $radnasid) }
            if ($PSBoundParameters.ContainsKey('radnasip')) { $Payload.Add('radnasip', $radnasip) }
            if ($PSBoundParameters.ContainsKey('radaccounttype')) { $Payload.Add('radaccounttype', $radaccounttype) }
            if ($PSBoundParameters.ContainsKey('radframedip')) { $Payload.Add('radframedip', $radframedip) }
            if ($PSBoundParameters.ContainsKey('radapn')) { $Payload.Add('radapn', $radapn) }
            if ($PSBoundParameters.ContainsKey('radmsisdn')) { $Payload.Add('radmsisdn', $radmsisdn) }
            if ($PSBoundParameters.ContainsKey('radaccountsession')) { $Payload.Add('radaccountsession', $radaccountsession) }
            if ($PSBoundParameters.ContainsKey('lrtm')) { $Payload.Add('lrtm', $lrtm) }
            if ($PSBoundParameters.ContainsKey('deviation')) { $Payload.Add('deviation', $deviation) }
            if ($PSBoundParameters.ContainsKey('scriptargs')) { $Payload.Add('scriptargs', $scriptargs) }
            if ($PSBoundParameters.ContainsKey('validatecred')) { $Payload.Add('validatecred', $validatecred) }
            if ($PSBoundParameters.ContainsKey('domain')) { $Payload.Add('domain', $domain) }
            if ($PSBoundParameters.ContainsKey('dispatcherip')) { $Payload.Add('dispatcherip', $dispatcherip) }
            if ($PSBoundParameters.ContainsKey('dispatcherport')) { $Payload.Add('dispatcherport', $dispatcherport) }
            if ($PSBoundParameters.ContainsKey('interval')) { $Payload.Add('interval', $interval) }
            if ($PSBoundParameters.ContainsKey('resptimeout')) { $Payload.Add('resptimeout', $resptimeout) }
            if ($PSBoundParameters.ContainsKey('resptimeoutthresh')) { $Payload.Add('resptimeoutthresh', $resptimeoutthresh) }
            if ($PSBoundParameters.ContainsKey('retries')) { $Payload.Add('retries', $retries) }
            if ($PSBoundParameters.ContainsKey('failureretries')) { $Payload.Add('failureretries', $failureretries) }
            if ($PSBoundParameters.ContainsKey('alertretries')) { $Payload.Add('alertretries', $alertretries) }
            if ($PSBoundParameters.ContainsKey('successretries')) { $Payload.Add('successretries', $successretries) }
            if ($PSBoundParameters.ContainsKey('downtime')) { $Payload.Add('downtime', $downtime) }
            if ($PSBoundParameters.ContainsKey('destip')) { $Payload.Add('destip', $destip) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('reverse')) { $Payload.Add('reverse', $reverse) }
            if ($PSBoundParameters.ContainsKey('transparent')) { $Payload.Add('transparent', $transparent) }
            if ($PSBoundParameters.ContainsKey('iptunnel')) { $Payload.Add('iptunnel', $iptunnel) }
            if ($PSBoundParameters.ContainsKey('tos')) { $Payload.Add('tos', $tos) }
            if ($PSBoundParameters.ContainsKey('tosid')) { $Payload.Add('tosid', $tosid) }
            if ($PSBoundParameters.ContainsKey('secure')) { $Payload.Add('secure', $secure) }
            if ($PSBoundParameters.ContainsKey('group')) { $Payload.Add('group', $group) }
            if ($PSBoundParameters.ContainsKey('filename')) { $Payload.Add('filename', $filename) }
            if ($PSBoundParameters.ContainsKey('basedn')) { $Payload.Add('basedn', $basedn) }
            if ($PSBoundParameters.ContainsKey('binddn')) { $Payload.Add('binddn', $binddn) }
            if ($PSBoundParameters.ContainsKey('filter')) { $Payload.Add('filter', $filter) }
            if ($PSBoundParameters.ContainsKey('attribute')) { $Payload.Add('attribute', $attribute) }
            if ($PSBoundParameters.ContainsKey('database')) { $Payload.Add('database', $database) }
            if ($PSBoundParameters.ContainsKey('oraclesid')) { $Payload.Add('oraclesid', $oraclesid) }
            if ($PSBoundParameters.ContainsKey('sqlquery')) { $Payload.Add('sqlquery', $sqlquery) }
            if ($PSBoundParameters.ContainsKey('Snmpoid')) { $Payload.Add('Snmpoid', $Snmpoid) }
            if ($PSBoundParameters.ContainsKey('snmpcommunity')) { $Payload.Add('snmpcommunity', $snmpcommunity) }
            if ($PSBoundParameters.ContainsKey('snmpthreshold')) { $Payload.Add('snmpthreshold', $snmpthreshold) }
            if ($PSBoundParameters.ContainsKey('snmpversion')) { $Payload.Add('snmpversion', $snmpversion) }
            if ($PSBoundParameters.ContainsKey('metrictable')) { $Payload.Add('metrictable', $metrictable) }
            if ($PSBoundParameters.ContainsKey('mssqlprotocolversion')) { $Payload.Add('mssqlprotocolversion', $mssqlprotocolversion) }
            if ($PSBoundParameters.ContainsKey('originhost')) { $Payload.Add('originhost', $originhost) }
            if ($PSBoundParameters.ContainsKey('originrealm')) { $Payload.Add('originrealm', $originrealm) }
            if ($PSBoundParameters.ContainsKey('hostipaddress')) { $Payload.Add('hostipaddress', $hostipaddress) }
            if ($PSBoundParameters.ContainsKey('vendorid')) { $Payload.Add('vendorid', $vendorid) }
            if ($PSBoundParameters.ContainsKey('productname')) { $Payload.Add('productname', $productname) }
            if ($PSBoundParameters.ContainsKey('firmwarerevision')) { $Payload.Add('firmwarerevision', $firmwarerevision) }
            if ($PSBoundParameters.ContainsKey('authapplicationid')) { $Payload.Add('authapplicationid', $authapplicationid) }
            if ($PSBoundParameters.ContainsKey('acctapplicationid')) { $Payload.Add('acctapplicationid', $acctapplicationid) }
            if ($PSBoundParameters.ContainsKey('inbandsecurityid')) { $Payload.Add('inbandsecurityid', $inbandsecurityid) }
            if ($PSBoundParameters.ContainsKey('supportedvendorids')) { $Payload.Add('supportedvendorids', $supportedvendorids) }
            if ($PSBoundParameters.ContainsKey('vendorspecificvendorid')) { $Payload.Add('vendorspecificvendorid', $vendorspecificvendorid) }
            if ($PSBoundParameters.ContainsKey('vendorspecificauthapplicationids')) { $Payload.Add('vendorspecificauthapplicationids', $vendorspecificauthapplicationids) }
            if ($PSBoundParameters.ContainsKey('vendorspecificacctapplicationids')) { $Payload.Add('vendorspecificacctapplicationids', $vendorspecificacctapplicationids) }
            if ($PSBoundParameters.ContainsKey('kcdaccount')) { $Payload.Add('kcdaccount', $kcdaccount) }
            if ($PSBoundParameters.ContainsKey('storedb')) { $Payload.Add('storedb', $storedb) }
            if ($PSBoundParameters.ContainsKey('trofscode')) { $Payload.Add('trofscode', $trofscode) }
            if ($PSBoundParameters.ContainsKey('trofsstring')) { $Payload.Add('trofsstring', $trofsstring) }
            if ($PSCmdlet.ShouldProcess("$monitorname type", "Unset Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbmonitor -Action unset -Payload $Payload -GetWarning
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
        Enable Load Balancing configuration Object
    .DESCRIPTION
        Enable Load Balancing configuration Object 
    .PARAMETER servicename 
        The name of the service to which the monitor is bound. 
    .PARAMETER servicegroupname 
        The name of the service group to which the monitor is to be bound. 
    .PARAMETER monitorname 
        Name for the monitor. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my monitor" or 'my monitor').
    .EXAMPLE
        Invoke-ADCEnableLbmonitor 
    .NOTES
        File Name : Invoke-ADCEnableLbmonitor
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor/
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
        [string]$servicename ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servicegroupname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$monitorname 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableLbmonitor: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('servicename')) { $Payload.Add('servicename', $servicename) }
            if ($PSBoundParameters.ContainsKey('servicegroupname')) { $Payload.Add('servicegroupname', $servicegroupname) }
            if ($PSBoundParameters.ContainsKey('monitorname')) { $Payload.Add('monitorname', $monitorname) }
            if ($PSCmdlet.ShouldProcess($Name, "Enable Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbmonitor -Action enable -Payload $Payload -GetWarning
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
        Disable Load Balancing configuration Object
    .DESCRIPTION
        Disable Load Balancing configuration Object 
    .PARAMETER servicename 
        The name of the service to which the monitor is bound. 
    .PARAMETER servicegroupname 
        The name of the service group to which the monitor is to be bound. 
    .PARAMETER monitorname 
        Name for the monitor. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my monitor" or 'my monitor').
    .EXAMPLE
        Invoke-ADCDisableLbmonitor 
    .NOTES
        File Name : Invoke-ADCDisableLbmonitor
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor/
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
        [string]$servicename ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servicegroupname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$monitorname 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableLbmonitor: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('servicename')) { $Payload.Add('servicename', $servicename) }
            if ($PSBoundParameters.ContainsKey('servicegroupname')) { $Payload.Add('servicegroupname', $servicegroupname) }
            if ($PSBoundParameters.ContainsKey('monitorname')) { $Payload.Add('monitorname', $monitorname) }
            if ($PSCmdlet.ShouldProcess($Name, "Disable Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbmonitor -Action disable -Payload $Payload -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER monitorname 
       Name for the monitor. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my monitor" or 'my monitor'). 
    .PARAMETER GetAll 
        Retreive all lbmonitor object(s)
    .PARAMETER Count
        If specified, the count of the lbmonitor object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbmonitor
    .EXAMPLE 
        Invoke-ADCGetLbmonitor -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbmonitor -Count
    .EXAMPLE
        Invoke-ADCGetLbmonitor -name <string>
    .EXAMPLE
        Invoke-ADCGetLbmonitor -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbmonitor
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor/
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
        [string]$monitorname,

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
        Write-Verbose "Invoke-ADCGetLbmonitor: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lbmonitor objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmonitor objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmonitor objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmonitor configuration for property 'monitorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor -Resource $monitorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmonitor configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER monitorname 
       Name of the monitor. 
    .PARAMETER GetAll 
        Retreive all lbmonitor_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbmonitor_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbmonitorbinding
    .EXAMPLE 
        Invoke-ADCGetLbmonitorbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetLbmonitorbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbmonitorbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbmonitorbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_binding/
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
        [string]$monitorname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbmonitorbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmonitor_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmonitor_binding configuration for property 'monitorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_binding -Resource $monitorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmonitor_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER monitorname 
        Name of the monitor.  
        Minimum length = 1 
    .PARAMETER metric 
        Metric name in the metric table, whose setting is changed. A value zero disables the metric and it will not be used for load calculation.  
        Minimum length = 1  
        Maximum length = 37 
    .PARAMETER metricthreshold 
        Threshold to be used for that metric. 
    .PARAMETER metricweight 
        The weight for the specified service metric with respect to others.  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER PassThru 
        Return details about the created lbmonitor_metric_binding item.
    .EXAMPLE
        Invoke-ADCAddLbmonitormetricbinding -monitorname <string>
    .NOTES
        File Name : Invoke-ADCAddLbmonitormetricbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_metric_binding/
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
        [string]$monitorname ,

        [ValidateLength(1, 37)]
        [string]$metric ,

        [double]$metricthreshold ,

        [ValidateRange(1, 100)]
        [double]$metricweight ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbmonitormetricbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                monitorname = $monitorname
            }
            if ($PSBoundParameters.ContainsKey('metric')) { $Payload.Add('metric', $metric) }
            if ($PSBoundParameters.ContainsKey('metricthreshold')) { $Payload.Add('metricthreshold', $metricthreshold) }
            if ($PSBoundParameters.ContainsKey('metricweight')) { $Payload.Add('metricweight', $metricweight) }
 
            if ($PSCmdlet.ShouldProcess("lbmonitor_metric_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbmonitor_metric_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbmonitormetricbinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER monitorname 
       Name of the monitor.  
       Minimum length = 1    .PARAMETER metric 
       Metric name in the metric table, whose setting is changed. A value zero disables the metric and it will not be used for load calculation.  
       Minimum length = 1  
       Maximum length = 37
    .EXAMPLE
        Invoke-ADCDeleteLbmonitormetricbinding -monitorname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbmonitormetricbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_metric_binding/
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
        [string]$monitorname ,

        [string]$metric 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbmonitormetricbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('metric')) { $Arguments.Add('metric', $metric) }
            if ($PSCmdlet.ShouldProcess("$monitorname", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbmonitor_metric_binding -Resource $monitorname -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER monitorname 
       Name of the monitor. 
    .PARAMETER GetAll 
        Retreive all lbmonitor_metric_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbmonitor_metric_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbmonitormetricbinding
    .EXAMPLE 
        Invoke-ADCGetLbmonitormetricbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbmonitormetricbinding -Count
    .EXAMPLE
        Invoke-ADCGetLbmonitormetricbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbmonitormetricbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbmonitormetricbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_metric_binding/
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
        [string]$monitorname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbmonitor_metric_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_metric_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmonitor_metric_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_metric_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmonitor_metric_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_metric_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmonitor_metric_binding configuration for property 'monitorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_metric_binding -Resource $monitorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmonitor_metric_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_metric_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER monitorname 
        Name of the monitor.  
        Minimum length = 1 
    .PARAMETER servicename 
        Name of the service or service group.  
        Minimum length = 1 
    .PARAMETER dup_state 
        State of the monitor. The state setting for a monitor of a given type affects all monitors of that type. For example, if an HTTP monitor is enabled, all HTTP monitors on the appliance are (or remain) enabled. If an HTTP monitor is disabled, all HTTP monitors on the appliance are disabled.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dup_weight 
        Weight to assign to the binding between the monitor and service.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER servicegroupname 
        Name of the service group.  
        Minimum length = 1 
    .PARAMETER state 
        State of the monitor. The state setting for a monitor of a given type affects all monitors of that type. For example, if an HTTP monitor is enabled, all HTTP monitors on the appliance are (or remain) enabled. If an HTTP monitor is disabled, all HTTP monitors on the appliance are disabled.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER weight 
        Weight to assign to the binding between the monitor and service.  
        Minimum value = 1  
        Maximum value = 100
    .EXAMPLE
        Invoke-ADCAddLbmonitorservicegroupbinding -monitorname <string>
    .NOTES
        File Name : Invoke-ADCAddLbmonitorservicegroupbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_servicegroup_binding/
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
        [string]$monitorname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servicename ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dup_state = 'ENABLED' ,

        [ValidateRange(1, 100)]
        [double]$dup_weight = '1' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servicegroupname ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' ,

        [ValidateRange(1, 100)]
        [double]$weight 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbmonitorservicegroupbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                monitorname = $monitorname
            }
            if ($PSBoundParameters.ContainsKey('servicename')) { $Payload.Add('servicename', $servicename) }
            if ($PSBoundParameters.ContainsKey('dup_state')) { $Payload.Add('dup_state', $dup_state) }
            if ($PSBoundParameters.ContainsKey('dup_weight')) { $Payload.Add('dup_weight', $dup_weight) }
            if ($PSBoundParameters.ContainsKey('servicegroupname')) { $Payload.Add('servicegroupname', $servicegroupname) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
 
            if ($PSCmdlet.ShouldProcess("lbmonitor_servicegroup_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbmonitor_servicegroup_binding -Payload $Payload -GetWarning
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER monitorname 
       Name of the monitor.  
       Minimum length = 1    .PARAMETER servicename 
       Name of the service or service group.  
       Minimum length = 1    .PARAMETER servicegroupname 
       Name of the service group.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteLbmonitorservicegroupbinding -monitorname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbmonitorservicegroupbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_servicegroup_binding/
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
        [string]$monitorname ,

        [string]$servicename ,

        [string]$servicegroupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbmonitorservicegroupbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('servicename')) { $Arguments.Add('servicename', $servicename) }
            if ($PSBoundParameters.ContainsKey('servicegroupname')) { $Arguments.Add('servicegroupname', $servicegroupname) }
            if ($PSCmdlet.ShouldProcess("$monitorname", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbmonitor_servicegroup_binding -Resource $monitorname -Arguments $Arguments
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER monitorname 
        Name of the monitor.  
        Minimum length = 1 
    .PARAMETER servicename 
        Name of the service or service group.  
        Minimum length = 1 
    .PARAMETER dup_state 
        State of the monitor. The state setting for a monitor of a given type affects all monitors of that type. For example, if an HTTP monitor is enabled, all HTTP monitors on the appliance are (or remain) enabled. If an HTTP monitor is disabled, all HTTP monitors on the appliance are disabled.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dup_weight 
        Weight to assign to the binding between the monitor and service.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER servicegroupname 
        Name of the service group.  
        Minimum length = 1 
    .PARAMETER state 
        State of the monitor. The state setting for a monitor of a given type affects all monitors of that type. For example, if an HTTP monitor is enabled, all HTTP monitors on the appliance are (or remain) enabled. If an HTTP monitor is disabled, all HTTP monitors on the appliance are disabled.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER weight 
        Weight to assign to the binding between the monitor and service.  
        Minimum value = 1  
        Maximum value = 100
    .EXAMPLE
        Invoke-ADCAddLbmonitorservicebinding -monitorname <string>
    .NOTES
        File Name : Invoke-ADCAddLbmonitorservicebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_service_binding/
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
        [string]$monitorname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servicename ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dup_state = 'ENABLED' ,

        [ValidateRange(1, 100)]
        [double]$dup_weight = '1' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servicegroupname ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' ,

        [ValidateRange(1, 100)]
        [double]$weight 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbmonitorservicebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                monitorname = $monitorname
            }
            if ($PSBoundParameters.ContainsKey('servicename')) { $Payload.Add('servicename', $servicename) }
            if ($PSBoundParameters.ContainsKey('dup_state')) { $Payload.Add('dup_state', $dup_state) }
            if ($PSBoundParameters.ContainsKey('dup_weight')) { $Payload.Add('dup_weight', $dup_weight) }
            if ($PSBoundParameters.ContainsKey('servicegroupname')) { $Payload.Add('servicegroupname', $servicegroupname) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
 
            if ($PSCmdlet.ShouldProcess("lbmonitor_service_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbmonitor_service_binding -Payload $Payload -GetWarning
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER monitorname 
       Name of the monitor.  
       Minimum length = 1    .PARAMETER servicename 
       Name of the service or service group.  
       Minimum length = 1    .PARAMETER servicegroupname 
       Name of the service group.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteLbmonitorservicebinding -monitorname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbmonitorservicebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_service_binding/
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
        [string]$monitorname ,

        [string]$servicename ,

        [string]$servicegroupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbmonitorservicebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('servicename')) { $Arguments.Add('servicename', $servicename) }
            if ($PSBoundParameters.ContainsKey('servicegroupname')) { $Arguments.Add('servicegroupname', $servicegroupname) }
            if ($PSCmdlet.ShouldProcess("$monitorname", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbmonitor_service_binding -Resource $monitorname -Arguments $Arguments
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER monitorname 
        Name of the monitor.  
        Minimum length = 1 
    .PARAMETER certkeyname 
        The name of the certificate bound to the monitor. 
    .PARAMETER ca 
        The rule for use of CRL corresponding to this CA certificate during client authentication. If crlCheck is set to Mandatory, the system will deny all SSL clients if the CRL is missing, expired - NextUpdate date is in the past, or is incomplete with remote CRL refresh enabled. If crlCheck is set to optional, the system will allow SSL clients in the above error cases.However, in any case if the client certificate is revoked in the CRL, the SSL client will be denied access. 
    .PARAMETER crlcheck 
        The state of the CRL check parameter. (Mandatory/Optional).  
        Possible values = Mandatory, Optional 
    .PARAMETER ocspcheck 
        The state of the OCSP check parameter. (Mandatory/Optional).  
        Possible values = Mandatory, Optional 
    .PARAMETER PassThru 
        Return details about the created lbmonitor_sslcertkey_binding item.
    .EXAMPLE
        Invoke-ADCAddLbmonitorsslcertkeybinding -monitorname <string>
    .NOTES
        File Name : Invoke-ADCAddLbmonitorsslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_sslcertkey_binding/
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
        [string]$monitorname ,

        [string]$certkeyname ,

        [boolean]$ca ,

        [ValidateSet('Mandatory', 'Optional')]
        [string]$crlcheck ,

        [ValidateSet('Mandatory', 'Optional')]
        [string]$ocspcheck ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbmonitorsslcertkeybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                monitorname = $monitorname
            }
            if ($PSBoundParameters.ContainsKey('certkeyname')) { $Payload.Add('certkeyname', $certkeyname) }
            if ($PSBoundParameters.ContainsKey('ca')) { $Payload.Add('ca', $ca) }
            if ($PSBoundParameters.ContainsKey('crlcheck')) { $Payload.Add('crlcheck', $crlcheck) }
            if ($PSBoundParameters.ContainsKey('ocspcheck')) { $Payload.Add('ocspcheck', $ocspcheck) }
 
            if ($PSCmdlet.ShouldProcess("lbmonitor_sslcertkey_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbmonitor_sslcertkey_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbmonitorsslcertkeybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER monitorname 
       Name of the monitor.  
       Minimum length = 1    .PARAMETER certkeyname 
       The name of the certificate bound to the monitor.    .PARAMETER ca 
       The rule for use of CRL corresponding to this CA certificate during client authentication. If crlCheck is set to Mandatory, the system will deny all SSL clients if the CRL is missing, expired - NextUpdate date is in the past, or is incomplete with remote CRL refresh enabled. If crlCheck is set to optional, the system will allow SSL clients in the above error cases.However, in any case if the client certificate is revoked in the CRL, the SSL client will be denied access.
    .EXAMPLE
        Invoke-ADCDeleteLbmonitorsslcertkeybinding -monitorname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbmonitorsslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_sslcertkey_binding/
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
        [string]$monitorname ,

        [string]$certkeyname ,

        [boolean]$ca 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbmonitorsslcertkeybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('certkeyname')) { $Arguments.Add('certkeyname', $certkeyname) }
            if ($PSBoundParameters.ContainsKey('ca')) { $Arguments.Add('ca', $ca) }
            if ($PSCmdlet.ShouldProcess("$monitorname", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbmonitor_sslcertkey_binding -Resource $monitorname -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER monitorname 
       Name of the monitor. 
    .PARAMETER GetAll 
        Retreive all lbmonitor_sslcertkey_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbmonitor_sslcertkey_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbmonitorsslcertkeybinding
    .EXAMPLE 
        Invoke-ADCGetLbmonitorsslcertkeybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbmonitorsslcertkeybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbmonitorsslcertkeybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbmonitorsslcertkeybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbmonitorsslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbmonitor_sslcertkey_binding/
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
        [string]$monitorname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbmonitor_sslcertkey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_sslcertkey_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbmonitor_sslcertkey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_sslcertkey_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbmonitor_sslcertkey_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_sslcertkey_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbmonitor_sslcertkey_binding configuration for property 'monitorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_sslcertkey_binding -Resource $monitorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbmonitor_sslcertkey_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbmonitor_sslcertkey_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Update Load Balancing configuration Object
    .DESCRIPTION
        Update Load Balancing configuration Object 
    .PARAMETER httponlycookieflag 
        Include the HttpOnly attribute in persistence cookies. The HttpOnly attribute limits the scope of a cookie to HTTP requests and helps mitigate the risk of cross-site scripting attacks.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER usesecuredpersistencecookie 
        Encode persistence cookie values using SHA2 hash.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER useencryptedpersistencecookie 
        Encode persistence cookie values using SHA2 hash.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cookiepassphrase 
        Use this parameter to specify the passphrase used to generate secured persistence cookie value. It specifies the passphrase with a maximum of 31 characters. 
    .PARAMETER consolidatedlconn 
        To find the service with the fewest connections, the virtual server uses the consolidated connection statistics from all the packet engines. The NO setting allows consideration of only the number of connections on the packet engine that received the new connection.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER useportforhashlb 
        Include the port number of the service when creating a hash for hash based load balancing methods. With the NO setting, only the IP address of the service is considered when creating a hash.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER preferdirectroute 
        Perform route lookup for traffic received by the Citrix ADC, and forward the traffic according to configured routes. Do not set this parameter if you want a wildcard virtual server to direct packets received by the appliance to an intermediary device, such as a firewall, even if their destination is directly connected to the appliance. Route lookup is performed after the packets have been processed and returned by the intermediary device.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER startuprrfactor 
        Number of requests, per service, for which to apply the round robin load balancing method before switching to the configured load balancing method, thus allowing services to ramp up gradually to full load. Until the specified number of requests is distributed, the Citrix ADC is said to be implementing the slow start mode (or startup round robin). Implemented for a virtual server when one of the following is true:  
        * The virtual server is newly created.  
        * One or more services are newly bound to the virtual server.  
        * One or more services bound to the virtual server are enabled.  
        * The load balancing method is changed.  
        This parameter applies to all the load balancing virtual servers configured on the Citrix ADC, except for those virtual servers for which the virtual server-level slow start parameters (New Service Startup Request Rate and Increment Interval) are configured. If the global slow start parameter and the slow start parameters for a given virtual server are not set, the appliance implements a default slow start for the virtual server, as follows:  
        * For a newly configured virtual server, the appliance implements slow start for the first 100 requests received by the virtual server.  
        * For an existing virtual server, if one or more services are newly bound or newly enabled, or if the load balancing method is changed, the appliance dynamically computes the number of requests for which to implement startup round robin. It obtains this number by multiplying the request rate by the number of bound services (it includes services that are marked as DOWN). For example, if the current request rate is 20 requests/s and ten services are bound to the virtual server, the appliance performs startup round robin for 200 requests.  
        Not applicable to a virtual server for which a hash based load balancing method is configured. 
    .PARAMETER monitorskipmaxclient 
        When a monitor initiates a connection to a service, do not check to determine whether the number of connections to the service has reached the limit specified by the service's Max Clients setting. Enables monitoring to continue even if the service has reached its connection limit.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER monitorconnectionclose 
        Close monitoring connections by sending the service a connection termination message with the specified bit set.  
        Default value: FIN  
        Possible values = RESET, FIN 
    .PARAMETER vserverspecificmac 
        Allow a MAC-mode virtual server to accept traffic returned by an intermediary device, such as a firewall, to which the traffic was previously forwarded by another MAC-mode virtual server. The second virtual server can then distribute that traffic across the destination server farm. Also useful when load balancing Branch Repeater appliances.  
        Note: The second virtual server can also send the traffic to another set of intermediary devices, such as another set of firewalls. If necessary, you can configure multiple MAC-mode virtual servers to pass traffic successively through multiple sets of intermediary devices.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER allowboundsvcremoval 
        This is used, to enable/disable the option of svc/svcgroup removal, if it is bound to one or more vserver. If it is enabled, the svc/svcgroup can be removed, even if it bound to vservers. If disabled, an error will be thrown, when the user tries to remove a svc/svcgroup without unbinding from its vservers.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER retainservicestate 
        This option is used to retain the original state of service or servicegroup member when an enable server command is issued.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER dbsttl 
        Specify the TTL for DNS record for domain based service. The default value of ttl is 0 which indicates to use the TTL received in DNS response for monitors.  
        Default value: 0 
    .PARAMETER maxpipelinenat 
        Maximum number of concurrent requests to allow on a single client connection, which is identified by the <clientip:port>-<vserver ip:port> tuple. This parameter is applicable to ANY service type and all UDP service types (except DNS) and only when "svrTimeout" is set to zero. A value of 0 (zero) applies no limit to the number of concurrent requests allowed on a single client connection. 
    .PARAMETER literaladccookieattribute 
        String configured as LiteralADCCookieAttribute will be appended as attribute for Citrix ADC cookie (for example: LB cookie persistence , GSLB site persistence, CS cookie persistence, LB group cookie persistence).  
        Sample usage -  
        set lb parameter -LiteralADCCookieAttribute ";SameSite=None". 
    .PARAMETER computedadccookieattribute 
        ComputedADCCookieAttribute accepts ns variable as input in form of string starting with $ (to understand how to configure ns variable, please check man add ns variable). policies can be configured to modify this variable for every transaction and the final value of the variable after policy evaluation will be appended as attribute to Citrix ADC cookie (for example: LB cookie persistence , GSLB sitepersistence, CS cookie persistence, LB group cookie persistence). Only one of ComputedADCCookieAttribute, LiteralADCCookieAttribute can be set.  
        Sample usage -  
        add ns variable lbvar -type TEXT(100) -scope Transaction  
        add ns assignment lbassign -variable $lbvar -set "\\";SameSite=Strict\\""  
        add rewrite policy lbpol <valid policy expression> lbassign  
        bind rewrite global lbpol 100 next -type RES_OVERRIDE  
        set lb param -ComputedADCCookieAttribute "$lbvar"  
        For incoming client request, if above policy evaluates TRUE, then SameSite=Strict will be appended to ADC generated cookie.
    .EXAMPLE
        Invoke-ADCUpdateLbparameter 
    .NOTES
        File Name : Invoke-ADCUpdateLbparameter
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbparameter/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httponlycookieflag ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$usesecuredpersistencecookie ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$useencryptedpersistencecookie ,

        [string]$cookiepassphrase ,

        [ValidateSet('YES', 'NO')]
        [string]$consolidatedlconn ,

        [ValidateSet('YES', 'NO')]
        [string]$useportforhashlb ,

        [ValidateSet('YES', 'NO')]
        [string]$preferdirectroute ,

        [double]$startuprrfactor ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$monitorskipmaxclient ,

        [ValidateSet('RESET', 'FIN')]
        [string]$monitorconnectionclose ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$vserverspecificmac ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$allowboundsvcremoval ,

        [ValidateSet('ON', 'OFF')]
        [string]$retainservicestate ,

        [double]$dbsttl ,

        [double]$maxpipelinenat ,

        [string]$literaladccookieattribute ,

        [string]$computedadccookieattribute 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLbparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('httponlycookieflag')) { $Payload.Add('httponlycookieflag', $httponlycookieflag) }
            if ($PSBoundParameters.ContainsKey('usesecuredpersistencecookie')) { $Payload.Add('usesecuredpersistencecookie', $usesecuredpersistencecookie) }
            if ($PSBoundParameters.ContainsKey('useencryptedpersistencecookie')) { $Payload.Add('useencryptedpersistencecookie', $useencryptedpersistencecookie) }
            if ($PSBoundParameters.ContainsKey('cookiepassphrase')) { $Payload.Add('cookiepassphrase', $cookiepassphrase) }
            if ($PSBoundParameters.ContainsKey('consolidatedlconn')) { $Payload.Add('consolidatedlconn', $consolidatedlconn) }
            if ($PSBoundParameters.ContainsKey('useportforhashlb')) { $Payload.Add('useportforhashlb', $useportforhashlb) }
            if ($PSBoundParameters.ContainsKey('preferdirectroute')) { $Payload.Add('preferdirectroute', $preferdirectroute) }
            if ($PSBoundParameters.ContainsKey('startuprrfactor')) { $Payload.Add('startuprrfactor', $startuprrfactor) }
            if ($PSBoundParameters.ContainsKey('monitorskipmaxclient')) { $Payload.Add('monitorskipmaxclient', $monitorskipmaxclient) }
            if ($PSBoundParameters.ContainsKey('monitorconnectionclose')) { $Payload.Add('monitorconnectionclose', $monitorconnectionclose) }
            if ($PSBoundParameters.ContainsKey('vserverspecificmac')) { $Payload.Add('vserverspecificmac', $vserverspecificmac) }
            if ($PSBoundParameters.ContainsKey('allowboundsvcremoval')) { $Payload.Add('allowboundsvcremoval', $allowboundsvcremoval) }
            if ($PSBoundParameters.ContainsKey('retainservicestate')) { $Payload.Add('retainservicestate', $retainservicestate) }
            if ($PSBoundParameters.ContainsKey('dbsttl')) { $Payload.Add('dbsttl', $dbsttl) }
            if ($PSBoundParameters.ContainsKey('maxpipelinenat')) { $Payload.Add('maxpipelinenat', $maxpipelinenat) }
            if ($PSBoundParameters.ContainsKey('literaladccookieattribute')) { $Payload.Add('literaladccookieattribute', $literaladccookieattribute) }
            if ($PSBoundParameters.ContainsKey('computedadccookieattribute')) { $Payload.Add('computedadccookieattribute', $computedadccookieattribute) }
 
            if ($PSCmdlet.ShouldProcess("lbparameter", "Update Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbparameter -Payload $Payload -GetWarning
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
        Unset Load Balancing configuration Object
    .DESCRIPTION
        Unset Load Balancing configuration Object 
   .PARAMETER httponlycookieflag 
       Include the HttpOnly attribute in persistence cookies. The HttpOnly attribute limits the scope of a cookie to HTTP requests and helps mitigate the risk of cross-site scripting attacks.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER usesecuredpersistencecookie 
       Encode persistence cookie values using SHA2 hash.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER useencryptedpersistencecookie 
       Encode persistence cookie values using SHA2 hash.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER cookiepassphrase 
       Use this parameter to specify the passphrase used to generate secured persistence cookie value. It specifies the passphrase with a maximum of 31 characters. 
   .PARAMETER consolidatedlconn 
       To find the service with the fewest connections, the virtual server uses the consolidated connection statistics from all the packet engines. The NO setting allows consideration of only the number of connections on the packet engine that received the new connection.  
       Possible values = YES, NO 
   .PARAMETER useportforhashlb 
       Include the port number of the service when creating a hash for hash based load balancing methods. With the NO setting, only the IP address of the service is considered when creating a hash.  
       Possible values = YES, NO 
   .PARAMETER preferdirectroute 
       Perform route lookup for traffic received by the Citrix ADC, and forward the traffic according to configured routes. Do not set this parameter if you want a wildcard virtual server to direct packets received by the appliance to an intermediary device, such as a firewall, even if their destination is directly connected to the appliance. Route lookup is performed after the packets have been processed and returned by the intermediary device.  
       Possible values = YES, NO 
   .PARAMETER startuprrfactor 
       Number of requests, per service, for which to apply the round robin load balancing method before switching to the configured load balancing method, thus allowing services to ramp up gradually to full load. Until the specified number of requests is distributed, the Citrix ADC is said to be implementing the slow start mode (or startup round robin). Implemented for a virtual server when one of the following is true:  
       * The virtual server is newly created.  
       * One or more services are newly bound to the virtual server.  
       * One or more services bound to the virtual server are enabled.  
       * The load balancing method is changed.  
       This parameter applies to all the load balancing virtual servers configured on the Citrix ADC, except for those virtual servers for which the virtual server-level slow start parameters (New Service Startup Request Rate and Increment Interval) are configured. If the global slow start parameter and the slow start parameters for a given virtual server are not set, the appliance implements a default slow start for the virtual server, as follows:  
       * For a newly configured virtual server, the appliance implements slow start for the first 100 requests received by the virtual server.  
       * For an existing virtual server, if one or more services are newly bound or newly enabled, or if the load balancing method is changed, the appliance dynamically computes the number of requests for which to implement startup round robin. It obtains this number by multiplying the request rate by the number of bound services (it includes services that are marked as DOWN). For example, if the current request rate is 20 requests/s and ten services are bound to the virtual server, the appliance performs startup round robin for 200 requests.  
       Not applicable to a virtual server for which a hash based load balancing method is configured. 
   .PARAMETER monitorskipmaxclient 
       When a monitor initiates a connection to a service, do not check to determine whether the number of connections to the service has reached the limit specified by the service's Max Clients setting. Enables monitoring to continue even if the service has reached its connection limit.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER monitorconnectionclose 
       Close monitoring connections by sending the service a connection termination message with the specified bit set.  
       Possible values = RESET, FIN 
   .PARAMETER vserverspecificmac 
       Allow a MAC-mode virtual server to accept traffic returned by an intermediary device, such as a firewall, to which the traffic was previously forwarded by another MAC-mode virtual server. The second virtual server can then distribute that traffic across the destination server farm. Also useful when load balancing Branch Repeater appliances.  
       Note: The second virtual server can also send the traffic to another set of intermediary devices, such as another set of firewalls. If necessary, you can configure multiple MAC-mode virtual servers to pass traffic successively through multiple sets of intermediary devices.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER allowboundsvcremoval 
       This is used, to enable/disable the option of svc/svcgroup removal, if it is bound to one or more vserver. If it is enabled, the svc/svcgroup can be removed, even if it bound to vservers. If disabled, an error will be thrown, when the user tries to remove a svc/svcgroup without unbinding from its vservers.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER retainservicestate 
       This option is used to retain the original state of service or servicegroup member when an enable server command is issued.  
       Possible values = ON, OFF 
   .PARAMETER dbsttl 
       Specify the TTL for DNS record for domain based service. The default value of ttl is 0 which indicates to use the TTL received in DNS response for monitors. 
   .PARAMETER maxpipelinenat 
       Maximum number of concurrent requests to allow on a single client connection, which is identified by the <clientip:port>-<vserver ip:port> tuple. This parameter is applicable to ANY service type and all UDP service types (except DNS) and only when "svrTimeout" is set to zero. A value of 0 (zero) applies no limit to the number of concurrent requests allowed on a single client connection. 
   .PARAMETER literaladccookieattribute 
       String configured as LiteralADCCookieAttribute will be appended as attribute for Citrix ADC cookie (for example: LB cookie persistence , GSLB site persistence, CS cookie persistence, LB group cookie persistence).  
       Sample usage -  
       set lb parameter -LiteralADCCookieAttribute ";SameSite=None". 
   .PARAMETER computedadccookieattribute 
       ComputedADCCookieAttribute accepts ns variable as input in form of string starting with $ (to understand how to configure ns variable, please check man add ns variable). policies can be configured to modify this variable for every transaction and the final value of the variable after policy evaluation will be appended as attribute to Citrix ADC cookie (for example: LB cookie persistence , GSLB sitepersistence, CS cookie persistence, LB group cookie persistence). Only one of ComputedADCCookieAttribute, LiteralADCCookieAttribute can be set.  
       Sample usage -  
       add ns variable lbvar -type TEXT(100) -scope Transaction  
       add ns assignment lbassign -variable $lbvar -set "\\";SameSite=Strict\\""  
       add rewrite policy lbpol <valid policy expression> lbassign  
       bind rewrite global lbpol 100 next -type RES_OVERRIDE  
       set lb param -ComputedADCCookieAttribute "$lbvar"  
       For incoming client request, if above policy evaluates TRUE, then SameSite=Strict will be appended to ADC generated cookie.
    .EXAMPLE
        Invoke-ADCUnsetLbparameter 
    .NOTES
        File Name : Invoke-ADCUnsetLbparameter
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbparameter
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

        [Boolean]$httponlycookieflag ,

        [Boolean]$usesecuredpersistencecookie ,

        [Boolean]$useencryptedpersistencecookie ,

        [Boolean]$cookiepassphrase ,

        [Boolean]$consolidatedlconn ,

        [Boolean]$useportforhashlb ,

        [Boolean]$preferdirectroute ,

        [Boolean]$startuprrfactor ,

        [Boolean]$monitorskipmaxclient ,

        [Boolean]$monitorconnectionclose ,

        [Boolean]$vserverspecificmac ,

        [Boolean]$allowboundsvcremoval ,

        [Boolean]$retainservicestate ,

        [Boolean]$dbsttl ,

        [Boolean]$maxpipelinenat ,

        [Boolean]$literaladccookieattribute ,

        [Boolean]$computedadccookieattribute 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLbparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('httponlycookieflag')) { $Payload.Add('httponlycookieflag', $httponlycookieflag) }
            if ($PSBoundParameters.ContainsKey('usesecuredpersistencecookie')) { $Payload.Add('usesecuredpersistencecookie', $usesecuredpersistencecookie) }
            if ($PSBoundParameters.ContainsKey('useencryptedpersistencecookie')) { $Payload.Add('useencryptedpersistencecookie', $useencryptedpersistencecookie) }
            if ($PSBoundParameters.ContainsKey('cookiepassphrase')) { $Payload.Add('cookiepassphrase', $cookiepassphrase) }
            if ($PSBoundParameters.ContainsKey('consolidatedlconn')) { $Payload.Add('consolidatedlconn', $consolidatedlconn) }
            if ($PSBoundParameters.ContainsKey('useportforhashlb')) { $Payload.Add('useportforhashlb', $useportforhashlb) }
            if ($PSBoundParameters.ContainsKey('preferdirectroute')) { $Payload.Add('preferdirectroute', $preferdirectroute) }
            if ($PSBoundParameters.ContainsKey('startuprrfactor')) { $Payload.Add('startuprrfactor', $startuprrfactor) }
            if ($PSBoundParameters.ContainsKey('monitorskipmaxclient')) { $Payload.Add('monitorskipmaxclient', $monitorskipmaxclient) }
            if ($PSBoundParameters.ContainsKey('monitorconnectionclose')) { $Payload.Add('monitorconnectionclose', $monitorconnectionclose) }
            if ($PSBoundParameters.ContainsKey('vserverspecificmac')) { $Payload.Add('vserverspecificmac', $vserverspecificmac) }
            if ($PSBoundParameters.ContainsKey('allowboundsvcremoval')) { $Payload.Add('allowboundsvcremoval', $allowboundsvcremoval) }
            if ($PSBoundParameters.ContainsKey('retainservicestate')) { $Payload.Add('retainservicestate', $retainservicestate) }
            if ($PSBoundParameters.ContainsKey('dbsttl')) { $Payload.Add('dbsttl', $dbsttl) }
            if ($PSBoundParameters.ContainsKey('maxpipelinenat')) { $Payload.Add('maxpipelinenat', $maxpipelinenat) }
            if ($PSBoundParameters.ContainsKey('literaladccookieattribute')) { $Payload.Add('literaladccookieattribute', $literaladccookieattribute) }
            if ($PSBoundParameters.ContainsKey('computedadccookieattribute')) { $Payload.Add('computedadccookieattribute', $computedadccookieattribute) }
            if ($PSCmdlet.ShouldProcess("lbparameter", "Unset Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbparameter -Action unset -Payload $Payload -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER GetAll 
        Retreive all lbparameter object(s)
    .PARAMETER Count
        If specified, the count of the lbparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbparameter
    .EXAMPLE 
        Invoke-ADCGetLbparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetLbparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetLbparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbparameter
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbparameter/
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
        Write-Verbose "Invoke-ADCGetLbparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lbparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbparameter -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbparameter -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbparameter -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving lbparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbparameter -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Clear Load Balancing configuration Object
    .DESCRIPTION
        Clear Load Balancing configuration Object 
    .PARAMETER vserver 
        The name of the virtual server. 
    .PARAMETER persistenceparameter 
        The persistence parameter whose persistence sessions are to be flushed.
    .EXAMPLE
        Invoke-ADCClearLbpersistentsessions 
    .NOTES
        File Name : Invoke-ADCClearLbpersistentsessions
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbpersistentsessions/
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

        [string]$vserver ,

        [string]$persistenceparameter 

    )
    begin {
        Write-Verbose "Invoke-ADCClearLbpersistentsessions: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Payload.Add('vserver', $vserver) }
            if ($PSBoundParameters.ContainsKey('persistenceparameter')) { $Payload.Add('persistenceparameter', $persistenceparameter) }
            if ($PSCmdlet.ShouldProcess($Name, "Clear Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbpersistentsessions -Action clear -Payload $Payload -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER vserver 
       The name of the virtual server. 
    .PARAMETER nodeid 
       Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retreive all lbpersistentsessions object(s)
    .PARAMETER Count
        If specified, the count of the lbpersistentsessions object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbpersistentsessions
    .EXAMPLE 
        Invoke-ADCGetLbpersistentsessions -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbpersistentsessions -Count
    .EXAMPLE
        Invoke-ADCGetLbpersistentsessions -name <string>
    .EXAMPLE
        Invoke-ADCGetLbpersistentsessions -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbpersistentsessions
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbpersistentsessions/
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
        [string]$vserver ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 31)]
        [double]$nodeid,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lbpersistentsessions objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbpersistentsessions -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbpersistentsessions objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbpersistentsessions -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbpersistentsessions objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('vserver')) { $Arguments.Add('vserver', $vserver) } 
                if ($PSBoundParameters.ContainsKey('nodeid')) { $Arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbpersistentsessions -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbpersistentsessions configuration for property ''"

            } else {
                Write-Verbose "Retrieving lbpersistentsessions configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbpersistentsessions -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER lbprofilename 
        Name of the LB profile.  
        Minimum length = 1 
    .PARAMETER dbslb 
        Enable database specific load balancing for MySQL and MSSQL service types.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER processlocal 
        By turning on this option packets destined to a vserver in a cluster will not under go any steering. Turn this option for single pa  
        cket request response mode or when the upstream device is performing a proper RSS for connection based distribution.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httponlycookieflag 
        Include the HttpOnly attribute in persistence cookies. The HttpOnly attribute limits the scope of a cookie to HTTP requests and helps mitigate the risk of cross-site scripting attacks.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cookiepassphrase 
        Use this parameter to specify the passphrase used to generate secured persistence cookie value. It specifies the passphrase with a maximum of 31 characters. 
    .PARAMETER usesecuredpersistencecookie 
        Encode persistence cookie values using SHA2 hash.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER useencryptedpersistencecookie 
        Encode persistence cookie values using SHA2 hash.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER literaladccookieattribute 
        String configured as LiteralADCCookieAttribute will be appended as attribute for Citrix ADC cookie (for example: LB cookie persistence , GSLB site persistence, CS cookie persistence, LB group cookie persistence).  
        Sample usage -  
        add lb profile lbprof -LiteralADCCookieAttribute ";SameSite=None". 
    .PARAMETER computedadccookieattribute 
        ComputedADCCookieAttribute accepts ns variable as input in form of string starting with $ (to understand how to configure ns variable, please check man add ns variable). policies can be configured to modify this variable for every transaction and the final value of the variable after policy evaluation will be appended as attribute to Citrix ADC cookie (for example: LB cookie persistence , GSLB sitepersistence, CS cookie persistence, LB group cookie persistence). Only one of ComputedADCCookieAttribute, LiteralADCCookieAttribute can be set.  
        Sample usage -  
        add ns variable lbvar -type TEXT(100) -scope Transaction  
        add ns assignment lbassign -variable $lbvar -set "\\";SameSite=Strict\\""  
        add rewrite policy lbpol <valid policy expression> lbassign  
        bind rewrite global lbpol 100 next -type RES_OVERRIDE  
        add lb profile lbprof -ComputedADCCookieAttribute "$lbvar"  
        For incoming client request, if above policy evaluates TRUE, then SameSite=Strict will be appended to ADC generated cookie. 
    .PARAMETER PassThru 
        Return details about the created lbprofile item.
    .EXAMPLE
        Invoke-ADCAddLbprofile -lbprofilename <string>
    .NOTES
        File Name : Invoke-ADCAddLbprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbprofile/
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
        [string]$lbprofilename ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dbslb = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$processlocal = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httponlycookieflag = 'ENABLED' ,

        [string]$cookiepassphrase ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$usesecuredpersistencecookie = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$useencryptedpersistencecookie = 'DISABLED' ,

        [string]$literaladccookieattribute ,

        [string]$computedadccookieattribute ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                lbprofilename = $lbprofilename
            }
            if ($PSBoundParameters.ContainsKey('dbslb')) { $Payload.Add('dbslb', $dbslb) }
            if ($PSBoundParameters.ContainsKey('processlocal')) { $Payload.Add('processlocal', $processlocal) }
            if ($PSBoundParameters.ContainsKey('httponlycookieflag')) { $Payload.Add('httponlycookieflag', $httponlycookieflag) }
            if ($PSBoundParameters.ContainsKey('cookiepassphrase')) { $Payload.Add('cookiepassphrase', $cookiepassphrase) }
            if ($PSBoundParameters.ContainsKey('usesecuredpersistencecookie')) { $Payload.Add('usesecuredpersistencecookie', $usesecuredpersistencecookie) }
            if ($PSBoundParameters.ContainsKey('useencryptedpersistencecookie')) { $Payload.Add('useencryptedpersistencecookie', $useencryptedpersistencecookie) }
            if ($PSBoundParameters.ContainsKey('literaladccookieattribute')) { $Payload.Add('literaladccookieattribute', $literaladccookieattribute) }
            if ($PSBoundParameters.ContainsKey('computedadccookieattribute')) { $Payload.Add('computedadccookieattribute', $computedadccookieattribute) }
 
            if ($PSCmdlet.ShouldProcess("lbprofile", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbprofile -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER lbprofilename 
       Name of the LB profile.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteLbprofile -lbprofilename <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbprofile/
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
        [string]$lbprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$lbprofilename", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbprofile -Resource $lbprofilename -Arguments $Arguments
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
        Update Load Balancing configuration Object
    .DESCRIPTION
        Update Load Balancing configuration Object 
    .PARAMETER lbprofilename 
        Name of the LB profile.  
        Minimum length = 1 
    .PARAMETER dbslb 
        Enable database specific load balancing for MySQL and MSSQL service types.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER processlocal 
        By turning on this option packets destined to a vserver in a cluster will not under go any steering. Turn this option for single pa  
        cket request response mode or when the upstream device is performing a proper RSS for connection based distribution.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httponlycookieflag 
        Include the HttpOnly attribute in persistence cookies. The HttpOnly attribute limits the scope of a cookie to HTTP requests and helps mitigate the risk of cross-site scripting attacks.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cookiepassphrase 
        Use this parameter to specify the passphrase used to generate secured persistence cookie value. It specifies the passphrase with a maximum of 31 characters. 
    .PARAMETER usesecuredpersistencecookie 
        Encode persistence cookie values using SHA2 hash.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER useencryptedpersistencecookie 
        Encode persistence cookie values using SHA2 hash.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER literaladccookieattribute 
        String configured as LiteralADCCookieAttribute will be appended as attribute for Citrix ADC cookie (for example: LB cookie persistence , GSLB site persistence, CS cookie persistence, LB group cookie persistence).  
        Sample usage -  
        add lb profile lbprof -LiteralADCCookieAttribute ";SameSite=None". 
    .PARAMETER computedadccookieattribute 
        ComputedADCCookieAttribute accepts ns variable as input in form of string starting with $ (to understand how to configure ns variable, please check man add ns variable). policies can be configured to modify this variable for every transaction and the final value of the variable after policy evaluation will be appended as attribute to Citrix ADC cookie (for example: LB cookie persistence , GSLB sitepersistence, CS cookie persistence, LB group cookie persistence). Only one of ComputedADCCookieAttribute, LiteralADCCookieAttribute can be set.  
        Sample usage -  
        add ns variable lbvar -type TEXT(100) -scope Transaction  
        add ns assignment lbassign -variable $lbvar -set "\\";SameSite=Strict\\""  
        add rewrite policy lbpol <valid policy expression> lbassign  
        bind rewrite global lbpol 100 next -type RES_OVERRIDE  
        add lb profile lbprof -ComputedADCCookieAttribute "$lbvar"  
        For incoming client request, if above policy evaluates TRUE, then SameSite=Strict will be appended to ADC generated cookie. 
    .PARAMETER PassThru 
        Return details about the created lbprofile item.
    .EXAMPLE
        Invoke-ADCUpdateLbprofile -lbprofilename <string>
    .NOTES
        File Name : Invoke-ADCUpdateLbprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbprofile/
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
        [string]$lbprofilename ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dbslb ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$processlocal ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httponlycookieflag ,

        [string]$cookiepassphrase ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$usesecuredpersistencecookie ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$useencryptedpersistencecookie ,

        [string]$literaladccookieattribute ,

        [string]$computedadccookieattribute ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLbprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                lbprofilename = $lbprofilename
            }
            if ($PSBoundParameters.ContainsKey('dbslb')) { $Payload.Add('dbslb', $dbslb) }
            if ($PSBoundParameters.ContainsKey('processlocal')) { $Payload.Add('processlocal', $processlocal) }
            if ($PSBoundParameters.ContainsKey('httponlycookieflag')) { $Payload.Add('httponlycookieflag', $httponlycookieflag) }
            if ($PSBoundParameters.ContainsKey('cookiepassphrase')) { $Payload.Add('cookiepassphrase', $cookiepassphrase) }
            if ($PSBoundParameters.ContainsKey('usesecuredpersistencecookie')) { $Payload.Add('usesecuredpersistencecookie', $usesecuredpersistencecookie) }
            if ($PSBoundParameters.ContainsKey('useencryptedpersistencecookie')) { $Payload.Add('useencryptedpersistencecookie', $useencryptedpersistencecookie) }
            if ($PSBoundParameters.ContainsKey('literaladccookieattribute')) { $Payload.Add('literaladccookieattribute', $literaladccookieattribute) }
            if ($PSBoundParameters.ContainsKey('computedadccookieattribute')) { $Payload.Add('computedadccookieattribute', $computedadccookieattribute) }
 
            if ($PSCmdlet.ShouldProcess("lbprofile", "Update Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbprofile -Filter $Payload)
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
        Unset Load Balancing configuration Object
    .DESCRIPTION
        Unset Load Balancing configuration Object 
   .PARAMETER lbprofilename 
       Name of the LB profile. 
   .PARAMETER dbslb 
       Enable database specific load balancing for MySQL and MSSQL service types.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER processlocal 
       By turning on this option packets destined to a vserver in a cluster will not under go any steering. Turn this option for single pa  
       cket request response mode or when the upstream device is performing a proper RSS for connection based distribution.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httponlycookieflag 
       Include the HttpOnly attribute in persistence cookies. The HttpOnly attribute limits the scope of a cookie to HTTP requests and helps mitigate the risk of cross-site scripting attacks.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER cookiepassphrase 
       Use this parameter to specify the passphrase used to generate secured persistence cookie value. It specifies the passphrase with a maximum of 31 characters. 
   .PARAMETER usesecuredpersistencecookie 
       Encode persistence cookie values using SHA2 hash.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER useencryptedpersistencecookie 
       Encode persistence cookie values using SHA2 hash.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER literaladccookieattribute 
       String configured as LiteralADCCookieAttribute will be appended as attribute for Citrix ADC cookie (for example: LB cookie persistence , GSLB site persistence, CS cookie persistence, LB group cookie persistence).  
       Sample usage -  
       add lb profile lbprof -LiteralADCCookieAttribute ";SameSite=None". 
   .PARAMETER computedadccookieattribute 
       ComputedADCCookieAttribute accepts ns variable as input in form of string starting with $ (to understand how to configure ns variable, please check man add ns variable). policies can be configured to modify this variable for every transaction and the final value of the variable after policy evaluation will be appended as attribute to Citrix ADC cookie (for example: LB cookie persistence , GSLB sitepersistence, CS cookie persistence, LB group cookie persistence). Only one of ComputedADCCookieAttribute, LiteralADCCookieAttribute can be set.  
       Sample usage -  
       add ns variable lbvar -type TEXT(100) -scope Transaction  
       add ns assignment lbassign -variable $lbvar -set "\\";SameSite=Strict\\""  
       add rewrite policy lbpol <valid policy expression> lbassign  
       bind rewrite global lbpol 100 next -type RES_OVERRIDE  
       add lb profile lbprof -ComputedADCCookieAttribute "$lbvar"  
       For incoming client request, if above policy evaluates TRUE, then SameSite=Strict will be appended to ADC generated cookie.
    .EXAMPLE
        Invoke-ADCUnsetLbprofile -lbprofilename <string>
    .NOTES
        File Name : Invoke-ADCUnsetLbprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbprofile
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
        [string]$lbprofilename ,

        [Boolean]$dbslb ,

        [Boolean]$processlocal ,

        [Boolean]$httponlycookieflag ,

        [Boolean]$cookiepassphrase ,

        [Boolean]$usesecuredpersistencecookie ,

        [Boolean]$useencryptedpersistencecookie ,

        [Boolean]$literaladccookieattribute ,

        [Boolean]$computedadccookieattribute 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLbprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                lbprofilename = $lbprofilename
            }
            if ($PSBoundParameters.ContainsKey('dbslb')) { $Payload.Add('dbslb', $dbslb) }
            if ($PSBoundParameters.ContainsKey('processlocal')) { $Payload.Add('processlocal', $processlocal) }
            if ($PSBoundParameters.ContainsKey('httponlycookieflag')) { $Payload.Add('httponlycookieflag', $httponlycookieflag) }
            if ($PSBoundParameters.ContainsKey('cookiepassphrase')) { $Payload.Add('cookiepassphrase', $cookiepassphrase) }
            if ($PSBoundParameters.ContainsKey('usesecuredpersistencecookie')) { $Payload.Add('usesecuredpersistencecookie', $usesecuredpersistencecookie) }
            if ($PSBoundParameters.ContainsKey('useencryptedpersistencecookie')) { $Payload.Add('useencryptedpersistencecookie', $useencryptedpersistencecookie) }
            if ($PSBoundParameters.ContainsKey('literaladccookieattribute')) { $Payload.Add('literaladccookieattribute', $literaladccookieattribute) }
            if ($PSBoundParameters.ContainsKey('computedadccookieattribute')) { $Payload.Add('computedadccookieattribute', $computedadccookieattribute) }
            if ($PSCmdlet.ShouldProcess("$lbprofilename", "Unset Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbprofile -Action unset -Payload $Payload -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER lbprofilename 
       Name of the LB profile. 
    .PARAMETER GetAll 
        Retreive all lbprofile object(s)
    .PARAMETER Count
        If specified, the count of the lbprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbprofile
    .EXAMPLE 
        Invoke-ADCGetLbprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbprofile -Count
    .EXAMPLE
        Invoke-ADCGetLbprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetLbprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbprofile/
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
        [string]$lbprofilename,

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
        Write-Verbose "Invoke-ADCGetLbprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lbprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbprofile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbprofile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbprofile -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbprofile configuration for property 'lbprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbprofile -Resource $lbprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbprofile -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER network 
        The IP address of the network to which the route belongs. 
    .PARAMETER netmask 
        The netmask to which the route belongs. 
    .PARAMETER gatewayname 
        The name of the route.  
        Minimum length = 1 
    .PARAMETER td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 4094
    .EXAMPLE
        Invoke-ADCAddLbroute -network <string> -netmask <string> -gatewayname <string>
    .NOTES
        File Name : Invoke-ADCAddLbroute
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbroute/
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
        [string]$network ,

        [Parameter(Mandatory = $true)]
        [string]$netmask ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$gatewayname ,

        [ValidateRange(0, 4094)]
        [double]$td = '0' 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbroute: Starting"
    }
    process {
        try {
            $Payload = @{
                network = $network
                netmask = $netmask
                gatewayname = $gatewayname
            }
            if ($PSBoundParameters.ContainsKey('td')) { $Payload.Add('td', $td) }
 
            if ($PSCmdlet.ShouldProcess("lbroute", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbroute -Payload $Payload -GetWarning
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER network 
       The IP address of the network to which the route belongs.    .PARAMETER netmask 
       The netmask to which the route belongs.    .PARAMETER td 
       Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0.  
       Default value: 0  
       Minimum value = 0  
       Maximum value = 4094
    .EXAMPLE
        Invoke-ADCDeleteLbroute -network <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbroute
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbroute/
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
        [string]$network ,

        [string]$netmask ,

        [double]$td 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbroute: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Arguments.Add('netmask', $netmask) }
            if ($PSBoundParameters.ContainsKey('td')) { $Arguments.Add('td', $td) }
            if ($PSCmdlet.ShouldProcess("$network", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbroute -Resource $network -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER GetAll 
        Retreive all lbroute object(s)
    .PARAMETER Count
        If specified, the count of the lbroute object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbroute
    .EXAMPLE 
        Invoke-ADCGetLbroute -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbroute -Count
    .EXAMPLE
        Invoke-ADCGetLbroute -name <string>
    .EXAMPLE
        Invoke-ADCGetLbroute -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbroute
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbroute/
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
        Write-Verbose "Invoke-ADCGetLbroute: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lbroute objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbroute -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbroute objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbroute -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbroute objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbroute -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbroute configuration for property ''"

            } else {
                Write-Verbose "Retrieving lbroute configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbroute -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER network 
        The destination network. 
    .PARAMETER gatewayname 
        The name of the route.  
        Minimum length = 1 
    .PARAMETER td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 4094
    .EXAMPLE
        Invoke-ADCAddLbroute6 -network <string> -gatewayname <string>
    .NOTES
        File Name : Invoke-ADCAddLbroute6
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbroute6/
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
        [string]$network ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$gatewayname ,

        [ValidateRange(0, 4094)]
        [double]$td = '0' 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbroute6: Starting"
    }
    process {
        try {
            $Payload = @{
                network = $network
                gatewayname = $gatewayname
            }
            if ($PSBoundParameters.ContainsKey('td')) { $Payload.Add('td', $td) }
 
            if ($PSCmdlet.ShouldProcess("lbroute6", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbroute6 -Payload $Payload -GetWarning
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER network 
       The destination network.    .PARAMETER td 
       Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0.  
       Default value: 0  
       Minimum value = 0  
       Maximum value = 4094
    .EXAMPLE
        Invoke-ADCDeleteLbroute6 -network <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbroute6
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbroute6/
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
        [string]$network ,

        [double]$td 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbroute6: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('td')) { $Arguments.Add('td', $td) }
            if ($PSCmdlet.ShouldProcess("$network", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbroute6 -Resource $network -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER GetAll 
        Retreive all lbroute6 object(s)
    .PARAMETER Count
        If specified, the count of the lbroute6 object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbroute6
    .EXAMPLE 
        Invoke-ADCGetLbroute6 -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbroute6 -Count
    .EXAMPLE
        Invoke-ADCGetLbroute6 -name <string>
    .EXAMPLE
        Invoke-ADCGetLbroute6 -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbroute6
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbroute6/
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
        Write-Verbose "Invoke-ADCGetLbroute6: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lbroute6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbroute6 -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbroute6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbroute6 -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbroute6 objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbroute6 -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbroute6 configuration for property ''"

            } else {
                Write-Verbose "Retrieving lbroute6 configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbroute6 -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Update Load Balancing configuration Object
    .DESCRIPTION
        Update Load Balancing configuration Object 
    .PARAMETER rnatsrcport 
        Port number with which to match the source port in server-initiated SIP traffic. The rport parameter is added, without a value, to SIP packets that have a matching source port number, and CALL-ID based persistence is implemented for the responses received by the virtual server.  
        Default value: 0 
    .PARAMETER rnatdstport 
        Port number with which to match the destination port in server-initiated SIP traffic. The rport parameter is added, without a value, to SIP packets that have a matching destination port number, and CALL-ID based persistence is implemented for the responses received by the virtual server.  
        Default value: 0 
    .PARAMETER retrydur 
        Time, in seconds, for which a client must wait before initiating a connection after receiving a 503 Service Unavailable response from the SIP server. The time value is sent in the "Retry-After" header in the 503 response.  
        Default value: 120  
        Minimum value = 1 
    .PARAMETER addrportvip 
        Add the rport parameter to the VIA headers of SIP requests that virtual servers receive from clients or servers.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sip503ratethreshold 
        Maximum number of 503 Service Unavailable responses to generate, once every 10 milliseconds, when a SIP virtual server becomes unavailable.  
        Default value: 100 
    .PARAMETER rnatsecuresrcport 
        Port number with which to match the source port in server-initiated SIP over SSL traffic. The rport parameter is added, without a value, to SIP packets that have a matching source port number, and CALL-ID based persistence is implemented for the responses received by the virtual server.  
        Default value: 0  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER rnatsecuredstport 
        Port number with which to match the destination port in server-initiated SIP over SSL traffic. The rport parameter is added, without a value, to SIP packets that have a matching destination port number, and CALL-ID based persistence is implemented for the responses received by the virtual server.  
        Default value: 0  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        Invoke-ADCUpdateLbsipparameters 
    .NOTES
        File Name : Invoke-ADCUpdateLbsipparameters
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbsipparameters/
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

        [int]$rnatsrcport ,

        [int]$rnatdstport ,

        [int]$retrydur ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$addrportvip ,

        [double]$sip503ratethreshold ,

        [ValidateRange(1, 65535)]
        [int]$rnatsecuresrcport ,

        [ValidateRange(1, 65535)]
        [int]$rnatsecuredstport 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLbsipparameters: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('rnatsrcport')) { $Payload.Add('rnatsrcport', $rnatsrcport) }
            if ($PSBoundParameters.ContainsKey('rnatdstport')) { $Payload.Add('rnatdstport', $rnatdstport) }
            if ($PSBoundParameters.ContainsKey('retrydur')) { $Payload.Add('retrydur', $retrydur) }
            if ($PSBoundParameters.ContainsKey('addrportvip')) { $Payload.Add('addrportvip', $addrportvip) }
            if ($PSBoundParameters.ContainsKey('sip503ratethreshold')) { $Payload.Add('sip503ratethreshold', $sip503ratethreshold) }
            if ($PSBoundParameters.ContainsKey('rnatsecuresrcport')) { $Payload.Add('rnatsecuresrcport', $rnatsecuresrcport) }
            if ($PSBoundParameters.ContainsKey('rnatsecuredstport')) { $Payload.Add('rnatsecuredstport', $rnatsecuredstport) }
 
            if ($PSCmdlet.ShouldProcess("lbsipparameters", "Update Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbsipparameters -Payload $Payload -GetWarning
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
        Unset Load Balancing configuration Object
    .DESCRIPTION
        Unset Load Balancing configuration Object 
   .PARAMETER rnatsrcport 
       Port number with which to match the source port in server-initiated SIP traffic. The rport parameter is added, without a value, to SIP packets that have a matching source port number, and CALL-ID based persistence is implemented for the responses received by the virtual server. 
   .PARAMETER rnatdstport 
       Port number with which to match the destination port in server-initiated SIP traffic. The rport parameter is added, without a value, to SIP packets that have a matching destination port number, and CALL-ID based persistence is implemented for the responses received by the virtual server. 
   .PARAMETER retrydur 
       Time, in seconds, for which a client must wait before initiating a connection after receiving a 503 Service Unavailable response from the SIP server. The time value is sent in the "Retry-After" header in the 503 response. 
   .PARAMETER addrportvip 
       Add the rport parameter to the VIA headers of SIP requests that virtual servers receive from clients or servers.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sip503ratethreshold 
       Maximum number of 503 Service Unavailable responses to generate, once every 10 milliseconds, when a SIP virtual server becomes unavailable. 
   .PARAMETER rnatsecuresrcport 
       Port number with which to match the source port in server-initiated SIP over SSL traffic. The rport parameter is added, without a value, to SIP packets that have a matching source port number, and CALL-ID based persistence is implemented for the responses received by the virtual server.  
       * in CLI is represented as 65535 in NITRO API 
   .PARAMETER rnatsecuredstport 
       Port number with which to match the destination port in server-initiated SIP over SSL traffic. The rport parameter is added, without a value, to SIP packets that have a matching destination port number, and CALL-ID based persistence is implemented for the responses received by the virtual server.  
       * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        Invoke-ADCUnsetLbsipparameters 
    .NOTES
        File Name : Invoke-ADCUnsetLbsipparameters
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbsipparameters
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

        [Boolean]$rnatsrcport ,

        [Boolean]$rnatdstport ,

        [Boolean]$retrydur ,

        [Boolean]$addrportvip ,

        [Boolean]$sip503ratethreshold ,

        [Boolean]$rnatsecuresrcport ,

        [Boolean]$rnatsecuredstport 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLbsipparameters: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('rnatsrcport')) { $Payload.Add('rnatsrcport', $rnatsrcport) }
            if ($PSBoundParameters.ContainsKey('rnatdstport')) { $Payload.Add('rnatdstport', $rnatdstport) }
            if ($PSBoundParameters.ContainsKey('retrydur')) { $Payload.Add('retrydur', $retrydur) }
            if ($PSBoundParameters.ContainsKey('addrportvip')) { $Payload.Add('addrportvip', $addrportvip) }
            if ($PSBoundParameters.ContainsKey('sip503ratethreshold')) { $Payload.Add('sip503ratethreshold', $sip503ratethreshold) }
            if ($PSBoundParameters.ContainsKey('rnatsecuresrcport')) { $Payload.Add('rnatsecuresrcport', $rnatsecuresrcport) }
            if ($PSBoundParameters.ContainsKey('rnatsecuredstport')) { $Payload.Add('rnatsecuredstport', $rnatsecuredstport) }
            if ($PSCmdlet.ShouldProcess("lbsipparameters", "Unset Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbsipparameters -Action unset -Payload $Payload -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER GetAll 
        Retreive all lbsipparameters object(s)
    .PARAMETER Count
        If specified, the count of the lbsipparameters object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbsipparameters
    .EXAMPLE 
        Invoke-ADCGetLbsipparameters -GetAll
    .EXAMPLE
        Invoke-ADCGetLbsipparameters -name <string>
    .EXAMPLE
        Invoke-ADCGetLbsipparameters -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbsipparameters
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbsipparameters/
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
        Write-Verbose "Invoke-ADCGetLbsipparameters: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lbsipparameters objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbsipparameters -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbsipparameters objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbsipparameters -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbsipparameters objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbsipparameters -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbsipparameters configuration for property ''"

            } else {
                Write-Verbose "Retrieving lbsipparameters configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbsipparameters -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER servicetype 
        Protocol used by the service (also called the service type).  
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, DTLS, NNTP, DNS, DHCPRA, ANY, SIP_UDP, SIP_TCP, SIP_SSL, DNS_TCP, RTSP, PUSH, SSL_PUSH, RADIUS, RDP, MYSQL, MSSQL, DIAMETER, SSL_DIAMETER, TFTP, ORACLE, SMPP, SYSLOGTCP, SYSLOGUDP, FIX, SSL_FIX, PROXY, USER_TCP, USER_SSL_TCP, QUIC, IPFIX, LOGSTREAM, MONGO, MONGO_TLS 
    .PARAMETER ipv46 
        IPv4 or IPv6 address to assign to the virtual server. 
    .PARAMETER ippattern 
        IP address pattern, in dotted decimal notation, for identifying packets to be accepted by the virtual server. The IP Mask parameter specifies which part of the destination IP address is matched against the pattern. Mutually exclusive with the IP Address parameter.  
        For example, if the IP pattern assigned to the virtual server is 198.51.100.0 and the IP mask is 255.255.240.0 (a forward mask), the first 20 bits in the destination IP addresses are matched with the first 20 bits in the pattern. The virtual server accepts requests with IP addresses that range from 198.51.96.1 to 198.51.111.254. You can also use a pattern such as 0.0.2.2 and a mask such as 0.0.255.255 (a reverse mask).  
        If a destination IP address matches more than one IP pattern, the pattern with the longest match is selected, and the associated virtual server processes the request. For example, if virtual servers vs1 and vs2 have the same IP pattern, 0.0.100.128, but different IP masks of 0.0.255.255 and 0.0.224.255, a destination IP address of 198.51.100.128 has the longest match with the IP pattern of vs1. If a destination IP address matches two or more virtual servers to the same extent, the request is processed by the virtual server whose port number matches the port number in the request. 
    .PARAMETER ipmask 
        IP mask, in dotted decimal notation, for the IP Pattern parameter. Can have leading or trailing non-zero octets (for example, 255.255.240.0 or 0.0.255.255). Accordingly, the mask specifies whether the first n bits or the last n bits of the destination IP address in a client request are to be matched with the corresponding bits in the IP pattern. The former is called a forward mask. The latter is called a reverse mask. 
    .PARAMETER port 
        Port number for the virtual server.  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current lb vserver.  
        Minimum length = 1 
    .PARAMETER range 
        Number of IP addresses that the appliance must generate and assign to the virtual server. The virtual server then functions as a network virtual server, accepting traffic on any of the generated IP addresses. The IP addresses are generated automatically, as follows:  
        * For a range of n, the last octet of the address specified by the IP Address parameter increments n-1 times.  
        * If the last octet exceeds 255, it rolls over to 0 and the third octet increments by 1.  
        Note: The Range parameter assigns multiple IP addresses to one virtual server. To generate an array of virtual servers, each of which owns only one IP address, use brackets in the IP Address and Name parameters to specify the range. For example:  
        add lb vserver my_vserver[1-3] HTTP 192.0.2.[1-3] 80.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 254 
    .PARAMETER persistencetype 
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
    .PARAMETER timeout 
        Time period for which a persistence session is in effect.  
        Default value: 2  
        Minimum value = 0  
        Maximum value = 1440 
    .PARAMETER persistencebackup 
        Backup persistence type for the virtual server. Becomes operational if the primary persistence mechanism fails.  
        Possible values = SOURCEIP, NONE 
    .PARAMETER backuppersistencetimeout 
        Time period for which backup persistence is in effect.  
        Default value: 2  
        Minimum value = 2  
        Maximum value = 1440 
    .PARAMETER lbmethod 
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
        Default value: LEASTCONNECTION  
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, URLHASH, DOMAINHASH, DESTINATIONIPHASH, SOURCEIPHASH, SRCIPDESTIPHASH, LEASTBANDWIDTH, LEASTPACKETS, TOKEN, SRCIPSRCPORTHASH, LRTM, CALLIDHASH, CUSTOMLOAD, LEASTREQUEST, AUDITLOGHASH, STATICPROXIMITY, USER_TOKEN 
    .PARAMETER hashlength 
        Number of bytes to consider for the hash value used in the URLHASH and DOMAINHASH load balancing methods.  
        Default value: 80  
        Minimum value = 1  
        Maximum value = 4096 
    .PARAMETER netmask 
        IPv4 subnet mask to apply to the destination IP address or source IP address when the load balancing method is DESTINATIONIPHASH or SOURCEIPHASH.  
        Minimum length = 1 
    .PARAMETER v6netmasklen 
        Number of bits to consider in an IPv6 destination or source IP address, for creating the hash that is required by the DESTINATIONIPHASH and SOURCEIPHASH load balancing methods.  
        Default value: 128  
        Minimum value = 1  
        Maximum value = 128 
    .PARAMETER backuplbmethod 
        Backup load balancing method. Becomes operational if the primary load balancing me  
        thod fails or cannot be used.  
        Valid only if the primary method is based on static proximity.  
        Default value: ROUNDROBIN  
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, CUSTOMLOAD 
    .PARAMETER cookiename 
        Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
    .PARAMETER rule 
        Expression, or name of a named expression, against which traffic is evaluated.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks.  
        Default value: "none" 
    .PARAMETER listenpolicy 
        Expression identifying traffic accepted by the virtual server. Can be either an expression (for example, CLIENT.IP.DST.IN_SUBNET(192.0.2.0/24) or the name of a named expression. In the above example, the virtual server accepts all requests whose destination IP address is in the 192.0.2.0/24 subnet.  
        Default value: "NONE" 
    .PARAMETER listenpriority 
        Integer specifying the priority of the listen policy. A higher number specifies a lower priority. If a request matches the listen policies of more than one virtual server the virtual server whose listen policy has the highest priority (the lowest priority number) accepts the request.  
        Default value: 101  
        Minimum value = 0  
        Maximum value = 101 
    .PARAMETER resrule 
        Expression specifying which part of a server's response to use for creating rule based persistence sessions (persistence type RULE). Can be either an expression or the name of a named expression.  
        Example:  
        HTTP.RES.HEADER("setcookie").VALUE(0).TYPECAST_NVLIST_T('=',';').VALUE("server1").  
        Default value: "none" 
    .PARAMETER persistmask 
        Persistence mask for IP based persistence types, for IPv4 virtual servers.  
        Minimum length = 1 
    .PARAMETER v6persistmasklen 
        Persistence mask for IP based persistence types, for IPv6 virtual servers.  
        Default value: 128  
        Minimum value = 1  
        Maximum value = 128 
    .PARAMETER pq 
        Use priority queuing on the virtual server. based persistence types, for IPv6 virtual servers.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER sc 
        Use SureConnect on the virtual server.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER rtspnat 
        Use network address translation (NAT) for RTSP data connections.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER m 
        Redirection mode for load balancing. Available settings function as follows:  
        * IP - Before forwarding a request to a server, change the destination IP address to the server's IP address.  
        * MAC - Before forwarding a request to a server, change the destination MAC address to the server's MAC address. The destination IP address is not changed. MAC-based redirection mode is used mostly in firewall load balancing deployments.  
        * IPTUNNEL - Perform IP-in-IP encapsulation for client IP packets. In the outer IP headers, set the destination IP address to the IP address of the server and the source IP address to the subnet IP (SNIP). The client IP packets are not modified. Applicable to both IPv4 and IPv6 packets.  
        * TOS - Encode the virtual server's TOS ID in the TOS field of the IP header.  
        You can use either the IPTUNNEL or the TOS option to implement Direct Server Return (DSR).  
        Default value: IP  
        Possible values = IP, MAC, IPTUNNEL, TOS 
    .PARAMETER tosid 
        TOS ID of the virtual server. Applicable only when the load balancing redirection mode is set to TOS.  
        Minimum value = 1  
        Maximum value = 63 
    .PARAMETER datalength 
        Length of the token to be extracted from the data segment of an incoming packet, for use in the token method of load balancing. The length of the token, specified in bytes, must not be greater than 24 KB. Applicable to virtual servers of type TCP.  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER dataoffset 
        Offset to be considered when extracting a token from the TCP payload. Applicable to virtual servers, of type TCP, using the token method of load balancing. Must be within the first 24 KB of the TCP payload.  
        Minimum value = 0  
        Maximum value = 25400 
    .PARAMETER sessionless 
        Perform load balancing on a per-packet basis, without establishing sessions. Recommended for load balancing of intrusion detection system (IDS) servers and scenarios involving direct server return (DSR), where session information is unnecessary.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER trofspersistence 
        When value is ENABLED, Trofs persistence is honored. When value is DISABLED, Trofs persistence is not honored.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER state 
        State of the load balancing virtual server.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER connfailover 
        Mode in which the connection failover feature must operate for the virtual server. After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary appliance. Clients remain connected to the same servers. Available settings function as follows:  
        * STATEFUL - The primary appliance shares state information with the secondary appliance, in real time, resulting in some runtime processing overhead.  
        * STATELESS - State information is not shared, and the new primary appliance tries to re-create the packet flow on the basis of the information contained in the packets it receives.  
        * DISABLED - Connection failover does not occur.  
        Default value: DISABLED  
        Possible values = DISABLED, STATEFUL, STATELESS 
    .PARAMETER redirurl 
        URL to which to redirect traffic if the virtual server becomes unavailable.  
        WARNING! Make sure that the domain in the URL does not match the domain specified for a content switching policy. If it does, requests are continuously redirected to the unavailable virtual server.  
        Minimum length = 1 
    .PARAMETER cacheable 
        Route cacheable requests to a cache redirection virtual server. The load balancing virtual server can forward requests only to a transparent cache redirection virtual server that has an IP address and port combination of *:80, so such a cache redirection virtual server must be configured on the appliance.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER clttimeout 
        Idle time, in seconds, after which a client connection is terminated.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER somethod 
        Type of threshold that, when exceeded, triggers spillover. Available settings function as follows:  
        * CONNECTION - Spillover occurs when the number of client connections exceeds the threshold.  
        * DYNAMICCONNECTION - Spillover occurs when the number of client connections at the virtual server exceeds the sum of the maximum client (Max Clients) settings for bound services. Do not specify a spillover threshold for this setting, because the threshold is implied by the Max Clients settings of bound services.  
        * BANDWIDTH - Spillover occurs when the bandwidth consumed by the virtual server's incoming and outgoing traffic exceeds the threshold.  
        * HEALTH - Spillover occurs when the percentage of weights of the services that are UP drops below the threshold. For example, if services svc1, svc2, and svc3 are bound to a virtual server, with weights 1, 2, and 3, and the spillover threshold is 50%, spillover occurs if svc1 and svc3 or svc2 and svc3 transition to DOWN.  
        * NONE - Spillover does not occur.  
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER sopersistence 
        If spillover occurs, maintain source IP address based persistence for both primary and backup virtual servers.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sopersistencetimeout 
        Timeout for spillover persistence, in minutes.  
        Default value: 2  
        Minimum value = 2  
        Maximum value = 1440 
    .PARAMETER healththreshold 
        Threshold in percent of active services below which vserver state is made down. If this threshold is 0, vserver state will be up even if one bound service is up.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER sothreshold 
        Threshold at which spillover occurs. Specify an integer for the CONNECTION spillover method, a bandwidth value in kilobits per second for the BANDWIDTH method (do not enter the units), or a percentage for the HEALTH method (do not enter the percentage symbol).  
        Minimum value = 1  
        Maximum value = 4294967287 
    .PARAMETER sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists.  
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER redirectportrewrite 
        Rewrite the port and change the protocol to ensure successful HTTP redirects from services.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER downstateflush 
        Flush all active transactions associated with a virtual server whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER backupvserver 
        Name of the backup virtual server to which to forward requests if the primary virtual server goes DOWN or reaches its spillover threshold.  
        Minimum length = 1 
    .PARAMETER disableprimaryondown 
        If the primary virtual server goes down, do not allow it to return to primary status until manually enabled.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER insertvserveripport 
        Insert an HTTP header, whose value is the IP address and port number of the virtual server, before forwarding a request to the server. The format of the header is <vipHeader>: <virtual server IP address>_<port number >, where vipHeader is the name that you specify for the header. If the virtual server has an IPv6 address, the address in the header is enclosed in brackets ([ and ]) to separate it from the port number. If you have mapped an IPv4 address to a virtual server's IPv6 address, the value of this parameter determines which IP address is inserted in the header, as follows:  
        * VIPADDR - Insert the IP address of the virtual server in the HTTP header regardless of whether the virtual server has an IPv4 address or an IPv6 address. A mapped IPv4 address, if configured, is ignored.  
        * V6TOV4MAPPING - Insert the IPv4 address that is mapped to the virtual server's IPv6 address. If a mapped IPv4 address is not configured, insert the IPv6 address.  
        * OFF - Disable header insertion.  
        Possible values = OFF, VIPADDR, V6TOV4MAPPING 
    .PARAMETER vipheader 
        Name for the inserted header. The default name is vip-header.  
        Minimum length = 1 
    .PARAMETER authenticationhost 
        Fully qualified domain name (FQDN) of the authentication virtual server to which the user must be redirected for authentication. Make sure that the Authentication parameter is set to ENABLED.  
        Minimum length = 3  
        Maximum length = 252 
    .PARAMETER authentication 
        Enable or disable user authentication.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER authn401 
        Enable or disable user authentication with HTTP 401 responses.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER authnvsname 
        Name of an authentication virtual server with which to authenticate users.  
        Minimum length = 1  
        Maximum length = 252 
    .PARAMETER push 
        Process traffic with the push virtual server that is bound to this load balancing virtual server.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER pushvserver 
        Name of the load balancing virtual server, of type PUSH or SSL_PUSH, to which the server pushes updates received on the load balancing virtual server that you are configuring.  
        Minimum length = 1 
    .PARAMETER pushlabel 
        Expression for extracting a label from the server's response. Can be either an expression or the name of a named expression.  
        Default value: "none" 
    .PARAMETER pushmulticlients 
        Allow multiple Web 2.0 connections from the same client to connect to the virtual server and expect updates.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER tcpprofilename 
        Name of the TCP profile whose settings are to be applied to the virtual server.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER httpprofilename 
        Name of the HTTP profile whose settings are to be applied to the virtual server.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER dbprofilename 
        Name of the DB profile whose settings are to be applied to the virtual server.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER comment 
        Any comments that you might want to associate with the virtual server. 
    .PARAMETER l2conn 
        Use Layer 2 parameters (channel number, MAC address, and VLAN ID) in addition to the 4-tuple (<source IP>:<source port>::<destination IP>:<destination port>) that is used to identify a connection. Allows multiple TCP and non-TCP connections with the same 4-tuple to co-exist on the Citrix ADC.  
        Possible values = ON, OFF 
    .PARAMETER oracleserverversion 
        Oracle server version.  
        Default value: 10G  
        Possible values = 10G, 11G 
    .PARAMETER mssqlserverversion 
        For a load balancing virtual server of type MSSQL, the Microsoft SQL Server version. Set this parameter if you expect some clients to run a version different from the version of the database. This setting provides compatibility between the client-side and server-side connections by ensuring that all communication conforms to the server's version.  
        Default value: 2008R2  
        Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
    .PARAMETER mysqlprotocolversion 
        MySQL protocol version that the virtual server advertises to clients. 
    .PARAMETER mysqlserverversion 
        MySQL server version string that the virtual server advertises to clients.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER mysqlcharacterset 
        Character set that the virtual server advertises to clients. 
    .PARAMETER mysqlservercapabilities 
        Server capabilities that the virtual server advertises to clients. 
    .PARAMETER appflowlog 
        Apply AppFlow logging to the virtual server.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER netprofile 
        Name of the network profile to associate with the virtual server. If you set this parameter, the virtual server uses only the IP addresses in the network profile as source IP addresses when initiating connections with servers.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER icmpvsrresponse 
        How the Citrix ADC responds to ping requests received for an IP address that is common to one or more virtual servers. Available settings function as follows:  
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always responds to the ping requests.  
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance responds to the ping requests if at least one of the virtual servers is UP. Otherwise, the appliance does not respond.  
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance responds if at least one virtual server with the ACTIVE setting is UP. Otherwise, the appliance does not respond.  
        Note: This parameter is available at the virtual server level. A similar parameter, ICMP Response, is available at the IP address level, for IPv4 addresses of type VIP. To set that parameter, use the add ip command in the CLI or the Create IP dialog box in the GUI.  
        Default value: PASSIVE  
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER rhistate 
        Route Health Injection (RHI) functionality of the NetSaler appliance for advertising the route of the VIP address associated with the virtual server. When Vserver RHI Level (RHI) parameter is set to VSVR_CNTRLD, the following are different RHI behaviors for the VIP address on the basis of RHIstate (RHI STATE) settings on the virtual servers associated with the VIP address:  
        * If you set RHI STATE to PASSIVE on all virtual servers, the Citrix ADC always advertises the route for the VIP address.  
        * If you set RHI STATE to ACTIVE on all virtual servers, the Citrix ADC advertises the route for the VIP address if at least one of the associated virtual servers is in UP state.  
        * If you set RHI STATE to ACTIVE on some and PASSIVE on others, the Citrix ADC advertises the route for the VIP address if at least one of the associated virtual servers, whose RHI STATE set to ACTIVE, is in UP state.  
        Default value: PASSIVE  
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER newservicerequest 
        Number of requests, or percentage of the load on existing services, by which to increase the load on a new service at each interval in slow-start mode. A non-zero value indicates that slow-start is applicable. A zero value indicates that the global RR startup parameter is applied. Changing the value to zero will cause services currently in slow start to take the full traffic as determined by the LB method. Subsequently, any new services added will use the global RR factor.  
        Default value: 0 
    .PARAMETER newservicerequestunit 
        Units in which to increment load at each interval in slow-start mode.  
        Default value: PER_SECOND  
        Possible values = PER_SECOND, PERCENT 
    .PARAMETER newservicerequestincrementinterval 
        Interval, in seconds, between successive increments in the load on a new service or a service whose state has just changed from DOWN to UP. A value of 0 (zero) specifies manual slow start.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 3600 
    .PARAMETER minautoscalemembers 
        Minimum number of members expected to be present when vserver is used in Autoscale.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 5000 
    .PARAMETER maxautoscalemembers 
        Maximum number of members expected to be present when vserver is used in Autoscale.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 5000 
    .PARAMETER persistavpno 
        Persist AVP number for Diameter Persistency.  
        In case this AVP is not defined in Base RFC 3588 and it is nested inside a Grouped AVP,  
        define a sequence of AVP numbers (max 3) in order of parent to child. So say persist AVP number X  
        is nested inside AVP Y which is nested in Z, then define the list as Z Y X.  
        Minimum value = 1 
    .PARAMETER skippersistency 
        This argument decides the behavior incase the service which is selected from an existing persistence session has reached threshold.  
        Default value: None  
        Possible values = Bypass, ReLb, None 
    .PARAMETER td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0.  
        Minimum value = 0  
        Maximum value = 4094 
    .PARAMETER authnprofile 
        Name of the authentication profile to be used when authentication is turned on. 
    .PARAMETER macmoderetainvlan 
        This option is used to retain vlan information of incoming packet when macmode is enabled.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dbslb 
        Enable database specific load balancing for MySQL and MSSQL service types.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dns64 
        This argument is for enabling/disabling the dns64 on lbvserver.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER bypassaaaa 
        If this option is enabled while resolving DNS64 query AAAA queries are not sent to back end dns server.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER recursionavailable 
        When set to YES, this option causes the DNS replies from this vserver to have the RA bit turned on. Typically one would set this option to YES, when the vserver is load balancing a set of DNS servers thatsupport recursive queries.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER processlocal 
        By turning on this option packets destined to a vserver in a cluster will not under go any steering. Turn this option for single packet request response mode or when the upstream device is performing a proper RSS for connection based distribution.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dnsprofilename 
        Name of the DNS profile to be associated with the VServer. DNS profile properties will be applied to the transactions processed by a VServer. This parameter is valid only for DNS and DNS-TCP VServers.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER lbprofilename 
        Name of the LB profile which is associated to the vserver. 
    .PARAMETER redirectfromport 
        Port number for the virtual server, from which we absorb the traffic for http redirect.  
        Minimum value = 1  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER httpsredirecturl 
        URL to which to redirect traffic if the traffic is recieved from redirect port. 
    .PARAMETER retainconnectionsoncluster 
        This option enables you to retain existing connections on a node joining a Cluster system or when a node is being configured for passive timeout. By default, this option is disabled.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER adfsproxyprofile 
        Name of the adfsProxy profile to be used to support ADFSPIP protocol for ADFS servers. 
    .PARAMETER tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset.  
        Minimum value = 1  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER PassThru 
        Return details about the created lbvserver item.
    .EXAMPLE
        Invoke-ADCAddLbvserver -name <string> -servicetype <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver/
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
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'DTLS', 'NNTP', 'DNS', 'DHCPRA', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'DNS_TCP', 'RTSP', 'PUSH', 'SSL_PUSH', 'RADIUS', 'RDP', 'MYSQL', 'MSSQL', 'DIAMETER', 'SSL_DIAMETER', 'TFTP', 'ORACLE', 'SMPP', 'SYSLOGTCP', 'SYSLOGUDP', 'FIX', 'SSL_FIX', 'PROXY', 'USER_TCP', 'USER_SSL_TCP', 'QUIC', 'IPFIX', 'LOGSTREAM', 'MONGO', 'MONGO_TLS')]
        [string]$servicetype ,

        [string]$ipv46 ,

        [string]$ippattern ,

        [string]$ipmask ,

        [ValidateRange(1, 65535)]
        [int]$port ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ipset ,

        [double]$range = '1' ,

        [ValidateSet('SOURCEIP', 'COOKIEINSERT', 'SSLSESSION', 'RULE', 'URLPASSIVE', 'CUSTOMSERVERID', 'DESTIP', 'SRCIPDESTIP', 'CALLID', 'RTSPSID', 'DIAMETER', 'FIXSESSION', 'USERSESSION', 'NONE')]
        [string]$persistencetype ,

        [ValidateRange(0, 1440)]
        [double]$timeout = '2' ,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$persistencebackup ,

        [ValidateRange(2, 1440)]
        [double]$backuppersistencetimeout = '2' ,

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'URLHASH', 'DOMAINHASH', 'DESTINATIONIPHASH', 'SOURCEIPHASH', 'SRCIPDESTIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'TOKEN', 'SRCIPSRCPORTHASH', 'LRTM', 'CALLIDHASH', 'CUSTOMLOAD', 'LEASTREQUEST', 'AUDITLOGHASH', 'STATICPROXIMITY', 'USER_TOKEN')]
        [string]$lbmethod = 'LEASTCONNECTION' ,

        [ValidateRange(1, 4096)]
        [double]$hashlength = '80' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$netmask ,

        [ValidateRange(1, 128)]
        [double]$v6netmasklen = '128' ,

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'SOURCEIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'CUSTOMLOAD')]
        [string]$backuplbmethod = 'ROUNDROBIN' ,

        [string]$cookiename ,

        [string]$rule = '"none"' ,

        [string]$listenpolicy = '"NONE"' ,

        [ValidateRange(0, 101)]
        [double]$listenpriority = '101' ,

        [string]$resrule = '"none"' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$persistmask ,

        [ValidateRange(1, 128)]
        [double]$v6persistmasklen = '128' ,

        [ValidateSet('ON', 'OFF')]
        [string]$pq = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$sc = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$rtspnat = 'OFF' ,

        [ValidateSet('IP', 'MAC', 'IPTUNNEL', 'TOS')]
        [string]$m = 'IP' ,

        [ValidateRange(1, 63)]
        [double]$tosid ,

        [ValidateRange(1, 100)]
        [double]$datalength ,

        [ValidateRange(0, 25400)]
        [double]$dataoffset ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessionless = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$trofspersistence = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' ,

        [ValidateSet('DISABLED', 'STATEFUL', 'STATELESS')]
        [string]$connfailover = 'DISABLED' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$redirurl ,

        [ValidateSet('YES', 'NO')]
        [string]$cacheable = 'NO' ,

        [ValidateRange(0, 31536000)]
        [double]$clttimeout ,

        [ValidateSet('CONNECTION', 'DYNAMICCONNECTION', 'BANDWIDTH', 'HEALTH', 'NONE')]
        [string]$somethod ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sopersistence = 'DISABLED' ,

        [ValidateRange(2, 1440)]
        [double]$sopersistencetimeout = '2' ,

        [ValidateRange(0, 100)]
        [double]$healththreshold = '0' ,

        [ValidateRange(1, 4294967287)]
        [double]$sothreshold ,

        [ValidateSet('DROP', 'ACCEPT', 'REDIRECT')]
        [string]$sobackupaction ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$redirectportrewrite = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$downstateflush = 'ENABLED' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$backupvserver ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$disableprimaryondown = 'DISABLED' ,

        [ValidateSet('OFF', 'VIPADDR', 'V6TOV4MAPPING')]
        [string]$insertvserveripport ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$vipheader ,

        [ValidateLength(3, 252)]
        [string]$authenticationhost ,

        [ValidateSet('ON', 'OFF')]
        [string]$authentication = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$authn401 = 'OFF' ,

        [ValidateLength(1, 252)]
        [string]$authnvsname ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$push = 'DISABLED' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$pushvserver ,

        [string]$pushlabel = '"none"' ,

        [ValidateSet('YES', 'NO')]
        [string]$pushmulticlients = 'NO' ,

        [ValidateLength(1, 127)]
        [string]$tcpprofilename ,

        [ValidateLength(1, 127)]
        [string]$httpprofilename ,

        [ValidateLength(1, 127)]
        [string]$dbprofilename ,

        [string]$comment ,

        [ValidateSet('ON', 'OFF')]
        [string]$l2conn ,

        [ValidateSet('10G', '11G')]
        [string]$oracleserverversion = '10G' ,

        [ValidateSet('70', '2000', '2000SP1', '2005', '2008', '2008R2', '2012', '2014')]
        [string]$mssqlserverversion = '2008R2' ,

        [double]$mysqlprotocolversion ,

        [ValidateLength(1, 31)]
        [string]$mysqlserverversion ,

        [double]$mysqlcharacterset ,

        [double]$mysqlservercapabilities ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowlog = 'ENABLED' ,

        [ValidateLength(1, 127)]
        [string]$netprofile ,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$icmpvsrresponse = 'PASSIVE' ,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$rhistate = 'PASSIVE' ,

        [double]$newservicerequest = '0' ,

        [ValidateSet('PER_SECOND', 'PERCENT')]
        [string]$newservicerequestunit = 'PER_SECOND' ,

        [ValidateRange(0, 3600)]
        [double]$newservicerequestincrementinterval = '0' ,

        [ValidateRange(0, 5000)]
        [double]$minautoscalemembers = '0' ,

        [ValidateRange(0, 5000)]
        [double]$maxautoscalemembers = '0' ,

        [double[]]$persistavpno ,

        [ValidateSet('Bypass', 'ReLb', 'None')]
        [string]$skippersistency = 'None' ,

        [ValidateRange(0, 4094)]
        [double]$td ,

        [string]$authnprofile ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$macmoderetainvlan = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dbslb = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dns64 ,

        [ValidateSet('YES', 'NO')]
        [string]$bypassaaaa = 'NO' ,

        [ValidateSet('YES', 'NO')]
        [string]$recursionavailable = 'NO' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$processlocal = 'DISABLED' ,

        [ValidateLength(1, 127)]
        [string]$dnsprofilename ,

        [string]$lbprofilename ,

        [ValidateRange(1, 65535)]
        [int]$redirectfromport ,

        [string]$httpsredirecturl ,

        [ValidateSet('YES', 'NO')]
        [string]$retainconnectionsoncluster = 'NO' ,

        [string]$adfsproxyprofile ,

        [ValidateRange(1, 65535)]
        [int]$tcpprobeport ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                servicetype = $servicetype
            }
            if ($PSBoundParameters.ContainsKey('ipv46')) { $Payload.Add('ipv46', $ipv46) }
            if ($PSBoundParameters.ContainsKey('ippattern')) { $Payload.Add('ippattern', $ippattern) }
            if ($PSBoundParameters.ContainsKey('ipmask')) { $Payload.Add('ipmask', $ipmask) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('ipset')) { $Payload.Add('ipset', $ipset) }
            if ($PSBoundParameters.ContainsKey('range')) { $Payload.Add('range', $range) }
            if ($PSBoundParameters.ContainsKey('persistencetype')) { $Payload.Add('persistencetype', $persistencetype) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('persistencebackup')) { $Payload.Add('persistencebackup', $persistencebackup) }
            if ($PSBoundParameters.ContainsKey('backuppersistencetimeout')) { $Payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('lbmethod')) { $Payload.Add('lbmethod', $lbmethod) }
            if ($PSBoundParameters.ContainsKey('hashlength')) { $Payload.Add('hashlength', $hashlength) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Payload.Add('netmask', $netmask) }
            if ($PSBoundParameters.ContainsKey('v6netmasklen')) { $Payload.Add('v6netmasklen', $v6netmasklen) }
            if ($PSBoundParameters.ContainsKey('backuplbmethod')) { $Payload.Add('backuplbmethod', $backuplbmethod) }
            if ($PSBoundParameters.ContainsKey('cookiename')) { $Payload.Add('cookiename', $cookiename) }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('listenpolicy')) { $Payload.Add('listenpolicy', $listenpolicy) }
            if ($PSBoundParameters.ContainsKey('listenpriority')) { $Payload.Add('listenpriority', $listenpriority) }
            if ($PSBoundParameters.ContainsKey('resrule')) { $Payload.Add('resrule', $resrule) }
            if ($PSBoundParameters.ContainsKey('persistmask')) { $Payload.Add('persistmask', $persistmask) }
            if ($PSBoundParameters.ContainsKey('v6persistmasklen')) { $Payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ($PSBoundParameters.ContainsKey('pq')) { $Payload.Add('pq', $pq) }
            if ($PSBoundParameters.ContainsKey('sc')) { $Payload.Add('sc', $sc) }
            if ($PSBoundParameters.ContainsKey('rtspnat')) { $Payload.Add('rtspnat', $rtspnat) }
            if ($PSBoundParameters.ContainsKey('m')) { $Payload.Add('m', $m) }
            if ($PSBoundParameters.ContainsKey('tosid')) { $Payload.Add('tosid', $tosid) }
            if ($PSBoundParameters.ContainsKey('datalength')) { $Payload.Add('datalength', $datalength) }
            if ($PSBoundParameters.ContainsKey('dataoffset')) { $Payload.Add('dataoffset', $dataoffset) }
            if ($PSBoundParameters.ContainsKey('sessionless')) { $Payload.Add('sessionless', $sessionless) }
            if ($PSBoundParameters.ContainsKey('trofspersistence')) { $Payload.Add('trofspersistence', $trofspersistence) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('connfailover')) { $Payload.Add('connfailover', $connfailover) }
            if ($PSBoundParameters.ContainsKey('redirurl')) { $Payload.Add('redirurl', $redirurl) }
            if ($PSBoundParameters.ContainsKey('cacheable')) { $Payload.Add('cacheable', $cacheable) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('somethod')) { $Payload.Add('somethod', $somethod) }
            if ($PSBoundParameters.ContainsKey('sopersistence')) { $Payload.Add('sopersistence', $sopersistence) }
            if ($PSBoundParameters.ContainsKey('sopersistencetimeout')) { $Payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('healththreshold')) { $Payload.Add('healththreshold', $healththreshold) }
            if ($PSBoundParameters.ContainsKey('sothreshold')) { $Payload.Add('sothreshold', $sothreshold) }
            if ($PSBoundParameters.ContainsKey('sobackupaction')) { $Payload.Add('sobackupaction', $sobackupaction) }
            if ($PSBoundParameters.ContainsKey('redirectportrewrite')) { $Payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('backupvserver')) { $Payload.Add('backupvserver', $backupvserver) }
            if ($PSBoundParameters.ContainsKey('disableprimaryondown')) { $Payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ($PSBoundParameters.ContainsKey('insertvserveripport')) { $Payload.Add('insertvserveripport', $insertvserveripport) }
            if ($PSBoundParameters.ContainsKey('vipheader')) { $Payload.Add('vipheader', $vipheader) }
            if ($PSBoundParameters.ContainsKey('authenticationhost')) { $Payload.Add('authenticationhost', $authenticationhost) }
            if ($PSBoundParameters.ContainsKey('authentication')) { $Payload.Add('authentication', $authentication) }
            if ($PSBoundParameters.ContainsKey('authn401')) { $Payload.Add('authn401', $authn401) }
            if ($PSBoundParameters.ContainsKey('authnvsname')) { $Payload.Add('authnvsname', $authnvsname) }
            if ($PSBoundParameters.ContainsKey('push')) { $Payload.Add('push', $push) }
            if ($PSBoundParameters.ContainsKey('pushvserver')) { $Payload.Add('pushvserver', $pushvserver) }
            if ($PSBoundParameters.ContainsKey('pushlabel')) { $Payload.Add('pushlabel', $pushlabel) }
            if ($PSBoundParameters.ContainsKey('pushmulticlients')) { $Payload.Add('pushmulticlients', $pushmulticlients) }
            if ($PSBoundParameters.ContainsKey('tcpprofilename')) { $Payload.Add('tcpprofilename', $tcpprofilename) }
            if ($PSBoundParameters.ContainsKey('httpprofilename')) { $Payload.Add('httpprofilename', $httpprofilename) }
            if ($PSBoundParameters.ContainsKey('dbprofilename')) { $Payload.Add('dbprofilename', $dbprofilename) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('l2conn')) { $Payload.Add('l2conn', $l2conn) }
            if ($PSBoundParameters.ContainsKey('oracleserverversion')) { $Payload.Add('oracleserverversion', $oracleserverversion) }
            if ($PSBoundParameters.ContainsKey('mssqlserverversion')) { $Payload.Add('mssqlserverversion', $mssqlserverversion) }
            if ($PSBoundParameters.ContainsKey('mysqlprotocolversion')) { $Payload.Add('mysqlprotocolversion', $mysqlprotocolversion) }
            if ($PSBoundParameters.ContainsKey('mysqlserverversion')) { $Payload.Add('mysqlserverversion', $mysqlserverversion) }
            if ($PSBoundParameters.ContainsKey('mysqlcharacterset')) { $Payload.Add('mysqlcharacterset', $mysqlcharacterset) }
            if ($PSBoundParameters.ContainsKey('mysqlservercapabilities')) { $Payload.Add('mysqlservercapabilities', $mysqlservercapabilities) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('icmpvsrresponse')) { $Payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ($PSBoundParameters.ContainsKey('rhistate')) { $Payload.Add('rhistate', $rhistate) }
            if ($PSBoundParameters.ContainsKey('newservicerequest')) { $Payload.Add('newservicerequest', $newservicerequest) }
            if ($PSBoundParameters.ContainsKey('newservicerequestunit')) { $Payload.Add('newservicerequestunit', $newservicerequestunit) }
            if ($PSBoundParameters.ContainsKey('newservicerequestincrementinterval')) { $Payload.Add('newservicerequestincrementinterval', $newservicerequestincrementinterval) }
            if ($PSBoundParameters.ContainsKey('minautoscalemembers')) { $Payload.Add('minautoscalemembers', $minautoscalemembers) }
            if ($PSBoundParameters.ContainsKey('maxautoscalemembers')) { $Payload.Add('maxautoscalemembers', $maxautoscalemembers) }
            if ($PSBoundParameters.ContainsKey('persistavpno')) { $Payload.Add('persistavpno', $persistavpno) }
            if ($PSBoundParameters.ContainsKey('skippersistency')) { $Payload.Add('skippersistency', $skippersistency) }
            if ($PSBoundParameters.ContainsKey('td')) { $Payload.Add('td', $td) }
            if ($PSBoundParameters.ContainsKey('authnprofile')) { $Payload.Add('authnprofile', $authnprofile) }
            if ($PSBoundParameters.ContainsKey('macmoderetainvlan')) { $Payload.Add('macmoderetainvlan', $macmoderetainvlan) }
            if ($PSBoundParameters.ContainsKey('dbslb')) { $Payload.Add('dbslb', $dbslb) }
            if ($PSBoundParameters.ContainsKey('dns64')) { $Payload.Add('dns64', $dns64) }
            if ($PSBoundParameters.ContainsKey('bypassaaaa')) { $Payload.Add('bypassaaaa', $bypassaaaa) }
            if ($PSBoundParameters.ContainsKey('recursionavailable')) { $Payload.Add('recursionavailable', $recursionavailable) }
            if ($PSBoundParameters.ContainsKey('processlocal')) { $Payload.Add('processlocal', $processlocal) }
            if ($PSBoundParameters.ContainsKey('dnsprofilename')) { $Payload.Add('dnsprofilename', $dnsprofilename) }
            if ($PSBoundParameters.ContainsKey('lbprofilename')) { $Payload.Add('lbprofilename', $lbprofilename) }
            if ($PSBoundParameters.ContainsKey('redirectfromport')) { $Payload.Add('redirectfromport', $redirectfromport) }
            if ($PSBoundParameters.ContainsKey('httpsredirecturl')) { $Payload.Add('httpsredirecturl', $httpsredirecturl) }
            if ($PSBoundParameters.ContainsKey('retainconnectionsoncluster')) { $Payload.Add('retainconnectionsoncluster', $retainconnectionsoncluster) }
            if ($PSBoundParameters.ContainsKey('adfsproxyprofile')) { $Payload.Add('adfsproxyprofile', $adfsproxyprofile) }
            if ($PSBoundParameters.ContainsKey('tcpprobeport')) { $Payload.Add('tcpprobeport', $tcpprobeport) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbvserver -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserver -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteLbvserver -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver/
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
        Write-Verbose "Invoke-ADCDeleteLbvserver: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver -Resource $name -Arguments $Arguments
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
        Update Load Balancing configuration Object
    .DESCRIPTION
        Update Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER ipv46 
        IPv4 or IPv6 address to assign to the virtual server. 
    .PARAMETER ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current lb vserver.  
        Minimum length = 1 
    .PARAMETER ippattern 
        IP address pattern, in dotted decimal notation, for identifying packets to be accepted by the virtual server. The IP Mask parameter specifies which part of the destination IP address is matched against the pattern. Mutually exclusive with the IP Address parameter.  
        For example, if the IP pattern assigned to the virtual server is 198.51.100.0 and the IP mask is 255.255.240.0 (a forward mask), the first 20 bits in the destination IP addresses are matched with the first 20 bits in the pattern. The virtual server accepts requests with IP addresses that range from 198.51.96.1 to 198.51.111.254. You can also use a pattern such as 0.0.2.2 and a mask such as 0.0.255.255 (a reverse mask).  
        If a destination IP address matches more than one IP pattern, the pattern with the longest match is selected, and the associated virtual server processes the request. For example, if virtual servers vs1 and vs2 have the same IP pattern, 0.0.100.128, but different IP masks of 0.0.255.255 and 0.0.224.255, a destination IP address of 198.51.100.128 has the longest match with the IP pattern of vs1. If a destination IP address matches two or more virtual servers to the same extent, the request is processed by the virtual server whose port number matches the port number in the request. 
    .PARAMETER ipmask 
        IP mask, in dotted decimal notation, for the IP Pattern parameter. Can have leading or trailing non-zero octets (for example, 255.255.240.0 or 0.0.255.255). Accordingly, the mask specifies whether the first n bits or the last n bits of the destination IP address in a client request are to be matched with the corresponding bits in the IP pattern. The former is called a forward mask. The latter is called a reverse mask. 
    .PARAMETER weight 
        Weight to assign to the specified service.  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER servicename 
        Service to bind to the virtual server.  
        Minimum length = 1 
    .PARAMETER persistencetype 
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
    .PARAMETER timeout 
        Time period for which a persistence session is in effect.  
        Default value: 2  
        Minimum value = 0  
        Maximum value = 1440 
    .PARAMETER persistencebackup 
        Backup persistence type for the virtual server. Becomes operational if the primary persistence mechanism fails.  
        Possible values = SOURCEIP, NONE 
    .PARAMETER backuppersistencetimeout 
        Time period for which backup persistence is in effect.  
        Default value: 2  
        Minimum value = 2  
        Maximum value = 1440 
    .PARAMETER lbmethod 
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
        Default value: LEASTCONNECTION  
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, URLHASH, DOMAINHASH, DESTINATIONIPHASH, SOURCEIPHASH, SRCIPDESTIPHASH, LEASTBANDWIDTH, LEASTPACKETS, TOKEN, SRCIPSRCPORTHASH, LRTM, CALLIDHASH, CUSTOMLOAD, LEASTREQUEST, AUDITLOGHASH, STATICPROXIMITY, USER_TOKEN 
    .PARAMETER hashlength 
        Number of bytes to consider for the hash value used in the URLHASH and DOMAINHASH load balancing methods.  
        Default value: 80  
        Minimum value = 1  
        Maximum value = 4096 
    .PARAMETER netmask 
        IPv4 subnet mask to apply to the destination IP address or source IP address when the load balancing method is DESTINATIONIPHASH or SOURCEIPHASH.  
        Minimum length = 1 
    .PARAMETER v6netmasklen 
        Number of bits to consider in an IPv6 destination or source IP address, for creating the hash that is required by the DESTINATIONIPHASH and SOURCEIPHASH load balancing methods.  
        Default value: 128  
        Minimum value = 1  
        Maximum value = 128 
    .PARAMETER backuplbmethod 
        Backup load balancing method. Becomes operational if the primary load balancing me  
        thod fails or cannot be used.  
        Valid only if the primary method is based on static proximity.  
        Default value: ROUNDROBIN  
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, CUSTOMLOAD 
    .PARAMETER rule 
        Expression, or name of a named expression, against which traffic is evaluated.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks.  
        Default value: "none" 
    .PARAMETER cookiename 
        Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
    .PARAMETER resrule 
        Expression specifying which part of a server's response to use for creating rule based persistence sessions (persistence type RULE). Can be either an expression or the name of a named expression.  
        Example:  
        HTTP.RES.HEADER("setcookie").VALUE(0).TYPECAST_NVLIST_T('=',';').VALUE("server1").  
        Default value: "none" 
    .PARAMETER persistmask 
        Persistence mask for IP based persistence types, for IPv4 virtual servers.  
        Minimum length = 1 
    .PARAMETER v6persistmasklen 
        Persistence mask for IP based persistence types, for IPv6 virtual servers.  
        Default value: 128  
        Minimum value = 1  
        Maximum value = 128 
    .PARAMETER pq 
        Use priority queuing on the virtual server. based persistence types, for IPv6 virtual servers.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER sc 
        Use SureConnect on the virtual server.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER rtspnat 
        Use network address translation (NAT) for RTSP data connections.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER m 
        Redirection mode for load balancing. Available settings function as follows:  
        * IP - Before forwarding a request to a server, change the destination IP address to the server's IP address.  
        * MAC - Before forwarding a request to a server, change the destination MAC address to the server's MAC address. The destination IP address is not changed. MAC-based redirection mode is used mostly in firewall load balancing deployments.  
        * IPTUNNEL - Perform IP-in-IP encapsulation for client IP packets. In the outer IP headers, set the destination IP address to the IP address of the server and the source IP address to the subnet IP (SNIP). The client IP packets are not modified. Applicable to both IPv4 and IPv6 packets.  
        * TOS - Encode the virtual server's TOS ID in the TOS field of the IP header.  
        You can use either the IPTUNNEL or the TOS option to implement Direct Server Return (DSR).  
        Default value: IP  
        Possible values = IP, MAC, IPTUNNEL, TOS 
    .PARAMETER tosid 
        TOS ID of the virtual server. Applicable only when the load balancing redirection mode is set to TOS.  
        Minimum value = 1  
        Maximum value = 63 
    .PARAMETER datalength 
        Length of the token to be extracted from the data segment of an incoming packet, for use in the token method of load balancing. The length of the token, specified in bytes, must not be greater than 24 KB. Applicable to virtual servers of type TCP.  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER dataoffset 
        Offset to be considered when extracting a token from the TCP payload. Applicable to virtual servers, of type TCP, using the token method of load balancing. Must be within the first 24 KB of the TCP payload.  
        Minimum value = 0  
        Maximum value = 25400 
    .PARAMETER sessionless 
        Perform load balancing on a per-packet basis, without establishing sessions. Recommended for load balancing of intrusion detection system (IDS) servers and scenarios involving direct server return (DSR), where session information is unnecessary.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER trofspersistence 
        When value is ENABLED, Trofs persistence is honored. When value is DISABLED, Trofs persistence is not honored.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER connfailover 
        Mode in which the connection failover feature must operate for the virtual server. After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary appliance. Clients remain connected to the same servers. Available settings function as follows:  
        * STATEFUL - The primary appliance shares state information with the secondary appliance, in real time, resulting in some runtime processing overhead.  
        * STATELESS - State information is not shared, and the new primary appliance tries to re-create the packet flow on the basis of the information contained in the packets it receives.  
        * DISABLED - Connection failover does not occur.  
        Default value: DISABLED  
        Possible values = DISABLED, STATEFUL, STATELESS 
    .PARAMETER backupvserver 
        Name of the backup virtual server to which to forward requests if the primary virtual server goes DOWN or reaches its spillover threshold.  
        Minimum length = 1 
    .PARAMETER redirurl 
        URL to which to redirect traffic if the virtual server becomes unavailable.  
        WARNING! Make sure that the domain in the URL does not match the domain specified for a content switching policy. If it does, requests are continuously redirected to the unavailable virtual server.  
        Minimum length = 1 
    .PARAMETER cacheable 
        Route cacheable requests to a cache redirection virtual server. The load balancing virtual server can forward requests only to a transparent cache redirection virtual server that has an IP address and port combination of *:80, so such a cache redirection virtual server must be configured on the appliance.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER clttimeout 
        Idle time, in seconds, after which a client connection is terminated.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER somethod 
        Type of threshold that, when exceeded, triggers spillover. Available settings function as follows:  
        * CONNECTION - Spillover occurs when the number of client connections exceeds the threshold.  
        * DYNAMICCONNECTION - Spillover occurs when the number of client connections at the virtual server exceeds the sum of the maximum client (Max Clients) settings for bound services. Do not specify a spillover threshold for this setting, because the threshold is implied by the Max Clients settings of bound services.  
        * BANDWIDTH - Spillover occurs when the bandwidth consumed by the virtual server's incoming and outgoing traffic exceeds the threshold.  
        * HEALTH - Spillover occurs when the percentage of weights of the services that are UP drops below the threshold. For example, if services svc1, svc2, and svc3 are bound to a virtual server, with weights 1, 2, and 3, and the spillover threshold is 50%, spillover occurs if svc1 and svc3 or svc2 and svc3 transition to DOWN.  
        * NONE - Spillover does not occur.  
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER sothreshold 
        Threshold at which spillover occurs. Specify an integer for the CONNECTION spillover method, a bandwidth value in kilobits per second for the BANDWIDTH method (do not enter the units), or a percentage for the HEALTH method (do not enter the percentage symbol).  
        Minimum value = 1  
        Maximum value = 4294967287 
    .PARAMETER sopersistence 
        If spillover occurs, maintain source IP address based persistence for both primary and backup virtual servers.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sopersistencetimeout 
        Timeout for spillover persistence, in minutes.  
        Default value: 2  
        Minimum value = 2  
        Maximum value = 1440 
    .PARAMETER healththreshold 
        Threshold in percent of active services below which vserver state is made down. If this threshold is 0, vserver state will be up even if one bound service is up.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists.  
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER redirectportrewrite 
        Rewrite the port and change the protocol to ensure successful HTTP redirects from services.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER downstateflush 
        Flush all active transactions associated with a virtual server whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER insertvserveripport 
        Insert an HTTP header, whose value is the IP address and port number of the virtual server, before forwarding a request to the server. The format of the header is <vipHeader>: <virtual server IP address>_<port number >, where vipHeader is the name that you specify for the header. If the virtual server has an IPv6 address, the address in the header is enclosed in brackets ([ and ]) to separate it from the port number. If you have mapped an IPv4 address to a virtual server's IPv6 address, the value of this parameter determines which IP address is inserted in the header, as follows:  
        * VIPADDR - Insert the IP address of the virtual server in the HTTP header regardless of whether the virtual server has an IPv4 address or an IPv6 address. A mapped IPv4 address, if configured, is ignored.  
        * V6TOV4MAPPING - Insert the IPv4 address that is mapped to the virtual server's IPv6 address. If a mapped IPv4 address is not configured, insert the IPv6 address.  
        * OFF - Disable header insertion.  
        Possible values = OFF, VIPADDR, V6TOV4MAPPING 
    .PARAMETER vipheader 
        Name for the inserted header. The default name is vip-header.  
        Minimum length = 1 
    .PARAMETER disableprimaryondown 
        If the primary virtual server goes down, do not allow it to return to primary status until manually enabled.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER authenticationhost 
        Fully qualified domain name (FQDN) of the authentication virtual server to which the user must be redirected for authentication. Make sure that the Authentication parameter is set to ENABLED.  
        Minimum length = 3  
        Maximum length = 252 
    .PARAMETER authentication 
        Enable or disable user authentication.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER authn401 
        Enable or disable user authentication with HTTP 401 responses.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER authnvsname 
        Name of an authentication virtual server with which to authenticate users.  
        Minimum length = 1  
        Maximum length = 252 
    .PARAMETER push 
        Process traffic with the push virtual server that is bound to this load balancing virtual server.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER pushvserver 
        Name of the load balancing virtual server, of type PUSH or SSL_PUSH, to which the server pushes updates received on the load balancing virtual server that you are configuring.  
        Minimum length = 1 
    .PARAMETER pushlabel 
        Expression for extracting a label from the server's response. Can be either an expression or the name of a named expression.  
        Default value: "none" 
    .PARAMETER pushmulticlients 
        Allow multiple Web 2.0 connections from the same client to connect to the virtual server and expect updates.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER listenpolicy 
        Expression identifying traffic accepted by the virtual server. Can be either an expression (for example, CLIENT.IP.DST.IN_SUBNET(192.0.2.0/24) or the name of a named expression. In the above example, the virtual server accepts all requests whose destination IP address is in the 192.0.2.0/24 subnet.  
        Default value: "NONE" 
    .PARAMETER listenpriority 
        Integer specifying the priority of the listen policy. A higher number specifies a lower priority. If a request matches the listen policies of more than one virtual server the virtual server whose listen policy has the highest priority (the lowest priority number) accepts the request.  
        Default value: 101  
        Minimum value = 0  
        Maximum value = 101 
    .PARAMETER tcpprofilename 
        Name of the TCP profile whose settings are to be applied to the virtual server.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER httpprofilename 
        Name of the HTTP profile whose settings are to be applied to the virtual server.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER dbprofilename 
        Name of the DB profile whose settings are to be applied to the virtual server.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER comment 
        Any comments that you might want to associate with the virtual server. 
    .PARAMETER l2conn 
        Use Layer 2 parameters (channel number, MAC address, and VLAN ID) in addition to the 4-tuple (<source IP>:<source port>::<destination IP>:<destination port>) that is used to identify a connection. Allows multiple TCP and non-TCP connections with the same 4-tuple to co-exist on the Citrix ADC.  
        Possible values = ON, OFF 
    .PARAMETER oracleserverversion 
        Oracle server version.  
        Default value: 10G  
        Possible values = 10G, 11G 
    .PARAMETER mssqlserverversion 
        For a load balancing virtual server of type MSSQL, the Microsoft SQL Server version. Set this parameter if you expect some clients to run a version different from the version of the database. This setting provides compatibility between the client-side and server-side connections by ensuring that all communication conforms to the server's version.  
        Default value: 2008R2  
        Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
    .PARAMETER mysqlprotocolversion 
        MySQL protocol version that the virtual server advertises to clients. 
    .PARAMETER mysqlserverversion 
        MySQL server version string that the virtual server advertises to clients.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER mysqlcharacterset 
        Character set that the virtual server advertises to clients. 
    .PARAMETER mysqlservercapabilities 
        Server capabilities that the virtual server advertises to clients. 
    .PARAMETER appflowlog 
        Apply AppFlow logging to the virtual server.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER netprofile 
        Name of the network profile to associate with the virtual server. If you set this parameter, the virtual server uses only the IP addresses in the network profile as source IP addresses when initiating connections with servers.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER icmpvsrresponse 
        How the Citrix ADC responds to ping requests received for an IP address that is common to one or more virtual servers. Available settings function as follows:  
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always responds to the ping requests.  
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance responds to the ping requests if at least one of the virtual servers is UP. Otherwise, the appliance does not respond.  
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance responds if at least one virtual server with the ACTIVE setting is UP. Otherwise, the appliance does not respond.  
        Note: This parameter is available at the virtual server level. A similar parameter, ICMP Response, is available at the IP address level, for IPv4 addresses of type VIP. To set that parameter, use the add ip command in the CLI or the Create IP dialog box in the GUI.  
        Default value: PASSIVE  
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER rhistate 
        Route Health Injection (RHI) functionality of the NetSaler appliance for advertising the route of the VIP address associated with the virtual server. When Vserver RHI Level (RHI) parameter is set to VSVR_CNTRLD, the following are different RHI behaviors for the VIP address on the basis of RHIstate (RHI STATE) settings on the virtual servers associated with the VIP address:  
        * If you set RHI STATE to PASSIVE on all virtual servers, the Citrix ADC always advertises the route for the VIP address.  
        * If you set RHI STATE to ACTIVE on all virtual servers, the Citrix ADC advertises the route for the VIP address if at least one of the associated virtual servers is in UP state.  
        * If you set RHI STATE to ACTIVE on some and PASSIVE on others, the Citrix ADC advertises the route for the VIP address if at least one of the associated virtual servers, whose RHI STATE set to ACTIVE, is in UP state.  
        Default value: PASSIVE  
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER newservicerequest 
        Number of requests, or percentage of the load on existing services, by which to increase the load on a new service at each interval in slow-start mode. A non-zero value indicates that slow-start is applicable. A zero value indicates that the global RR startup parameter is applied. Changing the value to zero will cause services currently in slow start to take the full traffic as determined by the LB method. Subsequently, any new services added will use the global RR factor.  
        Default value: 0 
    .PARAMETER newservicerequestunit 
        Units in which to increment load at each interval in slow-start mode.  
        Default value: PER_SECOND  
        Possible values = PER_SECOND, PERCENT 
    .PARAMETER newservicerequestincrementinterval 
        Interval, in seconds, between successive increments in the load on a new service or a service whose state has just changed from DOWN to UP. A value of 0 (zero) specifies manual slow start.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 3600 
    .PARAMETER minautoscalemembers 
        Minimum number of members expected to be present when vserver is used in Autoscale.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 5000 
    .PARAMETER maxautoscalemembers 
        Maximum number of members expected to be present when vserver is used in Autoscale.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 5000 
    .PARAMETER persistavpno 
        Persist AVP number for Diameter Persistency.  
        In case this AVP is not defined in Base RFC 3588 and it is nested inside a Grouped AVP,  
        define a sequence of AVP numbers (max 3) in order of parent to child. So say persist AVP number X  
        is nested inside AVP Y which is nested in Z, then define the list as Z Y X.  
        Minimum value = 1 
    .PARAMETER skippersistency 
        This argument decides the behavior incase the service which is selected from an existing persistence session has reached threshold.  
        Default value: None  
        Possible values = Bypass, ReLb, None 
    .PARAMETER authnprofile 
        Name of the authentication profile to be used when authentication is turned on. 
    .PARAMETER macmoderetainvlan 
        This option is used to retain vlan information of incoming packet when macmode is enabled.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dbslb 
        Enable database specific load balancing for MySQL and MSSQL service types.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dns64 
        This argument is for enabling/disabling the dns64 on lbvserver.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER bypassaaaa 
        If this option is enabled while resolving DNS64 query AAAA queries are not sent to back end dns server.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER recursionavailable 
        When set to YES, this option causes the DNS replies from this vserver to have the RA bit turned on. Typically one would set this option to YES, when the vserver is load balancing a set of DNS servers thatsupport recursive queries.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER processlocal 
        By turning on this option packets destined to a vserver in a cluster will not under go any steering. Turn this option for single packet request response mode or when the upstream device is performing a proper RSS for connection based distribution.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dnsprofilename 
        Name of the DNS profile to be associated with the VServer. DNS profile properties will be applied to the transactions processed by a VServer. This parameter is valid only for DNS and DNS-TCP VServers.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER lbprofilename 
        Name of the LB profile which is associated to the vserver. 
    .PARAMETER redirectfromport 
        Port number for the virtual server, from which we absorb the traffic for http redirect.  
        Minimum value = 1  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER httpsredirecturl 
        URL to which to redirect traffic if the traffic is recieved from redirect port. 
    .PARAMETER retainconnectionsoncluster 
        This option enables you to retain existing connections on a node joining a Cluster system or when a node is being configured for passive timeout. By default, this option is disabled.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER adfsproxyprofile 
        Name of the adfsProxy profile to be used to support ADFSPIP protocol for ADFS servers. 
    .PARAMETER tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset.  
        Minimum value = 1  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER PassThru 
        Return details about the created lbvserver item.
    .EXAMPLE
        Invoke-ADCUpdateLbvserver -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateLbvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver/
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

        [string]$ipv46 ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ipset ,

        [string]$ippattern ,

        [string]$ipmask ,

        [ValidateRange(1, 100)]
        [double]$weight ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servicename ,

        [ValidateSet('SOURCEIP', 'COOKIEINSERT', 'SSLSESSION', 'RULE', 'URLPASSIVE', 'CUSTOMSERVERID', 'DESTIP', 'SRCIPDESTIP', 'CALLID', 'RTSPSID', 'DIAMETER', 'FIXSESSION', 'USERSESSION', 'NONE')]
        [string]$persistencetype ,

        [ValidateRange(0, 1440)]
        [double]$timeout ,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$persistencebackup ,

        [ValidateRange(2, 1440)]
        [double]$backuppersistencetimeout ,

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'URLHASH', 'DOMAINHASH', 'DESTINATIONIPHASH', 'SOURCEIPHASH', 'SRCIPDESTIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'TOKEN', 'SRCIPSRCPORTHASH', 'LRTM', 'CALLIDHASH', 'CUSTOMLOAD', 'LEASTREQUEST', 'AUDITLOGHASH', 'STATICPROXIMITY', 'USER_TOKEN')]
        [string]$lbmethod ,

        [ValidateRange(1, 4096)]
        [double]$hashlength ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$netmask ,

        [ValidateRange(1, 128)]
        [double]$v6netmasklen ,

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'SOURCEIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'CUSTOMLOAD')]
        [string]$backuplbmethod ,

        [string]$rule ,

        [string]$cookiename ,

        [string]$resrule ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$persistmask ,

        [ValidateRange(1, 128)]
        [double]$v6persistmasklen ,

        [ValidateSet('ON', 'OFF')]
        [string]$pq ,

        [ValidateSet('ON', 'OFF')]
        [string]$sc ,

        [ValidateSet('ON', 'OFF')]
        [string]$rtspnat ,

        [ValidateSet('IP', 'MAC', 'IPTUNNEL', 'TOS')]
        [string]$m ,

        [ValidateRange(1, 63)]
        [double]$tosid ,

        [ValidateRange(1, 100)]
        [double]$datalength ,

        [ValidateRange(0, 25400)]
        [double]$dataoffset ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessionless ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$trofspersistence ,

        [ValidateSet('DISABLED', 'STATEFUL', 'STATELESS')]
        [string]$connfailover ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$backupvserver ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$redirurl ,

        [ValidateSet('YES', 'NO')]
        [string]$cacheable ,

        [ValidateRange(0, 31536000)]
        [double]$clttimeout ,

        [ValidateSet('CONNECTION', 'DYNAMICCONNECTION', 'BANDWIDTH', 'HEALTH', 'NONE')]
        [string]$somethod ,

        [ValidateRange(1, 4294967287)]
        [double]$sothreshold ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sopersistence ,

        [ValidateRange(2, 1440)]
        [double]$sopersistencetimeout ,

        [ValidateRange(0, 100)]
        [double]$healththreshold ,

        [ValidateSet('DROP', 'ACCEPT', 'REDIRECT')]
        [string]$sobackupaction ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$redirectportrewrite ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$downstateflush ,

        [ValidateSet('OFF', 'VIPADDR', 'V6TOV4MAPPING')]
        [string]$insertvserveripport ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$vipheader ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$disableprimaryondown ,

        [ValidateLength(3, 252)]
        [string]$authenticationhost ,

        [ValidateSet('ON', 'OFF')]
        [string]$authentication ,

        [ValidateSet('ON', 'OFF')]
        [string]$authn401 ,

        [ValidateLength(1, 252)]
        [string]$authnvsname ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$push ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$pushvserver ,

        [string]$pushlabel ,

        [ValidateSet('YES', 'NO')]
        [string]$pushmulticlients ,

        [string]$listenpolicy ,

        [ValidateRange(0, 101)]
        [double]$listenpriority ,

        [ValidateLength(1, 127)]
        [string]$tcpprofilename ,

        [ValidateLength(1, 127)]
        [string]$httpprofilename ,

        [ValidateLength(1, 127)]
        [string]$dbprofilename ,

        [string]$comment ,

        [ValidateSet('ON', 'OFF')]
        [string]$l2conn ,

        [ValidateSet('10G', '11G')]
        [string]$oracleserverversion ,

        [ValidateSet('70', '2000', '2000SP1', '2005', '2008', '2008R2', '2012', '2014')]
        [string]$mssqlserverversion ,

        [double]$mysqlprotocolversion ,

        [ValidateLength(1, 31)]
        [string]$mysqlserverversion ,

        [double]$mysqlcharacterset ,

        [double]$mysqlservercapabilities ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowlog ,

        [ValidateLength(1, 127)]
        [string]$netprofile ,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$icmpvsrresponse ,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$rhistate ,

        [double]$newservicerequest ,

        [ValidateSet('PER_SECOND', 'PERCENT')]
        [string]$newservicerequestunit ,

        [ValidateRange(0, 3600)]
        [double]$newservicerequestincrementinterval ,

        [ValidateRange(0, 5000)]
        [double]$minautoscalemembers ,

        [ValidateRange(0, 5000)]
        [double]$maxautoscalemembers ,

        [double[]]$persistavpno ,

        [ValidateSet('Bypass', 'ReLb', 'None')]
        [string]$skippersistency ,

        [string]$authnprofile ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$macmoderetainvlan ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dbslb ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dns64 ,

        [ValidateSet('YES', 'NO')]
        [string]$bypassaaaa ,

        [ValidateSet('YES', 'NO')]
        [string]$recursionavailable ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$processlocal ,

        [ValidateLength(1, 127)]
        [string]$dnsprofilename ,

        [string]$lbprofilename ,

        [ValidateRange(1, 65535)]
        [int]$redirectfromport ,

        [string]$httpsredirecturl ,

        [ValidateSet('YES', 'NO')]
        [string]$retainconnectionsoncluster ,

        [string]$adfsproxyprofile ,

        [ValidateRange(1, 65535)]
        [int]$tcpprobeport ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLbvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ipv46')) { $Payload.Add('ipv46', $ipv46) }
            if ($PSBoundParameters.ContainsKey('ipset')) { $Payload.Add('ipset', $ipset) }
            if ($PSBoundParameters.ContainsKey('ippattern')) { $Payload.Add('ippattern', $ippattern) }
            if ($PSBoundParameters.ContainsKey('ipmask')) { $Payload.Add('ipmask', $ipmask) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('servicename')) { $Payload.Add('servicename', $servicename) }
            if ($PSBoundParameters.ContainsKey('persistencetype')) { $Payload.Add('persistencetype', $persistencetype) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('persistencebackup')) { $Payload.Add('persistencebackup', $persistencebackup) }
            if ($PSBoundParameters.ContainsKey('backuppersistencetimeout')) { $Payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('lbmethod')) { $Payload.Add('lbmethod', $lbmethod) }
            if ($PSBoundParameters.ContainsKey('hashlength')) { $Payload.Add('hashlength', $hashlength) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Payload.Add('netmask', $netmask) }
            if ($PSBoundParameters.ContainsKey('v6netmasklen')) { $Payload.Add('v6netmasklen', $v6netmasklen) }
            if ($PSBoundParameters.ContainsKey('backuplbmethod')) { $Payload.Add('backuplbmethod', $backuplbmethod) }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('cookiename')) { $Payload.Add('cookiename', $cookiename) }
            if ($PSBoundParameters.ContainsKey('resrule')) { $Payload.Add('resrule', $resrule) }
            if ($PSBoundParameters.ContainsKey('persistmask')) { $Payload.Add('persistmask', $persistmask) }
            if ($PSBoundParameters.ContainsKey('v6persistmasklen')) { $Payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ($PSBoundParameters.ContainsKey('pq')) { $Payload.Add('pq', $pq) }
            if ($PSBoundParameters.ContainsKey('sc')) { $Payload.Add('sc', $sc) }
            if ($PSBoundParameters.ContainsKey('rtspnat')) { $Payload.Add('rtspnat', $rtspnat) }
            if ($PSBoundParameters.ContainsKey('m')) { $Payload.Add('m', $m) }
            if ($PSBoundParameters.ContainsKey('tosid')) { $Payload.Add('tosid', $tosid) }
            if ($PSBoundParameters.ContainsKey('datalength')) { $Payload.Add('datalength', $datalength) }
            if ($PSBoundParameters.ContainsKey('dataoffset')) { $Payload.Add('dataoffset', $dataoffset) }
            if ($PSBoundParameters.ContainsKey('sessionless')) { $Payload.Add('sessionless', $sessionless) }
            if ($PSBoundParameters.ContainsKey('trofspersistence')) { $Payload.Add('trofspersistence', $trofspersistence) }
            if ($PSBoundParameters.ContainsKey('connfailover')) { $Payload.Add('connfailover', $connfailover) }
            if ($PSBoundParameters.ContainsKey('backupvserver')) { $Payload.Add('backupvserver', $backupvserver) }
            if ($PSBoundParameters.ContainsKey('redirurl')) { $Payload.Add('redirurl', $redirurl) }
            if ($PSBoundParameters.ContainsKey('cacheable')) { $Payload.Add('cacheable', $cacheable) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('somethod')) { $Payload.Add('somethod', $somethod) }
            if ($PSBoundParameters.ContainsKey('sothreshold')) { $Payload.Add('sothreshold', $sothreshold) }
            if ($PSBoundParameters.ContainsKey('sopersistence')) { $Payload.Add('sopersistence', $sopersistence) }
            if ($PSBoundParameters.ContainsKey('sopersistencetimeout')) { $Payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('healththreshold')) { $Payload.Add('healththreshold', $healththreshold) }
            if ($PSBoundParameters.ContainsKey('sobackupaction')) { $Payload.Add('sobackupaction', $sobackupaction) }
            if ($PSBoundParameters.ContainsKey('redirectportrewrite')) { $Payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('insertvserveripport')) { $Payload.Add('insertvserveripport', $insertvserveripport) }
            if ($PSBoundParameters.ContainsKey('vipheader')) { $Payload.Add('vipheader', $vipheader) }
            if ($PSBoundParameters.ContainsKey('disableprimaryondown')) { $Payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ($PSBoundParameters.ContainsKey('authenticationhost')) { $Payload.Add('authenticationhost', $authenticationhost) }
            if ($PSBoundParameters.ContainsKey('authentication')) { $Payload.Add('authentication', $authentication) }
            if ($PSBoundParameters.ContainsKey('authn401')) { $Payload.Add('authn401', $authn401) }
            if ($PSBoundParameters.ContainsKey('authnvsname')) { $Payload.Add('authnvsname', $authnvsname) }
            if ($PSBoundParameters.ContainsKey('push')) { $Payload.Add('push', $push) }
            if ($PSBoundParameters.ContainsKey('pushvserver')) { $Payload.Add('pushvserver', $pushvserver) }
            if ($PSBoundParameters.ContainsKey('pushlabel')) { $Payload.Add('pushlabel', $pushlabel) }
            if ($PSBoundParameters.ContainsKey('pushmulticlients')) { $Payload.Add('pushmulticlients', $pushmulticlients) }
            if ($PSBoundParameters.ContainsKey('listenpolicy')) { $Payload.Add('listenpolicy', $listenpolicy) }
            if ($PSBoundParameters.ContainsKey('listenpriority')) { $Payload.Add('listenpriority', $listenpriority) }
            if ($PSBoundParameters.ContainsKey('tcpprofilename')) { $Payload.Add('tcpprofilename', $tcpprofilename) }
            if ($PSBoundParameters.ContainsKey('httpprofilename')) { $Payload.Add('httpprofilename', $httpprofilename) }
            if ($PSBoundParameters.ContainsKey('dbprofilename')) { $Payload.Add('dbprofilename', $dbprofilename) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('l2conn')) { $Payload.Add('l2conn', $l2conn) }
            if ($PSBoundParameters.ContainsKey('oracleserverversion')) { $Payload.Add('oracleserverversion', $oracleserverversion) }
            if ($PSBoundParameters.ContainsKey('mssqlserverversion')) { $Payload.Add('mssqlserverversion', $mssqlserverversion) }
            if ($PSBoundParameters.ContainsKey('mysqlprotocolversion')) { $Payload.Add('mysqlprotocolversion', $mysqlprotocolversion) }
            if ($PSBoundParameters.ContainsKey('mysqlserverversion')) { $Payload.Add('mysqlserverversion', $mysqlserverversion) }
            if ($PSBoundParameters.ContainsKey('mysqlcharacterset')) { $Payload.Add('mysqlcharacterset', $mysqlcharacterset) }
            if ($PSBoundParameters.ContainsKey('mysqlservercapabilities')) { $Payload.Add('mysqlservercapabilities', $mysqlservercapabilities) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('icmpvsrresponse')) { $Payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ($PSBoundParameters.ContainsKey('rhistate')) { $Payload.Add('rhistate', $rhistate) }
            if ($PSBoundParameters.ContainsKey('newservicerequest')) { $Payload.Add('newservicerequest', $newservicerequest) }
            if ($PSBoundParameters.ContainsKey('newservicerequestunit')) { $Payload.Add('newservicerequestunit', $newservicerequestunit) }
            if ($PSBoundParameters.ContainsKey('newservicerequestincrementinterval')) { $Payload.Add('newservicerequestincrementinterval', $newservicerequestincrementinterval) }
            if ($PSBoundParameters.ContainsKey('minautoscalemembers')) { $Payload.Add('minautoscalemembers', $minautoscalemembers) }
            if ($PSBoundParameters.ContainsKey('maxautoscalemembers')) { $Payload.Add('maxautoscalemembers', $maxautoscalemembers) }
            if ($PSBoundParameters.ContainsKey('persistavpno')) { $Payload.Add('persistavpno', $persistavpno) }
            if ($PSBoundParameters.ContainsKey('skippersistency')) { $Payload.Add('skippersistency', $skippersistency) }
            if ($PSBoundParameters.ContainsKey('authnprofile')) { $Payload.Add('authnprofile', $authnprofile) }
            if ($PSBoundParameters.ContainsKey('macmoderetainvlan')) { $Payload.Add('macmoderetainvlan', $macmoderetainvlan) }
            if ($PSBoundParameters.ContainsKey('dbslb')) { $Payload.Add('dbslb', $dbslb) }
            if ($PSBoundParameters.ContainsKey('dns64')) { $Payload.Add('dns64', $dns64) }
            if ($PSBoundParameters.ContainsKey('bypassaaaa')) { $Payload.Add('bypassaaaa', $bypassaaaa) }
            if ($PSBoundParameters.ContainsKey('recursionavailable')) { $Payload.Add('recursionavailable', $recursionavailable) }
            if ($PSBoundParameters.ContainsKey('processlocal')) { $Payload.Add('processlocal', $processlocal) }
            if ($PSBoundParameters.ContainsKey('dnsprofilename')) { $Payload.Add('dnsprofilename', $dnsprofilename) }
            if ($PSBoundParameters.ContainsKey('lbprofilename')) { $Payload.Add('lbprofilename', $lbprofilename) }
            if ($PSBoundParameters.ContainsKey('redirectfromport')) { $Payload.Add('redirectfromport', $redirectfromport) }
            if ($PSBoundParameters.ContainsKey('httpsredirecturl')) { $Payload.Add('httpsredirecturl', $httpsredirecturl) }
            if ($PSBoundParameters.ContainsKey('retainconnectionsoncluster')) { $Payload.Add('retainconnectionsoncluster', $retainconnectionsoncluster) }
            if ($PSBoundParameters.ContainsKey('adfsproxyprofile')) { $Payload.Add('adfsproxyprofile', $adfsproxyprofile) }
            if ($PSBoundParameters.ContainsKey('tcpprobeport')) { $Payload.Add('tcpprobeport', $tcpprobeport) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver", "Update Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserver -Filter $Payload)
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
        Unset Load Balancing configuration Object
    .DESCRIPTION
        Unset Load Balancing configuration Object 
   .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
   .PARAMETER backupvserver 
       Name of the backup virtual server to which to forward requests if the primary virtual server goes DOWN or reaches its spillover threshold. 
   .PARAMETER clttimeout 
       Idle time, in seconds, after which a client connection is terminated. 
   .PARAMETER redirurl 
       URL to which to redirect traffic if the virtual server becomes unavailable.  
       WARNING! Make sure that the domain in the URL does not match the domain specified for a content switching policy. If it does, requests are continuously redirected to the unavailable virtual server. 
   .PARAMETER redirurlflags 
       The redirect URL to be unset. 
   .PARAMETER authn401 
       Enable or disable user authentication with HTTP 401 responses.  
       Possible values = ON, OFF 
   .PARAMETER authentication 
       Enable or disable user authentication.  
       Possible values = ON, OFF 
   .PARAMETER authenticationhost 
       Fully qualified domain name (FQDN) of the authentication virtual server to which the user must be redirected for authentication. Make sure that the Authentication parameter is set to ENABLED. 
   .PARAMETER authnvsname 
       Name of an authentication virtual server with which to authenticate users. 
   .PARAMETER pushvserver 
       Name of the load balancing virtual server, of type PUSH or SSL_PUSH, to which the server pushes updates received on the load balancing virtual server that you are configuring. 
   .PARAMETER pushlabel 
       Expression for extracting a label from the server's response. Can be either an expression or the name of a named expression. 
   .PARAMETER tcpprofilename 
       Name of the TCP profile whose settings are to be applied to the virtual server. 
   .PARAMETER httpprofilename 
       Name of the HTTP profile whose settings are to be applied to the virtual server. 
   .PARAMETER dbprofilename 
       Name of the DB profile whose settings are to be applied to the virtual server. 
   .PARAMETER rule 
       Expression, or name of a named expression, against which traffic is evaluated.  
       The following requirements apply only to the Citrix ADC CLI:  
       * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
       * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
       * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
   .PARAMETER sothreshold 
       Threshold at which spillover occurs. Specify an integer for the CONNECTION spillover method, a bandwidth value in kilobits per second for the BANDWIDTH method (do not enter the units), or a percentage for the HEALTH method (do not enter the percentage symbol). 
   .PARAMETER l2conn 
       Use Layer 2 parameters (channel number, MAC address, and VLAN ID) in addition to the 4-tuple (<source IP>:<source port>::<destination IP>:<destination port>) that is used to identify a connection. Allows multiple TCP and non-TCP connections with the same 4-tuple to co-exist on the Citrix ADC.  
       Possible values = ON, OFF 
   .PARAMETER mysqlprotocolversion 
       MySQL protocol version that the virtual server advertises to clients. 
   .PARAMETER mysqlserverversion 
       MySQL server version string that the virtual server advertises to clients. 
   .PARAMETER mysqlcharacterset 
       Character set that the virtual server advertises to clients. 
   .PARAMETER mysqlservercapabilities 
       Server capabilities that the virtual server advertises to clients. 
   .PARAMETER appflowlog 
       Apply AppFlow logging to the virtual server.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER netprofile 
       Name of the network profile to associate with the virtual server. If you set this parameter, the virtual server uses only the IP addresses in the network profile as source IP addresses when initiating connections with servers. 
   .PARAMETER icmpvsrresponse 
       How the Citrix ADC responds to ping requests received for an IP address that is common to one or more virtual servers. Available settings function as follows:  
       * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always responds to the ping requests.  
       * If set to ACTIVE on all the virtual servers that share the IP address, the appliance responds to the ping requests if at least one of the virtual servers is UP. Otherwise, the appliance does not respond.  
       * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance responds if at least one virtual server with the ACTIVE setting is UP. Otherwise, the appliance does not respond.  
       Note: This parameter is available at the virtual server level. A similar parameter, ICMP Response, is available at the IP address level, for IPv4 addresses of type VIP. To set that parameter, use the add ip command in the CLI or the Create IP dialog box in the GUI.  
       Possible values = PASSIVE, ACTIVE 
   .PARAMETER skippersistency 
       This argument decides the behavior incase the service which is selected from an existing persistence session has reached threshold.  
       Possible values = Bypass, ReLb, None 
   .PARAMETER minautoscalemembers 
       Minimum number of members expected to be present when vserver is used in Autoscale. 
   .PARAMETER maxautoscalemembers 
       Maximum number of members expected to be present when vserver is used in Autoscale. 
   .PARAMETER authnprofile 
       Name of the authentication profile to be used when authentication is turned on. 
   .PARAMETER macmoderetainvlan 
       This option is used to retain vlan information of incoming packet when macmode is enabled.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER dbslb 
       Enable database specific load balancing for MySQL and MSSQL service types.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER dnsprofilename 
       Name of the DNS profile to be associated with the VServer. DNS profile properties will be applied to the transactions processed by a VServer. This parameter is valid only for DNS and DNS-TCP VServers. 
   .PARAMETER lbprofilename 
       Name of the LB profile which is associated to the vserver. 
   .PARAMETER redirectfromport 
       Port number for the virtual server, from which we absorb the traffic for http redirect.  
       * in CLI is represented as 65535 in NITRO API 
   .PARAMETER httpsredirecturl 
       URL to which to redirect traffic if the traffic is recieved from redirect port. 
   .PARAMETER adfsproxyprofile 
       Name of the adfsProxy profile to be used to support ADFSPIP protocol for ADFS servers. 
   .PARAMETER tcpprobeport 
       Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset.  
       * in CLI is represented as 65535 in NITRO API 
   .PARAMETER ipset 
       The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current lb vserver. 
   .PARAMETER servicename 
       Service to bind to the virtual server. 
   .PARAMETER persistencetype 
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
   .PARAMETER timeout 
       Time period for which a persistence session is in effect. 
   .PARAMETER persistencebackup 
       Backup persistence type for the virtual server. Becomes operational if the primary persistence mechanism fails.  
       Possible values = SOURCEIP, NONE 
   .PARAMETER backuppersistencetimeout 
       Time period for which backup persistence is in effect. 
   .PARAMETER lbmethod 
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
   .PARAMETER hashlength 
       Number of bytes to consider for the hash value used in the URLHASH and DOMAINHASH load balancing methods. 
   .PARAMETER netmask 
       IPv4 subnet mask to apply to the destination IP address or source IP address when the load balancing method is DESTINATIONIPHASH or SOURCEIPHASH. 
   .PARAMETER v6netmasklen 
       Number of bits to consider in an IPv6 destination or source IP address, for creating the hash that is required by the DESTINATIONIPHASH and SOURCEIPHASH load balancing methods. 
   .PARAMETER backuplbmethod 
       Backup load balancing method. Becomes operational if the primary load balancing me  
       thod fails or cannot be used.  
       Valid only if the primary method is based on static proximity.  
       Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, CUSTOMLOAD 
   .PARAMETER cookiename 
       Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
   .PARAMETER resrule 
       Expression specifying which part of a server's response to use for creating rule based persistence sessions (persistence type RULE). Can be either an expression or the name of a named expression.  
       Example:  
       HTTP.RES.HEADER("setcookie").VALUE(0).TYPECAST_NVLIST_T('=',';').VALUE("server1"). 
   .PARAMETER persistmask 
       Persistence mask for IP based persistence types, for IPv4 virtual servers. 
   .PARAMETER v6persistmasklen 
       Persistence mask for IP based persistence types, for IPv6 virtual servers. 
   .PARAMETER pq 
       Use priority queuing on the virtual server. based persistence types, for IPv6 virtual servers.  
       Possible values = ON, OFF 
   .PARAMETER sc 
       Use SureConnect on the virtual server.  
       Possible values = ON, OFF 
   .PARAMETER rtspnat 
       Use network address translation (NAT) for RTSP data connections.  
       Possible values = ON, OFF 
   .PARAMETER m 
       Redirection mode for load balancing. Available settings function as follows:  
       * IP - Before forwarding a request to a server, change the destination IP address to the server's IP address.  
       * MAC - Before forwarding a request to a server, change the destination MAC address to the server's MAC address. The destination IP address is not changed. MAC-based redirection mode is used mostly in firewall load balancing deployments.  
       * IPTUNNEL - Perform IP-in-IP encapsulation for client IP packets. In the outer IP headers, set the destination IP address to the IP address of the server and the source IP address to the subnet IP (SNIP). The client IP packets are not modified. Applicable to both IPv4 and IPv6 packets.  
       * TOS - Encode the virtual server's TOS ID in the TOS field of the IP header.  
       You can use either the IPTUNNEL or the TOS option to implement Direct Server Return (DSR).  
       Possible values = IP, MAC, IPTUNNEL, TOS 
   .PARAMETER tosid 
       TOS ID of the virtual server. Applicable only when the load balancing redirection mode is set to TOS. 
   .PARAMETER datalength 
       Length of the token to be extracted from the data segment of an incoming packet, for use in the token method of load balancing. The length of the token, specified in bytes, must not be greater than 24 KB. Applicable to virtual servers of type TCP. 
   .PARAMETER dataoffset 
       Offset to be considered when extracting a token from the TCP payload. Applicable to virtual servers, of type TCP, using the token method of load balancing. Must be within the first 24 KB of the TCP payload. 
   .PARAMETER sessionless 
       Perform load balancing on a per-packet basis, without establishing sessions. Recommended for load balancing of intrusion detection system (IDS) servers and scenarios involving direct server return (DSR), where session information is unnecessary.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER trofspersistence 
       When value is ENABLED, Trofs persistence is honored. When value is DISABLED, Trofs persistence is not honored.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER connfailover 
       Mode in which the connection failover feature must operate for the virtual server. After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary appliance. Clients remain connected to the same servers. Available settings function as follows:  
       * STATEFUL - The primary appliance shares state information with the secondary appliance, in real time, resulting in some runtime processing overhead.  
       * STATELESS - State information is not shared, and the new primary appliance tries to re-create the packet flow on the basis of the information contained in the packets it receives.  
       * DISABLED - Connection failover does not occur.  
       Possible values = DISABLED, STATEFUL, STATELESS 
   .PARAMETER cacheable 
       Route cacheable requests to a cache redirection virtual server. The load balancing virtual server can forward requests only to a transparent cache redirection virtual server that has an IP address and port combination of *:80, so such a cache redirection virtual server must be configured on the appliance.  
       Possible values = YES, NO 
   .PARAMETER somethod 
       Type of threshold that, when exceeded, triggers spillover. Available settings function as follows:  
       * CONNECTION - Spillover occurs when the number of client connections exceeds the threshold.  
       * DYNAMICCONNECTION - Spillover occurs when the number of client connections at the virtual server exceeds the sum of the maximum client (Max Clients) settings for bound services. Do not specify a spillover threshold for this setting, because the threshold is implied by the Max Clients settings of bound services.  
       * BANDWIDTH - Spillover occurs when the bandwidth consumed by the virtual server's incoming and outgoing traffic exceeds the threshold.  
       * HEALTH - Spillover occurs when the percentage of weights of the services that are UP drops below the threshold. For example, if services svc1, svc2, and svc3 are bound to a virtual server, with weights 1, 2, and 3, and the spillover threshold is 50%, spillover occurs if svc1 and svc3 or svc2 and svc3 transition to DOWN.  
       * NONE - Spillover does not occur.  
       Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
   .PARAMETER sopersistence 
       If spillover occurs, maintain source IP address based persistence for both primary and backup virtual servers.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sopersistencetimeout 
       Timeout for spillover persistence, in minutes. 
   .PARAMETER healththreshold 
       Threshold in percent of active services below which vserver state is made down. If this threshold is 0, vserver state will be up even if one bound service is up. 
   .PARAMETER sobackupaction 
       Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists.  
       Possible values = DROP, ACCEPT, REDIRECT 
   .PARAMETER redirectportrewrite 
       Rewrite the port and change the protocol to ensure successful HTTP redirects from services.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER downstateflush 
       Flush all active transactions associated with a virtual server whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER insertvserveripport 
       Insert an HTTP header, whose value is the IP address and port number of the virtual server, before forwarding a request to the server. The format of the header is <vipHeader>: <virtual server IP address>_<port number >, where vipHeader is the name that you specify for the header. If the virtual server has an IPv6 address, the address in the header is enclosed in brackets ([ and ]) to separate it from the port number. If you have mapped an IPv4 address to a virtual server's IPv6 address, the value of this parameter determines which IP address is inserted in the header, as follows:  
       * VIPADDR - Insert the IP address of the virtual server in the HTTP header regardless of whether the virtual server has an IPv4 address or an IPv6 address. A mapped IPv4 address, if configured, is ignored.  
       * V6TOV4MAPPING - Insert the IPv4 address that is mapped to the virtual server's IPv6 address. If a mapped IPv4 address is not configured, insert the IPv6 address.  
       * OFF - Disable header insertion.  
       Possible values = OFF, VIPADDR, V6TOV4MAPPING 
   .PARAMETER vipheader 
       Name for the inserted header. The default name is vip-header. 
   .PARAMETER disableprimaryondown 
       If the primary virtual server goes down, do not allow it to return to primary status until manually enabled.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER push 
       Process traffic with the push virtual server that is bound to this load balancing virtual server.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER pushmulticlients 
       Allow multiple Web 2.0 connections from the same client to connect to the virtual server and expect updates.  
       Possible values = YES, NO 
   .PARAMETER listenpolicy 
       Expression identifying traffic accepted by the virtual server. Can be either an expression (for example, CLIENT.IP.DST.IN_SUBNET(192.0.2.0/24) or the name of a named expression. In the above example, the virtual server accepts all requests whose destination IP address is in the 192.0.2.0/24 subnet. 
   .PARAMETER listenpriority 
       Integer specifying the priority of the listen policy. A higher number specifies a lower priority. If a request matches the listen policies of more than one virtual server the virtual server whose listen policy has the highest priority (the lowest priority number) accepts the request. 
   .PARAMETER comment 
       Any comments that you might want to associate with the virtual server. 
   .PARAMETER oracleserverversion 
       Oracle server version.  
       Possible values = 10G, 11G 
   .PARAMETER mssqlserverversion 
       For a load balancing virtual server of type MSSQL, the Microsoft SQL Server version. Set this parameter if you expect some clients to run a version different from the version of the database. This setting provides compatibility between the client-side and server-side connections by ensuring that all communication conforms to the server's version.  
       Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
   .PARAMETER rhistate 
       Route Health Injection (RHI) functionality of the NetSaler appliance for advertising the route of the VIP address associated with the virtual server. When Vserver RHI Level (RHI) parameter is set to VSVR_CNTRLD, the following are different RHI behaviors for the VIP address on the basis of RHIstate (RHI STATE) settings on the virtual servers associated with the VIP address:  
       * If you set RHI STATE to PASSIVE on all virtual servers, the Citrix ADC always advertises the route for the VIP address.  
       * If you set RHI STATE to ACTIVE on all virtual servers, the Citrix ADC advertises the route for the VIP address if at least one of the associated virtual servers is in UP state.  
       * If you set RHI STATE to ACTIVE on some and PASSIVE on others, the Citrix ADC advertises the route for the VIP address if at least one of the associated virtual servers, whose RHI STATE set to ACTIVE, is in UP state.  
       Possible values = PASSIVE, ACTIVE 
   .PARAMETER newservicerequest 
       Number of requests, or percentage of the load on existing services, by which to increase the load on a new service at each interval in slow-start mode. A non-zero value indicates that slow-start is applicable. A zero value indicates that the global RR startup parameter is applied. Changing the value to zero will cause services currently in slow start to take the full traffic as determined by the LB method. Subsequently, any new services added will use the global RR factor. 
   .PARAMETER newservicerequestunit 
       Units in which to increment load at each interval in slow-start mode.  
       Possible values = PER_SECOND, PERCENT 
   .PARAMETER newservicerequestincrementinterval 
       Interval, in seconds, between successive increments in the load on a new service or a service whose state has just changed from DOWN to UP. A value of 0 (zero) specifies manual slow start. 
   .PARAMETER persistavpno 
       Persist AVP number for Diameter Persistency.  
       In case this AVP is not defined in Base RFC 3588 and it is nested inside a Grouped AVP,  
       define a sequence of AVP numbers (max 3) in order of parent to child. So say persist AVP number X  
       is nested inside AVP Y which is nested in Z, then define the list as Z Y X. 
   .PARAMETER recursionavailable 
       When set to YES, this option causes the DNS replies from this vserver to have the RA bit turned on. Typically one would set this option to YES, when the vserver is load balancing a set of DNS servers thatsupport recursive queries.  
       Possible values = YES, NO 
   .PARAMETER retainconnectionsoncluster 
       This option enables you to retain existing connections on a node joining a Cluster system or when a node is being configured for passive timeout. By default, this option is disabled.  
       Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCUnsetLbvserver -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetLbvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver
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

        [Boolean]$backupvserver ,

        [Boolean]$clttimeout ,

        [Boolean]$redirurl ,

        [Boolean]$redirurlflags ,

        [Boolean]$authn401 ,

        [Boolean]$authentication ,

        [Boolean]$authenticationhost ,

        [Boolean]$authnvsname ,

        [Boolean]$pushvserver ,

        [Boolean]$pushlabel ,

        [Boolean]$tcpprofilename ,

        [Boolean]$httpprofilename ,

        [Boolean]$dbprofilename ,

        [Boolean]$rule ,

        [Boolean]$sothreshold ,

        [Boolean]$l2conn ,

        [Boolean]$mysqlprotocolversion ,

        [Boolean]$mysqlserverversion ,

        [Boolean]$mysqlcharacterset ,

        [Boolean]$mysqlservercapabilities ,

        [Boolean]$appflowlog ,

        [Boolean]$netprofile ,

        [Boolean]$icmpvsrresponse ,

        [Boolean]$skippersistency ,

        [Boolean]$minautoscalemembers ,

        [Boolean]$maxautoscalemembers ,

        [Boolean]$authnprofile ,

        [Boolean]$macmoderetainvlan ,

        [Boolean]$dbslb ,

        [Boolean]$dnsprofilename ,

        [Boolean]$lbprofilename ,

        [Boolean]$redirectfromport ,

        [Boolean]$httpsredirecturl ,

        [Boolean]$adfsproxyprofile ,

        [Boolean]$tcpprobeport ,

        [Boolean]$ipset ,

        [Boolean]$servicename ,

        [Boolean]$persistencetype ,

        [Boolean]$timeout ,

        [Boolean]$persistencebackup ,

        [Boolean]$backuppersistencetimeout ,

        [Boolean]$lbmethod ,

        [Boolean]$hashlength ,

        [Boolean]$netmask ,

        [Boolean]$v6netmasklen ,

        [Boolean]$backuplbmethod ,

        [Boolean]$cookiename ,

        [Boolean]$resrule ,

        [Boolean]$persistmask ,

        [Boolean]$v6persistmasklen ,

        [Boolean]$pq ,

        [Boolean]$sc ,

        [Boolean]$rtspnat ,

        [Boolean]$m ,

        [Boolean]$tosid ,

        [Boolean]$datalength ,

        [Boolean]$dataoffset ,

        [Boolean]$sessionless ,

        [Boolean]$trofspersistence ,

        [Boolean]$connfailover ,

        [Boolean]$cacheable ,

        [Boolean]$somethod ,

        [Boolean]$sopersistence ,

        [Boolean]$sopersistencetimeout ,

        [Boolean]$healththreshold ,

        [Boolean]$sobackupaction ,

        [Boolean]$redirectportrewrite ,

        [Boolean]$downstateflush ,

        [Boolean]$insertvserveripport ,

        [Boolean]$vipheader ,

        [Boolean]$disableprimaryondown ,

        [Boolean]$push ,

        [Boolean]$pushmulticlients ,

        [Boolean]$listenpolicy ,

        [Boolean]$listenpriority ,

        [Boolean]$comment ,

        [Boolean]$oracleserverversion ,

        [Boolean]$mssqlserverversion ,

        [Boolean]$rhistate ,

        [Boolean]$newservicerequest ,

        [Boolean]$newservicerequestunit ,

        [Boolean]$newservicerequestincrementinterval ,

        [Boolean]$persistavpno ,

        [Boolean]$recursionavailable ,

        [Boolean]$retainconnectionsoncluster 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLbvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('backupvserver')) { $Payload.Add('backupvserver', $backupvserver) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('redirurl')) { $Payload.Add('redirurl', $redirurl) }
            if ($PSBoundParameters.ContainsKey('redirurlflags')) { $Payload.Add('redirurlflags', $redirurlflags) }
            if ($PSBoundParameters.ContainsKey('authn401')) { $Payload.Add('authn401', $authn401) }
            if ($PSBoundParameters.ContainsKey('authentication')) { $Payload.Add('authentication', $authentication) }
            if ($PSBoundParameters.ContainsKey('authenticationhost')) { $Payload.Add('authenticationhost', $authenticationhost) }
            if ($PSBoundParameters.ContainsKey('authnvsname')) { $Payload.Add('authnvsname', $authnvsname) }
            if ($PSBoundParameters.ContainsKey('pushvserver')) { $Payload.Add('pushvserver', $pushvserver) }
            if ($PSBoundParameters.ContainsKey('pushlabel')) { $Payload.Add('pushlabel', $pushlabel) }
            if ($PSBoundParameters.ContainsKey('tcpprofilename')) { $Payload.Add('tcpprofilename', $tcpprofilename) }
            if ($PSBoundParameters.ContainsKey('httpprofilename')) { $Payload.Add('httpprofilename', $httpprofilename) }
            if ($PSBoundParameters.ContainsKey('dbprofilename')) { $Payload.Add('dbprofilename', $dbprofilename) }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('sothreshold')) { $Payload.Add('sothreshold', $sothreshold) }
            if ($PSBoundParameters.ContainsKey('l2conn')) { $Payload.Add('l2conn', $l2conn) }
            if ($PSBoundParameters.ContainsKey('mysqlprotocolversion')) { $Payload.Add('mysqlprotocolversion', $mysqlprotocolversion) }
            if ($PSBoundParameters.ContainsKey('mysqlserverversion')) { $Payload.Add('mysqlserverversion', $mysqlserverversion) }
            if ($PSBoundParameters.ContainsKey('mysqlcharacterset')) { $Payload.Add('mysqlcharacterset', $mysqlcharacterset) }
            if ($PSBoundParameters.ContainsKey('mysqlservercapabilities')) { $Payload.Add('mysqlservercapabilities', $mysqlservercapabilities) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('icmpvsrresponse')) { $Payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ($PSBoundParameters.ContainsKey('skippersistency')) { $Payload.Add('skippersistency', $skippersistency) }
            if ($PSBoundParameters.ContainsKey('minautoscalemembers')) { $Payload.Add('minautoscalemembers', $minautoscalemembers) }
            if ($PSBoundParameters.ContainsKey('maxautoscalemembers')) { $Payload.Add('maxautoscalemembers', $maxautoscalemembers) }
            if ($PSBoundParameters.ContainsKey('authnprofile')) { $Payload.Add('authnprofile', $authnprofile) }
            if ($PSBoundParameters.ContainsKey('macmoderetainvlan')) { $Payload.Add('macmoderetainvlan', $macmoderetainvlan) }
            if ($PSBoundParameters.ContainsKey('dbslb')) { $Payload.Add('dbslb', $dbslb) }
            if ($PSBoundParameters.ContainsKey('dnsprofilename')) { $Payload.Add('dnsprofilename', $dnsprofilename) }
            if ($PSBoundParameters.ContainsKey('lbprofilename')) { $Payload.Add('lbprofilename', $lbprofilename) }
            if ($PSBoundParameters.ContainsKey('redirectfromport')) { $Payload.Add('redirectfromport', $redirectfromport) }
            if ($PSBoundParameters.ContainsKey('httpsredirecturl')) { $Payload.Add('httpsredirecturl', $httpsredirecturl) }
            if ($PSBoundParameters.ContainsKey('adfsproxyprofile')) { $Payload.Add('adfsproxyprofile', $adfsproxyprofile) }
            if ($PSBoundParameters.ContainsKey('tcpprobeport')) { $Payload.Add('tcpprobeport', $tcpprobeport) }
            if ($PSBoundParameters.ContainsKey('ipset')) { $Payload.Add('ipset', $ipset) }
            if ($PSBoundParameters.ContainsKey('servicename')) { $Payload.Add('servicename', $servicename) }
            if ($PSBoundParameters.ContainsKey('persistencetype')) { $Payload.Add('persistencetype', $persistencetype) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('persistencebackup')) { $Payload.Add('persistencebackup', $persistencebackup) }
            if ($PSBoundParameters.ContainsKey('backuppersistencetimeout')) { $Payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('lbmethod')) { $Payload.Add('lbmethod', $lbmethod) }
            if ($PSBoundParameters.ContainsKey('hashlength')) { $Payload.Add('hashlength', $hashlength) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Payload.Add('netmask', $netmask) }
            if ($PSBoundParameters.ContainsKey('v6netmasklen')) { $Payload.Add('v6netmasklen', $v6netmasklen) }
            if ($PSBoundParameters.ContainsKey('backuplbmethod')) { $Payload.Add('backuplbmethod', $backuplbmethod) }
            if ($PSBoundParameters.ContainsKey('cookiename')) { $Payload.Add('cookiename', $cookiename) }
            if ($PSBoundParameters.ContainsKey('resrule')) { $Payload.Add('resrule', $resrule) }
            if ($PSBoundParameters.ContainsKey('persistmask')) { $Payload.Add('persistmask', $persistmask) }
            if ($PSBoundParameters.ContainsKey('v6persistmasklen')) { $Payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ($PSBoundParameters.ContainsKey('pq')) { $Payload.Add('pq', $pq) }
            if ($PSBoundParameters.ContainsKey('sc')) { $Payload.Add('sc', $sc) }
            if ($PSBoundParameters.ContainsKey('rtspnat')) { $Payload.Add('rtspnat', $rtspnat) }
            if ($PSBoundParameters.ContainsKey('m')) { $Payload.Add('m', $m) }
            if ($PSBoundParameters.ContainsKey('tosid')) { $Payload.Add('tosid', $tosid) }
            if ($PSBoundParameters.ContainsKey('datalength')) { $Payload.Add('datalength', $datalength) }
            if ($PSBoundParameters.ContainsKey('dataoffset')) { $Payload.Add('dataoffset', $dataoffset) }
            if ($PSBoundParameters.ContainsKey('sessionless')) { $Payload.Add('sessionless', $sessionless) }
            if ($PSBoundParameters.ContainsKey('trofspersistence')) { $Payload.Add('trofspersistence', $trofspersistence) }
            if ($PSBoundParameters.ContainsKey('connfailover')) { $Payload.Add('connfailover', $connfailover) }
            if ($PSBoundParameters.ContainsKey('cacheable')) { $Payload.Add('cacheable', $cacheable) }
            if ($PSBoundParameters.ContainsKey('somethod')) { $Payload.Add('somethod', $somethod) }
            if ($PSBoundParameters.ContainsKey('sopersistence')) { $Payload.Add('sopersistence', $sopersistence) }
            if ($PSBoundParameters.ContainsKey('sopersistencetimeout')) { $Payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('healththreshold')) { $Payload.Add('healththreshold', $healththreshold) }
            if ($PSBoundParameters.ContainsKey('sobackupaction')) { $Payload.Add('sobackupaction', $sobackupaction) }
            if ($PSBoundParameters.ContainsKey('redirectportrewrite')) { $Payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('insertvserveripport')) { $Payload.Add('insertvserveripport', $insertvserveripport) }
            if ($PSBoundParameters.ContainsKey('vipheader')) { $Payload.Add('vipheader', $vipheader) }
            if ($PSBoundParameters.ContainsKey('disableprimaryondown')) { $Payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ($PSBoundParameters.ContainsKey('push')) { $Payload.Add('push', $push) }
            if ($PSBoundParameters.ContainsKey('pushmulticlients')) { $Payload.Add('pushmulticlients', $pushmulticlients) }
            if ($PSBoundParameters.ContainsKey('listenpolicy')) { $Payload.Add('listenpolicy', $listenpolicy) }
            if ($PSBoundParameters.ContainsKey('listenpriority')) { $Payload.Add('listenpriority', $listenpriority) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('oracleserverversion')) { $Payload.Add('oracleserverversion', $oracleserverversion) }
            if ($PSBoundParameters.ContainsKey('mssqlserverversion')) { $Payload.Add('mssqlserverversion', $mssqlserverversion) }
            if ($PSBoundParameters.ContainsKey('rhistate')) { $Payload.Add('rhistate', $rhistate) }
            if ($PSBoundParameters.ContainsKey('newservicerequest')) { $Payload.Add('newservicerequest', $newservicerequest) }
            if ($PSBoundParameters.ContainsKey('newservicerequestunit')) { $Payload.Add('newservicerequestunit', $newservicerequestunit) }
            if ($PSBoundParameters.ContainsKey('newservicerequestincrementinterval')) { $Payload.Add('newservicerequestincrementinterval', $newservicerequestincrementinterval) }
            if ($PSBoundParameters.ContainsKey('persistavpno')) { $Payload.Add('persistavpno', $persistavpno) }
            if ($PSBoundParameters.ContainsKey('recursionavailable')) { $Payload.Add('recursionavailable', $recursionavailable) }
            if ($PSBoundParameters.ContainsKey('retainconnectionsoncluster')) { $Payload.Add('retainconnectionsoncluster', $retainconnectionsoncluster) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbvserver -Action unset -Payload $Payload -GetWarning
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
        Enable Load Balancing configuration Object
    .DESCRIPTION
        Enable Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .
    .EXAMPLE
        Invoke-ADCEnableLbvserver -name <string>
    .NOTES
        File Name : Invoke-ADCEnableLbvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver/
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
        Write-Verbose "Invoke-ADCEnableLbvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

            if ($PSCmdlet.ShouldProcess($Name, "Enable Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbvserver -Action enable -Payload $Payload -GetWarning
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
        Disable Load Balancing configuration Object
    .DESCRIPTION
        Disable Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .
    .EXAMPLE
        Invoke-ADCDisableLbvserver -name <string>
    .NOTES
        File Name : Invoke-ADCDisableLbvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver/
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
        Write-Verbose "Invoke-ADCDisableLbvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

            if ($PSCmdlet.ShouldProcess($Name, "Disable Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbvserver -Action disable -Payload $Payload -GetWarning
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
        Rename Load Balancing configuration Object
    .DESCRIPTION
        Rename Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER newname 
        New name for the virtual server.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created lbvserver item.
    .EXAMPLE
        Invoke-ADCRenameLbvserver -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameLbvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver/
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
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameLbvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("lbvserver", "Rename Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbvserver -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserver -Filter $Payload)
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserver
    .EXAMPLE 
        Invoke-ADCGetLbvserver -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserver -Count
    .EXAMPLE
        Invoke-ADCGetLbvserver -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserver -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver/
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
        Write-Verbose "Invoke-ADCGetLbvserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lbvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER analyticsprofile 
        Name of the analytics profile bound to the LB vserver. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_analyticsprofile_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvserveranalyticsprofilebinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserveranalyticsprofilebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_analyticsprofile_binding/
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

        [string]$analyticsprofile ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserveranalyticsprofilebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('analyticsprofile')) { $Payload.Add('analyticsprofile', $analyticsprofile) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_analyticsprofile_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_analyticsprofile_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserveranalyticsprofilebinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER analyticsprofile 
       Name of the analytics profile bound to the LB vserver.
    .EXAMPLE
        Invoke-ADCDeleteLbvserveranalyticsprofilebinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserveranalyticsprofilebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_analyticsprofile_binding/
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

        [string]$analyticsprofile 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserveranalyticsprofilebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('analyticsprofile')) { $Arguments.Add('analyticsprofile', $analyticsprofile) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_analyticsprofile_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_analyticsprofile_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_analyticsprofile_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserveranalyticsprofilebinding
    .EXAMPLE 
        Invoke-ADCGetLbvserveranalyticsprofilebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserveranalyticsprofilebinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserveranalyticsprofilebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserveranalyticsprofilebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserveranalyticsprofilebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_analyticsprofile_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserveranalyticsprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_analyticsprofile_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_analyticsprofile_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_analyticsprofile_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_analyticsprofile_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_analyticsprofile_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_analyticsprofile_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_analyticsprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_analyticsprofile_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_appflowpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvserverappflowpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserverappflowpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_appflowpolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverappflowpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_appflowpolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_appflowpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserverappflowpolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvserverappflowpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverappflowpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_appflowpolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverappflowpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_appflowpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_appflowpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_appflowpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverappflowpolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverappflowpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverappflowpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverappflowpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverappflowpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverappflowpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_appflowpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverappflowpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appflowpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appflowpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_appflowpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appflowpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_appflowpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appflowpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_appflowpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appflowpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_appfwpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvserverappfwpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserverappfwpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_appfwpolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverappfwpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_appfwpolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_appfwpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserverappfwpolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvserverappfwpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverappfwpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_appfwpolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverappfwpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_appfwpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_appfwpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_appfwpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverappfwpolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverappfwpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverappfwpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverappfwpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverappfwpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverappfwpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_appfwpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverappfwpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appfwpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appfwpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_appfwpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appfwpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_appfwpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appfwpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_appfwpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appfwpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_appqoepolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvserverappqoepolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserverappqoepolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_appqoepolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverappqoepolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_appqoepolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_appqoepolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserverappqoepolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvserverappqoepolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverappqoepolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_appqoepolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverappqoepolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_appqoepolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_appqoepolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_appqoepolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverappqoepolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverappqoepolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverappqoepolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverappqoepolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverappqoepolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverappqoepolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_appqoepolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverappqoepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_appqoepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appqoepolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_appqoepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appqoepolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_appqoepolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appqoepolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_appqoepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appqoepolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_appqoepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_appqoepolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER bindpoint 
        Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_auditnslogpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvserverauditnslogpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserverauditnslogpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_auditnslogpolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_auditnslogpolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_auditnslogpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserverauditnslogpolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvserverauditnslogpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverauditnslogpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_auditnslogpolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_auditnslogpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_auditnslogpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_auditnslogpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverauditnslogpolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverauditnslogpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverauditnslogpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverauditnslogpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverauditnslogpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverauditnslogpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_auditnslogpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverauditnslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditnslogpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditnslogpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_auditnslogpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditnslogpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_auditnslogpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditnslogpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_auditnslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditnslogpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER bindpoint 
        Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_auditsyslogpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvserverauditsyslogpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserverauditsyslogpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_auditsyslogpolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_auditsyslogpolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_auditsyslogpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserverauditsyslogpolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvserverauditsyslogpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverauditsyslogpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_auditsyslogpolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_auditsyslogpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_auditsyslogpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_auditsyslogpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverauditsyslogpolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverauditsyslogpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverauditsyslogpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverauditsyslogpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverauditsyslogpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverauditsyslogpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_auditsyslogpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverauditsyslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditsyslogpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditsyslogpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_auditsyslogpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditsyslogpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_auditsyslogpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditsyslogpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_auditsyslogpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_authorizationpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvserverauthorizationpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserverauthorizationpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_authorizationpolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverauthorizationpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_authorizationpolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_authorizationpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserverauthorizationpolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvserverauthorizationpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverauthorizationpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_authorizationpolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverauthorizationpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_authorizationpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_authorizationpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_authorizationpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverauthorizationpolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverauthorizationpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverauthorizationpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverauthorizationpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverauthorizationpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverauthorizationpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_authorizationpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverauthorizationpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_authorizationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_authorizationpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_authorizationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_authorizationpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_authorizationpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_authorizationpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_authorizationpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_authorizationpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_authorizationpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_authorizationpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name of the virtual server. If no name is provided, statistical data of all configured virtual servers is displayed. 
    .PARAMETER GetAll 
        Retreive all lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetLbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetLbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_botpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvserverbotpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserverbotpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_botpolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverbotpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_botpolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_botpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserverbotpolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvserverbotpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverbotpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_botpolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverbotpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_botpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_botpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_botpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverbotpolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverbotpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverbotpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverbotpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverbotpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverbotpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_botpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverbotpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_botpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_botpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_botpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_botpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_botpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_botpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_botpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_botpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_cachepolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvservercachepolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvservercachepolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_cachepolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvservercachepolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_cachepolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_cachepolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvservercachepolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvservercachepolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvservercachepolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_cachepolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvservercachepolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_cachepolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_cachepolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_cachepolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvservercachepolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvservercachepolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvservercachepolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvservercachepolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvservercachepolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvservercachepolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_cachepolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvservercachepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_cachepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cachepolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_cachepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cachepolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_cachepolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cachepolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_cachepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cachepolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_cachepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cachepolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_cmppolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvservercmppolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvservercmppolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_cmppolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvservercmppolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_cmppolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_cmppolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvservercmppolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvservercmppolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvservercmppolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_cmppolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvservercmppolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_cmppolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_cmppolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_cmppolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvservercmppolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvservercmppolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvservercmppolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvservercmppolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvservercmppolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvservercmppolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_cmppolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvservercmppolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_cmppolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cmppolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_cmppolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cmppolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_cmppolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cmppolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_cmppolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cmppolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_cmppolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_cmppolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_contentinspectionpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvservercontentinspectionpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvservercontentinspectionpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_contentinspectionpolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvservercontentinspectionpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_contentinspectionpolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_contentinspectionpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvservercontentinspectionpolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvservercontentinspectionpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvservercontentinspectionpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_contentinspectionpolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvservercontentinspectionpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_contentinspectionpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_contentinspectionpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_contentinspectionpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvservercontentinspectionpolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvservercontentinspectionpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvservercontentinspectionpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvservercontentinspectionpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvservercontentinspectionpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvservercontentinspectionpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_contentinspectionpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvservercontentinspectionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_contentinspectionpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_contentinspectionpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_contentinspectionpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_contentinspectionpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_contentinspectionpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_contentinspectionpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_contentinspectionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_contentinspectionpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_csvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_csvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvservercsvserverbinding
    .EXAMPLE 
        Invoke-ADCGetLbvservercsvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvservercsvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvservercsvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvservercsvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvservercsvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_csvserver_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvservercsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_csvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_csvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_csvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_csvserver_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_csvserver_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_csvserver_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_dnspolicy64_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvserverdnspolicy64binding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserverdnspolicy64binding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_dnspolicy64_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverdnspolicy64binding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_dnspolicy64_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_dnspolicy64_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserverdnspolicy64binding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvserverdnspolicy64binding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverdnspolicy64binding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_dnspolicy64_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverdnspolicy64binding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_dnspolicy64_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_dnspolicy64_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_dnspolicy64_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverdnspolicy64binding
    .EXAMPLE 
        Invoke-ADCGetLbvserverdnspolicy64binding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverdnspolicy64binding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverdnspolicy64binding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverdnspolicy64binding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverdnspolicy64binding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_dnspolicy64_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverdnspolicy64binding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_dnspolicy64_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dnspolicy64_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_dnspolicy64_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dnspolicy64_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_dnspolicy64_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dnspolicy64_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_dnspolicy64_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dnspolicy64_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_dnspolicy64_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dnspolicy64_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_dospolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_dospolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverdospolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverdospolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverdospolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverdospolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverdospolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverdospolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_dospolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverdospolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_dospolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dospolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_dospolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dospolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_dospolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dospolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_dospolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dospolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_dospolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_dospolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_feopolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvserverfeopolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserverfeopolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_feopolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverfeopolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_feopolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_feopolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserverfeopolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvserverfeopolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverfeopolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_feopolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverfeopolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_feopolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_feopolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_feopolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverfeopolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverfeopolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverfeopolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverfeopolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverfeopolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverfeopolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_feopolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverfeopolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_feopolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_feopolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_feopolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_feopolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_feopolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_feopolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_feopolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_feopolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_feopolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_feopolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER bindpoint 
        Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_filterpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvserverfilterpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserverfilterpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_filterpolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverfilterpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_filterpolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_filterpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserverfilterpolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvserverfilterpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverfilterpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_filterpolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverfilterpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_filterpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_filterpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_filterpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverfilterpolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverfilterpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverfilterpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverfilterpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverfilterpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverfilterpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_filterpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverfilterpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_filterpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_filterpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_filterpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_filterpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_filterpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_filterpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_filterpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_filterpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Integer specifying the policy's priority. The lower the priority number, the higher the policy's priority.  
        Minimum value = 1  
        Maximum value = 2147483647 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER bindpoint 
        Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_pqpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvserverpqpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserverpqpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_pqpolicy_binding/
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

        [string]$policyname ,

        [ValidateRange(1, 2147483647)]
        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverpqpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_pqpolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_pqpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserverpqpolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Integer specifying the policy's priority. The lower the priority number, the higher the policy's priority.  
       Minimum value = 1  
       Maximum value = 2147483647
    .EXAMPLE
        Invoke-ADCDeleteLbvserverpqpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverpqpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_pqpolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverpqpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_pqpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_pqpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_pqpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverpqpolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverpqpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverpqpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverpqpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverpqpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverpqpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_pqpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverpqpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_pqpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_pqpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_pqpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_pqpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_pqpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_pqpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_pqpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_pqpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_pqpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_pqpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_responderpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvserverresponderpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserverresponderpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_responderpolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverresponderpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_responderpolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_responderpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserverresponderpolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvserverresponderpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverresponderpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_responderpolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverresponderpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_responderpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_responderpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_responderpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverresponderpolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverresponderpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverresponderpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverresponderpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverresponderpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverresponderpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_responderpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverresponderpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_responderpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_responderpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_responderpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_responderpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_responderpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_responderpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_responderpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_responderpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_responderpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_responderpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_rewritepolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvserverrewritepolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserverrewritepolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_rewritepolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverrewritepolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_rewritepolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_rewritepolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserverrewritepolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvserverrewritepolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverrewritepolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_rewritepolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverrewritepolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_rewritepolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_rewritepolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_rewritepolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverrewritepolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverrewritepolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverrewritepolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverrewritepolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverrewritepolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverrewritepolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_rewritepolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverrewritepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_rewritepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_rewritepolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_rewritepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_rewritepolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_rewritepolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_rewritepolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_rewritepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_rewritepolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_rewritepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_rewritepolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER bindpoint 
        Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_scpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvserverscpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserverscpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_scpolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverscpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_scpolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_scpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserverscpolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvserverscpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverscpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_scpolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverscpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_scpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_scpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_scpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverscpolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverscpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverscpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverscpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverscpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverscpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_scpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverscpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_scpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_scpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_scpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_scpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_scpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_scpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_scpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_scpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_scpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_scpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_servicegroupmember_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_servicegroupmember_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverservicegroupmemberbinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverservicegroupmemberbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverservicegroupmemberbinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverservicegroupmemberbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverservicegroupmemberbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverservicegroupmemberbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_servicegroupmember_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverservicegroupmemberbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_servicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroupmember_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_servicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroupmember_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_servicegroupmember_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroupmember_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_servicegroupmember_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroupmember_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_servicegroupmember_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroupmember_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER servicename 
        Service to bind to the virtual server.  
        Minimum length = 1 
    .PARAMETER weight 
        Integer specifying the weight of the service. A larger number specifies a greater weight. Defines the capacity of the service relative to the other services in the load balancing configuration. Determines the priority given to the service in load balancing decisions.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER servicegroupname 
        The service group name bound to the selected load balancing virtual server. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_servicegroup_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvserverservicegroupbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserverservicegroupbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_servicegroup_binding/
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
        [string]$servicename ,

        [ValidateRange(1, 100)]
        [double]$weight = '1' ,

        [string]$servicegroupname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverservicegroupbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('servicename')) { $Payload.Add('servicename', $servicename) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('servicegroupname')) { $Payload.Add('servicegroupname', $servicegroupname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_servicegroup_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_servicegroup_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserverservicegroupbinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER servicename 
       Service to bind to the virtual server.  
       Minimum length = 1    .PARAMETER servicegroupname 
       The service group name bound to the selected load balancing virtual server.
    .EXAMPLE
        Invoke-ADCDeleteLbvserverservicegroupbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverservicegroupbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_servicegroup_binding/
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

        [string]$servicename ,

        [string]$servicegroupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverservicegroupbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('servicename')) { $Arguments.Add('servicename', $servicename) }
            if ($PSBoundParameters.ContainsKey('servicegroupname')) { $Arguments.Add('servicegroupname', $servicegroupname) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_servicegroup_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_servicegroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_servicegroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverservicegroupbinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverservicegroupbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverservicegroupbinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverservicegroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverservicegroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverservicegroupbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_servicegroup_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverservicegroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_servicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_servicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_servicegroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroup_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_servicegroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroup_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_servicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_servicegroup_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER servicename 
        Service to bind to the virtual server.  
        Minimum length = 1 
    .PARAMETER weight 
        Weight to assign to the specified service.  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER servicegroupname 
        Name of the service group.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created lbvserver_service_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvserverservicebinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserverservicebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_service_binding/
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
        [string]$servicename ,

        [ValidateRange(1, 100)]
        [double]$weight ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servicegroupname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverservicebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('servicename')) { $Payload.Add('servicename', $servicename) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('servicegroupname')) { $Payload.Add('servicegroupname', $servicegroupname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_service_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_service_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserverservicebinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER servicename 
       Service to bind to the virtual server.  
       Minimum length = 1    .PARAMETER servicegroupname 
       Name of the service group.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteLbvserverservicebinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverservicebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_service_binding/
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

        [string]$servicename ,

        [string]$servicegroupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverservicebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('servicename')) { $Arguments.Add('servicename', $servicename) }
            if ($PSBoundParameters.ContainsKey('servicegroupname')) { $Arguments.Add('servicegroupname', $servicegroupname) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_service_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_service_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_service_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverservicebinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverservicebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverservicebinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverservicebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverservicebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverservicebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_service_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverservicebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_service_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_service_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_service_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_service_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_service_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_service_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_service_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_service_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_spilloverpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvserverspilloverpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvserverspilloverpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_spilloverpolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvserverspilloverpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_spilloverpolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_spilloverpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvserverspilloverpolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvserverspilloverpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvserverspilloverpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_spilloverpolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvserverspilloverpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_spilloverpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_spilloverpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_spilloverpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvserverspilloverpolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvserverspilloverpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvserverspilloverpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvserverspilloverpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvserverspilloverpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvserverspilloverpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_spilloverpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverspilloverpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_spilloverpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_spilloverpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_spilloverpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_spilloverpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_spilloverpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_spilloverpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_spilloverpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_spilloverpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER bindpoint 
        Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        Type of policy label to invoke. Applicable only to rewrite, videooptimization and cache policies. Available settings function as follows: * reqvserver - Evaluate the request against the request-based policies bound to the specified virtual server. * resvserver - Evaluate the response against the response-based policies bound to the specified virtual server. * policylabel - invoke the request or response against the specified user-defined policy label.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_tmtrafficpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvservertmtrafficpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvservertmtrafficpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_tmtrafficpolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvservertmtrafficpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_tmtrafficpolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_tmtrafficpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvservertmtrafficpolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       Bind point to which to bind the policy. Applicable only to compression, rewrite, videooptimization and cache policies.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvservertmtrafficpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvservertmtrafficpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_tmtrafficpolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvservertmtrafficpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_tmtrafficpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_tmtrafficpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_tmtrafficpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvservertmtrafficpolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvservertmtrafficpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvservertmtrafficpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvservertmtrafficpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvservertmtrafficpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvservertmtrafficpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_tmtrafficpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvservertmtrafficpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_tmtrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_tmtrafficpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_tmtrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_tmtrafficpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_tmtrafficpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_tmtrafficpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_tmtrafficpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_tmtrafficpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_tmtrafficpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_tmtrafficpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_transformpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvservertransformpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvservertransformpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_transformpolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvservertransformpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_transformpolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_transformpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvservertransformpolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvservertransformpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvservertransformpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_transformpolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvservertransformpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_transformpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_transformpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_transformpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvservertransformpolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvservertransformpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvservertransformpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvservertransformpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvservertransformpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvservertransformpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_transformpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvservertransformpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_transformpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_transformpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_transformpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_transformpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_transformpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_transformpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_transformpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_transformpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_transformpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_transformpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_videooptimizationdetectionpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvservervideooptimizationdetectionpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvservervideooptimizationdetectionpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_videooptimizationdetectionpolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvservervideooptimizationdetectionpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_videooptimizationdetectionpolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_videooptimizationdetectionpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvservervideooptimizationdetectionpolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvservervideooptimizationdetectionpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvservervideooptimizationdetectionpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_videooptimizationdetectionpolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvservervideooptimizationdetectionpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_videooptimizationdetectionpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_videooptimizationdetectionpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_videooptimizationdetectionpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvservervideooptimizationdetectionpolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvservervideooptimizationdetectionpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvservervideooptimizationdetectionpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvservervideooptimizationdetectionpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvservervideooptimizationdetectionpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvservervideooptimizationdetectionpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_videooptimizationdetectionpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvservervideooptimizationdetectionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_videooptimizationdetectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationdetectionpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_videooptimizationdetectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationdetectionpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_videooptimizationdetectionpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationdetectionpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_videooptimizationdetectionpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationdetectionpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_videooptimizationdetectionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationdetectionpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the LB vserver. 
    .PARAMETER priority 
        Priority. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or policy label. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created lbvserver_videooptimizationpacingpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddLbvservervideooptimizationpacingpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddLbvservervideooptimizationpacingpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_videooptimizationpacingpolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbvservervideooptimizationpacingpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("lbvserver_videooptimizationpacingpolicy_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver_videooptimizationpacingpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbvservervideooptimizationpacingpolicybinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the LB vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE    .PARAMETER priority 
       Priority.
    .EXAMPLE
        Invoke-ADCDeleteLbvservervideooptimizationpacingpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbvservervideooptimizationpacingpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_videooptimizationpacingpolicy_binding/
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

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbvservervideooptimizationpacingpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver_videooptimizationpacingpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created. CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all lbvserver_videooptimizationpacingpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbvserver_videooptimizationpacingpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbvservervideooptimizationpacingpolicybinding
    .EXAMPLE 
        Invoke-ADCGetLbvservervideooptimizationpacingpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbvservervideooptimizationpacingpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetLbvservervideooptimizationpacingpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbvservervideooptimizationpacingpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbvservervideooptimizationpacingpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_videooptimizationpacingpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvservervideooptimizationpacingpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbvserver_videooptimizationpacingpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationpacingpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver_videooptimizationpacingpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationpacingpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver_videooptimizationpacingpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationpacingpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver_videooptimizationpacingpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationpacingpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver_videooptimizationpacingpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver_videooptimizationpacingpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER wlmname 
        The name of the Work Load Manager.  
        Minimum length = 1 
    .PARAMETER ipaddress 
        The IP address of the WLM. 
    .PARAMETER port 
        The port of the WLM.  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER lbuid 
        The LBUID for the Load Balancer to communicate to the Work Load Manager. 
    .PARAMETER katimeout 
        The idle time period after which Citrix ADC would probe the WLM. The value ranges from 1 to 1440 minutes.  
        Default value: 2  
        Minimum value = 0  
        Maximum value = 1440 
    .PARAMETER PassThru 
        Return details about the created lbwlm item.
    .EXAMPLE
        Invoke-ADCAddLbwlm -wlmname <string> -lbuid <string>
    .NOTES
        File Name : Invoke-ADCAddLbwlm
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbwlm/
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
        [string]$wlmname ,

        [string]$ipaddress ,

        [ValidateRange(1, 65535)]
        [int]$port ,

        [Parameter(Mandatory = $true)]
        [string]$lbuid ,

        [ValidateRange(0, 1440)]
        [double]$katimeout = '2' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbwlm: Starting"
    }
    process {
        try {
            $Payload = @{
                wlmname = $wlmname
                lbuid = $lbuid
            }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Payload.Add('ipaddress', $ipaddress) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('katimeout')) { $Payload.Add('katimeout', $katimeout) }
 
            if ($PSCmdlet.ShouldProcess("lbwlm", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbwlm -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbwlm -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER wlmname 
       The name of the Work Load Manager.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteLbwlm -wlmname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbwlm
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbwlm/
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
        [string]$wlmname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbwlm: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$wlmname", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbwlm -Resource $wlmname -Arguments $Arguments
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
        Update Load Balancing configuration Object
    .DESCRIPTION
        Update Load Balancing configuration Object 
    .PARAMETER wlmname 
        The name of the Work Load Manager.  
        Minimum length = 1 
    .PARAMETER katimeout 
        The idle time period after which Citrix ADC would probe the WLM. The value ranges from 1 to 1440 minutes.  
        Default value: 2  
        Minimum value = 0  
        Maximum value = 1440 
    .PARAMETER PassThru 
        Return details about the created lbwlm item.
    .EXAMPLE
        Invoke-ADCUpdateLbwlm -wlmname <string>
    .NOTES
        File Name : Invoke-ADCUpdateLbwlm
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbwlm/
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
        [string]$wlmname ,

        [ValidateRange(0, 1440)]
        [double]$katimeout ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLbwlm: Starting"
    }
    process {
        try {
            $Payload = @{
                wlmname = $wlmname
            }
            if ($PSBoundParameters.ContainsKey('katimeout')) { $Payload.Add('katimeout', $katimeout) }
 
            if ($PSCmdlet.ShouldProcess("lbwlm", "Update Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbwlm -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbwlm -Filter $Payload)
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
        Unset Load Balancing configuration Object
    .DESCRIPTION
        Unset Load Balancing configuration Object 
   .PARAMETER wlmname 
       The name of the Work Load Manager. 
   .PARAMETER katimeout 
       The idle time period after which Citrix ADC would probe the WLM. The value ranges from 1 to 1440 minutes.
    .EXAMPLE
        Invoke-ADCUnsetLbwlm -wlmname <string>
    .NOTES
        File Name : Invoke-ADCUnsetLbwlm
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbwlm
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
        [string]$wlmname ,

        [Boolean]$katimeout 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLbwlm: Starting"
    }
    process {
        try {
            $Payload = @{
                wlmname = $wlmname
            }
            if ($PSBoundParameters.ContainsKey('katimeout')) { $Payload.Add('katimeout', $katimeout) }
            if ($PSCmdlet.ShouldProcess("$wlmname", "Unset Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbwlm -Action unset -Payload $Payload -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER wlmname 
       The name of the Work Load Manager. 
    .PARAMETER GetAll 
        Retreive all lbwlm object(s)
    .PARAMETER Count
        If specified, the count of the lbwlm object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbwlm
    .EXAMPLE 
        Invoke-ADCGetLbwlm -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbwlm -Count
    .EXAMPLE
        Invoke-ADCGetLbwlm -name <string>
    .EXAMPLE
        Invoke-ADCGetLbwlm -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbwlm
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbwlm/
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
        [string]$wlmname,

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
        Write-Verbose "Invoke-ADCGetLbwlm: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lbwlm objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbwlm objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbwlm objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbwlm configuration for property 'wlmname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm -Resource $wlmname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbwlm configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER wlmname 
       The name of the work load manager. 
    .PARAMETER GetAll 
        Retreive all lbwlm_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbwlm_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbwlmbinding
    .EXAMPLE 
        Invoke-ADCGetLbwlmbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetLbwlmbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbwlmbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbwlmbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbwlm_binding/
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
        [string]$wlmname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbwlmbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbwlm_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbwlm_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbwlm_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbwlm_binding configuration for property 'wlmname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_binding -Resource $wlmname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbwlm_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Load Balancing configuration Object
    .DESCRIPTION
        Add Load Balancing configuration Object 
    .PARAMETER wlmname 
        The name of the Work Load Manager.  
        Minimum length = 1 
    .PARAMETER vservername 
        Name of the virtual server which is to be bound to the WLM. 
    .PARAMETER PassThru 
        Return details about the created lbwlm_lbvserver_binding item.
    .EXAMPLE
        Invoke-ADCAddLbwlmlbvserverbinding -wlmname <string> -vservername <string>
    .NOTES
        File Name : Invoke-ADCAddLbwlmlbvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbwlm_lbvserver_binding/
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
        [string]$wlmname ,

        [Parameter(Mandatory = $true)]
        [string]$vservername ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLbwlmlbvserverbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                wlmname = $wlmname
                vservername = $vservername
            }

 
            if ($PSCmdlet.ShouldProcess("lbwlm_lbvserver_binding", "Add Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbwlm_lbvserver_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLbwlmlbvserverbinding -Filter $Payload)
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
        Delete Load Balancing configuration Object
    .DESCRIPTION
        Delete Load Balancing configuration Object
    .PARAMETER wlmname 
       The name of the Work Load Manager.  
       Minimum length = 1    .PARAMETER vservername 
       Name of the virtual server which is to be bound to the WLM.
    .EXAMPLE
        Invoke-ADCDeleteLbwlmlbvserverbinding -wlmname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLbwlmlbvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbwlm_lbvserver_binding/
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
        [string]$wlmname ,

        [string]$vservername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLbwlmlbvserverbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('vservername')) { $Arguments.Add('vservername', $vservername) }
            if ($PSCmdlet.ShouldProcess("$wlmname", "Delete Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbwlm_lbvserver_binding -Resource $wlmname -Arguments $Arguments
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
        Get Load Balancing configuration object(s)
    .DESCRIPTION
        Get Load Balancing configuration object(s)
    .PARAMETER wlmname 
       The name of the Work Load Manager. 
    .PARAMETER GetAll 
        Retreive all lbwlm_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the lbwlm_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLbwlmlbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetLbwlmlbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLbwlmlbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetLbwlmlbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLbwlmlbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLbwlmlbvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbwlm_lbvserver_binding/
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
        [string]$wlmname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lbwlm_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_lbvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbwlm_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_lbvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbwlm_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_lbvserver_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbwlm_lbvserver_binding configuration for property 'wlmname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_lbvserver_binding -Resource $wlmname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbwlm_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbwlm_lbvserver_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


