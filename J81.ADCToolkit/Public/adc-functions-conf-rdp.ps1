function Invoke-ADCAddRdpclientprofile {
    <#
    .SYNOPSIS
        Add Rdp configuration Object.
    .DESCRIPTION
        Configuration for RDP clientprofile resource.
    .PARAMETER Name 
        The name of the rdp profile. 
    .PARAMETER Rdpurloverride 
        This setting determines whether the RDP parameters supplied in the vpn url override those specified in the RDP profile. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectclipboard 
        This setting corresponds to the Clipboard check box on the Local Resources tab under Options in RDC. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectdrives 
        This setting corresponds to the selections for Drives under More on the Local Resources tab under Options in RDC. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectprinters 
        This setting corresponds to the selection in the Printers check box on the Local Resources tab under Options in RDC. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectcomports 
        This setting corresponds to the selections for comports under More on the Local Resources tab under Options in RDC. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectpnpdevices 
        This setting corresponds to the selections for pnpdevices under More on the Local Resources tab under Options in RDC. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Keyboardhook 
        This setting corresponds to the selection in the Keyboard drop-down list on the Local Resources tab under Options in RDC. 
        Possible values = OnLocal, OnRemote, InFullScreenMode 
    .PARAMETER Audiocapturemode 
        This setting corresponds to the selections in the Remote audio area on the Local Resources tab under Options in RDC. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Videoplaybackmode 
        This setting determines if Remote Desktop Connection (RDC) will use RDP efficient multimedia streaming for video playback. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Multimonitorsupport 
        Enable/Disable Multiple Monitor Support for Remote Desktop Connection (RDC). 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Rdpcookievalidity 
        RDP cookie validity period. RDP cookie validity time is applicable for new connection and also for any re-connection that might happen, mostly due to network disruption or during fail-over. 
    .PARAMETER Addusernameinrdpfile 
        Add username in rdp file. 
        Possible values = YES, NO 
    .PARAMETER Rdpfilename 
        RDP file name to be sent to End User. 
    .PARAMETER Rdphost 
        Fully-qualified domain name (FQDN) of the RDP Listener. 
    .PARAMETER Rdplistener 
        IP address (or) Fully-qualified domain name(FQDN) of the RDP Listener with the port in the format IP:Port (or) FQDN:Port. 
    .PARAMETER Rdpcustomparams 
        Option for RDP custom parameters settings (if any). Custom params needs to be separated by ';'. 
    .PARAMETER Psk 
        Pre shared key value. 
    .PARAMETER Randomizerdpfilename 
        Will generate unique filename everytime rdp file is downloaded by appending output of time() function in the format <rdpfileName>_<time>.rdp. This tries to avoid the pop-up for replacement of existing rdp file during each rdp connection launch, hence providing better end-user experience. 
        Possible values = YES, NO 
    .PARAMETER Rdplinkattribute 
        Citrix Gateway allows the configuration of rdpLinkAttribute parameter which can be used to fetch a list of RDP servers(IP/FQDN) that a user can access, from an Authentication server attribute(Example: LDAP, SAML). Based on the list received, the RDP links will be generated and displayed to the user. 
        Note: The Attribute mentioned in the rdpLinkAttribute should be fetched through corresponding authentication method. 
    .PARAMETER Rdpvalidateclientip 
        This setting determines whether RDC launch is initiated by the valid client IP. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER PassThru 
        Return details about the created rdpclientprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddRdpclientprofile -name <string>
        An example how to add rdpclientprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddRdpclientprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpclientprofile/
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

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Rdpurloverride = 'ENABLE',

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectclipboard = 'ENABLE',

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectdrives = 'DISABLE',

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectprinters = 'ENABLE',

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectcomports = 'DISABLE',

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectpnpdevices = 'DISABLE',

        [ValidateSet('OnLocal', 'OnRemote', 'InFullScreenMode')]
        [string]$Keyboardhook = 'InFullScreenMode',

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Audiocapturemode = 'DISABLE',

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Videoplaybackmode = 'ENABLE',

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Multimonitorsupport = 'ENABLE',

        [ValidateRange(1, 86400)]
        [double]$Rdpcookievalidity = '60',

        [ValidateSet('YES', 'NO')]
        [string]$Addusernameinrdpfile = 'NO',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Rdpfilename,

        [string]$Rdphost,

        [string]$Rdplistener,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Rdpcustomparams = '0',

        [string]$Psk = '0',

        [ValidateSet('YES', 'NO')]
        [string]$Randomizerdpfilename = 'NO',

        [string]$Rdplinkattribute,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Rdpvalidateclientip = 'DISABLE',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddRdpclientprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rdpurloverride') ) { $payload.Add('rdpurloverride', $rdpurloverride) }
            if ( $PSBoundParameters.ContainsKey('redirectclipboard') ) { $payload.Add('redirectclipboard', $redirectclipboard) }
            if ( $PSBoundParameters.ContainsKey('redirectdrives') ) { $payload.Add('redirectdrives', $redirectdrives) }
            if ( $PSBoundParameters.ContainsKey('redirectprinters') ) { $payload.Add('redirectprinters', $redirectprinters) }
            if ( $PSBoundParameters.ContainsKey('redirectcomports') ) { $payload.Add('redirectcomports', $redirectcomports) }
            if ( $PSBoundParameters.ContainsKey('redirectpnpdevices') ) { $payload.Add('redirectpnpdevices', $redirectpnpdevices) }
            if ( $PSBoundParameters.ContainsKey('keyboardhook') ) { $payload.Add('keyboardhook', $keyboardhook) }
            if ( $PSBoundParameters.ContainsKey('audiocapturemode') ) { $payload.Add('audiocapturemode', $audiocapturemode) }
            if ( $PSBoundParameters.ContainsKey('videoplaybackmode') ) { $payload.Add('videoplaybackmode', $videoplaybackmode) }
            if ( $PSBoundParameters.ContainsKey('multimonitorsupport') ) { $payload.Add('multimonitorsupport', $multimonitorsupport) }
            if ( $PSBoundParameters.ContainsKey('rdpcookievalidity') ) { $payload.Add('rdpcookievalidity', $rdpcookievalidity) }
            if ( $PSBoundParameters.ContainsKey('addusernameinrdpfile') ) { $payload.Add('addusernameinrdpfile', $addusernameinrdpfile) }
            if ( $PSBoundParameters.ContainsKey('rdpfilename') ) { $payload.Add('rdpfilename', $rdpfilename) }
            if ( $PSBoundParameters.ContainsKey('rdphost') ) { $payload.Add('rdphost', $rdphost) }
            if ( $PSBoundParameters.ContainsKey('rdplistener') ) { $payload.Add('rdplistener', $rdplistener) }
            if ( $PSBoundParameters.ContainsKey('rdpcustomparams') ) { $payload.Add('rdpcustomparams', $rdpcustomparams) }
            if ( $PSBoundParameters.ContainsKey('psk') ) { $payload.Add('psk', $psk) }
            if ( $PSBoundParameters.ContainsKey('randomizerdpfilename') ) { $payload.Add('randomizerdpfilename', $randomizerdpfilename) }
            if ( $PSBoundParameters.ContainsKey('rdplinkattribute') ) { $payload.Add('rdplinkattribute', $rdplinkattribute) }
            if ( $PSBoundParameters.ContainsKey('rdpvalidateclientip') ) { $payload.Add('rdpvalidateclientip', $rdpvalidateclientip) }
            if ( $PSCmdlet.ShouldProcess("rdpclientprofile", "Add Rdp configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type rdpclientprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetRdpclientprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddRdpclientprofile: Finished"
    }
}

function Invoke-ADCUpdateRdpclientprofile {
    <#
    .SYNOPSIS
        Update Rdp configuration Object.
    .DESCRIPTION
        Configuration for RDP clientprofile resource.
    .PARAMETER Name 
        The name of the rdp profile. 
    .PARAMETER Rdpurloverride 
        This setting determines whether the RDP parameters supplied in the vpn url override those specified in the RDP profile. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectclipboard 
        This setting corresponds to the Clipboard check box on the Local Resources tab under Options in RDC. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectdrives 
        This setting corresponds to the selections for Drives under More on the Local Resources tab under Options in RDC. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectprinters 
        This setting corresponds to the selection in the Printers check box on the Local Resources tab under Options in RDC. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectcomports 
        This setting corresponds to the selections for comports under More on the Local Resources tab under Options in RDC. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectpnpdevices 
        This setting corresponds to the selections for pnpdevices under More on the Local Resources tab under Options in RDC. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Keyboardhook 
        This setting corresponds to the selection in the Keyboard drop-down list on the Local Resources tab under Options in RDC. 
        Possible values = OnLocal, OnRemote, InFullScreenMode 
    .PARAMETER Audiocapturemode 
        This setting corresponds to the selections in the Remote audio area on the Local Resources tab under Options in RDC. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Videoplaybackmode 
        This setting determines if Remote Desktop Connection (RDC) will use RDP efficient multimedia streaming for video playback. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Multimonitorsupport 
        Enable/Disable Multiple Monitor Support for Remote Desktop Connection (RDC). 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Rdpcookievalidity 
        RDP cookie validity period. RDP cookie validity time is applicable for new connection and also for any re-connection that might happen, mostly due to network disruption or during fail-over. 
    .PARAMETER Addusernameinrdpfile 
        Add username in rdp file. 
        Possible values = YES, NO 
    .PARAMETER Rdpfilename 
        RDP file name to be sent to End User. 
    .PARAMETER Rdphost 
        Fully-qualified domain name (FQDN) of the RDP Listener. 
    .PARAMETER Rdplistener 
        IP address (or) Fully-qualified domain name(FQDN) of the RDP Listener with the port in the format IP:Port (or) FQDN:Port. 
    .PARAMETER Rdpcustomparams 
        Option for RDP custom parameters settings (if any). Custom params needs to be separated by ';'. 
    .PARAMETER Psk 
        Pre shared key value. 
    .PARAMETER Randomizerdpfilename 
        Will generate unique filename everytime rdp file is downloaded by appending output of time() function in the format <rdpfileName>_<time>.rdp. This tries to avoid the pop-up for replacement of existing rdp file during each rdp connection launch, hence providing better end-user experience. 
        Possible values = YES, NO 
    .PARAMETER Rdplinkattribute 
        Citrix Gateway allows the configuration of rdpLinkAttribute parameter which can be used to fetch a list of RDP servers(IP/FQDN) that a user can access, from an Authentication server attribute(Example: LDAP, SAML). Based on the list received, the RDP links will be generated and displayed to the user. 
        Note: The Attribute mentioned in the rdpLinkAttribute should be fetched through corresponding authentication method. 
    .PARAMETER Rdpvalidateclientip 
        This setting determines whether RDC launch is initiated by the valid client IP. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER PassThru 
        Return details about the created rdpclientprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateRdpclientprofile -name <string>
        An example how to update rdpclientprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateRdpclientprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpclientprofile/
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

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Rdpurloverride,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectclipboard,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectdrives,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectprinters,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectcomports,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Redirectpnpdevices,

        [ValidateSet('OnLocal', 'OnRemote', 'InFullScreenMode')]
        [string]$Keyboardhook,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Audiocapturemode,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Videoplaybackmode,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Multimonitorsupport,

        [ValidateRange(1, 86400)]
        [double]$Rdpcookievalidity,

        [ValidateSet('YES', 'NO')]
        [string]$Addusernameinrdpfile,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Rdpfilename,

        [string]$Rdphost,

        [string]$Rdplistener,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Rdpcustomparams,

        [string]$Psk,

        [ValidateSet('YES', 'NO')]
        [string]$Randomizerdpfilename,

        [string]$Rdplinkattribute,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Rdpvalidateclientip,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateRdpclientprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rdpurloverride') ) { $payload.Add('rdpurloverride', $rdpurloverride) }
            if ( $PSBoundParameters.ContainsKey('redirectclipboard') ) { $payload.Add('redirectclipboard', $redirectclipboard) }
            if ( $PSBoundParameters.ContainsKey('redirectdrives') ) { $payload.Add('redirectdrives', $redirectdrives) }
            if ( $PSBoundParameters.ContainsKey('redirectprinters') ) { $payload.Add('redirectprinters', $redirectprinters) }
            if ( $PSBoundParameters.ContainsKey('redirectcomports') ) { $payload.Add('redirectcomports', $redirectcomports) }
            if ( $PSBoundParameters.ContainsKey('redirectpnpdevices') ) { $payload.Add('redirectpnpdevices', $redirectpnpdevices) }
            if ( $PSBoundParameters.ContainsKey('keyboardhook') ) { $payload.Add('keyboardhook', $keyboardhook) }
            if ( $PSBoundParameters.ContainsKey('audiocapturemode') ) { $payload.Add('audiocapturemode', $audiocapturemode) }
            if ( $PSBoundParameters.ContainsKey('videoplaybackmode') ) { $payload.Add('videoplaybackmode', $videoplaybackmode) }
            if ( $PSBoundParameters.ContainsKey('multimonitorsupport') ) { $payload.Add('multimonitorsupport', $multimonitorsupport) }
            if ( $PSBoundParameters.ContainsKey('rdpcookievalidity') ) { $payload.Add('rdpcookievalidity', $rdpcookievalidity) }
            if ( $PSBoundParameters.ContainsKey('addusernameinrdpfile') ) { $payload.Add('addusernameinrdpfile', $addusernameinrdpfile) }
            if ( $PSBoundParameters.ContainsKey('rdpfilename') ) { $payload.Add('rdpfilename', $rdpfilename) }
            if ( $PSBoundParameters.ContainsKey('rdphost') ) { $payload.Add('rdphost', $rdphost) }
            if ( $PSBoundParameters.ContainsKey('rdplistener') ) { $payload.Add('rdplistener', $rdplistener) }
            if ( $PSBoundParameters.ContainsKey('rdpcustomparams') ) { $payload.Add('rdpcustomparams', $rdpcustomparams) }
            if ( $PSBoundParameters.ContainsKey('psk') ) { $payload.Add('psk', $psk) }
            if ( $PSBoundParameters.ContainsKey('randomizerdpfilename') ) { $payload.Add('randomizerdpfilename', $randomizerdpfilename) }
            if ( $PSBoundParameters.ContainsKey('rdplinkattribute') ) { $payload.Add('rdplinkattribute', $rdplinkattribute) }
            if ( $PSBoundParameters.ContainsKey('rdpvalidateclientip') ) { $payload.Add('rdpvalidateclientip', $rdpvalidateclientip) }
            if ( $PSCmdlet.ShouldProcess("rdpclientprofile", "Update Rdp configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type rdpclientprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetRdpclientprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateRdpclientprofile: Finished"
    }
}

function Invoke-ADCUnsetRdpclientprofile {
    <#
    .SYNOPSIS
        Unset Rdp configuration Object.
    .DESCRIPTION
        Configuration for RDP clientprofile resource.
    .PARAMETER Name 
        The name of the rdp profile. 
    .PARAMETER Rdpurloverride 
        This setting determines whether the RDP parameters supplied in the vpn url override those specified in the RDP profile. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectclipboard 
        This setting corresponds to the Clipboard check box on the Local Resources tab under Options in RDC. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectdrives 
        This setting corresponds to the selections for Drives under More on the Local Resources tab under Options in RDC. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectprinters 
        This setting corresponds to the selection in the Printers check box on the Local Resources tab under Options in RDC. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectcomports 
        This setting corresponds to the selections for comports under More on the Local Resources tab under Options in RDC. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Redirectpnpdevices 
        This setting corresponds to the selections for pnpdevices under More on the Local Resources tab under Options in RDC. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Keyboardhook 
        This setting corresponds to the selection in the Keyboard drop-down list on the Local Resources tab under Options in RDC. 
        Possible values = OnLocal, OnRemote, InFullScreenMode 
    .PARAMETER Audiocapturemode 
        This setting corresponds to the selections in the Remote audio area on the Local Resources tab under Options in RDC. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Videoplaybackmode 
        This setting determines if Remote Desktop Connection (RDC) will use RDP efficient multimedia streaming for video playback. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Multimonitorsupport 
        Enable/Disable Multiple Monitor Support for Remote Desktop Connection (RDC). 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Rdpcookievalidity 
        RDP cookie validity period. RDP cookie validity time is applicable for new connection and also for any re-connection that might happen, mostly due to network disruption or during fail-over. 
    .PARAMETER Addusernameinrdpfile 
        Add username in rdp file. 
        Possible values = YES, NO 
    .PARAMETER Rdpfilename 
        RDP file name to be sent to End User. 
    .PARAMETER Rdphost 
        Fully-qualified domain name (FQDN) of the RDP Listener. 
    .PARAMETER Rdplistener 
        IP address (or) Fully-qualified domain name(FQDN) of the RDP Listener with the port in the format IP:Port (or) FQDN:Port. 
    .PARAMETER Rdpcustomparams 
        Option for RDP custom parameters settings (if any). Custom params needs to be separated by ';'. 
    .PARAMETER Psk 
        Pre shared key value. 
    .PARAMETER Randomizerdpfilename 
        Will generate unique filename everytime rdp file is downloaded by appending output of time() function in the format <rdpfileName>_<time>.rdp. This tries to avoid the pop-up for replacement of existing rdp file during each rdp connection launch, hence providing better end-user experience. 
        Possible values = YES, NO 
    .PARAMETER Rdplinkattribute 
        Citrix Gateway allows the configuration of rdpLinkAttribute parameter which can be used to fetch a list of RDP servers(IP/FQDN) that a user can access, from an Authentication server attribute(Example: LDAP, SAML). Based on the list received, the RDP links will be generated and displayed to the user. 
        Note: The Attribute mentioned in the rdpLinkAttribute should be fetched through corresponding authentication method. 
    .PARAMETER Rdpvalidateclientip 
        This setting determines whether RDC launch is initiated by the valid client IP. 
        Possible values = ENABLE, DISABLE
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetRdpclientprofile -name <string>
        An example how to unset rdpclientprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetRdpclientprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpclientprofile
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

        [Boolean]$rdpurloverride,

        [Boolean]$redirectclipboard,

        [Boolean]$redirectdrives,

        [Boolean]$redirectprinters,

        [Boolean]$redirectcomports,

        [Boolean]$redirectpnpdevices,

        [Boolean]$keyboardhook,

        [Boolean]$audiocapturemode,

        [Boolean]$videoplaybackmode,

        [Boolean]$multimonitorsupport,

        [Boolean]$rdpcookievalidity,

        [Boolean]$addusernameinrdpfile,

        [Boolean]$rdpfilename,

        [Boolean]$rdphost,

        [Boolean]$rdplistener,

        [Boolean]$rdpcustomparams,

        [Boolean]$psk,

        [Boolean]$randomizerdpfilename,

        [Boolean]$rdplinkattribute,

        [Boolean]$rdpvalidateclientip 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetRdpclientprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rdpurloverride') ) { $payload.Add('rdpurloverride', $rdpurloverride) }
            if ( $PSBoundParameters.ContainsKey('redirectclipboard') ) { $payload.Add('redirectclipboard', $redirectclipboard) }
            if ( $PSBoundParameters.ContainsKey('redirectdrives') ) { $payload.Add('redirectdrives', $redirectdrives) }
            if ( $PSBoundParameters.ContainsKey('redirectprinters') ) { $payload.Add('redirectprinters', $redirectprinters) }
            if ( $PSBoundParameters.ContainsKey('redirectcomports') ) { $payload.Add('redirectcomports', $redirectcomports) }
            if ( $PSBoundParameters.ContainsKey('redirectpnpdevices') ) { $payload.Add('redirectpnpdevices', $redirectpnpdevices) }
            if ( $PSBoundParameters.ContainsKey('keyboardhook') ) { $payload.Add('keyboardhook', $keyboardhook) }
            if ( $PSBoundParameters.ContainsKey('audiocapturemode') ) { $payload.Add('audiocapturemode', $audiocapturemode) }
            if ( $PSBoundParameters.ContainsKey('videoplaybackmode') ) { $payload.Add('videoplaybackmode', $videoplaybackmode) }
            if ( $PSBoundParameters.ContainsKey('multimonitorsupport') ) { $payload.Add('multimonitorsupport', $multimonitorsupport) }
            if ( $PSBoundParameters.ContainsKey('rdpcookievalidity') ) { $payload.Add('rdpcookievalidity', $rdpcookievalidity) }
            if ( $PSBoundParameters.ContainsKey('addusernameinrdpfile') ) { $payload.Add('addusernameinrdpfile', $addusernameinrdpfile) }
            if ( $PSBoundParameters.ContainsKey('rdpfilename') ) { $payload.Add('rdpfilename', $rdpfilename) }
            if ( $PSBoundParameters.ContainsKey('rdphost') ) { $payload.Add('rdphost', $rdphost) }
            if ( $PSBoundParameters.ContainsKey('rdplistener') ) { $payload.Add('rdplistener', $rdplistener) }
            if ( $PSBoundParameters.ContainsKey('rdpcustomparams') ) { $payload.Add('rdpcustomparams', $rdpcustomparams) }
            if ( $PSBoundParameters.ContainsKey('psk') ) { $payload.Add('psk', $psk) }
            if ( $PSBoundParameters.ContainsKey('randomizerdpfilename') ) { $payload.Add('randomizerdpfilename', $randomizerdpfilename) }
            if ( $PSBoundParameters.ContainsKey('rdplinkattribute') ) { $payload.Add('rdplinkattribute', $rdplinkattribute) }
            if ( $PSBoundParameters.ContainsKey('rdpvalidateclientip') ) { $payload.Add('rdpvalidateclientip', $rdpvalidateclientip) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Rdp configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type rdpclientprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetRdpclientprofile: Finished"
    }
}

function Invoke-ADCDeleteRdpclientprofile {
    <#
    .SYNOPSIS
        Delete Rdp configuration Object.
    .DESCRIPTION
        Configuration for RDP clientprofile resource.
    .PARAMETER Name 
        The name of the rdp profile.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteRdpclientprofile -Name <string>
        An example how to delete rdpclientprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteRdpclientprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpclientprofile/
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
        Write-Verbose "Invoke-ADCDeleteRdpclientprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Rdp configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type rdpclientprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteRdpclientprofile: Finished"
    }
}

function Invoke-ADCGetRdpclientprofile {
    <#
    .SYNOPSIS
        Get Rdp configuration object(s).
    .DESCRIPTION
        Configuration for RDP clientprofile resource.
    .PARAMETER Name 
        The name of the rdp profile. 
    .PARAMETER GetAll 
        Retrieve all rdpclientprofile object(s).
    .PARAMETER Count
        If specified, the count of the rdpclientprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRdpclientprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRdpclientprofile -GetAll 
        Get all rdpclientprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRdpclientprofile -Count 
        Get the number of rdpclientprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRdpclientprofile -name <string>
        Get rdpclientprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRdpclientprofile -Filter @{ 'name'='<value>' }
        Get rdpclientprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRdpclientprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpclientprofile/
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
        Write-Verbose "Invoke-ADCGetRdpclientprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all rdpclientprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpclientprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rdpclientprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpclientprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rdpclientprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpclientprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rdpclientprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpclientprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rdpclientprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpclientprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRdpclientprofile: Ended"
    }
}

function Invoke-ADCKillRdpconnections {
    <#
    .SYNOPSIS
        Kill Rdp configuration Object.
    .DESCRIPTION
        Configuration for active rdp connections resource.
    .PARAMETER Username 
        User name for which to display connections. 
    .PARAMETER All 
        Terminate all active rdpconnections.
    .EXAMPLE
        PS C:\>Invoke-ADCKillRdpconnections 
        An example how to kill rdpconnections configuration Object(s).
    .NOTES
        File Name : Invoke-ADCKillRdpconnections
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpconnections/
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
        [string]$Username,

        [boolean]$All 

    )
    begin {
        Write-Verbose "Invoke-ADCKillRdpconnections: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('username') ) { $payload.Add('username', $username) }
            if ( $PSBoundParameters.ContainsKey('all') ) { $payload.Add('all', $all) }
            if ( $PSCmdlet.ShouldProcess($Name, "Kill Rdp configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type rdpconnections -Action kill -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCKillRdpconnections: Finished"
    }
}

function Invoke-ADCGetRdpconnections {
    <#
    .SYNOPSIS
        Get Rdp configuration object(s).
    .DESCRIPTION
        Configuration for active rdp connections resource.
    .PARAMETER Username 
        User name for which to display connections. 
    .PARAMETER GetAll 
        Retrieve all rdpconnections object(s).
    .PARAMETER Count
        If specified, the count of the rdpconnections object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRdpconnections
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRdpconnections -GetAll 
        Get all rdpconnections data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRdpconnections -Count 
        Get the number of rdpconnections objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRdpconnections -name <string>
        Get rdpconnections object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRdpconnections -Filter @{ 'name'='<value>' }
        Get rdpconnections data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRdpconnections
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpconnections/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetRdpconnections: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all rdpconnections objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpconnections -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rdpconnections objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpconnections -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rdpconnections objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('username') ) { $arguments.Add('username', $username) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpconnections -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rdpconnections configuration for property ''"

            } else {
                Write-Verbose "Retrieving rdpconnections configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpconnections -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRdpconnections: Ended"
    }
}

function Invoke-ADCAddRdpserverprofile {
    <#
    .SYNOPSIS
        Add Rdp configuration Object.
    .DESCRIPTION
        Configuration for RDP serverprofile resource.
    .PARAMETER Name 
        The name of the rdp server profile. 
    .PARAMETER Rdpip 
        IPv4 or IPv6 address of RDP listener. This terminates client RDP connections. 
    .PARAMETER Rdpport 
        TCP port on which the RDP connection is established. 
    .PARAMETER Psk 
        Pre shared key value. 
    .PARAMETER Rdpredirection 
        Enable/Disable RDP redirection support. This needs to be enabled in presence of connection broker or session directory with IP cookie(msts cookie) based redirection support. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER PassThru 
        Return details about the created rdpserverprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddRdpserverprofile -name <string> -psk <string>
        An example how to add rdpserverprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddRdpserverprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpserverprofile/
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
        [ValidateLength(1, 32)]
        [string]$Name,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Rdpip,

        [ValidateRange(1, 65535)]
        [double]$Rdpport = '3389',

        [Parameter(Mandatory)]
        [string]$Psk,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Rdpredirection = 'DISABLE',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddRdpserverprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                psk            = $psk
            }
            if ( $PSBoundParameters.ContainsKey('rdpip') ) { $payload.Add('rdpip', $rdpip) }
            if ( $PSBoundParameters.ContainsKey('rdpport') ) { $payload.Add('rdpport', $rdpport) }
            if ( $PSBoundParameters.ContainsKey('rdpredirection') ) { $payload.Add('rdpredirection', $rdpredirection) }
            if ( $PSCmdlet.ShouldProcess("rdpserverprofile", "Add Rdp configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type rdpserverprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetRdpserverprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddRdpserverprofile: Finished"
    }
}

function Invoke-ADCUpdateRdpserverprofile {
    <#
    .SYNOPSIS
        Update Rdp configuration Object.
    .DESCRIPTION
        Configuration for RDP serverprofile resource.
    .PARAMETER Name 
        The name of the rdp server profile. 
    .PARAMETER Rdpip 
        IPv4 or IPv6 address of RDP listener. This terminates client RDP connections. 
    .PARAMETER Rdpport 
        TCP port on which the RDP connection is established. 
    .PARAMETER Psk 
        Pre shared key value. 
    .PARAMETER Rdpredirection 
        Enable/Disable RDP redirection support. This needs to be enabled in presence of connection broker or session directory with IP cookie(msts cookie) based redirection support. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER PassThru 
        Return details about the created rdpserverprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateRdpserverprofile -name <string>
        An example how to update rdpserverprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateRdpserverprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpserverprofile/
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
        [ValidateLength(1, 32)]
        [string]$Name,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Rdpip,

        [ValidateRange(1, 65535)]
        [double]$Rdpport,

        [string]$Psk,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Rdpredirection,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateRdpserverprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rdpip') ) { $payload.Add('rdpip', $rdpip) }
            if ( $PSBoundParameters.ContainsKey('rdpport') ) { $payload.Add('rdpport', $rdpport) }
            if ( $PSBoundParameters.ContainsKey('psk') ) { $payload.Add('psk', $psk) }
            if ( $PSBoundParameters.ContainsKey('rdpredirection') ) { $payload.Add('rdpredirection', $rdpredirection) }
            if ( $PSCmdlet.ShouldProcess("rdpserverprofile", "Update Rdp configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type rdpserverprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetRdpserverprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateRdpserverprofile: Finished"
    }
}

function Invoke-ADCUnsetRdpserverprofile {
    <#
    .SYNOPSIS
        Unset Rdp configuration Object.
    .DESCRIPTION
        Configuration for RDP serverprofile resource.
    .PARAMETER Name 
        The name of the rdp server profile. 
    .PARAMETER Rdpip 
        IPv4 or IPv6 address of RDP listener. This terminates client RDP connections. 
    .PARAMETER Rdpport 
        TCP port on which the RDP connection is established. 
    .PARAMETER Psk 
        Pre shared key value. 
    .PARAMETER Rdpredirection 
        Enable/Disable RDP redirection support. This needs to be enabled in presence of connection broker or session directory with IP cookie(msts cookie) based redirection support. 
        Possible values = ENABLE, DISABLE
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetRdpserverprofile -name <string>
        An example how to unset rdpserverprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetRdpserverprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpserverprofile
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

        [ValidateLength(1, 32)]
        [string]$Name,

        [Boolean]$rdpip,

        [Boolean]$rdpport,

        [Boolean]$psk,

        [Boolean]$rdpredirection 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetRdpserverprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rdpip') ) { $payload.Add('rdpip', $rdpip) }
            if ( $PSBoundParameters.ContainsKey('rdpport') ) { $payload.Add('rdpport', $rdpport) }
            if ( $PSBoundParameters.ContainsKey('psk') ) { $payload.Add('psk', $psk) }
            if ( $PSBoundParameters.ContainsKey('rdpredirection') ) { $payload.Add('rdpredirection', $rdpredirection) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Rdp configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type rdpserverprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetRdpserverprofile: Finished"
    }
}

function Invoke-ADCDeleteRdpserverprofile {
    <#
    .SYNOPSIS
        Delete Rdp configuration Object.
    .DESCRIPTION
        Configuration for RDP serverprofile resource.
    .PARAMETER Name 
        The name of the rdp server profile.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteRdpserverprofile -Name <string>
        An example how to delete rdpserverprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteRdpserverprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpserverprofile/
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
        Write-Verbose "Invoke-ADCDeleteRdpserverprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Rdp configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type rdpserverprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteRdpserverprofile: Finished"
    }
}

function Invoke-ADCGetRdpserverprofile {
    <#
    .SYNOPSIS
        Get Rdp configuration object(s).
    .DESCRIPTION
        Configuration for RDP serverprofile resource.
    .PARAMETER Name 
        The name of the rdp server profile. 
    .PARAMETER GetAll 
        Retrieve all rdpserverprofile object(s).
    .PARAMETER Count
        If specified, the count of the rdpserverprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRdpserverprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRdpserverprofile -GetAll 
        Get all rdpserverprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRdpserverprofile -Count 
        Get the number of rdpserverprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRdpserverprofile -name <string>
        Get rdpserverprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRdpserverprofile -Filter @{ 'name'='<value>' }
        Get rdpserverprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRdpserverprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpserverprofile/
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
        [ValidateLength(1, 32)]
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
        Write-Verbose "Invoke-ADCGetRdpserverprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all rdpserverprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpserverprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rdpserverprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpserverprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rdpserverprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpserverprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rdpserverprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpserverprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rdpserverprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpserverprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRdpserverprofile: Ended"
    }
}


