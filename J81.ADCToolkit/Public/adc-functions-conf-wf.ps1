function Invoke-ADCInstallWfpackage {
    <#
    .SYNOPSIS
        Install Wf configuration Object.
    .DESCRIPTION
        Configuration for Web Front resource.
    .PARAMETER Jre 
        Complete path to the JRE tar file. 
        You can use OpenJDK7 package for FreeBSD 8.x/amd64.The Java package can be downloaded from http://ftp-archive.freebsd.org/pub/FreeBSD-Archive/old-releases/amd64/amd64/8.4-RELEASE/packages/java/openjdk-7.17.02_2.tbz or http://www.freebsdfoundation.org/cgi-bin/download?download=diablo-jdk-freebsd6.amd64.1.7.17.07.02.tbz. 
    .PARAMETER Wf 
        Complete path to the WebFront tar file for installing the WebFront on the Citrix ADC. This file includes Apache Tomcat Web server. The file name has the following format: nswf-<version number>.tar (for example, nswf-1.5.tar).
    .EXAMPLE
        PS C:\>Invoke-ADCInstallWfpackage 
        An example how to install wfpackage configuration Object(s).
    .NOTES
        File Name : Invoke-ADCInstallWfpackage
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wf/wfpackage/
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

        [ValidateLength(1, 255)]
        [string]$Jre,

        [ValidateLength(1, 255)]
        [string]$Wf 

    )
    begin {
        Write-Verbose "Invoke-ADCInstallWfpackage: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('jre') ) { $payload.Add('jre', $jre) }
            if ( $PSBoundParameters.ContainsKey('wf') ) { $payload.Add('wf', $wf) }
            if ( $PSCmdlet.ShouldProcess($Name, "Install Wf configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type wfpackage -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCInstallWfpackage: Finished"
    }
}

function Invoke-ADCGetWfpackage {
    <#
    .SYNOPSIS
        Get Wf configuration object(s).
    .DESCRIPTION
        Configuration for Web Front resource.
    .PARAMETER GetAll 
        Retrieve all wfpackage object(s).
    .PARAMETER Count
        If specified, the count of the wfpackage object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWfpackage
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetWfpackage -GetAll 
        Get all wfpackage data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWfpackage -name <string>
        Get wfpackage object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWfpackage -Filter @{ 'name'='<value>' }
        Get wfpackage data with a filter.
    .NOTES
        File Name : Invoke-ADCGetWfpackage
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wf/wfpackage/
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
        Write-Verbose "Invoke-ADCGetWfpackage: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all wfpackage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wfpackage -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for wfpackage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wfpackage -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving wfpackage objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wfpackage -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving wfpackage configuration for property ''"

            } else {
                Write-Verbose "Retrieving wfpackage configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wfpackage -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetWfpackage: Ended"
    }
}

function Invoke-ADCAddWfsite {
    <#
    .SYNOPSIS
        Add Wf configuration Object.
    .DESCRIPTION
        Configuration for WF site resource.
    .PARAMETER Sitename 
        Name of the WebFront site being created on the Citrix ADC. 
    .PARAMETER Storefronturl 
        FQDN or IP of Windows StoreFront server where the store is configured. 
    .PARAMETER Storename 
        Name of the store present in StoreFront. 
    .PARAMETER Html5receiver 
        Specifies whether or not to use HTML5 receiver for launching apps for the WF site. 
        Possible values = ALWAYS, FALLBACK, OFF 
    .PARAMETER Workspacecontrol 
        Specifies whether of not to use workspace control for the WF site. 
        Possible values = ON, OFF 
    .PARAMETER Displayroamingaccounts 
        Specifies whether or not to display the accounts selection screen during First Time Use of Receiver . 
        Possible values = ON, OFF 
    .PARAMETER Xframeoptions 
        The value to be sent in the X-Frame-Options header. WARNING: Setting this option to ALLOW could leave the end user vulnerable to Click Jacking attacks. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created wfsite item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddWfsite -sitename <string> -storefronturl <string> -storename <string>
        An example how to add wfsite configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddWfsite
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wf/wfsite/
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
        [ValidateLength(1, 255)]
        [string]$Sitename,

        [Parameter(Mandatory)]
        [ValidateLength(1, 255)]
        [string]$Storefronturl,

        [Parameter(Mandatory)]
        [ValidateLength(1, 255)]
        [string]$Storename,

        [ValidateSet('ALWAYS', 'FALLBACK', 'OFF')]
        [string]$Html5receiver = 'FALLBACK',

        [ValidateSet('ON', 'OFF')]
        [string]$Workspacecontrol = 'ON',

        [ValidateSet('ON', 'OFF')]
        [string]$Displayroamingaccounts = 'ON',

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Xframeoptions = 'DENY',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddWfsite: Starting"
    }
    process {
        try {
            $payload = @{ sitename = $sitename
                storefronturl      = $storefronturl
                storename          = $storename
            }
            if ( $PSBoundParameters.ContainsKey('html5receiver') ) { $payload.Add('html5receiver', $html5receiver) }
            if ( $PSBoundParameters.ContainsKey('workspacecontrol') ) { $payload.Add('workspacecontrol', $workspacecontrol) }
            if ( $PSBoundParameters.ContainsKey('displayroamingaccounts') ) { $payload.Add('displayroamingaccounts', $displayroamingaccounts) }
            if ( $PSBoundParameters.ContainsKey('xframeoptions') ) { $payload.Add('xframeoptions', $xframeoptions) }
            if ( $PSCmdlet.ShouldProcess("wfsite", "Add Wf configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type wfsite -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetWfsite -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddWfsite: Finished"
    }
}

function Invoke-ADCDeleteWfsite {
    <#
    .SYNOPSIS
        Delete Wf configuration Object.
    .DESCRIPTION
        Configuration for WF site resource.
    .PARAMETER Sitename 
        Name of the WebFront site being created on the Citrix ADC.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteWfsite -Sitename <string>
        An example how to delete wfsite configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteWfsite
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wf/wfsite/
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
        [string]$Sitename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteWfsite: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$sitename", "Delete Wf configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type wfsite -NitroPath nitro/v1/config -Resource $sitename -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteWfsite: Finished"
    }
}

function Invoke-ADCUpdateWfsite {
    <#
    .SYNOPSIS
        Update Wf configuration Object.
    .DESCRIPTION
        Configuration for WF site resource.
    .PARAMETER Sitename 
        Name of the WebFront site being created on the Citrix ADC. 
    .PARAMETER Storefronturl 
        FQDN or IP of Windows StoreFront server where the store is configured. 
    .PARAMETER Storename 
        Name of the store present in StoreFront. 
    .PARAMETER Html5receiver 
        Specifies whether or not to use HTML5 receiver for launching apps for the WF site. 
        Possible values = ALWAYS, FALLBACK, OFF 
    .PARAMETER Workspacecontrol 
        Specifies whether of not to use workspace control for the WF site. 
        Possible values = ON, OFF 
    .PARAMETER Displayroamingaccounts 
        Specifies whether or not to display the accounts selection screen during First Time Use of Receiver . 
        Possible values = ON, OFF 
    .PARAMETER Xframeoptions 
        The value to be sent in the X-Frame-Options header. WARNING: Setting this option to ALLOW could leave the end user vulnerable to Click Jacking attacks. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created wfsite item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateWfsite -sitename <string>
        An example how to update wfsite configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateWfsite
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wf/wfsite/
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
        [ValidateLength(1, 255)]
        [string]$Sitename,

        [ValidateLength(1, 255)]
        [string]$Storefronturl,

        [ValidateLength(1, 255)]
        [string]$Storename,

        [ValidateSet('ALWAYS', 'FALLBACK', 'OFF')]
        [string]$Html5receiver,

        [ValidateSet('ON', 'OFF')]
        [string]$Workspacecontrol,

        [ValidateSet('ON', 'OFF')]
        [string]$Displayroamingaccounts,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Xframeoptions,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateWfsite: Starting"
    }
    process {
        try {
            $payload = @{ sitename = $sitename }
            if ( $PSBoundParameters.ContainsKey('storefronturl') ) { $payload.Add('storefronturl', $storefronturl) }
            if ( $PSBoundParameters.ContainsKey('storename') ) { $payload.Add('storename', $storename) }
            if ( $PSBoundParameters.ContainsKey('html5receiver') ) { $payload.Add('html5receiver', $html5receiver) }
            if ( $PSBoundParameters.ContainsKey('workspacecontrol') ) { $payload.Add('workspacecontrol', $workspacecontrol) }
            if ( $PSBoundParameters.ContainsKey('displayroamingaccounts') ) { $payload.Add('displayroamingaccounts', $displayroamingaccounts) }
            if ( $PSBoundParameters.ContainsKey('xframeoptions') ) { $payload.Add('xframeoptions', $xframeoptions) }
            if ( $PSCmdlet.ShouldProcess("wfsite", "Update Wf configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type wfsite -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetWfsite -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateWfsite: Finished"
    }
}

function Invoke-ADCGetWfsite {
    <#
    .SYNOPSIS
        Get Wf configuration object(s).
    .DESCRIPTION
        Configuration for WF site resource.
    .PARAMETER Sitename 
        Name of the WebFront site being created on the Citrix ADC. 
    .PARAMETER GetAll 
        Retrieve all wfsite object(s).
    .PARAMETER Count
        If specified, the count of the wfsite object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWfsite
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetWfsite -GetAll 
        Get all wfsite data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetWfsite -Count 
        Get the number of wfsite objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWfsite -name <string>
        Get wfsite object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWfsite -Filter @{ 'name'='<value>' }
        Get wfsite data with a filter.
    .NOTES
        File Name : Invoke-ADCGetWfsite
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wf/wfsite/
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
        [ValidateLength(1, 255)]
        [string]$Sitename,

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
        Write-Verbose "Invoke-ADCGetWfsite: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all wfsite objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wfsite -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for wfsite objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wfsite -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving wfsite objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wfsite -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving wfsite configuration for property 'sitename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wfsite -NitroPath nitro/v1/config -Resource $sitename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving wfsite configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wfsite -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetWfsite: Ended"
    }
}


