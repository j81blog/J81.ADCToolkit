function Invoke-ADCAddRdpclientprofile {
<#
    .SYNOPSIS
        Add Rdp configuration Object
    .DESCRIPTION
        Add Rdp configuration Object 
    .PARAMETER name 
        The name of the rdp profile.  
        Minimum length = 1 
    .PARAMETER rdpurloverride 
        This setting determines whether the RDP parameters supplied in the vpn url override those specified in the RDP profile.  
        Default value: ENABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER redirectclipboard 
        This setting corresponds to the Clipboard check box on the Local Resources tab under Options in RDC.  
        Default value: ENABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER redirectdrives 
        This setting corresponds to the selections for Drives under More on the Local Resources tab under Options in RDC.  
        Default value: DISABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER redirectprinters 
        This setting corresponds to the selection in the Printers check box on the Local Resources tab under Options in RDC.  
        Default value: ENABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER redirectcomports 
        This setting corresponds to the selections for comports under More on the Local Resources tab under Options in RDC.  
        Default value: DISABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER redirectpnpdevices 
        This setting corresponds to the selections for pnpdevices under More on the Local Resources tab under Options in RDC.  
        Default value: DISABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER keyboardhook 
        This setting corresponds to the selection in the Keyboard drop-down list on the Local Resources tab under Options in RDC.  
        Default value: InFullScreenMode  
        Possible values = OnLocal, OnRemote, InFullScreenMode 
    .PARAMETER audiocapturemode 
        This setting corresponds to the selections in the Remote audio area on the Local Resources tab under Options in RDC.  
        Default value: DISABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER videoplaybackmode 
        This setting determines if Remote Desktop Connection (RDC) will use RDP efficient multimedia streaming for video playback.  
        Default value: ENABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER multimonitorsupport 
        Enable/Disable Multiple Monitor Support for Remote Desktop Connection (RDC).  
        Default value: ENABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER rdpcookievalidity 
        RDP cookie validity period. RDP cookie validity time is applicable for new connection and also for any re-connection that might happen, mostly due to network disruption or during fail-over.  
        Default value: 60  
        Minimum value = 1  
        Maximum value = 86400 
    .PARAMETER addusernameinrdpfile 
        Add username in rdp file.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER rdpfilename 
        RDP file name to be sent to End User.  
        Minimum length = 1 
    .PARAMETER rdphost 
        Fully-qualified domain name (FQDN) of the RDP Listener.  
        Maximum length = 252 
    .PARAMETER rdplistener 
        IP address (or) Fully-qualified domain name(FQDN) of the RDP Listener with the port in the format IP:Port (or) FQDN:Port.  
        Maximum length = 255 
    .PARAMETER rdpcustomparams 
        Option for RDP custom parameters settings (if any). Custom params needs to be separated by ';'.  
        Default value: 0  
        Minimum length = 1 
    .PARAMETER psk 
        Pre shared key value.  
        Default value: 0 
    .PARAMETER randomizerdpfilename 
        Will generate unique filename everytime rdp file is downloaded by appending output of time() function in the format <rdpfileName>_<time>.rdp. This tries to avoid the pop-up for replacement of existing rdp file during each rdp connection launch, hence providing better end-user experience.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER rdplinkattribute 
        Citrix Gateway allows the configuration of rdpLinkAttribute parameter which can be used to fetch a list of RDP servers(IP/FQDN) that a user can access, from an Authentication server attribute(Example: LDAP, SAML). Based on the list received, the RDP links will be generated and displayed to the user.  
        Note: The Attribute mentioned in the rdpLinkAttribute should be fetched through corresponding authentication method. 
    .PARAMETER PassThru 
        Return details about the created rdpclientprofile item.
    .EXAMPLE
        Invoke-ADCAddRdpclientprofile -name <string>
    .NOTES
        File Name : Invoke-ADCAddRdpclientprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpclientprofile/
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

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$rdpurloverride = 'ENABLE' ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$redirectclipboard = 'ENABLE' ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$redirectdrives = 'DISABLE' ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$redirectprinters = 'ENABLE' ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$redirectcomports = 'DISABLE' ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$redirectpnpdevices = 'DISABLE' ,

        [ValidateSet('OnLocal', 'OnRemote', 'InFullScreenMode')]
        [string]$keyboardhook = 'InFullScreenMode' ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$audiocapturemode = 'DISABLE' ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$videoplaybackmode = 'ENABLE' ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$multimonitorsupport = 'ENABLE' ,

        [ValidateRange(1, 86400)]
        [double]$rdpcookievalidity = '60' ,

        [ValidateSet('YES', 'NO')]
        [string]$addusernameinrdpfile = 'NO' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$rdpfilename ,

        [string]$rdphost ,

        [string]$rdplistener ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$rdpcustomparams = '0' ,

        [string]$psk = '0' ,

        [ValidateSet('YES', 'NO')]
        [string]$randomizerdpfilename = 'NO' ,

        [string]$rdplinkattribute ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddRdpclientprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rdpurloverride')) { $Payload.Add('rdpurloverride', $rdpurloverride) }
            if ($PSBoundParameters.ContainsKey('redirectclipboard')) { $Payload.Add('redirectclipboard', $redirectclipboard) }
            if ($PSBoundParameters.ContainsKey('redirectdrives')) { $Payload.Add('redirectdrives', $redirectdrives) }
            if ($PSBoundParameters.ContainsKey('redirectprinters')) { $Payload.Add('redirectprinters', $redirectprinters) }
            if ($PSBoundParameters.ContainsKey('redirectcomports')) { $Payload.Add('redirectcomports', $redirectcomports) }
            if ($PSBoundParameters.ContainsKey('redirectpnpdevices')) { $Payload.Add('redirectpnpdevices', $redirectpnpdevices) }
            if ($PSBoundParameters.ContainsKey('keyboardhook')) { $Payload.Add('keyboardhook', $keyboardhook) }
            if ($PSBoundParameters.ContainsKey('audiocapturemode')) { $Payload.Add('audiocapturemode', $audiocapturemode) }
            if ($PSBoundParameters.ContainsKey('videoplaybackmode')) { $Payload.Add('videoplaybackmode', $videoplaybackmode) }
            if ($PSBoundParameters.ContainsKey('multimonitorsupport')) { $Payload.Add('multimonitorsupport', $multimonitorsupport) }
            if ($PSBoundParameters.ContainsKey('rdpcookievalidity')) { $Payload.Add('rdpcookievalidity', $rdpcookievalidity) }
            if ($PSBoundParameters.ContainsKey('addusernameinrdpfile')) { $Payload.Add('addusernameinrdpfile', $addusernameinrdpfile) }
            if ($PSBoundParameters.ContainsKey('rdpfilename')) { $Payload.Add('rdpfilename', $rdpfilename) }
            if ($PSBoundParameters.ContainsKey('rdphost')) { $Payload.Add('rdphost', $rdphost) }
            if ($PSBoundParameters.ContainsKey('rdplistener')) { $Payload.Add('rdplistener', $rdplistener) }
            if ($PSBoundParameters.ContainsKey('rdpcustomparams')) { $Payload.Add('rdpcustomparams', $rdpcustomparams) }
            if ($PSBoundParameters.ContainsKey('psk')) { $Payload.Add('psk', $psk) }
            if ($PSBoundParameters.ContainsKey('randomizerdpfilename')) { $Payload.Add('randomizerdpfilename', $randomizerdpfilename) }
            if ($PSBoundParameters.ContainsKey('rdplinkattribute')) { $Payload.Add('rdplinkattribute', $rdplinkattribute) }
 
            if ($PSCmdlet.ShouldProcess("rdpclientprofile", "Add Rdp configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type rdpclientprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetRdpclientprofile -Filter $Payload)
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
        Update Rdp configuration Object
    .DESCRIPTION
        Update Rdp configuration Object 
    .PARAMETER name 
        The name of the rdp profile.  
        Minimum length = 1 
    .PARAMETER rdpurloverride 
        This setting determines whether the RDP parameters supplied in the vpn url override those specified in the RDP profile.  
        Default value: ENABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER redirectclipboard 
        This setting corresponds to the Clipboard check box on the Local Resources tab under Options in RDC.  
        Default value: ENABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER redirectdrives 
        This setting corresponds to the selections for Drives under More on the Local Resources tab under Options in RDC.  
        Default value: DISABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER redirectprinters 
        This setting corresponds to the selection in the Printers check box on the Local Resources tab under Options in RDC.  
        Default value: ENABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER redirectcomports 
        This setting corresponds to the selections for comports under More on the Local Resources tab under Options in RDC.  
        Default value: DISABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER redirectpnpdevices 
        This setting corresponds to the selections for pnpdevices under More on the Local Resources tab under Options in RDC.  
        Default value: DISABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER keyboardhook 
        This setting corresponds to the selection in the Keyboard drop-down list on the Local Resources tab under Options in RDC.  
        Default value: InFullScreenMode  
        Possible values = OnLocal, OnRemote, InFullScreenMode 
    .PARAMETER audiocapturemode 
        This setting corresponds to the selections in the Remote audio area on the Local Resources tab under Options in RDC.  
        Default value: DISABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER videoplaybackmode 
        This setting determines if Remote Desktop Connection (RDC) will use RDP efficient multimedia streaming for video playback.  
        Default value: ENABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER multimonitorsupport 
        Enable/Disable Multiple Monitor Support for Remote Desktop Connection (RDC).  
        Default value: ENABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER rdpcookievalidity 
        RDP cookie validity period. RDP cookie validity time is applicable for new connection and also for any re-connection that might happen, mostly due to network disruption or during fail-over.  
        Default value: 60  
        Minimum value = 1  
        Maximum value = 86400 
    .PARAMETER addusernameinrdpfile 
        Add username in rdp file.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER rdpfilename 
        RDP file name to be sent to End User.  
        Minimum length = 1 
    .PARAMETER rdphost 
        Fully-qualified domain name (FQDN) of the RDP Listener.  
        Maximum length = 252 
    .PARAMETER rdplistener 
        IP address (or) Fully-qualified domain name(FQDN) of the RDP Listener with the port in the format IP:Port (or) FQDN:Port.  
        Maximum length = 255 
    .PARAMETER rdpcustomparams 
        Option for RDP custom parameters settings (if any). Custom params needs to be separated by ';'.  
        Default value: 0  
        Minimum length = 1 
    .PARAMETER psk 
        Pre shared key value.  
        Default value: 0 
    .PARAMETER randomizerdpfilename 
        Will generate unique filename everytime rdp file is downloaded by appending output of time() function in the format <rdpfileName>_<time>.rdp. This tries to avoid the pop-up for replacement of existing rdp file during each rdp connection launch, hence providing better end-user experience.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER rdplinkattribute 
        Citrix Gateway allows the configuration of rdpLinkAttribute parameter which can be used to fetch a list of RDP servers(IP/FQDN) that a user can access, from an Authentication server attribute(Example: LDAP, SAML). Based on the list received, the RDP links will be generated and displayed to the user.  
        Note: The Attribute mentioned in the rdpLinkAttribute should be fetched through corresponding authentication method. 
    .PARAMETER PassThru 
        Return details about the created rdpclientprofile item.
    .EXAMPLE
        Invoke-ADCUpdateRdpclientprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateRdpclientprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpclientprofile/
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

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$rdpurloverride ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$redirectclipboard ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$redirectdrives ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$redirectprinters ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$redirectcomports ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$redirectpnpdevices ,

        [ValidateSet('OnLocal', 'OnRemote', 'InFullScreenMode')]
        [string]$keyboardhook ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$audiocapturemode ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$videoplaybackmode ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$multimonitorsupport ,

        [ValidateRange(1, 86400)]
        [double]$rdpcookievalidity ,

        [ValidateSet('YES', 'NO')]
        [string]$addusernameinrdpfile ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$rdpfilename ,

        [string]$rdphost ,

        [string]$rdplistener ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$rdpcustomparams ,

        [string]$psk ,

        [ValidateSet('YES', 'NO')]
        [string]$randomizerdpfilename ,

        [string]$rdplinkattribute ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateRdpclientprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rdpurloverride')) { $Payload.Add('rdpurloverride', $rdpurloverride) }
            if ($PSBoundParameters.ContainsKey('redirectclipboard')) { $Payload.Add('redirectclipboard', $redirectclipboard) }
            if ($PSBoundParameters.ContainsKey('redirectdrives')) { $Payload.Add('redirectdrives', $redirectdrives) }
            if ($PSBoundParameters.ContainsKey('redirectprinters')) { $Payload.Add('redirectprinters', $redirectprinters) }
            if ($PSBoundParameters.ContainsKey('redirectcomports')) { $Payload.Add('redirectcomports', $redirectcomports) }
            if ($PSBoundParameters.ContainsKey('redirectpnpdevices')) { $Payload.Add('redirectpnpdevices', $redirectpnpdevices) }
            if ($PSBoundParameters.ContainsKey('keyboardhook')) { $Payload.Add('keyboardhook', $keyboardhook) }
            if ($PSBoundParameters.ContainsKey('audiocapturemode')) { $Payload.Add('audiocapturemode', $audiocapturemode) }
            if ($PSBoundParameters.ContainsKey('videoplaybackmode')) { $Payload.Add('videoplaybackmode', $videoplaybackmode) }
            if ($PSBoundParameters.ContainsKey('multimonitorsupport')) { $Payload.Add('multimonitorsupport', $multimonitorsupport) }
            if ($PSBoundParameters.ContainsKey('rdpcookievalidity')) { $Payload.Add('rdpcookievalidity', $rdpcookievalidity) }
            if ($PSBoundParameters.ContainsKey('addusernameinrdpfile')) { $Payload.Add('addusernameinrdpfile', $addusernameinrdpfile) }
            if ($PSBoundParameters.ContainsKey('rdpfilename')) { $Payload.Add('rdpfilename', $rdpfilename) }
            if ($PSBoundParameters.ContainsKey('rdphost')) { $Payload.Add('rdphost', $rdphost) }
            if ($PSBoundParameters.ContainsKey('rdplistener')) { $Payload.Add('rdplistener', $rdplistener) }
            if ($PSBoundParameters.ContainsKey('rdpcustomparams')) { $Payload.Add('rdpcustomparams', $rdpcustomparams) }
            if ($PSBoundParameters.ContainsKey('psk')) { $Payload.Add('psk', $psk) }
            if ($PSBoundParameters.ContainsKey('randomizerdpfilename')) { $Payload.Add('randomizerdpfilename', $randomizerdpfilename) }
            if ($PSBoundParameters.ContainsKey('rdplinkattribute')) { $Payload.Add('rdplinkattribute', $rdplinkattribute) }
 
            if ($PSCmdlet.ShouldProcess("rdpclientprofile", "Update Rdp configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type rdpclientprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetRdpclientprofile -Filter $Payload)
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
        Unset Rdp configuration Object
    .DESCRIPTION
        Unset Rdp configuration Object 
   .PARAMETER name 
       The name of the rdp profile. 
   .PARAMETER rdpurloverride 
       This setting determines whether the RDP parameters supplied in the vpn url override those specified in the RDP profile.  
       Possible values = ENABLE, DISABLE 
   .PARAMETER redirectclipboard 
       This setting corresponds to the Clipboard check box on the Local Resources tab under Options in RDC.  
       Possible values = ENABLE, DISABLE 
   .PARAMETER redirectdrives 
       This setting corresponds to the selections for Drives under More on the Local Resources tab under Options in RDC.  
       Possible values = ENABLE, DISABLE 
   .PARAMETER redirectprinters 
       This setting corresponds to the selection in the Printers check box on the Local Resources tab under Options in RDC.  
       Possible values = ENABLE, DISABLE 
   .PARAMETER redirectcomports 
       This setting corresponds to the selections for comports under More on the Local Resources tab under Options in RDC.  
       Possible values = ENABLE, DISABLE 
   .PARAMETER redirectpnpdevices 
       This setting corresponds to the selections for pnpdevices under More on the Local Resources tab under Options in RDC.  
       Possible values = ENABLE, DISABLE 
   .PARAMETER keyboardhook 
       This setting corresponds to the selection in the Keyboard drop-down list on the Local Resources tab under Options in RDC.  
       Possible values = OnLocal, OnRemote, InFullScreenMode 
   .PARAMETER audiocapturemode 
       This setting corresponds to the selections in the Remote audio area on the Local Resources tab under Options in RDC.  
       Possible values = ENABLE, DISABLE 
   .PARAMETER videoplaybackmode 
       This setting determines if Remote Desktop Connection (RDC) will use RDP efficient multimedia streaming for video playback.  
       Possible values = ENABLE, DISABLE 
   .PARAMETER multimonitorsupport 
       Enable/Disable Multiple Monitor Support for Remote Desktop Connection (RDC).  
       Possible values = ENABLE, DISABLE 
   .PARAMETER rdpcookievalidity 
       RDP cookie validity period. RDP cookie validity time is applicable for new connection and also for any re-connection that might happen, mostly due to network disruption or during fail-over. 
   .PARAMETER addusernameinrdpfile 
       Add username in rdp file.  
       Possible values = YES, NO 
   .PARAMETER rdpfilename 
       RDP file name to be sent to End User. 
   .PARAMETER rdphost 
       Fully-qualified domain name (FQDN) of the RDP Listener. 
   .PARAMETER rdplistener 
       IP address (or) Fully-qualified domain name(FQDN) of the RDP Listener with the port in the format IP:Port (or) FQDN:Port. 
   .PARAMETER rdpcustomparams 
       Option for RDP custom parameters settings (if any). Custom params needs to be separated by ';'. 
   .PARAMETER psk 
       Pre shared key value. 
   .PARAMETER randomizerdpfilename 
       Will generate unique filename everytime rdp file is downloaded by appending output of time() function in the format <rdpfileName>_<time>.rdp. This tries to avoid the pop-up for replacement of existing rdp file during each rdp connection launch, hence providing better end-user experience.  
       Possible values = YES, NO 
   .PARAMETER rdplinkattribute 
       Citrix Gateway allows the configuration of rdpLinkAttribute parameter which can be used to fetch a list of RDP servers(IP/FQDN) that a user can access, from an Authentication server attribute(Example: LDAP, SAML). Based on the list received, the RDP links will be generated and displayed to the user.  
       Note: The Attribute mentioned in the rdpLinkAttribute should be fetched through corresponding authentication method.
    .EXAMPLE
        Invoke-ADCUnsetRdpclientprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetRdpclientprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpclientprofile
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

        [Boolean]$rdpurloverride ,

        [Boolean]$redirectclipboard ,

        [Boolean]$redirectdrives ,

        [Boolean]$redirectprinters ,

        [Boolean]$redirectcomports ,

        [Boolean]$redirectpnpdevices ,

        [Boolean]$keyboardhook ,

        [Boolean]$audiocapturemode ,

        [Boolean]$videoplaybackmode ,

        [Boolean]$multimonitorsupport ,

        [Boolean]$rdpcookievalidity ,

        [Boolean]$addusernameinrdpfile ,

        [Boolean]$rdpfilename ,

        [Boolean]$rdphost ,

        [Boolean]$rdplistener ,

        [Boolean]$rdpcustomparams ,

        [Boolean]$psk ,

        [Boolean]$randomizerdpfilename ,

        [Boolean]$rdplinkattribute 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetRdpclientprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rdpurloverride')) { $Payload.Add('rdpurloverride', $rdpurloverride) }
            if ($PSBoundParameters.ContainsKey('redirectclipboard')) { $Payload.Add('redirectclipboard', $redirectclipboard) }
            if ($PSBoundParameters.ContainsKey('redirectdrives')) { $Payload.Add('redirectdrives', $redirectdrives) }
            if ($PSBoundParameters.ContainsKey('redirectprinters')) { $Payload.Add('redirectprinters', $redirectprinters) }
            if ($PSBoundParameters.ContainsKey('redirectcomports')) { $Payload.Add('redirectcomports', $redirectcomports) }
            if ($PSBoundParameters.ContainsKey('redirectpnpdevices')) { $Payload.Add('redirectpnpdevices', $redirectpnpdevices) }
            if ($PSBoundParameters.ContainsKey('keyboardhook')) { $Payload.Add('keyboardhook', $keyboardhook) }
            if ($PSBoundParameters.ContainsKey('audiocapturemode')) { $Payload.Add('audiocapturemode', $audiocapturemode) }
            if ($PSBoundParameters.ContainsKey('videoplaybackmode')) { $Payload.Add('videoplaybackmode', $videoplaybackmode) }
            if ($PSBoundParameters.ContainsKey('multimonitorsupport')) { $Payload.Add('multimonitorsupport', $multimonitorsupport) }
            if ($PSBoundParameters.ContainsKey('rdpcookievalidity')) { $Payload.Add('rdpcookievalidity', $rdpcookievalidity) }
            if ($PSBoundParameters.ContainsKey('addusernameinrdpfile')) { $Payload.Add('addusernameinrdpfile', $addusernameinrdpfile) }
            if ($PSBoundParameters.ContainsKey('rdpfilename')) { $Payload.Add('rdpfilename', $rdpfilename) }
            if ($PSBoundParameters.ContainsKey('rdphost')) { $Payload.Add('rdphost', $rdphost) }
            if ($PSBoundParameters.ContainsKey('rdplistener')) { $Payload.Add('rdplistener', $rdplistener) }
            if ($PSBoundParameters.ContainsKey('rdpcustomparams')) { $Payload.Add('rdpcustomparams', $rdpcustomparams) }
            if ($PSBoundParameters.ContainsKey('psk')) { $Payload.Add('psk', $psk) }
            if ($PSBoundParameters.ContainsKey('randomizerdpfilename')) { $Payload.Add('randomizerdpfilename', $randomizerdpfilename) }
            if ($PSBoundParameters.ContainsKey('rdplinkattribute')) { $Payload.Add('rdplinkattribute', $rdplinkattribute) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Rdp configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type rdpclientprofile -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Delete Rdp configuration Object
    .DESCRIPTION
        Delete Rdp configuration Object
    .PARAMETER name 
       The name of the rdp profile.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteRdpclientprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteRdpclientprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpclientprofile/
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
        Write-Verbose "Invoke-ADCDeleteRdpclientprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Rdp configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type rdpclientprofile -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Rdp configuration object(s)
    .DESCRIPTION
        Get Rdp configuration object(s)
    .PARAMETER name 
       The name of the rdp profile. 
    .PARAMETER GetAll 
        Retreive all rdpclientprofile object(s)
    .PARAMETER Count
        If specified, the count of the rdpclientprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetRdpclientprofile
    .EXAMPLE 
        Invoke-ADCGetRdpclientprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetRdpclientprofile -Count
    .EXAMPLE
        Invoke-ADCGetRdpclientprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetRdpclientprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetRdpclientprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpclientprofile/
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
        Write-Verbose "Invoke-ADCGetRdpclientprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all rdpclientprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpclientprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rdpclientprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpclientprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rdpclientprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpclientprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rdpclientprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpclientprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rdpclientprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpclientprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Kill Rdp configuration Object
    .DESCRIPTION
        Kill Rdp configuration Object 
    .PARAMETER username 
        User name for which to display connections. 
    .PARAMETER all 
        Terminate all active rdpconnections.
    .EXAMPLE
        Invoke-ADCKillRdpconnections 
    .NOTES
        File Name : Invoke-ADCKillRdpconnections
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpconnections/
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
        [string]$username ,

        [boolean]$all 

    )
    begin {
        Write-Verbose "Invoke-ADCKillRdpconnections: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('username')) { $Payload.Add('username', $username) }
            if ($PSBoundParameters.ContainsKey('all')) { $Payload.Add('all', $all) }
            if ($PSCmdlet.ShouldProcess($Name, "Kill Rdp configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type rdpconnections -Action kill -Payload $Payload -GetWarning
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
        Get Rdp configuration object(s)
    .DESCRIPTION
        Get Rdp configuration object(s)
    .PARAMETER username 
       User name for which to display connections. 
    .PARAMETER GetAll 
        Retreive all rdpconnections object(s)
    .PARAMETER Count
        If specified, the count of the rdpconnections object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetRdpconnections
    .EXAMPLE 
        Invoke-ADCGetRdpconnections -GetAll 
    .EXAMPLE 
        Invoke-ADCGetRdpconnections -Count
    .EXAMPLE
        Invoke-ADCGetRdpconnections -name <string>
    .EXAMPLE
        Invoke-ADCGetRdpconnections -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetRdpconnections
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpconnections/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$username,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all rdpconnections objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpconnections -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rdpconnections objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpconnections -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rdpconnections objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('username')) { $Arguments.Add('username', $username) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpconnections -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rdpconnections configuration for property ''"

            } else {
                Write-Verbose "Retrieving rdpconnections configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpconnections -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Rdp configuration Object
    .DESCRIPTION
        Add Rdp configuration Object 
    .PARAMETER name 
        The name of the rdp server profile.  
        Minimum length = 1  
        Maximum length = 32 
    .PARAMETER rdpip 
        IPv4 or IPv6 address of RDP listener. This terminates client RDP connections.  
        Minimum length = 1 
    .PARAMETER rdpport 
        TCP port on which the RDP connection is established.  
        Default value: 3389  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER psk 
        Pre shared key value. 
    .PARAMETER rdpredirection 
        Enable/Disable RDP redirection support. This needs to be enabled in presence of connection broker or session directory with IP cookie(msts cookie) based redirection support.  
        Default value: DISABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER PassThru 
        Return details about the created rdpserverprofile item.
    .EXAMPLE
        Invoke-ADCAddRdpserverprofile -name <string> -psk <string>
    .NOTES
        File Name : Invoke-ADCAddRdpserverprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpserverprofile/
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
        [ValidateLength(1, 32)]
        [string]$name ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$rdpip ,

        [ValidateRange(1, 65535)]
        [double]$rdpport = '3389' ,

        [Parameter(Mandatory = $true)]
        [string]$psk ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$rdpredirection = 'DISABLE' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddRdpserverprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                psk = $psk
            }
            if ($PSBoundParameters.ContainsKey('rdpip')) { $Payload.Add('rdpip', $rdpip) }
            if ($PSBoundParameters.ContainsKey('rdpport')) { $Payload.Add('rdpport', $rdpport) }
            if ($PSBoundParameters.ContainsKey('rdpredirection')) { $Payload.Add('rdpredirection', $rdpredirection) }
 
            if ($PSCmdlet.ShouldProcess("rdpserverprofile", "Add Rdp configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type rdpserverprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetRdpserverprofile -Filter $Payload)
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
        Update Rdp configuration Object
    .DESCRIPTION
        Update Rdp configuration Object 
    .PARAMETER name 
        The name of the rdp server profile.  
        Minimum length = 1  
        Maximum length = 32 
    .PARAMETER rdpip 
        IPv4 or IPv6 address of RDP listener. This terminates client RDP connections.  
        Minimum length = 1 
    .PARAMETER rdpport 
        TCP port on which the RDP connection is established.  
        Default value: 3389  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER psk 
        Pre shared key value. 
    .PARAMETER rdpredirection 
        Enable/Disable RDP redirection support. This needs to be enabled in presence of connection broker or session directory with IP cookie(msts cookie) based redirection support.  
        Default value: DISABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER PassThru 
        Return details about the created rdpserverprofile item.
    .EXAMPLE
        Invoke-ADCUpdateRdpserverprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateRdpserverprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpserverprofile/
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
        [ValidateLength(1, 32)]
        [string]$name ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$rdpip ,

        [ValidateRange(1, 65535)]
        [double]$rdpport ,

        [string]$psk ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$rdpredirection ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateRdpserverprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rdpip')) { $Payload.Add('rdpip', $rdpip) }
            if ($PSBoundParameters.ContainsKey('rdpport')) { $Payload.Add('rdpport', $rdpport) }
            if ($PSBoundParameters.ContainsKey('psk')) { $Payload.Add('psk', $psk) }
            if ($PSBoundParameters.ContainsKey('rdpredirection')) { $Payload.Add('rdpredirection', $rdpredirection) }
 
            if ($PSCmdlet.ShouldProcess("rdpserverprofile", "Update Rdp configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type rdpserverprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetRdpserverprofile -Filter $Payload)
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
        Unset Rdp configuration Object
    .DESCRIPTION
        Unset Rdp configuration Object 
   .PARAMETER name 
       The name of the rdp server profile. 
   .PARAMETER rdpip 
       IPv4 or IPv6 address of RDP listener. This terminates client RDP connections. 
   .PARAMETER rdpport 
       TCP port on which the RDP connection is established. 
   .PARAMETER psk 
       Pre shared key value. 
   .PARAMETER rdpredirection 
       Enable/Disable RDP redirection support. This needs to be enabled in presence of connection broker or session directory with IP cookie(msts cookie) based redirection support.  
       Possible values = ENABLE, DISABLE
    .EXAMPLE
        Invoke-ADCUnsetRdpserverprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetRdpserverprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpserverprofile
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
        [ValidateLength(1, 32)]
        [string]$name ,

        [Boolean]$rdpip ,

        [Boolean]$rdpport ,

        [Boolean]$psk ,

        [Boolean]$rdpredirection 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetRdpserverprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rdpip')) { $Payload.Add('rdpip', $rdpip) }
            if ($PSBoundParameters.ContainsKey('rdpport')) { $Payload.Add('rdpport', $rdpport) }
            if ($PSBoundParameters.ContainsKey('psk')) { $Payload.Add('psk', $psk) }
            if ($PSBoundParameters.ContainsKey('rdpredirection')) { $Payload.Add('rdpredirection', $rdpredirection) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Rdp configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type rdpserverprofile -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Delete Rdp configuration Object
    .DESCRIPTION
        Delete Rdp configuration Object
    .PARAMETER name 
       The name of the rdp server profile.  
       Minimum length = 1  
       Maximum length = 32 
    .EXAMPLE
        Invoke-ADCDeleteRdpserverprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteRdpserverprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpserverprofile/
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
        Write-Verbose "Invoke-ADCDeleteRdpserverprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Rdp configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type rdpserverprofile -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Rdp configuration object(s)
    .DESCRIPTION
        Get Rdp configuration object(s)
    .PARAMETER name 
       The name of the rdp server profile. 
    .PARAMETER GetAll 
        Retreive all rdpserverprofile object(s)
    .PARAMETER Count
        If specified, the count of the rdpserverprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetRdpserverprofile
    .EXAMPLE 
        Invoke-ADCGetRdpserverprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetRdpserverprofile -Count
    .EXAMPLE
        Invoke-ADCGetRdpserverprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetRdpserverprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetRdpserverprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rdp/rdpserverprofile/
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
        [ValidateLength(1, 32)]
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
        Write-Verbose "Invoke-ADCGetRdpserverprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all rdpserverprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpserverprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rdpserverprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpserverprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rdpserverprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpserverprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rdpserverprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpserverprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rdpserverprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rdpserverprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


