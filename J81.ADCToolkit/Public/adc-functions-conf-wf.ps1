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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAEpPbLLRcFJkb2
# dvZlO0mfDEqge3JBksW0NpGm5hcYY6CCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQgQ3/uJ3y+IWa3y2kNmMNU5lbP1IaDXsJaIs1M0qfrdj0wDQYJKoZIhvcNAQEB
# BQAEggEAjmqgS/ysu16vSAi6lGTjFcLlSxOAoSNCqdbO8xnk4+y/bBq+tA7AAbuX
# t3qJwVuIA0pSjdJUNnoT30u9NY7p5barny4V7cJyE2G9TJ/Y6nO0QLWctFhpWxzW
# d0HvBNAza4SwWP1I5VwZUgXj4lRH8fE87zMmc9jcfjMz1fgPOX+C9jkV7FloNoG1
# W6FZeEex0g4Z2bXs6j4rT1g8Rn53ofEPSIz/ZfihZ9YoX9omsWqANx6ys2OItsA4
# /PfHDzFSmMHmOmIYjoYGXOelpRx23qDi2JsGKxN2AzgIoDPelpjQ+xslFvjq6wuA
# HC25SBOp7n4Tn1QI5541Mcs0DUQE2A==
# SIG # End signature block
