function Invoke-ADCInstallWipackage {
<#
    .SYNOPSIS
        Install WebInterface configuration Object
    .DESCRIPTION
        Install WebInterface configuration Object 
    .PARAMETER jre 
        Complete path to the JRE tar file.  
        You can use OpenJDK7 package for FreeBSD 8.x/amd64.The Java package can be downloaded from http://ftp-archive.freebsd.org/pub/FreeBSD-Archive/old-releases/amd64/amd64/8.4-RELEASE/packages/java/openjdk-7.17.02_2.tbz. 
    .PARAMETER wi 
        Complete path to the Web Interface tar file for installing the Web Interface on the Citrix ADC. This file includes Apache Tomcat Web server. The file name has the following format: nswi-<version number>.tgz (for example, nswi-1.5.tgz). 
    .PARAMETER maxsites 
        Maximum number of Web Interface sites that can be created on the Citrix ADC; changes the amount of RAM reserved for Web Interface usage; changing its value results in restart of Tomcat server and invalidates any existing Web Interface sessions.  
        Possible values = 3, 25, 50, 100, 200, 500
    .EXAMPLE
        Invoke-ADCInstallWipackage 
    .NOTES
        File Name : Invoke-ADCInstallWipackage
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wipackage/
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
        [string]$wi ,

        [ValidateSet('3', '25', '50', '100', '200', '500')]
        [string]$maxsites 

    )
    begin {
        Write-Verbose "Invoke-ADCInstallWipackage: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('jre')) { $Payload.Add('jre', $jre) }
            if ($PSBoundParameters.ContainsKey('wi')) { $Payload.Add('wi', $wi) }
            if ($PSBoundParameters.ContainsKey('maxsites')) { $Payload.Add('maxsites', $maxsites) }
            if ($PSCmdlet.ShouldProcess($Name, "Install WebInterface configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type wipackage -Payload $Payload -GetWarning
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
        Get WebInterface configuration object(s)
    .DESCRIPTION
        Get WebInterface configuration object(s)
    .PARAMETER GetAll 
        Retreive all wipackage object(s)
    .PARAMETER Count
        If specified, the count of the wipackage object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetWipackage
    .EXAMPLE 
        Invoke-ADCGetWipackage -GetAll
    .EXAMPLE
        Invoke-ADCGetWipackage -name <string>
    .EXAMPLE
        Invoke-ADCGetWipackage -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetWipackage
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wipackage/
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
        Write-Verbose "Invoke-ADCGetWipackage: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all wipackage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wipackage -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for wipackage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wipackage -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving wipackage objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wipackage -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving wipackage configuration for property ''"

            } else {
                Write-Verbose "Retrieving wipackage configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wipackage -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add WebInterface configuration Object
    .DESCRIPTION
        Add WebInterface configuration Object 
    .PARAMETER sitepath 
        Path to the Web Interface site being created on the Citrix ADC.  
        Minimum length = 1  
        Maximum length = 250 
    .PARAMETER agurl 
        Call back URL of the Gateway.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER staurl 
        URL of the Secure Ticket Authority (STA) server.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER secondstaurl 
        URL of the second Secure Ticket Authority (STA) server.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER sessionreliability 
        Enable session reliability through Access Gateway.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER usetwotickets 
        Request tickets issued by two separate Secure Ticket Authorities (STA) when a resource is accessed.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER authenticationpoint 
        Authentication point for the Web Interface site.  
        Possible values = WebInterface, AccessGateway 
    .PARAMETER agauthenticationmethod 
        Method for authenticating a Web Interface site if you have specified Web Interface as the authentication point.  
        Available settings function as follows:  
        * Explicit - Users must provide a user name and password to log on to the Web Interface.  
        * Anonymous - Users can log on to the Web Interface without providing a user name and password. They have access to resources published for anonymous users.  
        Possible values = Explicit, SmartCard 
    .PARAMETER wiauthenticationmethods 
        The method of authentication to be used at Web Interface.  
        Default value: Explicit  
        Possible values = Explicit, Anonymous 
    .PARAMETER defaultcustomtextlocale 
        Default language for the Web Interface site.  
        Default value: English  
        Possible values = German, English, Spanish, French, Japanese, Korean, Russian, Chinese_simplified, Chinese_traditional 
    .PARAMETER websessiontimeout 
        Time-out, in minutes, for idle Web Interface browser sessions. If a client's session is idle for a time that exceeds the time-out value, the Citrix ADC terminates the connection.  
        Default value: 20  
        Minimum value = 1  
        Maximum value = 1440 
    .PARAMETER defaultaccessmethod 
        Default access method for clients accessing the Web Interface site.  
        Note: Before you configure an access method based on the client IP address, you must enable USIP mode on the Web Interface service to make the client's IP address available with the Web Interface.  
        Depending on whether the Web Interface site is configured to use an HTTP or HTTPS virtual server or to use access gateway, you can send clients or access gateway the IP address, or the alternate address, of a XenApp or XenDesktop server. Or, you can send the IP address translated from a mapping entry, which defines mapping of an internal address and port to an external address and port.  
        Note: In the Citrix ADC command line, mapping entries can be created by using the bind wi site command.  
        Possible values = Direct, Alternate, Translated, GatewayDirect, GatewayAlternate, GatewayTranslated 
    .PARAMETER logintitle 
        A custom login page title for the Web Interface site.  
        Default value: "Welcome to Web Interface on NetScaler"  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER appwelcomemessage 
        Specifies localized text to appear at the top of the main content area of the Applications screen. LanguageCode is en, de, es, fr, ja, or any other supported language identifier.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER welcomemessage 
        Localized welcome message that appears on the welcome area of the login screen.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER footertext 
        Localized text that appears in the footer area of all pages.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER loginsysmessage 
        Localized text that appears at the bottom of the main content area of the login screen.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER preloginbutton 
        Localized text that appears as the name of the pre-login message confirmation button.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER preloginmessage 
        Localized text that appears on the pre-login message page.  
        Minimum length = 1  
        Maximum length = 2048 
    .PARAMETER prelogintitle 
        Localized text that appears as the title of the pre-login message page.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER domainselection 
        Domain names listed on the login screen for explicit authentication.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER sitetype 
        Type of access to the Web Interface site. Available settings function as follows:  
        * XenApp/XenDesktop web site - Configures the Web Interface site for access by a web browser.  
        * XenApp/XenDesktop services site - Configures the Web Interface site for access by the XenApp plug-in.  
        Default value: XenAppWeb  
        Possible values = XenAppWeb, XenAppServices 
    .PARAMETER userinterfacebranding 
        Specifies whether the site is focused towards users accessing applications or desktops. Setting the parameter to Desktops changes the functionality of the site to improve the experience for XenDesktop users. Citrix recommends using this setting for any deployment that includes XenDesktop.  
        Default value: Applications  
        Possible values = Desktops, Applications 
    .PARAMETER publishedresourcetype 
        Method for accessing the published XenApp and XenDesktop resources.  
        Available settings function as follows:  
        * Online - Allows applications to be launched on the XenApp and XenDesktop servers.  
        * Offline - Allows streaming of applications to the client.  
        * DualMode - Allows both online and offline modes.  
        Default value: Online  
        Possible values = Online, Offline, DualMode 
    .PARAMETER kioskmode 
        User settings do not persist from one session to another.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER showsearch 
        Enables search option on XenApp websites.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER showrefresh 
        Provides the Refresh button on the applications screen.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER wiuserinterfacemodes 
        Appearance of the login screen.  
        * Simple - Only the login fields for the selected authentication method are displayed.  
        * Advanced - Displays the navigation bar, which provides access to the pre-login messages and preferences screens.  
        Default value: SIMPLE  
        Possible values = SIMPLE, ADVANCED 
    .PARAMETER userinterfacelayouts 
        Specifies whether or not to use the compact user interface.  
        Default value: AUTO  
        Possible values = AUTO, NORMAL, COMPACT 
    .PARAMETER restrictdomains 
        The RestrictDomains setting is used to enable/disable domain restrictions. If domain restriction is enabled, the LoginDomains list is used for validating the login domain. It is applied to all the authentication methods except Anonymous for XenApp Web and XenApp Services sites.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER logindomains 
        [List of NetBIOS domain names], Domain names to use for access restriction.  
        Only takes effect when used in conjunction with the RestrictDomains setting.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER hidedomainfield 
        The HideDomainField setting is used to control whether the domain field is displayed on the logon screen.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER agcallbackurl 
        Callback AGURL to which Web Interface contacts. .  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER PassThru 
        Return details about the created wisite item.
    .EXAMPLE
        Invoke-ADCAddWisite -sitepath <string>
    .NOTES
        File Name : Invoke-ADCAddWisite
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite/
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
        [ValidateLength(1, 250)]
        [string]$sitepath ,

        [ValidateLength(1, 255)]
        [string]$agurl ,

        [ValidateLength(1, 255)]
        [string]$staurl ,

        [ValidateLength(1, 255)]
        [string]$secondstaurl ,

        [ValidateSet('ON', 'OFF')]
        [string]$sessionreliability = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$usetwotickets = 'OFF' ,

        [ValidateSet('WebInterface', 'AccessGateway')]
        [string]$authenticationpoint ,

        [ValidateSet('Explicit', 'SmartCard')]
        [string]$agauthenticationmethod ,

        [ValidateSet('Explicit', 'Anonymous')]
        [string[]]$wiauthenticationmethods = 'Explicit' ,

        [ValidateSet('German', 'English', 'Spanish', 'French', 'Japanese', 'Korean', 'Russian', 'Chinese_simplified', 'Chinese_traditional')]
        [string]$defaultcustomtextlocale = 'English' ,

        [ValidateRange(1, 1440)]
        [double]$websessiontimeout = '20' ,

        [ValidateSet('Direct', 'Alternate', 'Translated', 'GatewayDirect', 'GatewayAlternate', 'GatewayTranslated')]
        [string]$defaultaccessmethod ,

        [ValidateLength(1, 255)]
        [string]$logintitle = '"Welcome to Web Interface on NetScaler"' ,

        [ValidateLength(1, 255)]
        [string]$appwelcomemessage ,

        [ValidateLength(1, 255)]
        [string]$welcomemessage ,

        [ValidateLength(1, 255)]
        [string]$footertext ,

        [ValidateLength(1, 255)]
        [string]$loginsysmessage ,

        [ValidateLength(1, 255)]
        [string]$preloginbutton ,

        [ValidateLength(1, 2048)]
        [string]$preloginmessage ,

        [ValidateLength(1, 255)]
        [string]$prelogintitle ,

        [ValidateLength(1, 255)]
        [string]$domainselection ,

        [ValidateSet('XenAppWeb', 'XenAppServices')]
        [string]$sitetype = 'XenAppWeb' ,

        [ValidateSet('Desktops', 'Applications')]
        [string]$userinterfacebranding = 'Applications' ,

        [ValidateSet('Online', 'Offline', 'DualMode')]
        [string]$publishedresourcetype = 'Online' ,

        [ValidateSet('ON', 'OFF')]
        [string]$kioskmode = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$showsearch = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$showrefresh = 'OFF' ,

        [ValidateSet('SIMPLE', 'ADVANCED')]
        [string]$wiuserinterfacemodes = 'SIMPLE' ,

        [ValidateSet('AUTO', 'NORMAL', 'COMPACT')]
        [string]$userinterfacelayouts = 'AUTO' ,

        [ValidateSet('ON', 'OFF')]
        [string]$restrictdomains = 'OFF' ,

        [ValidateLength(1, 255)]
        [string]$logindomains ,

        [ValidateSet('ON', 'OFF')]
        [string]$hidedomainfield = 'OFF' ,

        [ValidateLength(1, 255)]
        [string]$agcallbackurl ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddWisite: Starting"
    }
    process {
        try {
            $Payload = @{
                sitepath = $sitepath
            }
            if ($PSBoundParameters.ContainsKey('agurl')) { $Payload.Add('agurl', $agurl) }
            if ($PSBoundParameters.ContainsKey('staurl')) { $Payload.Add('staurl', $staurl) }
            if ($PSBoundParameters.ContainsKey('secondstaurl')) { $Payload.Add('secondstaurl', $secondstaurl) }
            if ($PSBoundParameters.ContainsKey('sessionreliability')) { $Payload.Add('sessionreliability', $sessionreliability) }
            if ($PSBoundParameters.ContainsKey('usetwotickets')) { $Payload.Add('usetwotickets', $usetwotickets) }
            if ($PSBoundParameters.ContainsKey('authenticationpoint')) { $Payload.Add('authenticationpoint', $authenticationpoint) }
            if ($PSBoundParameters.ContainsKey('agauthenticationmethod')) { $Payload.Add('agauthenticationmethod', $agauthenticationmethod) }
            if ($PSBoundParameters.ContainsKey('wiauthenticationmethods')) { $Payload.Add('wiauthenticationmethods', $wiauthenticationmethods) }
            if ($PSBoundParameters.ContainsKey('defaultcustomtextlocale')) { $Payload.Add('defaultcustomtextlocale', $defaultcustomtextlocale) }
            if ($PSBoundParameters.ContainsKey('websessiontimeout')) { $Payload.Add('websessiontimeout', $websessiontimeout) }
            if ($PSBoundParameters.ContainsKey('defaultaccessmethod')) { $Payload.Add('defaultaccessmethod', $defaultaccessmethod) }
            if ($PSBoundParameters.ContainsKey('logintitle')) { $Payload.Add('logintitle', $logintitle) }
            if ($PSBoundParameters.ContainsKey('appwelcomemessage')) { $Payload.Add('appwelcomemessage', $appwelcomemessage) }
            if ($PSBoundParameters.ContainsKey('welcomemessage')) { $Payload.Add('welcomemessage', $welcomemessage) }
            if ($PSBoundParameters.ContainsKey('footertext')) { $Payload.Add('footertext', $footertext) }
            if ($PSBoundParameters.ContainsKey('loginsysmessage')) { $Payload.Add('loginsysmessage', $loginsysmessage) }
            if ($PSBoundParameters.ContainsKey('preloginbutton')) { $Payload.Add('preloginbutton', $preloginbutton) }
            if ($PSBoundParameters.ContainsKey('preloginmessage')) { $Payload.Add('preloginmessage', $preloginmessage) }
            if ($PSBoundParameters.ContainsKey('prelogintitle')) { $Payload.Add('prelogintitle', $prelogintitle) }
            if ($PSBoundParameters.ContainsKey('domainselection')) { $Payload.Add('domainselection', $domainselection) }
            if ($PSBoundParameters.ContainsKey('sitetype')) { $Payload.Add('sitetype', $sitetype) }
            if ($PSBoundParameters.ContainsKey('userinterfacebranding')) { $Payload.Add('userinterfacebranding', $userinterfacebranding) }
            if ($PSBoundParameters.ContainsKey('publishedresourcetype')) { $Payload.Add('publishedresourcetype', $publishedresourcetype) }
            if ($PSBoundParameters.ContainsKey('kioskmode')) { $Payload.Add('kioskmode', $kioskmode) }
            if ($PSBoundParameters.ContainsKey('showsearch')) { $Payload.Add('showsearch', $showsearch) }
            if ($PSBoundParameters.ContainsKey('showrefresh')) { $Payload.Add('showrefresh', $showrefresh) }
            if ($PSBoundParameters.ContainsKey('wiuserinterfacemodes')) { $Payload.Add('wiuserinterfacemodes', $wiuserinterfacemodes) }
            if ($PSBoundParameters.ContainsKey('userinterfacelayouts')) { $Payload.Add('userinterfacelayouts', $userinterfacelayouts) }
            if ($PSBoundParameters.ContainsKey('restrictdomains')) { $Payload.Add('restrictdomains', $restrictdomains) }
            if ($PSBoundParameters.ContainsKey('logindomains')) { $Payload.Add('logindomains', $logindomains) }
            if ($PSBoundParameters.ContainsKey('hidedomainfield')) { $Payload.Add('hidedomainfield', $hidedomainfield) }
            if ($PSBoundParameters.ContainsKey('agcallbackurl')) { $Payload.Add('agcallbackurl', $agcallbackurl) }
 
            if ($PSCmdlet.ShouldProcess("wisite", "Add WebInterface configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type wisite -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetWisite -Filter $Payload)
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
        Delete WebInterface configuration Object
    .DESCRIPTION
        Delete WebInterface configuration Object
    .PARAMETER sitepath 
       Path to the Web Interface site being created on the Citrix ADC.  
       Minimum length = 1  
       Maximum length = 250 
    .EXAMPLE
        Invoke-ADCDeleteWisite -sitepath <string>
    .NOTES
        File Name : Invoke-ADCDeleteWisite
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite/
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
        [string]$sitepath 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteWisite: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$sitepath", "Delete WebInterface configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type wisite -Resource $sitepath -Arguments $Arguments
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
        Update WebInterface configuration Object
    .DESCRIPTION
        Update WebInterface configuration Object 
    .PARAMETER sitepath 
        Path to the Web Interface site being created on the Citrix ADC.  
        Minimum length = 1  
        Maximum length = 250 
    .PARAMETER agurl 
        Call back URL of the Gateway.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER staurl 
        URL of the Secure Ticket Authority (STA) server.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER sessionreliability 
        Enable session reliability through Access Gateway.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER usetwotickets 
        Request tickets issued by two separate Secure Ticket Authorities (STA) when a resource is accessed.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER secondstaurl 
        URL of the second Secure Ticket Authority (STA) server.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER wiauthenticationmethods 
        The method of authentication to be used at Web Interface.  
        Default value: Explicit  
        Possible values = Explicit, Anonymous 
    .PARAMETER defaultaccessmethod 
        Default access method for clients accessing the Web Interface site.  
        Note: Before you configure an access method based on the client IP address, you must enable USIP mode on the Web Interface service to make the client's IP address available with the Web Interface.  
        Depending on whether the Web Interface site is configured to use an HTTP or HTTPS virtual server or to use access gateway, you can send clients or access gateway the IP address, or the alternate address, of a XenApp or XenDesktop server. Or, you can send the IP address translated from a mapping entry, which defines mapping of an internal address and port to an external address and port.  
        Note: In the Citrix ADC command line, mapping entries can be created by using the bind wi site command.  
        Possible values = Direct, Alternate, Translated, GatewayDirect, GatewayAlternate, GatewayTranslated 
    .PARAMETER defaultcustomtextlocale 
        Default language for the Web Interface site.  
        Default value: English  
        Possible values = German, English, Spanish, French, Japanese, Korean, Russian, Chinese_simplified, Chinese_traditional 
    .PARAMETER websessiontimeout 
        Time-out, in minutes, for idle Web Interface browser sessions. If a client's session is idle for a time that exceeds the time-out value, the Citrix ADC terminates the connection.  
        Default value: 20  
        Minimum value = 1  
        Maximum value = 1440 
    .PARAMETER logintitle 
        A custom login page title for the Web Interface site.  
        Default value: "Welcome to Web Interface on NetScaler"  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER appwelcomemessage 
        Specifies localized text to appear at the top of the main content area of the Applications screen. LanguageCode is en, de, es, fr, ja, or any other supported language identifier.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER welcomemessage 
        Localized welcome message that appears on the welcome area of the login screen.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER footertext 
        Localized text that appears in the footer area of all pages.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER loginsysmessage 
        Localized text that appears at the bottom of the main content area of the login screen.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER preloginbutton 
        Localized text that appears as the name of the pre-login message confirmation button.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER preloginmessage 
        Localized text that appears on the pre-login message page.  
        Minimum length = 1  
        Maximum length = 2048 
    .PARAMETER prelogintitle 
        Localized text that appears as the title of the pre-login message page.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER domainselection 
        Domain names listed on the login screen for explicit authentication.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER userinterfacebranding 
        Specifies whether the site is focused towards users accessing applications or desktops. Setting the parameter to Desktops changes the functionality of the site to improve the experience for XenDesktop users. Citrix recommends using this setting for any deployment that includes XenDesktop.  
        Default value: Applications  
        Possible values = Desktops, Applications 
    .PARAMETER authenticationpoint 
        Authentication point for the Web Interface site.  
        Possible values = WebInterface, AccessGateway 
    .PARAMETER agauthenticationmethod 
        Method for authenticating a Web Interface site if you have specified Web Interface as the authentication point.  
        Available settings function as follows:  
        * Explicit - Users must provide a user name and password to log on to the Web Interface.  
        * Anonymous - Users can log on to the Web Interface without providing a user name and password. They have access to resources published for anonymous users.  
        Possible values = Explicit, SmartCard 
    .PARAMETER publishedresourcetype 
        Method for accessing the published XenApp and XenDesktop resources.  
        Available settings function as follows:  
        * Online - Allows applications to be launched on the XenApp and XenDesktop servers.  
        * Offline - Allows streaming of applications to the client.  
        * DualMode - Allows both online and offline modes.  
        Default value: Online  
        Possible values = Online, Offline, DualMode 
    .PARAMETER kioskmode 
        User settings do not persist from one session to another.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER showsearch 
        Enables search option on XenApp websites.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER showrefresh 
        Provides the Refresh button on the applications screen.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER wiuserinterfacemodes 
        Appearance of the login screen.  
        * Simple - Only the login fields for the selected authentication method are displayed.  
        * Advanced - Displays the navigation bar, which provides access to the pre-login messages and preferences screens.  
        Default value: SIMPLE  
        Possible values = SIMPLE, ADVANCED 
    .PARAMETER userinterfacelayouts 
        Specifies whether or not to use the compact user interface.  
        Default value: AUTO  
        Possible values = AUTO, NORMAL, COMPACT 
    .PARAMETER restrictdomains 
        The RestrictDomains setting is used to enable/disable domain restrictions. If domain restriction is enabled, the LoginDomains list is used for validating the login domain. It is applied to all the authentication methods except Anonymous for XenApp Web and XenApp Services sites.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER logindomains 
        [List of NetBIOS domain names], Domain names to use for access restriction.  
        Only takes effect when used in conjunction with the RestrictDomains setting.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER hidedomainfield 
        The HideDomainField setting is used to control whether the domain field is displayed on the logon screen.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER agcallbackurl 
        Callback AGURL to which Web Interface contacts. .  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER PassThru 
        Return details about the created wisite item.
    .EXAMPLE
        Invoke-ADCUpdateWisite -sitepath <string>
    .NOTES
        File Name : Invoke-ADCUpdateWisite
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite/
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
        [ValidateLength(1, 250)]
        [string]$sitepath ,

        [ValidateLength(1, 255)]
        [string]$agurl ,

        [ValidateLength(1, 255)]
        [string]$staurl ,

        [ValidateSet('ON', 'OFF')]
        [string]$sessionreliability ,

        [ValidateSet('ON', 'OFF')]
        [string]$usetwotickets ,

        [ValidateLength(1, 255)]
        [string]$secondstaurl ,

        [ValidateSet('Explicit', 'Anonymous')]
        [string[]]$wiauthenticationmethods ,

        [ValidateSet('Direct', 'Alternate', 'Translated', 'GatewayDirect', 'GatewayAlternate', 'GatewayTranslated')]
        [string]$defaultaccessmethod ,

        [ValidateSet('German', 'English', 'Spanish', 'French', 'Japanese', 'Korean', 'Russian', 'Chinese_simplified', 'Chinese_traditional')]
        [string]$defaultcustomtextlocale ,

        [ValidateRange(1, 1440)]
        [double]$websessiontimeout ,

        [ValidateLength(1, 255)]
        [string]$logintitle ,

        [ValidateLength(1, 255)]
        [string]$appwelcomemessage ,

        [ValidateLength(1, 255)]
        [string]$welcomemessage ,

        [ValidateLength(1, 255)]
        [string]$footertext ,

        [ValidateLength(1, 255)]
        [string]$loginsysmessage ,

        [ValidateLength(1, 255)]
        [string]$preloginbutton ,

        [ValidateLength(1, 2048)]
        [string]$preloginmessage ,

        [ValidateLength(1, 255)]
        [string]$prelogintitle ,

        [ValidateLength(1, 255)]
        [string]$domainselection ,

        [ValidateSet('Desktops', 'Applications')]
        [string]$userinterfacebranding ,

        [ValidateSet('WebInterface', 'AccessGateway')]
        [string]$authenticationpoint ,

        [ValidateSet('Explicit', 'SmartCard')]
        [string]$agauthenticationmethod ,

        [ValidateSet('Online', 'Offline', 'DualMode')]
        [string]$publishedresourcetype ,

        [ValidateSet('ON', 'OFF')]
        [string]$kioskmode ,

        [ValidateSet('ON', 'OFF')]
        [string]$showsearch ,

        [ValidateSet('ON', 'OFF')]
        [string]$showrefresh ,

        [ValidateSet('SIMPLE', 'ADVANCED')]
        [string]$wiuserinterfacemodes ,

        [ValidateSet('AUTO', 'NORMAL', 'COMPACT')]
        [string]$userinterfacelayouts ,

        [ValidateSet('ON', 'OFF')]
        [string]$restrictdomains ,

        [ValidateLength(1, 255)]
        [string]$logindomains ,

        [ValidateSet('ON', 'OFF')]
        [string]$hidedomainfield ,

        [ValidateLength(1, 255)]
        [string]$agcallbackurl ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateWisite: Starting"
    }
    process {
        try {
            $Payload = @{
                sitepath = $sitepath
            }
            if ($PSBoundParameters.ContainsKey('agurl')) { $Payload.Add('agurl', $agurl) }
            if ($PSBoundParameters.ContainsKey('staurl')) { $Payload.Add('staurl', $staurl) }
            if ($PSBoundParameters.ContainsKey('sessionreliability')) { $Payload.Add('sessionreliability', $sessionreliability) }
            if ($PSBoundParameters.ContainsKey('usetwotickets')) { $Payload.Add('usetwotickets', $usetwotickets) }
            if ($PSBoundParameters.ContainsKey('secondstaurl')) { $Payload.Add('secondstaurl', $secondstaurl) }
            if ($PSBoundParameters.ContainsKey('wiauthenticationmethods')) { $Payload.Add('wiauthenticationmethods', $wiauthenticationmethods) }
            if ($PSBoundParameters.ContainsKey('defaultaccessmethod')) { $Payload.Add('defaultaccessmethod', $defaultaccessmethod) }
            if ($PSBoundParameters.ContainsKey('defaultcustomtextlocale')) { $Payload.Add('defaultcustomtextlocale', $defaultcustomtextlocale) }
            if ($PSBoundParameters.ContainsKey('websessiontimeout')) { $Payload.Add('websessiontimeout', $websessiontimeout) }
            if ($PSBoundParameters.ContainsKey('logintitle')) { $Payload.Add('logintitle', $logintitle) }
            if ($PSBoundParameters.ContainsKey('appwelcomemessage')) { $Payload.Add('appwelcomemessage', $appwelcomemessage) }
            if ($PSBoundParameters.ContainsKey('welcomemessage')) { $Payload.Add('welcomemessage', $welcomemessage) }
            if ($PSBoundParameters.ContainsKey('footertext')) { $Payload.Add('footertext', $footertext) }
            if ($PSBoundParameters.ContainsKey('loginsysmessage')) { $Payload.Add('loginsysmessage', $loginsysmessage) }
            if ($PSBoundParameters.ContainsKey('preloginbutton')) { $Payload.Add('preloginbutton', $preloginbutton) }
            if ($PSBoundParameters.ContainsKey('preloginmessage')) { $Payload.Add('preloginmessage', $preloginmessage) }
            if ($PSBoundParameters.ContainsKey('prelogintitle')) { $Payload.Add('prelogintitle', $prelogintitle) }
            if ($PSBoundParameters.ContainsKey('domainselection')) { $Payload.Add('domainselection', $domainselection) }
            if ($PSBoundParameters.ContainsKey('userinterfacebranding')) { $Payload.Add('userinterfacebranding', $userinterfacebranding) }
            if ($PSBoundParameters.ContainsKey('authenticationpoint')) { $Payload.Add('authenticationpoint', $authenticationpoint) }
            if ($PSBoundParameters.ContainsKey('agauthenticationmethod')) { $Payload.Add('agauthenticationmethod', $agauthenticationmethod) }
            if ($PSBoundParameters.ContainsKey('publishedresourcetype')) { $Payload.Add('publishedresourcetype', $publishedresourcetype) }
            if ($PSBoundParameters.ContainsKey('kioskmode')) { $Payload.Add('kioskmode', $kioskmode) }
            if ($PSBoundParameters.ContainsKey('showsearch')) { $Payload.Add('showsearch', $showsearch) }
            if ($PSBoundParameters.ContainsKey('showrefresh')) { $Payload.Add('showrefresh', $showrefresh) }
            if ($PSBoundParameters.ContainsKey('wiuserinterfacemodes')) { $Payload.Add('wiuserinterfacemodes', $wiuserinterfacemodes) }
            if ($PSBoundParameters.ContainsKey('userinterfacelayouts')) { $Payload.Add('userinterfacelayouts', $userinterfacelayouts) }
            if ($PSBoundParameters.ContainsKey('restrictdomains')) { $Payload.Add('restrictdomains', $restrictdomains) }
            if ($PSBoundParameters.ContainsKey('logindomains')) { $Payload.Add('logindomains', $logindomains) }
            if ($PSBoundParameters.ContainsKey('hidedomainfield')) { $Payload.Add('hidedomainfield', $hidedomainfield) }
            if ($PSBoundParameters.ContainsKey('agcallbackurl')) { $Payload.Add('agcallbackurl', $agcallbackurl) }
 
            if ($PSCmdlet.ShouldProcess("wisite", "Update WebInterface configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type wisite -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetWisite -Filter $Payload)
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
        Unset WebInterface configuration Object
    .DESCRIPTION
        Unset WebInterface configuration Object 
   .PARAMETER sitepath 
       Path to the Web Interface site being created on the Citrix ADC. 
   .PARAMETER appwelcomemessage 
       Specifies localized text to appear at the top of the main content area of the Applications screen. LanguageCode is en, de, es, fr, ja, or any other supported language identifier. 
   .PARAMETER welcomemessage 
       Localized welcome message that appears on the welcome area of the login screen. 
   .PARAMETER footertext 
       Localized text that appears in the footer area of all pages. 
   .PARAMETER loginsysmessage 
       Localized text that appears at the bottom of the main content area of the login screen. 
   .PARAMETER preloginbutton 
       Localized text that appears as the name of the pre-login message confirmation button. 
   .PARAMETER preloginmessage 
       Localized text that appears on the pre-login message page. 
   .PARAMETER prelogintitle 
       Localized text that appears as the title of the pre-login message page. 
   .PARAMETER userinterfacebranding 
       Specifies whether the site is focused towards users accessing applications or desktops. Setting the parameter to Desktops changes the functionality of the site to improve the experience for XenDesktop users. Citrix recommends using this setting for any deployment that includes XenDesktop.  
       Possible values = Desktops, Applications 
   .PARAMETER logindomains 
       [List of NetBIOS domain names], Domain names to use for access restriction.  
       Only takes effect when used in conjunction with the RestrictDomains setting.
    .EXAMPLE
        Invoke-ADCUnsetWisite -sitepath <string>
    .NOTES
        File Name : Invoke-ADCUnsetWisite
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite
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
        [ValidateLength(1, 250)]
        [string]$sitepath ,

        [Boolean]$appwelcomemessage ,

        [Boolean]$welcomemessage ,

        [Boolean]$footertext ,

        [Boolean]$loginsysmessage ,

        [Boolean]$preloginbutton ,

        [Boolean]$preloginmessage ,

        [Boolean]$prelogintitle ,

        [Boolean]$userinterfacebranding ,

        [Boolean]$logindomains 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetWisite: Starting"
    }
    process {
        try {
            $Payload = @{
                sitepath = $sitepath
            }
            if ($PSBoundParameters.ContainsKey('appwelcomemessage')) { $Payload.Add('appwelcomemessage', $appwelcomemessage) }
            if ($PSBoundParameters.ContainsKey('welcomemessage')) { $Payload.Add('welcomemessage', $welcomemessage) }
            if ($PSBoundParameters.ContainsKey('footertext')) { $Payload.Add('footertext', $footertext) }
            if ($PSBoundParameters.ContainsKey('loginsysmessage')) { $Payload.Add('loginsysmessage', $loginsysmessage) }
            if ($PSBoundParameters.ContainsKey('preloginbutton')) { $Payload.Add('preloginbutton', $preloginbutton) }
            if ($PSBoundParameters.ContainsKey('preloginmessage')) { $Payload.Add('preloginmessage', $preloginmessage) }
            if ($PSBoundParameters.ContainsKey('prelogintitle')) { $Payload.Add('prelogintitle', $prelogintitle) }
            if ($PSBoundParameters.ContainsKey('userinterfacebranding')) { $Payload.Add('userinterfacebranding', $userinterfacebranding) }
            if ($PSBoundParameters.ContainsKey('logindomains')) { $Payload.Add('logindomains', $logindomains) }
            if ($PSCmdlet.ShouldProcess("$sitepath", "Unset WebInterface configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type wisite -Action unset -Payload $Payload -GetWarning
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
        Get WebInterface configuration object(s)
    .DESCRIPTION
        Get WebInterface configuration object(s)
    .PARAMETER sitepath 
       Path to the Web Interface site being created on the Citrix ADC. 
    .PARAMETER GetAll 
        Retreive all wisite object(s)
    .PARAMETER Count
        If specified, the count of the wisite object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetWisite
    .EXAMPLE 
        Invoke-ADCGetWisite -GetAll 
    .EXAMPLE 
        Invoke-ADCGetWisite -Count
    .EXAMPLE
        Invoke-ADCGetWisite -name <string>
    .EXAMPLE
        Invoke-ADCGetWisite -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetWisite
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite/
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
        [ValidateLength(1, 250)]
        [string]$sitepath,

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
        Write-Verbose "Invoke-ADCGetWisite: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all wisite objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for wisite objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving wisite objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving wisite configuration for property 'sitepath'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite -Resource $sitepath -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving wisite configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add WebInterface configuration Object
    .DESCRIPTION
        Add WebInterface configuration Object 
    .PARAMETER sitepath 
        Path to the Web Interface site.  
        Minimum length = 1  
        Maximum length = 250 
    .PARAMETER accessmethod 
        Secure access method to be applied to the IPv4 or network address of the client specified by the Client IP Address parameter. Depending on whether the Web Interface site is configured to use an HTTP or HTTPS virtual server or to use access gateway, you can send clients or access gateway the IP address, or the alternate address, of a XenApp or XenDesktop server. Or, you can send the IP address translated from a mapping entry, which defines mapping of an internal address and port to an external address and port.  
        Possible values = Direct, Alternate, Translated, GatewayDirect, GatewayAlternate, GatewayTranslated 
    .PARAMETER clientipaddress 
        IPv4 or network address of the client for which you want to associate an access method.  
        Default value: 0 
    .PARAMETER clientnetmask 
        Subnet mask associated with the IPv4 or network address specified by the Client IP Address parameter.  
        Default value: 0 
    .PARAMETER PassThru 
        Return details about the created wisite_accessmethod_binding item.
    .EXAMPLE
        Invoke-ADCAddWisiteaccessmethodbinding -sitepath <string>
    .NOTES
        File Name : Invoke-ADCAddWisiteaccessmethodbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_accessmethod_binding/
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
        [ValidateLength(1, 250)]
        [string]$sitepath ,

        [ValidateSet('Direct', 'Alternate', 'Translated', 'GatewayDirect', 'GatewayAlternate', 'GatewayTranslated')]
        [string]$accessmethod ,

        [string]$clientipaddress = '0' ,

        [string]$clientnetmask = '0' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddWisiteaccessmethodbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                sitepath = $sitepath
            }
            if ($PSBoundParameters.ContainsKey('accessmethod')) { $Payload.Add('accessmethod', $accessmethod) }
            if ($PSBoundParameters.ContainsKey('clientipaddress')) { $Payload.Add('clientipaddress', $clientipaddress) }
            if ($PSBoundParameters.ContainsKey('clientnetmask')) { $Payload.Add('clientnetmask', $clientnetmask) }
 
            if ($PSCmdlet.ShouldProcess("wisite_accessmethod_binding", "Add WebInterface configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type wisite_accessmethod_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetWisiteaccessmethodbinding -Filter $Payload)
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
        Delete WebInterface configuration Object
    .DESCRIPTION
        Delete WebInterface configuration Object
    .PARAMETER sitepath 
       Path to the Web Interface site.  
       Minimum length = 1  
       Maximum length = 250    .PARAMETER clientipaddress 
       IPv4 or network address of the client for which you want to associate an access method.  
       Default value: 0    .PARAMETER clientnetmask 
       Subnet mask associated with the IPv4 or network address specified by the Client IP Address parameter.  
       Default value: 0
    .EXAMPLE
        Invoke-ADCDeleteWisiteaccessmethodbinding -sitepath <string>
    .NOTES
        File Name : Invoke-ADCDeleteWisiteaccessmethodbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_accessmethod_binding/
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
        [string]$sitepath ,

        [string]$clientipaddress ,

        [string]$clientnetmask 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteWisiteaccessmethodbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('clientipaddress')) { $Arguments.Add('clientipaddress', $clientipaddress) }
            if ($PSBoundParameters.ContainsKey('clientnetmask')) { $Arguments.Add('clientnetmask', $clientnetmask) }
            if ($PSCmdlet.ShouldProcess("$sitepath", "Delete WebInterface configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type wisite_accessmethod_binding -Resource $sitepath -Arguments $Arguments
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
        Get WebInterface configuration object(s)
    .DESCRIPTION
        Get WebInterface configuration object(s)
    .PARAMETER sitepath 
       Path to the Web Interface site. 
    .PARAMETER GetAll 
        Retreive all wisite_accessmethod_binding object(s)
    .PARAMETER Count
        If specified, the count of the wisite_accessmethod_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetWisiteaccessmethodbinding
    .EXAMPLE 
        Invoke-ADCGetWisiteaccessmethodbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetWisiteaccessmethodbinding -Count
    .EXAMPLE
        Invoke-ADCGetWisiteaccessmethodbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetWisiteaccessmethodbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetWisiteaccessmethodbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_accessmethod_binding/
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
        [ValidateLength(1, 250)]
        [string]$sitepath,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all wisite_accessmethod_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_accessmethod_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for wisite_accessmethod_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_accessmethod_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving wisite_accessmethod_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_accessmethod_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving wisite_accessmethod_binding configuration for property 'sitepath'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_accessmethod_binding -Resource $sitepath -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving wisite_accessmethod_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_accessmethod_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get WebInterface configuration object(s)
    .DESCRIPTION
        Get WebInterface configuration object(s)
    .PARAMETER sitepath 
       Path of a Web Interface site whose details you want the Citrix ADC to display. 
    .PARAMETER GetAll 
        Retreive all wisite_binding object(s)
    .PARAMETER Count
        If specified, the count of the wisite_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetWisitebinding
    .EXAMPLE 
        Invoke-ADCGetWisitebinding -GetAll
    .EXAMPLE
        Invoke-ADCGetWisitebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetWisitebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetWisitebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_binding/
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
        [ValidateLength(1, 250)]
        [string]$sitepath,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetWisitebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all wisite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for wisite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving wisite_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving wisite_binding configuration for property 'sitepath'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_binding -Resource $sitepath -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving wisite_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add WebInterface configuration Object
    .DESCRIPTION
        Add WebInterface configuration Object 
    .PARAMETER sitepath 
        Path to the Web Interface site.  
        Minimum length = 1  
        Maximum length = 250 
    .PARAMETER farmname 
        Name for the logical representation of a XenApp or XenDesktop farm to be bound to the Web Interface site. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER xmlserveraddresses 
        Comma-separated IP addresses or host names of XenApp or XenDesktop servers providing XML services. 
    .PARAMETER groups 
        Active Directory groups that are permitted to enumerate resources from server farms. Including a setting for this parameter activates the user roaming feature. A maximum of 512 user groups can be specified for each farm defined with the Farm<n> parameter. The groups must be comma separated. 
    .PARAMETER recoveryfarm 
        Binded farm is set as a recovery farm.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER xmlport 
        Port number at which to contact the XML service. 
    .PARAMETER transport 
        Transport protocol to use for transferring data, related to the Web Interface site, between the Citrix ADC and the XML service.  
        Possible values = HTTP, HTTPS, SSLRELAY 
    .PARAMETER sslrelayport 
        TCP port at which the XenApp or XenDesktop servers listenfor SSL Relay traffic from the Citrix ADC. This parameter is required if you have set SSL Relay as the transport protocol. Web Interface uses root certificates when authenticating a server running SSL Relay. Make sure that all the servers running SSL Relay are configured to listen on the same port. 
    .PARAMETER loadbalance 
        Use all the XML servers (load balancing mode) or only one server (failover mode).  
        Possible values = ON, OFF 
    .PARAMETER PassThru 
        Return details about the created wisite_farmname_binding item.
    .EXAMPLE
        Invoke-ADCAddWisitefarmnamebinding -sitepath <string>
    .NOTES
        File Name : Invoke-ADCAddWisitefarmnamebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_farmname_binding/
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
        [ValidateLength(1, 250)]
        [string]$sitepath ,

        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$farmname ,

        [string]$xmlserveraddresses ,

        [string]$groups ,

        [ValidateSet('ON', 'OFF')]
        [string]$recoveryfarm = 'OFF' ,

        [double]$xmlport ,

        [ValidateSet('HTTP', 'HTTPS', 'SSLRELAY')]
        [string]$transport ,

        [double]$sslrelayport ,

        [ValidateSet('ON', 'OFF')]
        [string]$loadbalance ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddWisitefarmnamebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                sitepath = $sitepath
            }
            if ($PSBoundParameters.ContainsKey('farmname')) { $Payload.Add('farmname', $farmname) }
            if ($PSBoundParameters.ContainsKey('xmlserveraddresses')) { $Payload.Add('xmlserveraddresses', $xmlserveraddresses) }
            if ($PSBoundParameters.ContainsKey('groups')) { $Payload.Add('groups', $groups) }
            if ($PSBoundParameters.ContainsKey('recoveryfarm')) { $Payload.Add('recoveryfarm', $recoveryfarm) }
            if ($PSBoundParameters.ContainsKey('xmlport')) { $Payload.Add('xmlport', $xmlport) }
            if ($PSBoundParameters.ContainsKey('transport')) { $Payload.Add('transport', $transport) }
            if ($PSBoundParameters.ContainsKey('sslrelayport')) { $Payload.Add('sslrelayport', $sslrelayport) }
            if ($PSBoundParameters.ContainsKey('loadbalance')) { $Payload.Add('loadbalance', $loadbalance) }
 
            if ($PSCmdlet.ShouldProcess("wisite_farmname_binding", "Add WebInterface configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type wisite_farmname_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetWisitefarmnamebinding -Filter $Payload)
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
        Delete WebInterface configuration Object
    .DESCRIPTION
        Delete WebInterface configuration Object
    .PARAMETER sitepath 
       Path to the Web Interface site.  
       Minimum length = 1  
       Maximum length = 250    .PARAMETER farmname 
       Name for the logical representation of a XenApp or XenDesktop farm to be bound to the Web Interface site. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        Invoke-ADCDeleteWisitefarmnamebinding -sitepath <string>
    .NOTES
        File Name : Invoke-ADCDeleteWisitefarmnamebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_farmname_binding/
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
        [string]$sitepath ,

        [string]$farmname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteWisitefarmnamebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('farmname')) { $Arguments.Add('farmname', $farmname) }
            if ($PSCmdlet.ShouldProcess("$sitepath", "Delete WebInterface configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type wisite_farmname_binding -Resource $sitepath -Arguments $Arguments
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
        Get WebInterface configuration object(s)
    .DESCRIPTION
        Get WebInterface configuration object(s)
    .PARAMETER sitepath 
       Path to the Web Interface site. 
    .PARAMETER GetAll 
        Retreive all wisite_farmname_binding object(s)
    .PARAMETER Count
        If specified, the count of the wisite_farmname_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetWisitefarmnamebinding
    .EXAMPLE 
        Invoke-ADCGetWisitefarmnamebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetWisitefarmnamebinding -Count
    .EXAMPLE
        Invoke-ADCGetWisitefarmnamebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetWisitefarmnamebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetWisitefarmnamebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_farmname_binding/
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
        [ValidateLength(1, 250)]
        [string]$sitepath,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all wisite_farmname_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_farmname_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for wisite_farmname_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_farmname_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving wisite_farmname_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_farmname_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving wisite_farmname_binding configuration for property 'sitepath'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_farmname_binding -Resource $sitepath -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving wisite_farmname_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_farmname_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add WebInterface configuration Object
    .DESCRIPTION
        Add WebInterface configuration Object 
    .PARAMETER sitepath 
        Path to the Web Interface site.  
        Minimum length = 1  
        Maximum length = 250 
    .PARAMETER translationinternalip 
        IP address of the server for which you want to associate an external IP address. (Clients access the server through the associated external address and port.).  
        Default value: 0 
    .PARAMETER translationinternalport 
        Port number of the server for which you want to associate an external port. (Clients access the server through the associated external address and port.).  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER translationexternalip 
        External IP address associated with server's IP address. 
    .PARAMETER translationexternalport 
        External port number associated with the server's port number.  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER accesstype 
        Type of access to the XenApp or XenDesktop server. Available settings function as follows: * User Device - Clients can use the translated address of the mapping entry to connect to the XenApp or XenDesktop server. * Gateway - Access Gateway can use the translated address of the mapping entry to connect to the XenApp or XenDesktop server. * User Device and Gateway - Both clients and Access Gateway can use the translated address of the mapping entry to connect to the XenApp or XenDesktop server.  
        Default value: UserDevice  
        Possible values = UserDevice, Gateway, UserDeviceAndGateway 
    .PARAMETER PassThru 
        Return details about the created wisite_translationinternalip_binding item.
    .EXAMPLE
        Invoke-ADCAddWisitetranslationinternalipbinding -sitepath <string>
    .NOTES
        File Name : Invoke-ADCAddWisitetranslationinternalipbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_translationinternalip_binding/
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
        [ValidateLength(1, 250)]
        [string]$sitepath ,

        [string]$translationinternalip = '0' ,

        [ValidateRange(1, 65535)]
        [int]$translationinternalport ,

        [string]$translationexternalip ,

        [ValidateRange(1, 65535)]
        [int]$translationexternalport ,

        [ValidateSet('UserDevice', 'Gateway', 'UserDeviceAndGateway')]
        [string]$accesstype = 'UserDevice' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddWisitetranslationinternalipbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                sitepath = $sitepath
            }
            if ($PSBoundParameters.ContainsKey('translationinternalip')) { $Payload.Add('translationinternalip', $translationinternalip) }
            if ($PSBoundParameters.ContainsKey('translationinternalport')) { $Payload.Add('translationinternalport', $translationinternalport) }
            if ($PSBoundParameters.ContainsKey('translationexternalip')) { $Payload.Add('translationexternalip', $translationexternalip) }
            if ($PSBoundParameters.ContainsKey('translationexternalport')) { $Payload.Add('translationexternalport', $translationexternalport) }
            if ($PSBoundParameters.ContainsKey('accesstype')) { $Payload.Add('accesstype', $accesstype) }
 
            if ($PSCmdlet.ShouldProcess("wisite_translationinternalip_binding", "Add WebInterface configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type wisite_translationinternalip_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetWisitetranslationinternalipbinding -Filter $Payload)
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
        Delete WebInterface configuration Object
    .DESCRIPTION
        Delete WebInterface configuration Object
    .PARAMETER sitepath 
       Path to the Web Interface site.  
       Minimum length = 1  
       Maximum length = 250    .PARAMETER translationinternalip 
       IP address of the server for which you want to associate an external IP address. (Clients access the server through the associated external address and port.).  
       Default value: 0    .PARAMETER translationinternalport 
       Port number of the server for which you want to associate an external port. (Clients access the server through the associated external address and port.).  
       Range 1 - 65535  
       * in CLI is represented as 65535 in NITRO API    .PARAMETER translationexternalip 
       External IP address associated with server's IP address.    .PARAMETER translationexternalport 
       External port number associated with the server's port number.  
       Range 1 - 65535  
       * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        Invoke-ADCDeleteWisitetranslationinternalipbinding -sitepath <string>
    .NOTES
        File Name : Invoke-ADCDeleteWisitetranslationinternalipbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_translationinternalip_binding/
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
        [string]$sitepath ,

        [string]$translationinternalip ,

        [int]$translationinternalport ,

        [string]$translationexternalip ,

        [int]$translationexternalport 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteWisitetranslationinternalipbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('translationinternalip')) { $Arguments.Add('translationinternalip', $translationinternalip) }
            if ($PSBoundParameters.ContainsKey('translationinternalport')) { $Arguments.Add('translationinternalport', $translationinternalport) }
            if ($PSBoundParameters.ContainsKey('translationexternalip')) { $Arguments.Add('translationexternalip', $translationexternalip) }
            if ($PSBoundParameters.ContainsKey('translationexternalport')) { $Arguments.Add('translationexternalport', $translationexternalport) }
            if ($PSCmdlet.ShouldProcess("$sitepath", "Delete WebInterface configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type wisite_translationinternalip_binding -Resource $sitepath -Arguments $Arguments
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
        Get WebInterface configuration object(s)
    .DESCRIPTION
        Get WebInterface configuration object(s)
    .PARAMETER sitepath 
       Path to the Web Interface site. 
    .PARAMETER GetAll 
        Retreive all wisite_translationinternalip_binding object(s)
    .PARAMETER Count
        If specified, the count of the wisite_translationinternalip_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetWisitetranslationinternalipbinding
    .EXAMPLE 
        Invoke-ADCGetWisitetranslationinternalipbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetWisitetranslationinternalipbinding -Count
    .EXAMPLE
        Invoke-ADCGetWisitetranslationinternalipbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetWisitetranslationinternalipbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetWisitetranslationinternalipbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/wi/wisite_translationinternalip_binding/
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
        [ValidateLength(1, 250)]
        [string]$sitepath,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all wisite_translationinternalip_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_translationinternalip_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for wisite_translationinternalip_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_translationinternalip_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving wisite_translationinternalip_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_translationinternalip_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving wisite_translationinternalip_binding configuration for property 'sitepath'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_translationinternalip_binding -Resource $sitepath -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving wisite_translationinternalip_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type wisite_translationinternalip_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


