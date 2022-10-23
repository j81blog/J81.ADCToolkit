function Invoke-ADCInstallWipackage {
    <#
    .SYNOPSIS
        Install WebInterface configuration Object.
    .DESCRIPTION
        Configuration for Web Interface resource.
    .PARAMETER Jre 
        Complete path to the JRE tar file. 
        You can use OpenJDK7 package for FreeBSD 8.x/amd64.The Java package can be downloaded from http://ftp-archive.freebsd.org/pub/FreeBSD-Archive/old-releases/amd64/amd64/8.4-RELEASE/packages/java/openjdk-7.17.02_2.tbz. 
    .PARAMETER Webinterface 
        Complete path to the Web Interface tar file for installing the Web Interface on the Citrix ADC. This file includes Apache Tomcat Web server. The file name has the following format: nswi-<version number>.tgz (for example, nswi-1.5.tgz). 
        NOTE: The Nitro parameter 'wi' cannot be used as a PowerShell parameter, therefore an alternative Parameter name was chosen. 
    .PARAMETER Maxsites 
        Maximum number of Web Interface sites that can be created on the Citrix ADC; changes the amount of RAM reserved for Web Interface usage; changing its value results in restart of Tomcat server and invalidates any existing Web Interface sessions. 
        Possible values = 3, 25, 50, 100, 200, 500
    .EXAMPLE
        PS C:\>Invoke-ADCInstallWipackage 
        An example how to install wipackage configuration Object(s).
    .NOTES
        File Name : Invoke-ADCInstallWipackage
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wipackage/
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
        [string]$Webinterface,

        [ValidateSet('3', '25', '50', '100', '200', '500')]
        [string]$Maxsites 

    )
    begin {
        Write-Verbose "Invoke-ADCInstallWipackage: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('jre') ) { $payload.Add('jre', $jre) }
            if ( $PSBoundParameters.ContainsKey('webinterface') ) { $payload.Add('wi', $webinterface) }
            if ( $PSBoundParameters.ContainsKey('maxsites') ) { $payload.Add('maxsites', $maxsites) }
            if ( $PSCmdlet.ShouldProcess($Name, "Install WebInterface configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type wipackage -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCInstallWipackage: Finished"
    }
}

function Invoke-ADCGetWipackage {
    <#
    .SYNOPSIS
        Get WebInterface configuration object(s).
    .DESCRIPTION
        Configuration for Web Interface resource.
    .PARAMETER GetAll 
        Retrieve all wipackage object(s).
    .PARAMETER Count
        If specified, the count of the wipackage object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWipackage
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetWipackage -GetAll 
        Get all wipackage data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWipackage -name <string>
        Get wipackage object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWipackage -Filter @{ 'name'='<value>' }
        Get wipackage data with a filter.
    .NOTES
        File Name : Invoke-ADCGetWipackage
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wipackage/
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
        Write-Verbose "Invoke-ADCGetWipackage: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all wipackage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wipackage -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for wipackage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wipackage -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving wipackage objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wipackage -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving wipackage configuration for property ''"

            } else {
                Write-Verbose "Retrieving wipackage configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wipackage -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetWipackage: Ended"
    }
}

function Invoke-ADCAddWisite {
    <#
    .SYNOPSIS
        Add WebInterface configuration Object.
    .DESCRIPTION
        Configuration for WI site resource.
    .PARAMETER Sitepath 
        Path to the Web Interface site being created on the Citrix ADC. 
    .PARAMETER Agurl 
        Call back URL of the Gateway. 
    .PARAMETER Staurl 
        URL of the Secure Ticket Authority (STA) server. 
    .PARAMETER Secondstaurl 
        URL of the second Secure Ticket Authority (STA) server. 
    .PARAMETER Sessionreliability 
        Enable session reliability through Access Gateway. 
        Possible values = ON, OFF 
    .PARAMETER Usetwotickets 
        Request tickets issued by two separate Secure Ticket Authorities (STA) when a resource is accessed. 
        Possible values = ON, OFF 
    .PARAMETER Authenticationpoint 
        Authentication point for the Web Interface site. 
        Possible values = WebInterface, AccessGateway 
    .PARAMETER Agauthenticationmethod 
        Method for authenticating a Web Interface site if you have specified Web Interface as the authentication point. 
        Available settings function as follows: 
        * Explicit - Users must provide a user name and password to log on to the Web Interface. 
        * Anonymous - Users can log on to the Web Interface without providing a user name and password. They have access to resources published for anonymous users. 
        Possible values = Explicit, SmartCard 
    .PARAMETER Wiauthenticationmethods 
        The method of authentication to be used at Web Interface. 
        Possible values = Explicit, Anonymous 
    .PARAMETER Defaultcustomtextlocale 
        Default language for the Web Interface site. 
        Possible values = German, English, Spanish, French, Japanese, Korean, Russian, Chinese_simplified, Chinese_traditional 
    .PARAMETER Websessiontimeout 
        Time-out, in minutes, for idle Web Interface browser sessions. If a client's session is idle for a time that exceeds the time-out value, the Citrix ADC terminates the connection. 
    .PARAMETER Defaultaccessmethod 
        Default access method for clients accessing the Web Interface site. 
        Note: Before you configure an access method based on the client IP address, you must enable USIP mode on the Web Interface service to make the client's IP address available with the Web Interface. 
        Depending on whether the Web Interface site is configured to use an HTTP or HTTPS virtual server or to use access gateway, you can send clients or access gateway the IP address, or the alternate address, of a XenApp or XenDesktop server. Or, you can send the IP address translated from a mapping entry, which defines mapping of an internal address and port to an external address and port. 
        Note: In the Citrix ADC command line, mapping entries can be created by using the bind wi site command. 
        Possible values = Direct, Alternate, Translated, GatewayDirect, GatewayAlternate, GatewayTranslated 
    .PARAMETER Logintitle 
        A custom login page title for the Web Interface site. 
    .PARAMETER Appwelcomemessage 
        Specifies localized text to appear at the top of the main content area of the Applications screen. LanguageCode is en, de, es, fr, ja, or any other supported language identifier. 
    .PARAMETER Welcomemessage 
        Localized welcome message that appears on the welcome area of the login screen. 
    .PARAMETER Footertext 
        Localized text that appears in the footer area of all pages. 
    .PARAMETER Loginsysmessage 
        Localized text that appears at the bottom of the main content area of the login screen. 
    .PARAMETER Preloginbutton 
        Localized text that appears as the name of the pre-login message confirmation button. 
    .PARAMETER Preloginmessage 
        Localized text that appears on the pre-login message page. 
    .PARAMETER Prelogintitle 
        Localized text that appears as the title of the pre-login message page. 
    .PARAMETER Domainselection 
        Domain names listed on the login screen for explicit authentication. 
    .PARAMETER Sitetype 
        Type of access to the Web Interface site. Available settings function as follows: 
        * XenApp/XenDesktop web site - Configures the Web Interface site for access by a web browser. 
        * XenApp/XenDesktop services site - Configures the Web Interface site for access by the XenApp plug-in. 
        Possible values = XenAppWeb, XenAppServices 
    .PARAMETER Userinterfacebranding 
        Specifies whether the site is focused towards users accessing applications or desktops. Setting the parameter to Desktops changes the functionality of the site to improve the experience for XenDesktop users. Citrix recommends using this setting for any deployment that includes XenDesktop. 
        Possible values = Desktops, Applications 
    .PARAMETER Publishedresourcetype 
        Method for accessing the published XenApp and XenDesktop resources. 
        Available settings function as follows: 
        * Online - Allows applications to be launched on the XenApp and XenDesktop servers. 
        * Offline - Allows streaming of applications to the client. 
        * DualMode - Allows both online and offline modes. 
        Possible values = Online, Offline, DualMode 
    .PARAMETER Kioskmode 
        User settings do not persist from one session to another. 
        Possible values = ON, OFF 
    .PARAMETER Showsearch 
        Enables search option on XenApp websites. 
        Possible values = ON, OFF 
    .PARAMETER Showrefresh 
        Provides the Refresh button on the applications screen. 
        Possible values = ON, OFF 
    .PARAMETER Wiuserinterfacemodes 
        Appearance of the login screen. 
        * Simple - Only the login fields for the selected authentication method are displayed. 
        * Advanced - Displays the navigation bar, which provides access to the pre-login messages and preferences screens. 
        Possible values = SIMPLE, ADVANCED 
    .PARAMETER Userinterfacelayouts 
        Specifies whether or not to use the compact user interface. 
        Possible values = AUTO, NORMAL, COMPACT 
    .PARAMETER Restrictdomains 
        The RestrictDomains setting is used to enable/disable domain restrictions. If domain restriction is enabled, the LoginDomains list is used for validating the login domain. It is applied to all the authentication methods except Anonymous for XenApp Web and XenApp Services sites. 
        Possible values = ON, OFF 
    .PARAMETER Logindomains 
        [List of NetBIOS domain names], Domain names to use for access restriction. 
        Only takes effect when used in conjunction with the RestrictDomains setting. 
    .PARAMETER Hidedomainfield 
        The HideDomainField setting is used to control whether the domain field is displayed on the logon screen. 
        Possible values = ON, OFF 
    .PARAMETER Agcallbackurl 
        Callback AGURL to which Web Interface contacts. . 
    .PARAMETER PassThru 
        Return details about the created wisite item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddWisite -sitepath <string>
        An example how to add wisite configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddWisite
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite/
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
        [ValidateLength(1, 250)]
        [string]$Sitepath,

        [ValidateLength(1, 255)]
        [string]$Agurl,

        [ValidateLength(1, 255)]
        [string]$Staurl,

        [ValidateLength(1, 255)]
        [string]$Secondstaurl,

        [ValidateSet('ON', 'OFF')]
        [string]$Sessionreliability = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Usetwotickets = 'OFF',

        [ValidateSet('WebInterface', 'AccessGateway')]
        [string]$Authenticationpoint,

        [ValidateSet('Explicit', 'SmartCard')]
        [string]$Agauthenticationmethod,

        [ValidateSet('Explicit', 'Anonymous')]
        [string[]]$Wiauthenticationmethods = 'Explicit',

        [ValidateSet('German', 'English', 'Spanish', 'French', 'Japanese', 'Korean', 'Russian', 'Chinese_simplified', 'Chinese_traditional')]
        [string]$Defaultcustomtextlocale = 'English',

        [ValidateRange(1, 1440)]
        [double]$Websessiontimeout = '20',

        [ValidateSet('Direct', 'Alternate', 'Translated', 'GatewayDirect', 'GatewayAlternate', 'GatewayTranslated')]
        [string]$Defaultaccessmethod,

        [ValidateLength(1, 255)]
        [string]$Logintitle = '"Welcome to Web Interface on NetScaler"',

        [ValidateLength(1, 255)]
        [string]$Appwelcomemessage,

        [ValidateLength(1, 255)]
        [string]$Welcomemessage,

        [ValidateLength(1, 255)]
        [string]$Footertext,

        [ValidateLength(1, 255)]
        [string]$Loginsysmessage,

        [ValidateLength(1, 255)]
        [string]$Preloginbutton,

        [ValidateLength(1, 2048)]
        [string]$Preloginmessage,

        [ValidateLength(1, 255)]
        [string]$Prelogintitle,

        [ValidateLength(1, 255)]
        [string]$Domainselection,

        [ValidateSet('XenAppWeb', 'XenAppServices')]
        [string]$Sitetype = 'XenAppWeb',

        [ValidateSet('Desktops', 'Applications')]
        [string]$Userinterfacebranding = 'Applications',

        [ValidateSet('Online', 'Offline', 'DualMode')]
        [string]$Publishedresourcetype = 'Online',

        [ValidateSet('ON', 'OFF')]
        [string]$Kioskmode = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Showsearch = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Showrefresh = 'OFF',

        [ValidateSet('SIMPLE', 'ADVANCED')]
        [string]$Wiuserinterfacemodes = 'SIMPLE',

        [ValidateSet('AUTO', 'NORMAL', 'COMPACT')]
        [string]$Userinterfacelayouts = 'AUTO',

        [ValidateSet('ON', 'OFF')]
        [string]$Restrictdomains = 'OFF',

        [ValidateLength(1, 255)]
        [string]$Logindomains,

        [ValidateSet('ON', 'OFF')]
        [string]$Hidedomainfield = 'OFF',

        [ValidateLength(1, 255)]
        [string]$Agcallbackurl,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddWisite: Starting"
    }
    process {
        try {
            $payload = @{ sitepath = $sitepath }
            if ( $PSBoundParameters.ContainsKey('agurl') ) { $payload.Add('agurl', $agurl) }
            if ( $PSBoundParameters.ContainsKey('staurl') ) { $payload.Add('staurl', $staurl) }
            if ( $PSBoundParameters.ContainsKey('secondstaurl') ) { $payload.Add('secondstaurl', $secondstaurl) }
            if ( $PSBoundParameters.ContainsKey('sessionreliability') ) { $payload.Add('sessionreliability', $sessionreliability) }
            if ( $PSBoundParameters.ContainsKey('usetwotickets') ) { $payload.Add('usetwotickets', $usetwotickets) }
            if ( $PSBoundParameters.ContainsKey('authenticationpoint') ) { $payload.Add('authenticationpoint', $authenticationpoint) }
            if ( $PSBoundParameters.ContainsKey('agauthenticationmethod') ) { $payload.Add('agauthenticationmethod', $agauthenticationmethod) }
            if ( $PSBoundParameters.ContainsKey('wiauthenticationmethods') ) { $payload.Add('wiauthenticationmethods', $wiauthenticationmethods) }
            if ( $PSBoundParameters.ContainsKey('defaultcustomtextlocale') ) { $payload.Add('defaultcustomtextlocale', $defaultcustomtextlocale) }
            if ( $PSBoundParameters.ContainsKey('websessiontimeout') ) { $payload.Add('websessiontimeout', $websessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('defaultaccessmethod') ) { $payload.Add('defaultaccessmethod', $defaultaccessmethod) }
            if ( $PSBoundParameters.ContainsKey('logintitle') ) { $payload.Add('logintitle', $logintitle) }
            if ( $PSBoundParameters.ContainsKey('appwelcomemessage') ) { $payload.Add('appwelcomemessage', $appwelcomemessage) }
            if ( $PSBoundParameters.ContainsKey('welcomemessage') ) { $payload.Add('welcomemessage', $welcomemessage) }
            if ( $PSBoundParameters.ContainsKey('footertext') ) { $payload.Add('footertext', $footertext) }
            if ( $PSBoundParameters.ContainsKey('loginsysmessage') ) { $payload.Add('loginsysmessage', $loginsysmessage) }
            if ( $PSBoundParameters.ContainsKey('preloginbutton') ) { $payload.Add('preloginbutton', $preloginbutton) }
            if ( $PSBoundParameters.ContainsKey('preloginmessage') ) { $payload.Add('preloginmessage', $preloginmessage) }
            if ( $PSBoundParameters.ContainsKey('prelogintitle') ) { $payload.Add('prelogintitle', $prelogintitle) }
            if ( $PSBoundParameters.ContainsKey('domainselection') ) { $payload.Add('domainselection', $domainselection) }
            if ( $PSBoundParameters.ContainsKey('sitetype') ) { $payload.Add('sitetype', $sitetype) }
            if ( $PSBoundParameters.ContainsKey('userinterfacebranding') ) { $payload.Add('userinterfacebranding', $userinterfacebranding) }
            if ( $PSBoundParameters.ContainsKey('publishedresourcetype') ) { $payload.Add('publishedresourcetype', $publishedresourcetype) }
            if ( $PSBoundParameters.ContainsKey('kioskmode') ) { $payload.Add('kioskmode', $kioskmode) }
            if ( $PSBoundParameters.ContainsKey('showsearch') ) { $payload.Add('showsearch', $showsearch) }
            if ( $PSBoundParameters.ContainsKey('showrefresh') ) { $payload.Add('showrefresh', $showrefresh) }
            if ( $PSBoundParameters.ContainsKey('wiuserinterfacemodes') ) { $payload.Add('wiuserinterfacemodes', $wiuserinterfacemodes) }
            if ( $PSBoundParameters.ContainsKey('userinterfacelayouts') ) { $payload.Add('userinterfacelayouts', $userinterfacelayouts) }
            if ( $PSBoundParameters.ContainsKey('restrictdomains') ) { $payload.Add('restrictdomains', $restrictdomains) }
            if ( $PSBoundParameters.ContainsKey('logindomains') ) { $payload.Add('logindomains', $logindomains) }
            if ( $PSBoundParameters.ContainsKey('hidedomainfield') ) { $payload.Add('hidedomainfield', $hidedomainfield) }
            if ( $PSBoundParameters.ContainsKey('agcallbackurl') ) { $payload.Add('agcallbackurl', $agcallbackurl) }
            if ( $PSCmdlet.ShouldProcess("wisite", "Add WebInterface configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type wisite -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetWisite -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddWisite: Finished"
    }
}

function Invoke-ADCDeleteWisite {
    <#
    .SYNOPSIS
        Delete WebInterface configuration Object.
    .DESCRIPTION
        Configuration for WI site resource.
    .PARAMETER Sitepath 
        Path to the Web Interface site being created on the Citrix ADC.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteWisite -Sitepath <string>
        An example how to delete wisite configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteWisite
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite/
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
        [string]$Sitepath 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteWisite: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$sitepath", "Delete WebInterface configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type wisite -NitroPath nitro/v1/config -Resource $sitepath -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteWisite: Finished"
    }
}

function Invoke-ADCUpdateWisite {
    <#
    .SYNOPSIS
        Update WebInterface configuration Object.
    .DESCRIPTION
        Configuration for WI site resource.
    .PARAMETER Sitepath 
        Path to the Web Interface site being created on the Citrix ADC. 
    .PARAMETER Agurl 
        Call back URL of the Gateway. 
    .PARAMETER Staurl 
        URL of the Secure Ticket Authority (STA) server. 
    .PARAMETER Sessionreliability 
        Enable session reliability through Access Gateway. 
        Possible values = ON, OFF 
    .PARAMETER Usetwotickets 
        Request tickets issued by two separate Secure Ticket Authorities (STA) when a resource is accessed. 
        Possible values = ON, OFF 
    .PARAMETER Secondstaurl 
        URL of the second Secure Ticket Authority (STA) server. 
    .PARAMETER Wiauthenticationmethods 
        The method of authentication to be used at Web Interface. 
        Possible values = Explicit, Anonymous 
    .PARAMETER Defaultaccessmethod 
        Default access method for clients accessing the Web Interface site. 
        Note: Before you configure an access method based on the client IP address, you must enable USIP mode on the Web Interface service to make the client's IP address available with the Web Interface. 
        Depending on whether the Web Interface site is configured to use an HTTP or HTTPS virtual server or to use access gateway, you can send clients or access gateway the IP address, or the alternate address, of a XenApp or XenDesktop server. Or, you can send the IP address translated from a mapping entry, which defines mapping of an internal address and port to an external address and port. 
        Note: In the Citrix ADC command line, mapping entries can be created by using the bind wi site command. 
        Possible values = Direct, Alternate, Translated, GatewayDirect, GatewayAlternate, GatewayTranslated 
    .PARAMETER Defaultcustomtextlocale 
        Default language for the Web Interface site. 
        Possible values = German, English, Spanish, French, Japanese, Korean, Russian, Chinese_simplified, Chinese_traditional 
    .PARAMETER Websessiontimeout 
        Time-out, in minutes, for idle Web Interface browser sessions. If a client's session is idle for a time that exceeds the time-out value, the Citrix ADC terminates the connection. 
    .PARAMETER Logintitle 
        A custom login page title for the Web Interface site. 
    .PARAMETER Appwelcomemessage 
        Specifies localized text to appear at the top of the main content area of the Applications screen. LanguageCode is en, de, es, fr, ja, or any other supported language identifier. 
    .PARAMETER Welcomemessage 
        Localized welcome message that appears on the welcome area of the login screen. 
    .PARAMETER Footertext 
        Localized text that appears in the footer area of all pages. 
    .PARAMETER Loginsysmessage 
        Localized text that appears at the bottom of the main content area of the login screen. 
    .PARAMETER Preloginbutton 
        Localized text that appears as the name of the pre-login message confirmation button. 
    .PARAMETER Preloginmessage 
        Localized text that appears on the pre-login message page. 
    .PARAMETER Prelogintitle 
        Localized text that appears as the title of the pre-login message page. 
    .PARAMETER Domainselection 
        Domain names listed on the login screen for explicit authentication. 
    .PARAMETER Userinterfacebranding 
        Specifies whether the site is focused towards users accessing applications or desktops. Setting the parameter to Desktops changes the functionality of the site to improve the experience for XenDesktop users. Citrix recommends using this setting for any deployment that includes XenDesktop. 
        Possible values = Desktops, Applications 
    .PARAMETER Authenticationpoint 
        Authentication point for the Web Interface site. 
        Possible values = WebInterface, AccessGateway 
    .PARAMETER Agauthenticationmethod 
        Method for authenticating a Web Interface site if you have specified Web Interface as the authentication point. 
        Available settings function as follows: 
        * Explicit - Users must provide a user name and password to log on to the Web Interface. 
        * Anonymous - Users can log on to the Web Interface without providing a user name and password. They have access to resources published for anonymous users. 
        Possible values = Explicit, SmartCard 
    .PARAMETER Publishedresourcetype 
        Method for accessing the published XenApp and XenDesktop resources. 
        Available settings function as follows: 
        * Online - Allows applications to be launched on the XenApp and XenDesktop servers. 
        * Offline - Allows streaming of applications to the client. 
        * DualMode - Allows both online and offline modes. 
        Possible values = Online, Offline, DualMode 
    .PARAMETER Kioskmode 
        User settings do not persist from one session to another. 
        Possible values = ON, OFF 
    .PARAMETER Showsearch 
        Enables search option on XenApp websites. 
        Possible values = ON, OFF 
    .PARAMETER Showrefresh 
        Provides the Refresh button on the applications screen. 
        Possible values = ON, OFF 
    .PARAMETER Wiuserinterfacemodes 
        Appearance of the login screen. 
        * Simple - Only the login fields for the selected authentication method are displayed. 
        * Advanced - Displays the navigation bar, which provides access to the pre-login messages and preferences screens. 
        Possible values = SIMPLE, ADVANCED 
    .PARAMETER Userinterfacelayouts 
        Specifies whether or not to use the compact user interface. 
        Possible values = AUTO, NORMAL, COMPACT 
    .PARAMETER Restrictdomains 
        The RestrictDomains setting is used to enable/disable domain restrictions. If domain restriction is enabled, the LoginDomains list is used for validating the login domain. It is applied to all the authentication methods except Anonymous for XenApp Web and XenApp Services sites. 
        Possible values = ON, OFF 
    .PARAMETER Logindomains 
        [List of NetBIOS domain names], Domain names to use for access restriction. 
        Only takes effect when used in conjunction with the RestrictDomains setting. 
    .PARAMETER Hidedomainfield 
        The HideDomainField setting is used to control whether the domain field is displayed on the logon screen. 
        Possible values = ON, OFF 
    .PARAMETER Agcallbackurl 
        Callback AGURL to which Web Interface contacts. . 
    .PARAMETER PassThru 
        Return details about the created wisite item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateWisite -sitepath <string>
        An example how to update wisite configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateWisite
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite/
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
        [ValidateLength(1, 250)]
        [string]$Sitepath,

        [ValidateLength(1, 255)]
        [string]$Agurl,

        [ValidateLength(1, 255)]
        [string]$Staurl,

        [ValidateSet('ON', 'OFF')]
        [string]$Sessionreliability,

        [ValidateSet('ON', 'OFF')]
        [string]$Usetwotickets,

        [ValidateLength(1, 255)]
        [string]$Secondstaurl,

        [ValidateSet('Explicit', 'Anonymous')]
        [string[]]$Wiauthenticationmethods,

        [ValidateSet('Direct', 'Alternate', 'Translated', 'GatewayDirect', 'GatewayAlternate', 'GatewayTranslated')]
        [string]$Defaultaccessmethod,

        [ValidateSet('German', 'English', 'Spanish', 'French', 'Japanese', 'Korean', 'Russian', 'Chinese_simplified', 'Chinese_traditional')]
        [string]$Defaultcustomtextlocale,

        [ValidateRange(1, 1440)]
        [double]$Websessiontimeout,

        [ValidateLength(1, 255)]
        [string]$Logintitle,

        [ValidateLength(1, 255)]
        [string]$Appwelcomemessage,

        [ValidateLength(1, 255)]
        [string]$Welcomemessage,

        [ValidateLength(1, 255)]
        [string]$Footertext,

        [ValidateLength(1, 255)]
        [string]$Loginsysmessage,

        [ValidateLength(1, 255)]
        [string]$Preloginbutton,

        [ValidateLength(1, 2048)]
        [string]$Preloginmessage,

        [ValidateLength(1, 255)]
        [string]$Prelogintitle,

        [ValidateLength(1, 255)]
        [string]$Domainselection,

        [ValidateSet('Desktops', 'Applications')]
        [string]$Userinterfacebranding,

        [ValidateSet('WebInterface', 'AccessGateway')]
        [string]$Authenticationpoint,

        [ValidateSet('Explicit', 'SmartCard')]
        [string]$Agauthenticationmethod,

        [ValidateSet('Online', 'Offline', 'DualMode')]
        [string]$Publishedresourcetype,

        [ValidateSet('ON', 'OFF')]
        [string]$Kioskmode,

        [ValidateSet('ON', 'OFF')]
        [string]$Showsearch,

        [ValidateSet('ON', 'OFF')]
        [string]$Showrefresh,

        [ValidateSet('SIMPLE', 'ADVANCED')]
        [string]$Wiuserinterfacemodes,

        [ValidateSet('AUTO', 'NORMAL', 'COMPACT')]
        [string]$Userinterfacelayouts,

        [ValidateSet('ON', 'OFF')]
        [string]$Restrictdomains,

        [ValidateLength(1, 255)]
        [string]$Logindomains,

        [ValidateSet('ON', 'OFF')]
        [string]$Hidedomainfield,

        [ValidateLength(1, 255)]
        [string]$Agcallbackurl,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateWisite: Starting"
    }
    process {
        try {
            $payload = @{ sitepath = $sitepath }
            if ( $PSBoundParameters.ContainsKey('agurl') ) { $payload.Add('agurl', $agurl) }
            if ( $PSBoundParameters.ContainsKey('staurl') ) { $payload.Add('staurl', $staurl) }
            if ( $PSBoundParameters.ContainsKey('sessionreliability') ) { $payload.Add('sessionreliability', $sessionreliability) }
            if ( $PSBoundParameters.ContainsKey('usetwotickets') ) { $payload.Add('usetwotickets', $usetwotickets) }
            if ( $PSBoundParameters.ContainsKey('secondstaurl') ) { $payload.Add('secondstaurl', $secondstaurl) }
            if ( $PSBoundParameters.ContainsKey('wiauthenticationmethods') ) { $payload.Add('wiauthenticationmethods', $wiauthenticationmethods) }
            if ( $PSBoundParameters.ContainsKey('defaultaccessmethod') ) { $payload.Add('defaultaccessmethod', $defaultaccessmethod) }
            if ( $PSBoundParameters.ContainsKey('defaultcustomtextlocale') ) { $payload.Add('defaultcustomtextlocale', $defaultcustomtextlocale) }
            if ( $PSBoundParameters.ContainsKey('websessiontimeout') ) { $payload.Add('websessiontimeout', $websessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('logintitle') ) { $payload.Add('logintitle', $logintitle) }
            if ( $PSBoundParameters.ContainsKey('appwelcomemessage') ) { $payload.Add('appwelcomemessage', $appwelcomemessage) }
            if ( $PSBoundParameters.ContainsKey('welcomemessage') ) { $payload.Add('welcomemessage', $welcomemessage) }
            if ( $PSBoundParameters.ContainsKey('footertext') ) { $payload.Add('footertext', $footertext) }
            if ( $PSBoundParameters.ContainsKey('loginsysmessage') ) { $payload.Add('loginsysmessage', $loginsysmessage) }
            if ( $PSBoundParameters.ContainsKey('preloginbutton') ) { $payload.Add('preloginbutton', $preloginbutton) }
            if ( $PSBoundParameters.ContainsKey('preloginmessage') ) { $payload.Add('preloginmessage', $preloginmessage) }
            if ( $PSBoundParameters.ContainsKey('prelogintitle') ) { $payload.Add('prelogintitle', $prelogintitle) }
            if ( $PSBoundParameters.ContainsKey('domainselection') ) { $payload.Add('domainselection', $domainselection) }
            if ( $PSBoundParameters.ContainsKey('userinterfacebranding') ) { $payload.Add('userinterfacebranding', $userinterfacebranding) }
            if ( $PSBoundParameters.ContainsKey('authenticationpoint') ) { $payload.Add('authenticationpoint', $authenticationpoint) }
            if ( $PSBoundParameters.ContainsKey('agauthenticationmethod') ) { $payload.Add('agauthenticationmethod', $agauthenticationmethod) }
            if ( $PSBoundParameters.ContainsKey('publishedresourcetype') ) { $payload.Add('publishedresourcetype', $publishedresourcetype) }
            if ( $PSBoundParameters.ContainsKey('kioskmode') ) { $payload.Add('kioskmode', $kioskmode) }
            if ( $PSBoundParameters.ContainsKey('showsearch') ) { $payload.Add('showsearch', $showsearch) }
            if ( $PSBoundParameters.ContainsKey('showrefresh') ) { $payload.Add('showrefresh', $showrefresh) }
            if ( $PSBoundParameters.ContainsKey('wiuserinterfacemodes') ) { $payload.Add('wiuserinterfacemodes', $wiuserinterfacemodes) }
            if ( $PSBoundParameters.ContainsKey('userinterfacelayouts') ) { $payload.Add('userinterfacelayouts', $userinterfacelayouts) }
            if ( $PSBoundParameters.ContainsKey('restrictdomains') ) { $payload.Add('restrictdomains', $restrictdomains) }
            if ( $PSBoundParameters.ContainsKey('logindomains') ) { $payload.Add('logindomains', $logindomains) }
            if ( $PSBoundParameters.ContainsKey('hidedomainfield') ) { $payload.Add('hidedomainfield', $hidedomainfield) }
            if ( $PSBoundParameters.ContainsKey('agcallbackurl') ) { $payload.Add('agcallbackurl', $agcallbackurl) }
            if ( $PSCmdlet.ShouldProcess("wisite", "Update WebInterface configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type wisite -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetWisite -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateWisite: Finished"
    }
}

function Invoke-ADCUnsetWisite {
    <#
    .SYNOPSIS
        Unset WebInterface configuration Object.
    .DESCRIPTION
        Configuration for WI site resource.
    .PARAMETER Sitepath 
        Path to the Web Interface site being created on the Citrix ADC. 
    .PARAMETER Appwelcomemessage 
        Specifies localized text to appear at the top of the main content area of the Applications screen. LanguageCode is en, de, es, fr, ja, or any other supported language identifier. 
    .PARAMETER Welcomemessage 
        Localized welcome message that appears on the welcome area of the login screen. 
    .PARAMETER Footertext 
        Localized text that appears in the footer area of all pages. 
    .PARAMETER Loginsysmessage 
        Localized text that appears at the bottom of the main content area of the login screen. 
    .PARAMETER Preloginbutton 
        Localized text that appears as the name of the pre-login message confirmation button. 
    .PARAMETER Preloginmessage 
        Localized text that appears on the pre-login message page. 
    .PARAMETER Prelogintitle 
        Localized text that appears as the title of the pre-login message page. 
    .PARAMETER Userinterfacebranding 
        Specifies whether the site is focused towards users accessing applications or desktops. Setting the parameter to Desktops changes the functionality of the site to improve the experience for XenDesktop users. Citrix recommends using this setting for any deployment that includes XenDesktop. 
        Possible values = Desktops, Applications 
    .PARAMETER Logindomains 
        [List of NetBIOS domain names], Domain names to use for access restriction. 
        Only takes effect when used in conjunction with the RestrictDomains setting.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetWisite -sitepath <string>
        An example how to unset wisite configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetWisite
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite
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

        [ValidateLength(1, 250)]
        [string]$Sitepath,

        [Boolean]$appwelcomemessage,

        [Boolean]$welcomemessage,

        [Boolean]$footertext,

        [Boolean]$loginsysmessage,

        [Boolean]$preloginbutton,

        [Boolean]$preloginmessage,

        [Boolean]$prelogintitle,

        [Boolean]$userinterfacebranding,

        [Boolean]$logindomains 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetWisite: Starting"
    }
    process {
        try {
            $payload = @{ sitepath = $sitepath }
            if ( $PSBoundParameters.ContainsKey('appwelcomemessage') ) { $payload.Add('appwelcomemessage', $appwelcomemessage) }
            if ( $PSBoundParameters.ContainsKey('welcomemessage') ) { $payload.Add('welcomemessage', $welcomemessage) }
            if ( $PSBoundParameters.ContainsKey('footertext') ) { $payload.Add('footertext', $footertext) }
            if ( $PSBoundParameters.ContainsKey('loginsysmessage') ) { $payload.Add('loginsysmessage', $loginsysmessage) }
            if ( $PSBoundParameters.ContainsKey('preloginbutton') ) { $payload.Add('preloginbutton', $preloginbutton) }
            if ( $PSBoundParameters.ContainsKey('preloginmessage') ) { $payload.Add('preloginmessage', $preloginmessage) }
            if ( $PSBoundParameters.ContainsKey('prelogintitle') ) { $payload.Add('prelogintitle', $prelogintitle) }
            if ( $PSBoundParameters.ContainsKey('userinterfacebranding') ) { $payload.Add('userinterfacebranding', $userinterfacebranding) }
            if ( $PSBoundParameters.ContainsKey('logindomains') ) { $payload.Add('logindomains', $logindomains) }
            if ( $PSCmdlet.ShouldProcess("$sitepath", "Unset WebInterface configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type wisite -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetWisite: Finished"
    }
}

function Invoke-ADCGetWisite {
    <#
    .SYNOPSIS
        Get WebInterface configuration object(s).
    .DESCRIPTION
        Configuration for WI site resource.
    .PARAMETER Sitepath 
        Path to the Web Interface site being created on the Citrix ADC. 
    .PARAMETER GetAll 
        Retrieve all wisite object(s).
    .PARAMETER Count
        If specified, the count of the wisite object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWisite
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetWisite -GetAll 
        Get all wisite data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetWisite -Count 
        Get the number of wisite objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWisite -name <string>
        Get wisite object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWisite -Filter @{ 'name'='<value>' }
        Get wisite data with a filter.
    .NOTES
        File Name : Invoke-ADCGetWisite
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite/
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
        [ValidateLength(1, 250)]
        [string]$Sitepath,

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
        Write-Verbose "Invoke-ADCGetWisite: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all wisite objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for wisite objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving wisite objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving wisite configuration for property 'sitepath'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite -NitroPath nitro/v1/config -Resource $sitepath -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving wisite configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetWisite: Ended"
    }
}

function Invoke-ADCAddWisiteaccessmethodbinding {
    <#
    .SYNOPSIS
        Add WebInterface configuration Object.
    .DESCRIPTION
        Binding object showing the accessmethod that can be bound to wisite.
    .PARAMETER Sitepath 
        Path to the Web Interface site. 
    .PARAMETER Accessmethod 
        Secure access method to be applied to the IPv4 or network address of the client specified by the Client IP Address parameter. Depending on whether the Web Interface site is configured to use an HTTP or HTTPS virtual server or to use access gateway, you can send clients or access gateway the IP address, or the alternate address, of a XenApp or XenDesktop server. Or, you can send the IP address translated from a mapping entry, which defines mapping of an internal address and port to an external address and port. 
        Possible values = Direct, Alternate, Translated, GatewayDirect, GatewayAlternate, GatewayTranslated 
    .PARAMETER Clientipaddress 
        IPv4 or network address of the client for which you want to associate an access method. 
    .PARAMETER Clientnetmask 
        Subnet mask associated with the IPv4 or network address specified by the Client IP Address parameter. 
    .PARAMETER PassThru 
        Return details about the created wisite_accessmethod_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddWisiteaccessmethodbinding -sitepath <string>
        An example how to add wisite_accessmethod_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddWisiteaccessmethodbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_accessmethod_binding/
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
        [ValidateLength(1, 250)]
        [string]$Sitepath,

        [ValidateSet('Direct', 'Alternate', 'Translated', 'GatewayDirect', 'GatewayAlternate', 'GatewayTranslated')]
        [string]$Accessmethod,

        [string]$Clientipaddress = '0',

        [string]$Clientnetmask = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddWisiteaccessmethodbinding: Starting"
    }
    process {
        try {
            $payload = @{ sitepath = $sitepath }
            if ( $PSBoundParameters.ContainsKey('accessmethod') ) { $payload.Add('accessmethod', $accessmethod) }
            if ( $PSBoundParameters.ContainsKey('clientipaddress') ) { $payload.Add('clientipaddress', $clientipaddress) }
            if ( $PSBoundParameters.ContainsKey('clientnetmask') ) { $payload.Add('clientnetmask', $clientnetmask) }
            if ( $PSCmdlet.ShouldProcess("wisite_accessmethod_binding", "Add WebInterface configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type wisite_accessmethod_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetWisiteaccessmethodbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddWisiteaccessmethodbinding: Finished"
    }
}

function Invoke-ADCDeleteWisiteaccessmethodbinding {
    <#
    .SYNOPSIS
        Delete WebInterface configuration Object.
    .DESCRIPTION
        Binding object showing the accessmethod that can be bound to wisite.
    .PARAMETER Sitepath 
        Path to the Web Interface site. 
    .PARAMETER Clientipaddress 
        IPv4 or network address of the client for which you want to associate an access method. 
    .PARAMETER Clientnetmask 
        Subnet mask associated with the IPv4 or network address specified by the Client IP Address parameter.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteWisiteaccessmethodbinding -Sitepath <string>
        An example how to delete wisite_accessmethod_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteWisiteaccessmethodbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_accessmethod_binding/
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
        [string]$Sitepath,

        [string]$Clientipaddress,

        [string]$Clientnetmask 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteWisiteaccessmethodbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Clientipaddress') ) { $arguments.Add('clientipaddress', $Clientipaddress) }
            if ( $PSBoundParameters.ContainsKey('Clientnetmask') ) { $arguments.Add('clientnetmask', $Clientnetmask) }
            if ( $PSCmdlet.ShouldProcess("$sitepath", "Delete WebInterface configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type wisite_accessmethod_binding -NitroPath nitro/v1/config -Resource $sitepath -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteWisiteaccessmethodbinding: Finished"
    }
}

function Invoke-ADCGetWisiteaccessmethodbinding {
    <#
    .SYNOPSIS
        Get WebInterface configuration object(s).
    .DESCRIPTION
        Binding object showing the accessmethod that can be bound to wisite.
    .PARAMETER Sitepath 
        Path to the Web Interface site. 
    .PARAMETER GetAll 
        Retrieve all wisite_accessmethod_binding object(s).
    .PARAMETER Count
        If specified, the count of the wisite_accessmethod_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWisiteaccessmethodbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetWisiteaccessmethodbinding -GetAll 
        Get all wisite_accessmethod_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetWisiteaccessmethodbinding -Count 
        Get the number of wisite_accessmethod_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWisiteaccessmethodbinding -name <string>
        Get wisite_accessmethod_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWisiteaccessmethodbinding -Filter @{ 'name'='<value>' }
        Get wisite_accessmethod_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetWisiteaccessmethodbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_accessmethod_binding/
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
        [ValidateLength(1, 250)]
        [string]$Sitepath,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetWisiteaccessmethodbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all wisite_accessmethod_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_accessmethod_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for wisite_accessmethod_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_accessmethod_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving wisite_accessmethod_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_accessmethod_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving wisite_accessmethod_binding configuration for property 'sitepath'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_accessmethod_binding -NitroPath nitro/v1/config -Resource $sitepath -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving wisite_accessmethod_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_accessmethod_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetWisiteaccessmethodbinding: Ended"
    }
}

function Invoke-ADCGetWisitebinding {
    <#
    .SYNOPSIS
        Get WebInterface configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to wisite.
    .PARAMETER Sitepath 
        Path of a Web Interface site whose details you want the Citrix ADC to display. 
    .PARAMETER GetAll 
        Retrieve all wisite_binding object(s).
    .PARAMETER Count
        If specified, the count of the wisite_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWisitebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetWisitebinding -GetAll 
        Get all wisite_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWisitebinding -name <string>
        Get wisite_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWisitebinding -Filter @{ 'name'='<value>' }
        Get wisite_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetWisitebinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_binding/
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
        [ValidateLength(1, 250)]
        [string]$Sitepath,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetWisitebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all wisite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for wisite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving wisite_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving wisite_binding configuration for property 'sitepath'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_binding -NitroPath nitro/v1/config -Resource $sitepath -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving wisite_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetWisitebinding: Ended"
    }
}

function Invoke-ADCAddWisitefarmnamebinding {
    <#
    .SYNOPSIS
        Add WebInterface configuration Object.
    .DESCRIPTION
        Binding object showing the farmname that can be bound to wisite.
    .PARAMETER Sitepath 
        Path to the Web Interface site. 
    .PARAMETER Farmname 
        Name for the logical representation of a XenApp or XenDesktop farm to be bound to the Web Interface site. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Xmlserveraddresses 
        Comma-separated IP addresses or host names of XenApp or XenDesktop servers providing XML services. 
    .PARAMETER Groups 
        Active Directory groups that are permitted to enumerate resources from server farms. Including a setting for this parameter activates the user roaming feature. A maximum of 512 user groups can be specified for each farm defined with the Farm<n> parameter. The groups must be comma separated. 
    .PARAMETER Recoveryfarm 
        Binded farm is set as a recovery farm. 
        Possible values = ON, OFF 
    .PARAMETER Xmlport 
        Port number at which to contact the XML service. 
    .PARAMETER Transport 
        Transport protocol to use for transferring data, related to the Web Interface site, between the Citrix ADC and the XML service. 
        Possible values = HTTP, HTTPS, SSLRELAY 
    .PARAMETER Sslrelayport 
        TCP port at which the XenApp or XenDesktop servers listenfor SSL Relay traffic from the Citrix ADC. This parameter is required if you have set SSL Relay as the transport protocol. Web Interface uses root certificates when authenticating a server running SSL Relay. Make sure that all the servers running SSL Relay are configured to listen on the same port. 
    .PARAMETER Loadbalance 
        Use all the XML servers (load balancing mode) or only one server (failover mode). 
        Possible values = ON, OFF 
    .PARAMETER PassThru 
        Return details about the created wisite_farmname_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddWisitefarmnamebinding -sitepath <string>
        An example how to add wisite_farmname_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddWisitefarmnamebinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_farmname_binding/
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
        [ValidateLength(1, 250)]
        [string]$Sitepath,

        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Farmname,

        [string]$Xmlserveraddresses,

        [string]$Groups,

        [ValidateSet('ON', 'OFF')]
        [string]$Recoveryfarm = 'OFF',

        [double]$Xmlport,

        [ValidateSet('HTTP', 'HTTPS', 'SSLRELAY')]
        [string]$Transport,

        [double]$Sslrelayport,

        [ValidateSet('ON', 'OFF')]
        [string]$Loadbalance,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddWisitefarmnamebinding: Starting"
    }
    process {
        try {
            $payload = @{ sitepath = $sitepath }
            if ( $PSBoundParameters.ContainsKey('farmname') ) { $payload.Add('farmname', $farmname) }
            if ( $PSBoundParameters.ContainsKey('xmlserveraddresses') ) { $payload.Add('xmlserveraddresses', $xmlserveraddresses) }
            if ( $PSBoundParameters.ContainsKey('groups') ) { $payload.Add('groups', $groups) }
            if ( $PSBoundParameters.ContainsKey('recoveryfarm') ) { $payload.Add('recoveryfarm', $recoveryfarm) }
            if ( $PSBoundParameters.ContainsKey('xmlport') ) { $payload.Add('xmlport', $xmlport) }
            if ( $PSBoundParameters.ContainsKey('transport') ) { $payload.Add('transport', $transport) }
            if ( $PSBoundParameters.ContainsKey('sslrelayport') ) { $payload.Add('sslrelayport', $sslrelayport) }
            if ( $PSBoundParameters.ContainsKey('loadbalance') ) { $payload.Add('loadbalance', $loadbalance) }
            if ( $PSCmdlet.ShouldProcess("wisite_farmname_binding", "Add WebInterface configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type wisite_farmname_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetWisitefarmnamebinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddWisitefarmnamebinding: Finished"
    }
}

function Invoke-ADCDeleteWisitefarmnamebinding {
    <#
    .SYNOPSIS
        Delete WebInterface configuration Object.
    .DESCRIPTION
        Binding object showing the farmname that can be bound to wisite.
    .PARAMETER Sitepath 
        Path to the Web Interface site. 
    .PARAMETER Farmname 
        Name for the logical representation of a XenApp or XenDesktop farm to be bound to the Web Interface site. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteWisitefarmnamebinding -Sitepath <string>
        An example how to delete wisite_farmname_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteWisitefarmnamebinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_farmname_binding/
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
        [string]$Sitepath,

        [string]$Farmname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteWisitefarmnamebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Farmname') ) { $arguments.Add('farmname', $Farmname) }
            if ( $PSCmdlet.ShouldProcess("$sitepath", "Delete WebInterface configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type wisite_farmname_binding -NitroPath nitro/v1/config -Resource $sitepath -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteWisitefarmnamebinding: Finished"
    }
}

function Invoke-ADCGetWisitefarmnamebinding {
    <#
    .SYNOPSIS
        Get WebInterface configuration object(s).
    .DESCRIPTION
        Binding object showing the farmname that can be bound to wisite.
    .PARAMETER Sitepath 
        Path to the Web Interface site. 
    .PARAMETER GetAll 
        Retrieve all wisite_farmname_binding object(s).
    .PARAMETER Count
        If specified, the count of the wisite_farmname_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWisitefarmnamebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetWisitefarmnamebinding -GetAll 
        Get all wisite_farmname_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetWisitefarmnamebinding -Count 
        Get the number of wisite_farmname_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWisitefarmnamebinding -name <string>
        Get wisite_farmname_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWisitefarmnamebinding -Filter @{ 'name'='<value>' }
        Get wisite_farmname_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetWisitefarmnamebinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_farmname_binding/
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
        [ValidateLength(1, 250)]
        [string]$Sitepath,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetWisitefarmnamebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all wisite_farmname_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_farmname_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for wisite_farmname_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_farmname_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving wisite_farmname_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_farmname_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving wisite_farmname_binding configuration for property 'sitepath'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_farmname_binding -NitroPath nitro/v1/config -Resource $sitepath -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving wisite_farmname_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_farmname_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetWisitefarmnamebinding: Ended"
    }
}

function Invoke-ADCAddWisitetranslationinternalipbinding {
    <#
    .SYNOPSIS
        Add WebInterface configuration Object.
    .DESCRIPTION
        Binding object showing the translationinternalip that can be bound to wisite.
    .PARAMETER Sitepath 
        Path to the Web Interface site. 
    .PARAMETER Translationinternalip 
        IP address of the server for which you want to associate an external IP address. (Clients access the server through the associated external address and port.). 
    .PARAMETER Translationinternalport 
        Port number of the server for which you want to associate an external port. (Clients access the server through the associated external address and port.). 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Translationexternalip 
        External IP address associated with server's IP address. 
    .PARAMETER Translationexternalport 
        External port number associated with the server's port number. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Accesstype 
        Type of access to the XenApp or XenDesktop server. Available settings function as follows: * User Device - Clients can use the translated address of the mapping entry to connect to the XenApp or XenDesktop server. * Gateway - Access Gateway can use the translated address of the mapping entry to connect to the XenApp or XenDesktop server. * User Device and Gateway - Both clients and Access Gateway can use the translated address of the mapping entry to connect to the XenApp or XenDesktop server. 
        Possible values = UserDevice, Gateway, UserDeviceAndGateway 
    .PARAMETER PassThru 
        Return details about the created wisite_translationinternalip_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddWisitetranslationinternalipbinding -sitepath <string>
        An example how to add wisite_translationinternalip_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddWisitetranslationinternalipbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_translationinternalip_binding/
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
        [ValidateLength(1, 250)]
        [string]$Sitepath,

        [string]$Translationinternalip = '0',

        [ValidateRange(1, 65535)]
        [int]$Translationinternalport,

        [string]$Translationexternalip,

        [ValidateRange(1, 65535)]
        [int]$Translationexternalport,

        [ValidateSet('UserDevice', 'Gateway', 'UserDeviceAndGateway')]
        [string]$Accesstype = 'UserDevice',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddWisitetranslationinternalipbinding: Starting"
    }
    process {
        try {
            $payload = @{ sitepath = $sitepath }
            if ( $PSBoundParameters.ContainsKey('translationinternalip') ) { $payload.Add('translationinternalip', $translationinternalip) }
            if ( $PSBoundParameters.ContainsKey('translationinternalport') ) { $payload.Add('translationinternalport', $translationinternalport) }
            if ( $PSBoundParameters.ContainsKey('translationexternalip') ) { $payload.Add('translationexternalip', $translationexternalip) }
            if ( $PSBoundParameters.ContainsKey('translationexternalport') ) { $payload.Add('translationexternalport', $translationexternalport) }
            if ( $PSBoundParameters.ContainsKey('accesstype') ) { $payload.Add('accesstype', $accesstype) }
            if ( $PSCmdlet.ShouldProcess("wisite_translationinternalip_binding", "Add WebInterface configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type wisite_translationinternalip_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetWisitetranslationinternalipbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddWisitetranslationinternalipbinding: Finished"
    }
}

function Invoke-ADCDeleteWisitetranslationinternalipbinding {
    <#
    .SYNOPSIS
        Delete WebInterface configuration Object.
    .DESCRIPTION
        Binding object showing the translationinternalip that can be bound to wisite.
    .PARAMETER Sitepath 
        Path to the Web Interface site. 
    .PARAMETER Translationinternalip 
        IP address of the server for which you want to associate an external IP address. (Clients access the server through the associated external address and port.). 
    .PARAMETER Translationinternalport 
        Port number of the server for which you want to associate an external port. (Clients access the server through the associated external address and port.). 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Translationexternalip 
        External IP address associated with server's IP address. 
    .PARAMETER Translationexternalport 
        External port number associated with the server's port number. 
        * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteWisitetranslationinternalipbinding -Sitepath <string>
        An example how to delete wisite_translationinternalip_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteWisitetranslationinternalipbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_translationinternalip_binding/
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
        [string]$Sitepath,

        [string]$Translationinternalip,

        [int]$Translationinternalport,

        [string]$Translationexternalip,

        [int]$Translationexternalport 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteWisitetranslationinternalipbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Translationinternalip') ) { $arguments.Add('translationinternalip', $Translationinternalip) }
            if ( $PSBoundParameters.ContainsKey('Translationinternalport') ) { $arguments.Add('translationinternalport', $Translationinternalport) }
            if ( $PSBoundParameters.ContainsKey('Translationexternalip') ) { $arguments.Add('translationexternalip', $Translationexternalip) }
            if ( $PSBoundParameters.ContainsKey('Translationexternalport') ) { $arguments.Add('translationexternalport', $Translationexternalport) }
            if ( $PSCmdlet.ShouldProcess("$sitepath", "Delete WebInterface configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type wisite_translationinternalip_binding -NitroPath nitro/v1/config -Resource $sitepath -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteWisitetranslationinternalipbinding: Finished"
    }
}

function Invoke-ADCGetWisitetranslationinternalipbinding {
    <#
    .SYNOPSIS
        Get WebInterface configuration object(s).
    .DESCRIPTION
        Binding object showing the translationinternalip that can be bound to wisite.
    .PARAMETER Sitepath 
        Path to the Web Interface site. 
    .PARAMETER GetAll 
        Retrieve all wisite_translationinternalip_binding object(s).
    .PARAMETER Count
        If specified, the count of the wisite_translationinternalip_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWisitetranslationinternalipbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetWisitetranslationinternalipbinding -GetAll 
        Get all wisite_translationinternalip_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetWisitetranslationinternalipbinding -Count 
        Get the number of wisite_translationinternalip_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWisitetranslationinternalipbinding -name <string>
        Get wisite_translationinternalip_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetWisitetranslationinternalipbinding -Filter @{ 'name'='<value>' }
        Get wisite_translationinternalip_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetWisitetranslationinternalipbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_translationinternalip_binding/
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
        [ValidateLength(1, 250)]
        [string]$Sitepath,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetWisitetranslationinternalipbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all wisite_translationinternalip_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_translationinternalip_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for wisite_translationinternalip_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_translationinternalip_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving wisite_translationinternalip_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_translationinternalip_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving wisite_translationinternalip_binding configuration for property 'sitepath'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_translationinternalip_binding -NitroPath nitro/v1/config -Resource $sitepath -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving wisite_translationinternalip_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_translationinternalip_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetWisitetranslationinternalipbinding: Ended"
    }
}


