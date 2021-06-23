function Invoke-ADCAddUserprotocol {
<#
    .SYNOPSIS
        Add User configuration Object
    .DESCRIPTION
        Add User configuration Object 
    .PARAMETER name 
        Unique name for the user protocol. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters.  
        Minimum length = 1 
    .PARAMETER transport 
        Transport layer's protocol.  
        Possible values = TCP, SSL 
    .PARAMETER extension 
        Name of the extension to add parsing and runtime handling of the protocol packets. 
    .PARAMETER comment 
        Any comments associated with the protocol. 
    .PARAMETER PassThru 
        Return details about the created userprotocol item.
    .EXAMPLE
        Invoke-ADCAddUserprotocol -name <string> -transport <string> -extension <string>
    .NOTES
        File Name : Invoke-ADCAddUserprotocol
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/user/userprotocol/
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
        [ValidateSet('TCP', 'SSL')]
        [string]$transport ,

        [Parameter(Mandatory = $true)]
        [string]$extension ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddUserprotocol: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                transport = $transport
                extension = $extension
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("userprotocol", "Add User configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type userprotocol -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetUserprotocol -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddUserprotocol: Finished"
    }
}

function Invoke-ADCDeleteUserprotocol {
<#
    .SYNOPSIS
        Delete User configuration Object
    .DESCRIPTION
        Delete User configuration Object
    .PARAMETER name 
       Unique name for the user protocol. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteUserprotocol -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteUserprotocol
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/user/userprotocol/
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
        Write-Verbose "Invoke-ADCDeleteUserprotocol: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete User configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type userprotocol -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteUserprotocol: Finished"
    }
}

function Invoke-ADCUpdateUserprotocol {
<#
    .SYNOPSIS
        Update User configuration Object
    .DESCRIPTION
        Update User configuration Object 
    .PARAMETER name 
        Unique name for the user protocol. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters.  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments associated with the protocol. 
    .PARAMETER PassThru 
        Return details about the created userprotocol item.
    .EXAMPLE
        Invoke-ADCUpdateUserprotocol -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateUserprotocol
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/user/userprotocol/
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

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateUserprotocol: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("userprotocol", "Update User configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type userprotocol -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetUserprotocol -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateUserprotocol: Finished"
    }
}

function Invoke-ADCUnsetUserprotocol {
<#
    .SYNOPSIS
        Unset User configuration Object
    .DESCRIPTION
        Unset User configuration Object 
   .PARAMETER name 
       Unique name for the user protocol. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. 
   .PARAMETER comment 
       Any comments associated with the protocol.
    .EXAMPLE
        Invoke-ADCUnsetUserprotocol -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetUserprotocol
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/user/userprotocol
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
        Write-Verbose "Invoke-ADCUnsetUserprotocol: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset User configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type userprotocol -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetUserprotocol: Finished"
    }
}

function Invoke-ADCGetUserprotocol {
<#
    .SYNOPSIS
        Get User configuration object(s)
    .DESCRIPTION
        Get User configuration object(s)
    .PARAMETER name 
       Unique name for the user protocol. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. 
    .PARAMETER GetAll 
        Retreive all userprotocol object(s)
    .PARAMETER Count
        If specified, the count of the userprotocol object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetUserprotocol
    .EXAMPLE 
        Invoke-ADCGetUserprotocol -GetAll 
    .EXAMPLE 
        Invoke-ADCGetUserprotocol -Count
    .EXAMPLE
        Invoke-ADCGetUserprotocol -name <string>
    .EXAMPLE
        Invoke-ADCGetUserprotocol -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetUserprotocol
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/user/userprotocol/
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
        Write-Verbose "Invoke-ADCGetUserprotocol: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all userprotocol objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type userprotocol -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for userprotocol objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type userprotocol -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving userprotocol objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type userprotocol -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving userprotocol configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type userprotocol -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving userprotocol configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type userprotocol -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetUserprotocol: Ended"
    }
}

function Invoke-ADCAddUservserver {
<#
    .SYNOPSIS
        Add User configuration Object
    .DESCRIPTION
        Add User configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER userprotocol 
        User protocol uesd by the service. 
    .PARAMETER ipaddress 
        IPv4 or IPv6 address to assign to the virtual server. 
    .PARAMETER port 
        Port number for the virtual server.  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER defaultlb 
        Name of the default Load Balancing virtual server used for load balancing of services. The protocol type of default Load Balancing virtual server should be a user type. 
    .PARAMETER Params 
        Any comments associated with the protocol. 
    .PARAMETER comment 
        Any comments that you might want to associate with the virtual server. 
    .PARAMETER state 
        Initial state of the user vserver.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created uservserver item.
    .EXAMPLE
        Invoke-ADCAddUservserver -name <string> -userprotocol <string> -ipaddress <string> -port <int> -defaultlb <string>
    .NOTES
        File Name : Invoke-ADCAddUservserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/user/uservserver/
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
        [string]$userprotocol ,

        [Parameter(Mandatory = $true)]
        [string]$ipaddress ,

        [Parameter(Mandatory = $true)]
        [ValidateRange(1, 65535)]
        [int]$port ,

        [Parameter(Mandatory = $true)]
        [string]$defaultlb ,

        [string]$Params ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddUservserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                userprotocol = $userprotocol
                ipaddress = $ipaddress
                port = $port
                defaultlb = $defaultlb
            }
            if ($PSBoundParameters.ContainsKey('Params')) { $Payload.Add('Params', $Params) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
 
            if ($PSCmdlet.ShouldProcess("uservserver", "Add User configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type uservserver -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetUservserver -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddUservserver: Finished"
    }
}

function Invoke-ADCDeleteUservserver {
<#
    .SYNOPSIS
        Delete User configuration Object
    .DESCRIPTION
        Delete User configuration Object
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteUservserver -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteUservserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/user/uservserver/
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
        Write-Verbose "Invoke-ADCDeleteUservserver: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete User configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type uservserver -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteUservserver: Finished"
    }
}

function Invoke-ADCUpdateUservserver {
<#
    .SYNOPSIS
        Update User configuration Object
    .DESCRIPTION
        Update User configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .  
        Minimum length = 1 
    .PARAMETER ipaddress 
        IPv4 or IPv6 address to assign to the virtual server. 
    .PARAMETER defaultlb 
        Name of the default Load Balancing virtual server used for load balancing of services. The protocol type of default Load Balancing virtual server should be a user type. 
    .PARAMETER Params 
        Any comments associated with the protocol. 
    .PARAMETER comment 
        Any comments that you might want to associate with the virtual server. 
    .PARAMETER PassThru 
        Return details about the created uservserver item.
    .EXAMPLE
        Invoke-ADCUpdateUservserver -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateUservserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/user/uservserver/
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

        [string]$defaultlb ,

        [string]$Params ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateUservserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Payload.Add('ipaddress', $ipaddress) }
            if ($PSBoundParameters.ContainsKey('defaultlb')) { $Payload.Add('defaultlb', $defaultlb) }
            if ($PSBoundParameters.ContainsKey('Params')) { $Payload.Add('Params', $Params) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("uservserver", "Update User configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type uservserver -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetUservserver -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateUservserver: Finished"
    }
}

function Invoke-ADCUnsetUservserver {
<#
    .SYNOPSIS
        Unset User configuration Object
    .DESCRIPTION
        Unset User configuration Object 
   .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
   .PARAMETER Params 
       Any comments associated with the protocol. 
   .PARAMETER comment 
       Any comments that you might want to associate with the virtual server.
    .EXAMPLE
        Invoke-ADCUnsetUservserver -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetUservserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/user/uservserver
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

        [Boolean]$Params ,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetUservserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('Params')) { $Payload.Add('Params', $Params) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset User configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type uservserver -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetUservserver: Finished"
    }
}

function Invoke-ADCEnableUservserver {
<#
    .SYNOPSIS
        Enable User configuration Object
    .DESCRIPTION
        Enable User configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .
    .EXAMPLE
        Invoke-ADCEnableUservserver -name <string>
    .NOTES
        File Name : Invoke-ADCEnableUservserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/user/uservserver/
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
        Write-Verbose "Invoke-ADCEnableUservserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

            if ($PSCmdlet.ShouldProcess($Name, "Enable User configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type uservserver -Action enable -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCEnableUservserver: Finished"
    }
}

function Invoke-ADCDisableUservserver {
<#
    .SYNOPSIS
        Disable User configuration Object
    .DESCRIPTION
        Disable User configuration Object 
    .PARAMETER name 
        Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). .
    .EXAMPLE
        Invoke-ADCDisableUservserver -name <string>
    .NOTES
        File Name : Invoke-ADCDisableUservserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/user/uservserver/
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
        Write-Verbose "Invoke-ADCDisableUservserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

            if ($PSCmdlet.ShouldProcess($Name, "Disable User configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type uservserver -Action disable -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCDisableUservserver: Finished"
    }
}

function Invoke-ADCGetUservserver {
<#
    .SYNOPSIS
        Get User configuration object(s)
    .DESCRIPTION
        Get User configuration object(s)
    .PARAMETER name 
       Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). . 
    .PARAMETER GetAll 
        Retreive all uservserver object(s)
    .PARAMETER Count
        If specified, the count of the uservserver object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetUservserver
    .EXAMPLE 
        Invoke-ADCGetUservserver -GetAll 
    .EXAMPLE 
        Invoke-ADCGetUservserver -Count
    .EXAMPLE
        Invoke-ADCGetUservserver -name <string>
    .EXAMPLE
        Invoke-ADCGetUservserver -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetUservserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/user/uservserver/
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
        Write-Verbose "Invoke-ADCGetUservserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all uservserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type uservserver -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for uservserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type uservserver -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving uservserver objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type uservserver -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving uservserver configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type uservserver -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving uservserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type uservserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetUservserver: Ended"
    }
}


