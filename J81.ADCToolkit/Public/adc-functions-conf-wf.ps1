function Invoke-ADCInstallWfpackage {
<#
    .SYNOPSIS
        Install Wf configuration Object
    .DESCRIPTION
        Install Wf configuration Object 
    .PARAMETER jre 
        Complete path to the JRE tar file.  
        You can use OpenJDK7 package for FreeBSD 8.x/amd64.The Java package can be downloaded from http://ftp-archive.freebsd.org/pub/FreeBSD-Archive/old-releases/amd64/amd64/8.4-RELEASE/packages/java/openjdk-7.17.02_2.tbz or http://www.freebsdfoundation.org/cgi-bin/download?download=diablo-jdk-freebsd6.amd64.1.7.17.07.02.tbz. 
    .PARAMETER wf 
        Complete path to the WebFront tar file for installing the WebFront on the Citrix ADC. This file includes Apache Tomcat Web server. The file name has the following format: nswf-<version number>.tar (for example, nswf-1.5.tar).
    .EXAMPLE
        Invoke-ADCInstallWfpackage 
    .NOTES
        File Name : Invoke-ADCInstallWfpackage
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wf/wfpackage/
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

        [ValidateLength(1, 255)]
        [string]$jre ,

        [ValidateLength(1, 255)]
        [string]$wf 

    )
    begin {
        Write-Verbose "Invoke-ADCInstallWfpackage: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('jre')) { $Payload.Add('jre', $jre) }
            if ($PSBoundParameters.ContainsKey('wf')) { $Payload.Add('wf', $wf) }
            if ($PSCmdlet.ShouldProcess($Name, "Install Wf configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type wfpackage -Payload $Payload -GetWarning
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
        Get Wf configuration object(s)
    .DESCRIPTION
        Get Wf configuration object(s)
    .PARAMETER GetAll 
        Retreive all wfpackage object(s)
    .PARAMETER Count
        If specified, the count of the wfpackage object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetWfpackage
    .EXAMPLE 
        Invoke-ADCGetWfpackage -GetAll
    .EXAMPLE
        Invoke-ADCGetWfpackage -name <string>
    .EXAMPLE
        Invoke-ADCGetWfpackage -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetWfpackage
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wf/wfpackage/
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
        Write-Verbose "Invoke-ADCGetWfpackage: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all wfpackage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wfpackage -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for wfpackage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wfpackage -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving wfpackage objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wfpackage -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving wfpackage configuration for property ''"

            } else {
                Write-Verbose "Retrieving wfpackage configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wfpackage -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Wf configuration Object
    .DESCRIPTION
        Add Wf configuration Object 
    .PARAMETER sitename 
        Name of the WebFront site being created on the Citrix ADC.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER storefronturl 
        FQDN or IP of Windows StoreFront server where the store is configured.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER storename 
        Name of the store present in StoreFront.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER html5receiver 
        Specifies whether or not to use HTML5 receiver for launching apps for the WF site.  
        Default value: FALLBACK  
        Possible values = ALWAYS, FALLBACK, OFF 
    .PARAMETER workspacecontrol 
        Specifies whether of not to use workspace control for the WF site.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER displayroamingaccounts 
        Specifies whether or not to display the accounts selection screen during First Time Use of Receiver .  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER xframeoptions 
        The value to be sent in the X-Frame-Options header. WARNING: Setting this option to ALLOW could leave the end user vulnerable to Click Jacking attacks.  
        Default value: DENY  
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created wfsite item.
    .EXAMPLE
        Invoke-ADCAddWfsite -sitename <string> -storefronturl <string> -storename <string>
    .NOTES
        File Name : Invoke-ADCAddWfsite
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wf/wfsite/
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
        [ValidateLength(1, 255)]
        [string]$sitename ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 255)]
        [string]$storefronturl ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 255)]
        [string]$storename ,

        [ValidateSet('ALWAYS', 'FALLBACK', 'OFF')]
        [string]$html5receiver = 'FALLBACK' ,

        [ValidateSet('ON', 'OFF')]
        [string]$workspacecontrol = 'ON' ,

        [ValidateSet('ON', 'OFF')]
        [string]$displayroamingaccounts = 'ON' ,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$xframeoptions = 'DENY' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddWfsite: Starting"
    }
    process {
        try {
            $Payload = @{
                sitename = $sitename
                storefronturl = $storefronturl
                storename = $storename
            }
            if ($PSBoundParameters.ContainsKey('html5receiver')) { $Payload.Add('html5receiver', $html5receiver) }
            if ($PSBoundParameters.ContainsKey('workspacecontrol')) { $Payload.Add('workspacecontrol', $workspacecontrol) }
            if ($PSBoundParameters.ContainsKey('displayroamingaccounts')) { $Payload.Add('displayroamingaccounts', $displayroamingaccounts) }
            if ($PSBoundParameters.ContainsKey('xframeoptions')) { $Payload.Add('xframeoptions', $xframeoptions) }
 
            if ($PSCmdlet.ShouldProcess("wfsite", "Add Wf configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type wfsite -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetWfsite -Filter $Payload)
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
        Delete Wf configuration Object
    .DESCRIPTION
        Delete Wf configuration Object
    .PARAMETER sitename 
       Name of the WebFront site being created on the Citrix ADC.  
       Minimum length = 1  
       Maximum length = 255 
    .EXAMPLE
        Invoke-ADCDeleteWfsite -sitename <string>
    .NOTES
        File Name : Invoke-ADCDeleteWfsite
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wf/wfsite/
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
        [string]$sitename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteWfsite: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$sitename", "Delete Wf configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type wfsite -NitroPath nitro/v1/config -Resource $sitename -Arguments $Arguments
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
        Update Wf configuration Object
    .DESCRIPTION
        Update Wf configuration Object 
    .PARAMETER sitename 
        Name of the WebFront site being created on the Citrix ADC.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER storefronturl 
        FQDN or IP of Windows StoreFront server where the store is configured.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER storename 
        Name of the store present in StoreFront.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER html5receiver 
        Specifies whether or not to use HTML5 receiver for launching apps for the WF site.  
        Default value: FALLBACK  
        Possible values = ALWAYS, FALLBACK, OFF 
    .PARAMETER workspacecontrol 
        Specifies whether of not to use workspace control for the WF site.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER displayroamingaccounts 
        Specifies whether or not to display the accounts selection screen during First Time Use of Receiver .  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER xframeoptions 
        The value to be sent in the X-Frame-Options header. WARNING: Setting this option to ALLOW could leave the end user vulnerable to Click Jacking attacks.  
        Default value: DENY  
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created wfsite item.
    .EXAMPLE
        Invoke-ADCUpdateWfsite -sitename <string>
    .NOTES
        File Name : Invoke-ADCUpdateWfsite
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wf/wfsite/
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
        [ValidateLength(1, 255)]
        [string]$sitename ,

        [ValidateLength(1, 255)]
        [string]$storefronturl ,

        [ValidateLength(1, 255)]
        [string]$storename ,

        [ValidateSet('ALWAYS', 'FALLBACK', 'OFF')]
        [string]$html5receiver ,

        [ValidateSet('ON', 'OFF')]
        [string]$workspacecontrol ,

        [ValidateSet('ON', 'OFF')]
        [string]$displayroamingaccounts ,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$xframeoptions ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateWfsite: Starting"
    }
    process {
        try {
            $Payload = @{
                sitename = $sitename
            }
            if ($PSBoundParameters.ContainsKey('storefronturl')) { $Payload.Add('storefronturl', $storefronturl) }
            if ($PSBoundParameters.ContainsKey('storename')) { $Payload.Add('storename', $storename) }
            if ($PSBoundParameters.ContainsKey('html5receiver')) { $Payload.Add('html5receiver', $html5receiver) }
            if ($PSBoundParameters.ContainsKey('workspacecontrol')) { $Payload.Add('workspacecontrol', $workspacecontrol) }
            if ($PSBoundParameters.ContainsKey('displayroamingaccounts')) { $Payload.Add('displayroamingaccounts', $displayroamingaccounts) }
            if ($PSBoundParameters.ContainsKey('xframeoptions')) { $Payload.Add('xframeoptions', $xframeoptions) }
 
            if ($PSCmdlet.ShouldProcess("wfsite", "Update Wf configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type wfsite -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetWfsite -Filter $Payload)
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
        Get Wf configuration object(s)
    .DESCRIPTION
        Get Wf configuration object(s)
    .PARAMETER sitename 
       Name of the WebFront site being created on the Citrix ADC. 
    .PARAMETER GetAll 
        Retreive all wfsite object(s)
    .PARAMETER Count
        If specified, the count of the wfsite object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetWfsite
    .EXAMPLE 
        Invoke-ADCGetWfsite -GetAll 
    .EXAMPLE 
        Invoke-ADCGetWfsite -Count
    .EXAMPLE
        Invoke-ADCGetWfsite -name <string>
    .EXAMPLE
        Invoke-ADCGetWfsite -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetWfsite
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wf/wfsite/
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
        [ValidateLength(1, 255)]
        [string]$sitename,

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
        Write-Verbose "Invoke-ADCGetWfsite: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all wfsite objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wfsite -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for wfsite objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wfsite -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving wfsite objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wfsite -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving wfsite configuration for property 'sitename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wfsite -NitroPath nitro/v1/config -Resource $sitename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving wfsite configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wfsite -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


