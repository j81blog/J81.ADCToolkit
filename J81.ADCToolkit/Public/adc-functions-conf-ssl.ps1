function Invoke-ADCAddSslaction {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER name 
        Name for the SSL action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the action is created. 
    .PARAMETER clientauth 
        Perform client certificate authentication.  
        Possible values = DOCLIENTAUTH, NOCLIENTAUTH 
    .PARAMETER clientcertverification 
        Client certificate verification is mandatory or optional.  
        Default value: Mandatory  
        Possible values = Mandatory, Optional 
    .PARAMETER ssllogprofile 
        The name of the ssllogprofile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER clientcert 
        Insert the entire client certificate into the HTTP header of the request being sent to the web server. The certificate is inserted in ASCII (PEM) format.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER certheader 
        Name of the header into which to insert the client certificate. 
    .PARAMETER clientcertserialnumber 
        Insert the entire client serial number into the HTTP header of the request being sent to the web server.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER certserialheader 
        Name of the header into which to insert the client serial number. 
    .PARAMETER clientcertsubject 
        Insert the client certificate subject, also known as the distinguished name (DN), into the HTTP header of the request being sent to the web server.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER certsubjectheader 
        Name of the header into which to insert the client certificate subject. 
    .PARAMETER clientcerthash 
        Insert the certificate's signature into the HTTP header of the request being sent to the web server. The signature is the value extracted directly from the X.509 certificate signature field. All X.509 certificates contain a signature field.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER certhashheader 
        Name of the header into which to insert the client certificate signature (hash). 
    .PARAMETER clientcertfingerprint 
        Insert the certificate's fingerprint into the HTTP header of the request being sent to the web server. The fingerprint is derived by computing the specified hash value (SHA256, for example) of the DER-encoding of the client certificate.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER certfingerprintheader 
        Name of the header into which to insert the client certificate fingerprint. 
    .PARAMETER certfingerprintdigest 
        Digest algorithm used to compute the fingerprint of the client certificate.  
        Possible values = SHA1, SHA224, SHA256, SHA384, SHA512 
    .PARAMETER clientcertissuer 
        Insert the certificate issuer details into the HTTP header of the request being sent to the web server.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER certissuerheader 
        Name of the header into which to insert the client certificate issuer details. 
    .PARAMETER sessionid 
        Insert the SSL session ID into the HTTP header of the request being sent to the web server. Every SSL connection that the client and the Citrix ADC share has a unique ID that identifies the specific connection.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sessionidheader 
        Name of the header into which to insert the Session ID. 
    .PARAMETER cipher 
        Insert the cipher suite that the client and the Citrix ADC negotiated for the SSL session into the HTTP header of the request being sent to the web server. The appliance inserts the cipher-suite name, SSL protocol, export or non-export string, and cipher strength bit, depending on the type of browser connecting to the SSL virtual server or service (for example, Cipher-Suite: RC4- MD5 SSLv3 Non-Export 128-bit).  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cipherheader 
        Name of the header into which to insert the name of the cipher suite. 
    .PARAMETER clientcertnotbefore 
        Insert the date from which the certificate is valid into the HTTP header of the request being sent to the web server. Every certificate is configured with the date and time from which it is valid.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER certnotbeforeheader 
        Name of the header into which to insert the date and time from which the certificate is valid. 
    .PARAMETER clientcertnotafter 
        Insert the date of expiry of the certificate into the HTTP header of the request being sent to the web server. Every certificate is configured with the date and time at which the certificate expires.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER certnotafterheader 
        Name of the header into which to insert the certificate's expiry date. 
    .PARAMETER owasupport 
        If the appliance is in front of an Outlook Web Access (OWA) server, insert a special header field, FRONT-END-HTTPS: ON, into the HTTP requests going to the OWA server. This header communicates to the server that the transaction is HTTPS and not HTTP.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER forward 
        This action takes an argument a vserver name, to this vserver one will be able to forward all the packets.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER cacertgrpname 
        This action will allow to pick CA(s) from the specific CA group, to verify the client certificate.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER PassThru 
        Return details about the created sslaction item.
    .EXAMPLE
        Invoke-ADCAddSslaction -name <string>
    .NOTES
        File Name : Invoke-ADCAddSslaction
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslaction/
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

        [ValidateSet('DOCLIENTAUTH', 'NOCLIENTAUTH')]
        [string]$clientauth ,

        [ValidateSet('Mandatory', 'Optional')]
        [string]$clientcertverification = 'Mandatory' ,

        [ValidateLength(1, 127)]
        [string]$ssllogprofile ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$clientcert ,

        [string]$certheader ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$clientcertserialnumber ,

        [string]$certserialheader ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$clientcertsubject ,

        [string]$certsubjectheader ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$clientcerthash ,

        [string]$certhashheader ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$clientcertfingerprint ,

        [string]$certfingerprintheader ,

        [ValidateSet('SHA1', 'SHA224', 'SHA256', 'SHA384', 'SHA512')]
        [string]$certfingerprintdigest ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$clientcertissuer ,

        [string]$certissuerheader ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessionid ,

        [string]$sessionidheader ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cipher ,

        [string]$cipherheader ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$clientcertnotbefore ,

        [string]$certnotbeforeheader ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$clientcertnotafter ,

        [string]$certnotafterheader ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$owasupport ,

        [ValidateLength(1, 127)]
        [string]$forward ,

        [ValidateLength(1, 31)]
        [string]$cacertgrpname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('clientauth')) { $Payload.Add('clientauth', $clientauth) }
            if ($PSBoundParameters.ContainsKey('clientcertverification')) { $Payload.Add('clientcertverification', $clientcertverification) }
            if ($PSBoundParameters.ContainsKey('ssllogprofile')) { $Payload.Add('ssllogprofile', $ssllogprofile) }
            if ($PSBoundParameters.ContainsKey('clientcert')) { $Payload.Add('clientcert', $clientcert) }
            if ($PSBoundParameters.ContainsKey('certheader')) { $Payload.Add('certheader', $certheader) }
            if ($PSBoundParameters.ContainsKey('clientcertserialnumber')) { $Payload.Add('clientcertserialnumber', $clientcertserialnumber) }
            if ($PSBoundParameters.ContainsKey('certserialheader')) { $Payload.Add('certserialheader', $certserialheader) }
            if ($PSBoundParameters.ContainsKey('clientcertsubject')) { $Payload.Add('clientcertsubject', $clientcertsubject) }
            if ($PSBoundParameters.ContainsKey('certsubjectheader')) { $Payload.Add('certsubjectheader', $certsubjectheader) }
            if ($PSBoundParameters.ContainsKey('clientcerthash')) { $Payload.Add('clientcerthash', $clientcerthash) }
            if ($PSBoundParameters.ContainsKey('certhashheader')) { $Payload.Add('certhashheader', $certhashheader) }
            if ($PSBoundParameters.ContainsKey('clientcertfingerprint')) { $Payload.Add('clientcertfingerprint', $clientcertfingerprint) }
            if ($PSBoundParameters.ContainsKey('certfingerprintheader')) { $Payload.Add('certfingerprintheader', $certfingerprintheader) }
            if ($PSBoundParameters.ContainsKey('certfingerprintdigest')) { $Payload.Add('certfingerprintdigest', $certfingerprintdigest) }
            if ($PSBoundParameters.ContainsKey('clientcertissuer')) { $Payload.Add('clientcertissuer', $clientcertissuer) }
            if ($PSBoundParameters.ContainsKey('certissuerheader')) { $Payload.Add('certissuerheader', $certissuerheader) }
            if ($PSBoundParameters.ContainsKey('sessionid')) { $Payload.Add('sessionid', $sessionid) }
            if ($PSBoundParameters.ContainsKey('sessionidheader')) { $Payload.Add('sessionidheader', $sessionidheader) }
            if ($PSBoundParameters.ContainsKey('cipher')) { $Payload.Add('cipher', $cipher) }
            if ($PSBoundParameters.ContainsKey('cipherheader')) { $Payload.Add('cipherheader', $cipherheader) }
            if ($PSBoundParameters.ContainsKey('clientcertnotbefore')) { $Payload.Add('clientcertnotbefore', $clientcertnotbefore) }
            if ($PSBoundParameters.ContainsKey('certnotbeforeheader')) { $Payload.Add('certnotbeforeheader', $certnotbeforeheader) }
            if ($PSBoundParameters.ContainsKey('clientcertnotafter')) { $Payload.Add('clientcertnotafter', $clientcertnotafter) }
            if ($PSBoundParameters.ContainsKey('certnotafterheader')) { $Payload.Add('certnotafterheader', $certnotafterheader) }
            if ($PSBoundParameters.ContainsKey('owasupport')) { $Payload.Add('owasupport', $owasupport) }
            if ($PSBoundParameters.ContainsKey('forward')) { $Payload.Add('forward', $forward) }
            if ($PSBoundParameters.ContainsKey('cacertgrpname')) { $Payload.Add('cacertgrpname', $cacertgrpname) }
 
            if ($PSCmdlet.ShouldProcess("sslaction", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslaction -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslaction: Finished"
    }
}

function Invoke-ADCDeleteSslaction {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER name 
       Name for the SSL action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the action is created. 
    .EXAMPLE
        Invoke-ADCDeleteSslaction -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslaction
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslaction/
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
        Write-Verbose "Invoke-ADCDeleteSslaction: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslaction -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslaction: Finished"
    }
}

function Invoke-ADCGetSslaction {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       Name for the SSL action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the action is created. 
    .PARAMETER GetAll 
        Retreive all sslaction object(s)
    .PARAMETER Count
        If specified, the count of the sslaction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslaction
    .EXAMPLE 
        Invoke-ADCGetSslaction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslaction -Count
    .EXAMPLE
        Invoke-ADCGetSslaction -name <string>
    .EXAMPLE
        Invoke-ADCGetSslaction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslaction
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslaction/
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
        Write-Verbose "Invoke-ADCGetSslaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslaction -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslaction -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslaction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslaction -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslaction -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslaction -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslaction: Ended"
    }
}

function Invoke-ADCAddSslcacertgroup {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER cacertgroupname 
        Name given to the CA certificate group. The name will be used to add the CA certificates to the group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created sslcacertgroup item.
    .EXAMPLE
        Invoke-ADCAddSslcacertgroup -cacertgroupname <string>
    .NOTES
        File Name : Invoke-ADCAddSslcacertgroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcacertgroup/
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
        [string]$cacertgroupname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslcacertgroup: Starting"
    }
    process {
        try {
            $Payload = @{
                cacertgroupname = $cacertgroupname
            }

 
            if ($PSCmdlet.ShouldProcess("sslcacertgroup", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcacertgroup -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslcacertgroup -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslcacertgroup: Finished"
    }
}

function Invoke-ADCDeleteSslcacertgroup {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER cacertgroupname 
       Name given to the CA certificate group. The name will be used to add the CA certificates to the group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .EXAMPLE
        Invoke-ADCDeleteSslcacertgroup -cacertgroupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslcacertgroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcacertgroup/
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
        [string]$cacertgroupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslcacertgroup: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$cacertgroupname", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslcacertgroup -Resource $cacertgroupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslcacertgroup: Finished"
    }
}

function Invoke-ADCGetSslcacertgroup {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER cacertgroupname 
       Name given to the CA certificate group. The name will be used to add the CA certificates to the group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retreive all sslcacertgroup object(s)
    .PARAMETER Count
        If specified, the count of the sslcacertgroup object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcacertgroup
    .EXAMPLE 
        Invoke-ADCGetSslcacertgroup -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcacertgroup -Count
    .EXAMPLE
        Invoke-ADCGetSslcacertgroup -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcacertgroup -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcacertgroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcacertgroup/
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
        [string]$cacertgroupname,

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
        Write-Verbose "Invoke-ADCGetSslcacertgroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslcacertgroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcacertgroup -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcacertgroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcacertgroup -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcacertgroup objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcacertgroup -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcacertgroup configuration for property 'cacertgroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcacertgroup -Resource $cacertgroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcacertgroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcacertgroup -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcacertgroup: Ended"
    }
}

function Invoke-ADCGetSslcacertgroupbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER cacertgroupname 
       Name of the CA certificate group for which to show detailed information. 
    .PARAMETER GetAll 
        Retreive all sslcacertgroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslcacertgroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcacertgroupbinding
    .EXAMPLE 
        Invoke-ADCGetSslcacertgroupbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetSslcacertgroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcacertgroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcacertgroupbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcacertgroup_binding/
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
        [string]$cacertgroupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslcacertgroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslcacertgroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcacertgroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcacertgroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcacertgroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcacertgroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcacertgroup_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcacertgroup_binding configuration for property 'cacertgroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcacertgroup_binding -Resource $cacertgroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcacertgroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcacertgroup_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcacertgroupbinding: Ended"
    }
}

function Invoke-ADCAddSslcacertgroupsslcertkeybinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER cacertgroupname 
        Name given to the CA certificate group. The name will be used to add the CA certificates to the group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER certkeyname 
        Name for the certkey added to the Citrix ADC. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the certificate-key pair is created. 
    .PARAMETER crlcheck 
        The state of the CRL check parameter. (Mandatory/Optional).  
        Possible values = Mandatory, Optional 
    .PARAMETER ocspcheck 
        The state of the OCSP check parameter. (Mandatory/Optional).  
        Possible values = Mandatory, Optional 
    .PARAMETER PassThru 
        Return details about the created sslcacertgroup_sslcertkey_binding item.
    .EXAMPLE
        Invoke-ADCAddSslcacertgroupsslcertkeybinding -cacertgroupname <string> -certkeyname <string>
    .NOTES
        File Name : Invoke-ADCAddSslcacertgroupsslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcacertgroup_sslcertkey_binding/
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
        [string]$cacertgroupname ,

        [Parameter(Mandatory = $true)]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 31)]
        [string]$certkeyname ,

        [ValidateSet('Mandatory', 'Optional')]
        [string]$crlcheck ,

        [ValidateSet('Mandatory', 'Optional')]
        [string]$ocspcheck ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslcacertgroupsslcertkeybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                cacertgroupname = $cacertgroupname
                certkeyname = $certkeyname
            }
            if ($PSBoundParameters.ContainsKey('crlcheck')) { $Payload.Add('crlcheck', $crlcheck) }
            if ($PSBoundParameters.ContainsKey('ocspcheck')) { $Payload.Add('ocspcheck', $ocspcheck) }
 
            if ($PSCmdlet.ShouldProcess("sslcacertgroup_sslcertkey_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslcacertgroup_sslcertkey_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslcacertgroupsslcertkeybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslcacertgroupsslcertkeybinding: Finished"
    }
}

function Invoke-ADCDeleteSslcacertgroupsslcertkeybinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER cacertgroupname 
       Name given to the CA certificate group. The name will be used to add the CA certificates to the group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.    .PARAMETER certkeyname 
       Name for the certkey added to the Citrix ADC. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the certificate-key pair is created.
    .EXAMPLE
        Invoke-ADCDeleteSslcacertgroupsslcertkeybinding -cacertgroupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslcacertgroupsslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcacertgroup_sslcertkey_binding/
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
        [string]$cacertgroupname ,

        [string]$certkeyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslcacertgroupsslcertkeybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('certkeyname')) { $Arguments.Add('certkeyname', $certkeyname) }
            if ($PSCmdlet.ShouldProcess("$cacertgroupname", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslcacertgroup_sslcertkey_binding -Resource $cacertgroupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslcacertgroupsslcertkeybinding: Finished"
    }
}

function Invoke-ADCGetSslcacertgroupsslcertkeybinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER cacertgroupname 
       Name given to the CA certificate group. The name will be used to add the CA certificates to the group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retreive all sslcacertgroup_sslcertkey_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslcacertgroup_sslcertkey_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcacertgroupsslcertkeybinding
    .EXAMPLE 
        Invoke-ADCGetSslcacertgroupsslcertkeybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcacertgroupsslcertkeybinding -Count
    .EXAMPLE
        Invoke-ADCGetSslcacertgroupsslcertkeybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcacertgroupsslcertkeybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcacertgroupsslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcacertgroup_sslcertkey_binding/
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
        [string]$cacertgroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslcacertgroupsslcertkeybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslcacertgroup_sslcertkey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcacertgroup_sslcertkey_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcacertgroup_sslcertkey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcacertgroup_sslcertkey_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcacertgroup_sslcertkey_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcacertgroup_sslcertkey_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcacertgroup_sslcertkey_binding configuration for property 'cacertgroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcacertgroup_sslcertkey_binding -Resource $cacertgroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcacertgroup_sslcertkey_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcacertgroup_sslcertkey_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcacertgroupsslcertkeybinding: Ended"
    }
}

function Invoke-ADCCreateSslcert {
<#
    .SYNOPSIS
        Create SSL configuration Object
    .DESCRIPTION
        Create SSL configuration Object 
    .PARAMETER certfile 
        Name for and, optionally, path to the generated certificate file. /nsconfig/ssl/ is the default path. 
    .PARAMETER reqfile 
        Name for and, optionally, path to the certificate-signing request (CSR). /nsconfig/ssl/ is the default path. 
    .PARAMETER certtype 
        Type of certificate to generate. Specify one of the following:  
        * ROOT_CERT - Self-signed Root-CA certificate. You must specify the key file name. The generated Root-CA certificate can be used for signing end-user client or server certificates or to create Intermediate-CA certificates.  
        * INTM_CERT - Intermediate-CA certificate.  
        * CLNT_CERT - End-user client certificate used for client authentication.  
        * SRVR_CERT - SSL server certificate used on SSL servers for end-to-end encryption.  
        Possible values = ROOT_CERT, INTM_CERT, CLNT_CERT, SRVR_CERT 
    .PARAMETER keyfile 
        Name for and, optionally, path to the private key. You can either use an existing RSA or DSA key that you own or create a new private key on the Citrix ADC. This file is required only when creating a self-signed Root-CA certificate. The key file is stored in the /nsconfig/ssl directory by default.  
        If the input key specified is an encrypted key, you are prompted to enter the PEM pass phrase that was used for encrypting the key. 
    .PARAMETER keyform 
        Format in which the key is stored on the appliance.  
        Possible values = DER, PEM 
    .PARAMETER pempassphrase 
        . 
    .PARAMETER days 
        Number of days for which the certificate will be valid, beginning with the time and day (system time) of creation. 
    .PARAMETER subjectaltname 
        Subject Alternative Name (SAN) is an extension to X.509 that allows various values to be associated with a security certificate using a subjectAltName field. These values are called "Subject Alternative Names" (SAN). Names include:  
        1. Email addresses  
        2. IP addresses  
        3. URIs  
        4. DNS names (This is usually also provided as the Common Name RDN within the Subject field of the main certificate.)  
        5. directory names (alternative Distinguished Names to that given in the Subject). 
    .PARAMETER certform 
        Format in which the certificate is stored on the appliance.  
        Possible values = DER, PEM 
    .PARAMETER cacert 
        Name of the CA certificate file that issues and signs the Intermediate-CA certificate or the end-user client and server certificates. 
    .PARAMETER cacertform 
        Format of the CA certificate.  
        Possible values = DER, PEM 
    .PARAMETER cakey 
        Private key, associated with the CA certificate that is used to sign the Intermediate-CA certificate or the end-user client and server certificate. If the CA key file is password protected, the user is prompted to enter the pass phrase that was used to encrypt the key. 
    .PARAMETER cakeyform 
        Format for the CA certificate.  
        Possible values = DER, PEM 
    .PARAMETER caserial 
        Serial number file maintained for the CA certificate. This file contains the serial number of the next certificate to be issued or signed by the CA. If the specified file does not exist, a new file is created, with /nsconfig/ssl/ as the default path. If you do not specify a proper path for the existing serial file, a new serial file is created. This might change the certificate serial numbers assigned by the CA certificate to each of the certificates it signs.
    .EXAMPLE
        Invoke-ADCCreateSslcert -certfile <string> -reqfile <string> -certtype <string>
    .NOTES
        File Name : Invoke-ADCCreateSslcert
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcert/
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
        [string]$certfile ,

        [Parameter(Mandatory = $true)]
        [string]$reqfile ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('ROOT_CERT', 'INTM_CERT', 'CLNT_CERT', 'SRVR_CERT')]
        [string]$certtype ,

        [string]$keyfile ,

        [ValidateSet('DER', 'PEM')]
        [string]$keyform ,

        [ValidateLength(1, 31)]
        [string]$pempassphrase ,

        [ValidateRange(1, 3650)]
        [double]$days ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$subjectaltname ,

        [ValidateSet('DER', 'PEM')]
        [string]$certform ,

        [string]$cacert ,

        [ValidateSet('DER', 'PEM')]
        [string]$cacertform ,

        [string]$cakey ,

        [ValidateSet('DER', 'PEM')]
        [string]$cakeyform ,

        [string]$caserial 

    )
    begin {
        Write-Verbose "Invoke-ADCCreateSslcert: Starting"
    }
    process {
        try {
            $Payload = @{
                certfile = $certfile
                reqfile = $reqfile
                certtype = $certtype
            }
            if ($PSBoundParameters.ContainsKey('keyfile')) { $Payload.Add('keyfile', $keyfile) }
            if ($PSBoundParameters.ContainsKey('keyform')) { $Payload.Add('keyform', $keyform) }
            if ($PSBoundParameters.ContainsKey('pempassphrase')) { $Payload.Add('pempassphrase', $pempassphrase) }
            if ($PSBoundParameters.ContainsKey('days')) { $Payload.Add('days', $days) }
            if ($PSBoundParameters.ContainsKey('subjectaltname')) { $Payload.Add('subjectaltname', $subjectaltname) }
            if ($PSBoundParameters.ContainsKey('certform')) { $Payload.Add('certform', $certform) }
            if ($PSBoundParameters.ContainsKey('cacert')) { $Payload.Add('cacert', $cacert) }
            if ($PSBoundParameters.ContainsKey('cacertform')) { $Payload.Add('cacertform', $cacertform) }
            if ($PSBoundParameters.ContainsKey('cakey')) { $Payload.Add('cakey', $cakey) }
            if ($PSBoundParameters.ContainsKey('cakeyform')) { $Payload.Add('cakeyform', $cakeyform) }
            if ($PSBoundParameters.ContainsKey('caserial')) { $Payload.Add('caserial', $caserial) }
            if ($PSCmdlet.ShouldProcess($Name, "Create SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcert -Action create -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCCreateSslcert: Finished"
    }
}

function Invoke-ADCImportSslcertbundle {
<#
    .SYNOPSIS
        Import SSL configuration Object
    .DESCRIPTION
        Import SSL configuration Object 
    .PARAMETER name 
        Name to assign to the imported certificate bundle. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER src 
        URL specifying the protocol, host, and path, including file name, to the certificate bundle to be imported or exported. For example, http://www.example.com/cert_bundle_file.  
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access.
    .EXAMPLE
        Invoke-ADCImportSslcertbundle -name <string> -src <string>
    .NOTES
        File Name : Invoke-ADCImportSslcertbundle
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertbundle/
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
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 2047)]
        [string]$src 

    )
    begin {
        Write-Verbose "Invoke-ADCImportSslcertbundle: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                src = $src
            }

            if ($PSCmdlet.ShouldProcess($Name, "Import SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcertbundle -Action import -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportSslcertbundle: Finished"
    }
}

function Invoke-ADCDeleteSslcertbundle {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
     .PARAMETER name 
       Name to assign to the imported certificate bundle. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        Invoke-ADCDeleteSslcertbundle 
    .NOTES
        File Name : Invoke-ADCDeleteSslcertbundle
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertbundle/
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

        [string]$name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslcertbundle: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('name')) { $Arguments.Add('name', $name) }
            if ($PSCmdlet.ShouldProcess("sslcertbundle", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslcertbundle -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslcertbundle: Finished"
    }
}

function Invoke-ADCApplySslcertbundle {
<#
    .SYNOPSIS
        Apply SSL configuration Object
    .DESCRIPTION
        Apply SSL configuration Object 
    .PARAMETER name 
        Name to assign to the imported certificate bundle. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        Invoke-ADCApplySslcertbundle -name <string>
    .NOTES
        File Name : Invoke-ADCApplySslcertbundle
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertbundle/
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
        [string]$name 

    )
    begin {
        Write-Verbose "Invoke-ADCApplySslcertbundle: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

            if ($PSCmdlet.ShouldProcess($Name, "Apply SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcertbundle -Action apply -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCApplySslcertbundle: Finished"
    }
}

function Invoke-ADCExportSslcertbundle {
<#
    .SYNOPSIS
        Export SSL configuration Object
    .DESCRIPTION
        Export SSL configuration Object 
    .PARAMETER name 
        Name to assign to the imported certificate bundle. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER src 
        URL specifying the protocol, host, and path, including file name, to the certificate bundle to be imported or exported. For example, http://www.example.com/cert_bundle_file.  
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access.
    .EXAMPLE
        Invoke-ADCExportSslcertbundle -name <string> -src <string>
    .NOTES
        File Name : Invoke-ADCExportSslcertbundle
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertbundle/
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
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 2047)]
        [string]$src 

    )
    begin {
        Write-Verbose "Invoke-ADCExportSslcertbundle: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                src = $src
            }

            if ($PSCmdlet.ShouldProcess($Name, "Export SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcertbundle -Action export -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCExportSslcertbundle: Finished"
    }
}

function Invoke-ADCGetSslcertbundle {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER GetAll 
        Retreive all sslcertbundle object(s)
    .PARAMETER Count
        If specified, the count of the sslcertbundle object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcertbundle
    .EXAMPLE 
        Invoke-ADCGetSslcertbundle -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcertbundle -Count
    .EXAMPLE
        Invoke-ADCGetSslcertbundle -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcertbundle -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcertbundle
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertbundle/
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
        Write-Verbose "Invoke-ADCGetSslcertbundle: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslcertbundle objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertbundle -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcertbundle objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertbundle -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcertbundle objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertbundle -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcertbundle configuration for property ''"

            } else {
                Write-Verbose "Retrieving sslcertbundle configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertbundle -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcertbundle: Ended"
    }
}

function Invoke-ADCGetSslcertchain {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER certkeyname 
       Name of the Certificate. 
    .PARAMETER GetAll 
        Retreive all sslcertchain object(s)
    .PARAMETER Count
        If specified, the count of the sslcertchain object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcertchain
    .EXAMPLE 
        Invoke-ADCGetSslcertchain -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcertchain -Count
    .EXAMPLE
        Invoke-ADCGetSslcertchain -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcertchain -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcertchain
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertchain/
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
        [string]$certkeyname,

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
        Write-Verbose "Invoke-ADCGetSslcertchain: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslcertchain objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertchain -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcertchain objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertchain -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcertchain objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertchain -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcertchain configuration for property 'certkeyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertchain -Resource $certkeyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcertchain configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertchain -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcertchain: Ended"
    }
}

function Invoke-ADCGetSslcertchainbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER certkeyname 
       Name of the Certificate. 
    .PARAMETER GetAll 
        Retreive all sslcertchain_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslcertchain_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcertchainbinding
    .EXAMPLE 
        Invoke-ADCGetSslcertchainbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetSslcertchainbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcertchainbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcertchainbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertchain_binding/
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
        [string]$certkeyname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslcertchainbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslcertchain_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertchain_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcertchain_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertchain_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcertchain_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertchain_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcertchain_binding configuration for property 'certkeyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertchain_binding -Resource $certkeyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcertchain_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertchain_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcertchainbinding: Ended"
    }
}

function Invoke-ADCGetSslcertchainsslcertkeybinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER certkeyname 
       Name of the Certificate. 
    .PARAMETER GetAll 
        Retreive all sslcertchain_sslcertkey_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslcertchain_sslcertkey_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcertchainsslcertkeybinding
    .EXAMPLE 
        Invoke-ADCGetSslcertchainsslcertkeybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcertchainsslcertkeybinding -Count
    .EXAMPLE
        Invoke-ADCGetSslcertchainsslcertkeybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcertchainsslcertkeybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcertchainsslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertchain_sslcertkey_binding/
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
        [string]$certkeyname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslcertchainsslcertkeybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslcertchain_sslcertkey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertchain_sslcertkey_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcertchain_sslcertkey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertchain_sslcertkey_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcertchain_sslcertkey_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertchain_sslcertkey_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcertchain_sslcertkey_binding configuration for property 'certkeyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertchain_sslcertkey_binding -Resource $certkeyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcertchain_sslcertkey_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertchain_sslcertkey_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcertchainsslcertkeybinding: Ended"
    }
}

function Invoke-ADCImportSslcertfile {
<#
    .SYNOPSIS
        Import SSL configuration Object
    .DESCRIPTION
        Import SSL configuration Object 
    .PARAMETER name 
        Name to assign to the imported certificate file. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER src 
        URL specifying the protocol, host, and path, including file name, to the certificate file to be imported. For example, http://www.example.com/cert_file.  
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access.
    .EXAMPLE
        Invoke-ADCImportSslcertfile -name <string> -src <string>
    .NOTES
        File Name : Invoke-ADCImportSslcertfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertfile/
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
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 2047)]
        [string]$src 

    )
    begin {
        Write-Verbose "Invoke-ADCImportSslcertfile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                src = $src
            }

            if ($PSCmdlet.ShouldProcess($Name, "Import SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcertfile -Action import -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportSslcertfile: Finished"
    }
}

function Invoke-ADCDeleteSslcertfile {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
     .PARAMETER name 
       Name to assign to the imported certificate file. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        Invoke-ADCDeleteSslcertfile 
    .NOTES
        File Name : Invoke-ADCDeleteSslcertfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertfile/
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

        [string]$name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslcertfile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('name')) { $Arguments.Add('name', $name) }
            if ($PSCmdlet.ShouldProcess("sslcertfile", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslcertfile -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslcertfile: Finished"
    }
}

function Invoke-ADCGetSslcertfile {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER GetAll 
        Retreive all sslcertfile object(s)
    .PARAMETER Count
        If specified, the count of the sslcertfile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcertfile
    .EXAMPLE 
        Invoke-ADCGetSslcertfile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcertfile -Count
    .EXAMPLE
        Invoke-ADCGetSslcertfile -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcertfile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcertfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertfile/
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
        Write-Verbose "Invoke-ADCGetSslcertfile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslcertfile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertfile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcertfile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertfile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcertfile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertfile -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcertfile configuration for property ''"

            } else {
                Write-Verbose "Retrieving sslcertfile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertfile -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcertfile: Ended"
    }
}

function Invoke-ADCAddSslcertificatechain {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER certkeyname 
        Name of the certificate-key pair. 
    .PARAMETER PassThru 
        Return details about the created sslcertificatechain item.
    .EXAMPLE
        Invoke-ADCAddSslcertificatechain -certkeyname <string>
    .NOTES
        File Name : Invoke-ADCAddSslcertificatechain
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertificatechain/
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
        [string]$certkeyname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslcertificatechain: Starting"
    }
    process {
        try {
            $Payload = @{
                certkeyname = $certkeyname
            }

 
            if ($PSCmdlet.ShouldProcess("sslcertificatechain", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcertificatechain -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslcertificatechain -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslcertificatechain: Finished"
    }
}

function Invoke-ADCGetSslcertificatechain {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER certkeyname 
       Name of the certificate-key pair. 
    .PARAMETER GetAll 
        Retreive all sslcertificatechain object(s)
    .PARAMETER Count
        If specified, the count of the sslcertificatechain object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcertificatechain
    .EXAMPLE 
        Invoke-ADCGetSslcertificatechain -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcertificatechain -Count
    .EXAMPLE
        Invoke-ADCGetSslcertificatechain -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcertificatechain -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcertificatechain
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertificatechain/
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
        [string]$certkeyname,

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
        Write-Verbose "Invoke-ADCGetSslcertificatechain: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslcertificatechain objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertificatechain -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcertificatechain objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertificatechain -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcertificatechain objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertificatechain -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcertificatechain configuration for property 'certkeyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertificatechain -Resource $certkeyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcertificatechain configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertificatechain -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcertificatechain: Ended"
    }
}

function Invoke-ADCAddSslcertkey {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER certkey 
        Name for the certificate and private-key pair. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the certificate-key pair is created. 
    .PARAMETER cert 
        Name of and, optionally, path to the X509 certificate file that is used to form the certificate-key pair. The certificate file should be present on the appliance's hard-disk drive or solid-state drive. Storing a certificate in any location other than the default might cause inconsistency in a high availability setup. /nsconfig/ssl/ is the default path.  
        Minimum length = 1 
    .PARAMETER key 
        Name of and, optionally, path to the private-key file that is used to form the certificate-key pair. The certificate file should be present on the appliance's hard-disk drive or solid-state drive. Storing a certificate in any location other than the default might cause inconsistency in a high availability setup. /nsconfig/ssl/ is the default path.  
        Minimum length = 1 
    .PARAMETER password 
        Passphrase that was used to encrypt the private-key. Use this option to load encrypted private-keys in PEM format. 
    .PARAMETER fipskey 
        Name of the FIPS key that was created inside the Hardware Security Module (HSM) of a FIPS appliance, or a key that was imported into the HSM.  
        Minimum length = 1 
    .PARAMETER hsmkey 
        Name of the HSM key that was created in the External Hardware Security Module (HSM) of a FIPS appliance.  
        Minimum length = 1 
    .PARAMETER inform 
        Input format of the certificate and the private-key files. The three formats supported by the appliance are:  
        PEM - Privacy Enhanced Mail  
        DER - Distinguished Encoding Rule  
        PFX - Personal Information Exchange.  
        Default value: PEM  
        Possible values = DER, PEM, PFX 
    .PARAMETER passplain 
        Pass phrase used to encrypt the private-key. Required when adding an encrypted private-key in PEM format.  
        Minimum length = 1 
    .PARAMETER expirymonitor 
        Issue an alert when the certificate is about to expire.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER notificationperiod 
        Time, in number of days, before certificate expiration, at which to generate an alert that the certificate is about to expire.  
        Minimum value = 10  
        Maximum value = 100 
    .PARAMETER bundle 
        Parse the certificate chain as a single file after linking the server certificate to its issuer's certificate within the file.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER PassThru 
        Return details about the created sslcertkey item.
    .EXAMPLE
        Invoke-ADCAddSslcertkey -certkey <string> -cert <string>
    .NOTES
        File Name : Invoke-ADCAddSslcertkey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey/
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
        [string]$certkey ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cert ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$key ,

        [boolean]$password ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$fipskey ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$hsmkey ,

        [ValidateSet('DER', 'PEM', 'PFX')]
        [string]$inform = 'PEM' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$passplain ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$expirymonitor ,

        [ValidateRange(10, 100)]
        [double]$notificationperiod ,

        [ValidateSet('YES', 'NO')]
        [string]$bundle = 'NO' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslcertkey: Starting"
    }
    process {
        try {
            $Payload = @{
                certkey = $certkey
                cert = $cert
            }
            if ($PSBoundParameters.ContainsKey('key')) { $Payload.Add('key', $key) }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSBoundParameters.ContainsKey('fipskey')) { $Payload.Add('fipskey', $fipskey) }
            if ($PSBoundParameters.ContainsKey('hsmkey')) { $Payload.Add('hsmkey', $hsmkey) }
            if ($PSBoundParameters.ContainsKey('inform')) { $Payload.Add('inform', $inform) }
            if ($PSBoundParameters.ContainsKey('passplain')) { $Payload.Add('passplain', $passplain) }
            if ($PSBoundParameters.ContainsKey('expirymonitor')) { $Payload.Add('expirymonitor', $expirymonitor) }
            if ($PSBoundParameters.ContainsKey('notificationperiod')) { $Payload.Add('notificationperiod', $notificationperiod) }
            if ($PSBoundParameters.ContainsKey('bundle')) { $Payload.Add('bundle', $bundle) }
 
            if ($PSCmdlet.ShouldProcess("sslcertkey", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcertkey -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslcertkey -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslcertkey: Finished"
    }
}

function Invoke-ADCDeleteSslcertkey {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER certkey 
       Name for the certificate and private-key pair. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the certificate-key pair is created.    .PARAMETER deletefromdevice 
       Delete cert/key file from file system.
    .EXAMPLE
        Invoke-ADCDeleteSslcertkey -certkey <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslcertkey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey/
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
        [string]$certkey ,

        [boolean]$deletefromdevice 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslcertkey: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('deletefromdevice')) { $Arguments.Add('deletefromdevice', $deletefromdevice) }
            if ($PSCmdlet.ShouldProcess("$certkey", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslcertkey -Resource $certkey -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslcertkey: Finished"
    }
}

function Invoke-ADCUpdateSslcertkey {
<#
    .SYNOPSIS
        Update SSL configuration Object
    .DESCRIPTION
        Update SSL configuration Object 
    .PARAMETER certkey 
        Name for the certificate and private-key pair. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the certificate-key pair is created. 
    .PARAMETER expirymonitor 
        Issue an alert when the certificate is about to expire.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER notificationperiod 
        Time, in number of days, before certificate expiration, at which to generate an alert that the certificate is about to expire.  
        Minimum value = 10  
        Maximum value = 100 
    .PARAMETER PassThru 
        Return details about the created sslcertkey item.
    .EXAMPLE
        Invoke-ADCUpdateSslcertkey -certkey <string>
    .NOTES
        File Name : Invoke-ADCUpdateSslcertkey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey/
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
        [string]$certkey ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$expirymonitor ,

        [ValidateRange(10, 100)]
        [double]$notificationperiod ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSslcertkey: Starting"
    }
    process {
        try {
            $Payload = @{
                certkey = $certkey
            }
            if ($PSBoundParameters.ContainsKey('expirymonitor')) { $Payload.Add('expirymonitor', $expirymonitor) }
            if ($PSBoundParameters.ContainsKey('notificationperiod')) { $Payload.Add('notificationperiod', $notificationperiod) }
 
            if ($PSCmdlet.ShouldProcess("sslcertkey", "Update SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslcertkey -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslcertkey -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateSslcertkey: Finished"
    }
}

function Invoke-ADCUnsetSslcertkey {
<#
    .SYNOPSIS
        Unset SSL configuration Object
    .DESCRIPTION
        Unset SSL configuration Object 
   .PARAMETER certkey 
       Name for the certificate and private-key pair. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the certificate-key pair is created. 
   .PARAMETER expirymonitor 
       Issue an alert when the certificate is about to expire.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER notificationperiod 
       Time, in number of days, before certificate expiration, at which to generate an alert that the certificate is about to expire.
    .EXAMPLE
        Invoke-ADCUnsetSslcertkey -certkey <string>
    .NOTES
        File Name : Invoke-ADCUnsetSslcertkey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey
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
        [string]$certkey ,

        [Boolean]$expirymonitor ,

        [Boolean]$notificationperiod 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSslcertkey: Starting"
    }
    process {
        try {
            $Payload = @{
                certkey = $certkey
            }
            if ($PSBoundParameters.ContainsKey('expirymonitor')) { $Payload.Add('expirymonitor', $expirymonitor) }
            if ($PSBoundParameters.ContainsKey('notificationperiod')) { $Payload.Add('notificationperiod', $notificationperiod) }
            if ($PSCmdlet.ShouldProcess("$certkey", "Unset SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcertkey -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSslcertkey: Finished"
    }
}

function Invoke-ADCLinkSslcertkey {
<#
    .SYNOPSIS
        Link SSL configuration Object
    .DESCRIPTION
        Link SSL configuration Object 
    .PARAMETER certkey 
        Name for the certificate and private-key pair. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the certificate-key pair is created. 
    .PARAMETER linkcertkeyname 
        Name of the Certificate Authority certificate-key pair to which to link a certificate-key pair.
    .EXAMPLE
        Invoke-ADCLinkSslcertkey -certkey <string> -linkcertkeyname <string>
    .NOTES
        File Name : Invoke-ADCLinkSslcertkey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey/
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
        [string]$certkey ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$linkcertkeyname 

    )
    begin {
        Write-Verbose "Invoke-ADCLinkSslcertkey: Starting"
    }
    process {
        try {
            $Payload = @{
                certkey = $certkey
                linkcertkeyname = $linkcertkeyname
            }

            if ($PSCmdlet.ShouldProcess($Name, "Link SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcertkey -Action link -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCLinkSslcertkey: Finished"
    }
}

function Invoke-ADCUnlinkSslcertkey {
<#
    .SYNOPSIS
        Unlink SSL configuration Object
    .DESCRIPTION
        Unlink SSL configuration Object 
    .PARAMETER certkey 
        Name for the certificate and private-key pair. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the certificate-key pair is created.
    .EXAMPLE
        Invoke-ADCUnlinkSslcertkey -certkey <string>
    .NOTES
        File Name : Invoke-ADCUnlinkSslcertkey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey/
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
        [string]$certkey 

    )
    begin {
        Write-Verbose "Invoke-ADCUnlinkSslcertkey: Starting"
    }
    process {
        try {
            $Payload = @{
                certkey = $certkey
            }

            if ($PSCmdlet.ShouldProcess($Name, "Unlink SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcertkey -Action unlink -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnlinkSslcertkey: Finished"
    }
}

function Invoke-ADCChangeSslcertkey {
<#
    .SYNOPSIS
        Change SSL configuration Object
    .DESCRIPTION
        Change SSL configuration Object 
    .PARAMETER certkey 
        Name for the certificate and private-key pair. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the certificate-key pair is created. 
    .PARAMETER cert 
        Name of and, optionally, path to the X509 certificate file that is used to form the certificate-key pair. The certificate file should be present on the appliance's hard-disk drive or solid-state drive. Storing a certificate in any location other than the default might cause inconsistency in a high availability setup. /nsconfig/ssl/ is the default path.  
        Minimum length = 1 
    .PARAMETER key 
        Name of and, optionally, path to the private-key file that is used to form the certificate-key pair. The certificate file should be present on the appliance's hard-disk drive or solid-state drive. Storing a certificate in any location other than the default might cause inconsistency in a high availability setup. /nsconfig/ssl/ is the default path.  
        Minimum length = 1 
    .PARAMETER password 
        Passphrase that was used to encrypt the private-key. Use this option to load encrypted private-keys in PEM format. 
    .PARAMETER fipskey 
        Name of the FIPS key that was created inside the Hardware Security Module (HSM) of a FIPS appliance, or a key that was imported into the HSM.  
        Minimum length = 1 
    .PARAMETER inform 
        Input format of the certificate and the private-key files. The three formats supported by the appliance are:  
        PEM - Privacy Enhanced Mail  
        DER - Distinguished Encoding Rule  
        PFX - Personal Information Exchange.  
        Default value: PEM  
        Possible values = DER, PEM, PFX 
    .PARAMETER passplain 
        Pass phrase used to encrypt the private-key. Required when adding an encrypted private-key in PEM format.  
        Minimum length = 1 
    .PARAMETER nodomaincheck 
        Override the check for matching domain names during a certificate update operation. 
    .PARAMETER PassThru 
        Return details about the created sslcertkey item.
    .EXAMPLE
        Invoke-ADCChangeSslcertkey -certkey <string>
    .NOTES
        File Name : Invoke-ADCChangeSslcertkey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey/
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
        [string]$certkey ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cert ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$key ,

        [boolean]$password ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$fipskey ,

        [ValidateSet('DER', 'PEM', 'PFX')]
        [string]$inform ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$passplain ,

        [boolean]$nodomaincheck ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCChangeSslcertkey: Starting"
    }
    process {
        try {
            $Payload = @{
                certkey = $certkey
            }
            if ($PSBoundParameters.ContainsKey('cert')) { $Payload.Add('cert', $cert) }
            if ($PSBoundParameters.ContainsKey('key')) { $Payload.Add('key', $key) }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSBoundParameters.ContainsKey('fipskey')) { $Payload.Add('fipskey', $fipskey) }
            if ($PSBoundParameters.ContainsKey('inform')) { $Payload.Add('inform', $inform) }
            if ($PSBoundParameters.ContainsKey('passplain')) { $Payload.Add('passplain', $passplain) }
            if ($PSBoundParameters.ContainsKey('nodomaincheck')) { $Payload.Add('nodomaincheck', $nodomaincheck) }
 
            if ($PSCmdlet.ShouldProcess("sslcertkey", "Change SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcertkey -Action update -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslcertkey -Filter $Payload)
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
        Write-Verbose "Invoke-ADCChangeSslcertkey: Finished"
    }
}

function Invoke-ADCClearSslcertkey {
<#
    .SYNOPSIS
        Clear SSL configuration Object
    .DESCRIPTION
        Clear SSL configuration Object 
    .PARAMETER certkey 
        Name for the certificate and private-key pair. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the certificate-key pair is created. 
    .PARAMETER ocspstaplingcache 
        Clear cached ocspStapling response in certkey.
    .EXAMPLE
        Invoke-ADCClearSslcertkey -certkey <string>
    .NOTES
        File Name : Invoke-ADCClearSslcertkey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey/
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
        [string]$certkey ,

        [boolean]$ocspstaplingcache 

    )
    begin {
        Write-Verbose "Invoke-ADCClearSslcertkey: Starting"
    }
    process {
        try {
            $Payload = @{
                certkey = $certkey
            }
            if ($PSBoundParameters.ContainsKey('ocspstaplingcache')) { $Payload.Add('ocspstaplingcache', $ocspstaplingcache) }
            if ($PSCmdlet.ShouldProcess($Name, "Clear SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcertkey -Action clear -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCClearSslcertkey: Finished"
    }
}

function Invoke-ADCGetSslcertkey {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER certkey 
       Name for the certificate and private-key pair. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the certificate-key pair is created. 
    .PARAMETER GetAll 
        Retreive all sslcertkey object(s)
    .PARAMETER Count
        If specified, the count of the sslcertkey object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcertkey
    .EXAMPLE 
        Invoke-ADCGetSslcertkey -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcertkey -Count
    .EXAMPLE
        Invoke-ADCGetSslcertkey -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcertkey -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcertkey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey/
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
        [string]$certkey,

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
        Write-Verbose "Invoke-ADCGetSslcertkey: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslcertkey objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcertkey objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcertkey objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcertkey configuration for property 'certkey'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey -Resource $certkey -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcertkey configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcertkey: Ended"
    }
}

function Invoke-ADCGetSslcertkeybinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER certkey 
       Name of the certificate-key pair for which to show detailed information. 
    .PARAMETER GetAll 
        Retreive all sslcertkey_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslcertkey_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcertkeybinding
    .EXAMPLE 
        Invoke-ADCGetSslcertkeybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetSslcertkeybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcertkeybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey_binding/
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
        [string]$certkey,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslcertkeybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslcertkey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcertkey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcertkey_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcertkey_binding configuration for property 'certkey'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_binding -Resource $certkey -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcertkey_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcertkeybinding: Ended"
    }
}

function Invoke-ADCGetSslcertkeycrldistributionbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER certkey 
       Name of the certificate-key pair. 
    .PARAMETER GetAll 
        Retreive all sslcertkey_crldistribution_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslcertkey_crldistribution_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcertkeycrldistributionbinding
    .EXAMPLE 
        Invoke-ADCGetSslcertkeycrldistributionbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcertkeycrldistributionbinding -Count
    .EXAMPLE
        Invoke-ADCGetSslcertkeycrldistributionbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcertkeycrldistributionbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcertkeycrldistributionbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey_crldistribution_binding/
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
        [string]$certkey,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslcertkeycrldistributionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslcertkey_crldistribution_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_crldistribution_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcertkey_crldistribution_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_crldistribution_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcertkey_crldistribution_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_crldistribution_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcertkey_crldistribution_binding configuration for property 'certkey'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_crldistribution_binding -Resource $certkey -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcertkey_crldistribution_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_crldistribution_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcertkeycrldistributionbinding: Ended"
    }
}

function Invoke-ADCGetSslcertkeyservicebinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER certkey 
       Name of the certificate-key pair. 
    .PARAMETER GetAll 
        Retreive all sslcertkey_service_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslcertkey_service_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcertkeyservicebinding
    .EXAMPLE 
        Invoke-ADCGetSslcertkeyservicebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcertkeyservicebinding -Count
    .EXAMPLE
        Invoke-ADCGetSslcertkeyservicebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcertkeyservicebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcertkeyservicebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey_service_binding/
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
        [string]$certkey,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslcertkeyservicebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslcertkey_service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_service_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcertkey_service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_service_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcertkey_service_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_service_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcertkey_service_binding configuration for property 'certkey'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_service_binding -Resource $certkey -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcertkey_service_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_service_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcertkeyservicebinding: Ended"
    }
}

function Invoke-ADCAddSslcertkeysslocspresponderbinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER certkey 
        Name of the certificate-key pair.  
        Minimum length = 1 
    .PARAMETER ocspresponder 
        OCSP responders bound to this certkey. 
    .PARAMETER priority 
        ocsp priority. 
    .PARAMETER PassThru 
        Return details about the created sslcertkey_sslocspresponder_binding item.
    .EXAMPLE
        Invoke-ADCAddSslcertkeysslocspresponderbinding 
    .NOTES
        File Name : Invoke-ADCAddSslcertkeysslocspresponderbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey_sslocspresponder_binding/
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
        [string]$certkey ,

        [string]$ocspresponder ,

        [double]$priority ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslcertkeysslocspresponderbinding: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('certkey')) { $Payload.Add('certkey', $certkey) }
            if ($PSBoundParameters.ContainsKey('ocspresponder')) { $Payload.Add('ocspresponder', $ocspresponder) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
 
            if ($PSCmdlet.ShouldProcess("sslcertkey_sslocspresponder_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslcertkey_sslocspresponder_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslcertkeysslocspresponderbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslcertkeysslocspresponderbinding: Finished"
    }
}

function Invoke-ADCDeleteSslcertkeysslocspresponderbinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER certkey 
       Name of the certificate-key pair.  
       Minimum length = 1    .PARAMETER ocspresponder 
       OCSP responders bound to this certkey.    .PARAMETER ca 
       The certificate-key pair being unbound is a Certificate Authority (CA) certificate. If you choose this option, the certificate-key pair is unbound from the list of CA certificates that were bound to the specified SSL virtual server or SSL service.
    .EXAMPLE
        Invoke-ADCDeleteSslcertkeysslocspresponderbinding -certkey <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslcertkeysslocspresponderbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey_sslocspresponder_binding/
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
        [string]$certkey ,

        [string]$ocspresponder ,

        [boolean]$ca 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslcertkeysslocspresponderbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ocspresponder')) { $Arguments.Add('ocspresponder', $ocspresponder) }
            if ($PSBoundParameters.ContainsKey('ca')) { $Arguments.Add('ca', $ca) }
            if ($PSCmdlet.ShouldProcess("$certkey", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslcertkey_sslocspresponder_binding -Resource $certkey -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslcertkeysslocspresponderbinding: Finished"
    }
}

function Invoke-ADCGetSslcertkeysslocspresponderbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER certkey 
       Name of the certificate-key pair. 
    .PARAMETER GetAll 
        Retreive all sslcertkey_sslocspresponder_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslcertkey_sslocspresponder_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcertkeysslocspresponderbinding
    .EXAMPLE 
        Invoke-ADCGetSslcertkeysslocspresponderbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcertkeysslocspresponderbinding -Count
    .EXAMPLE
        Invoke-ADCGetSslcertkeysslocspresponderbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcertkeysslocspresponderbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcertkeysslocspresponderbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey_sslocspresponder_binding/
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
        [string]$certkey,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslcertkeysslocspresponderbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslcertkey_sslocspresponder_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_sslocspresponder_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcertkey_sslocspresponder_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_sslocspresponder_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcertkey_sslocspresponder_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_sslocspresponder_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcertkey_sslocspresponder_binding configuration for property 'certkey'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_sslocspresponder_binding -Resource $certkey -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcertkey_sslocspresponder_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_sslocspresponder_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcertkeysslocspresponderbinding: Ended"
    }
}

function Invoke-ADCGetSslcertkeysslprofilebinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER certkey 
       Name of the certificate-key pair. 
    .PARAMETER GetAll 
        Retreive all sslcertkey_sslprofile_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslcertkey_sslprofile_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcertkeysslprofilebinding
    .EXAMPLE 
        Invoke-ADCGetSslcertkeysslprofilebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcertkeysslprofilebinding -Count
    .EXAMPLE
        Invoke-ADCGetSslcertkeysslprofilebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcertkeysslprofilebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcertkeysslprofilebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey_sslprofile_binding/
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
        [string]$certkey,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslcertkeysslprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslcertkey_sslprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_sslprofile_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcertkey_sslprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_sslprofile_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcertkey_sslprofile_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_sslprofile_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcertkey_sslprofile_binding configuration for property 'certkey'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_sslprofile_binding -Resource $certkey -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcertkey_sslprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_sslprofile_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcertkeysslprofilebinding: Ended"
    }
}

function Invoke-ADCGetSslcertkeysslvserverbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER certkey 
       Name of the certificate-key pair. 
    .PARAMETER GetAll 
        Retreive all sslcertkey_sslvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslcertkey_sslvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcertkeysslvserverbinding
    .EXAMPLE 
        Invoke-ADCGetSslcertkeysslvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcertkeysslvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetSslcertkeysslvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcertkeysslvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcertkeysslvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey_sslvserver_binding/
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
        [string]$certkey,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslcertkeysslvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslcertkey_sslvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_sslvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcertkey_sslvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_sslvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcertkey_sslvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_sslvserver_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcertkey_sslvserver_binding configuration for property 'certkey'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_sslvserver_binding -Resource $certkey -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcertkey_sslvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey_sslvserver_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcertkeysslvserverbinding: Ended"
    }
}

function Invoke-ADCGetSslcertlink {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER GetAll 
        Retreive all sslcertlink object(s)
    .PARAMETER Count
        If specified, the count of the sslcertlink object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcertlink
    .EXAMPLE 
        Invoke-ADCGetSslcertlink -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcertlink -Count
    .EXAMPLE
        Invoke-ADCGetSslcertlink -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcertlink -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcertlink
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertlink/
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
        Write-Verbose "Invoke-ADCGetSslcertlink: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslcertlink objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertlink -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcertlink objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertlink -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcertlink objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertlink -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcertlink configuration for property ''"

            } else {
                Write-Verbose "Retrieving sslcertlink configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertlink -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcertlink: Ended"
    }
}

function Invoke-ADCCreateSslcertreq {
<#
    .SYNOPSIS
        Create SSL configuration Object
    .DESCRIPTION
        Create SSL configuration Object 
    .PARAMETER reqfile 
        Name for and, optionally, path to the certificate signing request (CSR). /nsconfig/ssl/ is the default path. 
    .PARAMETER keyfile 
        Name of and, optionally, path to the private key used to create the certificate signing request, which then becomes part of the certificate-key pair. The private key can be either an RSA or a DSA key. The key must be present in the appliance's local storage. /nsconfig/ssl is the default path. 
    .PARAMETER subjectaltname 
        Subject Alternative Name (SAN) is an extension to X.509 that allows various values to be associated with a security certificate using a subjectAltName field. These values are called "Subject Alternative Names" (SAN). Names include:  
        1. Email addresses  
        2. IP addresses  
        3. URIs  
        4. DNS names (this is usually also provided as the Common Name RDN within the Subject field of the main certificate.)  
        5. Directory names (alternative Distinguished Names to that given in the Subject). 
    .PARAMETER fipskeyname 
        Name of the FIPS key used to create the certificate signing request. FIPS keys are created inside the Hardware Security Module of the FIPS card. 
    .PARAMETER keyform 
        Format in which the key is stored on the appliance.  
        Possible values = DER, PEM 
    .PARAMETER pempassphrase 
        . 
    .PARAMETER countryname 
        Two letter ISO code for your country. For example, US for United States. 
    .PARAMETER statename 
        Full name of the state or province where your organization is located.  
        Do not abbreviate. 
    .PARAMETER organizationname 
        Name of the organization that will use this certificate. The organization name (corporation, limited partnership, university, or government agency) must be registered with some authority at the national, state, or city level. Use the legal name under which the organization is registered.  
        Do not abbreviate the organization name and do not use the following characters in the name:  
        Angle brackets (< >) tilde (~), exclamation mark, at (@), pound (#), zero (0), caret (^), asterisk (*), forward slash (/), square brackets ([ ]), question mark (?). 
    .PARAMETER organizationunitname 
        Name of the division or section in the organization that will use the certificate. 
    .PARAMETER localityname 
        Name of the city or town in which your organization's head office is located. 
    .PARAMETER commonname 
        Fully qualified domain name for the company or web site. The common name must match the name used by DNS servers to do a DNS lookup of your server. Most browsers use this information for authenticating the server's certificate during the SSL handshake. If the server name in the URL does not match the common name as given in the server certificate, the browser terminates the SSL handshake or prompts the user with a warning message.  
        Do not use wildcard characters, such as asterisk (*) or question mark (?), and do not use an IP address as the common name. The common name must not contain the protocol specifier <http://> or <https://>. 
    .PARAMETER emailaddress 
        Contact person's e-mail address. This address is publically displayed as part of the certificate. Provide an e-mail address that is monitored by an administrator who can be contacted about the certificate. 
    .PARAMETER challengepassword 
        Pass phrase, embedded in the certificate signing request that is shared only between the client or server requesting the certificate and the SSL certificate issuer (typically the certificate authority). This pass phrase can be used to authenticate a client or server that is requesting a certificate from the certificate authority. 
    .PARAMETER companyname 
        Additional name for the company or web site. 
    .PARAMETER digestmethod 
        Digest algorithm used in creating CSR.  
        Possible values = SHA1, SHA256
    .EXAMPLE
        Invoke-ADCCreateSslcertreq -reqfile <string> -countryname <string> -statename <string> -organizationname <string>
    .NOTES
        File Name : Invoke-ADCCreateSslcertreq
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertreq/
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
        [string]$reqfile ,

        [string]$keyfile ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$subjectaltname ,

        [ValidateLength(1, 31)]
        [string]$fipskeyname ,

        [ValidateSet('DER', 'PEM')]
        [string]$keyform ,

        [ValidateLength(1, 31)]
        [string]$pempassphrase ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(2, 2)]
        [string]$countryname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$statename ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$organizationname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$organizationunitname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$localityname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$commonname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$emailaddress ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$challengepassword ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$companyname ,

        [ValidateSet('SHA1', 'SHA256')]
        [string]$digestmethod 

    )
    begin {
        Write-Verbose "Invoke-ADCCreateSslcertreq: Starting"
    }
    process {
        try {
            $Payload = @{
                reqfile = $reqfile
                countryname = $countryname
                statename = $statename
                organizationname = $organizationname
            }
            if ($PSBoundParameters.ContainsKey('keyfile')) { $Payload.Add('keyfile', $keyfile) }
            if ($PSBoundParameters.ContainsKey('subjectaltname')) { $Payload.Add('subjectaltname', $subjectaltname) }
            if ($PSBoundParameters.ContainsKey('fipskeyname')) { $Payload.Add('fipskeyname', $fipskeyname) }
            if ($PSBoundParameters.ContainsKey('keyform')) { $Payload.Add('keyform', $keyform) }
            if ($PSBoundParameters.ContainsKey('pempassphrase')) { $Payload.Add('pempassphrase', $pempassphrase) }
            if ($PSBoundParameters.ContainsKey('organizationunitname')) { $Payload.Add('organizationunitname', $organizationunitname) }
            if ($PSBoundParameters.ContainsKey('localityname')) { $Payload.Add('localityname', $localityname) }
            if ($PSBoundParameters.ContainsKey('commonname')) { $Payload.Add('commonname', $commonname) }
            if ($PSBoundParameters.ContainsKey('emailaddress')) { $Payload.Add('emailaddress', $emailaddress) }
            if ($PSBoundParameters.ContainsKey('challengepassword')) { $Payload.Add('challengepassword', $challengepassword) }
            if ($PSBoundParameters.ContainsKey('companyname')) { $Payload.Add('companyname', $companyname) }
            if ($PSBoundParameters.ContainsKey('digestmethod')) { $Payload.Add('digestmethod', $digestmethod) }
            if ($PSCmdlet.ShouldProcess($Name, "Create SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcertreq -Action create -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCCreateSslcertreq: Finished"
    }
}

function Invoke-ADCAddSslcipher {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER ciphergroupname 
        Name for the user-defined cipher group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the cipher group is created. 
    .PARAMETER ciphgrpalias 
        The individual cipher name(s), a user-defined cipher group, or a system predefined cipher alias that will be added to the predefined cipher alias that will be added to the group cipherGroupName.  
        If a cipher alias or a cipher group is specified, all the individual ciphers in the cipher alias or group will be added to the user-defined cipher group.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created sslcipher item.
    .EXAMPLE
        Invoke-ADCAddSslcipher -ciphergroupname <string>
    .NOTES
        File Name : Invoke-ADCAddSslcipher
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcipher/
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
        [string]$ciphergroupname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ciphgrpalias ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslcipher: Starting"
    }
    process {
        try {
            $Payload = @{
                ciphergroupname = $ciphergroupname
            }
            if ($PSBoundParameters.ContainsKey('ciphgrpalias')) { $Payload.Add('ciphgrpalias', $ciphgrpalias) }
 
            if ($PSCmdlet.ShouldProcess("sslcipher", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcipher -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslcipher -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslcipher: Finished"
    }
}

function Invoke-ADCUpdateSslcipher {
<#
    .SYNOPSIS
        Update SSL configuration Object
    .DESCRIPTION
        Update SSL configuration Object 
    .PARAMETER ciphergroupname 
        Name for the user-defined cipher group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the cipher group is created. 
    .PARAMETER ciphername 
        Cipher name. 
    .PARAMETER cipherpriority 
        This indicates priority assigned to the particular cipher.  
        Minimum value = 1 
    .PARAMETER PassThru 
        Return details about the created sslcipher item.
    .EXAMPLE
        Invoke-ADCUpdateSslcipher -ciphergroupname <string>
    .NOTES
        File Name : Invoke-ADCUpdateSslcipher
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcipher/
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
        [string]$ciphergroupname ,

        [string]$ciphername ,

        [double]$cipherpriority ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSslcipher: Starting"
    }
    process {
        try {
            $Payload = @{
                ciphergroupname = $ciphergroupname
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Payload.Add('ciphername', $ciphername) }
            if ($PSBoundParameters.ContainsKey('cipherpriority')) { $Payload.Add('cipherpriority', $cipherpriority) }
 
            if ($PSCmdlet.ShouldProcess("sslcipher", "Update SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslcipher -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslcipher -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateSslcipher: Finished"
    }
}

function Invoke-ADCUnsetSslcipher {
<#
    .SYNOPSIS
        Unset SSL configuration Object
    .DESCRIPTION
        Unset SSL configuration Object 
   .PARAMETER ciphergroupname 
       Name for the user-defined cipher group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the cipher group is created. 
   .PARAMETER ciphername 
       Cipher name. 
   .PARAMETER cipherpriority 
       This indicates priority assigned to the particular cipher.
    .EXAMPLE
        Invoke-ADCUnsetSslcipher -ciphergroupname <string>
    .NOTES
        File Name : Invoke-ADCUnsetSslcipher
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcipher
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
        [string]$ciphergroupname ,

        [Boolean]$ciphername ,

        [Boolean]$cipherpriority 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSslcipher: Starting"
    }
    process {
        try {
            $Payload = @{
                ciphergroupname = $ciphergroupname
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Payload.Add('ciphername', $ciphername) }
            if ($PSBoundParameters.ContainsKey('cipherpriority')) { $Payload.Add('cipherpriority', $cipherpriority) }
            if ($PSCmdlet.ShouldProcess("$ciphergroupname", "Unset SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcipher -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSslcipher: Finished"
    }
}

function Invoke-ADCDeleteSslcipher {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER ciphergroupname 
       Name for the user-defined cipher group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the cipher group is created.    .PARAMETER ciphername 
       Cipher name.
    .EXAMPLE
        Invoke-ADCDeleteSslcipher -ciphergroupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslcipher
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcipher/
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
        [string]$ciphergroupname ,

        [string]$ciphername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslcipher: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Arguments.Add('ciphername', $ciphername) }
            if ($PSCmdlet.ShouldProcess("$ciphergroupname", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslcipher -Resource $ciphergroupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslcipher: Finished"
    }
}

function Invoke-ADCGetSslcipher {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER ciphergroupname 
       Name for the user-defined cipher group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the cipher group is created. 
    .PARAMETER GetAll 
        Retreive all sslcipher object(s)
    .PARAMETER Count
        If specified, the count of the sslcipher object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcipher
    .EXAMPLE 
        Invoke-ADCGetSslcipher -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcipher -Count
    .EXAMPLE
        Invoke-ADCGetSslcipher -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcipher -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcipher
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcipher/
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
        [string]$ciphergroupname,

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
        Write-Verbose "Invoke-ADCGetSslcipher: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslcipher objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcipher objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcipher objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcipher configuration for property 'ciphergroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher -Resource $ciphergroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcipher configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcipher: Ended"
    }
}

function Invoke-ADCGetSslciphersuite {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER ciphername 
       Name of the cipher suite for which to show detailed information. 
    .PARAMETER GetAll 
        Retreive all sslciphersuite object(s)
    .PARAMETER Count
        If specified, the count of the sslciphersuite object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslciphersuite
    .EXAMPLE 
        Invoke-ADCGetSslciphersuite -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslciphersuite -Count
    .EXAMPLE
        Invoke-ADCGetSslciphersuite -name <string>
    .EXAMPLE
        Invoke-ADCGetSslciphersuite -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslciphersuite
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslciphersuite/
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
        [string]$ciphername,

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
        Write-Verbose "Invoke-ADCGetSslciphersuite: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslciphersuite objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslciphersuite -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslciphersuite objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslciphersuite -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslciphersuite objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslciphersuite -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslciphersuite configuration for property 'ciphername'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslciphersuite -Resource $ciphername -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslciphersuite configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslciphersuite -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslciphersuite: Ended"
    }
}

function Invoke-ADCGetSslcipherbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER ciphergroupname 
       Name of the cipher group for which to show detailed information. 
    .PARAMETER GetAll 
        Retreive all sslcipher_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslcipher_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcipherbinding
    .EXAMPLE 
        Invoke-ADCGetSslcipherbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetSslcipherbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcipherbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcipherbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcipher_binding/
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
        [string]$ciphergroupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslcipherbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslcipher_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcipher_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcipher_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcipher_binding configuration for property 'ciphergroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_binding -Resource $ciphergroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcipher_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcipherbinding: Ended"
    }
}

function Invoke-ADCGetSslcipherindividualcipherbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER ciphergroupname 
       Name of the user-defined cipher group. 
    .PARAMETER GetAll 
        Retreive all sslcipher_individualcipher_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslcipher_individualcipher_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcipherindividualcipherbinding
    .EXAMPLE 
        Invoke-ADCGetSslcipherindividualcipherbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcipherindividualcipherbinding -Count
    .EXAMPLE
        Invoke-ADCGetSslcipherindividualcipherbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcipherindividualcipherbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcipherindividualcipherbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcipher_individualcipher_binding/
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
        [string]$ciphergroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslcipherindividualcipherbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslcipher_individualcipher_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_individualcipher_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcipher_individualcipher_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_individualcipher_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcipher_individualcipher_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_individualcipher_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcipher_individualcipher_binding configuration for property 'ciphergroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_individualcipher_binding -Resource $ciphergroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcipher_individualcipher_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_individualcipher_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcipherindividualcipherbinding: Ended"
    }
}

function Invoke-ADCAddSslciphersslciphersuitebinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER ciphergroupname 
        Name for the user-defined cipher group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the cipher group is created. 
    .PARAMETER cipheroperation 
        The operation that is performed when adding the cipher-suite. Possible cipher operations are: ADD - Appends the given cipher-suite to the existing one configured for the virtual server. REM - Removes the given cipher-suite from the existing one configured for the virtual server. ORD - Overrides the current configured cipher-suite for the virtual server with the given cipher-suite.  
        Default value: 0  
        Possible values = ADD, REM, ORD 
    .PARAMETER ciphgrpals 
        A cipher-suite can consist of an individual cipher name, the system predefined cipher-alias name, or user defined cipher-group name.  
        Minimum length = 1 
    .PARAMETER ciphername 
        Cipher name. 
    .PARAMETER cipherpriority 
        This indicates priority assigned to the particular cipher.  
        Minimum value = 1 
    .PARAMETER PassThru 
        Return details about the created sslcipher_sslciphersuite_binding item.
    .EXAMPLE
        Invoke-ADCAddSslciphersslciphersuitebinding 
    .NOTES
        File Name : Invoke-ADCAddSslciphersslciphersuitebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcipher_sslciphersuite_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$ciphergroupname ,

        [ValidateSet('ADD', 'REM', 'ORD')]
        [string]$cipheroperation = '0' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ciphgrpals ,

        [string]$ciphername ,

        [double]$cipherpriority ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslciphersslciphersuitebinding: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('ciphergroupname')) { $Payload.Add('ciphergroupname', $ciphergroupname) }
            if ($PSBoundParameters.ContainsKey('cipheroperation')) { $Payload.Add('cipheroperation', $cipheroperation) }
            if ($PSBoundParameters.ContainsKey('ciphgrpals')) { $Payload.Add('ciphgrpals', $ciphgrpals) }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Payload.Add('ciphername', $ciphername) }
            if ($PSBoundParameters.ContainsKey('cipherpriority')) { $Payload.Add('cipherpriority', $cipherpriority) }
 
            if ($PSCmdlet.ShouldProcess("sslcipher_sslciphersuite_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslcipher_sslciphersuite_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslciphersslciphersuitebinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslciphersslciphersuitebinding: Finished"
    }
}

function Invoke-ADCDeleteSslciphersslciphersuitebinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
     .PARAMETER ciphergroupname 
       Name for the user-defined cipher group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the cipher group is created.    .PARAMETER ciphername 
       Cipher name.
    .EXAMPLE
        Invoke-ADCDeleteSslciphersslciphersuitebinding 
    .NOTES
        File Name : Invoke-ADCDeleteSslciphersslciphersuitebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcipher_sslciphersuite_binding/
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

        [string]$ciphergroupname ,

        [string]$ciphername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslciphersslciphersuitebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ciphergroupname')) { $Arguments.Add('ciphergroupname', $ciphergroupname) }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Arguments.Add('ciphername', $ciphername) }
            if ($PSCmdlet.ShouldProcess("sslcipher_sslciphersuite_binding", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslcipher_sslciphersuite_binding -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslciphersslciphersuitebinding: Finished"
    }
}

function Invoke-ADCGetSslciphersslciphersuitebinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER GetAll 
        Retreive all sslcipher_sslciphersuite_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslcipher_sslciphersuite_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslciphersslciphersuitebinding
    .EXAMPLE 
        Invoke-ADCGetSslciphersslciphersuitebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslciphersslciphersuitebinding -Count
    .EXAMPLE
        Invoke-ADCGetSslciphersslciphersuitebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslciphersslciphersuitebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslciphersslciphersuitebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcipher_sslciphersuite_binding/
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
        Write-Verbose "Invoke-ADCGetSslciphersslciphersuitebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslcipher_sslciphersuite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_sslciphersuite_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcipher_sslciphersuite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_sslciphersuite_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcipher_sslciphersuite_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_sslciphersuite_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcipher_sslciphersuite_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving sslcipher_sslciphersuite_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_sslciphersuite_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslciphersslciphersuitebinding: Ended"
    }
}

function Invoke-ADCGetSslciphersslprofilebinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER ciphergroupname 
       Name of the user-defined cipher group. 
    .PARAMETER GetAll 
        Retreive all sslcipher_sslprofile_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslcipher_sslprofile_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslciphersslprofilebinding
    .EXAMPLE 
        Invoke-ADCGetSslciphersslprofilebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslciphersslprofilebinding -Count
    .EXAMPLE
        Invoke-ADCGetSslciphersslprofilebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslciphersslprofilebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslciphersslprofilebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcipher_sslprofile_binding/
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
        [string]$ciphergroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslciphersslprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslcipher_sslprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_sslprofile_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcipher_sslprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_sslprofile_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcipher_sslprofile_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_sslprofile_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcipher_sslprofile_binding configuration for property 'ciphergroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_sslprofile_binding -Resource $ciphergroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcipher_sslprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcipher_sslprofile_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslciphersslprofilebinding: Ended"
    }
}

function Invoke-ADCAddSslcrl {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER crlname 
        Name for the Certificate Revocation List (CRL). Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the CRL is created. 
    .PARAMETER crlpath 
        Path to the CRL file. /var/netscaler/ssl/ is the default path.  
        Minimum length = 1 
    .PARAMETER inform 
        Input format of the CRL file. The two formats supported on the appliance are:  
        PEM - Privacy Enhanced Mail.  
        DER - Distinguished Encoding Rule.  
        Default value: PEM  
        Possible values = DER, PEM 
    .PARAMETER refresh 
        Set CRL auto refresh.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cacert 
        CA certificate that has issued the CRL. Required if CRL Auto Refresh is selected. Install the CA certificate on the appliance before adding the CRL.  
        Minimum length = 1 
    .PARAMETER method 
        Method for CRL refresh. If LDAP is selected, specify the method, CA certificate, base DN, port, and LDAP server name. If HTTP is selected, specify the CA certificate, method, URL, and port. Cannot be changed after a CRL is added.  
        Possible values = HTTP, LDAP 
    .PARAMETER server 
        IP address of the LDAP server from which to fetch the CRLs.  
        Minimum length = 1 
    .PARAMETER url 
        URL of the CRL distribution point. 
    .PARAMETER port 
        Port for the LDAP server.  
        Minimum value = 1 
    .PARAMETER basedn 
        Base distinguished name (DN), which is used in an LDAP search to search for a CRL. Citrix recommends searching for the Base DN instead of the Issuer Name from the CA certificate, because the Issuer Name field might not exactly match the LDAP directory structure's DN.  
        Minimum length = 1 
    .PARAMETER scope 
        Extent of the search operation on the LDAP server. Available settings function as follows:  
        One - One level below Base DN.  
        Base - Exactly the same level as Base DN.  
        Default value: One  
        Possible values = Base, One 
    .PARAMETER interval 
        CRL refresh interval. Use the NONE setting to unset this parameter.  
        Possible values = MONTHLY, WEEKLY, DAILY, NOW, NONE 
    .PARAMETER day 
        Day on which to refresh the CRL, or, if the Interval parameter is not set, the number of days after which to refresh the CRL. If Interval is set to MONTHLY, specify the date. If Interval is set to WEEKLY, specify the day of the week (for example, Sun=0 and Sat=6). This parameter is not applicable if the Interval is set to DAILY.  
        Minimum value = 0  
        Maximum value = 31 
    .PARAMETER time 
        Time, in hours (1-24) and minutes (1-60), at which to refresh the CRL. 
    .PARAMETER binddn 
        Bind distinguished name (DN) to be used to access the CRL object in the LDAP repository if access to the LDAP repository is restricted or anonymous access is not allowed.  
        Minimum length = 1 
    .PARAMETER password 
        Password to access the CRL in the LDAP repository if access to the LDAP repository is restricted or anonymous access is not allowed.  
        Minimum length = 1 
    .PARAMETER binary 
        Set the LDAP-based CRL retrieval mode to binary.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER PassThru 
        Return details about the created sslcrl item.
    .EXAMPLE
        Invoke-ADCAddSslcrl -crlname <string> -crlpath <string>
    .NOTES
        File Name : Invoke-ADCAddSslcrl
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcrl/
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
        [string]$crlname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$crlpath ,

        [ValidateSet('DER', 'PEM')]
        [string]$inform = 'PEM' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$refresh ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cacert ,

        [ValidateSet('HTTP', 'LDAP')]
        [string]$method ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$server ,

        [string]$url ,

        [int]$port ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$basedn ,

        [ValidateSet('Base', 'One')]
        [string]$scope = 'One' ,

        [ValidateSet('MONTHLY', 'WEEKLY', 'DAILY', 'NOW', 'NONE')]
        [string]$interval ,

        [ValidateRange(0, 31)]
        [double]$day ,

        [string]$time ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$binddn ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password ,

        [ValidateSet('YES', 'NO')]
        [string]$binary = 'NO' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslcrl: Starting"
    }
    process {
        try {
            $Payload = @{
                crlname = $crlname
                crlpath = $crlpath
            }
            if ($PSBoundParameters.ContainsKey('inform')) { $Payload.Add('inform', $inform) }
            if ($PSBoundParameters.ContainsKey('refresh')) { $Payload.Add('refresh', $refresh) }
            if ($PSBoundParameters.ContainsKey('cacert')) { $Payload.Add('cacert', $cacert) }
            if ($PSBoundParameters.ContainsKey('method')) { $Payload.Add('method', $method) }
            if ($PSBoundParameters.ContainsKey('server')) { $Payload.Add('server', $server) }
            if ($PSBoundParameters.ContainsKey('url')) { $Payload.Add('url', $url) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('basedn')) { $Payload.Add('basedn', $basedn) }
            if ($PSBoundParameters.ContainsKey('scope')) { $Payload.Add('scope', $scope) }
            if ($PSBoundParameters.ContainsKey('interval')) { $Payload.Add('interval', $interval) }
            if ($PSBoundParameters.ContainsKey('day')) { $Payload.Add('day', $day) }
            if ($PSBoundParameters.ContainsKey('time')) { $Payload.Add('time', $time) }
            if ($PSBoundParameters.ContainsKey('binddn')) { $Payload.Add('binddn', $binddn) }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSBoundParameters.ContainsKey('binary')) { $Payload.Add('binary', $binary) }
 
            if ($PSCmdlet.ShouldProcess("sslcrl", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcrl -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslcrl -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslcrl: Finished"
    }
}

function Invoke-ADCCreateSslcrl {
<#
    .SYNOPSIS
        Create SSL configuration Object
    .DESCRIPTION
        Create SSL configuration Object 
    .PARAMETER cacertfile 
        Name of and, optionally, path to the CA certificate file.  
        /nsconfig/ssl/ is the default path. 
    .PARAMETER cakeyfile 
        Name of and, optionally, path to the CA key file. /nsconfig/ssl/ is the default path. 
    .PARAMETER indexfile 
        Name of and, optionally, path to the file containing the serial numbers of all the certificates that are revoked. Revoked certificates are appended to the file. /nsconfig/ssl/ is the default path. 
    .PARAMETER revoke 
        Name of and, optionally, path to the certificate to be revoked. /nsconfig/ssl/ is the default path. 
    .PARAMETER gencrl 
        Name of and, optionally, path to the CRL file to be generated. The list of certificates that have been revoked is obtained from the index file. /nsconfig/ssl/ is the default path. 
    .PARAMETER password 
        Password to access the CRL in the LDAP repository if access to the LDAP repository is restricted or anonymous access is not allowed.
    .EXAMPLE
        Invoke-ADCCreateSslcrl -cacertfile <string> -cakeyfile <string> -indexfile <string>
    .NOTES
        File Name : Invoke-ADCCreateSslcrl
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcrl/
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
        [string]$cacertfile ,

        [Parameter(Mandatory = $true)]
        [string]$cakeyfile ,

        [Parameter(Mandatory = $true)]
        [string]$indexfile ,

        [string]$revoke ,

        [string]$gencrl ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password 

    )
    begin {
        Write-Verbose "Invoke-ADCCreateSslcrl: Starting"
    }
    process {
        try {
            $Payload = @{
                cacertfile = $cacertfile
                cakeyfile = $cakeyfile
                indexfile = $indexfile
            }
            if ($PSBoundParameters.ContainsKey('revoke')) { $Payload.Add('revoke', $revoke) }
            if ($PSBoundParameters.ContainsKey('gencrl')) { $Payload.Add('gencrl', $gencrl) }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSCmdlet.ShouldProcess($Name, "Create SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcrl -Action create -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCCreateSslcrl: Finished"
    }
}

function Invoke-ADCDeleteSslcrl {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER crlname 
       Name for the Certificate Revocation List (CRL). Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the CRL is created. 
    .EXAMPLE
        Invoke-ADCDeleteSslcrl -crlname <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslcrl
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcrl/
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
        [string]$crlname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslcrl: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$crlname", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslcrl -Resource $crlname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslcrl: Finished"
    }
}

function Invoke-ADCUpdateSslcrl {
<#
    .SYNOPSIS
        Update SSL configuration Object
    .DESCRIPTION
        Update SSL configuration Object 
    .PARAMETER crlname 
        Name for the Certificate Revocation List (CRL). Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the CRL is created. 
    .PARAMETER refresh 
        Set CRL auto refresh.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cacert 
        CA certificate that has issued the CRL. Required if CRL Auto Refresh is selected. Install the CA certificate on the appliance before adding the CRL.  
        Minimum length = 1 
    .PARAMETER server 
        IP address of the LDAP server from which to fetch the CRLs.  
        Minimum length = 1 
    .PARAMETER method 
        Method for CRL refresh. If LDAP is selected, specify the method, CA certificate, base DN, port, and LDAP server name. If HTTP is selected, specify the CA certificate, method, URL, and port. Cannot be changed after a CRL is added.  
        Possible values = HTTP, LDAP 
    .PARAMETER url 
        URL of the CRL distribution point. 
    .PARAMETER port 
        Port for the LDAP server.  
        Minimum value = 1 
    .PARAMETER basedn 
        Base distinguished name (DN), which is used in an LDAP search to search for a CRL. Citrix recommends searching for the Base DN instead of the Issuer Name from the CA certificate, because the Issuer Name field might not exactly match the LDAP directory structure's DN.  
        Minimum length = 1 
    .PARAMETER scope 
        Extent of the search operation on the LDAP server. Available settings function as follows:  
        One - One level below Base DN.  
        Base - Exactly the same level as Base DN.  
        Default value: One  
        Possible values = Base, One 
    .PARAMETER interval 
        CRL refresh interval. Use the NONE setting to unset this parameter.  
        Possible values = MONTHLY, WEEKLY, DAILY, NOW, NONE 
    .PARAMETER day 
        Day on which to refresh the CRL, or, if the Interval parameter is not set, the number of days after which to refresh the CRL. If Interval is set to MONTHLY, specify the date. If Interval is set to WEEKLY, specify the day of the week (for example, Sun=0 and Sat=6). This parameter is not applicable if the Interval is set to DAILY.  
        Minimum value = 0  
        Maximum value = 31 
    .PARAMETER time 
        Time, in hours (1-24) and minutes (1-60), at which to refresh the CRL. 
    .PARAMETER binddn 
        Bind distinguished name (DN) to be used to access the CRL object in the LDAP repository if access to the LDAP repository is restricted or anonymous access is not allowed.  
        Minimum length = 1 
    .PARAMETER password 
        Password to access the CRL in the LDAP repository if access to the LDAP repository is restricted or anonymous access is not allowed.  
        Minimum length = 1 
    .PARAMETER binary 
        Set the LDAP-based CRL retrieval mode to binary.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER PassThru 
        Return details about the created sslcrl item.
    .EXAMPLE
        Invoke-ADCUpdateSslcrl -crlname <string>
    .NOTES
        File Name : Invoke-ADCUpdateSslcrl
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcrl/
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
        [string]$crlname ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$refresh ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cacert ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$server ,

        [ValidateSet('HTTP', 'LDAP')]
        [string]$method ,

        [string]$url ,

        [int]$port ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$basedn ,

        [ValidateSet('Base', 'One')]
        [string]$scope ,

        [ValidateSet('MONTHLY', 'WEEKLY', 'DAILY', 'NOW', 'NONE')]
        [string]$interval ,

        [ValidateRange(0, 31)]
        [double]$day ,

        [string]$time ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$binddn ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password ,

        [ValidateSet('YES', 'NO')]
        [string]$binary ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSslcrl: Starting"
    }
    process {
        try {
            $Payload = @{
                crlname = $crlname
            }
            if ($PSBoundParameters.ContainsKey('refresh')) { $Payload.Add('refresh', $refresh) }
            if ($PSBoundParameters.ContainsKey('cacert')) { $Payload.Add('cacert', $cacert) }
            if ($PSBoundParameters.ContainsKey('server')) { $Payload.Add('server', $server) }
            if ($PSBoundParameters.ContainsKey('method')) { $Payload.Add('method', $method) }
            if ($PSBoundParameters.ContainsKey('url')) { $Payload.Add('url', $url) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('basedn')) { $Payload.Add('basedn', $basedn) }
            if ($PSBoundParameters.ContainsKey('scope')) { $Payload.Add('scope', $scope) }
            if ($PSBoundParameters.ContainsKey('interval')) { $Payload.Add('interval', $interval) }
            if ($PSBoundParameters.ContainsKey('day')) { $Payload.Add('day', $day) }
            if ($PSBoundParameters.ContainsKey('time')) { $Payload.Add('time', $time) }
            if ($PSBoundParameters.ContainsKey('binddn')) { $Payload.Add('binddn', $binddn) }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSBoundParameters.ContainsKey('binary')) { $Payload.Add('binary', $binary) }
 
            if ($PSCmdlet.ShouldProcess("sslcrl", "Update SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslcrl -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslcrl -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateSslcrl: Finished"
    }
}

function Invoke-ADCUnsetSslcrl {
<#
    .SYNOPSIS
        Unset SSL configuration Object
    .DESCRIPTION
        Unset SSL configuration Object 
   .PARAMETER crlname 
       Name for the Certificate Revocation List (CRL). Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the CRL is created. 
   .PARAMETER refresh 
       Set CRL auto refresh.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER cacert 
       CA certificate that has issued the CRL. Required if CRL Auto Refresh is selected. Install the CA certificate on the appliance before adding the CRL. 
   .PARAMETER server 
       IP address of the LDAP server from which to fetch the CRLs. 
   .PARAMETER method 
       Method for CRL refresh. If LDAP is selected, specify the method, CA certificate, base DN, port, and LDAP server name. If HTTP is selected, specify the CA certificate, method, URL, and port. Cannot be changed after a CRL is added.  
       Possible values = HTTP, LDAP 
   .PARAMETER url 
       URL of the CRL distribution point. 
   .PARAMETER port 
       Port for the LDAP server. 
   .PARAMETER basedn 
       Base distinguished name (DN), which is used in an LDAP search to search for a CRL. Citrix recommends searching for the Base DN instead of the Issuer Name from the CA certificate, because the Issuer Name field might not exactly match the LDAP directory structure's DN. 
   .PARAMETER scope 
       Extent of the search operation on the LDAP server. Available settings function as follows:  
       One - One level below Base DN.  
       Base - Exactly the same level as Base DN.  
       Possible values = Base, One 
   .PARAMETER interval 
       CRL refresh interval. Use the NONE setting to unset this parameter.  
       Possible values = MONTHLY, WEEKLY, DAILY, NOW, NONE 
   .PARAMETER day 
       Day on which to refresh the CRL, or, if the Interval parameter is not set, the number of days after which to refresh the CRL. If Interval is set to MONTHLY, specify the date. If Interval is set to WEEKLY, specify the day of the week (for example, Sun=0 and Sat=6). This parameter is not applicable if the Interval is set to DAILY. 
   .PARAMETER time 
       Time, in hours (1-24) and minutes (1-60), at which to refresh the CRL. 
   .PARAMETER binddn 
       Bind distinguished name (DN) to be used to access the CRL object in the LDAP repository if access to the LDAP repository is restricted or anonymous access is not allowed. 
   .PARAMETER password 
       Password to access the CRL in the LDAP repository if access to the LDAP repository is restricted or anonymous access is not allowed. 
   .PARAMETER binary 
       Set the LDAP-based CRL retrieval mode to binary.  
       Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCUnsetSslcrl -crlname <string>
    .NOTES
        File Name : Invoke-ADCUnsetSslcrl
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcrl
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
        [string]$crlname ,

        [Boolean]$refresh ,

        [Boolean]$cacert ,

        [Boolean]$server ,

        [Boolean]$method ,

        [Boolean]$url ,

        [Boolean]$port ,

        [Boolean]$basedn ,

        [Boolean]$scope ,

        [Boolean]$interval ,

        [Boolean]$day ,

        [Boolean]$time ,

        [Boolean]$binddn ,

        [Boolean]$password ,

        [Boolean]$binary 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSslcrl: Starting"
    }
    process {
        try {
            $Payload = @{
                crlname = $crlname
            }
            if ($PSBoundParameters.ContainsKey('refresh')) { $Payload.Add('refresh', $refresh) }
            if ($PSBoundParameters.ContainsKey('cacert')) { $Payload.Add('cacert', $cacert) }
            if ($PSBoundParameters.ContainsKey('server')) { $Payload.Add('server', $server) }
            if ($PSBoundParameters.ContainsKey('method')) { $Payload.Add('method', $method) }
            if ($PSBoundParameters.ContainsKey('url')) { $Payload.Add('url', $url) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('basedn')) { $Payload.Add('basedn', $basedn) }
            if ($PSBoundParameters.ContainsKey('scope')) { $Payload.Add('scope', $scope) }
            if ($PSBoundParameters.ContainsKey('interval')) { $Payload.Add('interval', $interval) }
            if ($PSBoundParameters.ContainsKey('day')) { $Payload.Add('day', $day) }
            if ($PSBoundParameters.ContainsKey('time')) { $Payload.Add('time', $time) }
            if ($PSBoundParameters.ContainsKey('binddn')) { $Payload.Add('binddn', $binddn) }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSBoundParameters.ContainsKey('binary')) { $Payload.Add('binary', $binary) }
            if ($PSCmdlet.ShouldProcess("$crlname", "Unset SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcrl -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSslcrl: Finished"
    }
}

function Invoke-ADCGetSslcrl {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER crlname 
       Name for the Certificate Revocation List (CRL). Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the CRL is created. 
    .PARAMETER GetAll 
        Retreive all sslcrl object(s)
    .PARAMETER Count
        If specified, the count of the sslcrl object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcrl
    .EXAMPLE 
        Invoke-ADCGetSslcrl -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcrl -Count
    .EXAMPLE
        Invoke-ADCGetSslcrl -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcrl -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcrl
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcrl/
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
        [string]$crlname,

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
        Write-Verbose "Invoke-ADCGetSslcrl: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslcrl objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrl -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcrl objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrl -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcrl objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrl -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcrl configuration for property 'crlname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrl -Resource $crlname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcrl configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrl -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcrl: Ended"
    }
}

function Invoke-ADCImportSslcrlfile {
<#
    .SYNOPSIS
        Import SSL configuration Object
    .DESCRIPTION
        Import SSL configuration Object 
    .PARAMETER name 
        Name to assign to the imported CRL file. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER src 
        URL specifying the protocol, host, and path, including file name to the CRL file to be imported. For example, http://www.example.com/crl_file.  
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access.
    .EXAMPLE
        Invoke-ADCImportSslcrlfile -name <string> -src <string>
    .NOTES
        File Name : Invoke-ADCImportSslcrlfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcrlfile/
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
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 2047)]
        [string]$src 

    )
    begin {
        Write-Verbose "Invoke-ADCImportSslcrlfile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                src = $src
            }

            if ($PSCmdlet.ShouldProcess($Name, "Import SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcrlfile -Action import -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportSslcrlfile: Finished"
    }
}

function Invoke-ADCDeleteSslcrlfile {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
     .PARAMETER name 
       Name to assign to the imported CRL file. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        Invoke-ADCDeleteSslcrlfile 
    .NOTES
        File Name : Invoke-ADCDeleteSslcrlfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcrlfile/
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

        [string]$name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslcrlfile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('name')) { $Arguments.Add('name', $name) }
            if ($PSCmdlet.ShouldProcess("sslcrlfile", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslcrlfile -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslcrlfile: Finished"
    }
}

function Invoke-ADCGetSslcrlfile {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER GetAll 
        Retreive all sslcrlfile object(s)
    .PARAMETER Count
        If specified, the count of the sslcrlfile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcrlfile
    .EXAMPLE 
        Invoke-ADCGetSslcrlfile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcrlfile -Count
    .EXAMPLE
        Invoke-ADCGetSslcrlfile -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcrlfile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcrlfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcrlfile/
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
        Write-Verbose "Invoke-ADCGetSslcrlfile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslcrlfile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrlfile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcrlfile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrlfile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcrlfile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrlfile -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcrlfile configuration for property ''"

            } else {
                Write-Verbose "Retrieving sslcrlfile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrlfile -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcrlfile: Ended"
    }
}

function Invoke-ADCGetSslcrlbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER crlname 
       Name of the CRL for which to show detailed information. 
    .PARAMETER GetAll 
        Retreive all sslcrl_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslcrl_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcrlbinding
    .EXAMPLE 
        Invoke-ADCGetSslcrlbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetSslcrlbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcrlbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcrlbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcrl_binding/
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
        [string]$crlname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslcrlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslcrl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrl_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcrl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrl_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcrl_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrl_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcrl_binding configuration for property 'crlname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrl_binding -Resource $crlname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcrl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrl_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcrlbinding: Ended"
    }
}

function Invoke-ADCGetSslcrlserialnumberbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER crlname 
       Name of the CRL for which to show detailed information. 
    .PARAMETER GetAll 
        Retreive all sslcrl_serialnumber_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslcrl_serialnumber_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslcrlserialnumberbinding
    .EXAMPLE 
        Invoke-ADCGetSslcrlserialnumberbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslcrlserialnumberbinding -Count
    .EXAMPLE
        Invoke-ADCGetSslcrlserialnumberbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslcrlserialnumberbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslcrlserialnumberbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcrl_serialnumber_binding/
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
        [string]$crlname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslcrlserialnumberbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslcrl_serialnumber_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrl_serialnumber_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslcrl_serialnumber_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrl_serialnumber_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslcrl_serialnumber_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrl_serialnumber_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslcrl_serialnumber_binding configuration for property 'crlname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrl_serialnumber_binding -Resource $crlname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslcrl_serialnumber_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcrl_serialnumber_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslcrlserialnumberbinding: Ended"
    }
}

function Invoke-ADCImportSsldhfile {
<#
    .SYNOPSIS
        Import SSL configuration Object
    .DESCRIPTION
        Import SSL configuration Object 
    .PARAMETER name 
        Name to assign to the imported DH file. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER src 
        URL specifying the protocol, host, and path, including file name, to the DH file to be imported. For example, http://www.example.com/dh_file.  
        NOTE: The import fails if the file is on an HTTPS server that requires client certificate authentication for access.
    .EXAMPLE
        Invoke-ADCImportSsldhfile -name <string> -src <string>
    .NOTES
        File Name : Invoke-ADCImportSsldhfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/ssldhfile/
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
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 2047)]
        [string]$src 

    )
    begin {
        Write-Verbose "Invoke-ADCImportSsldhfile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                src = $src
            }

            if ($PSCmdlet.ShouldProcess($Name, "Import SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type ssldhfile -Action import -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportSsldhfile: Finished"
    }
}

function Invoke-ADCDeleteSsldhfile {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
     .PARAMETER name 
       Name to assign to the imported DH file. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        Invoke-ADCDeleteSsldhfile 
    .NOTES
        File Name : Invoke-ADCDeleteSsldhfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/ssldhfile/
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

        [string]$name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSsldhfile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('name')) { $Arguments.Add('name', $name) }
            if ($PSCmdlet.ShouldProcess("ssldhfile", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type ssldhfile -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSsldhfile: Finished"
    }
}

function Invoke-ADCGetSsldhfile {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER GetAll 
        Retreive all ssldhfile object(s)
    .PARAMETER Count
        If specified, the count of the ssldhfile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSsldhfile
    .EXAMPLE 
        Invoke-ADCGetSsldhfile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSsldhfile -Count
    .EXAMPLE
        Invoke-ADCGetSsldhfile -name <string>
    .EXAMPLE
        Invoke-ADCGetSsldhfile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSsldhfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/ssldhfile/
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
        Write-Verbose "Invoke-ADCGetSsldhfile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all ssldhfile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ssldhfile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ssldhfile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ssldhfile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ssldhfile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ssldhfile -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ssldhfile configuration for property ''"

            } else {
                Write-Verbose "Retrieving ssldhfile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ssldhfile -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSsldhfile: Ended"
    }
}

function Invoke-ADCCreateSsldhparam {
<#
    .SYNOPSIS
        Create SSL configuration Object
    .DESCRIPTION
        Create SSL configuration Object 
    .PARAMETER dhfile 
        Name of and, optionally, path to the DH key file. /nsconfig/ssl/ is the default path. 
    .PARAMETER bits 
        Size, in bits, of the DH key being generated. 
    .PARAMETER gen 
        Random number required for generating the DH key. Required as part of the DH key generation algorithm.  
        Possible values = 2, 5
    .EXAMPLE
        Invoke-ADCCreateSsldhparam -dhfile <string>
    .NOTES
        File Name : Invoke-ADCCreateSsldhparam
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/ssldhparam/
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
        [string]$dhfile ,

        [ValidateRange(512, 2048)]
        [double]$bits ,

        [ValidateSet('2', '5')]
        [string]$gen 

    )
    begin {
        Write-Verbose "Invoke-ADCCreateSsldhparam: Starting"
    }
    process {
        try {
            $Payload = @{
                dhfile = $dhfile
            }
            if ($PSBoundParameters.ContainsKey('bits')) { $Payload.Add('bits', $bits) }
            if ($PSBoundParameters.ContainsKey('gen')) { $Payload.Add('gen', $gen) }
            if ($PSCmdlet.ShouldProcess($Name, "Create SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type ssldhparam -Action create -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCCreateSsldhparam: Finished"
    }
}

function Invoke-ADCCreateSsldsakey {
<#
    .SYNOPSIS
        Create SSL configuration Object
    .DESCRIPTION
        Create SSL configuration Object 
    .PARAMETER keyfile 
        Name for and, optionally, path to the DSA key file. /nsconfig/ssl/ is the default path. 
    .PARAMETER bits 
        Size, in bits, of the DSA key. 
    .PARAMETER keyform 
        Format in which the DSA key file is stored on the appliance.  
        Possible values = DER, PEM 
    .PARAMETER des 
        Encrypt the generated DSA key by using the DES algorithm. On the command line, you are prompted to enter the pass phrase (password) that will be used to encrypt the key. 
    .PARAMETER des3 
        Encrypt the generated DSA key by using the Triple-DES algorithm. On the command line, you are prompted to enter the pass phrase (password) that will be used to encrypt the key. 
    .PARAMETER aes256 
        Encrypt the generated DSA key by using the AES algorithm. 
    .PARAMETER password 
        Pass phrase to use for encryption if DES or DES3 option is selected. 
    .PARAMETER pkcs8 
        Create the private key in PKCS#8 format.
    .EXAMPLE
        Invoke-ADCCreateSsldsakey -keyfile <string> -bits <double>
    .NOTES
        File Name : Invoke-ADCCreateSsldsakey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/ssldsakey/
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
        [string]$keyfile ,

        [Parameter(Mandatory = $true)]
        [ValidateRange(512, 2048)]
        [double]$bits ,

        [ValidateSet('DER', 'PEM')]
        [string]$keyform ,

        [boolean]$des ,

        [boolean]$des3 ,

        [boolean]$aes256 ,

        [ValidateLength(1, 31)]
        [string]$password ,

        [boolean]$pkcs8 

    )
    begin {
        Write-Verbose "Invoke-ADCCreateSsldsakey: Starting"
    }
    process {
        try {
            $Payload = @{
                keyfile = $keyfile
                bits = $bits
            }
            if ($PSBoundParameters.ContainsKey('keyform')) { $Payload.Add('keyform', $keyform) }
            if ($PSBoundParameters.ContainsKey('des')) { $Payload.Add('des', $des) }
            if ($PSBoundParameters.ContainsKey('des3')) { $Payload.Add('des3', $des3) }
            if ($PSBoundParameters.ContainsKey('aes256')) { $Payload.Add('aes256', $aes256) }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSBoundParameters.ContainsKey('pkcs8')) { $Payload.Add('pkcs8', $pkcs8) }
            if ($PSCmdlet.ShouldProcess($Name, "Create SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type ssldsakey -Action create -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCCreateSsldsakey: Finished"
    }
}

function Invoke-ADCAddSsldtlsprofile {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER name 
        Name for the DTLS profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@),equals sign (=), and hyphen (-) characters. Cannot be changed after the profile is created.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER pmtudiscovery 
        Source for the maximum record size value. If ENABLED, the value is taken from the PMTU table. If DISABLED, the value is taken from the profile.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER maxrecordsize 
        Maximum size of records that can be sent if PMTU is disabled.  
        Default value: 1459  
        Minimum value = 250  
        Maximum value = 1459 
    .PARAMETER maxretrytime 
        Wait for the specified time, in seconds, before resending the request.  
        Default value: 3 
    .PARAMETER helloverifyrequest 
        Send a Hello Verify request to validate the client.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER terminatesession 
        Terminate the session if the message authentication code (MAC) of the client and server do not match.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER maxpacketsize 
        Maximum number of packets to reassemble. This value helps protect against a fragmented packet attack.  
        Default value: 120  
        Minimum value = 0  
        Maximum value = 86400 
    .PARAMETER PassThru 
        Return details about the created ssldtlsprofile item.
    .EXAMPLE
        Invoke-ADCAddSsldtlsprofile -name <string>
    .NOTES
        File Name : Invoke-ADCAddSsldtlsprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/ssldtlsprofile/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$pmtudiscovery = 'DISABLED' ,

        [ValidateRange(250, 1459)]
        [double]$maxrecordsize = '1459' ,

        [double]$maxretrytime = '3' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$helloverifyrequest = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$terminatesession = 'DISABLED' ,

        [ValidateRange(0, 86400)]
        [double]$maxpacketsize = '120' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSsldtlsprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('pmtudiscovery')) { $Payload.Add('pmtudiscovery', $pmtudiscovery) }
            if ($PSBoundParameters.ContainsKey('maxrecordsize')) { $Payload.Add('maxrecordsize', $maxrecordsize) }
            if ($PSBoundParameters.ContainsKey('maxretrytime')) { $Payload.Add('maxretrytime', $maxretrytime) }
            if ($PSBoundParameters.ContainsKey('helloverifyrequest')) { $Payload.Add('helloverifyrequest', $helloverifyrequest) }
            if ($PSBoundParameters.ContainsKey('terminatesession')) { $Payload.Add('terminatesession', $terminatesession) }
            if ($PSBoundParameters.ContainsKey('maxpacketsize')) { $Payload.Add('maxpacketsize', $maxpacketsize) }
 
            if ($PSCmdlet.ShouldProcess("ssldtlsprofile", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type ssldtlsprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSsldtlsprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSsldtlsprofile: Finished"
    }
}

function Invoke-ADCDeleteSsldtlsprofile {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER name 
       Name for the DTLS profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@),equals sign (=), and hyphen (-) characters. Cannot be changed after the profile is created.  
       Minimum length = 1  
       Maximum length = 127 
    .EXAMPLE
        Invoke-ADCDeleteSsldtlsprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteSsldtlsprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/ssldtlsprofile/
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
        Write-Verbose "Invoke-ADCDeleteSsldtlsprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type ssldtlsprofile -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSsldtlsprofile: Finished"
    }
}

function Invoke-ADCUpdateSsldtlsprofile {
<#
    .SYNOPSIS
        Update SSL configuration Object
    .DESCRIPTION
        Update SSL configuration Object 
    .PARAMETER name 
        Name for the DTLS profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@),equals sign (=), and hyphen (-) characters. Cannot be changed after the profile is created.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER pmtudiscovery 
        Source for the maximum record size value. If ENABLED, the value is taken from the PMTU table. If DISABLED, the value is taken from the profile.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER maxrecordsize 
        Maximum size of records that can be sent if PMTU is disabled.  
        Default value: 1459  
        Minimum value = 250  
        Maximum value = 1459 
    .PARAMETER maxretrytime 
        Wait for the specified time, in seconds, before resending the request.  
        Default value: 3 
    .PARAMETER helloverifyrequest 
        Send a Hello Verify request to validate the client.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER terminatesession 
        Terminate the session if the message authentication code (MAC) of the client and server do not match.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER maxpacketsize 
        Maximum number of packets to reassemble. This value helps protect against a fragmented packet attack.  
        Default value: 120  
        Minimum value = 0  
        Maximum value = 86400 
    .PARAMETER PassThru 
        Return details about the created ssldtlsprofile item.
    .EXAMPLE
        Invoke-ADCUpdateSsldtlsprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateSsldtlsprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/ssldtlsprofile/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$pmtudiscovery ,

        [ValidateRange(250, 1459)]
        [double]$maxrecordsize ,

        [double]$maxretrytime ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$helloverifyrequest ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$terminatesession ,

        [ValidateRange(0, 86400)]
        [double]$maxpacketsize ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSsldtlsprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('pmtudiscovery')) { $Payload.Add('pmtudiscovery', $pmtudiscovery) }
            if ($PSBoundParameters.ContainsKey('maxrecordsize')) { $Payload.Add('maxrecordsize', $maxrecordsize) }
            if ($PSBoundParameters.ContainsKey('maxretrytime')) { $Payload.Add('maxretrytime', $maxretrytime) }
            if ($PSBoundParameters.ContainsKey('helloverifyrequest')) { $Payload.Add('helloverifyrequest', $helloverifyrequest) }
            if ($PSBoundParameters.ContainsKey('terminatesession')) { $Payload.Add('terminatesession', $terminatesession) }
            if ($PSBoundParameters.ContainsKey('maxpacketsize')) { $Payload.Add('maxpacketsize', $maxpacketsize) }
 
            if ($PSCmdlet.ShouldProcess("ssldtlsprofile", "Update SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type ssldtlsprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSsldtlsprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateSsldtlsprofile: Finished"
    }
}

function Invoke-ADCUnsetSsldtlsprofile {
<#
    .SYNOPSIS
        Unset SSL configuration Object
    .DESCRIPTION
        Unset SSL configuration Object 
   .PARAMETER name 
       Name for the DTLS profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@),equals sign (=), and hyphen (-) characters. Cannot be changed after the profile is created. 
   .PARAMETER pmtudiscovery 
       Source for the maximum record size value. If ENABLED, the value is taken from the PMTU table. If DISABLED, the value is taken from the profile.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER maxrecordsize 
       Maximum size of records that can be sent if PMTU is disabled. 
   .PARAMETER maxretrytime 
       Wait for the specified time, in seconds, before resending the request. 
   .PARAMETER helloverifyrequest 
       Send a Hello Verify request to validate the client.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER terminatesession 
       Terminate the session if the message authentication code (MAC) of the client and server do not match.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER maxpacketsize 
       Maximum number of packets to reassemble. This value helps protect against a fragmented packet attack.
    .EXAMPLE
        Invoke-ADCUnsetSsldtlsprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetSsldtlsprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/ssldtlsprofile
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [Boolean]$pmtudiscovery ,

        [Boolean]$maxrecordsize ,

        [Boolean]$maxretrytime ,

        [Boolean]$helloverifyrequest ,

        [Boolean]$terminatesession ,

        [Boolean]$maxpacketsize 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSsldtlsprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('pmtudiscovery')) { $Payload.Add('pmtudiscovery', $pmtudiscovery) }
            if ($PSBoundParameters.ContainsKey('maxrecordsize')) { $Payload.Add('maxrecordsize', $maxrecordsize) }
            if ($PSBoundParameters.ContainsKey('maxretrytime')) { $Payload.Add('maxretrytime', $maxretrytime) }
            if ($PSBoundParameters.ContainsKey('helloverifyrequest')) { $Payload.Add('helloverifyrequest', $helloverifyrequest) }
            if ($PSBoundParameters.ContainsKey('terminatesession')) { $Payload.Add('terminatesession', $terminatesession) }
            if ($PSBoundParameters.ContainsKey('maxpacketsize')) { $Payload.Add('maxpacketsize', $maxpacketsize) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type ssldtlsprofile -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSsldtlsprofile: Finished"
    }
}

function Invoke-ADCGetSsldtlsprofile {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       Name for the DTLS profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@),equals sign (=), and hyphen (-) characters. Cannot be changed after the profile is created. 
    .PARAMETER GetAll 
        Retreive all ssldtlsprofile object(s)
    .PARAMETER Count
        If specified, the count of the ssldtlsprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSsldtlsprofile
    .EXAMPLE 
        Invoke-ADCGetSsldtlsprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSsldtlsprofile -Count
    .EXAMPLE
        Invoke-ADCGetSsldtlsprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetSsldtlsprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSsldtlsprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/ssldtlsprofile/
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
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-ADCGetSsldtlsprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all ssldtlsprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ssldtlsprofile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ssldtlsprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ssldtlsprofile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ssldtlsprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ssldtlsprofile -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ssldtlsprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ssldtlsprofile -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving ssldtlsprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ssldtlsprofile -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSsldtlsprofile: Ended"
    }
}

function Invoke-ADCCreateSslecdsakey {
<#
    .SYNOPSIS
        Create SSL configuration Object
    .DESCRIPTION
        Create SSL configuration Object 
    .PARAMETER keyfile 
        Name for and, optionally, path to the ECDSA key file. /nsconfig/ssl/ is the default path. 
    .PARAMETER curve 
        Curve id to generate ECDSA key. Only P_256 and P_384 are supported.  
        Possible values = P_256, P_384 
    .PARAMETER keyform 
        Format in which the ECDSA key file is stored on the appliance.  
        Possible values = DER, PEM 
    .PARAMETER des 
        Encrypt the generated ECDSA key by using the DES algorithm. On the command line, you are prompted to enter the pass phrase (password) that is used to encrypt the key. 
    .PARAMETER des3 
        Encrypt the generated ECDSA key by using the Triple-DES algorithm. On the command line, you are prompted to enter the pass phrase (password) that is used to encrypt the key. 
    .PARAMETER aes256 
        Encrypt the generated ECDSA key by using the AES algorithm. 
    .PARAMETER password 
        Pass phrase to use for encryption if DES or DES3 option is selected. 
    .PARAMETER pkcs8 
        Create the private key in PKCS#8 format.
    .EXAMPLE
        Invoke-ADCCreateSslecdsakey -keyfile <string> -curve <string>
    .NOTES
        File Name : Invoke-ADCCreateSslecdsakey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslecdsakey/
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
        [string]$keyfile ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('P_256', 'P_384')]
        [string]$curve ,

        [ValidateSet('DER', 'PEM')]
        [string]$keyform ,

        [boolean]$des ,

        [boolean]$des3 ,

        [boolean]$aes256 ,

        [ValidateLength(1, 31)]
        [string]$password ,

        [boolean]$pkcs8 

    )
    begin {
        Write-Verbose "Invoke-ADCCreateSslecdsakey: Starting"
    }
    process {
        try {
            $Payload = @{
                keyfile = $keyfile
                curve = $curve
            }
            if ($PSBoundParameters.ContainsKey('keyform')) { $Payload.Add('keyform', $keyform) }
            if ($PSBoundParameters.ContainsKey('des')) { $Payload.Add('des', $des) }
            if ($PSBoundParameters.ContainsKey('des3')) { $Payload.Add('des3', $des3) }
            if ($PSBoundParameters.ContainsKey('aes256')) { $Payload.Add('aes256', $aes256) }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSBoundParameters.ContainsKey('pkcs8')) { $Payload.Add('pkcs8', $pkcs8) }
            if ($PSCmdlet.ShouldProcess($Name, "Create SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslecdsakey -Action create -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCCreateSslecdsakey: Finished"
    }
}

function Invoke-ADCUpdateSslfips {
<#
    .SYNOPSIS
        Update SSL configuration Object
    .DESCRIPTION
        Update SSL configuration Object 
    .PARAMETER inithsm 
        FIPS initialization level. The appliance currently supports Level-2 (FIPS 140-2).  
        Possible values = Level-2 
    .PARAMETER sopassword 
        Security officer password that will be in effect after you have configured the HSM.  
        Minimum length = 1 
    .PARAMETER oldsopassword 
        Old password for the security officer.  
        Minimum length = 1 
    .PARAMETER userpassword 
        The Hardware Security Module's (HSM) User password.  
        Minimum length = 1 
    .PARAMETER hsmlabel 
        Label to identify the Hardware Security Module (HSM).  
        Minimum length = 1
    .EXAMPLE
        Invoke-ADCUpdateSslfips -inithsm <string> -sopassword <string> -oldsopassword <string> -userpassword <string>
    .NOTES
        File Name : Invoke-ADCUpdateSslfips
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslfips/
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
        [ValidateSet('Level-2')]
        [string]$inithsm ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$sopassword ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$oldsopassword ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$userpassword ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$hsmlabel 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSslfips: Starting"
    }
    process {
        try {
            $Payload = @{
                inithsm = $inithsm
                sopassword = $sopassword
                oldsopassword = $oldsopassword
                userpassword = $userpassword
            }
            if ($PSBoundParameters.ContainsKey('hsmlabel')) { $Payload.Add('hsmlabel', $hsmlabel) }
 
            if ($PSCmdlet.ShouldProcess("sslfips", "Update SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslfips -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateSslfips: Finished"
    }
}

function Invoke-ADCUnsetSslfips {
<#
    .SYNOPSIS
        Unset SSL configuration Object
    .DESCRIPTION
        Unset SSL configuration Object 
   .PARAMETER hsmlabel 
       Label to identify the Hardware Security Module (HSM).
    .EXAMPLE
        Invoke-ADCUnsetSslfips 
    .NOTES
        File Name : Invoke-ADCUnsetSslfips
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslfips
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

        [Boolean]$hsmlabel 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSslfips: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('hsmlabel')) { $Payload.Add('hsmlabel', $hsmlabel) }
            if ($PSCmdlet.ShouldProcess("sslfips", "Unset SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslfips -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSslfips: Finished"
    }
}

function Invoke-ADCResetSslfips {
<#
    .SYNOPSIS
        Reset SSL configuration Object
    .DESCRIPTION
        Reset SSL configuration Object 
    .EXAMPLE
        Invoke-ADCResetSslfips 
    .NOTES
        File Name : Invoke-ADCResetSslfips
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslfips/
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
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession) 

    )
    begin {
        Write-Verbose "Invoke-ADCResetSslfips: Starting"
    }
    process {
        try {
            $Payload = @{

            }

            if ($PSCmdlet.ShouldProcess($Name, "Reset SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslfips -Action reset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCResetSslfips: Finished"
    }
}

function Invoke-ADCChangeSslfips {
<#
    .SYNOPSIS
        Change SSL configuration Object
    .DESCRIPTION
        Change SSL configuration Object 
    .PARAMETER fipsfw 
        Path to the FIPS firmware file.  
        Minimum length = 1
    .EXAMPLE
        Invoke-ADCChangeSslfips -fipsfw <string>
    .NOTES
        File Name : Invoke-ADCChangeSslfips
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslfips/
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
        [string]$fipsfw 

    )
    begin {
        Write-Verbose "Invoke-ADCChangeSslfips: Starting"
    }
    process {
        try {
            $Payload = @{
                fipsfw = $fipsfw
            }

 
            if ($PSCmdlet.ShouldProcess("sslfips", "Change SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslfips -Action update -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCChangeSslfips: Finished"
    }
}

function Invoke-ADCGetSslfips {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER GetAll 
        Retreive all sslfips object(s)
    .PARAMETER Count
        If specified, the count of the sslfips object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslfips
    .EXAMPLE 
        Invoke-ADCGetSslfips -GetAll
    .EXAMPLE
        Invoke-ADCGetSslfips -name <string>
    .EXAMPLE
        Invoke-ADCGetSslfips -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslfips
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslfips/
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
        Write-Verbose "Invoke-ADCGetSslfips: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslfips objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslfips -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslfips objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslfips -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslfips objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslfips -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslfips configuration for property ''"

            } else {
                Write-Verbose "Retrieving sslfips configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslfips -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslfips: Ended"
    }
}

function Invoke-ADCCreateSslfipskey {
<#
    .SYNOPSIS
        Create SSL configuration Object
    .DESCRIPTION
        Create SSL configuration Object 
    .PARAMETER fipskeyname 
        Name for the FIPS key. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the FIPS key is created. 
    .PARAMETER keytype 
        Only RSA key and ECDSA Key are supported.  
        Possible values = RSA, ECDSA 
    .PARAMETER exponent 
        Exponent value for the FIPS key to be created. Available values function as follows:  
        3=3 (hexadecimal)  
        F4=10001 (hexadecimal).  
        Possible values = 3, F4 
    .PARAMETER modulus 
        Modulus, in multiples of 64, of the FIPS key to be created. 
    .PARAMETER curve 
        Only p_256 (prime256v1) and P_384 (secp384r1) are supported.  
        Possible values = P_256, P_384
    .EXAMPLE
        Invoke-ADCCreateSslfipskey -fipskeyname <string> -keytype <string>
    .NOTES
        File Name : Invoke-ADCCreateSslfipskey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslfipskey/
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
        [string]$fipskeyname ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('RSA', 'ECDSA')]
        [string]$keytype ,

        [ValidateSet('3', 'F4')]
        [string]$exponent ,

        [ValidateRange(0, 4096)]
        [double]$modulus ,

        [ValidateSet('P_256', 'P_384')]
        [string]$curve 

    )
    begin {
        Write-Verbose "Invoke-ADCCreateSslfipskey: Starting"
    }
    process {
        try {
            $Payload = @{
                fipskeyname = $fipskeyname
                keytype = $keytype
            }
            if ($PSBoundParameters.ContainsKey('exponent')) { $Payload.Add('exponent', $exponent) }
            if ($PSBoundParameters.ContainsKey('modulus')) { $Payload.Add('modulus', $modulus) }
            if ($PSBoundParameters.ContainsKey('curve')) { $Payload.Add('curve', $curve) }
            if ($PSCmdlet.ShouldProcess($Name, "Create SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslfipskey -Action create -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCCreateSslfipskey: Finished"
    }
}

function Invoke-ADCDeleteSslfipskey {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER fipskeyname 
       Name for the FIPS key. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the FIPS key is created. 
    .EXAMPLE
        Invoke-ADCDeleteSslfipskey -fipskeyname <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslfipskey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslfipskey/
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
        [string]$fipskeyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslfipskey: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$fipskeyname", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslfipskey -Resource $fipskeyname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslfipskey: Finished"
    }
}

function Invoke-ADCImportSslfipskey {
<#
    .SYNOPSIS
        Import SSL configuration Object
    .DESCRIPTION
        Import SSL configuration Object 
    .PARAMETER fipskeyname 
        Name for the FIPS key. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the FIPS key is created. 
    .PARAMETER key 
        Name of and, optionally, path to the key file to be imported.  
        /nsconfig/ssl/ is the default path. 
    .PARAMETER inform 
        Input format of the key file. Available formats are:  
        SIM - Secure Information Management; select when importing a FIPS key. If the external FIPS key is encrypted, first decrypt it, and then import it.  
        PEM - Privacy Enhanced Mail; select when importing a non-FIPS key.  
        Possible values = SIM, DER, PEM 
    .PARAMETER wrapkeyname 
        Name of the wrap key to use for importing the key. Required for importing a non-FIPS key. 
    .PARAMETER iv 
        Initialization Vector (IV) to use for importing the key. Required for importing a non-FIPS key. 
    .PARAMETER exponent 
        Exponent value for the FIPS key to be created. Available values function as follows:  
        3=3 (hexadecimal)  
        F4=10001 (hexadecimal).  
        Possible values = 3, F4
    .EXAMPLE
        Invoke-ADCImportSslfipskey -fipskeyname <string> -key <string>
    .NOTES
        File Name : Invoke-ADCImportSslfipskey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslfipskey/
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
        [string]$fipskeyname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$key ,

        [ValidateSet('SIM', 'DER', 'PEM')]
        [string]$inform ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$wrapkeyname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$iv ,

        [ValidateSet('3', 'F4')]
        [string]$exponent 

    )
    begin {
        Write-Verbose "Invoke-ADCImportSslfipskey: Starting"
    }
    process {
        try {
            $Payload = @{
                fipskeyname = $fipskeyname
                key = $key
            }
            if ($PSBoundParameters.ContainsKey('inform')) { $Payload.Add('inform', $inform) }
            if ($PSBoundParameters.ContainsKey('wrapkeyname')) { $Payload.Add('wrapkeyname', $wrapkeyname) }
            if ($PSBoundParameters.ContainsKey('iv')) { $Payload.Add('iv', $iv) }
            if ($PSBoundParameters.ContainsKey('exponent')) { $Payload.Add('exponent', $exponent) }
            if ($PSCmdlet.ShouldProcess($Name, "Import SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslfipskey -Action import -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportSslfipskey: Finished"
    }
}

function Invoke-ADCExportSslfipskey {
<#
    .SYNOPSIS
        Export SSL configuration Object
    .DESCRIPTION
        Export SSL configuration Object 
    .PARAMETER fipskeyname 
        Name for the FIPS key. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the FIPS key is created. 
    .PARAMETER key 
        Name of and, optionally, path to the key file to be imported.  
        /nsconfig/ssl/ is the default path.
    .EXAMPLE
        Invoke-ADCExportSslfipskey -fipskeyname <string> -key <string>
    .NOTES
        File Name : Invoke-ADCExportSslfipskey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslfipskey/
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
        [string]$fipskeyname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$key 

    )
    begin {
        Write-Verbose "Invoke-ADCExportSslfipskey: Starting"
    }
    process {
        try {
            $Payload = @{
                fipskeyname = $fipskeyname
                key = $key
            }

            if ($PSCmdlet.ShouldProcess($Name, "Export SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslfipskey -Action export -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCExportSslfipskey: Finished"
    }
}

function Invoke-ADCGetSslfipskey {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER fipskeyname 
       Name for the FIPS key. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the FIPS key is created. 
    .PARAMETER GetAll 
        Retreive all sslfipskey object(s)
    .PARAMETER Count
        If specified, the count of the sslfipskey object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslfipskey
    .EXAMPLE 
        Invoke-ADCGetSslfipskey -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslfipskey -Count
    .EXAMPLE
        Invoke-ADCGetSslfipskey -name <string>
    .EXAMPLE
        Invoke-ADCGetSslfipskey -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslfipskey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslfipskey/
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
        [string]$fipskeyname,

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
        Write-Verbose "Invoke-ADCGetSslfipskey: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslfipskey objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslfipskey -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslfipskey objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslfipskey -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslfipskey objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslfipskey -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslfipskey configuration for property 'fipskeyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslfipskey -Resource $fipskeyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslfipskey configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslfipskey -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslfipskey: Ended"
    }
}

function Invoke-ADCEnableSslfipssimsource {
<#
    .SYNOPSIS
        Enable SSL configuration Object
    .DESCRIPTION
        Enable SSL configuration Object 
    .PARAMETER targetsecret 
        Name of and, optionally, path to the target FIPS appliance's secret data. /nsconfig/ssl/ is the default path. 
    .PARAMETER sourcesecret 
        Name for and, optionally, path to the source FIPS appliance's secret data. /nsconfig/ssl/ is the default path.
    .EXAMPLE
        Invoke-ADCEnableSslfipssimsource -targetsecret <string> -sourcesecret <string>
    .NOTES
        File Name : Invoke-ADCEnableSslfipssimsource
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslfipssimsource/
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
        [string]$targetsecret ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$sourcesecret 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableSslfipssimsource: Starting"
    }
    process {
        try {
            $Payload = @{
                targetsecret = $targetsecret
                sourcesecret = $sourcesecret
            }

            if ($PSCmdlet.ShouldProcess($Name, "Enable SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslfipssimsource -Action enable -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCEnableSslfipssimsource: Finished"
    }
}

function Invoke-ADCInitSslfipssimsource {
<#
    .SYNOPSIS
        Init SSL configuration Object
    .DESCRIPTION
        Init SSL configuration Object 
    .PARAMETER certfile 
        Name for and, optionally, path to the source FIPS appliance's certificate file. /nsconfig/ssl/ is the default path.
    .EXAMPLE
        Invoke-ADCInitSslfipssimsource -certfile <string>
    .NOTES
        File Name : Invoke-ADCInitSslfipssimsource
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslfipssimsource/
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
        [string]$certfile 

    )
    begin {
        Write-Verbose "Invoke-ADCInitSslfipssimsource: Starting"
    }
    process {
        try {
            $Payload = @{
                certfile = $certfile
            }

            if ($PSCmdlet.ShouldProcess($Name, "Init SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslfipssimsource -Action init -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCInitSslfipssimsource: Finished"
    }
}

function Invoke-ADCEnableSslfipssimtarget {
<#
    .SYNOPSIS
        Enable SSL configuration Object
    .DESCRIPTION
        Enable SSL configuration Object 
    .PARAMETER keyvector 
        Name of and, optionally, path to the target FIPS appliance's key vector. /nsconfig/ssl/ is the default path. 
    .PARAMETER sourcesecret 
        Name of and, optionally, path to the source FIPS appliance's secret data. /nsconfig/ssl/ is the default path.
    .EXAMPLE
        Invoke-ADCEnableSslfipssimtarget -keyvector <string> -sourcesecret <string>
    .NOTES
        File Name : Invoke-ADCEnableSslfipssimtarget
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslfipssimtarget/
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
        [string]$keyvector ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$sourcesecret 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableSslfipssimtarget: Starting"
    }
    process {
        try {
            $Payload = @{
                keyvector = $keyvector
                sourcesecret = $sourcesecret
            }

            if ($PSCmdlet.ShouldProcess($Name, "Enable SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslfipssimtarget -Action enable -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCEnableSslfipssimtarget: Finished"
    }
}

function Invoke-ADCInitSslfipssimtarget {
<#
    .SYNOPSIS
        Init SSL configuration Object
    .DESCRIPTION
        Init SSL configuration Object 
    .PARAMETER certfile 
        Name of and, optionally, path to the source FIPS appliance's certificate file. /nsconfig/ssl/ is the default path. 
    .PARAMETER keyvector 
        Name of and, optionally, path to the target FIPS appliance's key vector. /nsconfig/ssl/ is the default path. 
    .PARAMETER targetsecret 
        Name for and, optionally, path to the target FIPS appliance's secret data. The default input path for the secret data is /nsconfig/ssl/.
    .EXAMPLE
        Invoke-ADCInitSslfipssimtarget -certfile <string> -keyvector <string> -targetsecret <string>
    .NOTES
        File Name : Invoke-ADCInitSslfipssimtarget
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslfipssimtarget/
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
        [string]$certfile ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$keyvector ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$targetsecret 

    )
    begin {
        Write-Verbose "Invoke-ADCInitSslfipssimtarget: Starting"
    }
    process {
        try {
            $Payload = @{
                certfile = $certfile
                keyvector = $keyvector
                targetsecret = $targetsecret
            }

            if ($PSCmdlet.ShouldProcess($Name, "Init SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslfipssimtarget -Action init -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCInitSslfipssimtarget: Finished"
    }
}

function Invoke-ADCGetSslglobalbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER GetAll 
        Retreive all sslglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslglobalbinding
    .EXAMPLE 
        Invoke-ADCGetSslglobalbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetSslglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslglobalbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslglobal_binding/
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
        Write-Verbose "Invoke-ADCGetSslglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslglobal_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslglobal_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslglobal_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving sslglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslglobal_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslglobalbinding: Ended"
    }
}

function Invoke-ADCAddSslglobalsslpolicybinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER policyname 
        The name for the SSL policy. 
    .PARAMETER priority 
        The priority of the policy binding. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label.  
        Default value: "END" 
    .PARAMETER type 
        Global bind point to which the policy is bound.  
        Possible values = CONTROL_OVERRIDE, CONTROL_DEFAULT, DATA_OVERRIDE, DATA_DEFAULT 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server, service, or policy label. After the invoked policies are evaluated, the flow returns to the policy with the next priority. 
    .PARAMETER labeltype 
        Type of policy label to invoke. Specify virtual server for a policy label associated with a virtual server, or policy label for a user-defined policy label.  
        Possible values = vserver, service, policylabel 
    .PARAMETER labelname 
        Name of the virtual server or user-defined policy label to invoke if the policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created sslglobal_sslpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddSslglobalsslpolicybinding 
    .NOTES
        File Name : Invoke-ADCAddSslglobalsslpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslglobal_sslpolicy_binding/
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

        [string]$policyname ,

        [double]$priority ,

        [string]$gotopriorityexpression = '"END"' ,

        [ValidateSet('CONTROL_OVERRIDE', 'CONTROL_DEFAULT', 'DATA_OVERRIDE', 'DATA_DEFAULT')]
        [string]$type ,

        [boolean]$invoke ,

        [ValidateSet('vserver', 'service', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslglobalsslpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("sslglobal_sslpolicy_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslglobal_sslpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslglobalsslpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslglobalsslpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteSslglobalsslpolicybinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
     .PARAMETER policyname 
       The name for the SSL policy.    .PARAMETER type 
       Global bind point to which the policy is bound.  
       Possible values = CONTROL_OVERRIDE, CONTROL_DEFAULT, DATA_OVERRIDE, DATA_DEFAULT    .PARAMETER priority 
       The priority of the policy binding.
    .EXAMPLE
        Invoke-ADCDeleteSslglobalsslpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteSslglobalsslpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslglobal_sslpolicy_binding/
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

        [string]$policyname ,

        [string]$type ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslglobalsslpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("sslglobal_sslpolicy_binding", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslglobal_sslpolicy_binding -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslglobalsslpolicybinding: Finished"
    }
}

function Invoke-ADCGetSslglobalsslpolicybinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER GetAll 
        Retreive all sslglobal_sslpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslglobal_sslpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslglobalsslpolicybinding
    .EXAMPLE 
        Invoke-ADCGetSslglobalsslpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslglobalsslpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetSslglobalsslpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslglobalsslpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslglobalsslpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslglobal_sslpolicy_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslglobalsslpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslglobal_sslpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslglobal_sslpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslglobal_sslpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslglobal_sslpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslglobal_sslpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslglobal_sslpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslglobal_sslpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving sslglobal_sslpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslglobal_sslpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslglobalsslpolicybinding: Ended"
    }
}

function Invoke-ADCAddSslhsmkey {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER hsmkeyname 
        .  
        Minimum length = 1 
    .PARAMETER hsmtype 
        Type of HSM.  
        Default value: THALES  
        Possible values = THALES, SAFENET, KEYVAULT 
    .PARAMETER key 
        Name of the key. optionally, for Thales, path to the HSM key file; /var/opt/nfast/kmdata/local/ is the default path. Applies when HSMTYPE is THALES or KEYVAULT.  
        Maximum length = 63 
    .PARAMETER serialnum 
        Serial number of the partition on which the key is present. Applies only to SafeNet HSM.  
        Maximum length = 16 
    .PARAMETER password 
        Password for a partition. Applies only to SafeNet HSM.  
        Minimum length = 1 
    .PARAMETER keystore 
        Name of keystore object representing HSM where key is stored. For example, name of keyvault object or azurekeyvault authentication object. Applies only to KEYVAULT type HSM.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created sslhsmkey item.
    .EXAMPLE
        Invoke-ADCAddSslhsmkey -hsmkeyname <string>
    .NOTES
        File Name : Invoke-ADCAddSslhsmkey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslhsmkey/
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
        [string]$hsmkeyname ,

        [ValidateSet('THALES', 'SAFENET', 'KEYVAULT')]
        [string]$hsmtype = 'THALES' ,

        [string]$key ,

        [string]$serialnum ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$keystore ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslhsmkey: Starting"
    }
    process {
        try {
            $Payload = @{
                hsmkeyname = $hsmkeyname
            }
            if ($PSBoundParameters.ContainsKey('hsmtype')) { $Payload.Add('hsmtype', $hsmtype) }
            if ($PSBoundParameters.ContainsKey('key')) { $Payload.Add('key', $key) }
            if ($PSBoundParameters.ContainsKey('serialnum')) { $Payload.Add('serialnum', $serialnum) }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSBoundParameters.ContainsKey('keystore')) { $Payload.Add('keystore', $keystore) }
 
            if ($PSCmdlet.ShouldProcess("sslhsmkey", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslhsmkey -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslhsmkey -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslhsmkey: Finished"
    }
}

function Invoke-ADCDeleteSslhsmkey {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER hsmkeyname 
       .  
       Minimum length = 1    .PARAMETER hsmtype 
       Type of HSM.  
       Default value: THALES  
       Possible values = THALES, SAFENET, KEYVAULT    .PARAMETER serialnum 
       Serial number of the partition on which the key is present. Applies only to SafeNet HSM.  
       Maximum length = 16    .PARAMETER password 
       Password for a partition. Applies only to SafeNet HSM.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteSslhsmkey -hsmkeyname <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslhsmkey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslhsmkey/
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
        [string]$hsmkeyname ,

        [string]$hsmtype ,

        [string]$serialnum ,

        [string]$password 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslhsmkey: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('hsmtype')) { $Arguments.Add('hsmtype', $hsmtype) }
            if ($PSBoundParameters.ContainsKey('serialnum')) { $Arguments.Add('serialnum', $serialnum) }
            if ($PSBoundParameters.ContainsKey('password')) { $Arguments.Add('password', $password) }
            if ($PSCmdlet.ShouldProcess("$hsmkeyname", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslhsmkey -Resource $hsmkeyname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslhsmkey: Finished"
    }
}

function Invoke-ADCGetSslhsmkey {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER hsmkeyname 
       . 
    .PARAMETER GetAll 
        Retreive all sslhsmkey object(s)
    .PARAMETER Count
        If specified, the count of the sslhsmkey object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslhsmkey
    .EXAMPLE 
        Invoke-ADCGetSslhsmkey -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslhsmkey -Count
    .EXAMPLE
        Invoke-ADCGetSslhsmkey -name <string>
    .EXAMPLE
        Invoke-ADCGetSslhsmkey -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslhsmkey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslhsmkey/
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
        [string]$hsmkeyname,

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
        Write-Verbose "Invoke-ADCGetSslhsmkey: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslhsmkey objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslhsmkey -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslhsmkey objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslhsmkey -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslhsmkey objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslhsmkey -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslhsmkey configuration for property 'hsmkeyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslhsmkey -Resource $hsmkeyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslhsmkey configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslhsmkey -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslhsmkey: Ended"
    }
}

function Invoke-ADCImportSslkeyfile {
<#
    .SYNOPSIS
        Import SSL configuration Object
    .DESCRIPTION
        Import SSL configuration Object 
    .PARAMETER name 
        Name to assign to the imported key file. Must begin with an ASCII alphanumeric or underscore(_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@),equals (=), and hyphen (-) characters. 
    .PARAMETER src 
        URL specifying the protocol, host, and path, including file name, to the key file to be imported. For example, http://www.example.com/key_file.  
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER password 
        .
    .EXAMPLE
        Invoke-ADCImportSslkeyfile -name <string> -src <string>
    .NOTES
        File Name : Invoke-ADCImportSslkeyfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslkeyfile/
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
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 2047)]
        [string]$src ,

        [string]$password 

    )
    begin {
        Write-Verbose "Invoke-ADCImportSslkeyfile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                src = $src
            }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSCmdlet.ShouldProcess($Name, "Import SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslkeyfile -Action import -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportSslkeyfile: Finished"
    }
}

function Invoke-ADCDeleteSslkeyfile {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
     .PARAMETER name 
       Name to assign to the imported key file. Must begin with an ASCII alphanumeric or underscore(_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@),equals (=), and hyphen (-) characters.
    .EXAMPLE
        Invoke-ADCDeleteSslkeyfile 
    .NOTES
        File Name : Invoke-ADCDeleteSslkeyfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslkeyfile/
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

        [string]$name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslkeyfile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('name')) { $Arguments.Add('name', $name) }
            if ($PSCmdlet.ShouldProcess("sslkeyfile", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslkeyfile -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslkeyfile: Finished"
    }
}

function Invoke-ADCGetSslkeyfile {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER GetAll 
        Retreive all sslkeyfile object(s)
    .PARAMETER Count
        If specified, the count of the sslkeyfile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslkeyfile
    .EXAMPLE 
        Invoke-ADCGetSslkeyfile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslkeyfile -Count
    .EXAMPLE
        Invoke-ADCGetSslkeyfile -name <string>
    .EXAMPLE
        Invoke-ADCGetSslkeyfile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslkeyfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslkeyfile/
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
        Write-Verbose "Invoke-ADCGetSslkeyfile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslkeyfile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslkeyfile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslkeyfile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslkeyfile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslkeyfile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslkeyfile -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslkeyfile configuration for property ''"

            } else {
                Write-Verbose "Retrieving sslkeyfile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslkeyfile -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslkeyfile: Ended"
    }
}

function Invoke-ADCAddSsllogprofile {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER name 
        The name of the ssllogprofile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER ssllogclauth 
        log all SSL ClAuth events.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ssllogclauthfailures 
        log all SSL ClAuth error events.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sslloghs 
        log all SSL HS events.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sslloghsfailures 
        log all SSL HS error events.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created ssllogprofile item.
    .EXAMPLE
        Invoke-ADCAddSsllogprofile -name <string>
    .NOTES
        File Name : Invoke-ADCAddSsllogprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/ssllogprofile/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ssllogclauth = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ssllogclauthfailures = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslloghs = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslloghsfailures = 'DISABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSsllogprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ssllogclauth')) { $Payload.Add('ssllogclauth', $ssllogclauth) }
            if ($PSBoundParameters.ContainsKey('ssllogclauthfailures')) { $Payload.Add('ssllogclauthfailures', $ssllogclauthfailures) }
            if ($PSBoundParameters.ContainsKey('sslloghs')) { $Payload.Add('sslloghs', $sslloghs) }
            if ($PSBoundParameters.ContainsKey('sslloghsfailures')) { $Payload.Add('sslloghsfailures', $sslloghsfailures) }
 
            if ($PSCmdlet.ShouldProcess("ssllogprofile", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type ssllogprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSsllogprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSsllogprofile: Finished"
    }
}

function Invoke-ADCUpdateSsllogprofile {
<#
    .SYNOPSIS
        Update SSL configuration Object
    .DESCRIPTION
        Update SSL configuration Object 
    .PARAMETER name 
        The name of the ssllogprofile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER ssllogclauth 
        log all SSL ClAuth events.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ssllogclauthfailures 
        log all SSL ClAuth error events.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sslloghs 
        log all SSL HS events.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sslloghsfailures 
        log all SSL HS error events.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created ssllogprofile item.
    .EXAMPLE
        Invoke-ADCUpdateSsllogprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateSsllogprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/ssllogprofile/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ssllogclauth ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ssllogclauthfailures ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslloghs ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslloghsfailures ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSsllogprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ssllogclauth')) { $Payload.Add('ssllogclauth', $ssllogclauth) }
            if ($PSBoundParameters.ContainsKey('ssllogclauthfailures')) { $Payload.Add('ssllogclauthfailures', $ssllogclauthfailures) }
            if ($PSBoundParameters.ContainsKey('sslloghs')) { $Payload.Add('sslloghs', $sslloghs) }
            if ($PSBoundParameters.ContainsKey('sslloghsfailures')) { $Payload.Add('sslloghsfailures', $sslloghsfailures) }
 
            if ($PSCmdlet.ShouldProcess("ssllogprofile", "Update SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type ssllogprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSsllogprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateSsllogprofile: Finished"
    }
}

function Invoke-ADCUnsetSsllogprofile {
<#
    .SYNOPSIS
        Unset SSL configuration Object
    .DESCRIPTION
        Unset SSL configuration Object 
   .PARAMETER name 
       The name of the ssllogprofile. 
   .PARAMETER ssllogclauth 
       log all SSL ClAuth events.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ssllogclauthfailures 
       log all SSL ClAuth error events.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sslloghs 
       log all SSL HS events.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sslloghsfailures 
       log all SSL HS error events.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetSsllogprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetSsllogprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/ssllogprofile
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [Boolean]$ssllogclauth ,

        [Boolean]$ssllogclauthfailures ,

        [Boolean]$sslloghs ,

        [Boolean]$sslloghsfailures 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSsllogprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ssllogclauth')) { $Payload.Add('ssllogclauth', $ssllogclauth) }
            if ($PSBoundParameters.ContainsKey('ssllogclauthfailures')) { $Payload.Add('ssllogclauthfailures', $ssllogclauthfailures) }
            if ($PSBoundParameters.ContainsKey('sslloghs')) { $Payload.Add('sslloghs', $sslloghs) }
            if ($PSBoundParameters.ContainsKey('sslloghsfailures')) { $Payload.Add('sslloghsfailures', $sslloghsfailures) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type ssllogprofile -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSsllogprofile: Finished"
    }
}

function Invoke-ADCDeleteSsllogprofile {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER name 
       The name of the ssllogprofile.  
       Minimum length = 1  
       Maximum length = 127 
    .EXAMPLE
        Invoke-ADCDeleteSsllogprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteSsllogprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/ssllogprofile/
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
        Write-Verbose "Invoke-ADCDeleteSsllogprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type ssllogprofile -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSsllogprofile: Finished"
    }
}

function Invoke-ADCGetSsllogprofile {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       The name of the ssllogprofile. 
    .PARAMETER GetAll 
        Retreive all ssllogprofile object(s)
    .PARAMETER Count
        If specified, the count of the ssllogprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSsllogprofile
    .EXAMPLE 
        Invoke-ADCGetSsllogprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSsllogprofile -Count
    .EXAMPLE
        Invoke-ADCGetSsllogprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetSsllogprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSsllogprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/ssllogprofile/
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
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-ADCGetSsllogprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all ssllogprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ssllogprofile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ssllogprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ssllogprofile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ssllogprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ssllogprofile -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ssllogprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ssllogprofile -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving ssllogprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ssllogprofile -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSsllogprofile: Ended"
    }
}

function Invoke-ADCAddSslocspresponder {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER name 
        Name for the OCSP responder. Cannot begin with a hash (#) or space character and must contain only ASCII alphanumeric, underscore (_), hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the responder is created. 
    .PARAMETER url 
        URL of the OCSP responder.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER cache 
        Enable caching of responses. Caching of responses received from the OCSP responder enables faster responses to the clients and reduces the load on the OCSP responder.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cachetimeout 
        Timeout for caching the OCSP response. After the timeout, the Citrix ADC sends a fresh request to the OCSP responder for the certificate status. If a timeout is not specified, the timeout provided in the OCSP response applies.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 43200 
    .PARAMETER batchingdepth 
        Number of client certificates to batch together into one OCSP request. Batching avoids overloading the OCSP responder. A value of 1 signifies that each request is queried independently. For a value greater than 1, specify a timeout (batching delay) to avoid inordinately delaying the processing of a single certificate.  
        Minimum value = 1  
        Maximum value = 8 
    .PARAMETER batchingdelay 
        Maximum time, in milliseconds, to wait to accumulate OCSP requests to batch. Does not apply if the Batching Depth is 1.  
        Minimum value = 1  
        Maximum value = 10000 
    .PARAMETER resptimeout 
        Time, in milliseconds, to wait for an OCSP response. When this time elapses, an error message appears or the transaction is forwarded, depending on the settings on the virtual server. Includes Batching Delay time.  
        Minimum value = 100  
        Maximum value = 120000 
    .PARAMETER ocspurlresolvetimeout 
        Time, in milliseconds, to wait for an OCSP URL Resolution. When this time elapses, an error message appears or the transaction is forwarded, depending on the settings on the virtual server.  
        Minimum value = 100  
        Maximum value = 2000 
    .PARAMETER respondercert 
        .  
        Minimum length = 1 
    .PARAMETER trustresponder 
        A certificate to use to validate OCSP responses. Alternatively, if -trustResponder is specified, no verification will be done on the reponse. If both are omitted, only the response times (producedAt, lastUpdate, nextUpdate) will be verified. 
    .PARAMETER producedattimeskew 
        Time, in seconds, for which the Citrix ADC waits before considering the response as invalid. The response is considered invalid if the Produced At time stamp in the OCSP response exceeds or precedes the current Citrix ADC clock time by the amount of time specified.  
        Default value: 300  
        Minimum value = 0  
        Maximum value = 86400 
    .PARAMETER signingcert 
        Certificate-key pair that is used to sign OCSP requests. If this parameter is not set, the requests are not signed.  
        Minimum length = 1 
    .PARAMETER usenonce 
        Enable the OCSP nonce extension, which is designed to prevent replay attacks.  
        Possible values = YES, NO 
    .PARAMETER insertclientcert 
        Include the complete client certificate in the OCSP request.  
        Possible values = YES, NO 
    .PARAMETER httpmethod 
        HTTP method used to send ocsp request. POST is the default httpmethod. If request length is > 255, POST wil be used even if GET is set as httpMethod.  
        Default value: POST  
        Possible values = GET, POST 
    .PARAMETER PassThru 
        Return details about the created sslocspresponder item.
    .EXAMPLE
        Invoke-ADCAddSslocspresponder -name <string> -url <string>
    .NOTES
        File Name : Invoke-ADCAddSslocspresponder
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslocspresponder/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 127)]
        [string]$url ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cache = 'DISABLED' ,

        [ValidateRange(1, 43200)]
        [double]$cachetimeout = '1' ,

        [ValidateRange(1, 8)]
        [double]$batchingdepth ,

        [ValidateRange(1, 10000)]
        [double]$batchingdelay ,

        [ValidateRange(100, 120000)]
        [double]$resptimeout ,

        [ValidateRange(100, 2000)]
        [double]$ocspurlresolvetimeout ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$respondercert ,

        [boolean]$trustresponder ,

        [ValidateRange(0, 86400)]
        [double]$producedattimeskew = '300' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$signingcert ,

        [ValidateSet('YES', 'NO')]
        [string]$usenonce ,

        [ValidateSet('YES', 'NO')]
        [string]$insertclientcert ,

        [ValidateSet('GET', 'POST')]
        [string]$httpmethod = 'POST' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslocspresponder: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                url = $url
            }
            if ($PSBoundParameters.ContainsKey('cache')) { $Payload.Add('cache', $cache) }
            if ($PSBoundParameters.ContainsKey('cachetimeout')) { $Payload.Add('cachetimeout', $cachetimeout) }
            if ($PSBoundParameters.ContainsKey('batchingdepth')) { $Payload.Add('batchingdepth', $batchingdepth) }
            if ($PSBoundParameters.ContainsKey('batchingdelay')) { $Payload.Add('batchingdelay', $batchingdelay) }
            if ($PSBoundParameters.ContainsKey('resptimeout')) { $Payload.Add('resptimeout', $resptimeout) }
            if ($PSBoundParameters.ContainsKey('ocspurlresolvetimeout')) { $Payload.Add('ocspurlresolvetimeout', $ocspurlresolvetimeout) }
            if ($PSBoundParameters.ContainsKey('respondercert')) { $Payload.Add('respondercert', $respondercert) }
            if ($PSBoundParameters.ContainsKey('trustresponder')) { $Payload.Add('trustresponder', $trustresponder) }
            if ($PSBoundParameters.ContainsKey('producedattimeskew')) { $Payload.Add('producedattimeskew', $producedattimeskew) }
            if ($PSBoundParameters.ContainsKey('signingcert')) { $Payload.Add('signingcert', $signingcert) }
            if ($PSBoundParameters.ContainsKey('usenonce')) { $Payload.Add('usenonce', $usenonce) }
            if ($PSBoundParameters.ContainsKey('insertclientcert')) { $Payload.Add('insertclientcert', $insertclientcert) }
            if ($PSBoundParameters.ContainsKey('httpmethod')) { $Payload.Add('httpmethod', $httpmethod) }
 
            if ($PSCmdlet.ShouldProcess("sslocspresponder", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslocspresponder -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslocspresponder -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslocspresponder: Finished"
    }
}

function Invoke-ADCDeleteSslocspresponder {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER name 
       Name for the OCSP responder. Cannot begin with a hash (#) or space character and must contain only ASCII alphanumeric, underscore (_), hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the responder is created. 
    .EXAMPLE
        Invoke-ADCDeleteSslocspresponder -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslocspresponder
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslocspresponder/
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
        Write-Verbose "Invoke-ADCDeleteSslocspresponder: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslocspresponder -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslocspresponder: Finished"
    }
}

function Invoke-ADCUpdateSslocspresponder {
<#
    .SYNOPSIS
        Update SSL configuration Object
    .DESCRIPTION
        Update SSL configuration Object 
    .PARAMETER name 
        Name for the OCSP responder. Cannot begin with a hash (#) or space character and must contain only ASCII alphanumeric, underscore (_), hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the responder is created. 
    .PARAMETER url 
        URL of the OCSP responder.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER cache 
        Enable caching of responses. Caching of responses received from the OCSP responder enables faster responses to the clients and reduces the load on the OCSP responder.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cachetimeout 
        Timeout for caching the OCSP response. After the timeout, the Citrix ADC sends a fresh request to the OCSP responder for the certificate status. If a timeout is not specified, the timeout provided in the OCSP response applies.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 43200 
    .PARAMETER batchingdepth 
        Number of client certificates to batch together into one OCSP request. Batching avoids overloading the OCSP responder. A value of 1 signifies that each request is queried independently. For a value greater than 1, specify a timeout (batching delay) to avoid inordinately delaying the processing of a single certificate.  
        Minimum value = 1  
        Maximum value = 8 
    .PARAMETER batchingdelay 
        Maximum time, in milliseconds, to wait to accumulate OCSP requests to batch. Does not apply if the Batching Depth is 1.  
        Minimum value = 1  
        Maximum value = 10000 
    .PARAMETER resptimeout 
        Time, in milliseconds, to wait for an OCSP response. When this time elapses, an error message appears or the transaction is forwarded, depending on the settings on the virtual server. Includes Batching Delay time.  
        Minimum value = 100  
        Maximum value = 120000 
    .PARAMETER ocspurlresolvetimeout 
        Time, in milliseconds, to wait for an OCSP URL Resolution. When this time elapses, an error message appears or the transaction is forwarded, depending on the settings on the virtual server.  
        Minimum value = 100  
        Maximum value = 2000 
    .PARAMETER respondercert 
        .  
        Minimum length = 1 
    .PARAMETER trustresponder 
        A certificate to use to validate OCSP responses. Alternatively, if -trustResponder is specified, no verification will be done on the reponse. If both are omitted, only the response times (producedAt, lastUpdate, nextUpdate) will be verified. 
    .PARAMETER producedattimeskew 
        Time, in seconds, for which the Citrix ADC waits before considering the response as invalid. The response is considered invalid if the Produced At time stamp in the OCSP response exceeds or precedes the current Citrix ADC clock time by the amount of time specified.  
        Default value: 300  
        Minimum value = 0  
        Maximum value = 86400 
    .PARAMETER signingcert 
        Certificate-key pair that is used to sign OCSP requests. If this parameter is not set, the requests are not signed.  
        Minimum length = 1 
    .PARAMETER usenonce 
        Enable the OCSP nonce extension, which is designed to prevent replay attacks.  
        Possible values = YES, NO 
    .PARAMETER insertclientcert 
        Include the complete client certificate in the OCSP request.  
        Possible values = YES, NO 
    .PARAMETER httpmethod 
        HTTP method used to send ocsp request. POST is the default httpmethod. If request length is > 255, POST wil be used even if GET is set as httpMethod.  
        Default value: POST  
        Possible values = GET, POST 
    .PARAMETER PassThru 
        Return details about the created sslocspresponder item.
    .EXAMPLE
        Invoke-ADCUpdateSslocspresponder -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateSslocspresponder
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslocspresponder/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [ValidateLength(1, 127)]
        [string]$url ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cache ,

        [ValidateRange(1, 43200)]
        [double]$cachetimeout ,

        [ValidateRange(1, 8)]
        [double]$batchingdepth ,

        [ValidateRange(1, 10000)]
        [double]$batchingdelay ,

        [ValidateRange(100, 120000)]
        [double]$resptimeout ,

        [ValidateRange(100, 2000)]
        [double]$ocspurlresolvetimeout ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$respondercert ,

        [boolean]$trustresponder ,

        [ValidateRange(0, 86400)]
        [double]$producedattimeskew ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$signingcert ,

        [ValidateSet('YES', 'NO')]
        [string]$usenonce ,

        [ValidateSet('YES', 'NO')]
        [string]$insertclientcert ,

        [ValidateSet('GET', 'POST')]
        [string]$httpmethod ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSslocspresponder: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('url')) { $Payload.Add('url', $url) }
            if ($PSBoundParameters.ContainsKey('cache')) { $Payload.Add('cache', $cache) }
            if ($PSBoundParameters.ContainsKey('cachetimeout')) { $Payload.Add('cachetimeout', $cachetimeout) }
            if ($PSBoundParameters.ContainsKey('batchingdepth')) { $Payload.Add('batchingdepth', $batchingdepth) }
            if ($PSBoundParameters.ContainsKey('batchingdelay')) { $Payload.Add('batchingdelay', $batchingdelay) }
            if ($PSBoundParameters.ContainsKey('resptimeout')) { $Payload.Add('resptimeout', $resptimeout) }
            if ($PSBoundParameters.ContainsKey('ocspurlresolvetimeout')) { $Payload.Add('ocspurlresolvetimeout', $ocspurlresolvetimeout) }
            if ($PSBoundParameters.ContainsKey('respondercert')) { $Payload.Add('respondercert', $respondercert) }
            if ($PSBoundParameters.ContainsKey('trustresponder')) { $Payload.Add('trustresponder', $trustresponder) }
            if ($PSBoundParameters.ContainsKey('producedattimeskew')) { $Payload.Add('producedattimeskew', $producedattimeskew) }
            if ($PSBoundParameters.ContainsKey('signingcert')) { $Payload.Add('signingcert', $signingcert) }
            if ($PSBoundParameters.ContainsKey('usenonce')) { $Payload.Add('usenonce', $usenonce) }
            if ($PSBoundParameters.ContainsKey('insertclientcert')) { $Payload.Add('insertclientcert', $insertclientcert) }
            if ($PSBoundParameters.ContainsKey('httpmethod')) { $Payload.Add('httpmethod', $httpmethod) }
 
            if ($PSCmdlet.ShouldProcess("sslocspresponder", "Update SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslocspresponder -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslocspresponder -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateSslocspresponder: Finished"
    }
}

function Invoke-ADCUnsetSslocspresponder {
<#
    .SYNOPSIS
        Unset SSL configuration Object
    .DESCRIPTION
        Unset SSL configuration Object 
   .PARAMETER name 
       Name for the OCSP responder. Cannot begin with a hash (#) or space character and must contain only ASCII alphanumeric, underscore (_), hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the responder is created. 
   .PARAMETER trustresponder 
       A certificate to use to validate OCSP responses. Alternatively, if -trustResponder is specified, no verification will be done on the reponse. If both are omitted, only the response times (producedAt, lastUpdate, nextUpdate) will be verified. 
   .PARAMETER insertclientcert 
       Include the complete client certificate in the OCSP request.  
       Possible values = YES, NO 
   .PARAMETER cache 
       Enable caching of responses. Caching of responses received from the OCSP responder enables faster responses to the clients and reduces the load on the OCSP responder.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER cachetimeout 
       Timeout for caching the OCSP response. After the timeout, the Citrix ADC sends a fresh request to the OCSP responder for the certificate status. If a timeout is not specified, the timeout provided in the OCSP response applies. 
   .PARAMETER batchingdepth 
       Number of client certificates to batch together into one OCSP request. Batching avoids overloading the OCSP responder. A value of 1 signifies that each request is queried independently. For a value greater than 1, specify a timeout (batching delay) to avoid inordinately delaying the processing of a single certificate. 
   .PARAMETER batchingdelay 
       Maximum time, in milliseconds, to wait to accumulate OCSP requests to batch. Does not apply if the Batching Depth is 1. 
   .PARAMETER resptimeout 
       Time, in milliseconds, to wait for an OCSP response. When this time elapses, an error message appears or the transaction is forwarded, depending on the settings on the virtual server. Includes Batching Delay time. 
   .PARAMETER ocspurlresolvetimeout 
       Time, in milliseconds, to wait for an OCSP URL Resolution. When this time elapses, an error message appears or the transaction is forwarded, depending on the settings on the virtual server. 
   .PARAMETER respondercert 
       . 
   .PARAMETER producedattimeskew 
       Time, in seconds, for which the Citrix ADC waits before considering the response as invalid. The response is considered invalid if the Produced At time stamp in the OCSP response exceeds or precedes the current Citrix ADC clock time by the amount of time specified. 
   .PARAMETER signingcert 
       Certificate-key pair that is used to sign OCSP requests. If this parameter is not set, the requests are not signed. 
   .PARAMETER usenonce 
       Enable the OCSP nonce extension, which is designed to prevent replay attacks.  
       Possible values = YES, NO 
   .PARAMETER httpmethod 
       HTTP method used to send ocsp request. POST is the default httpmethod. If request length is > 255, POST wil be used even if GET is set as httpMethod.  
       Possible values = GET, POST
    .EXAMPLE
        Invoke-ADCUnsetSslocspresponder -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetSslocspresponder
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslocspresponder
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [Boolean]$trustresponder ,

        [Boolean]$insertclientcert ,

        [Boolean]$cache ,

        [Boolean]$cachetimeout ,

        [Boolean]$batchingdepth ,

        [Boolean]$batchingdelay ,

        [Boolean]$resptimeout ,

        [Boolean]$ocspurlresolvetimeout ,

        [Boolean]$respondercert ,

        [Boolean]$producedattimeskew ,

        [Boolean]$signingcert ,

        [Boolean]$usenonce ,

        [Boolean]$httpmethod 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSslocspresponder: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('trustresponder')) { $Payload.Add('trustresponder', $trustresponder) }
            if ($PSBoundParameters.ContainsKey('insertclientcert')) { $Payload.Add('insertclientcert', $insertclientcert) }
            if ($PSBoundParameters.ContainsKey('cache')) { $Payload.Add('cache', $cache) }
            if ($PSBoundParameters.ContainsKey('cachetimeout')) { $Payload.Add('cachetimeout', $cachetimeout) }
            if ($PSBoundParameters.ContainsKey('batchingdepth')) { $Payload.Add('batchingdepth', $batchingdepth) }
            if ($PSBoundParameters.ContainsKey('batchingdelay')) { $Payload.Add('batchingdelay', $batchingdelay) }
            if ($PSBoundParameters.ContainsKey('resptimeout')) { $Payload.Add('resptimeout', $resptimeout) }
            if ($PSBoundParameters.ContainsKey('ocspurlresolvetimeout')) { $Payload.Add('ocspurlresolvetimeout', $ocspurlresolvetimeout) }
            if ($PSBoundParameters.ContainsKey('respondercert')) { $Payload.Add('respondercert', $respondercert) }
            if ($PSBoundParameters.ContainsKey('producedattimeskew')) { $Payload.Add('producedattimeskew', $producedattimeskew) }
            if ($PSBoundParameters.ContainsKey('signingcert')) { $Payload.Add('signingcert', $signingcert) }
            if ($PSBoundParameters.ContainsKey('usenonce')) { $Payload.Add('usenonce', $usenonce) }
            if ($PSBoundParameters.ContainsKey('httpmethod')) { $Payload.Add('httpmethod', $httpmethod) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslocspresponder -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSslocspresponder: Finished"
    }
}

function Invoke-ADCGetSslocspresponder {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       Name for the OCSP responder. Cannot begin with a hash (#) or space character and must contain only ASCII alphanumeric, underscore (_), hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the responder is created. 
    .PARAMETER GetAll 
        Retreive all sslocspresponder object(s)
    .PARAMETER Count
        If specified, the count of the sslocspresponder object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslocspresponder
    .EXAMPLE 
        Invoke-ADCGetSslocspresponder -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslocspresponder -Count
    .EXAMPLE
        Invoke-ADCGetSslocspresponder -name <string>
    .EXAMPLE
        Invoke-ADCGetSslocspresponder -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslocspresponder
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslocspresponder/
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
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-ADCGetSslocspresponder: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslocspresponder objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslocspresponder -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslocspresponder objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslocspresponder -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslocspresponder objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslocspresponder -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslocspresponder configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslocspresponder -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslocspresponder configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslocspresponder -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslocspresponder: Ended"
    }
}

function Invoke-ADCUpdateSslparameter {
<#
    .SYNOPSIS
        Update SSL configuration Object
    .DESCRIPTION
        Update SSL configuration Object 
    .PARAMETER quantumsize 
        Amount of data to collect before the data is pushed to the crypto hardware for encryption. For large downloads, a larger quantum size better utilizes the crypto resources.  
        Default value: 8192  
        Possible values = 4096, 8192, 16384 
    .PARAMETER crlmemorysizemb 
        Maximum memory size to use for certificate revocation lists (CRLs). This parameter reserves memory for a CRL but sets a limit to the maximum memory that the CRLs loaded on the appliance can consume.  
        Default value: 256  
        Minimum value = 10  
        Maximum value = 1024 
    .PARAMETER strictcachecks 
        Enable strict CA certificate checks on the appliance.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER ssltriggertimeout 
        Time, in milliseconds, after which encryption is triggered for transactions that are not tracked on the Citrix ADC because their length is not known. There can be a delay of up to 10ms from the specified timeout value before the packet is pushed into the queue.  
        Default value: 100  
        Minimum value = 1  
        Maximum value = 200 
    .PARAMETER sendclosenotify 
        Send an SSL Close-Notify message to the client at the end of a transaction.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER encrypttriggerpktcount 
        Maximum number of queued packets after which encryption is triggered. Use this setting for SSL transactions that send small packets from server to Citrix ADC.  
        Default value: 45  
        Minimum value = 10  
        Maximum value = 50 
    .PARAMETER denysslreneg 
        Deny renegotiation in specified circumstances. Available settings function as follows:  
        * NO - Allow SSL renegotiation.  
        * FRONTEND_CLIENT - Deny secure and nonsecure SSL renegotiation initiated by the client.  
        * FRONTEND_CLIENTSERVER - Deny secure and nonsecure SSL renegotiation initiated by the client or the Citrix ADC during policy-based client authentication.  
        * ALL - Deny all secure and nonsecure SSL renegotiation.  
        * NONSECURE - Deny nonsecure SSL renegotiation. Allows only clients that support RFC 5746.  
        Default value: ALL  
        Possible values = NO, FRONTEND_CLIENT, FRONTEND_CLIENTSERVER, ALL, NONSECURE 
    .PARAMETER insertionencoding 
        Encoding method used to insert the subject or issuer's name in HTTP requests to servers.  
        Default value: Unicode  
        Possible values = Unicode, UTF-8 
    .PARAMETER ocspcachesize 
        Size, per packet engine, in megabytes, of the OCSP cache. A maximum of 10% of the packet engine memory can be assigned. Because the maximum allowed packet engine memory is 4GB, the maximum value that can be assigned to the OCSP cache is approximately 410 MB.  
        Default value: 10  
        Minimum value = 0  
        Maximum value = 512 
    .PARAMETER pushflag 
        Insert PUSH flag into decrypted, encrypted, or all records. If the PUSH flag is set to a value other than 0, the buffered records are forwarded on the basis of the value of the PUSH flag. Available settings function as follows:  
        0 - Auto (PUSH flag is not set.)  
        1 - Insert PUSH flag into every decrypted record.  
        2 -Insert PUSH flag into every encrypted record.  
        3 - Insert PUSH flag into every decrypted and encrypted record.  
        Minimum value = 0  
        Maximum value = 3 
    .PARAMETER dropreqwithnohostheader 
        Host header check for SNI enabled sessions. If this check is enabled and the HTTP request does not contain the host header for SNI enabled sessions(i.e vserver or profile bound to vserver has SNI enabled and 'Client Hello' arrived with SNI extension), the request is dropped.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER snihttphostmatch 
        Controls how the HTTP 'Host' header value is validated. These checks are performed only if the session is SNI enabled (i.e when vserver or profile bound to vserver has SNI enabled and 'Client Hello' arrived with SNI extension) and HTTP request contains 'Host' header.  
        Available settings function as follows:  
        CERT - Request is forwarded if the 'Host' value is covered  
        by the certificate used to establish this SSL session.  
        Note: 'CERT' matching mode cannot be applied in  
        TLS 1.3 connections established by resuming from a  
        previous TLS 1.3 session. On these connections, 'STRICT'  
        matching mode will be used instead.  
        STRICT - Request is forwarded only if value of 'Host' header  
        in HTTP is identical to the 'Server name' value passed  
        in 'Client Hello' of the SSL connection.  
        NO - No validation is performed on the HTTP 'Host'  
        header value.  
        Default value: CERT  
        Possible values = NO, CERT, STRICT 
    .PARAMETER pushenctriggertimeout 
        PUSH encryption trigger timeout value. The timeout value is applied only if you set the Push Encryption Trigger parameter to Timer in the SSL virtual server settings.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 200 
    .PARAMETER cryptodevdisablelimit 
        Limit to the number of disabled SSL chips after which the ADC restarts. A value of zero implies that the ADC does not automatically restart.  
        Default value: 0 
    .PARAMETER undefactioncontrol 
        Name of the undefined built-in control action: CLIENTAUTH, NOCLIENTAUTH, NOOP, RESET, or DROP.  
        Default value: "CLIENTAUTH" 
    .PARAMETER undefactiondata 
        Name of the undefined built-in data action: NOOP, RESET or DROP.  
        Default value: "NOOP" 
    .PARAMETER defaultprofile 
        Global parameter used to enable default profile feature.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER softwarecryptothreshold 
        Citrix ADC CPU utilization threshold (in percentage) beyond which crypto operations are not done in software.  
        A value of zero implies that CPU is not utilized for doing crypto in software.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER hybridfipsmode 
        When this mode is enabled, system will use additional crypto hardware to accelerate symmetric crypto operations.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sigdigesttype 
        Signature Digest Algorithms that are supported by appliance. Default value is "ALL" and it will enable the following algorithms depending on the platform.  
        On VPX: ECDSA-SHA1 ECDSA-SHA224 ECDSA-SHA256 ECDSA-SHA384 ECDSA-SHA512 RSA-SHA1 RSA-SHA224 RSA-SHA256 RSA-SHA384 RSA-SHA512 DSA-SHA1 DSA-SHA224 DSA-SHA256 DSA-SHA384 DSA-SHA512  
        On MPX with Nitrox-III and coleto cards: RSA-SHA1 RSA-SHA224 RSA-SHA256 RSA-SHA384 RSA-SHA512 ECDSA-SHA1 ECDSA-SHA224 ECDSA-SHA256 ECDSA-SHA384 ECDSA-SHA512  
        Others: RSA-SHA1 RSA-SHA224 RSA-SHA256 RSA-SHA384 RSA-SHA512.  
        Note:ALL doesnot include RSA-MD5 for any platform.  
        Default value: ALL  
        Possible values = ALL, RSA-MD5, RSA-SHA1, RSA-SHA224, RSA-SHA256, RSA-SHA384, RSA-SHA512, DSA-SHA1, DSA-SHA224, DSA-SHA256, DSA-SHA384, DSA-SHA512, ECDSA-SHA1, ECDSA-SHA224, ECDSA-SHA256, ECDSA-SHA384, ECDSA-SHA512 
    .PARAMETER sslierrorcache 
        Enable or disable dynamically learning and caching the learned information to make the subsequent interception or bypass decision. When enabled, NS does the lookup of this cached data to do early bypass.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sslimaxerrorcachemem 
        Specify the maximum memory that can be used for caching the learned data. This memory is used as a LRU cache so that the old entries gets replaced with new entry once the set memory limit is fully utilised. A value of 0 decides the limit automatically.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER insertcertspace 
        To insert space between lines in the certificate header of request.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER ndcppcompliancecertcheck 
        Applies when the Citrix ADC appliance acts as a client (back-end connection).  
        Settings apply as follows:  
        YES - During certificate verification, ignore the common name if SAN is present in the certificate.  
        NO - Do not ignore common name.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER heterogeneoussslhw 
        To support both cavium and coleto based platforms in cluster environment, this mode has to be enabled.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER operationqueuelimit 
        Limit in percentage of capacity of the crypto operations queue beyond which new SSL connections are not accepted until the queue is reduced.  
        Default value: 150  
        Minimum value = 0  
        Maximum value = 10000
    .EXAMPLE
        Invoke-ADCUpdateSslparameter 
    .NOTES
        File Name : Invoke-ADCUpdateSslparameter
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslparameter/
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

        [ValidateSet('4096', '8192', '16384')]
        [string]$quantumsize ,

        [ValidateRange(10, 1024)]
        [double]$crlmemorysizemb ,

        [ValidateSet('YES', 'NO')]
        [string]$strictcachecks ,

        [ValidateRange(1, 200)]
        [double]$ssltriggertimeout ,

        [ValidateSet('YES', 'NO')]
        [string]$sendclosenotify ,

        [ValidateRange(10, 50)]
        [double]$encrypttriggerpktcount ,

        [ValidateSet('NO', 'FRONTEND_CLIENT', 'FRONTEND_CLIENTSERVER', 'ALL', 'NONSECURE')]
        [string]$denysslreneg ,

        [ValidateSet('Unicode', 'UTF-8')]
        [string]$insertionencoding ,

        [ValidateRange(0, 512)]
        [double]$ocspcachesize ,

        [ValidateRange(0, 3)]
        [double]$pushflag ,

        [ValidateSet('YES', 'NO')]
        [string]$dropreqwithnohostheader ,

        [ValidateSet('NO', 'CERT', 'STRICT')]
        [string]$snihttphostmatch ,

        [ValidateRange(1, 200)]
        [double]$pushenctriggertimeout ,

        [double]$cryptodevdisablelimit ,

        [string]$undefactioncontrol ,

        [string]$undefactiondata ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$defaultprofile ,

        [ValidateRange(0, 100)]
        [double]$softwarecryptothreshold ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$hybridfipsmode ,

        [ValidateSet('ALL', 'RSA-MD5', 'RSA-SHA1', 'RSA-SHA224', 'RSA-SHA256', 'RSA-SHA384', 'RSA-SHA512', 'DSA-SHA1', 'DSA-SHA224', 'DSA-SHA256', 'DSA-SHA384', 'DSA-SHA512', 'ECDSA-SHA1', 'ECDSA-SHA224', 'ECDSA-SHA256', 'ECDSA-SHA384', 'ECDSA-SHA512')]
        [string[]]$sigdigesttype ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslierrorcache ,

        [ValidateRange(0, 4294967294)]
        [double]$sslimaxerrorcachemem ,

        [ValidateSet('YES', 'NO')]
        [string]$insertcertspace ,

        [ValidateSet('YES', 'NO')]
        [string]$ndcppcompliancecertcheck ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$heterogeneoussslhw ,

        [ValidateRange(0, 10000)]
        [double]$operationqueuelimit 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSslparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('quantumsize')) { $Payload.Add('quantumsize', $quantumsize) }
            if ($PSBoundParameters.ContainsKey('crlmemorysizemb')) { $Payload.Add('crlmemorysizemb', $crlmemorysizemb) }
            if ($PSBoundParameters.ContainsKey('strictcachecks')) { $Payload.Add('strictcachecks', $strictcachecks) }
            if ($PSBoundParameters.ContainsKey('ssltriggertimeout')) { $Payload.Add('ssltriggertimeout', $ssltriggertimeout) }
            if ($PSBoundParameters.ContainsKey('sendclosenotify')) { $Payload.Add('sendclosenotify', $sendclosenotify) }
            if ($PSBoundParameters.ContainsKey('encrypttriggerpktcount')) { $Payload.Add('encrypttriggerpktcount', $encrypttriggerpktcount) }
            if ($PSBoundParameters.ContainsKey('denysslreneg')) { $Payload.Add('denysslreneg', $denysslreneg) }
            if ($PSBoundParameters.ContainsKey('insertionencoding')) { $Payload.Add('insertionencoding', $insertionencoding) }
            if ($PSBoundParameters.ContainsKey('ocspcachesize')) { $Payload.Add('ocspcachesize', $ocspcachesize) }
            if ($PSBoundParameters.ContainsKey('pushflag')) { $Payload.Add('pushflag', $pushflag) }
            if ($PSBoundParameters.ContainsKey('dropreqwithnohostheader')) { $Payload.Add('dropreqwithnohostheader', $dropreqwithnohostheader) }
            if ($PSBoundParameters.ContainsKey('snihttphostmatch')) { $Payload.Add('snihttphostmatch', $snihttphostmatch) }
            if ($PSBoundParameters.ContainsKey('pushenctriggertimeout')) { $Payload.Add('pushenctriggertimeout', $pushenctriggertimeout) }
            if ($PSBoundParameters.ContainsKey('cryptodevdisablelimit')) { $Payload.Add('cryptodevdisablelimit', $cryptodevdisablelimit) }
            if ($PSBoundParameters.ContainsKey('undefactioncontrol')) { $Payload.Add('undefactioncontrol', $undefactioncontrol) }
            if ($PSBoundParameters.ContainsKey('undefactiondata')) { $Payload.Add('undefactiondata', $undefactiondata) }
            if ($PSBoundParameters.ContainsKey('defaultprofile')) { $Payload.Add('defaultprofile', $defaultprofile) }
            if ($PSBoundParameters.ContainsKey('softwarecryptothreshold')) { $Payload.Add('softwarecryptothreshold', $softwarecryptothreshold) }
            if ($PSBoundParameters.ContainsKey('hybridfipsmode')) { $Payload.Add('hybridfipsmode', $hybridfipsmode) }
            if ($PSBoundParameters.ContainsKey('sigdigesttype')) { $Payload.Add('sigdigesttype', $sigdigesttype) }
            if ($PSBoundParameters.ContainsKey('sslierrorcache')) { $Payload.Add('sslierrorcache', $sslierrorcache) }
            if ($PSBoundParameters.ContainsKey('sslimaxerrorcachemem')) { $Payload.Add('sslimaxerrorcachemem', $sslimaxerrorcachemem) }
            if ($PSBoundParameters.ContainsKey('insertcertspace')) { $Payload.Add('insertcertspace', $insertcertspace) }
            if ($PSBoundParameters.ContainsKey('ndcppcompliancecertcheck')) { $Payload.Add('ndcppcompliancecertcheck', $ndcppcompliancecertcheck) }
            if ($PSBoundParameters.ContainsKey('heterogeneoussslhw')) { $Payload.Add('heterogeneoussslhw', $heterogeneoussslhw) }
            if ($PSBoundParameters.ContainsKey('operationqueuelimit')) { $Payload.Add('operationqueuelimit', $operationqueuelimit) }
 
            if ($PSCmdlet.ShouldProcess("sslparameter", "Update SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslparameter -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateSslparameter: Finished"
    }
}

function Invoke-ADCUnsetSslparameter {
<#
    .SYNOPSIS
        Unset SSL configuration Object
    .DESCRIPTION
        Unset SSL configuration Object 
   .PARAMETER quantumsize 
       Amount of data to collect before the data is pushed to the crypto hardware for encryption. For large downloads, a larger quantum size better utilizes the crypto resources.  
       Possible values = 4096, 8192, 16384 
   .PARAMETER crlmemorysizemb 
       Maximum memory size to use for certificate revocation lists (CRLs). This parameter reserves memory for a CRL but sets a limit to the maximum memory that the CRLs loaded on the appliance can consume. 
   .PARAMETER strictcachecks 
       Enable strict CA certificate checks on the appliance.  
       Possible values = YES, NO 
   .PARAMETER ssltriggertimeout 
       Time, in milliseconds, after which encryption is triggered for transactions that are not tracked on the Citrix ADC because their length is not known. There can be a delay of up to 10ms from the specified timeout value before the packet is pushed into the queue. 
   .PARAMETER sendclosenotify 
       Send an SSL Close-Notify message to the client at the end of a transaction.  
       Possible values = YES, NO 
   .PARAMETER encrypttriggerpktcount 
       Maximum number of queued packets after which encryption is triggered. Use this setting for SSL transactions that send small packets from server to Citrix ADC. 
   .PARAMETER denysslreneg 
       Deny renegotiation in specified circumstances. Available settings function as follows:  
       * NO - Allow SSL renegotiation.  
       * FRONTEND_CLIENT - Deny secure and nonsecure SSL renegotiation initiated by the client.  
       * FRONTEND_CLIENTSERVER - Deny secure and nonsecure SSL renegotiation initiated by the client or the Citrix ADC during policy-based client authentication.  
       * ALL - Deny all secure and nonsecure SSL renegotiation.  
       * NONSECURE - Deny nonsecure SSL renegotiation. Allows only clients that support RFC 5746.  
       Possible values = NO, FRONTEND_CLIENT, FRONTEND_CLIENTSERVER, ALL, NONSECURE 
   .PARAMETER insertionencoding 
       Encoding method used to insert the subject or issuer's name in HTTP requests to servers.  
       Possible values = Unicode, UTF-8 
   .PARAMETER ocspcachesize 
       Size, per packet engine, in megabytes, of the OCSP cache. A maximum of 10% of the packet engine memory can be assigned. Because the maximum allowed packet engine memory is 4GB, the maximum value that can be assigned to the OCSP cache is approximately 410 MB. 
   .PARAMETER pushflag 
       Insert PUSH flag into decrypted, encrypted, or all records. If the PUSH flag is set to a value other than 0, the buffered records are forwarded on the basis of the value of the PUSH flag. Available settings function as follows:  
       0 - Auto (PUSH flag is not set.)  
       1 - Insert PUSH flag into every decrypted record.  
       2 -Insert PUSH flag into every encrypted record.  
       3 - Insert PUSH flag into every decrypted and encrypted record. 
   .PARAMETER dropreqwithnohostheader 
       Host header check for SNI enabled sessions. If this check is enabled and the HTTP request does not contain the host header for SNI enabled sessions(i.e vserver or profile bound to vserver has SNI enabled and 'Client Hello' arrived with SNI extension), the request is dropped.  
       Possible values = YES, NO 
   .PARAMETER snihttphostmatch 
       Controls how the HTTP 'Host' header value is validated. These checks are performed only if the session is SNI enabled (i.e when vserver or profile bound to vserver has SNI enabled and 'Client Hello' arrived with SNI extension) and HTTP request contains 'Host' header.  
       Available settings function as follows:  
       CERT - Request is forwarded if the 'Host' value is covered  
       by the certificate used to establish this SSL session.  
       Note: 'CERT' matching mode cannot be applied in  
       TLS 1.3 connections established by resuming from a  
       previous TLS 1.3 session. On these connections, 'STRICT'  
       matching mode will be used instead.  
       STRICT - Request is forwarded only if value of 'Host' header  
       in HTTP is identical to the 'Server name' value passed  
       in 'Client Hello' of the SSL connection.  
       NO - No validation is performed on the HTTP 'Host'  
       header value.  
       Possible values = NO, CERT, STRICT 
   .PARAMETER pushenctriggertimeout 
       PUSH encryption trigger timeout value. The timeout value is applied only if you set the Push Encryption Trigger parameter to Timer in the SSL virtual server settings. 
   .PARAMETER cryptodevdisablelimit 
       Limit to the number of disabled SSL chips after which the ADC restarts. A value of zero implies that the ADC does not automatically restart. 
   .PARAMETER undefactioncontrol 
       Name of the undefined built-in control action: CLIENTAUTH, NOCLIENTAUTH, NOOP, RESET, or DROP. 
   .PARAMETER undefactiondata 
       Name of the undefined built-in data action: NOOP, RESET or DROP. 
   .PARAMETER defaultprofile 
       Global parameter used to enable default profile feature.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER softwarecryptothreshold 
       Citrix ADC CPU utilization threshold (in percentage) beyond which crypto operations are not done in software.  
       A value of zero implies that CPU is not utilized for doing crypto in software. 
   .PARAMETER hybridfipsmode 
       When this mode is enabled, system will use additional crypto hardware to accelerate symmetric crypto operations.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sigdigesttype 
       Signature Digest Algorithms that are supported by appliance. Default value is "ALL" and it will enable the following algorithms depending on the platform.  
       On VPX: ECDSA-SHA1 ECDSA-SHA224 ECDSA-SHA256 ECDSA-SHA384 ECDSA-SHA512 RSA-SHA1 RSA-SHA224 RSA-SHA256 RSA-SHA384 RSA-SHA512 DSA-SHA1 DSA-SHA224 DSA-SHA256 DSA-SHA384 DSA-SHA512  
       On MPX with Nitrox-III and coleto cards: RSA-SHA1 RSA-SHA224 RSA-SHA256 RSA-SHA384 RSA-SHA512 ECDSA-SHA1 ECDSA-SHA224 ECDSA-SHA256 ECDSA-SHA384 ECDSA-SHA512  
       Others: RSA-SHA1 RSA-SHA224 RSA-SHA256 RSA-SHA384 RSA-SHA512.  
       Note:ALL doesnot include RSA-MD5 for any platform.  
       Possible values = ALL, RSA-MD5, RSA-SHA1, RSA-SHA224, RSA-SHA256, RSA-SHA384, RSA-SHA512, DSA-SHA1, DSA-SHA224, DSA-SHA256, DSA-SHA384, DSA-SHA512, ECDSA-SHA1, ECDSA-SHA224, ECDSA-SHA256, ECDSA-SHA384, ECDSA-SHA512 
   .PARAMETER sslierrorcache 
       Enable or disable dynamically learning and caching the learned information to make the subsequent interception or bypass decision. When enabled, NS does the lookup of this cached data to do early bypass.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sslimaxerrorcachemem 
       Specify the maximum memory that can be used for caching the learned data. This memory is used as a LRU cache so that the old entries gets replaced with new entry once the set memory limit is fully utilised. A value of 0 decides the limit automatically. 
   .PARAMETER insertcertspace 
       To insert space between lines in the certificate header of request.  
       Possible values = YES, NO 
   .PARAMETER ndcppcompliancecertcheck 
       Applies when the Citrix ADC appliance acts as a client (back-end connection).  
       Settings apply as follows:  
       YES - During certificate verification, ignore the common name if SAN is present in the certificate.  
       NO - Do not ignore common name.  
       Possible values = YES, NO 
   .PARAMETER heterogeneoussslhw 
       To support both cavium and coleto based platforms in cluster environment, this mode has to be enabled.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER operationqueuelimit 
       Limit in percentage of capacity of the crypto operations queue beyond which new SSL connections are not accepted until the queue is reduced.
    .EXAMPLE
        Invoke-ADCUnsetSslparameter 
    .NOTES
        File Name : Invoke-ADCUnsetSslparameter
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslparameter
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

        [Boolean]$quantumsize ,

        [Boolean]$crlmemorysizemb ,

        [Boolean]$strictcachecks ,

        [Boolean]$ssltriggertimeout ,

        [Boolean]$sendclosenotify ,

        [Boolean]$encrypttriggerpktcount ,

        [Boolean]$denysslreneg ,

        [Boolean]$insertionencoding ,

        [Boolean]$ocspcachesize ,

        [Boolean]$pushflag ,

        [Boolean]$dropreqwithnohostheader ,

        [Boolean]$snihttphostmatch ,

        [Boolean]$pushenctriggertimeout ,

        [Boolean]$cryptodevdisablelimit ,

        [Boolean]$undefactioncontrol ,

        [Boolean]$undefactiondata ,

        [Boolean]$defaultprofile ,

        [Boolean]$softwarecryptothreshold ,

        [Boolean]$hybridfipsmode ,

        [Boolean]$sigdigesttype ,

        [Boolean]$sslierrorcache ,

        [Boolean]$sslimaxerrorcachemem ,

        [Boolean]$insertcertspace ,

        [Boolean]$ndcppcompliancecertcheck ,

        [Boolean]$heterogeneoussslhw ,

        [Boolean]$operationqueuelimit 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSslparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('quantumsize')) { $Payload.Add('quantumsize', $quantumsize) }
            if ($PSBoundParameters.ContainsKey('crlmemorysizemb')) { $Payload.Add('crlmemorysizemb', $crlmemorysizemb) }
            if ($PSBoundParameters.ContainsKey('strictcachecks')) { $Payload.Add('strictcachecks', $strictcachecks) }
            if ($PSBoundParameters.ContainsKey('ssltriggertimeout')) { $Payload.Add('ssltriggertimeout', $ssltriggertimeout) }
            if ($PSBoundParameters.ContainsKey('sendclosenotify')) { $Payload.Add('sendclosenotify', $sendclosenotify) }
            if ($PSBoundParameters.ContainsKey('encrypttriggerpktcount')) { $Payload.Add('encrypttriggerpktcount', $encrypttriggerpktcount) }
            if ($PSBoundParameters.ContainsKey('denysslreneg')) { $Payload.Add('denysslreneg', $denysslreneg) }
            if ($PSBoundParameters.ContainsKey('insertionencoding')) { $Payload.Add('insertionencoding', $insertionencoding) }
            if ($PSBoundParameters.ContainsKey('ocspcachesize')) { $Payload.Add('ocspcachesize', $ocspcachesize) }
            if ($PSBoundParameters.ContainsKey('pushflag')) { $Payload.Add('pushflag', $pushflag) }
            if ($PSBoundParameters.ContainsKey('dropreqwithnohostheader')) { $Payload.Add('dropreqwithnohostheader', $dropreqwithnohostheader) }
            if ($PSBoundParameters.ContainsKey('snihttphostmatch')) { $Payload.Add('snihttphostmatch', $snihttphostmatch) }
            if ($PSBoundParameters.ContainsKey('pushenctriggertimeout')) { $Payload.Add('pushenctriggertimeout', $pushenctriggertimeout) }
            if ($PSBoundParameters.ContainsKey('cryptodevdisablelimit')) { $Payload.Add('cryptodevdisablelimit', $cryptodevdisablelimit) }
            if ($PSBoundParameters.ContainsKey('undefactioncontrol')) { $Payload.Add('undefactioncontrol', $undefactioncontrol) }
            if ($PSBoundParameters.ContainsKey('undefactiondata')) { $Payload.Add('undefactiondata', $undefactiondata) }
            if ($PSBoundParameters.ContainsKey('defaultprofile')) { $Payload.Add('defaultprofile', $defaultprofile) }
            if ($PSBoundParameters.ContainsKey('softwarecryptothreshold')) { $Payload.Add('softwarecryptothreshold', $softwarecryptothreshold) }
            if ($PSBoundParameters.ContainsKey('hybridfipsmode')) { $Payload.Add('hybridfipsmode', $hybridfipsmode) }
            if ($PSBoundParameters.ContainsKey('sigdigesttype')) { $Payload.Add('sigdigesttype', $sigdigesttype) }
            if ($PSBoundParameters.ContainsKey('sslierrorcache')) { $Payload.Add('sslierrorcache', $sslierrorcache) }
            if ($PSBoundParameters.ContainsKey('sslimaxerrorcachemem')) { $Payload.Add('sslimaxerrorcachemem', $sslimaxerrorcachemem) }
            if ($PSBoundParameters.ContainsKey('insertcertspace')) { $Payload.Add('insertcertspace', $insertcertspace) }
            if ($PSBoundParameters.ContainsKey('ndcppcompliancecertcheck')) { $Payload.Add('ndcppcompliancecertcheck', $ndcppcompliancecertcheck) }
            if ($PSBoundParameters.ContainsKey('heterogeneoussslhw')) { $Payload.Add('heterogeneoussslhw', $heterogeneoussslhw) }
            if ($PSBoundParameters.ContainsKey('operationqueuelimit')) { $Payload.Add('operationqueuelimit', $operationqueuelimit) }
            if ($PSCmdlet.ShouldProcess("sslparameter", "Unset SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslparameter -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSslparameter: Finished"
    }
}

function Invoke-ADCGetSslparameter {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER GetAll 
        Retreive all sslparameter object(s)
    .PARAMETER Count
        If specified, the count of the sslparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslparameter
    .EXAMPLE 
        Invoke-ADCGetSslparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetSslparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetSslparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslparameter
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslparameter/
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
        Write-Verbose "Invoke-ADCGetSslparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslparameter -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslparameter -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslparameter -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving sslparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslparameter -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslparameter: Ended"
    }
}

function Invoke-ADCConvertSslpkcs12 {
<#
    .SYNOPSIS
        Convert SSL configuration Object
    .DESCRIPTION
        Convert SSL configuration Object 
    .PARAMETER outfile 
        Name for and, optionally, path to, the output file that contains the certificate and the private key after converting from PKCS#12 to PEM format. /nsconfig/ssl/ is the default path.  
        If importing, the certificate-key pair is stored in PEM format. If exporting, the certificate-key pair is stored in PKCS#12 format. 
    .PARAMETER Import 
        Convert the certificate and private-key from PKCS#12 format to PEM format. 
    .PARAMETER pkcs12file 
        Name for and, optionally, path to, the PKCS#12 file. If importing, specify the input file name that contains the certificate and the private key in PKCS#12 format. If exporting, specify the output file name that contains the certificate and the private key after converting from PEM to  
        PKCS#12 format. /nsconfig/ssl/ is the default path.  
        During the import operation, if the key is encrypted, you are prompted to enter the pass phrase used for encrypting the key. 
    .PARAMETER des 
        Encrypt the private key by using the DES algorithm in CBC mode during the import operation. On the command line, you are prompted to enter the pass phrase. 
    .PARAMETER des3 
        Encrypt the private key by using the Triple-DES algorithm in EDE CBC mode (168-bit key) during the import operation. On the command line, you are prompted to enter the pass phrase. 
    .PARAMETER aes256 
        Encrypt the private key by using the AES algorithm (256-bit key) during the import operation. On the command line, you are prompted to enter the pass phrase. 
    .PARAMETER export 
        Convert the certificate and private key from PEM format to PKCS#12 format. On the command line, you are prompted to enter the pass phrase. 
    .PARAMETER certfile 
        Certificate file to be converted from PEM to PKCS#12 format. 
    .PARAMETER keyfile 
        Name of the private key file to be converted from PEM to PKCS#12 format. If the key file is encrypted, you are prompted to enter the pass phrase used for encrypting the key. 
    .PARAMETER password 
        . 
    .PARAMETER pempassphrase 
        .
    .EXAMPLE
        Invoke-ADCConvertSslpkcs12 -outfile <string> -password <string>
    .NOTES
        File Name : Invoke-ADCConvertSslpkcs12
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpkcs12/
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
        [string]$outfile ,

        [boolean]$Import ,

        [string]$pkcs12file ,

        [boolean]$des ,

        [boolean]$des3 ,

        [boolean]$aes256 ,

        [boolean]$export ,

        [string]$certfile ,

        [string]$keyfile ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 31)]
        [string]$password ,

        [ValidateLength(1, 31)]
        [string]$pempassphrase 

    )
    begin {
        Write-Verbose "Invoke-ADCConvertSslpkcs12: Starting"
    }
    process {
        try {
            $Payload = @{
                outfile = $outfile
                password = $password
            }
            if ($PSBoundParameters.ContainsKey('Import')) { $Payload.Add('Import', $Import) }
            if ($PSBoundParameters.ContainsKey('pkcs12file')) { $Payload.Add('pkcs12file', $pkcs12file) }
            if ($PSBoundParameters.ContainsKey('des')) { $Payload.Add('des', $des) }
            if ($PSBoundParameters.ContainsKey('des3')) { $Payload.Add('des3', $des3) }
            if ($PSBoundParameters.ContainsKey('aes256')) { $Payload.Add('aes256', $aes256) }
            if ($PSBoundParameters.ContainsKey('export')) { $Payload.Add('export', $export) }
            if ($PSBoundParameters.ContainsKey('certfile')) { $Payload.Add('certfile', $certfile) }
            if ($PSBoundParameters.ContainsKey('keyfile')) { $Payload.Add('keyfile', $keyfile) }
            if ($PSBoundParameters.ContainsKey('pempassphrase')) { $Payload.Add('pempassphrase', $pempassphrase) }
            if ($PSCmdlet.ShouldProcess($Name, "Convert SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslpkcs12 -Action convert -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCConvertSslpkcs12: Finished"
    }
}

function Invoke-ADCConvertSslpkcs8 {
<#
    .SYNOPSIS
        Convert SSL configuration Object
    .DESCRIPTION
        Convert SSL configuration Object 
    .PARAMETER pkcs8file 
        Name for and, optionally, path to, the output file where the PKCS#8 format key file is stored. /nsconfig/ssl/ is the default path. 
    .PARAMETER keyfile 
        Name of and, optionally, path to the input key file to be converted from PEM or DER format to PKCS#8 format. /nsconfig/ssl/ is the default path. 
    .PARAMETER keyform 
        Format in which the key file is stored on the appliance.  
        Possible values = DER, PEM 
    .PARAMETER password 
        Password to assign to the file if the key is encrypted. Applies only for PEM format files.
    .EXAMPLE
        Invoke-ADCConvertSslpkcs8 -pkcs8file <string> -keyfile <string>
    .NOTES
        File Name : Invoke-ADCConvertSslpkcs8
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpkcs8/
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
        [string]$pkcs8file ,

        [Parameter(Mandatory = $true)]
        [string]$keyfile ,

        [ValidateSet('DER', 'PEM')]
        [string]$keyform ,

        [ValidateLength(1, 31)]
        [string]$password 

    )
    begin {
        Write-Verbose "Invoke-ADCConvertSslpkcs8: Starting"
    }
    process {
        try {
            $Payload = @{
                pkcs8file = $pkcs8file
                keyfile = $keyfile
            }
            if ($PSBoundParameters.ContainsKey('keyform')) { $Payload.Add('keyform', $keyform) }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSCmdlet.ShouldProcess($Name, "Convert SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslpkcs8 -Action convert -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCConvertSslpkcs8: Finished"
    }
}

function Invoke-ADCAddSslpolicy {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER name 
        Name for the new SSL policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER rule 
        Expression, against which traffic is evaluated.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER reqaction 
        The name of the action to be performed on the request. Refer to 'add ssl action' command to add a new action. Builtin actions like NOOP, RESET, DROP, CLIENTAUTH and NOCLIENTAUTH are also allowed.  
        Minimum length = 1 
    .PARAMETER action 
        Name of the built-in or user-defined action to perform on the request. Available built-in actions are NOOP, RESET, DROP, CLIENTAUTH, NOCLIENTAUTH, INTERCEPT AND BYPASS. 
    .PARAMETER undefaction 
        Name of the action to be performed when the result of rule evaluation is undefined. Possible values for control policies: CLIENTAUTH, NOCLIENTAUTH, NOOP, RESET, DROP. Possible values for data policies: NOOP, RESET, DROP and BYPASS. 
    .PARAMETER comment 
        Any comments associated with this policy. 
    .PARAMETER PassThru 
        Return details about the created sslpolicy item.
    .EXAMPLE
        Invoke-ADCAddSslpolicy -name <string> -rule <string>
    .NOTES
        File Name : Invoke-ADCAddSslpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicy/
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
        [string]$rule ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$reqaction ,

        [string]$action ,

        [string]$undefaction ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                rule = $rule
            }
            if ($PSBoundParameters.ContainsKey('reqaction')) { $Payload.Add('reqaction', $reqaction) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("sslpolicy", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslpolicy: Finished"
    }
}

function Invoke-ADCDeleteSslpolicy {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER name 
       Name for the new SSL policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .EXAMPLE
        Invoke-ADCDeleteSslpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicy/
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
        Write-Verbose "Invoke-ADCDeleteSslpolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslpolicy -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslpolicy: Finished"
    }
}

function Invoke-ADCUpdateSslpolicy {
<#
    .SYNOPSIS
        Update SSL configuration Object
    .DESCRIPTION
        Update SSL configuration Object 
    .PARAMETER name 
        Name for the new SSL policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER rule 
        Expression, against which traffic is evaluated.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER action 
        Name of the built-in or user-defined action to perform on the request. Available built-in actions are NOOP, RESET, DROP, CLIENTAUTH, NOCLIENTAUTH, INTERCEPT AND BYPASS. 
    .PARAMETER undefaction 
        Name of the action to be performed when the result of rule evaluation is undefined. Possible values for control policies: CLIENTAUTH, NOCLIENTAUTH, NOOP, RESET, DROP. Possible values for data policies: NOOP, RESET, DROP and BYPASS. 
    .PARAMETER comment 
        Any comments associated with this policy. 
    .PARAMETER PassThru 
        Return details about the created sslpolicy item.
    .EXAMPLE
        Invoke-ADCUpdateSslpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateSslpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicy/
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

        [string]$rule ,

        [string]$action ,

        [string]$undefaction ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSslpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("sslpolicy", "Update SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateSslpolicy: Finished"
    }
}

function Invoke-ADCUnsetSslpolicy {
<#
    .SYNOPSIS
        Unset SSL configuration Object
    .DESCRIPTION
        Unset SSL configuration Object 
   .PARAMETER name 
       Name for the new SSL policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
   .PARAMETER undefaction 
       Name of the action to be performed when the result of rule evaluation is undefined. Possible values for control policies: CLIENTAUTH, NOCLIENTAUTH, NOOP, RESET, DROP. Possible values for data policies: NOOP, RESET, DROP and BYPASS. 
   .PARAMETER comment 
       Any comments associated with this policy.
    .EXAMPLE
        Invoke-ADCUnsetSslpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetSslpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicy
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

        [Boolean]$undefaction ,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSslpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslpolicy -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSslpolicy: Finished"
    }
}

function Invoke-ADCGetSslpolicy {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       Name for the new SSL policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER GetAll 
        Retreive all sslpolicy object(s)
    .PARAMETER Count
        If specified, the count of the sslpolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslpolicy
    .EXAMPLE 
        Invoke-ADCGetSslpolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslpolicy -Count
    .EXAMPLE
        Invoke-ADCGetSslpolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetSslpolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicy/
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
        Write-Verbose "Invoke-ADCGetSslpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslpolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslpolicy: Ended"
    }
}

function Invoke-ADCAddSslpolicylabel {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER labelname 
        Name for the SSL policy label. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy label is created. 
    .PARAMETER type 
        Type of policies that the policy label can contain.  
        Possible values = CONTROL, DATA 
    .PARAMETER PassThru 
        Return details about the created sslpolicylabel item.
    .EXAMPLE
        Invoke-ADCAddSslpolicylabel -labelname <string> -type <string>
    .NOTES
        File Name : Invoke-ADCAddSslpolicylabel
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicylabel/
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
        [string]$labelname ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('CONTROL', 'DATA')]
        [string]$type ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslpolicylabel: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
                type = $type
            }

 
            if ($PSCmdlet.ShouldProcess("sslpolicylabel", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslpolicylabel -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslpolicylabel -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslpolicylabel: Finished"
    }
}

function Invoke-ADCDeleteSslpolicylabel {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER labelname 
       Name for the SSL policy label. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy label is created. 
    .EXAMPLE
        Invoke-ADCDeleteSslpolicylabel -labelname <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslpolicylabel
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicylabel/
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
        [string]$labelname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslpolicylabel: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$labelname", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslpolicylabel -Resource $labelname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslpolicylabel: Finished"
    }
}

function Invoke-ADCGetSslpolicylabel {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER labelname 
       Name for the SSL policy label. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy label is created. 
    .PARAMETER GetAll 
        Retreive all sslpolicylabel object(s)
    .PARAMETER Count
        If specified, the count of the sslpolicylabel object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslpolicylabel
    .EXAMPLE 
        Invoke-ADCGetSslpolicylabel -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslpolicylabel -Count
    .EXAMPLE
        Invoke-ADCGetSslpolicylabel -name <string>
    .EXAMPLE
        Invoke-ADCGetSslpolicylabel -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslpolicylabel
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicylabel/
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
        [string]$labelname,

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
        Write-Verbose "Invoke-ADCGetSslpolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicylabel -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicylabel -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslpolicylabel objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicylabel -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslpolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicylabel -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslpolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicylabel -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslpolicylabel: Ended"
    }
}

function Invoke-ADCGetSslpolicylabelbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER labelname 
       Name of the SSL policy label for which to show detailed information. 
    .PARAMETER GetAll 
        Retreive all sslpolicylabel_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslpolicylabel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslpolicylabelbinding
    .EXAMPLE 
        Invoke-ADCGetSslpolicylabelbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetSslpolicylabelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslpolicylabelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslpolicylabelbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicylabel_binding/
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
        [string]$labelname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicylabel_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicylabel_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslpolicylabel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicylabel_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslpolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicylabel_binding -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicylabel_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslpolicylabelbinding: Ended"
    }
}

function Invoke-ADCAddSslpolicylabelsslpolicybinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER labelname 
        Name of the SSL policy label to which to bind policies. 
    .PARAMETER policyname 
        Name of the SSL policy to bind to the policy label. 
    .PARAMETER priority 
        Specifies the priority of the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER invoke 
        Invoke policies bound to a policy label. After the invoked policies are evaluated, the flow returns to the policy with the next priority. 
    .PARAMETER labeltype 
        Type of policy label invocation.  
        Possible values = vserver, service, policylabel 
    .PARAMETER invoke_labelname 
        Name of the label to invoke if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created sslpolicylabel_sslpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddSslpolicylabelsslpolicybinding -labelname <string> -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddSslpolicylabelsslpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicylabel_sslpolicy_binding/
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
        [string]$labelname ,

        [Parameter(Mandatory = $true)]
        [string]$policyname ,

        [Parameter(Mandatory = $true)]
        [double]$priority ,

        [string]$gotopriorityexpression ,

        [boolean]$invoke ,

        [ValidateSet('vserver', 'service', 'policylabel')]
        [string]$labeltype ,

        [string]$invoke_labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslpolicylabelsslpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
                policyname = $policyname
                priority = $priority
            }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('invoke_labelname')) { $Payload.Add('invoke_labelname', $invoke_labelname) }
 
            if ($PSCmdlet.ShouldProcess("sslpolicylabel_sslpolicy_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslpolicylabel_sslpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslpolicylabelsslpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslpolicylabelsslpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteSslpolicylabelsslpolicybinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER labelname 
       Name of the SSL policy label to which to bind policies.    .PARAMETER policyname 
       Name of the SSL policy to bind to the policy label.    .PARAMETER priority 
       Specifies the priority of the policy.
    .EXAMPLE
        Invoke-ADCDeleteSslpolicylabelsslpolicybinding -labelname <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslpolicylabelsslpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicylabel_sslpolicy_binding/
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
        [string]$labelname ,

        [string]$policyname ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslpolicylabelsslpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$labelname", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslpolicylabel_sslpolicy_binding -Resource $labelname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslpolicylabelsslpolicybinding: Finished"
    }
}

function Invoke-ADCGetSslpolicylabelsslpolicybinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER labelname 
       Name of the SSL policy label to which to bind policies. 
    .PARAMETER GetAll 
        Retreive all sslpolicylabel_sslpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslpolicylabel_sslpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslpolicylabelsslpolicybinding
    .EXAMPLE 
        Invoke-ADCGetSslpolicylabelsslpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslpolicylabelsslpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetSslpolicylabelsslpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslpolicylabelsslpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslpolicylabelsslpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicylabel_sslpolicy_binding/
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
        [string]$labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslpolicylabelsslpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslpolicylabel_sslpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicylabel_sslpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslpolicylabel_sslpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicylabel_sslpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslpolicylabel_sslpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicylabel_sslpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslpolicylabel_sslpolicy_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicylabel_sslpolicy_binding -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslpolicylabel_sslpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicylabel_sslpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslpolicylabelsslpolicybinding: Ended"
    }
}

function Invoke-ADCGetSslpolicybinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       Name of the SSL policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all sslpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslpolicybinding
    .EXAMPLE 
        Invoke-ADCGetSslpolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetSslpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetSslpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslpolicybinding: Ended"
    }
}

function Invoke-ADCGetSslpolicycsvserverbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       Name of the SSL policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all sslpolicy_csvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslpolicy_csvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslpolicycsvserverbinding
    .EXAMPLE 
        Invoke-ADCGetSslpolicycsvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslpolicycsvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetSslpolicycsvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslpolicycsvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslpolicycsvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicy_csvserver_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslpolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_csvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_csvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslpolicy_csvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_csvserver_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_csvserver_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_csvserver_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslpolicycsvserverbinding: Ended"
    }
}

function Invoke-ADCGetSslpolicylbvserverbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       Name of the SSL policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all sslpolicy_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslpolicy_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslpolicylbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetSslpolicylbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslpolicylbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetSslpolicylbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslpolicylbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslpolicylbvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicy_lbvserver_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_lbvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_lbvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslpolicy_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_lbvserver_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_lbvserver_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_lbvserver_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslpolicylbvserverbinding: Ended"
    }
}

function Invoke-ADCGetSslpolicysslglobalbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       Name of the SSL policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all sslpolicy_sslglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslpolicy_sslglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslpolicysslglobalbinding
    .EXAMPLE 
        Invoke-ADCGetSslpolicysslglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslpolicysslglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetSslpolicysslglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslpolicysslglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslpolicysslglobalbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicy_sslglobal_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslpolicysslglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslpolicy_sslglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslglobal_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslpolicy_sslglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslglobal_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslpolicy_sslglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslglobal_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslpolicy_sslglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslglobal_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslpolicy_sslglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslglobal_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslpolicysslglobalbinding: Ended"
    }
}

function Invoke-ADCGetSslpolicysslpolicylabelbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       Name of the SSL policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all sslpolicy_sslpolicylabel_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslpolicy_sslpolicylabel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslpolicysslpolicylabelbinding
    .EXAMPLE 
        Invoke-ADCGetSslpolicysslpolicylabelbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslpolicysslpolicylabelbinding -Count
    .EXAMPLE
        Invoke-ADCGetSslpolicysslpolicylabelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslpolicysslpolicylabelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslpolicysslpolicylabelbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicy_sslpolicylabel_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslpolicysslpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslpolicy_sslpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslpolicylabel_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslpolicy_sslpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslpolicylabel_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslpolicy_sslpolicylabel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslpolicylabel_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslpolicy_sslpolicylabel_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslpolicylabel_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslpolicy_sslpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslpolicylabel_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslpolicysslpolicylabelbinding: Ended"
    }
}

function Invoke-ADCGetSslpolicysslservicebinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       Name of the SSL policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all sslpolicy_sslservice_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslpolicy_sslservice_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslpolicysslservicebinding
    .EXAMPLE 
        Invoke-ADCGetSslpolicysslservicebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslpolicysslservicebinding -Count
    .EXAMPLE
        Invoke-ADCGetSslpolicysslservicebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslpolicysslservicebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslpolicysslservicebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicy_sslservice_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslpolicysslservicebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslpolicy_sslservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslservice_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslpolicy_sslservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslservice_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslpolicy_sslservice_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslservice_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslpolicy_sslservice_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslservice_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslpolicy_sslservice_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslservice_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslpolicysslservicebinding: Ended"
    }
}

function Invoke-ADCGetSslpolicysslvserverbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       Name of the SSL policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all sslpolicy_sslvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslpolicy_sslvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslpolicysslvserverbinding
    .EXAMPLE 
        Invoke-ADCGetSslpolicysslvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslpolicysslvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetSslpolicysslvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslpolicysslvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslpolicysslvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslpolicy_sslvserver_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslpolicysslvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslpolicy_sslvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslpolicy_sslvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslpolicy_sslvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslvserver_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslpolicy_sslvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslvserver_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslpolicy_sslvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslpolicy_sslvserver_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslpolicysslvserverbinding: Ended"
    }
}

function Invoke-ADCAddSslprofile {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER name 
        Name for the SSL profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the profile is created.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER sslprofiletype 
        Type of profile. Front end profiles apply to the entity that receives requests from a client. Backend profiles apply to the entity that sends client requests to a server.  
        Default value: FrontEnd  
        Possible values = BackEnd, FrontEnd 
    .PARAMETER ssllogprofile 
        The name of the ssllogprofile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER dhcount 
        Number of interactions, between the client and the Citrix ADC, after which the DH private-public pair is regenerated. A value of zero (0) specifies infinite use (no refresh).  
        This parameter is not applicable when configuring a backend profile. Allowed DH count values are 0 and >= 500.  
        Minimum value = 0  
        Maximum value = 65534 
    .PARAMETER dh 
        State of Diffie-Hellman (DH) key exchange.  
        This parameter is not applicable when configuring a backend profile.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dhfile 
        The file name and path for the DH parameter.  
        Minimum length = 1 
    .PARAMETER ersa 
        State of Ephemeral RSA (eRSA) key exchange. Ephemeral RSA allows clients that support only export ciphers to communicate with the secure server even if the server certificate does not support export clients. The ephemeral RSA key is automatically generated when you bind an export cipher to an SSL or TCP-based SSL virtual server or service. When you remove the export cipher, the eRSA key is not deleted. It is reused at a later date when another export cipher is bound to an SSL or TCP-based SSL virtual server or service. The eRSA key is deleted when the appliance restarts.  
        This parameter is not applicable when configuring a backend profile.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ersacount 
        The refresh count for the re-generation of RSA public-key and private-key pair.  
        Minimum value = 0  
        Maximum value = 65534 
    .PARAMETER sessreuse 
        State of session reuse. Establishing the initial handshake requires CPU-intensive public key encryption operations. With the ENABLED setting, session key exchange is avoided for session resumption requests received from the client.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sesstimeout 
        The Session timeout value in seconds.  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER cipherredirect 
        State of Cipher Redirect. If this parameter is set to ENABLED, you can configure an SSL virtual server or service to display meaningful error messages if the SSL handshake fails because of a cipher mismatch between the virtual server or service and the client.  
        This parameter is not applicable when configuring a backend profile.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cipherurl 
        The redirect URL to be used with the Cipher Redirect feature. 
    .PARAMETER clientauth 
        State of client authentication. In service-based SSL offload, the service terminates the SSL handshake if the SSL client does not provide a valid certificate.  
        This parameter is not applicable when configuring a backend profile.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER clientcert 
        The rule for client certificate requirement in client authentication.  
        Possible values = Mandatory, Optional 
    .PARAMETER dhkeyexpsizelimit 
        This option enables the use of NIST recommended (NIST Special Publication 800-56A) bit size for private-key size. For example, for DH params of size 2048bit, the private-key size recommended is 224bits. This is rounded-up to 256bits.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sslredirect 
        State of HTTPS redirects for the SSL service.  
        For an SSL session, if the client browser receives a redirect message, the browser tries to connect to the new location. However, the secure SSL session breaks if the object has moved from a secure site (https://) to an unsecure site (http://). Typically, a warning message appears on the screen, prompting the user to continue or disconnect.  
        If SSL Redirect is ENABLED, the redirect message is automatically converted from http:// to https:// and the SSL session does not break.  
        This parameter is not applicable when configuring a backend profile.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER redirectportrewrite 
        State of the port rewrite while performing HTTPS redirect. If this parameter is set to ENABLED, and the URL from the server does not contain the standard port, the port is rewritten to the standard.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ssl3 
        State of SSLv3 protocol support for the SSL profile.  
        Note: On platforms with SSL acceleration chips, if the SSL chip does not support SSLv3, this parameter cannot be set to ENABLED.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls1 
        State of TLSv1.0 protocol support for the SSL profile.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls11 
        State of TLSv1.1 protocol support for the SSL profile.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls12 
        State of TLSv1.2 protocol support for the SSL profile.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls13 
        State of TLSv1.3 protocol support for the SSL profile.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER snienable 
        State of the Server Name Indication (SNI) feature on the virtual server and service-based offload. SNI helps to enable SSL encryption on multiple domains on a single virtual server or service if the domains are controlled by the same organization and share the same second-level domain name. For example, *.sports.net can be used to secure domains such as login.sports.net and help.sports.net.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ocspstapling 
        State of OCSP stapling support on the SSL virtual server. Supported only if the protocol used is higher than SSLv3. Possible values:  
        ENABLED: The appliance sends a request to the OCSP responder to check the status of the server certificate and caches the response for the specified time. If the response is valid at the time of SSL handshake with the client, the OCSP-based server certificate status is sent to the client during the handshake.  
        DISABLED: The appliance does not check the status of the server certificate. .  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER serverauth 
        State of server authentication support for the SSL Backend profile.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER commonname 
        Name to be checked against the CommonName (CN) field in the server certificate bound to the SSL server.  
        Minimum length = 1 
    .PARAMETER pushenctrigger 
        Trigger encryption on the basis of the PUSH flag value. Available settings function as follows:  
        * ALWAYS - Any PUSH packet triggers encryption.  
        * IGNORE - Ignore PUSH packet for triggering encryption.  
        * MERGE - For a consecutive sequence of PUSH packets, the last PUSH packet triggers encryption.  
        * TIMER - PUSH packet triggering encryption is delayed by the time defined in the set ssl parameter command or in the Change Advanced SSL Settings dialog box.  
        Possible values = Always, Merge, Ignore, Timer 
    .PARAMETER sendclosenotify 
        Enable sending SSL Close-Notify at the end of a transaction.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER cleartextport 
        Port on which clear-text data is sent by the appliance to the server. Do not specify this parameter for SSL offloading with end-to-end encryption.  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER insertionencoding 
        Encoding method used to insert the subject or issuer's name in HTTP requests to servers.  
        Default value: Unicode  
        Possible values = Unicode, UTF-8 
    .PARAMETER denysslreneg 
        Deny renegotiation in specified circumstances. Available settings function as follows:  
        * NO - Allow SSL renegotiation.  
        * FRONTEND_CLIENT - Deny secure and nonsecure SSL renegotiation initiated by the client.  
        * FRONTEND_CLIENTSERVER - Deny secure and nonsecure SSL renegotiation initiated by the client or the Citrix ADC during policy-based client authentication.  
        * ALL - Deny all secure and nonsecure SSL renegotiation.  
        * NONSECURE - Deny nonsecure SSL renegotiation. Allows only clients that support RFC 5746.  
        Default value: ALL  
        Possible values = NO, FRONTEND_CLIENT, FRONTEND_CLIENTSERVER, ALL, NONSECURE 
    .PARAMETER quantumsize 
        Amount of data to collect before the data is pushed to the crypto hardware for encryption. For large downloads, a larger quantum size better utilizes the crypto resources.  
        Default value: 8192  
        Possible values = 4096, 8192, 16384 
    .PARAMETER strictcachecks 
        Enable strict CA certificate checks on the appliance.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER encrypttriggerpktcount 
        Maximum number of queued packets after which encryption is triggered. Use this setting for SSL transactions that send small packets from server to Citrix ADC.  
        Default value: 45  
        Minimum value = 10  
        Maximum value = 50 
    .PARAMETER pushflag 
        Insert PUSH flag into decrypted, encrypted, or all records. If the PUSH flag is set to a value other than 0, the buffered records are forwarded on the basis of the value of the PUSH flag. Available settings function as follows:  
        0 - Auto (PUSH flag is not set.)  
        1 - Insert PUSH flag into every decrypted record.  
        2 -Insert PUSH flag into every encrypted record.  
        3 - Insert PUSH flag into every decrypted and encrypted record.  
        Minimum value = 0  
        Maximum value = 3 
    .PARAMETER dropreqwithnohostheader 
        Host header check for SNI enabled sessions. If this check is enabled and the HTTP request does not contain the host header for SNI enabled sessions(i.e vserver or profile bound to vserver has SNI enabled and 'Client Hello' arrived with SNI extension), the request is dropped.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER snihttphostmatch 
        Controls how the HTTP 'Host' header value is validated. These checks are performed only if the session is SNI enabled (i.e when vserver or profile bound to vserver has SNI enabled and 'Client Hello' arrived with SNI extension) and HTTP request contains 'Host' header.  
        Available settings function as follows:  
        CERT - Request is forwarded if the 'Host' value is covered  
        by the certificate used to establish this SSL session.  
        Note: 'CERT' matching mode cannot be applied in  
        TLS 1.3 connections established by resuming from a  
        previous TLS 1.3 session. On these connections, 'STRICT'  
        matching mode will be used instead.  
        STRICT - Request is forwarded only if value of 'Host' header  
        in HTTP is identical to the 'Server name' value passed  
        in 'Client Hello' of the SSL connection.  
        NO - No validation is performed on the HTTP 'Host'  
        header value.  
        Default value: CERT  
        Possible values = NO, CERT, STRICT 
    .PARAMETER pushenctriggertimeout 
        PUSH encryption trigger timeout value. The timeout value is applied only if you set the Push Encryption Trigger parameter to Timer in the SSL virtual server settings.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 200 
    .PARAMETER ssltriggertimeout 
        Time, in milliseconds, after which encryption is triggered for transactions that are not tracked on the Citrix ADC because their length is not known. There can be a delay of up to 10ms from the specified timeout value before the packet is pushed into the queue.  
        Default value: 100  
        Minimum value = 1  
        Maximum value = 200 
    .PARAMETER clientauthuseboundcachain 
        Certficates bound on the VIP are used for validating the client cert. Certficates came along with client cert are not used for validating the client cert.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sslinterception 
        Enable or disable transparent interception of SSL sessions.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sslireneg 
        Enable or disable triggering the client renegotiation when renegotiation request is received from the origin server.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ssliocspcheck 
        Enable or disable OCSP check for origin server certificate.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sslimaxsessperserver 
        Maximum ssl session to be cached per dynamic origin server. A unique ssl session is created for each SNI received from the client on ClientHello and the matching session is used for server session reuse.  
        Default value: 10  
        Minimum value = 1  
        Maximum value = 1000 
    .PARAMETER sessionticket 
        This option enables the use of session tickets, as per the RFC 5077.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sessionticketlifetime 
        This option sets the life time of session tickets issued by NS in secs.  
        Default value: 300  
        Minimum value = 0  
        Maximum value = 172800 
    .PARAMETER sessionticketkeyrefresh 
        This option enables the use of session tickets, as per the RFC 5077.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sessionticketkeydata 
        Session ticket enc/dec key , admin can set it. 
    .PARAMETER sessionkeylifetime 
        This option sets the life time of symm key used to generate session tickets issued by NS in secs.  
        Default value: 3000  
        Minimum value = 600  
        Maximum value = 86400 
    .PARAMETER prevsessionkeylifetime 
        This option sets the life time of symm key used to generate session tickets issued by NS in secs.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 172800 
    .PARAMETER hsts 
        State of HSTS protocol support for the SSL profile. Using HSTS, a server can enforce the use of an HTTPS connection for all communication with a client.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER maxage 
        Set the maximum time, in seconds, in the strict transport security (STS) header during which the client must send only HTTPS requests to the server.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER includesubdomains 
        Enable HSTS for subdomains. If set to Yes, a client must send only HTTPS requests for subdomains.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER preload 
        Flag indicates the consent of the site owner to have their domain preloaded.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER skipclientcertpolicycheck 
        This flag controls the processing of X509 certificate policies. If this option is Enabled, then the policy check in Client authentication will be skipped. This option can be used only when Client Authentication is Enabled and ClientCert is set to Mandatory.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER zerorttearlydata 
        State of TLS 1.3 0-RTT early data support for the SSL Virtual Server. This setting only has an effect if resumption is enabled, as early data cannot be sent along with an initial handshake.  
        Early application data has significantly different security properties - in particular there is no guarantee that the data cannot be replayed.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls13sessionticketsperauthcontext 
        Number of tickets the SSL Virtual Server will issue anytime TLS 1.3 is negotiated, ticket-based resumption is enabled, and either (1) a handshake completes or (2) post-handhsake client auth completes.  
        This value can be increased to enable clients to open multiple parallel connections using a fresh ticket for each connection.  
        No tickets are sent if resumption is disabled.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 10 
    .PARAMETER dhekeyexchangewithpsk 
        Whether or not the SSL Virtual Server will require a DHE key exchange to occur when a PSK is accepted during a TLS 1.3 resumption handshake.  
        A DHE key exchange ensures forward secrecy even in the event that ticket keys are compromised, at the expense of an additional round trip and resources required to carry out the DHE key exchange.  
        If disabled, a DHE key exchange will be performed when a PSK is accepted but only if requested by the client.  
        If enabled, the server will require a DHE key exchange when a PSK is accepted regardless of whether the client supports combined PSK-DHE key exchange. This setting only has an effect when resumption is enabled.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER allowextendedmastersecret 
        When set to YES, attempt to use the TLS Extended Master Secret (EMS, as  
        described in RFC 7627) when negotiating TLS 1.0, TLS 1.1 and TLS 1.2  
        connection parameters. EMS must be supported by both the TLS client and server  
        in order to be enabled during a handshake. This setting applies to both  
        frontend and backend SSL profiles.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER alpnprotocol 
        Protocol to negotiate with client and then send as part of the ALPN extension in the server hello message. Possible values are HTTP1.1, HTTP2 and NONE. Default is none i.e. ALPN extension will not be sent. This parameter is relevant only if ssl connection is handled by the virtual server of type SSL_TCP. This parameter has no effect if TLSv1.3 is negotiated.  
        Default value: NONE  
        Possible values = NONE, HTTP1.1, HTTP2 
    .PARAMETER PassThru 
        Return details about the created sslprofile item.
    .EXAMPLE
        Invoke-ADCAddSslprofile -name <string>
    .NOTES
        File Name : Invoke-ADCAddSslprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [ValidateSet('BackEnd', 'FrontEnd')]
        [string]$sslprofiletype = 'FrontEnd' ,

        [ValidateLength(1, 127)]
        [string]$ssllogprofile ,

        [ValidateRange(0, 65534)]
        [double]$dhcount ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dh = 'DISABLED' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$dhfile ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ersa = 'ENABLED' ,

        [ValidateRange(0, 65534)]
        [double]$ersacount ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessreuse = 'ENABLED' ,

        [ValidateRange(0, 4294967294)]
        [double]$sesstimeout ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cipherredirect = 'DISABLED' ,

        [string]$cipherurl ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$clientauth = 'DISABLED' ,

        [ValidateSet('Mandatory', 'Optional')]
        [string]$clientcert ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dhkeyexpsizelimit = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslredirect = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$redirectportrewrite = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ssl3 = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls1 = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls11 = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls12 = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls13 = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$snienable = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ocspstapling = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$serverauth = 'DISABLED' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$commonname ,

        [ValidateSet('Always', 'Merge', 'Ignore', 'Timer')]
        [string]$pushenctrigger ,

        [ValidateSet('YES', 'NO')]
        [string]$sendclosenotify = 'YES' ,

        [ValidateRange(1, 65535)]
        [int]$cleartextport ,

        [ValidateSet('Unicode', 'UTF-8')]
        [string]$insertionencoding = 'Unicode' ,

        [ValidateSet('NO', 'FRONTEND_CLIENT', 'FRONTEND_CLIENTSERVER', 'ALL', 'NONSECURE')]
        [string]$denysslreneg = 'ALL' ,

        [ValidateSet('4096', '8192', '16384')]
        [string]$quantumsize = '8192' ,

        [ValidateSet('YES', 'NO')]
        [string]$strictcachecks = 'NO' ,

        [ValidateRange(10, 50)]
        [double]$encrypttriggerpktcount = '45' ,

        [ValidateRange(0, 3)]
        [double]$pushflag ,

        [ValidateSet('YES', 'NO')]
        [string]$dropreqwithnohostheader = 'NO' ,

        [ValidateSet('NO', 'CERT', 'STRICT')]
        [string]$snihttphostmatch = 'CERT' ,

        [ValidateRange(1, 200)]
        [double]$pushenctriggertimeout = '1' ,

        [ValidateRange(1, 200)]
        [double]$ssltriggertimeout = '100' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$clientauthuseboundcachain = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslinterception = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslireneg = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ssliocspcheck = 'ENABLED' ,

        [ValidateRange(1, 1000)]
        [double]$sslimaxsessperserver = '10' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessionticket = 'DISABLED' ,

        [ValidateRange(0, 172800)]
        [double]$sessionticketlifetime = '300' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessionticketkeyrefresh = 'ENABLED' ,

        [string]$sessionticketkeydata ,

        [ValidateRange(600, 86400)]
        [double]$sessionkeylifetime = '3000' ,

        [ValidateRange(0, 172800)]
        [double]$prevsessionkeylifetime = '0' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$hsts = 'DISABLED' ,

        [ValidateRange(0, 4294967294)]
        [double]$maxage = '0' ,

        [ValidateSet('YES', 'NO')]
        [string]$includesubdomains = 'NO' ,

        [ValidateSet('YES', 'NO')]
        [string]$preload = 'NO' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$skipclientcertpolicycheck = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$zerorttearlydata = 'DISABLED' ,

        [ValidateRange(1, 10)]
        [double]$tls13sessionticketsperauthcontext = '1' ,

        [ValidateSet('YES', 'NO')]
        [string]$dhekeyexchangewithpsk = 'NO' ,

        [ValidateSet('YES', 'NO')]
        [string]$allowextendedmastersecret = 'NO' ,

        [ValidateSet('NONE', 'HTTP1.1', 'HTTP2')]
        [string]$alpnprotocol = 'NONE' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('sslprofiletype')) { $Payload.Add('sslprofiletype', $sslprofiletype) }
            if ($PSBoundParameters.ContainsKey('ssllogprofile')) { $Payload.Add('ssllogprofile', $ssllogprofile) }
            if ($PSBoundParameters.ContainsKey('dhcount')) { $Payload.Add('dhcount', $dhcount) }
            if ($PSBoundParameters.ContainsKey('dh')) { $Payload.Add('dh', $dh) }
            if ($PSBoundParameters.ContainsKey('dhfile')) { $Payload.Add('dhfile', $dhfile) }
            if ($PSBoundParameters.ContainsKey('ersa')) { $Payload.Add('ersa', $ersa) }
            if ($PSBoundParameters.ContainsKey('ersacount')) { $Payload.Add('ersacount', $ersacount) }
            if ($PSBoundParameters.ContainsKey('sessreuse')) { $Payload.Add('sessreuse', $sessreuse) }
            if ($PSBoundParameters.ContainsKey('sesstimeout')) { $Payload.Add('sesstimeout', $sesstimeout) }
            if ($PSBoundParameters.ContainsKey('cipherredirect')) { $Payload.Add('cipherredirect', $cipherredirect) }
            if ($PSBoundParameters.ContainsKey('cipherurl')) { $Payload.Add('cipherurl', $cipherurl) }
            if ($PSBoundParameters.ContainsKey('clientauth')) { $Payload.Add('clientauth', $clientauth) }
            if ($PSBoundParameters.ContainsKey('clientcert')) { $Payload.Add('clientcert', $clientcert) }
            if ($PSBoundParameters.ContainsKey('dhkeyexpsizelimit')) { $Payload.Add('dhkeyexpsizelimit', $dhkeyexpsizelimit) }
            if ($PSBoundParameters.ContainsKey('sslredirect')) { $Payload.Add('sslredirect', $sslredirect) }
            if ($PSBoundParameters.ContainsKey('redirectportrewrite')) { $Payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ($PSBoundParameters.ContainsKey('ssl3')) { $Payload.Add('ssl3', $ssl3) }
            if ($PSBoundParameters.ContainsKey('tls1')) { $Payload.Add('tls1', $tls1) }
            if ($PSBoundParameters.ContainsKey('tls11')) { $Payload.Add('tls11', $tls11) }
            if ($PSBoundParameters.ContainsKey('tls12')) { $Payload.Add('tls12', $tls12) }
            if ($PSBoundParameters.ContainsKey('tls13')) { $Payload.Add('tls13', $tls13) }
            if ($PSBoundParameters.ContainsKey('snienable')) { $Payload.Add('snienable', $snienable) }
            if ($PSBoundParameters.ContainsKey('ocspstapling')) { $Payload.Add('ocspstapling', $ocspstapling) }
            if ($PSBoundParameters.ContainsKey('serverauth')) { $Payload.Add('serverauth', $serverauth) }
            if ($PSBoundParameters.ContainsKey('commonname')) { $Payload.Add('commonname', $commonname) }
            if ($PSBoundParameters.ContainsKey('pushenctrigger')) { $Payload.Add('pushenctrigger', $pushenctrigger) }
            if ($PSBoundParameters.ContainsKey('sendclosenotify')) { $Payload.Add('sendclosenotify', $sendclosenotify) }
            if ($PSBoundParameters.ContainsKey('cleartextport')) { $Payload.Add('cleartextport', $cleartextport) }
            if ($PSBoundParameters.ContainsKey('insertionencoding')) { $Payload.Add('insertionencoding', $insertionencoding) }
            if ($PSBoundParameters.ContainsKey('denysslreneg')) { $Payload.Add('denysslreneg', $denysslreneg) }
            if ($PSBoundParameters.ContainsKey('quantumsize')) { $Payload.Add('quantumsize', $quantumsize) }
            if ($PSBoundParameters.ContainsKey('strictcachecks')) { $Payload.Add('strictcachecks', $strictcachecks) }
            if ($PSBoundParameters.ContainsKey('encrypttriggerpktcount')) { $Payload.Add('encrypttriggerpktcount', $encrypttriggerpktcount) }
            if ($PSBoundParameters.ContainsKey('pushflag')) { $Payload.Add('pushflag', $pushflag) }
            if ($PSBoundParameters.ContainsKey('dropreqwithnohostheader')) { $Payload.Add('dropreqwithnohostheader', $dropreqwithnohostheader) }
            if ($PSBoundParameters.ContainsKey('snihttphostmatch')) { $Payload.Add('snihttphostmatch', $snihttphostmatch) }
            if ($PSBoundParameters.ContainsKey('pushenctriggertimeout')) { $Payload.Add('pushenctriggertimeout', $pushenctriggertimeout) }
            if ($PSBoundParameters.ContainsKey('ssltriggertimeout')) { $Payload.Add('ssltriggertimeout', $ssltriggertimeout) }
            if ($PSBoundParameters.ContainsKey('clientauthuseboundcachain')) { $Payload.Add('clientauthuseboundcachain', $clientauthuseboundcachain) }
            if ($PSBoundParameters.ContainsKey('sslinterception')) { $Payload.Add('sslinterception', $sslinterception) }
            if ($PSBoundParameters.ContainsKey('sslireneg')) { $Payload.Add('sslireneg', $sslireneg) }
            if ($PSBoundParameters.ContainsKey('ssliocspcheck')) { $Payload.Add('ssliocspcheck', $ssliocspcheck) }
            if ($PSBoundParameters.ContainsKey('sslimaxsessperserver')) { $Payload.Add('sslimaxsessperserver', $sslimaxsessperserver) }
            if ($PSBoundParameters.ContainsKey('sessionticket')) { $Payload.Add('sessionticket', $sessionticket) }
            if ($PSBoundParameters.ContainsKey('sessionticketlifetime')) { $Payload.Add('sessionticketlifetime', $sessionticketlifetime) }
            if ($PSBoundParameters.ContainsKey('sessionticketkeyrefresh')) { $Payload.Add('sessionticketkeyrefresh', $sessionticketkeyrefresh) }
            if ($PSBoundParameters.ContainsKey('sessionticketkeydata')) { $Payload.Add('sessionticketkeydata', $sessionticketkeydata) }
            if ($PSBoundParameters.ContainsKey('sessionkeylifetime')) { $Payload.Add('sessionkeylifetime', $sessionkeylifetime) }
            if ($PSBoundParameters.ContainsKey('prevsessionkeylifetime')) { $Payload.Add('prevsessionkeylifetime', $prevsessionkeylifetime) }
            if ($PSBoundParameters.ContainsKey('hsts')) { $Payload.Add('hsts', $hsts) }
            if ($PSBoundParameters.ContainsKey('maxage')) { $Payload.Add('maxage', $maxage) }
            if ($PSBoundParameters.ContainsKey('includesubdomains')) { $Payload.Add('includesubdomains', $includesubdomains) }
            if ($PSBoundParameters.ContainsKey('preload')) { $Payload.Add('preload', $preload) }
            if ($PSBoundParameters.ContainsKey('skipclientcertpolicycheck')) { $Payload.Add('skipclientcertpolicycheck', $skipclientcertpolicycheck) }
            if ($PSBoundParameters.ContainsKey('zerorttearlydata')) { $Payload.Add('zerorttearlydata', $zerorttearlydata) }
            if ($PSBoundParameters.ContainsKey('tls13sessionticketsperauthcontext')) { $Payload.Add('tls13sessionticketsperauthcontext', $tls13sessionticketsperauthcontext) }
            if ($PSBoundParameters.ContainsKey('dhekeyexchangewithpsk')) { $Payload.Add('dhekeyexchangewithpsk', $dhekeyexchangewithpsk) }
            if ($PSBoundParameters.ContainsKey('allowextendedmastersecret')) { $Payload.Add('allowextendedmastersecret', $allowextendedmastersecret) }
            if ($PSBoundParameters.ContainsKey('alpnprotocol')) { $Payload.Add('alpnprotocol', $alpnprotocol) }
 
            if ($PSCmdlet.ShouldProcess("sslprofile", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslprofile: Finished"
    }
}

function Invoke-ADCDeleteSslprofile {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER name 
       Name for the SSL profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the profile is created.  
       Minimum length = 1  
       Maximum length = 127 
    .EXAMPLE
        Invoke-ADCDeleteSslprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile/
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
        Write-Verbose "Invoke-ADCDeleteSslprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslprofile -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslprofile: Finished"
    }
}

function Invoke-ADCUpdateSslprofile {
<#
    .SYNOPSIS
        Update SSL configuration Object
    .DESCRIPTION
        Update SSL configuration Object 
    .PARAMETER name 
        Name for the SSL profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the profile is created.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER ssllogprofile 
        The name of the ssllogprofile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER dh 
        State of Diffie-Hellman (DH) key exchange.  
        This parameter is not applicable when configuring a backend profile.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dhfile 
        The file name and path for the DH parameter.  
        Minimum length = 1 
    .PARAMETER dhcount 
        Number of interactions, between the client and the Citrix ADC, after which the DH private-public pair is regenerated. A value of zero (0) specifies infinite use (no refresh).  
        This parameter is not applicable when configuring a backend profile. Allowed DH count values are 0 and >= 500.  
        Minimum value = 0  
        Maximum value = 65534 
    .PARAMETER dhkeyexpsizelimit 
        This option enables the use of NIST recommended (NIST Special Publication 800-56A) bit size for private-key size. For example, for DH params of size 2048bit, the private-key size recommended is 224bits. This is rounded-up to 256bits.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ersa 
        State of Ephemeral RSA (eRSA) key exchange. Ephemeral RSA allows clients that support only export ciphers to communicate with the secure server even if the server certificate does not support export clients. The ephemeral RSA key is automatically generated when you bind an export cipher to an SSL or TCP-based SSL virtual server or service. When you remove the export cipher, the eRSA key is not deleted. It is reused at a later date when another export cipher is bound to an SSL or TCP-based SSL virtual server or service. The eRSA key is deleted when the appliance restarts.  
        This parameter is not applicable when configuring a backend profile.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ersacount 
        The refresh count for the re-generation of RSA public-key and private-key pair.  
        Minimum value = 0  
        Maximum value = 65534 
    .PARAMETER sessreuse 
        State of session reuse. Establishing the initial handshake requires CPU-intensive public key encryption operations. With the ENABLED setting, session key exchange is avoided for session resumption requests received from the client.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sesstimeout 
        The Session timeout value in seconds.  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER cipherredirect 
        State of Cipher Redirect. If this parameter is set to ENABLED, you can configure an SSL virtual server or service to display meaningful error messages if the SSL handshake fails because of a cipher mismatch between the virtual server or service and the client.  
        This parameter is not applicable when configuring a backend profile.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cipherurl 
        The redirect URL to be used with the Cipher Redirect feature. 
    .PARAMETER clientauth 
        State of client authentication. In service-based SSL offload, the service terminates the SSL handshake if the SSL client does not provide a valid certificate.  
        This parameter is not applicable when configuring a backend profile.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER clientcert 
        The rule for client certificate requirement in client authentication.  
        Possible values = Mandatory, Optional 
    .PARAMETER sslredirect 
        State of HTTPS redirects for the SSL service.  
        For an SSL session, if the client browser receives a redirect message, the browser tries to connect to the new location. However, the secure SSL session breaks if the object has moved from a secure site (https://) to an unsecure site (http://). Typically, a warning message appears on the screen, prompting the user to continue or disconnect.  
        If SSL Redirect is ENABLED, the redirect message is automatically converted from http:// to https:// and the SSL session does not break.  
        This parameter is not applicable when configuring a backend profile.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER redirectportrewrite 
        State of the port rewrite while performing HTTPS redirect. If this parameter is set to ENABLED, and the URL from the server does not contain the standard port, the port is rewritten to the standard.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ssl3 
        State of SSLv3 protocol support for the SSL profile.  
        Note: On platforms with SSL acceleration chips, if the SSL chip does not support SSLv3, this parameter cannot be set to ENABLED.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls1 
        State of TLSv1.0 protocol support for the SSL profile.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls11 
        State of TLSv1.1 protocol support for the SSL profile.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls12 
        State of TLSv1.2 protocol support for the SSL profile.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls13 
        State of TLSv1.3 protocol support for the SSL profile.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER snienable 
        State of the Server Name Indication (SNI) feature on the virtual server and service-based offload. SNI helps to enable SSL encryption on multiple domains on a single virtual server or service if the domains are controlled by the same organization and share the same second-level domain name. For example, *.sports.net can be used to secure domains such as login.sports.net and help.sports.net.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ocspstapling 
        State of OCSP stapling support on the SSL virtual server. Supported only if the protocol used is higher than SSLv3. Possible values:  
        ENABLED: The appliance sends a request to the OCSP responder to check the status of the server certificate and caches the response for the specified time. If the response is valid at the time of SSL handshake with the client, the OCSP-based server certificate status is sent to the client during the handshake.  
        DISABLED: The appliance does not check the status of the server certificate. .  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER serverauth 
        State of server authentication support for the SSL Backend profile.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER commonname 
        Name to be checked against the CommonName (CN) field in the server certificate bound to the SSL server.  
        Minimum length = 1 
    .PARAMETER pushenctrigger 
        Trigger encryption on the basis of the PUSH flag value. Available settings function as follows:  
        * ALWAYS - Any PUSH packet triggers encryption.  
        * IGNORE - Ignore PUSH packet for triggering encryption.  
        * MERGE - For a consecutive sequence of PUSH packets, the last PUSH packet triggers encryption.  
        * TIMER - PUSH packet triggering encryption is delayed by the time defined in the set ssl parameter command or in the Change Advanced SSL Settings dialog box.  
        Possible values = Always, Merge, Ignore, Timer 
    .PARAMETER sendclosenotify 
        Enable sending SSL Close-Notify at the end of a transaction.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER cleartextport 
        Port on which clear-text data is sent by the appliance to the server. Do not specify this parameter for SSL offloading with end-to-end encryption.  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER insertionencoding 
        Encoding method used to insert the subject or issuer's name in HTTP requests to servers.  
        Default value: Unicode  
        Possible values = Unicode, UTF-8 
    .PARAMETER denysslreneg 
        Deny renegotiation in specified circumstances. Available settings function as follows:  
        * NO - Allow SSL renegotiation.  
        * FRONTEND_CLIENT - Deny secure and nonsecure SSL renegotiation initiated by the client.  
        * FRONTEND_CLIENTSERVER - Deny secure and nonsecure SSL renegotiation initiated by the client or the Citrix ADC during policy-based client authentication.  
        * ALL - Deny all secure and nonsecure SSL renegotiation.  
        * NONSECURE - Deny nonsecure SSL renegotiation. Allows only clients that support RFC 5746.  
        Default value: ALL  
        Possible values = NO, FRONTEND_CLIENT, FRONTEND_CLIENTSERVER, ALL, NONSECURE 
    .PARAMETER quantumsize 
        Amount of data to collect before the data is pushed to the crypto hardware for encryption. For large downloads, a larger quantum size better utilizes the crypto resources.  
        Default value: 8192  
        Possible values = 4096, 8192, 16384 
    .PARAMETER strictcachecks 
        Enable strict CA certificate checks on the appliance.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER encrypttriggerpktcount 
        Maximum number of queued packets after which encryption is triggered. Use this setting for SSL transactions that send small packets from server to Citrix ADC.  
        Default value: 45  
        Minimum value = 10  
        Maximum value = 50 
    .PARAMETER pushflag 
        Insert PUSH flag into decrypted, encrypted, or all records. If the PUSH flag is set to a value other than 0, the buffered records are forwarded on the basis of the value of the PUSH flag. Available settings function as follows:  
        0 - Auto (PUSH flag is not set.)  
        1 - Insert PUSH flag into every decrypted record.  
        2 -Insert PUSH flag into every encrypted record.  
        3 - Insert PUSH flag into every decrypted and encrypted record.  
        Minimum value = 0  
        Maximum value = 3 
    .PARAMETER dropreqwithnohostheader 
        Host header check for SNI enabled sessions. If this check is enabled and the HTTP request does not contain the host header for SNI enabled sessions(i.e vserver or profile bound to vserver has SNI enabled and 'Client Hello' arrived with SNI extension), the request is dropped.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER snihttphostmatch 
        Controls how the HTTP 'Host' header value is validated. These checks are performed only if the session is SNI enabled (i.e when vserver or profile bound to vserver has SNI enabled and 'Client Hello' arrived with SNI extension) and HTTP request contains 'Host' header.  
        Available settings function as follows:  
        CERT - Request is forwarded if the 'Host' value is covered  
        by the certificate used to establish this SSL session.  
        Note: 'CERT' matching mode cannot be applied in  
        TLS 1.3 connections established by resuming from a  
        previous TLS 1.3 session. On these connections, 'STRICT'  
        matching mode will be used instead.  
        STRICT - Request is forwarded only if value of 'Host' header  
        in HTTP is identical to the 'Server name' value passed  
        in 'Client Hello' of the SSL connection.  
        NO - No validation is performed on the HTTP 'Host'  
        header value.  
        Default value: CERT  
        Possible values = NO, CERT, STRICT 
    .PARAMETER pushenctriggertimeout 
        PUSH encryption trigger timeout value. The timeout value is applied only if you set the Push Encryption Trigger parameter to Timer in the SSL virtual server settings.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 200 
    .PARAMETER ssltriggertimeout 
        Time, in milliseconds, after which encryption is triggered for transactions that are not tracked on the Citrix ADC because their length is not known. There can be a delay of up to 10ms from the specified timeout value before the packet is pushed into the queue.  
        Default value: 100  
        Minimum value = 1  
        Maximum value = 200 
    .PARAMETER clientauthuseboundcachain 
        Certficates bound on the VIP are used for validating the client cert. Certficates came along with client cert are not used for validating the client cert.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sslinterception 
        Enable or disable transparent interception of SSL sessions.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sslireneg 
        Enable or disable triggering the client renegotiation when renegotiation request is received from the origin server.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ssliocspcheck 
        Enable or disable OCSP check for origin server certificate.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sslimaxsessperserver 
        Maximum ssl session to be cached per dynamic origin server. A unique ssl session is created for each SNI received from the client on ClientHello and the matching session is used for server session reuse.  
        Default value: 10  
        Minimum value = 1  
        Maximum value = 1000 
    .PARAMETER hsts 
        State of HSTS protocol support for the SSL profile. Using HSTS, a server can enforce the use of an HTTPS connection for all communication with a client.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER maxage 
        Set the maximum time, in seconds, in the strict transport security (STS) header during which the client must send only HTTPS requests to the server.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER includesubdomains 
        Enable HSTS for subdomains. If set to Yes, a client must send only HTTPS requests for subdomains.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER preload 
        Flag indicates the consent of the site owner to have their domain preloaded.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER sessionticket 
        This option enables the use of session tickets, as per the RFC 5077.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sessionticketlifetime 
        This option sets the life time of session tickets issued by NS in secs.  
        Default value: 300  
        Minimum value = 0  
        Maximum value = 172800 
    .PARAMETER sessionticketkeyrefresh 
        This option enables the use of session tickets, as per the RFC 5077.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sessionticketkeydata 
        Session ticket enc/dec key , admin can set it. 
    .PARAMETER sessionkeylifetime 
        This option sets the life time of symm key used to generate session tickets issued by NS in secs.  
        Default value: 3000  
        Minimum value = 600  
        Maximum value = 86400 
    .PARAMETER prevsessionkeylifetime 
        This option sets the life time of symm key used to generate session tickets issued by NS in secs.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 172800 
    .PARAMETER ciphername 
        The cipher group/alias/individual cipher configuration. 
    .PARAMETER cipherpriority 
        cipher priority.  
        Minimum value = 1 
    .PARAMETER strictsigdigestcheck 
        Parameter indicating to check whether peer entity certificate during TLS1.2 handshake is signed with one of signature-hash combination supported by Citrix ADC.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER skipclientcertpolicycheck 
        This flag controls the processing of X509 certificate policies. If this option is Enabled, then the policy check in Client authentication will be skipped. This option can be used only when Client Authentication is Enabled and ClientCert is set to Mandatory.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER zerorttearlydata 
        State of TLS 1.3 0-RTT early data support for the SSL Virtual Server. This setting only has an effect if resumption is enabled, as early data cannot be sent along with an initial handshake.  
        Early application data has significantly different security properties - in particular there is no guarantee that the data cannot be replayed.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls13sessionticketsperauthcontext 
        Number of tickets the SSL Virtual Server will issue anytime TLS 1.3 is negotiated, ticket-based resumption is enabled, and either (1) a handshake completes or (2) post-handhsake client auth completes.  
        This value can be increased to enable clients to open multiple parallel connections using a fresh ticket for each connection.  
        No tickets are sent if resumption is disabled.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 10 
    .PARAMETER dhekeyexchangewithpsk 
        Whether or not the SSL Virtual Server will require a DHE key exchange to occur when a PSK is accepted during a TLS 1.3 resumption handshake.  
        A DHE key exchange ensures forward secrecy even in the event that ticket keys are compromised, at the expense of an additional round trip and resources required to carry out the DHE key exchange.  
        If disabled, a DHE key exchange will be performed when a PSK is accepted but only if requested by the client.  
        If enabled, the server will require a DHE key exchange when a PSK is accepted regardless of whether the client supports combined PSK-DHE key exchange. This setting only has an effect when resumption is enabled.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER allowextendedmastersecret 
        When set to YES, attempt to use the TLS Extended Master Secret (EMS, as  
        described in RFC 7627) when negotiating TLS 1.0, TLS 1.1 and TLS 1.2  
        connection parameters. EMS must be supported by both the TLS client and server  
        in order to be enabled during a handshake. This setting applies to both  
        frontend and backend SSL profiles.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER alpnprotocol 
        Protocol to negotiate with client and then send as part of the ALPN extension in the server hello message. Possible values are HTTP1.1, HTTP2 and NONE. Default is none i.e. ALPN extension will not be sent. This parameter is relevant only if ssl connection is handled by the virtual server of type SSL_TCP. This parameter has no effect if TLSv1.3 is negotiated.  
        Default value: NONE  
        Possible values = NONE, HTTP1.1, HTTP2 
    .PARAMETER PassThru 
        Return details about the created sslprofile item.
    .EXAMPLE
        Invoke-ADCUpdateSslprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateSslprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [ValidateLength(1, 127)]
        [string]$ssllogprofile ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dh ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$dhfile ,

        [ValidateRange(0, 65534)]
        [double]$dhcount ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dhkeyexpsizelimit ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ersa ,

        [ValidateRange(0, 65534)]
        [double]$ersacount ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessreuse ,

        [ValidateRange(0, 4294967294)]
        [double]$sesstimeout ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cipherredirect ,

        [string]$cipherurl ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$clientauth ,

        [ValidateSet('Mandatory', 'Optional')]
        [string]$clientcert ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslredirect ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$redirectportrewrite ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ssl3 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls1 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls11 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls12 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls13 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$snienable ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ocspstapling ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$serverauth ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$commonname ,

        [ValidateSet('Always', 'Merge', 'Ignore', 'Timer')]
        [string]$pushenctrigger ,

        [ValidateSet('YES', 'NO')]
        [string]$sendclosenotify ,

        [ValidateRange(1, 65535)]
        [int]$cleartextport ,

        [ValidateSet('Unicode', 'UTF-8')]
        [string]$insertionencoding ,

        [ValidateSet('NO', 'FRONTEND_CLIENT', 'FRONTEND_CLIENTSERVER', 'ALL', 'NONSECURE')]
        [string]$denysslreneg ,

        [ValidateSet('4096', '8192', '16384')]
        [string]$quantumsize ,

        [ValidateSet('YES', 'NO')]
        [string]$strictcachecks ,

        [ValidateRange(10, 50)]
        [double]$encrypttriggerpktcount ,

        [ValidateRange(0, 3)]
        [double]$pushflag ,

        [ValidateSet('YES', 'NO')]
        [string]$dropreqwithnohostheader ,

        [ValidateSet('NO', 'CERT', 'STRICT')]
        [string]$snihttphostmatch ,

        [ValidateRange(1, 200)]
        [double]$pushenctriggertimeout ,

        [ValidateRange(1, 200)]
        [double]$ssltriggertimeout ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$clientauthuseboundcachain ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslinterception ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslireneg ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ssliocspcheck ,

        [ValidateRange(1, 1000)]
        [double]$sslimaxsessperserver ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$hsts ,

        [ValidateRange(0, 4294967294)]
        [double]$maxage ,

        [ValidateSet('YES', 'NO')]
        [string]$includesubdomains ,

        [ValidateSet('YES', 'NO')]
        [string]$preload ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessionticket ,

        [ValidateRange(0, 172800)]
        [double]$sessionticketlifetime ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessionticketkeyrefresh ,

        [string]$sessionticketkeydata ,

        [ValidateRange(600, 86400)]
        [double]$sessionkeylifetime ,

        [ValidateRange(0, 172800)]
        [double]$prevsessionkeylifetime ,

        [string]$ciphername ,

        [double]$cipherpriority ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$strictsigdigestcheck ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$skipclientcertpolicycheck ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$zerorttearlydata ,

        [ValidateRange(1, 10)]
        [double]$tls13sessionticketsperauthcontext ,

        [ValidateSet('YES', 'NO')]
        [string]$dhekeyexchangewithpsk ,

        [ValidateSet('YES', 'NO')]
        [string]$allowextendedmastersecret ,

        [ValidateSet('NONE', 'HTTP1.1', 'HTTP2')]
        [string]$alpnprotocol ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSslprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ssllogprofile')) { $Payload.Add('ssllogprofile', $ssllogprofile) }
            if ($PSBoundParameters.ContainsKey('dh')) { $Payload.Add('dh', $dh) }
            if ($PSBoundParameters.ContainsKey('dhfile')) { $Payload.Add('dhfile', $dhfile) }
            if ($PSBoundParameters.ContainsKey('dhcount')) { $Payload.Add('dhcount', $dhcount) }
            if ($PSBoundParameters.ContainsKey('dhkeyexpsizelimit')) { $Payload.Add('dhkeyexpsizelimit', $dhkeyexpsizelimit) }
            if ($PSBoundParameters.ContainsKey('ersa')) { $Payload.Add('ersa', $ersa) }
            if ($PSBoundParameters.ContainsKey('ersacount')) { $Payload.Add('ersacount', $ersacount) }
            if ($PSBoundParameters.ContainsKey('sessreuse')) { $Payload.Add('sessreuse', $sessreuse) }
            if ($PSBoundParameters.ContainsKey('sesstimeout')) { $Payload.Add('sesstimeout', $sesstimeout) }
            if ($PSBoundParameters.ContainsKey('cipherredirect')) { $Payload.Add('cipherredirect', $cipherredirect) }
            if ($PSBoundParameters.ContainsKey('cipherurl')) { $Payload.Add('cipherurl', $cipherurl) }
            if ($PSBoundParameters.ContainsKey('clientauth')) { $Payload.Add('clientauth', $clientauth) }
            if ($PSBoundParameters.ContainsKey('clientcert')) { $Payload.Add('clientcert', $clientcert) }
            if ($PSBoundParameters.ContainsKey('sslredirect')) { $Payload.Add('sslredirect', $sslredirect) }
            if ($PSBoundParameters.ContainsKey('redirectportrewrite')) { $Payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ($PSBoundParameters.ContainsKey('ssl3')) { $Payload.Add('ssl3', $ssl3) }
            if ($PSBoundParameters.ContainsKey('tls1')) { $Payload.Add('tls1', $tls1) }
            if ($PSBoundParameters.ContainsKey('tls11')) { $Payload.Add('tls11', $tls11) }
            if ($PSBoundParameters.ContainsKey('tls12')) { $Payload.Add('tls12', $tls12) }
            if ($PSBoundParameters.ContainsKey('tls13')) { $Payload.Add('tls13', $tls13) }
            if ($PSBoundParameters.ContainsKey('snienable')) { $Payload.Add('snienable', $snienable) }
            if ($PSBoundParameters.ContainsKey('ocspstapling')) { $Payload.Add('ocspstapling', $ocspstapling) }
            if ($PSBoundParameters.ContainsKey('serverauth')) { $Payload.Add('serverauth', $serverauth) }
            if ($PSBoundParameters.ContainsKey('commonname')) { $Payload.Add('commonname', $commonname) }
            if ($PSBoundParameters.ContainsKey('pushenctrigger')) { $Payload.Add('pushenctrigger', $pushenctrigger) }
            if ($PSBoundParameters.ContainsKey('sendclosenotify')) { $Payload.Add('sendclosenotify', $sendclosenotify) }
            if ($PSBoundParameters.ContainsKey('cleartextport')) { $Payload.Add('cleartextport', $cleartextport) }
            if ($PSBoundParameters.ContainsKey('insertionencoding')) { $Payload.Add('insertionencoding', $insertionencoding) }
            if ($PSBoundParameters.ContainsKey('denysslreneg')) { $Payload.Add('denysslreneg', $denysslreneg) }
            if ($PSBoundParameters.ContainsKey('quantumsize')) { $Payload.Add('quantumsize', $quantumsize) }
            if ($PSBoundParameters.ContainsKey('strictcachecks')) { $Payload.Add('strictcachecks', $strictcachecks) }
            if ($PSBoundParameters.ContainsKey('encrypttriggerpktcount')) { $Payload.Add('encrypttriggerpktcount', $encrypttriggerpktcount) }
            if ($PSBoundParameters.ContainsKey('pushflag')) { $Payload.Add('pushflag', $pushflag) }
            if ($PSBoundParameters.ContainsKey('dropreqwithnohostheader')) { $Payload.Add('dropreqwithnohostheader', $dropreqwithnohostheader) }
            if ($PSBoundParameters.ContainsKey('snihttphostmatch')) { $Payload.Add('snihttphostmatch', $snihttphostmatch) }
            if ($PSBoundParameters.ContainsKey('pushenctriggertimeout')) { $Payload.Add('pushenctriggertimeout', $pushenctriggertimeout) }
            if ($PSBoundParameters.ContainsKey('ssltriggertimeout')) { $Payload.Add('ssltriggertimeout', $ssltriggertimeout) }
            if ($PSBoundParameters.ContainsKey('clientauthuseboundcachain')) { $Payload.Add('clientauthuseboundcachain', $clientauthuseboundcachain) }
            if ($PSBoundParameters.ContainsKey('sslinterception')) { $Payload.Add('sslinterception', $sslinterception) }
            if ($PSBoundParameters.ContainsKey('sslireneg')) { $Payload.Add('sslireneg', $sslireneg) }
            if ($PSBoundParameters.ContainsKey('ssliocspcheck')) { $Payload.Add('ssliocspcheck', $ssliocspcheck) }
            if ($PSBoundParameters.ContainsKey('sslimaxsessperserver')) { $Payload.Add('sslimaxsessperserver', $sslimaxsessperserver) }
            if ($PSBoundParameters.ContainsKey('hsts')) { $Payload.Add('hsts', $hsts) }
            if ($PSBoundParameters.ContainsKey('maxage')) { $Payload.Add('maxage', $maxage) }
            if ($PSBoundParameters.ContainsKey('includesubdomains')) { $Payload.Add('includesubdomains', $includesubdomains) }
            if ($PSBoundParameters.ContainsKey('preload')) { $Payload.Add('preload', $preload) }
            if ($PSBoundParameters.ContainsKey('sessionticket')) { $Payload.Add('sessionticket', $sessionticket) }
            if ($PSBoundParameters.ContainsKey('sessionticketlifetime')) { $Payload.Add('sessionticketlifetime', $sessionticketlifetime) }
            if ($PSBoundParameters.ContainsKey('sessionticketkeyrefresh')) { $Payload.Add('sessionticketkeyrefresh', $sessionticketkeyrefresh) }
            if ($PSBoundParameters.ContainsKey('sessionticketkeydata')) { $Payload.Add('sessionticketkeydata', $sessionticketkeydata) }
            if ($PSBoundParameters.ContainsKey('sessionkeylifetime')) { $Payload.Add('sessionkeylifetime', $sessionkeylifetime) }
            if ($PSBoundParameters.ContainsKey('prevsessionkeylifetime')) { $Payload.Add('prevsessionkeylifetime', $prevsessionkeylifetime) }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Payload.Add('ciphername', $ciphername) }
            if ($PSBoundParameters.ContainsKey('cipherpriority')) { $Payload.Add('cipherpriority', $cipherpriority) }
            if ($PSBoundParameters.ContainsKey('strictsigdigestcheck')) { $Payload.Add('strictsigdigestcheck', $strictsigdigestcheck) }
            if ($PSBoundParameters.ContainsKey('skipclientcertpolicycheck')) { $Payload.Add('skipclientcertpolicycheck', $skipclientcertpolicycheck) }
            if ($PSBoundParameters.ContainsKey('zerorttearlydata')) { $Payload.Add('zerorttearlydata', $zerorttearlydata) }
            if ($PSBoundParameters.ContainsKey('tls13sessionticketsperauthcontext')) { $Payload.Add('tls13sessionticketsperauthcontext', $tls13sessionticketsperauthcontext) }
            if ($PSBoundParameters.ContainsKey('dhekeyexchangewithpsk')) { $Payload.Add('dhekeyexchangewithpsk', $dhekeyexchangewithpsk) }
            if ($PSBoundParameters.ContainsKey('allowextendedmastersecret')) { $Payload.Add('allowextendedmastersecret', $allowextendedmastersecret) }
            if ($PSBoundParameters.ContainsKey('alpnprotocol')) { $Payload.Add('alpnprotocol', $alpnprotocol) }
 
            if ($PSCmdlet.ShouldProcess("sslprofile", "Update SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateSslprofile: Finished"
    }
}

function Invoke-ADCUnsetSslprofile {
<#
    .SYNOPSIS
        Unset SSL configuration Object
    .DESCRIPTION
        Unset SSL configuration Object 
   .PARAMETER name 
       Name for the SSL profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the profile is created. 
   .PARAMETER ssllogprofile 
       The name of the ssllogprofile. 
   .PARAMETER dh 
       State of Diffie-Hellman (DH) key exchange.  
       This parameter is not applicable when configuring a backend profile.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER dhfile 
       The file name and path for the DH parameter. 
   .PARAMETER dhcount 
       Number of interactions, between the client and the Citrix ADC, after which the DH private-public pair is regenerated. A value of zero (0) specifies infinite use (no refresh).  
       This parameter is not applicable when configuring a backend profile. Allowed DH count values are 0 and >= 500. 
   .PARAMETER dhkeyexpsizelimit 
       This option enables the use of NIST recommended (NIST Special Publication 800-56A) bit size for private-key size. For example, for DH params of size 2048bit, the private-key size recommended is 224bits. This is rounded-up to 256bits.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ersa 
       State of Ephemeral RSA (eRSA) key exchange. Ephemeral RSA allows clients that support only export ciphers to communicate with the secure server even if the server certificate does not support export clients. The ephemeral RSA key is automatically generated when you bind an export cipher to an SSL or TCP-based SSL virtual server or service. When you remove the export cipher, the eRSA key is not deleted. It is reused at a later date when another export cipher is bound to an SSL or TCP-based SSL virtual server or service. The eRSA key is deleted when the appliance restarts.  
       This parameter is not applicable when configuring a backend profile.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ersacount 
       The refresh count for the re-generation of RSA public-key and private-key pair. 
   .PARAMETER sessreuse 
       State of session reuse. Establishing the initial handshake requires CPU-intensive public key encryption operations. With the ENABLED setting, session key exchange is avoided for session resumption requests received from the client.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sesstimeout 
       The Session timeout value in seconds. 
   .PARAMETER cipherredirect 
       State of Cipher Redirect. If this parameter is set to ENABLED, you can configure an SSL virtual server or service to display meaningful error messages if the SSL handshake fails because of a cipher mismatch between the virtual server or service and the client.  
       This parameter is not applicable when configuring a backend profile.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER cipherurl 
       The redirect URL to be used with the Cipher Redirect feature. 
   .PARAMETER clientauth 
       State of client authentication. In service-based SSL offload, the service terminates the SSL handshake if the SSL client does not provide a valid certificate.  
       This parameter is not applicable when configuring a backend profile.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER clientcert 
       The rule for client certificate requirement in client authentication.  
       Possible values = Mandatory, Optional 
   .PARAMETER sslredirect 
       State of HTTPS redirects for the SSL service.  
       For an SSL session, if the client browser receives a redirect message, the browser tries to connect to the new location. However, the secure SSL session breaks if the object has moved from a secure site (https://) to an unsecure site (http://). Typically, a warning message appears on the screen, prompting the user to continue or disconnect.  
       If SSL Redirect is ENABLED, the redirect message is automatically converted from http:// to https:// and the SSL session does not break.  
       This parameter is not applicable when configuring a backend profile.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER redirectportrewrite 
       State of the port rewrite while performing HTTPS redirect. If this parameter is set to ENABLED, and the URL from the server does not contain the standard port, the port is rewritten to the standard.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ssl3 
       State of SSLv3 protocol support for the SSL profile.  
       Note: On platforms with SSL acceleration chips, if the SSL chip does not support SSLv3, this parameter cannot be set to ENABLED.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tls1 
       State of TLSv1.0 protocol support for the SSL profile.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tls11 
       State of TLSv1.1 protocol support for the SSL profile.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tls12 
       State of TLSv1.2 protocol support for the SSL profile.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tls13 
       State of TLSv1.3 protocol support for the SSL profile.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER snienable 
       State of the Server Name Indication (SNI) feature on the virtual server and service-based offload. SNI helps to enable SSL encryption on multiple domains on a single virtual server or service if the domains are controlled by the same organization and share the same second-level domain name. For example, *.sports.net can be used to secure domains such as login.sports.net and help.sports.net.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ocspstapling 
       State of OCSP stapling support on the SSL virtual server. Supported only if the protocol used is higher than SSLv3. Possible values:  
       ENABLED: The appliance sends a request to the OCSP responder to check the status of the server certificate and caches the response for the specified time. If the response is valid at the time of SSL handshake with the client, the OCSP-based server certificate status is sent to the client during the handshake.  
       DISABLED: The appliance does not check the status of the server certificate. .  
       Possible values = ENABLED, DISABLED 
   .PARAMETER serverauth 
       State of server authentication support for the SSL Backend profile.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER commonname 
       Name to be checked against the CommonName (CN) field in the server certificate bound to the SSL server. 
   .PARAMETER pushenctrigger 
       Trigger encryption on the basis of the PUSH flag value. Available settings function as follows:  
       * ALWAYS - Any PUSH packet triggers encryption.  
       * IGNORE - Ignore PUSH packet for triggering encryption.  
       * MERGE - For a consecutive sequence of PUSH packets, the last PUSH packet triggers encryption.  
       * TIMER - PUSH packet triggering encryption is delayed by the time defined in the set ssl parameter command or in the Change Advanced SSL Settings dialog box.  
       Possible values = Always, Merge, Ignore, Timer 
   .PARAMETER sendclosenotify 
       Enable sending SSL Close-Notify at the end of a transaction.  
       Possible values = YES, NO 
   .PARAMETER cleartextport 
       Port on which clear-text data is sent by the appliance to the server. Do not specify this parameter for SSL offloading with end-to-end encryption.  
       * in CLI is represented as 65535 in NITRO API 
   .PARAMETER insertionencoding 
       Encoding method used to insert the subject or issuer's name in HTTP requests to servers.  
       Possible values = Unicode, UTF-8 
   .PARAMETER denysslreneg 
       Deny renegotiation in specified circumstances. Available settings function as follows:  
       * NO - Allow SSL renegotiation.  
       * FRONTEND_CLIENT - Deny secure and nonsecure SSL renegotiation initiated by the client.  
       * FRONTEND_CLIENTSERVER - Deny secure and nonsecure SSL renegotiation initiated by the client or the Citrix ADC during policy-based client authentication.  
       * ALL - Deny all secure and nonsecure SSL renegotiation.  
       * NONSECURE - Deny nonsecure SSL renegotiation. Allows only clients that support RFC 5746.  
       Possible values = NO, FRONTEND_CLIENT, FRONTEND_CLIENTSERVER, ALL, NONSECURE 
   .PARAMETER quantumsize 
       Amount of data to collect before the data is pushed to the crypto hardware for encryption. For large downloads, a larger quantum size better utilizes the crypto resources.  
       Possible values = 4096, 8192, 16384 
   .PARAMETER strictcachecks 
       Enable strict CA certificate checks on the appliance.  
       Possible values = YES, NO 
   .PARAMETER encrypttriggerpktcount 
       Maximum number of queued packets after which encryption is triggered. Use this setting for SSL transactions that send small packets from server to Citrix ADC. 
   .PARAMETER pushflag 
       Insert PUSH flag into decrypted, encrypted, or all records. If the PUSH flag is set to a value other than 0, the buffered records are forwarded on the basis of the value of the PUSH flag. Available settings function as follows:  
       0 - Auto (PUSH flag is not set.)  
       1 - Insert PUSH flag into every decrypted record.  
       2 -Insert PUSH flag into every encrypted record.  
       3 - Insert PUSH flag into every decrypted and encrypted record. 
   .PARAMETER dropreqwithnohostheader 
       Host header check for SNI enabled sessions. If this check is enabled and the HTTP request does not contain the host header for SNI enabled sessions(i.e vserver or profile bound to vserver has SNI enabled and 'Client Hello' arrived with SNI extension), the request is dropped.  
       Possible values = YES, NO 
   .PARAMETER snihttphostmatch 
       Controls how the HTTP 'Host' header value is validated. These checks are performed only if the session is SNI enabled (i.e when vserver or profile bound to vserver has SNI enabled and 'Client Hello' arrived with SNI extension) and HTTP request contains 'Host' header.  
       Available settings function as follows:  
       CERT - Request is forwarded if the 'Host' value is covered  
       by the certificate used to establish this SSL session.  
       Note: 'CERT' matching mode cannot be applied in  
       TLS 1.3 connections established by resuming from a  
       previous TLS 1.3 session. On these connections, 'STRICT'  
       matching mode will be used instead.  
       STRICT - Request is forwarded only if value of 'Host' header  
       in HTTP is identical to the 'Server name' value passed  
       in 'Client Hello' of the SSL connection.  
       NO - No validation is performed on the HTTP 'Host'  
       header value.  
       Possible values = NO, CERT, STRICT 
   .PARAMETER pushenctriggertimeout 
       PUSH encryption trigger timeout value. The timeout value is applied only if you set the Push Encryption Trigger parameter to Timer in the SSL virtual server settings. 
   .PARAMETER ssltriggertimeout 
       Time, in milliseconds, after which encryption is triggered for transactions that are not tracked on the Citrix ADC because their length is not known. There can be a delay of up to 10ms from the specified timeout value before the packet is pushed into the queue. 
   .PARAMETER clientauthuseboundcachain 
       Certficates bound on the VIP are used for validating the client cert. Certficates came along with client cert are not used for validating the client cert.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sslinterception 
       Enable or disable transparent interception of SSL sessions.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sslireneg 
       Enable or disable triggering the client renegotiation when renegotiation request is received from the origin server.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ssliocspcheck 
       Enable or disable OCSP check for origin server certificate.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sslimaxsessperserver 
       Maximum ssl session to be cached per dynamic origin server. A unique ssl session is created for each SNI received from the client on ClientHello and the matching session is used for server session reuse. 
   .PARAMETER hsts 
       State of HSTS protocol support for the SSL profile. Using HSTS, a server can enforce the use of an HTTPS connection for all communication with a client.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER maxage 
       Set the maximum time, in seconds, in the strict transport security (STS) header during which the client must send only HTTPS requests to the server. 
   .PARAMETER includesubdomains 
       Enable HSTS for subdomains. If set to Yes, a client must send only HTTPS requests for subdomains.  
       Possible values = YES, NO 
   .PARAMETER preload 
       Flag indicates the consent of the site owner to have their domain preloaded.  
       Possible values = YES, NO 
   .PARAMETER sessionticket 
       This option enables the use of session tickets, as per the RFC 5077.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sessionticketlifetime 
       This option sets the life time of session tickets issued by NS in secs. 
   .PARAMETER sessionticketkeyrefresh 
       This option enables the use of session tickets, as per the RFC 5077.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sessionticketkeydata 
       Session ticket enc/dec key , admin can set it. 
   .PARAMETER sessionkeylifetime 
       This option sets the life time of symm key used to generate session tickets issued by NS in secs. 
   .PARAMETER prevsessionkeylifetime 
       This option sets the life time of symm key used to generate session tickets issued by NS in secs. 
   .PARAMETER ciphername 
       The cipher group/alias/individual cipher configuration. 
   .PARAMETER cipherpriority 
       cipher priority. 
   .PARAMETER strictsigdigestcheck 
       Parameter indicating to check whether peer entity certificate during TLS1.2 handshake is signed with one of signature-hash combination supported by Citrix ADC.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER skipclientcertpolicycheck 
       This flag controls the processing of X509 certificate policies. If this option is Enabled, then the policy check in Client authentication will be skipped. This option can be used only when Client Authentication is Enabled and ClientCert is set to Mandatory.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER zerorttearlydata 
       State of TLS 1.3 0-RTT early data support for the SSL Virtual Server. This setting only has an effect if resumption is enabled, as early data cannot be sent along with an initial handshake.  
       Early application data has significantly different security properties - in particular there is no guarantee that the data cannot be replayed.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tls13sessionticketsperauthcontext 
       Number of tickets the SSL Virtual Server will issue anytime TLS 1.3 is negotiated, ticket-based resumption is enabled, and either (1) a handshake completes or (2) post-handhsake client auth completes.  
       This value can be increased to enable clients to open multiple parallel connections using a fresh ticket for each connection.  
       No tickets are sent if resumption is disabled. 
   .PARAMETER dhekeyexchangewithpsk 
       Whether or not the SSL Virtual Server will require a DHE key exchange to occur when a PSK is accepted during a TLS 1.3 resumption handshake.  
       A DHE key exchange ensures forward secrecy even in the event that ticket keys are compromised, at the expense of an additional round trip and resources required to carry out the DHE key exchange.  
       If disabled, a DHE key exchange will be performed when a PSK is accepted but only if requested by the client.  
       If enabled, the server will require a DHE key exchange when a PSK is accepted regardless of whether the client supports combined PSK-DHE key exchange. This setting only has an effect when resumption is enabled.  
       Possible values = YES, NO 
   .PARAMETER allowextendedmastersecret 
       When set to YES, attempt to use the TLS Extended Master Secret (EMS, as  
       described in RFC 7627) when negotiating TLS 1.0, TLS 1.1 and TLS 1.2  
       connection parameters. EMS must be supported by both the TLS client and server  
       in order to be enabled during a handshake. This setting applies to both  
       frontend and backend SSL profiles.  
       Possible values = YES, NO 
   .PARAMETER alpnprotocol 
       Protocol to negotiate with client and then send as part of the ALPN extension in the server hello message. Possible values are HTTP1.1, HTTP2 and NONE. Default is none i.e. ALPN extension will not be sent. This parameter is relevant only if ssl connection is handled by the virtual server of type SSL_TCP. This parameter has no effect if TLSv1.3 is negotiated.  
       Possible values = NONE, HTTP1.1, HTTP2
    .EXAMPLE
        Invoke-ADCUnsetSslprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetSslprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [Boolean]$ssllogprofile ,

        [Boolean]$dh ,

        [Boolean]$dhfile ,

        [Boolean]$dhcount ,

        [Boolean]$dhkeyexpsizelimit ,

        [Boolean]$ersa ,

        [Boolean]$ersacount ,

        [Boolean]$sessreuse ,

        [Boolean]$sesstimeout ,

        [Boolean]$cipherredirect ,

        [Boolean]$cipherurl ,

        [Boolean]$clientauth ,

        [Boolean]$clientcert ,

        [Boolean]$sslredirect ,

        [Boolean]$redirectportrewrite ,

        [Boolean]$ssl3 ,

        [Boolean]$tls1 ,

        [Boolean]$tls11 ,

        [Boolean]$tls12 ,

        [Boolean]$tls13 ,

        [Boolean]$snienable ,

        [Boolean]$ocspstapling ,

        [Boolean]$serverauth ,

        [Boolean]$commonname ,

        [Boolean]$pushenctrigger ,

        [Boolean]$sendclosenotify ,

        [Boolean]$cleartextport ,

        [Boolean]$insertionencoding ,

        [Boolean]$denysslreneg ,

        [Boolean]$quantumsize ,

        [Boolean]$strictcachecks ,

        [Boolean]$encrypttriggerpktcount ,

        [Boolean]$pushflag ,

        [Boolean]$dropreqwithnohostheader ,

        [Boolean]$snihttphostmatch ,

        [Boolean]$pushenctriggertimeout ,

        [Boolean]$ssltriggertimeout ,

        [Boolean]$clientauthuseboundcachain ,

        [Boolean]$sslinterception ,

        [Boolean]$sslireneg ,

        [Boolean]$ssliocspcheck ,

        [Boolean]$sslimaxsessperserver ,

        [Boolean]$hsts ,

        [Boolean]$maxage ,

        [Boolean]$includesubdomains ,

        [Boolean]$preload ,

        [Boolean]$sessionticket ,

        [Boolean]$sessionticketlifetime ,

        [Boolean]$sessionticketkeyrefresh ,

        [Boolean]$sessionticketkeydata ,

        [Boolean]$sessionkeylifetime ,

        [Boolean]$prevsessionkeylifetime ,

        [Boolean]$ciphername ,

        [Boolean]$cipherpriority ,

        [Boolean]$strictsigdigestcheck ,

        [Boolean]$skipclientcertpolicycheck ,

        [Boolean]$zerorttearlydata ,

        [Boolean]$tls13sessionticketsperauthcontext ,

        [Boolean]$dhekeyexchangewithpsk ,

        [Boolean]$allowextendedmastersecret ,

        [Boolean]$alpnprotocol 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSslprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ssllogprofile')) { $Payload.Add('ssllogprofile', $ssllogprofile) }
            if ($PSBoundParameters.ContainsKey('dh')) { $Payload.Add('dh', $dh) }
            if ($PSBoundParameters.ContainsKey('dhfile')) { $Payload.Add('dhfile', $dhfile) }
            if ($PSBoundParameters.ContainsKey('dhcount')) { $Payload.Add('dhcount', $dhcount) }
            if ($PSBoundParameters.ContainsKey('dhkeyexpsizelimit')) { $Payload.Add('dhkeyexpsizelimit', $dhkeyexpsizelimit) }
            if ($PSBoundParameters.ContainsKey('ersa')) { $Payload.Add('ersa', $ersa) }
            if ($PSBoundParameters.ContainsKey('ersacount')) { $Payload.Add('ersacount', $ersacount) }
            if ($PSBoundParameters.ContainsKey('sessreuse')) { $Payload.Add('sessreuse', $sessreuse) }
            if ($PSBoundParameters.ContainsKey('sesstimeout')) { $Payload.Add('sesstimeout', $sesstimeout) }
            if ($PSBoundParameters.ContainsKey('cipherredirect')) { $Payload.Add('cipherredirect', $cipherredirect) }
            if ($PSBoundParameters.ContainsKey('cipherurl')) { $Payload.Add('cipherurl', $cipherurl) }
            if ($PSBoundParameters.ContainsKey('clientauth')) { $Payload.Add('clientauth', $clientauth) }
            if ($PSBoundParameters.ContainsKey('clientcert')) { $Payload.Add('clientcert', $clientcert) }
            if ($PSBoundParameters.ContainsKey('sslredirect')) { $Payload.Add('sslredirect', $sslredirect) }
            if ($PSBoundParameters.ContainsKey('redirectportrewrite')) { $Payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ($PSBoundParameters.ContainsKey('ssl3')) { $Payload.Add('ssl3', $ssl3) }
            if ($PSBoundParameters.ContainsKey('tls1')) { $Payload.Add('tls1', $tls1) }
            if ($PSBoundParameters.ContainsKey('tls11')) { $Payload.Add('tls11', $tls11) }
            if ($PSBoundParameters.ContainsKey('tls12')) { $Payload.Add('tls12', $tls12) }
            if ($PSBoundParameters.ContainsKey('tls13')) { $Payload.Add('tls13', $tls13) }
            if ($PSBoundParameters.ContainsKey('snienable')) { $Payload.Add('snienable', $snienable) }
            if ($PSBoundParameters.ContainsKey('ocspstapling')) { $Payload.Add('ocspstapling', $ocspstapling) }
            if ($PSBoundParameters.ContainsKey('serverauth')) { $Payload.Add('serverauth', $serverauth) }
            if ($PSBoundParameters.ContainsKey('commonname')) { $Payload.Add('commonname', $commonname) }
            if ($PSBoundParameters.ContainsKey('pushenctrigger')) { $Payload.Add('pushenctrigger', $pushenctrigger) }
            if ($PSBoundParameters.ContainsKey('sendclosenotify')) { $Payload.Add('sendclosenotify', $sendclosenotify) }
            if ($PSBoundParameters.ContainsKey('cleartextport')) { $Payload.Add('cleartextport', $cleartextport) }
            if ($PSBoundParameters.ContainsKey('insertionencoding')) { $Payload.Add('insertionencoding', $insertionencoding) }
            if ($PSBoundParameters.ContainsKey('denysslreneg')) { $Payload.Add('denysslreneg', $denysslreneg) }
            if ($PSBoundParameters.ContainsKey('quantumsize')) { $Payload.Add('quantumsize', $quantumsize) }
            if ($PSBoundParameters.ContainsKey('strictcachecks')) { $Payload.Add('strictcachecks', $strictcachecks) }
            if ($PSBoundParameters.ContainsKey('encrypttriggerpktcount')) { $Payload.Add('encrypttriggerpktcount', $encrypttriggerpktcount) }
            if ($PSBoundParameters.ContainsKey('pushflag')) { $Payload.Add('pushflag', $pushflag) }
            if ($PSBoundParameters.ContainsKey('dropreqwithnohostheader')) { $Payload.Add('dropreqwithnohostheader', $dropreqwithnohostheader) }
            if ($PSBoundParameters.ContainsKey('snihttphostmatch')) { $Payload.Add('snihttphostmatch', $snihttphostmatch) }
            if ($PSBoundParameters.ContainsKey('pushenctriggertimeout')) { $Payload.Add('pushenctriggertimeout', $pushenctriggertimeout) }
            if ($PSBoundParameters.ContainsKey('ssltriggertimeout')) { $Payload.Add('ssltriggertimeout', $ssltriggertimeout) }
            if ($PSBoundParameters.ContainsKey('clientauthuseboundcachain')) { $Payload.Add('clientauthuseboundcachain', $clientauthuseboundcachain) }
            if ($PSBoundParameters.ContainsKey('sslinterception')) { $Payload.Add('sslinterception', $sslinterception) }
            if ($PSBoundParameters.ContainsKey('sslireneg')) { $Payload.Add('sslireneg', $sslireneg) }
            if ($PSBoundParameters.ContainsKey('ssliocspcheck')) { $Payload.Add('ssliocspcheck', $ssliocspcheck) }
            if ($PSBoundParameters.ContainsKey('sslimaxsessperserver')) { $Payload.Add('sslimaxsessperserver', $sslimaxsessperserver) }
            if ($PSBoundParameters.ContainsKey('hsts')) { $Payload.Add('hsts', $hsts) }
            if ($PSBoundParameters.ContainsKey('maxage')) { $Payload.Add('maxage', $maxage) }
            if ($PSBoundParameters.ContainsKey('includesubdomains')) { $Payload.Add('includesubdomains', $includesubdomains) }
            if ($PSBoundParameters.ContainsKey('preload')) { $Payload.Add('preload', $preload) }
            if ($PSBoundParameters.ContainsKey('sessionticket')) { $Payload.Add('sessionticket', $sessionticket) }
            if ($PSBoundParameters.ContainsKey('sessionticketlifetime')) { $Payload.Add('sessionticketlifetime', $sessionticketlifetime) }
            if ($PSBoundParameters.ContainsKey('sessionticketkeyrefresh')) { $Payload.Add('sessionticketkeyrefresh', $sessionticketkeyrefresh) }
            if ($PSBoundParameters.ContainsKey('sessionticketkeydata')) { $Payload.Add('sessionticketkeydata', $sessionticketkeydata) }
            if ($PSBoundParameters.ContainsKey('sessionkeylifetime')) { $Payload.Add('sessionkeylifetime', $sessionkeylifetime) }
            if ($PSBoundParameters.ContainsKey('prevsessionkeylifetime')) { $Payload.Add('prevsessionkeylifetime', $prevsessionkeylifetime) }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Payload.Add('ciphername', $ciphername) }
            if ($PSBoundParameters.ContainsKey('cipherpriority')) { $Payload.Add('cipherpriority', $cipherpriority) }
            if ($PSBoundParameters.ContainsKey('strictsigdigestcheck')) { $Payload.Add('strictsigdigestcheck', $strictsigdigestcheck) }
            if ($PSBoundParameters.ContainsKey('skipclientcertpolicycheck')) { $Payload.Add('skipclientcertpolicycheck', $skipclientcertpolicycheck) }
            if ($PSBoundParameters.ContainsKey('zerorttearlydata')) { $Payload.Add('zerorttearlydata', $zerorttearlydata) }
            if ($PSBoundParameters.ContainsKey('tls13sessionticketsperauthcontext')) { $Payload.Add('tls13sessionticketsperauthcontext', $tls13sessionticketsperauthcontext) }
            if ($PSBoundParameters.ContainsKey('dhekeyexchangewithpsk')) { $Payload.Add('dhekeyexchangewithpsk', $dhekeyexchangewithpsk) }
            if ($PSBoundParameters.ContainsKey('allowextendedmastersecret')) { $Payload.Add('allowextendedmastersecret', $allowextendedmastersecret) }
            if ($PSBoundParameters.ContainsKey('alpnprotocol')) { $Payload.Add('alpnprotocol', $alpnprotocol) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslprofile -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSslprofile: Finished"
    }
}

function Invoke-ADCGetSslprofile {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       Name for the SSL profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the profile is created. 
    .PARAMETER GetAll 
        Retreive all sslprofile object(s)
    .PARAMETER Count
        If specified, the count of the sslprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslprofile
    .EXAMPLE 
        Invoke-ADCGetSslprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslprofile -Count
    .EXAMPLE
        Invoke-ADCGetSslprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetSslprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile/
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
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-ADCGetSslprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslprofile: Ended"
    }
}

function Invoke-ADCGetSslprofilebinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       Name of the SSL profile for which to show detailed information. 
    .PARAMETER GetAll 
        Retreive all sslprofile_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslprofile_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslprofilebinding
    .EXAMPLE 
        Invoke-ADCGetSslprofilebinding -GetAll
    .EXAMPLE
        Invoke-ADCGetSslprofilebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslprofilebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslprofilebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile_binding/
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
        [ValidateLength(1, 127)]
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslprofile_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslprofile_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslprofilebinding: Ended"
    }
}

function Invoke-ADCAddSslprofileecccurvebinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER name 
        Name of the SSL profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER cipherpriority 
        Priority of the cipher binding.  
        Minimum value = 1  
        Maximum value = 1000 
    .PARAMETER ecccurvename 
        Named ECC curve bound to vserver/service.  
        Possible values = ALL, P_224, P_256, P_384, P_521 
    .PARAMETER PassThru 
        Return details about the created sslprofile_ecccurve_binding item.
    .EXAMPLE
        Invoke-ADCAddSslprofileecccurvebinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddSslprofileecccurvebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile_ecccurve_binding/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [ValidateRange(1, 1000)]
        [double]$cipherpriority ,

        [ValidateSet('ALL', 'P_224', 'P_256', 'P_384', 'P_521')]
        [string]$ecccurvename ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslprofileecccurvebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('cipherpriority')) { $Payload.Add('cipherpriority', $cipherpriority) }
            if ($PSBoundParameters.ContainsKey('ecccurvename')) { $Payload.Add('ecccurvename', $ecccurvename) }
 
            if ($PSCmdlet.ShouldProcess("sslprofile_ecccurve_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslprofile_ecccurve_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslprofileecccurvebinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslprofileecccurvebinding: Finished"
    }
}

function Invoke-ADCDeleteSslprofileecccurvebinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER name 
       Name of the SSL profile.  
       Minimum length = 1  
       Maximum length = 127    .PARAMETER ecccurvename 
       Named ECC curve bound to vserver/service.  
       Possible values = ALL, P_224, P_256, P_384, P_521
    .EXAMPLE
        Invoke-ADCDeleteSslprofileecccurvebinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslprofileecccurvebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile_ecccurve_binding/
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

        [string]$ecccurvename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslprofileecccurvebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ecccurvename')) { $Arguments.Add('ecccurvename', $ecccurvename) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslprofile_ecccurve_binding -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslprofileecccurvebinding: Finished"
    }
}

function Invoke-ADCGetSslprofileecccurvebinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       Name of the SSL profile. 
    .PARAMETER GetAll 
        Retreive all sslprofile_ecccurve_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslprofile_ecccurve_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslprofileecccurvebinding
    .EXAMPLE 
        Invoke-ADCGetSslprofileecccurvebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslprofileecccurvebinding -Count
    .EXAMPLE
        Invoke-ADCGetSslprofileecccurvebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslprofileecccurvebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslprofileecccurvebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile_ecccurve_binding/
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
        [ValidateLength(1, 127)]
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslprofileecccurvebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslprofile_ecccurve_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_ecccurve_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslprofile_ecccurve_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_ecccurve_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslprofile_ecccurve_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_ecccurve_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslprofile_ecccurve_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_ecccurve_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslprofile_ecccurve_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_ecccurve_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslprofileecccurvebinding: Ended"
    }
}

function Invoke-ADCAddSslprofilesslcertkeybinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER name 
        Name of the SSL profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER cipherpriority 
        Priority of the cipher binding.  
        Minimum value = 1  
        Maximum value = 1000 
    .PARAMETER sslicacertkey 
        The certkey (CA certificate + private key) to be used for SSL interception. 
    .PARAMETER PassThru 
        Return details about the created sslprofile_sslcertkey_binding item.
    .EXAMPLE
        Invoke-ADCAddSslprofilesslcertkeybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddSslprofilesslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile_sslcertkey_binding/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [ValidateRange(1, 1000)]
        [double]$cipherpriority ,

        [string]$sslicacertkey ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslprofilesslcertkeybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('cipherpriority')) { $Payload.Add('cipherpriority', $cipherpriority) }
            if ($PSBoundParameters.ContainsKey('sslicacertkey')) { $Payload.Add('sslicacertkey', $sslicacertkey) }
 
            if ($PSCmdlet.ShouldProcess("sslprofile_sslcertkey_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslprofile_sslcertkey_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslprofilesslcertkeybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslprofilesslcertkeybinding: Finished"
    }
}

function Invoke-ADCDeleteSslprofilesslcertkeybinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER name 
       Name of the SSL profile.  
       Minimum length = 1  
       Maximum length = 127    .PARAMETER sslicacertkey 
       The certkey (CA certificate + private key) to be used for SSL interception.
    .EXAMPLE
        Invoke-ADCDeleteSslprofilesslcertkeybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslprofilesslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile_sslcertkey_binding/
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

        [string]$sslicacertkey 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslprofilesslcertkeybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('sslicacertkey')) { $Arguments.Add('sslicacertkey', $sslicacertkey) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslprofile_sslcertkey_binding -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslprofilesslcertkeybinding: Finished"
    }
}

function Invoke-ADCGetSslprofilesslcertkeybinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       Name of the SSL profile. 
    .PARAMETER GetAll 
        Retreive all sslprofile_sslcertkey_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslprofile_sslcertkey_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslprofilesslcertkeybinding
    .EXAMPLE 
        Invoke-ADCGetSslprofilesslcertkeybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslprofilesslcertkeybinding -Count
    .EXAMPLE
        Invoke-ADCGetSslprofilesslcertkeybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslprofilesslcertkeybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslprofilesslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile_sslcertkey_binding/
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
        [ValidateLength(1, 127)]
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslprofilesslcertkeybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslprofile_sslcertkey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslcertkey_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslprofile_sslcertkey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslcertkey_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslprofile_sslcertkey_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslcertkey_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslprofile_sslcertkey_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslcertkey_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslprofile_sslcertkey_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslcertkey_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslprofilesslcertkeybinding: Ended"
    }
}

function Invoke-ADCAddSslprofilesslciphersuitebinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER name 
        Name of the SSL profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER ciphername 
        The cipher group/alias/individual cipher configuration. 
    .PARAMETER cipherpriority 
        cipher priority.  
        Minimum value = 1 
    .PARAMETER PassThru 
        Return details about the created sslprofile_sslciphersuite_binding item.
    .EXAMPLE
        Invoke-ADCAddSslprofilesslciphersuitebinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddSslprofilesslciphersuitebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile_sslciphersuite_binding/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [string]$ciphername ,

        [double]$cipherpriority ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslprofilesslciphersuitebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Payload.Add('ciphername', $ciphername) }
            if ($PSBoundParameters.ContainsKey('cipherpriority')) { $Payload.Add('cipherpriority', $cipherpriority) }
 
            if ($PSCmdlet.ShouldProcess("sslprofile_sslciphersuite_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslprofile_sslciphersuite_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslprofilesslciphersuitebinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslprofilesslciphersuitebinding: Finished"
    }
}

function Invoke-ADCDeleteSslprofilesslciphersuitebinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER name 
       Name of the SSL profile.  
       Minimum length = 1  
       Maximum length = 127    .PARAMETER ciphername 
       The cipher group/alias/individual cipher configuration.
    .EXAMPLE
        Invoke-ADCDeleteSslprofilesslciphersuitebinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslprofilesslciphersuitebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile_sslciphersuite_binding/
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

        [string]$ciphername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslprofilesslciphersuitebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Arguments.Add('ciphername', $ciphername) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslprofile_sslciphersuite_binding -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslprofilesslciphersuitebinding: Finished"
    }
}

function Invoke-ADCGetSslprofilesslciphersuitebinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       Name of the SSL profile. 
    .PARAMETER GetAll 
        Retreive all sslprofile_sslciphersuite_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslprofile_sslciphersuite_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslprofilesslciphersuitebinding
    .EXAMPLE 
        Invoke-ADCGetSslprofilesslciphersuitebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslprofilesslciphersuitebinding -Count
    .EXAMPLE
        Invoke-ADCGetSslprofilesslciphersuitebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslprofilesslciphersuitebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslprofilesslciphersuitebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile_sslciphersuite_binding/
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
        [ValidateLength(1, 127)]
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslprofilesslciphersuitebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslprofile_sslciphersuite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslciphersuite_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslprofile_sslciphersuite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslciphersuite_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslprofile_sslciphersuite_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslciphersuite_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslprofile_sslciphersuite_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslciphersuite_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslprofile_sslciphersuite_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslciphersuite_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslprofilesslciphersuitebinding: Ended"
    }
}

function Invoke-ADCAddSslprofilesslcipherbinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER name 
        Name of the SSL profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER ciphername 
        Name of the cipher.  
        Minimum length = 1 
    .PARAMETER cipherpriority 
        cipher priority.  
        Minimum value = 1 
    .PARAMETER PassThru 
        Return details about the created sslprofile_sslcipher_binding item.
    .EXAMPLE
        Invoke-ADCAddSslprofilesslcipherbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddSslprofilesslcipherbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile_sslcipher_binding/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ciphername ,

        [double]$cipherpriority ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslprofilesslcipherbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Payload.Add('ciphername', $ciphername) }
            if ($PSBoundParameters.ContainsKey('cipherpriority')) { $Payload.Add('cipherpriority', $cipherpriority) }
 
            if ($PSCmdlet.ShouldProcess("sslprofile_sslcipher_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslprofile_sslcipher_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslprofilesslcipherbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslprofilesslcipherbinding: Finished"
    }
}

function Invoke-ADCDeleteSslprofilesslcipherbinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER name 
       Name of the SSL profile.  
       Minimum length = 1  
       Maximum length = 127    .PARAMETER ciphername 
       Name of the cipher.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteSslprofilesslcipherbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslprofilesslcipherbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile_sslcipher_binding/
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

        [string]$ciphername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslprofilesslcipherbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Arguments.Add('ciphername', $ciphername) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslprofile_sslcipher_binding -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslprofilesslcipherbinding: Finished"
    }
}

function Invoke-ADCGetSslprofilesslcipherbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       Name of the SSL profile. 
    .PARAMETER GetAll 
        Retreive all sslprofile_sslcipher_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslprofile_sslcipher_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslprofilesslcipherbinding
    .EXAMPLE 
        Invoke-ADCGetSslprofilesslcipherbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslprofilesslcipherbinding -Count
    .EXAMPLE
        Invoke-ADCGetSslprofilesslcipherbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslprofilesslcipherbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslprofilesslcipherbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile_sslcipher_binding/
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
        [ValidateLength(1, 127)]
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslprofilesslcipherbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslprofile_sslcipher_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslcipher_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslprofile_sslcipher_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslcipher_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslprofile_sslcipher_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslcipher_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslprofile_sslcipher_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslcipher_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslprofile_sslcipher_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslcipher_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslprofilesslcipherbinding: Ended"
    }
}

function Invoke-ADCGetSslprofilesslvserverbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER name 
       Name of the SSL profile. 
    .PARAMETER GetAll 
        Retreive all sslprofile_sslvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslprofile_sslvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslprofilesslvserverbinding
    .EXAMPLE 
        Invoke-ADCGetSslprofilesslvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslprofilesslvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetSslprofilesslvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslprofilesslvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslprofilesslvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslprofile_sslvserver_binding/
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
        [ValidateLength(1, 127)]
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslprofilesslvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslprofile_sslvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslprofile_sslvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslprofile_sslvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslvserver_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslprofile_sslvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslvserver_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslprofile_sslvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslprofile_sslvserver_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslprofilesslvserverbinding: Ended"
    }
}

function Invoke-ADCCreateSslrsakey {
<#
    .SYNOPSIS
        Create SSL configuration Object
    .DESCRIPTION
        Create SSL configuration Object 
    .PARAMETER keyfile 
        Name for and, optionally, path to the RSA key file. /nsconfig/ssl/ is the default path. 
    .PARAMETER bits 
        Size, in bits, of the RSA key. 
    .PARAMETER exponent 
        Public exponent for the RSA key. The exponent is part of the cipher algorithm and is required for creating the RSA key.  
        Possible values = 3, F4 
    .PARAMETER keyform 
        Format in which the RSA key file is stored on the appliance.  
        Possible values = DER, PEM 
    .PARAMETER des 
        Encrypt the generated RSA key by using the DES algorithm. On the command line, you are prompted to enter the pass phrase (password) that is used to encrypt the key. 
    .PARAMETER des3 
        Encrypt the generated RSA key by using the Triple-DES algorithm. On the command line, you are prompted to enter the pass phrase (password) that is used to encrypt the key. 
    .PARAMETER aes256 
        Encrypt the generated RSA key by using the AES algorithm. 
    .PARAMETER password 
        Pass phrase to use for encryption if DES or DES3 option is selected. 
    .PARAMETER pkcs8 
        Create the private key in PKCS#8 format.
    .EXAMPLE
        Invoke-ADCCreateSslrsakey -keyfile <string> -bits <double>
    .NOTES
        File Name : Invoke-ADCCreateSslrsakey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslrsakey/
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
        [string]$keyfile ,

        [Parameter(Mandatory = $true)]
        [ValidateRange(512, 4096)]
        [double]$bits ,

        [ValidateSet('3', 'F4')]
        [string]$exponent ,

        [ValidateSet('DER', 'PEM')]
        [string]$keyform ,

        [boolean]$des ,

        [boolean]$des3 ,

        [boolean]$aes256 ,

        [ValidateLength(1, 31)]
        [string]$password ,

        [boolean]$pkcs8 

    )
    begin {
        Write-Verbose "Invoke-ADCCreateSslrsakey: Starting"
    }
    process {
        try {
            $Payload = @{
                keyfile = $keyfile
                bits = $bits
            }
            if ($PSBoundParameters.ContainsKey('exponent')) { $Payload.Add('exponent', $exponent) }
            if ($PSBoundParameters.ContainsKey('keyform')) { $Payload.Add('keyform', $keyform) }
            if ($PSBoundParameters.ContainsKey('des')) { $Payload.Add('des', $des) }
            if ($PSBoundParameters.ContainsKey('des3')) { $Payload.Add('des3', $des3) }
            if ($PSBoundParameters.ContainsKey('aes256')) { $Payload.Add('aes256', $aes256) }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSBoundParameters.ContainsKey('pkcs8')) { $Payload.Add('pkcs8', $pkcs8) }
            if ($PSCmdlet.ShouldProcess($Name, "Create SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslrsakey -Action create -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCCreateSslrsakey: Finished"
    }
}

function Invoke-ADCUpdateSslservice {
<#
    .SYNOPSIS
        Update SSL configuration Object
    .DESCRIPTION
        Update SSL configuration Object 
    .PARAMETER servicename 
        Name of the SSL service.  
        Minimum length = 1 
    .PARAMETER dh 
        State of Diffie-Hellman (DH) key exchange. This parameter is not applicable when configuring a backend service.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dhfile 
        Name for and, optionally, path to the PEM-format DH parameter file to be installed. /nsconfig/ssl/ is the default path. This parameter is not applicable when configuring a backend service.  
        Minimum length = 1 
    .PARAMETER dhcount 
        Number of interactions, between the client and the Citrix ADC, after which the DH private-public pair is regenerated. A value of zero (0) specifies infinite use (no refresh). This parameter is not applicable when configuring a backend service. Allowed DH count values are 0 and >= 500.  
        Minimum value = 0  
        Maximum value = 65534 
    .PARAMETER dhkeyexpsizelimit 
        This option enables the use of NIST recommended (NIST Special Publication 800-56A) bit size for private-key size. For example, for DH params of size 2048bit, the private-key size recommended is 224bits. This is rounded-up to 256bits.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ersa 
        State of Ephemeral RSA (eRSA) key exchange. Ephemeral RSA allows clients that support only export ciphers to communicate with the secure server even if the server certificate does not support export clients. The ephemeral RSA key is automatically generated when you bind an export cipher to an SSL or TCP-based SSL virtual server or service. When you remove the export cipher, the eRSA key is not deleted. It is reused at a later date when another export cipher is bound to an SSL or TCP-based SSL virtual server or service. The eRSA key is deleted when the appliance restarts.  
        This parameter is not applicable when configuring a backend service.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ersacount 
        Refresh count for regeneration of RSA public-key and private-key pair. Zero (0) specifies infinite usage (no refresh).  
        This parameter is not applicable when configuring a backend service.  
        Minimum value = 0  
        Maximum value = 65534 
    .PARAMETER sessreuse 
        State of session reuse. Establishing the initial handshake requires CPU-intensive public key encryption operations. With the ENABLED setting, session key exchange is avoided for session resumption requests received from the client.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sesstimeout 
        Time, in seconds, for which to keep the session active. Any session resumption request received after the timeout period will require a fresh SSL handshake and establishment of a new SSL session.  
        Default value: 300  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER cipherredirect 
        State of Cipher Redirect. If this parameter is set to ENABLED, you can configure an SSL virtual server or service to display meaningful error messages if the SSL handshake fails because of a cipher mismatch between the virtual server or service and the client.  
        This parameter is not applicable when configuring a backend service.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cipherurl 
        URL of the page to which to redirect the client in case of a cipher mismatch. Typically, this page has a clear explanation of the error or an alternative location that the transaction can continue from.  
        This parameter is not applicable when configuring a backend service. 
    .PARAMETER sslv2redirect 
        State of SSLv2 Redirect. If this parameter is set to ENABLED, you can configure an SSL virtual server or service to display meaningful error messages if the SSL handshake fails because of a protocol version mismatch between the virtual server or service and the client.  
        This parameter is not applicable when configuring a backend service.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sslv2url 
        URL of the page to which to redirect the client in case of a protocol version mismatch. Typically, this page has a clear explanation of the error or an alternative location that the transaction can continue from.  
        This parameter is not applicable when configuring a backend service. 
    .PARAMETER clientauth 
        State of client authentication. In service-based SSL offload, the service terminates the SSL handshake if the SSL client does not provide a valid certificate.  
        This parameter is not applicable when configuring a backend service.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER clientcert 
        Type of client authentication. If this parameter is set to MANDATORY, the appliance terminates the SSL handshake if the SSL client does not provide a valid certificate. With the OPTIONAL setting, the appliance requests a certificate from the SSL clients but proceeds with the SSL transaction even if the client presents an invalid certificate.  
        This parameter is not applicable when configuring a backend SSL service.  
        Caution: Define proper access control policies before changing this setting to Optional.  
        Possible values = Mandatory, Optional 
    .PARAMETER sslredirect 
        State of HTTPS redirects for the SSL service.  
        For an SSL session, if the client browser receives a redirect message, the browser tries to connect to the new location. However, the secure SSL session breaks if the object has moved from a secure site (https://) to an unsecure site (http://). Typically, a warning message appears on the screen, prompting the user to continue or disconnect.  
        If SSL Redirect is ENABLED, the redirect message is automatically converted from http:// to https:// and the SSL session does not break.  
        This parameter is not applicable when configuring a backend service.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER redirectportrewrite 
        State of the port rewrite while performing HTTPS redirect. If this parameter is set to ENABLED, and the URL from the server does not contain the standard port, the port is rewritten to the standard.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ssl2 
        State of SSLv2 protocol support for the SSL service.  
        This parameter is not applicable when configuring a backend service.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ssl3 
        State of SSLv3 protocol support for the SSL service.  
        Note: On platforms with SSL acceleration chips, if the SSL chip does not support SSLv3, this parameter cannot be set to ENABLED.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls1 
        State of TLSv1.0 protocol support for the SSL service.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls11 
        State of TLSv1.1 protocol support for the SSL service.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls12 
        State of TLSv1.2 protocol support for the SSL service.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls13 
        State of TLSv1.3 protocol support for the SSL service.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dtls1 
        State of DTLSv1.0 protocol support for the SSL service.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dtls12 
        State of DTLSv1.2 protocol support for the SSL service.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER snienable 
        State of the Server Name Indication (SNI) feature on the virtual server and service-based offload. SNI helps to enable SSL encryption on multiple domains on a single virtual server or service if the domains are controlled by the same organization and share the same second-level domain name. For example, *.sports.net can be used to secure domains such as login.sports.net and help.sports.net.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ocspstapling 
        State of OCSP stapling support on the SSL virtual server. Supported only if the protocol used is higher than SSLv3. Possible values:  
        ENABLED: The appliance sends a request to the OCSP responder to check the status of the server certificate and caches the response for the specified time. If the response is valid at the time of SSL handshake with the client, the OCSP-based server certificate status is sent to the client during the handshake.  
        DISABLED: The appliance does not check the status of the server certificate. .  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER serverauth 
        State of server authentication support for the SSL service.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER commonname 
        Name to be checked against the CommonName (CN) field in the server certificate bound to the SSL server.  
        Minimum length = 1 
    .PARAMETER pushenctrigger 
        Trigger encryption on the basis of the PUSH flag value. Available settings function as follows:  
        * ALWAYS - Any PUSH packet triggers encryption.  
        * IGNORE - Ignore PUSH packet for triggering encryption.  
        * MERGE - For a consecutive sequence of PUSH packets, the last PUSH packet triggers encryption.  
        * TIMER - PUSH packet triggering encryption is delayed by the time defined in the set ssl parameter command or in the Change Advanced SSL Settings dialog box.  
        Possible values = Always, Merge, Ignore, Timer 
    .PARAMETER sendclosenotify 
        Enable sending SSL Close-Notify at the end of a transaction.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER dtlsprofilename 
        Name of the DTLS profile that contains DTLS settings for the service.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER sslprofile 
        Name of the SSL profile that contains SSL settings for the service.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER strictsigdigestcheck 
        Parameter indicating to check whether peer's certificate during TLS1.2 handshake is signed with one of signature-hash combination supported by Citrix ADC.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created sslservice item.
    .EXAMPLE
        Invoke-ADCUpdateSslservice -servicename <string>
    .NOTES
        File Name : Invoke-ADCUpdateSslservice
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice/
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
        [string]$servicename ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dh ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$dhfile ,

        [ValidateRange(0, 65534)]
        [double]$dhcount ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dhkeyexpsizelimit ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ersa ,

        [ValidateRange(0, 65534)]
        [double]$ersacount ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessreuse ,

        [ValidateRange(0, 4294967294)]
        [double]$sesstimeout ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cipherredirect ,

        [string]$cipherurl ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslv2redirect ,

        [string]$sslv2url ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$clientauth ,

        [ValidateSet('Mandatory', 'Optional')]
        [string]$clientcert ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslredirect ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$redirectportrewrite ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ssl2 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ssl3 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls1 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls11 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls12 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls13 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dtls1 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dtls12 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$snienable ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ocspstapling ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$serverauth ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$commonname ,

        [ValidateSet('Always', 'Merge', 'Ignore', 'Timer')]
        [string]$pushenctrigger ,

        [ValidateSet('YES', 'NO')]
        [string]$sendclosenotify ,

        [ValidateLength(1, 127)]
        [string]$dtlsprofilename ,

        [ValidateLength(1, 127)]
        [string]$sslprofile ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$strictsigdigestcheck ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSslservice: Starting"
    }
    process {
        try {
            $Payload = @{
                servicename = $servicename
            }
            if ($PSBoundParameters.ContainsKey('dh')) { $Payload.Add('dh', $dh) }
            if ($PSBoundParameters.ContainsKey('dhfile')) { $Payload.Add('dhfile', $dhfile) }
            if ($PSBoundParameters.ContainsKey('dhcount')) { $Payload.Add('dhcount', $dhcount) }
            if ($PSBoundParameters.ContainsKey('dhkeyexpsizelimit')) { $Payload.Add('dhkeyexpsizelimit', $dhkeyexpsizelimit) }
            if ($PSBoundParameters.ContainsKey('ersa')) { $Payload.Add('ersa', $ersa) }
            if ($PSBoundParameters.ContainsKey('ersacount')) { $Payload.Add('ersacount', $ersacount) }
            if ($PSBoundParameters.ContainsKey('sessreuse')) { $Payload.Add('sessreuse', $sessreuse) }
            if ($PSBoundParameters.ContainsKey('sesstimeout')) { $Payload.Add('sesstimeout', $sesstimeout) }
            if ($PSBoundParameters.ContainsKey('cipherredirect')) { $Payload.Add('cipherredirect', $cipherredirect) }
            if ($PSBoundParameters.ContainsKey('cipherurl')) { $Payload.Add('cipherurl', $cipherurl) }
            if ($PSBoundParameters.ContainsKey('sslv2redirect')) { $Payload.Add('sslv2redirect', $sslv2redirect) }
            if ($PSBoundParameters.ContainsKey('sslv2url')) { $Payload.Add('sslv2url', $sslv2url) }
            if ($PSBoundParameters.ContainsKey('clientauth')) { $Payload.Add('clientauth', $clientauth) }
            if ($PSBoundParameters.ContainsKey('clientcert')) { $Payload.Add('clientcert', $clientcert) }
            if ($PSBoundParameters.ContainsKey('sslredirect')) { $Payload.Add('sslredirect', $sslredirect) }
            if ($PSBoundParameters.ContainsKey('redirectportrewrite')) { $Payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ($PSBoundParameters.ContainsKey('ssl2')) { $Payload.Add('ssl2', $ssl2) }
            if ($PSBoundParameters.ContainsKey('ssl3')) { $Payload.Add('ssl3', $ssl3) }
            if ($PSBoundParameters.ContainsKey('tls1')) { $Payload.Add('tls1', $tls1) }
            if ($PSBoundParameters.ContainsKey('tls11')) { $Payload.Add('tls11', $tls11) }
            if ($PSBoundParameters.ContainsKey('tls12')) { $Payload.Add('tls12', $tls12) }
            if ($PSBoundParameters.ContainsKey('tls13')) { $Payload.Add('tls13', $tls13) }
            if ($PSBoundParameters.ContainsKey('dtls1')) { $Payload.Add('dtls1', $dtls1) }
            if ($PSBoundParameters.ContainsKey('dtls12')) { $Payload.Add('dtls12', $dtls12) }
            if ($PSBoundParameters.ContainsKey('snienable')) { $Payload.Add('snienable', $snienable) }
            if ($PSBoundParameters.ContainsKey('ocspstapling')) { $Payload.Add('ocspstapling', $ocspstapling) }
            if ($PSBoundParameters.ContainsKey('serverauth')) { $Payload.Add('serverauth', $serverauth) }
            if ($PSBoundParameters.ContainsKey('commonname')) { $Payload.Add('commonname', $commonname) }
            if ($PSBoundParameters.ContainsKey('pushenctrigger')) { $Payload.Add('pushenctrigger', $pushenctrigger) }
            if ($PSBoundParameters.ContainsKey('sendclosenotify')) { $Payload.Add('sendclosenotify', $sendclosenotify) }
            if ($PSBoundParameters.ContainsKey('dtlsprofilename')) { $Payload.Add('dtlsprofilename', $dtlsprofilename) }
            if ($PSBoundParameters.ContainsKey('sslprofile')) { $Payload.Add('sslprofile', $sslprofile) }
            if ($PSBoundParameters.ContainsKey('strictsigdigestcheck')) { $Payload.Add('strictsigdigestcheck', $strictsigdigestcheck) }
 
            if ($PSCmdlet.ShouldProcess("sslservice", "Update SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslservice -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslservice -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateSslservice: Finished"
    }
}

function Invoke-ADCUnsetSslservice {
<#
    .SYNOPSIS
        Unset SSL configuration Object
    .DESCRIPTION
        Unset SSL configuration Object 
   .PARAMETER servicename 
       Name of the SSL service. 
   .PARAMETER dh 
       State of Diffie-Hellman (DH) key exchange. This parameter is not applicable when configuring a backend service.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER dhfile 
       Name for and, optionally, path to the PEM-format DH parameter file to be installed. /nsconfig/ssl/ is the default path. This parameter is not applicable when configuring a backend service. 
   .PARAMETER dhcount 
       Number of interactions, between the client and the Citrix ADC, after which the DH private-public pair is regenerated. A value of zero (0) specifies infinite use (no refresh). This parameter is not applicable when configuring a backend service. Allowed DH count values are 0 and >= 500. 
   .PARAMETER dhkeyexpsizelimit 
       This option enables the use of NIST recommended (NIST Special Publication 800-56A) bit size for private-key size. For example, for DH params of size 2048bit, the private-key size recommended is 224bits. This is rounded-up to 256bits.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ersa 
       State of Ephemeral RSA (eRSA) key exchange. Ephemeral RSA allows clients that support only export ciphers to communicate with the secure server even if the server certificate does not support export clients. The ephemeral RSA key is automatically generated when you bind an export cipher to an SSL or TCP-based SSL virtual server or service. When you remove the export cipher, the eRSA key is not deleted. It is reused at a later date when another export cipher is bound to an SSL or TCP-based SSL virtual server or service. The eRSA key is deleted when the appliance restarts.  
       This parameter is not applicable when configuring a backend service.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ersacount 
       Refresh count for regeneration of RSA public-key and private-key pair. Zero (0) specifies infinite usage (no refresh).  
       This parameter is not applicable when configuring a backend service. 
   .PARAMETER sessreuse 
       State of session reuse. Establishing the initial handshake requires CPU-intensive public key encryption operations. With the ENABLED setting, session key exchange is avoided for session resumption requests received from the client.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sesstimeout 
       Time, in seconds, for which to keep the session active. Any session resumption request received after the timeout period will require a fresh SSL handshake and establishment of a new SSL session. 
   .PARAMETER cipherredirect 
       State of Cipher Redirect. If this parameter is set to ENABLED, you can configure an SSL virtual server or service to display meaningful error messages if the SSL handshake fails because of a cipher mismatch between the virtual server or service and the client.  
       This parameter is not applicable when configuring a backend service.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER cipherurl 
       URL of the page to which to redirect the client in case of a cipher mismatch. Typically, this page has a clear explanation of the error or an alternative location that the transaction can continue from.  
       This parameter is not applicable when configuring a backend service. 
   .PARAMETER sslv2redirect 
       State of SSLv2 Redirect. If this parameter is set to ENABLED, you can configure an SSL virtual server or service to display meaningful error messages if the SSL handshake fails because of a protocol version mismatch between the virtual server or service and the client.  
       This parameter is not applicable when configuring a backend service.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sslv2url 
       URL of the page to which to redirect the client in case of a protocol version mismatch. Typically, this page has a clear explanation of the error or an alternative location that the transaction can continue from.  
       This parameter is not applicable when configuring a backend service. 
   .PARAMETER clientauth 
       State of client authentication. In service-based SSL offload, the service terminates the SSL handshake if the SSL client does not provide a valid certificate.  
       This parameter is not applicable when configuring a backend service.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER clientcert 
       Type of client authentication. If this parameter is set to MANDATORY, the appliance terminates the SSL handshake if the SSL client does not provide a valid certificate. With the OPTIONAL setting, the appliance requests a certificate from the SSL clients but proceeds with the SSL transaction even if the client presents an invalid certificate.  
       This parameter is not applicable when configuring a backend SSL service.  
       Caution: Define proper access control policies before changing this setting to Optional.  
       Possible values = Mandatory, Optional 
   .PARAMETER sslredirect 
       State of HTTPS redirects for the SSL service.  
       For an SSL session, if the client browser receives a redirect message, the browser tries to connect to the new location. However, the secure SSL session breaks if the object has moved from a secure site (https://) to an unsecure site (http://). Typically, a warning message appears on the screen, prompting the user to continue or disconnect.  
       If SSL Redirect is ENABLED, the redirect message is automatically converted from http:// to https:// and the SSL session does not break.  
       This parameter is not applicable when configuring a backend service.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER redirectportrewrite 
       State of the port rewrite while performing HTTPS redirect. If this parameter is set to ENABLED, and the URL from the server does not contain the standard port, the port is rewritten to the standard.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ssl2 
       State of SSLv2 protocol support for the SSL service.  
       This parameter is not applicable when configuring a backend service.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ssl3 
       State of SSLv3 protocol support for the SSL service.  
       Note: On platforms with SSL acceleration chips, if the SSL chip does not support SSLv3, this parameter cannot be set to ENABLED.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tls1 
       State of TLSv1.0 protocol support for the SSL service.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tls11 
       State of TLSv1.1 protocol support for the SSL service.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tls12 
       State of TLSv1.2 protocol support for the SSL service.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tls13 
       State of TLSv1.3 protocol support for the SSL service.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER dtls1 
       State of DTLSv1.0 protocol support for the SSL service.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER dtls12 
       State of DTLSv1.2 protocol support for the SSL service.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER snienable 
       State of the Server Name Indication (SNI) feature on the virtual server and service-based offload. SNI helps to enable SSL encryption on multiple domains on a single virtual server or service if the domains are controlled by the same organization and share the same second-level domain name. For example, *.sports.net can be used to secure domains such as login.sports.net and help.sports.net.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ocspstapling 
       State of OCSP stapling support on the SSL virtual server. Supported only if the protocol used is higher than SSLv3. Possible values:  
       ENABLED: The appliance sends a request to the OCSP responder to check the status of the server certificate and caches the response for the specified time. If the response is valid at the time of SSL handshake with the client, the OCSP-based server certificate status is sent to the client during the handshake.  
       DISABLED: The appliance does not check the status of the server certificate. .  
       Possible values = ENABLED, DISABLED 
   .PARAMETER serverauth 
       State of server authentication support for the SSL service.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER commonname 
       Name to be checked against the CommonName (CN) field in the server certificate bound to the SSL server. 
   .PARAMETER sendclosenotify 
       Enable sending SSL Close-Notify at the end of a transaction.  
       Possible values = YES, NO 
   .PARAMETER dtlsprofilename 
       Name of the DTLS profile that contains DTLS settings for the service. 
   .PARAMETER sslprofile 
       Name of the SSL profile that contains SSL settings for the service. 
   .PARAMETER strictsigdigestcheck 
       Parameter indicating to check whether peer's certificate during TLS1.2 handshake is signed with one of signature-hash combination supported by Citrix ADC.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetSslservice -servicename <string>
    .NOTES
        File Name : Invoke-ADCUnsetSslservice
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice
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
        [string]$servicename ,

        [Boolean]$dh ,

        [Boolean]$dhfile ,

        [Boolean]$dhcount ,

        [Boolean]$dhkeyexpsizelimit ,

        [Boolean]$ersa ,

        [Boolean]$ersacount ,

        [Boolean]$sessreuse ,

        [Boolean]$sesstimeout ,

        [Boolean]$cipherredirect ,

        [Boolean]$cipherurl ,

        [Boolean]$sslv2redirect ,

        [Boolean]$sslv2url ,

        [Boolean]$clientauth ,

        [Boolean]$clientcert ,

        [Boolean]$sslredirect ,

        [Boolean]$redirectportrewrite ,

        [Boolean]$ssl2 ,

        [Boolean]$ssl3 ,

        [Boolean]$tls1 ,

        [Boolean]$tls11 ,

        [Boolean]$tls12 ,

        [Boolean]$tls13 ,

        [Boolean]$dtls1 ,

        [Boolean]$dtls12 ,

        [Boolean]$snienable ,

        [Boolean]$ocspstapling ,

        [Boolean]$serverauth ,

        [Boolean]$commonname ,

        [Boolean]$sendclosenotify ,

        [Boolean]$dtlsprofilename ,

        [Boolean]$sslprofile ,

        [Boolean]$strictsigdigestcheck 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSslservice: Starting"
    }
    process {
        try {
            $Payload = @{
                servicename = $servicename
            }
            if ($PSBoundParameters.ContainsKey('dh')) { $Payload.Add('dh', $dh) }
            if ($PSBoundParameters.ContainsKey('dhfile')) { $Payload.Add('dhfile', $dhfile) }
            if ($PSBoundParameters.ContainsKey('dhcount')) { $Payload.Add('dhcount', $dhcount) }
            if ($PSBoundParameters.ContainsKey('dhkeyexpsizelimit')) { $Payload.Add('dhkeyexpsizelimit', $dhkeyexpsizelimit) }
            if ($PSBoundParameters.ContainsKey('ersa')) { $Payload.Add('ersa', $ersa) }
            if ($PSBoundParameters.ContainsKey('ersacount')) { $Payload.Add('ersacount', $ersacount) }
            if ($PSBoundParameters.ContainsKey('sessreuse')) { $Payload.Add('sessreuse', $sessreuse) }
            if ($PSBoundParameters.ContainsKey('sesstimeout')) { $Payload.Add('sesstimeout', $sesstimeout) }
            if ($PSBoundParameters.ContainsKey('cipherredirect')) { $Payload.Add('cipherredirect', $cipherredirect) }
            if ($PSBoundParameters.ContainsKey('cipherurl')) { $Payload.Add('cipherurl', $cipherurl) }
            if ($PSBoundParameters.ContainsKey('sslv2redirect')) { $Payload.Add('sslv2redirect', $sslv2redirect) }
            if ($PSBoundParameters.ContainsKey('sslv2url')) { $Payload.Add('sslv2url', $sslv2url) }
            if ($PSBoundParameters.ContainsKey('clientauth')) { $Payload.Add('clientauth', $clientauth) }
            if ($PSBoundParameters.ContainsKey('clientcert')) { $Payload.Add('clientcert', $clientcert) }
            if ($PSBoundParameters.ContainsKey('sslredirect')) { $Payload.Add('sslredirect', $sslredirect) }
            if ($PSBoundParameters.ContainsKey('redirectportrewrite')) { $Payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ($PSBoundParameters.ContainsKey('ssl2')) { $Payload.Add('ssl2', $ssl2) }
            if ($PSBoundParameters.ContainsKey('ssl3')) { $Payload.Add('ssl3', $ssl3) }
            if ($PSBoundParameters.ContainsKey('tls1')) { $Payload.Add('tls1', $tls1) }
            if ($PSBoundParameters.ContainsKey('tls11')) { $Payload.Add('tls11', $tls11) }
            if ($PSBoundParameters.ContainsKey('tls12')) { $Payload.Add('tls12', $tls12) }
            if ($PSBoundParameters.ContainsKey('tls13')) { $Payload.Add('tls13', $tls13) }
            if ($PSBoundParameters.ContainsKey('dtls1')) { $Payload.Add('dtls1', $dtls1) }
            if ($PSBoundParameters.ContainsKey('dtls12')) { $Payload.Add('dtls12', $dtls12) }
            if ($PSBoundParameters.ContainsKey('snienable')) { $Payload.Add('snienable', $snienable) }
            if ($PSBoundParameters.ContainsKey('ocspstapling')) { $Payload.Add('ocspstapling', $ocspstapling) }
            if ($PSBoundParameters.ContainsKey('serverauth')) { $Payload.Add('serverauth', $serverauth) }
            if ($PSBoundParameters.ContainsKey('commonname')) { $Payload.Add('commonname', $commonname) }
            if ($PSBoundParameters.ContainsKey('sendclosenotify')) { $Payload.Add('sendclosenotify', $sendclosenotify) }
            if ($PSBoundParameters.ContainsKey('dtlsprofilename')) { $Payload.Add('dtlsprofilename', $dtlsprofilename) }
            if ($PSBoundParameters.ContainsKey('sslprofile')) { $Payload.Add('sslprofile', $sslprofile) }
            if ($PSBoundParameters.ContainsKey('strictsigdigestcheck')) { $Payload.Add('strictsigdigestcheck', $strictsigdigestcheck) }
            if ($PSCmdlet.ShouldProcess("$servicename", "Unset SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslservice -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSslservice: Finished"
    }
}

function Invoke-ADCGetSslservice {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER servicename 
       Name of the SSL service. 
    .PARAMETER GetAll 
        Retreive all sslservice object(s)
    .PARAMETER Count
        If specified, the count of the sslservice object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslservice
    .EXAMPLE 
        Invoke-ADCGetSslservice -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslservice -Count
    .EXAMPLE
        Invoke-ADCGetSslservice -name <string>
    .EXAMPLE
        Invoke-ADCGetSslservice -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslservice
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice/
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
        [string]$servicename,

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
        Write-Verbose "Invoke-ADCGetSslservice: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslservice objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslservice objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslservice objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslservice configuration for property 'servicename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslservice configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslservice: Ended"
    }
}

function Invoke-ADCUpdateSslservicegroup {
<#
    .SYNOPSIS
        Update SSL configuration Object
    .DESCRIPTION
        Update SSL configuration Object 
    .PARAMETER servicegroupname 
        Name of the SSL service group for which to set advanced configuration.  
        Minimum length = 1 
    .PARAMETER sslprofile 
        Name of the SSL profile that contains SSL settings for the Service Group.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER sessreuse 
        State of session reuse. Establishing the initial handshake requires CPU-intensive public key encryption operations. With the ENABLED setting, session key exchange is avoided for session resumption requests received from the client.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sesstimeout 
        Time, in seconds, for which to keep the session active. Any session resumption request received after the timeout period will require a fresh SSL handshake and establishment of a new SSL session.  
        Default value: 300  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER ssl3 
        State of SSLv3 protocol support for the SSL service group.  
        Note: On platforms with SSL acceleration chips, if the SSL chip does not support SSLv3, this parameter cannot be set to ENABLED.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls1 
        State of TLSv1.0 protocol support for the SSL service group.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls11 
        State of TLSv1.1 protocol support for the SSL service group.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls12 
        State of TLSv1.2 protocol support for the SSL service group.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls13 
        State of TLSv1.3 protocol support for the SSL service group.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER snienable 
        State of the Server Name Indication (SNI) feature on the service. SNI helps to enable SSL encryption on multiple domains on a single virtual server or service if the domains are controlled by the same organization and share the same second-level domain name. For example, *.sports.net can be used to secure domains such as login.sports.net and help.sports.net.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ocspstapling 
        State of OCSP stapling support on the SSL virtual server. Supported only if the protocol used is higher than SSLv3. Possible values:  
        ENABLED: The appliance sends a request to the OCSP responder to check the status of the server certificate and caches the response for the specified time. If the response is valid at the time of SSL handshake with the client, the OCSP-based server certificate status is sent to the client during the handshake.  
        DISABLED: The appliance does not check the status of the server certificate.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER serverauth 
        State of server authentication support for the SSL service group.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER commonname 
        Name to be checked against the CommonName (CN) field in the server certificate bound to the SSL server.  
        Minimum length = 1 
    .PARAMETER sendclosenotify 
        Enable sending SSL Close-Notify at the end of a transaction.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER strictsigdigestcheck 
        Parameter indicating to check whether peer's certificate is signed with one of signature-hash combination supported by Citrix ADC.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created sslservicegroup item.
    .EXAMPLE
        Invoke-ADCUpdateSslservicegroup -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCUpdateSslservicegroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservicegroup/
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
        [string]$servicegroupname ,

        [ValidateLength(1, 127)]
        [string]$sslprofile ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessreuse ,

        [ValidateRange(0, 4294967294)]
        [double]$sesstimeout ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ssl3 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls1 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls11 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls12 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls13 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$snienable ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ocspstapling ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$serverauth ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$commonname ,

        [ValidateSet('YES', 'NO')]
        [string]$sendclosenotify ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$strictsigdigestcheck ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSslservicegroup: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('sslprofile')) { $Payload.Add('sslprofile', $sslprofile) }
            if ($PSBoundParameters.ContainsKey('sessreuse')) { $Payload.Add('sessreuse', $sessreuse) }
            if ($PSBoundParameters.ContainsKey('sesstimeout')) { $Payload.Add('sesstimeout', $sesstimeout) }
            if ($PSBoundParameters.ContainsKey('ssl3')) { $Payload.Add('ssl3', $ssl3) }
            if ($PSBoundParameters.ContainsKey('tls1')) { $Payload.Add('tls1', $tls1) }
            if ($PSBoundParameters.ContainsKey('tls11')) { $Payload.Add('tls11', $tls11) }
            if ($PSBoundParameters.ContainsKey('tls12')) { $Payload.Add('tls12', $tls12) }
            if ($PSBoundParameters.ContainsKey('tls13')) { $Payload.Add('tls13', $tls13) }
            if ($PSBoundParameters.ContainsKey('snienable')) { $Payload.Add('snienable', $snienable) }
            if ($PSBoundParameters.ContainsKey('ocspstapling')) { $Payload.Add('ocspstapling', $ocspstapling) }
            if ($PSBoundParameters.ContainsKey('serverauth')) { $Payload.Add('serverauth', $serverauth) }
            if ($PSBoundParameters.ContainsKey('commonname')) { $Payload.Add('commonname', $commonname) }
            if ($PSBoundParameters.ContainsKey('sendclosenotify')) { $Payload.Add('sendclosenotify', $sendclosenotify) }
            if ($PSBoundParameters.ContainsKey('strictsigdigestcheck')) { $Payload.Add('strictsigdigestcheck', $strictsigdigestcheck) }
 
            if ($PSCmdlet.ShouldProcess("sslservicegroup", "Update SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslservicegroup -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslservicegroup -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateSslservicegroup: Finished"
    }
}

function Invoke-ADCUnsetSslservicegroup {
<#
    .SYNOPSIS
        Unset SSL configuration Object
    .DESCRIPTION
        Unset SSL configuration Object 
   .PARAMETER servicegroupname 
       Name of the SSL service group for which to set advanced configuration. 
   .PARAMETER sslprofile 
       Name of the SSL profile that contains SSL settings for the Service Group. 
   .PARAMETER sessreuse 
       State of session reuse. Establishing the initial handshake requires CPU-intensive public key encryption operations. With the ENABLED setting, session key exchange is avoided for session resumption requests received from the client.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sesstimeout 
       Time, in seconds, for which to keep the session active. Any session resumption request received after the timeout period will require a fresh SSL handshake and establishment of a new SSL session. 
   .PARAMETER ssl3 
       State of SSLv3 protocol support for the SSL service group.  
       Note: On platforms with SSL acceleration chips, if the SSL chip does not support SSLv3, this parameter cannot be set to ENABLED.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tls1 
       State of TLSv1.0 protocol support for the SSL service group.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tls11 
       State of TLSv1.1 protocol support for the SSL service group.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tls12 
       State of TLSv1.2 protocol support for the SSL service group.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tls13 
       State of TLSv1.3 protocol support for the SSL service group.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER snienable 
       State of the Server Name Indication (SNI) feature on the service. SNI helps to enable SSL encryption on multiple domains on a single virtual server or service if the domains are controlled by the same organization and share the same second-level domain name. For example, *.sports.net can be used to secure domains such as login.sports.net and help.sports.net.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ocspstapling 
       State of OCSP stapling support on the SSL virtual server. Supported only if the protocol used is higher than SSLv3. Possible values:  
       ENABLED: The appliance sends a request to the OCSP responder to check the status of the server certificate and caches the response for the specified time. If the response is valid at the time of SSL handshake with the client, the OCSP-based server certificate status is sent to the client during the handshake.  
       DISABLED: The appliance does not check the status of the server certificate.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER serverauth 
       State of server authentication support for the SSL service group.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER commonname 
       Name to be checked against the CommonName (CN) field in the server certificate bound to the SSL server. 
   .PARAMETER sendclosenotify 
       Enable sending SSL Close-Notify at the end of a transaction.  
       Possible values = YES, NO 
   .PARAMETER strictsigdigestcheck 
       Parameter indicating to check whether peer's certificate is signed with one of signature-hash combination supported by Citrix ADC.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetSslservicegroup -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCUnsetSslservicegroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservicegroup
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
        [string]$servicegroupname ,

        [Boolean]$sslprofile ,

        [Boolean]$sessreuse ,

        [Boolean]$sesstimeout ,

        [Boolean]$ssl3 ,

        [Boolean]$tls1 ,

        [Boolean]$tls11 ,

        [Boolean]$tls12 ,

        [Boolean]$tls13 ,

        [Boolean]$snienable ,

        [Boolean]$ocspstapling ,

        [Boolean]$serverauth ,

        [Boolean]$commonname ,

        [Boolean]$sendclosenotify ,

        [Boolean]$strictsigdigestcheck 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSslservicegroup: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('sslprofile')) { $Payload.Add('sslprofile', $sslprofile) }
            if ($PSBoundParameters.ContainsKey('sessreuse')) { $Payload.Add('sessreuse', $sessreuse) }
            if ($PSBoundParameters.ContainsKey('sesstimeout')) { $Payload.Add('sesstimeout', $sesstimeout) }
            if ($PSBoundParameters.ContainsKey('ssl3')) { $Payload.Add('ssl3', $ssl3) }
            if ($PSBoundParameters.ContainsKey('tls1')) { $Payload.Add('tls1', $tls1) }
            if ($PSBoundParameters.ContainsKey('tls11')) { $Payload.Add('tls11', $tls11) }
            if ($PSBoundParameters.ContainsKey('tls12')) { $Payload.Add('tls12', $tls12) }
            if ($PSBoundParameters.ContainsKey('tls13')) { $Payload.Add('tls13', $tls13) }
            if ($PSBoundParameters.ContainsKey('snienable')) { $Payload.Add('snienable', $snienable) }
            if ($PSBoundParameters.ContainsKey('ocspstapling')) { $Payload.Add('ocspstapling', $ocspstapling) }
            if ($PSBoundParameters.ContainsKey('serverauth')) { $Payload.Add('serverauth', $serverauth) }
            if ($PSBoundParameters.ContainsKey('commonname')) { $Payload.Add('commonname', $commonname) }
            if ($PSBoundParameters.ContainsKey('sendclosenotify')) { $Payload.Add('sendclosenotify', $sendclosenotify) }
            if ($PSBoundParameters.ContainsKey('strictsigdigestcheck')) { $Payload.Add('strictsigdigestcheck', $strictsigdigestcheck) }
            if ($PSCmdlet.ShouldProcess("$servicegroupname", "Unset SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslservicegroup -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSslservicegroup: Finished"
    }
}

function Invoke-ADCGetSslservicegroup {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER servicegroupname 
       Name of the SSL service group for which to set advanced configuration. 
    .PARAMETER GetAll 
        Retreive all sslservicegroup object(s)
    .PARAMETER Count
        If specified, the count of the sslservicegroup object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslservicegroup
    .EXAMPLE 
        Invoke-ADCGetSslservicegroup -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslservicegroup -Count
    .EXAMPLE
        Invoke-ADCGetSslservicegroup -name <string>
    .EXAMPLE
        Invoke-ADCGetSslservicegroup -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslservicegroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservicegroup/
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
        [string]$servicegroupname,

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
        Write-Verbose "Invoke-ADCGetSslservicegroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslservicegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslservicegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslservicegroup objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslservicegroup configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslservicegroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslservicegroup: Ended"
    }
}

function Invoke-ADCGetSslservicegroupbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER servicegroupname 
       Name of the SSL service group for which to show detailed information. 
    .PARAMETER GetAll 
        Retreive all sslservicegroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslservicegroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslservicegroupbinding
    .EXAMPLE 
        Invoke-ADCGetSslservicegroupbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetSslservicegroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslservicegroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslservicegroupbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservicegroup_binding/
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
        [string]$servicegroupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslservicegroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslservicegroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslservicegroup_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_binding -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslservicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslservicegroupbinding: Ended"
    }
}

function Invoke-ADCAddSslservicegroupecccurvebinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER servicegroupname 
        The name of the SSL service to which the SSL policy needs to be bound.  
        Minimum length = 1 
    .PARAMETER ecccurvename 
        Named ECC curve bound to servicegroup.  
        Possible values = ALL, P_224, P_256, P_384, P_521 
    .PARAMETER PassThru 
        Return details about the created sslservicegroup_ecccurve_binding item.
    .EXAMPLE
        Invoke-ADCAddSslservicegroupecccurvebinding -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCAddSslservicegroupecccurvebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservicegroup_ecccurve_binding/
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
        [string]$servicegroupname ,

        [ValidateSet('ALL', 'P_224', 'P_256', 'P_384', 'P_521')]
        [string]$ecccurvename ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslservicegroupecccurvebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('ecccurvename')) { $Payload.Add('ecccurvename', $ecccurvename) }
 
            if ($PSCmdlet.ShouldProcess("sslservicegroup_ecccurve_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslservicegroup_ecccurve_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslservicegroupecccurvebinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslservicegroupecccurvebinding: Finished"
    }
}

function Invoke-ADCDeleteSslservicegroupecccurvebinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER servicegroupname 
       The name of the SSL service to which the SSL policy needs to be bound.  
       Minimum length = 1    .PARAMETER ecccurvename 
       Named ECC curve bound to servicegroup.  
       Possible values = ALL, P_224, P_256, P_384, P_521
    .EXAMPLE
        Invoke-ADCDeleteSslservicegroupecccurvebinding -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslservicegroupecccurvebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservicegroup_ecccurve_binding/
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
        [string]$servicegroupname ,

        [string]$ecccurvename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslservicegroupecccurvebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ecccurvename')) { $Arguments.Add('ecccurvename', $ecccurvename) }
            if ($PSCmdlet.ShouldProcess("$servicegroupname", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslservicegroup_ecccurve_binding -Resource $servicegroupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslservicegroupecccurvebinding: Finished"
    }
}

function Invoke-ADCGetSslservicegroupecccurvebinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER servicegroupname 
       The name of the SSL service to which the SSL policy needs to be bound. 
    .PARAMETER GetAll 
        Retreive all sslservicegroup_ecccurve_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslservicegroup_ecccurve_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslservicegroupecccurvebinding
    .EXAMPLE 
        Invoke-ADCGetSslservicegroupecccurvebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslservicegroupecccurvebinding -Count
    .EXAMPLE
        Invoke-ADCGetSslservicegroupecccurvebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslservicegroupecccurvebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslservicegroupecccurvebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservicegroup_ecccurve_binding/
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
        [string]$servicegroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslservicegroupecccurvebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslservicegroup_ecccurve_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_ecccurve_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslservicegroup_ecccurve_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_ecccurve_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslservicegroup_ecccurve_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_ecccurve_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslservicegroup_ecccurve_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_ecccurve_binding -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslservicegroup_ecccurve_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_ecccurve_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslservicegroupecccurvebinding: Ended"
    }
}

function Invoke-ADCAddSslservicegroupsslcertkeybinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER servicegroupname 
        The name of the SSL service to which the SSL policy needs to be bound.  
        Minimum length = 1 
    .PARAMETER certkeyname 
        The name of the certificate bound to the SSL service group. 
    .PARAMETER ca 
        CA certificate. 
    .PARAMETER crlcheck 
        The state of the CRL check parameter. (Mandatory/Optional).  
        Possible values = Mandatory, Optional 
    .PARAMETER snicert 
        The name of the CertKey. Use this option to bind Certkey(s) which will be used in SNI processing. 
    .PARAMETER ocspcheck 
        The state of the OCSP check parameter. (Mandatory/Optional).  
        Possible values = Mandatory, Optional 
    .PARAMETER PassThru 
        Return details about the created sslservicegroup_sslcertkey_binding item.
    .EXAMPLE
        Invoke-ADCAddSslservicegroupsslcertkeybinding -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCAddSslservicegroupsslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservicegroup_sslcertkey_binding/
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
        [string]$servicegroupname ,

        [string]$certkeyname ,

        [boolean]$ca ,

        [ValidateSet('Mandatory', 'Optional')]
        [string]$crlcheck ,

        [boolean]$snicert ,

        [ValidateSet('Mandatory', 'Optional')]
        [string]$ocspcheck ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslservicegroupsslcertkeybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('certkeyname')) { $Payload.Add('certkeyname', $certkeyname) }
            if ($PSBoundParameters.ContainsKey('ca')) { $Payload.Add('ca', $ca) }
            if ($PSBoundParameters.ContainsKey('crlcheck')) { $Payload.Add('crlcheck', $crlcheck) }
            if ($PSBoundParameters.ContainsKey('snicert')) { $Payload.Add('snicert', $snicert) }
            if ($PSBoundParameters.ContainsKey('ocspcheck')) { $Payload.Add('ocspcheck', $ocspcheck) }
 
            if ($PSCmdlet.ShouldProcess("sslservicegroup_sslcertkey_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslservicegroup_sslcertkey_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslservicegroupsslcertkeybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslservicegroupsslcertkeybinding: Finished"
    }
}

function Invoke-ADCDeleteSslservicegroupsslcertkeybinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER servicegroupname 
       The name of the SSL service to which the SSL policy needs to be bound.  
       Minimum length = 1    .PARAMETER certkeyname 
       The name of the certificate bound to the SSL service group.    .PARAMETER ca 
       CA certificate.    .PARAMETER crlcheck 
       The state of the CRL check parameter. (Mandatory/Optional).  
       Possible values = Mandatory, Optional    .PARAMETER snicert 
       The name of the CertKey. Use this option to bind Certkey(s) which will be used in SNI processing.
    .EXAMPLE
        Invoke-ADCDeleteSslservicegroupsslcertkeybinding -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslservicegroupsslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservicegroup_sslcertkey_binding/
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
        [string]$servicegroupname ,

        [string]$certkeyname ,

        [boolean]$ca ,

        [string]$crlcheck ,

        [boolean]$snicert 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslservicegroupsslcertkeybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('certkeyname')) { $Arguments.Add('certkeyname', $certkeyname) }
            if ($PSBoundParameters.ContainsKey('ca')) { $Arguments.Add('ca', $ca) }
            if ($PSBoundParameters.ContainsKey('crlcheck')) { $Arguments.Add('crlcheck', $crlcheck) }
            if ($PSBoundParameters.ContainsKey('snicert')) { $Arguments.Add('snicert', $snicert) }
            if ($PSCmdlet.ShouldProcess("$servicegroupname", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslservicegroup_sslcertkey_binding -Resource $servicegroupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslservicegroupsslcertkeybinding: Finished"
    }
}

function Invoke-ADCGetSslservicegroupsslcertkeybinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER servicegroupname 
       The name of the SSL service to which the SSL policy needs to be bound. 
    .PARAMETER GetAll 
        Retreive all sslservicegroup_sslcertkey_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslservicegroup_sslcertkey_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslservicegroupsslcertkeybinding
    .EXAMPLE 
        Invoke-ADCGetSslservicegroupsslcertkeybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslservicegroupsslcertkeybinding -Count
    .EXAMPLE
        Invoke-ADCGetSslservicegroupsslcertkeybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslservicegroupsslcertkeybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslservicegroupsslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservicegroup_sslcertkey_binding/
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
        [string]$servicegroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslservicegroupsslcertkeybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslservicegroup_sslcertkey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_sslcertkey_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslservicegroup_sslcertkey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_sslcertkey_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslservicegroup_sslcertkey_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_sslcertkey_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslservicegroup_sslcertkey_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_sslcertkey_binding -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslservicegroup_sslcertkey_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_sslcertkey_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslservicegroupsslcertkeybinding: Ended"
    }
}

function Invoke-ADCAddSslservicegroupsslciphersuitebinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER servicegroupname 
        The name of the SSL service to which the SSL policy needs to be bound.  
        Minimum length = 1 
    .PARAMETER ciphername 
        The name of the cipher group/alias/name configured for the SSL service group. 
    .PARAMETER PassThru 
        Return details about the created sslservicegroup_sslciphersuite_binding item.
    .EXAMPLE
        Invoke-ADCAddSslservicegroupsslciphersuitebinding -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCAddSslservicegroupsslciphersuitebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservicegroup_sslciphersuite_binding/
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
        [string]$servicegroupname ,

        [string]$ciphername ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslservicegroupsslciphersuitebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Payload.Add('ciphername', $ciphername) }
 
            if ($PSCmdlet.ShouldProcess("sslservicegroup_sslciphersuite_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslservicegroup_sslciphersuite_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslservicegroupsslciphersuitebinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslservicegroupsslciphersuitebinding: Finished"
    }
}

function Invoke-ADCDeleteSslservicegroupsslciphersuitebinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER servicegroupname 
       The name of the SSL service to which the SSL policy needs to be bound.  
       Minimum length = 1    .PARAMETER ciphername 
       The name of the cipher group/alias/name configured for the SSL service group.
    .EXAMPLE
        Invoke-ADCDeleteSslservicegroupsslciphersuitebinding -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslservicegroupsslciphersuitebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservicegroup_sslciphersuite_binding/
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
        [string]$servicegroupname ,

        [string]$ciphername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslservicegroupsslciphersuitebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Arguments.Add('ciphername', $ciphername) }
            if ($PSCmdlet.ShouldProcess("$servicegroupname", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslservicegroup_sslciphersuite_binding -Resource $servicegroupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslservicegroupsslciphersuitebinding: Finished"
    }
}

function Invoke-ADCGetSslservicegroupsslciphersuitebinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER servicegroupname 
       The name of the SSL service to which the SSL policy needs to be bound. 
    .PARAMETER GetAll 
        Retreive all sslservicegroup_sslciphersuite_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslservicegroup_sslciphersuite_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslservicegroupsslciphersuitebinding
    .EXAMPLE 
        Invoke-ADCGetSslservicegroupsslciphersuitebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslservicegroupsslciphersuitebinding -Count
    .EXAMPLE
        Invoke-ADCGetSslservicegroupsslciphersuitebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslservicegroupsslciphersuitebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslservicegroupsslciphersuitebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservicegroup_sslciphersuite_binding/
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
        [string]$servicegroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslservicegroupsslciphersuitebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslservicegroup_sslciphersuite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_sslciphersuite_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslservicegroup_sslciphersuite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_sslciphersuite_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslservicegroup_sslciphersuite_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_sslciphersuite_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslservicegroup_sslciphersuite_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_sslciphersuite_binding -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslservicegroup_sslciphersuite_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_sslciphersuite_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslservicegroupsslciphersuitebinding: Ended"
    }
}

function Invoke-ADCAddSslservicegroupsslcipherbinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER servicegroupname 
        The name of the SSL service to which the SSL policy needs to be bound.  
        Minimum length = 1 
    .PARAMETER ciphername 
        A cipher-suite can consist of an individual cipher name, the system predefined cipher-alias name, or user defined cipher-group name. 
    .PARAMETER PassThru 
        Return details about the created sslservicegroup_sslcipher_binding item.
    .EXAMPLE
        Invoke-ADCAddSslservicegroupsslcipherbinding -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCAddSslservicegroupsslcipherbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservicegroup_sslcipher_binding/
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
        [string]$servicegroupname ,

        [string]$ciphername ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslservicegroupsslcipherbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Payload.Add('ciphername', $ciphername) }
 
            if ($PSCmdlet.ShouldProcess("sslservicegroup_sslcipher_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslservicegroup_sslcipher_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslservicegroupsslcipherbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslservicegroupsslcipherbinding: Finished"
    }
}

function Invoke-ADCDeleteSslservicegroupsslcipherbinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER servicegroupname 
       The name of the SSL service to which the SSL policy needs to be bound.  
       Minimum length = 1    .PARAMETER ciphername 
       A cipher-suite can consist of an individual cipher name, the system predefined cipher-alias name, or user defined cipher-group name.
    .EXAMPLE
        Invoke-ADCDeleteSslservicegroupsslcipherbinding -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslservicegroupsslcipherbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservicegroup_sslcipher_binding/
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
        [string]$servicegroupname ,

        [string]$ciphername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslservicegroupsslcipherbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Arguments.Add('ciphername', $ciphername) }
            if ($PSCmdlet.ShouldProcess("$servicegroupname", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslservicegroup_sslcipher_binding -Resource $servicegroupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslservicegroupsslcipherbinding: Finished"
    }
}

function Invoke-ADCGetSslservicegroupsslcipherbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER servicegroupname 
       The name of the SSL service to which the SSL policy needs to be bound. 
    .PARAMETER GetAll 
        Retreive all sslservicegroup_sslcipher_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslservicegroup_sslcipher_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslservicegroupsslcipherbinding
    .EXAMPLE 
        Invoke-ADCGetSslservicegroupsslcipherbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslservicegroupsslcipherbinding -Count
    .EXAMPLE
        Invoke-ADCGetSslservicegroupsslcipherbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslservicegroupsslcipherbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslservicegroupsslcipherbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservicegroup_sslcipher_binding/
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
        [string]$servicegroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslservicegroupsslcipherbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslservicegroup_sslcipher_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_sslcipher_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslservicegroup_sslcipher_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_sslcipher_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslservicegroup_sslcipher_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_sslcipher_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslservicegroup_sslcipher_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_sslcipher_binding -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslservicegroup_sslcipher_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservicegroup_sslcipher_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslservicegroupsslcipherbinding: Ended"
    }
}

function Invoke-ADCGetSslservicebinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER servicename 
       Name of the SSL service for which to show detailed information. 
    .PARAMETER GetAll 
        Retreive all sslservice_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslservice_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslservicebinding
    .EXAMPLE 
        Invoke-ADCGetSslservicebinding -GetAll
    .EXAMPLE
        Invoke-ADCGetSslservicebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslservicebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslservicebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice_binding/
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
        [string]$servicename,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslservicebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslservice_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslservice_binding configuration for property 'servicename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_binding -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslservice_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslservicebinding: Ended"
    }
}

function Invoke-ADCAddSslserviceecccurvebinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER servicename 
        Name of the SSL service for which to set advanced configuration.  
        Minimum length = 1 
    .PARAMETER ecccurvename 
        Named ECC curve bound to service/vserver.  
        Possible values = ALL, P_224, P_256, P_384, P_521 
    .PARAMETER PassThru 
        Return details about the created sslservice_ecccurve_binding item.
    .EXAMPLE
        Invoke-ADCAddSslserviceecccurvebinding -servicename <string>
    .NOTES
        File Name : Invoke-ADCAddSslserviceecccurvebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice_ecccurve_binding/
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
        [string]$servicename ,

        [ValidateSet('ALL', 'P_224', 'P_256', 'P_384', 'P_521')]
        [string]$ecccurvename ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslserviceecccurvebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                servicename = $servicename
            }
            if ($PSBoundParameters.ContainsKey('ecccurvename')) { $Payload.Add('ecccurvename', $ecccurvename) }
 
            if ($PSCmdlet.ShouldProcess("sslservice_ecccurve_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslservice_ecccurve_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslserviceecccurvebinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslserviceecccurvebinding: Finished"
    }
}

function Invoke-ADCDeleteSslserviceecccurvebinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER servicename 
       Name of the SSL service for which to set advanced configuration.  
       Minimum length = 1    .PARAMETER ecccurvename 
       Named ECC curve bound to service/vserver.  
       Possible values = ALL, P_224, P_256, P_384, P_521
    .EXAMPLE
        Invoke-ADCDeleteSslserviceecccurvebinding -servicename <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslserviceecccurvebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice_ecccurve_binding/
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
        [string]$servicename ,

        [string]$ecccurvename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslserviceecccurvebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ecccurvename')) { $Arguments.Add('ecccurvename', $ecccurvename) }
            if ($PSCmdlet.ShouldProcess("$servicename", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslservice_ecccurve_binding -Resource $servicename -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslserviceecccurvebinding: Finished"
    }
}

function Invoke-ADCGetSslserviceecccurvebinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER servicename 
       Name of the SSL service for which to set advanced configuration. 
    .PARAMETER GetAll 
        Retreive all sslservice_ecccurve_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslservice_ecccurve_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslserviceecccurvebinding
    .EXAMPLE 
        Invoke-ADCGetSslserviceecccurvebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslserviceecccurvebinding -Count
    .EXAMPLE
        Invoke-ADCGetSslserviceecccurvebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslserviceecccurvebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslserviceecccurvebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice_ecccurve_binding/
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
        [string]$servicename,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslserviceecccurvebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslservice_ecccurve_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_ecccurve_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslservice_ecccurve_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_ecccurve_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslservice_ecccurve_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_ecccurve_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslservice_ecccurve_binding configuration for property 'servicename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_ecccurve_binding -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslservice_ecccurve_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_ecccurve_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslserviceecccurvebinding: Ended"
    }
}

function Invoke-ADCAddSslservicesslcertkeybinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER servicename 
        Name of the SSL service for which to set advanced configuration.  
        Minimum length = 1 
    .PARAMETER certkeyname 
        The certificate key pair binding. 
    .PARAMETER ca 
        CA certificate. 
    .PARAMETER crlcheck 
        The state of the CRL check parameter. (Mandatory/Optional).  
        Possible values = Mandatory, Optional 
    .PARAMETER skipcaname 
        The flag is used to indicate whether this particular CA certificate's CA_Name needs to be sent to the SSL client while requesting for client certificate in a SSL handshake. 
    .PARAMETER snicert 
        The name of the CertKey. Use this option to bind Certkey(s) which will be used in SNI processing. 
    .PARAMETER ocspcheck 
        Rule to use for the OCSP responder associated with the CA certificate during client authentication. If MANDATORY is specified, deny all SSL clients if the OCSP check fails because of connectivity issues with the remote OCSP server, or any other reason that prevents the OCSP check. With the OPTIONAL setting, allow SSL clients even if the OCSP check fails except when the client certificate is revoked.  
        Possible values = Mandatory, Optional 
    .PARAMETER PassThru 
        Return details about the created sslservice_sslcertkey_binding item.
    .EXAMPLE
        Invoke-ADCAddSslservicesslcertkeybinding -servicename <string>
    .NOTES
        File Name : Invoke-ADCAddSslservicesslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice_sslcertkey_binding/
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
        [string]$servicename ,

        [string]$certkeyname ,

        [boolean]$ca ,

        [ValidateSet('Mandatory', 'Optional')]
        [string]$crlcheck ,

        [boolean]$skipcaname ,

        [boolean]$snicert ,

        [ValidateSet('Mandatory', 'Optional')]
        [string]$ocspcheck ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslservicesslcertkeybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                servicename = $servicename
            }
            if ($PSBoundParameters.ContainsKey('certkeyname')) { $Payload.Add('certkeyname', $certkeyname) }
            if ($PSBoundParameters.ContainsKey('ca')) { $Payload.Add('ca', $ca) }
            if ($PSBoundParameters.ContainsKey('crlcheck')) { $Payload.Add('crlcheck', $crlcheck) }
            if ($PSBoundParameters.ContainsKey('skipcaname')) { $Payload.Add('skipcaname', $skipcaname) }
            if ($PSBoundParameters.ContainsKey('snicert')) { $Payload.Add('snicert', $snicert) }
            if ($PSBoundParameters.ContainsKey('ocspcheck')) { $Payload.Add('ocspcheck', $ocspcheck) }
 
            if ($PSCmdlet.ShouldProcess("sslservice_sslcertkey_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslservice_sslcertkey_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslservicesslcertkeybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslservicesslcertkeybinding: Finished"
    }
}

function Invoke-ADCDeleteSslservicesslcertkeybinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER servicename 
       Name of the SSL service for which to set advanced configuration.  
       Minimum length = 1    .PARAMETER certkeyname 
       The certificate key pair binding.    .PARAMETER ca 
       CA certificate.    .PARAMETER crlcheck 
       The state of the CRL check parameter. (Mandatory/Optional).  
       Possible values = Mandatory, Optional    .PARAMETER snicert 
       The name of the CertKey. Use this option to bind Certkey(s) which will be used in SNI processing.
    .EXAMPLE
        Invoke-ADCDeleteSslservicesslcertkeybinding -servicename <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslservicesslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice_sslcertkey_binding/
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
        [string]$servicename ,

        [string]$certkeyname ,

        [boolean]$ca ,

        [string]$crlcheck ,

        [boolean]$snicert 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslservicesslcertkeybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('certkeyname')) { $Arguments.Add('certkeyname', $certkeyname) }
            if ($PSBoundParameters.ContainsKey('ca')) { $Arguments.Add('ca', $ca) }
            if ($PSBoundParameters.ContainsKey('crlcheck')) { $Arguments.Add('crlcheck', $crlcheck) }
            if ($PSBoundParameters.ContainsKey('snicert')) { $Arguments.Add('snicert', $snicert) }
            if ($PSCmdlet.ShouldProcess("$servicename", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslservice_sslcertkey_binding -Resource $servicename -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslservicesslcertkeybinding: Finished"
    }
}

function Invoke-ADCGetSslservicesslcertkeybinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER servicename 
       Name of the SSL service for which to set advanced configuration. 
    .PARAMETER GetAll 
        Retreive all sslservice_sslcertkey_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslservice_sslcertkey_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslservicesslcertkeybinding
    .EXAMPLE 
        Invoke-ADCGetSslservicesslcertkeybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslservicesslcertkeybinding -Count
    .EXAMPLE
        Invoke-ADCGetSslservicesslcertkeybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslservicesslcertkeybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslservicesslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice_sslcertkey_binding/
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
        [string]$servicename,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslservicesslcertkeybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslservice_sslcertkey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslcertkey_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslservice_sslcertkey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslcertkey_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslservice_sslcertkey_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslcertkey_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslservice_sslcertkey_binding configuration for property 'servicename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslcertkey_binding -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslservice_sslcertkey_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslcertkey_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslservicesslcertkeybinding: Ended"
    }
}

function Invoke-ADCAddSslservicesslciphersuitebinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER servicename 
        Name of the SSL service for which to set advanced configuration.  
        Minimum length = 1 
    .PARAMETER ciphername 
        The cipher group/alias/individual cipher configuration. 
    .PARAMETER PassThru 
        Return details about the created sslservice_sslciphersuite_binding item.
    .EXAMPLE
        Invoke-ADCAddSslservicesslciphersuitebinding -servicename <string>
    .NOTES
        File Name : Invoke-ADCAddSslservicesslciphersuitebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice_sslciphersuite_binding/
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
        [string]$servicename ,

        [string]$ciphername ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslservicesslciphersuitebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                servicename = $servicename
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Payload.Add('ciphername', $ciphername) }
 
            if ($PSCmdlet.ShouldProcess("sslservice_sslciphersuite_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslservice_sslciphersuite_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslservicesslciphersuitebinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslservicesslciphersuitebinding: Finished"
    }
}

function Invoke-ADCDeleteSslservicesslciphersuitebinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER servicename 
       Name of the SSL service for which to set advanced configuration.  
       Minimum length = 1    .PARAMETER ciphername 
       The cipher group/alias/individual cipher configuration.
    .EXAMPLE
        Invoke-ADCDeleteSslservicesslciphersuitebinding -servicename <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslservicesslciphersuitebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice_sslciphersuite_binding/
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
        [string]$servicename ,

        [string]$ciphername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslservicesslciphersuitebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Arguments.Add('ciphername', $ciphername) }
            if ($PSCmdlet.ShouldProcess("$servicename", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslservice_sslciphersuite_binding -Resource $servicename -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslservicesslciphersuitebinding: Finished"
    }
}

function Invoke-ADCGetSslservicesslciphersuitebinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER servicename 
       Name of the SSL service for which to set advanced configuration. 
    .PARAMETER GetAll 
        Retreive all sslservice_sslciphersuite_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslservice_sslciphersuite_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslservicesslciphersuitebinding
    .EXAMPLE 
        Invoke-ADCGetSslservicesslciphersuitebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslservicesslciphersuitebinding -Count
    .EXAMPLE
        Invoke-ADCGetSslservicesslciphersuitebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslservicesslciphersuitebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslservicesslciphersuitebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice_sslciphersuite_binding/
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
        [string]$servicename,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslservicesslciphersuitebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslservice_sslciphersuite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslciphersuite_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslservice_sslciphersuite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslciphersuite_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslservice_sslciphersuite_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslciphersuite_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslservice_sslciphersuite_binding configuration for property 'servicename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslciphersuite_binding -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslservice_sslciphersuite_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslciphersuite_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslservicesslciphersuitebinding: Ended"
    }
}

function Invoke-ADCAddSslservicesslcipherbinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER servicename 
        Name of the SSL service for which to set advanced configuration.  
        Minimum length = 1 
    .PARAMETER ciphername 
        Name of the individual cipher, user-defined cipher group, or predefined (built-in) cipher alias. 
    .PARAMETER PassThru 
        Return details about the created sslservice_sslcipher_binding item.
    .EXAMPLE
        Invoke-ADCAddSslservicesslcipherbinding -servicename <string>
    .NOTES
        File Name : Invoke-ADCAddSslservicesslcipherbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice_sslcipher_binding/
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
        [string]$servicename ,

        [string]$ciphername ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslservicesslcipherbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                servicename = $servicename
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Payload.Add('ciphername', $ciphername) }
 
            if ($PSCmdlet.ShouldProcess("sslservice_sslcipher_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslservice_sslcipher_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslservicesslcipherbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslservicesslcipherbinding: Finished"
    }
}

function Invoke-ADCDeleteSslservicesslcipherbinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER servicename 
       Name of the SSL service for which to set advanced configuration.  
       Minimum length = 1    .PARAMETER ciphername 
       Name of the individual cipher, user-defined cipher group, or predefined (built-in) cipher alias.
    .EXAMPLE
        Invoke-ADCDeleteSslservicesslcipherbinding -servicename <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslservicesslcipherbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice_sslcipher_binding/
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
        [string]$servicename ,

        [string]$ciphername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslservicesslcipherbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Arguments.Add('ciphername', $ciphername) }
            if ($PSCmdlet.ShouldProcess("$servicename", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslservice_sslcipher_binding -Resource $servicename -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslservicesslcipherbinding: Finished"
    }
}

function Invoke-ADCGetSslservicesslcipherbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER servicename 
       Name of the SSL service for which to set advanced configuration. 
    .PARAMETER GetAll 
        Retreive all sslservice_sslcipher_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslservice_sslcipher_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslservicesslcipherbinding
    .EXAMPLE 
        Invoke-ADCGetSslservicesslcipherbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslservicesslcipherbinding -Count
    .EXAMPLE
        Invoke-ADCGetSslservicesslcipherbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslservicesslcipherbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslservicesslcipherbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice_sslcipher_binding/
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
        [string]$servicename,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslservicesslcipherbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslservice_sslcipher_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslcipher_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslservice_sslcipher_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslcipher_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslservice_sslcipher_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslcipher_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslservice_sslcipher_binding configuration for property 'servicename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslcipher_binding -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslservice_sslcipher_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslcipher_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslservicesslcipherbinding: Ended"
    }
}

function Invoke-ADCAddSslservicesslpolicybinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER servicename 
        Name of the SSL service for which to set advanced configuration.  
        Minimum length = 1 
    .PARAMETER policyname 
        The SSL policy binding. 
    .PARAMETER priority 
        The priority of the policies bound to this SSL service.  
        Minimum value = 0  
        Maximum value = 65534 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER invoke 
        Invoke flag. This attribute is relevant only for ADVANCED policies. 
    .PARAMETER labeltype 
        Type of policy label invocation.  
        Possible values = vserver, service, policylabel 
    .PARAMETER labelname 
        Name of the label to invoke if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created sslservice_sslpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddSslservicesslpolicybinding -servicename <string>
    .NOTES
        File Name : Invoke-ADCAddSslservicesslpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice_sslpolicy_binding/
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
        [string]$servicename ,

        [string]$policyname ,

        [ValidateRange(0, 65534)]
        [double]$priority ,

        [string]$gotopriorityexpression ,

        [boolean]$invoke ,

        [ValidateSet('vserver', 'service', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslservicesslpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                servicename = $servicename
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("sslservice_sslpolicy_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslservice_sslpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslservicesslpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslservicesslpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteSslservicesslpolicybinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER servicename 
       Name of the SSL service for which to set advanced configuration.  
       Minimum length = 1    .PARAMETER policyname 
       The SSL policy binding.    .PARAMETER priority 
       The priority of the policies bound to this SSL service.  
       Minimum value = 0  
       Maximum value = 65534
    .EXAMPLE
        Invoke-ADCDeleteSslservicesslpolicybinding -servicename <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslservicesslpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice_sslpolicy_binding/
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
        [string]$servicename ,

        [string]$policyname ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslservicesslpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$servicename", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslservice_sslpolicy_binding -Resource $servicename -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslservicesslpolicybinding: Finished"
    }
}

function Invoke-ADCGetSslservicesslpolicybinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER servicename 
       Name of the SSL service for which to set advanced configuration. 
    .PARAMETER GetAll 
        Retreive all sslservice_sslpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslservice_sslpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslservicesslpolicybinding
    .EXAMPLE 
        Invoke-ADCGetSslservicesslpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslservicesslpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetSslservicesslpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslservicesslpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslservicesslpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslservice_sslpolicy_binding/
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
        [string]$servicename,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslservicesslpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslservice_sslpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslservice_sslpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslservice_sslpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslservice_sslpolicy_binding configuration for property 'servicename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslpolicy_binding -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslservice_sslpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslservice_sslpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslservicesslpolicybinding: Ended"
    }
}

function Invoke-ADCUpdateSslvserver {
<#
    .SYNOPSIS
        Update SSL configuration Object
    .DESCRIPTION
        Update SSL configuration Object 
    .PARAMETER vservername 
        Name of the SSL virtual server for which to set advanced configuration.  
        Minimum length = 1 
    .PARAMETER cleartextport 
        Port on which clear-text data is sent by the appliance to the server. Do not specify this parameter for SSL offloading with end-to-end encryption.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 65534 
    .PARAMETER dh 
        State of Diffie-Hellman (DH) key exchange.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dhfile 
        Name of and, optionally, path to the DH parameter file, in PEM format, to be installed. /nsconfig/ssl/ is the default path.  
        Minimum length = 1 
    .PARAMETER dhcount 
        Number of interactions, between the client and the Citrix ADC, after which the DH private-public pair is regenerated. A value of zero (0) specifies infinite use (no refresh).  
        Minimum value = 0  
        Maximum value = 65534 
    .PARAMETER dhkeyexpsizelimit 
        This option enables the use of NIST recommended (NIST Special Publication 800-56A) bit size for private-key size. For example, for DH params of size 2048bit, the private-key size recommended is 224bits. This is rounded-up to 256bits.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ersa 
        State of Ephemeral RSA (eRSA) key exchange. Ephemeral RSA allows clients that support only export ciphers to communicate with the secure server even if the server certificate does not support export clients. The ephemeral RSA key is automatically generated when you bind an export cipher to an SSL or TCP-based SSL virtual server or service. When you remove the export cipher, the eRSA key is not deleted. It is reused at a later date when another export cipher is bound to an SSL or TCP-based SSL virtual server or service. The eRSA key is deleted when the appliance restarts.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ersacount 
        Refresh count for regeneration of the RSA public-key and private-key pair. Zero (0) specifies infinite usage (no refresh).  
        Minimum value = 0  
        Maximum value = 65534 
    .PARAMETER sessreuse 
        State of session reuse. Establishing the initial handshake requires CPU-intensive public key encryption operations. With the ENABLED setting, session key exchange is avoided for session resumption requests received from the client.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sesstimeout 
        Time, in seconds, for which to keep the session active. Any session resumption request received after the timeout period will require a fresh SSL handshake and establishment of a new SSL session.  
        Default value: 120  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER cipherredirect 
        State of Cipher Redirect. If cipher redirect is enabled, you can configure an SSL virtual server or service to display meaningful error messages if the SSL handshake fails because of a cipher mismatch between the virtual server or service and the client.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cipherurl 
        The redirect URL to be used with the Cipher Redirect feature. 
    .PARAMETER sslv2redirect 
        State of SSLv2 Redirect. If SSLv2 redirect is enabled, you can configure an SSL virtual server or service to display meaningful error messages if the SSL handshake fails because of a protocol version mismatch between the virtual server or service and the client.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sslv2url 
        URL of the page to which to redirect the client in case of a protocol version mismatch. Typically, this page has a clear explanation of the error or an alternative location that the transaction can continue from. 
    .PARAMETER clientauth 
        State of client authentication. If client authentication is enabled, the virtual server terminates the SSL handshake if the SSL client does not provide a valid certificate.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER clientcert 
        Type of client authentication. If this parameter is set to MANDATORY, the appliance terminates the SSL handshake if the SSL client does not provide a valid certificate. With the OPTIONAL setting, the appliance requests a certificate from the SSL clients but proceeds with the SSL transaction even if the client presents an invalid certificate.  
        Caution: Define proper access control policies before changing this setting to Optional.  
        Possible values = Mandatory, Optional 
    .PARAMETER sslredirect 
        State of HTTPS redirects for the SSL virtual server.  
        For an SSL session, if the client browser receives a redirect message, the browser tries to connect to the new location. However, the secure SSL session breaks if the object has moved from a secure site (https://) to an unsecure site (http://). Typically, a warning message appears on the screen, prompting the user to continue or disconnect.  
        If SSL Redirect is ENABLED, the redirect message is automatically converted from http:// to https:// and the SSL session does not break.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER redirectportrewrite 
        State of the port rewrite while performing HTTPS redirect. If this parameter is ENABLED and the URL from the server does not contain the standard port, the port is rewritten to the standard.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ssl2 
        State of SSLv2 protocol support for the SSL Virtual Server.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ssl3 
        State of SSLv3 protocol support for the SSL Virtual Server.  
        Note: On platforms with SSL acceleration chips, if the SSL chip does not support SSLv3, this parameter cannot be set to ENABLED.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls1 
        State of TLSv1.0 protocol support for the SSL Virtual Server.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls11 
        State of TLSv1.1 protocol support for the SSL Virtual Server.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls12 
        State of TLSv1.2 protocol support for the SSL Virtual Server.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls13 
        State of TLSv1.3 protocol support for the SSL Virtual Server.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dtls1 
        State of DTLSv1.0 protocol support for the SSL Virtual Server.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dtls12 
        State of DTLSv1.2 protocol support for the SSL Virtual Server.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER snienable 
        State of the Server Name Indication (SNI) feature on the virtual server and service-based offload. SNI helps to enable SSL encryption on multiple domains on a single virtual server or service if the domains are controlled by the same organization and share the same second-level domain name. For example, *.sports.net can be used to secure domains such as login.sports.net and help.sports.net.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ocspstapling 
        State of OCSP stapling support on the SSL virtual server. Supported only if the protocol used is higher than SSLv3. Possible values:  
        ENABLED: The appliance sends a request to the OCSP responder to check the status of the server certificate and caches the response for the specified time. If the response is valid at the time of SSL handshake with the client, the OCSP-based server certificate status is sent to the client during the handshake.  
        DISABLED: The appliance does not check the status of the server certificate. .  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER pushenctrigger 
        Trigger encryption on the basis of the PUSH flag value. Available settings function as follows:  
        * ALWAYS - Any PUSH packet triggers encryption.  
        * IGNORE - Ignore PUSH packet for triggering encryption.  
        * MERGE - For a consecutive sequence of PUSH packets, the last PUSH packet triggers encryption.  
        * TIMER - PUSH packet triggering encryption is delayed by the time defined in the set ssl parameter command or in the Change Advanced SSL Settings dialog box.  
        Possible values = Always, Merge, Ignore, Timer 
    .PARAMETER sendclosenotify 
        Enable sending SSL Close-Notify at the end of a transaction.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER dtlsprofilename 
        Name of the DTLS profile whose settings are to be applied to the virtual server.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER sslprofile 
        Name of the SSL profile that contains SSL settings for the virtual server.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER hsts 
        State of HSTS protocol support for the SSL Virtual Server. Using HSTS, a server can enforce the use of an HTTPS connection for all communication with a client.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER maxage 
        Set the maximum time, in seconds, in the strict transport security (STS) header during which the client must send only HTTPS requests to the server.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER includesubdomains 
        Enable HSTS for subdomains. If set to Yes, a client must send only HTTPS requests for subdomains.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER preload 
        Flag indicates the consent of the site owner to have their domain preloaded.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER strictsigdigestcheck 
        Parameter indicating to check whether peer entity certificate during TLS1.2 handshake is signed with one of signature-hash combination supported by Citrix ADC.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER zerorttearlydata 
        State of TLS 1.3 0-RTT early data support for the SSL Virtual Server. This setting only has an effect if resumption is enabled, as early data cannot be sent along with an initial handshake.  
        Early application data has significantly different security properties - in particular there is no guarantee that the data cannot be replayed.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tls13sessionticketsperauthcontext 
        Number of tickets the SSL Virtual Server will issue anytime TLS 1.3 is negotiated, ticket-based resumption is enabled, and either (1) a handshake completes or (2) post-handhsake client auth completes.  
        This value can be increased to enable clients to open multiple parallel connections using a fresh ticket for each connection.  
        No tickets are sent if resumption is disabled.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 10 
    .PARAMETER dhekeyexchangewithpsk 
        Whether or not the SSL Virtual Server will require a DHE key exchange to occur when a PSK is accepted during a TLS 1.3 resumption handshake.  
        A DHE key exchange ensures forward secrecy even in the event that ticket keys are compromised, at the expense of an additional round trip and resources required to carry out the DHE key exchange.  
        If disabled, a DHE key exchange will be performed when a PSK is accepted but only if requested by the client.  
        If enabled, the server will require a DHE key exchange when a PSK is accepted regardless of whether the client supports combined PSK-DHE key exchange. This setting only has an effect when resumption is enabled.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER PassThru 
        Return details about the created sslvserver item.
    .EXAMPLE
        Invoke-ADCUpdateSslvserver -vservername <string>
    .NOTES
        File Name : Invoke-ADCUpdateSslvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver/
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
        [string]$vservername ,

        [ValidateRange(0, 65534)]
        [int]$cleartextport ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dh ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$dhfile ,

        [ValidateRange(0, 65534)]
        [double]$dhcount ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dhkeyexpsizelimit ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ersa ,

        [ValidateRange(0, 65534)]
        [double]$ersacount ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessreuse ,

        [ValidateRange(0, 4294967294)]
        [double]$sesstimeout ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cipherredirect ,

        [string]$cipherurl ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslv2redirect ,

        [string]$sslv2url ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$clientauth ,

        [ValidateSet('Mandatory', 'Optional')]
        [string]$clientcert ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslredirect ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$redirectportrewrite ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ssl2 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ssl3 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls1 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls11 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls12 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tls13 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dtls1 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dtls12 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$snienable ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ocspstapling ,

        [ValidateSet('Always', 'Merge', 'Ignore', 'Timer')]
        [string]$pushenctrigger ,

        [ValidateSet('YES', 'NO')]
        [string]$sendclosenotify ,

        [ValidateLength(1, 127)]
        [string]$dtlsprofilename ,

        [ValidateLength(1, 127)]
        [string]$sslprofile ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$hsts ,

        [ValidateRange(0, 4294967294)]
        [double]$maxage ,

        [ValidateSet('YES', 'NO')]
        [string]$includesubdomains ,

        [ValidateSet('YES', 'NO')]
        [string]$preload ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$strictsigdigestcheck ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$zerorttearlydata ,

        [ValidateRange(1, 10)]
        [double]$tls13sessionticketsperauthcontext ,

        [ValidateSet('YES', 'NO')]
        [string]$dhekeyexchangewithpsk ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSslvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                vservername = $vservername
            }
            if ($PSBoundParameters.ContainsKey('cleartextport')) { $Payload.Add('cleartextport', $cleartextport) }
            if ($PSBoundParameters.ContainsKey('dh')) { $Payload.Add('dh', $dh) }
            if ($PSBoundParameters.ContainsKey('dhfile')) { $Payload.Add('dhfile', $dhfile) }
            if ($PSBoundParameters.ContainsKey('dhcount')) { $Payload.Add('dhcount', $dhcount) }
            if ($PSBoundParameters.ContainsKey('dhkeyexpsizelimit')) { $Payload.Add('dhkeyexpsizelimit', $dhkeyexpsizelimit) }
            if ($PSBoundParameters.ContainsKey('ersa')) { $Payload.Add('ersa', $ersa) }
            if ($PSBoundParameters.ContainsKey('ersacount')) { $Payload.Add('ersacount', $ersacount) }
            if ($PSBoundParameters.ContainsKey('sessreuse')) { $Payload.Add('sessreuse', $sessreuse) }
            if ($PSBoundParameters.ContainsKey('sesstimeout')) { $Payload.Add('sesstimeout', $sesstimeout) }
            if ($PSBoundParameters.ContainsKey('cipherredirect')) { $Payload.Add('cipherredirect', $cipherredirect) }
            if ($PSBoundParameters.ContainsKey('cipherurl')) { $Payload.Add('cipherurl', $cipherurl) }
            if ($PSBoundParameters.ContainsKey('sslv2redirect')) { $Payload.Add('sslv2redirect', $sslv2redirect) }
            if ($PSBoundParameters.ContainsKey('sslv2url')) { $Payload.Add('sslv2url', $sslv2url) }
            if ($PSBoundParameters.ContainsKey('clientauth')) { $Payload.Add('clientauth', $clientauth) }
            if ($PSBoundParameters.ContainsKey('clientcert')) { $Payload.Add('clientcert', $clientcert) }
            if ($PSBoundParameters.ContainsKey('sslredirect')) { $Payload.Add('sslredirect', $sslredirect) }
            if ($PSBoundParameters.ContainsKey('redirectportrewrite')) { $Payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ($PSBoundParameters.ContainsKey('ssl2')) { $Payload.Add('ssl2', $ssl2) }
            if ($PSBoundParameters.ContainsKey('ssl3')) { $Payload.Add('ssl3', $ssl3) }
            if ($PSBoundParameters.ContainsKey('tls1')) { $Payload.Add('tls1', $tls1) }
            if ($PSBoundParameters.ContainsKey('tls11')) { $Payload.Add('tls11', $tls11) }
            if ($PSBoundParameters.ContainsKey('tls12')) { $Payload.Add('tls12', $tls12) }
            if ($PSBoundParameters.ContainsKey('tls13')) { $Payload.Add('tls13', $tls13) }
            if ($PSBoundParameters.ContainsKey('dtls1')) { $Payload.Add('dtls1', $dtls1) }
            if ($PSBoundParameters.ContainsKey('dtls12')) { $Payload.Add('dtls12', $dtls12) }
            if ($PSBoundParameters.ContainsKey('snienable')) { $Payload.Add('snienable', $snienable) }
            if ($PSBoundParameters.ContainsKey('ocspstapling')) { $Payload.Add('ocspstapling', $ocspstapling) }
            if ($PSBoundParameters.ContainsKey('pushenctrigger')) { $Payload.Add('pushenctrigger', $pushenctrigger) }
            if ($PSBoundParameters.ContainsKey('sendclosenotify')) { $Payload.Add('sendclosenotify', $sendclosenotify) }
            if ($PSBoundParameters.ContainsKey('dtlsprofilename')) { $Payload.Add('dtlsprofilename', $dtlsprofilename) }
            if ($PSBoundParameters.ContainsKey('sslprofile')) { $Payload.Add('sslprofile', $sslprofile) }
            if ($PSBoundParameters.ContainsKey('hsts')) { $Payload.Add('hsts', $hsts) }
            if ($PSBoundParameters.ContainsKey('maxage')) { $Payload.Add('maxage', $maxage) }
            if ($PSBoundParameters.ContainsKey('includesubdomains')) { $Payload.Add('includesubdomains', $includesubdomains) }
            if ($PSBoundParameters.ContainsKey('preload')) { $Payload.Add('preload', $preload) }
            if ($PSBoundParameters.ContainsKey('strictsigdigestcheck')) { $Payload.Add('strictsigdigestcheck', $strictsigdigestcheck) }
            if ($PSBoundParameters.ContainsKey('zerorttearlydata')) { $Payload.Add('zerorttearlydata', $zerorttearlydata) }
            if ($PSBoundParameters.ContainsKey('tls13sessionticketsperauthcontext')) { $Payload.Add('tls13sessionticketsperauthcontext', $tls13sessionticketsperauthcontext) }
            if ($PSBoundParameters.ContainsKey('dhekeyexchangewithpsk')) { $Payload.Add('dhekeyexchangewithpsk', $dhekeyexchangewithpsk) }
 
            if ($PSCmdlet.ShouldProcess("sslvserver", "Update SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslvserver -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslvserver -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateSslvserver: Finished"
    }
}

function Invoke-ADCUnsetSslvserver {
<#
    .SYNOPSIS
        Unset SSL configuration Object
    .DESCRIPTION
        Unset SSL configuration Object 
   .PARAMETER vservername 
       Name of the SSL virtual server for which to set advanced configuration. 
   .PARAMETER cleartextport 
       Port on which clear-text data is sent by the appliance to the server. Do not specify this parameter for SSL offloading with end-to-end encryption. 
   .PARAMETER dh 
       State of Diffie-Hellman (DH) key exchange.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER dhfile 
       Name of and, optionally, path to the DH parameter file, in PEM format, to be installed. /nsconfig/ssl/ is the default path. 
   .PARAMETER dhcount 
       Number of interactions, between the client and the Citrix ADC, after which the DH private-public pair is regenerated. A value of zero (0) specifies infinite use (no refresh). 
   .PARAMETER dhkeyexpsizelimit 
       This option enables the use of NIST recommended (NIST Special Publication 800-56A) bit size for private-key size. For example, for DH params of size 2048bit, the private-key size recommended is 224bits. This is rounded-up to 256bits.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ersa 
       State of Ephemeral RSA (eRSA) key exchange. Ephemeral RSA allows clients that support only export ciphers to communicate with the secure server even if the server certificate does not support export clients. The ephemeral RSA key is automatically generated when you bind an export cipher to an SSL or TCP-based SSL virtual server or service. When you remove the export cipher, the eRSA key is not deleted. It is reused at a later date when another export cipher is bound to an SSL or TCP-based SSL virtual server or service. The eRSA key is deleted when the appliance restarts.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ersacount 
       Refresh count for regeneration of the RSA public-key and private-key pair. Zero (0) specifies infinite usage (no refresh). 
   .PARAMETER sessreuse 
       State of session reuse. Establishing the initial handshake requires CPU-intensive public key encryption operations. With the ENABLED setting, session key exchange is avoided for session resumption requests received from the client.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sesstimeout 
       Time, in seconds, for which to keep the session active. Any session resumption request received after the timeout period will require a fresh SSL handshake and establishment of a new SSL session. 
   .PARAMETER cipherredirect 
       State of Cipher Redirect. If cipher redirect is enabled, you can configure an SSL virtual server or service to display meaningful error messages if the SSL handshake fails because of a cipher mismatch between the virtual server or service and the client.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER cipherurl 
       The redirect URL to be used with the Cipher Redirect feature. 
   .PARAMETER sslv2redirect 
       State of SSLv2 Redirect. If SSLv2 redirect is enabled, you can configure an SSL virtual server or service to display meaningful error messages if the SSL handshake fails because of a protocol version mismatch between the virtual server or service and the client.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sslv2url 
       URL of the page to which to redirect the client in case of a protocol version mismatch. Typically, this page has a clear explanation of the error or an alternative location that the transaction can continue from. 
   .PARAMETER clientauth 
       State of client authentication. If client authentication is enabled, the virtual server terminates the SSL handshake if the SSL client does not provide a valid certificate.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER clientcert 
       Type of client authentication. If this parameter is set to MANDATORY, the appliance terminates the SSL handshake if the SSL client does not provide a valid certificate. With the OPTIONAL setting, the appliance requests a certificate from the SSL clients but proceeds with the SSL transaction even if the client presents an invalid certificate.  
       Caution: Define proper access control policies before changing this setting to Optional.  
       Possible values = Mandatory, Optional 
   .PARAMETER sslredirect 
       State of HTTPS redirects for the SSL virtual server.  
       For an SSL session, if the client browser receives a redirect message, the browser tries to connect to the new location. However, the secure SSL session breaks if the object has moved from a secure site (https://) to an unsecure site (http://). Typically, a warning message appears on the screen, prompting the user to continue or disconnect.  
       If SSL Redirect is ENABLED, the redirect message is automatically converted from http:// to https:// and the SSL session does not break.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER redirectportrewrite 
       State of the port rewrite while performing HTTPS redirect. If this parameter is ENABLED and the URL from the server does not contain the standard port, the port is rewritten to the standard.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ssl2 
       State of SSLv2 protocol support for the SSL Virtual Server.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ssl3 
       State of SSLv3 protocol support for the SSL Virtual Server.  
       Note: On platforms with SSL acceleration chips, if the SSL chip does not support SSLv3, this parameter cannot be set to ENABLED.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tls1 
       State of TLSv1.0 protocol support for the SSL Virtual Server.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tls11 
       State of TLSv1.1 protocol support for the SSL Virtual Server.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tls12 
       State of TLSv1.2 protocol support for the SSL Virtual Server.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tls13 
       State of TLSv1.3 protocol support for the SSL Virtual Server.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER dtls1 
       State of DTLSv1.0 protocol support for the SSL Virtual Server.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER dtls12 
       State of DTLSv1.2 protocol support for the SSL Virtual Server.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER snienable 
       State of the Server Name Indication (SNI) feature on the virtual server and service-based offload. SNI helps to enable SSL encryption on multiple domains on a single virtual server or service if the domains are controlled by the same organization and share the same second-level domain name. For example, *.sports.net can be used to secure domains such as login.sports.net and help.sports.net.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ocspstapling 
       State of OCSP stapling support on the SSL virtual server. Supported only if the protocol used is higher than SSLv3. Possible values:  
       ENABLED: The appliance sends a request to the OCSP responder to check the status of the server certificate and caches the response for the specified time. If the response is valid at the time of SSL handshake with the client, the OCSP-based server certificate status is sent to the client during the handshake.  
       DISABLED: The appliance does not check the status of the server certificate. .  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sendclosenotify 
       Enable sending SSL Close-Notify at the end of a transaction.  
       Possible values = YES, NO 
   .PARAMETER dtlsprofilename 
       Name of the DTLS profile whose settings are to be applied to the virtual server. 
   .PARAMETER sslprofile 
       Name of the SSL profile that contains SSL settings for the virtual server. 
   .PARAMETER hsts 
       State of HSTS protocol support for the SSL Virtual Server. Using HSTS, a server can enforce the use of an HTTPS connection for all communication with a client.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER maxage 
       Set the maximum time, in seconds, in the strict transport security (STS) header during which the client must send only HTTPS requests to the server. 
   .PARAMETER includesubdomains 
       Enable HSTS for subdomains. If set to Yes, a client must send only HTTPS requests for subdomains.  
       Possible values = YES, NO 
   .PARAMETER preload 
       Flag indicates the consent of the site owner to have their domain preloaded.  
       Possible values = YES, NO 
   .PARAMETER strictsigdigestcheck 
       Parameter indicating to check whether peer entity certificate during TLS1.2 handshake is signed with one of signature-hash combination supported by Citrix ADC.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER zerorttearlydata 
       State of TLS 1.3 0-RTT early data support for the SSL Virtual Server. This setting only has an effect if resumption is enabled, as early data cannot be sent along with an initial handshake.  
       Early application data has significantly different security properties - in particular there is no guarantee that the data cannot be replayed.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tls13sessionticketsperauthcontext 
       Number of tickets the SSL Virtual Server will issue anytime TLS 1.3 is negotiated, ticket-based resumption is enabled, and either (1) a handshake completes or (2) post-handhsake client auth completes.  
       This value can be increased to enable clients to open multiple parallel connections using a fresh ticket for each connection.  
       No tickets are sent if resumption is disabled. 
   .PARAMETER dhekeyexchangewithpsk 
       Whether or not the SSL Virtual Server will require a DHE key exchange to occur when a PSK is accepted during a TLS 1.3 resumption handshake.  
       A DHE key exchange ensures forward secrecy even in the event that ticket keys are compromised, at the expense of an additional round trip and resources required to carry out the DHE key exchange.  
       If disabled, a DHE key exchange will be performed when a PSK is accepted but only if requested by the client.  
       If enabled, the server will require a DHE key exchange when a PSK is accepted regardless of whether the client supports combined PSK-DHE key exchange. This setting only has an effect when resumption is enabled.  
       Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCUnsetSslvserver -vservername <string>
    .NOTES
        File Name : Invoke-ADCUnsetSslvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver
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
        [string]$vservername ,

        [Boolean]$cleartextport ,

        [Boolean]$dh ,

        [Boolean]$dhfile ,

        [Boolean]$dhcount ,

        [Boolean]$dhkeyexpsizelimit ,

        [Boolean]$ersa ,

        [Boolean]$ersacount ,

        [Boolean]$sessreuse ,

        [Boolean]$sesstimeout ,

        [Boolean]$cipherredirect ,

        [Boolean]$cipherurl ,

        [Boolean]$sslv2redirect ,

        [Boolean]$sslv2url ,

        [Boolean]$clientauth ,

        [Boolean]$clientcert ,

        [Boolean]$sslredirect ,

        [Boolean]$redirectportrewrite ,

        [Boolean]$ssl2 ,

        [Boolean]$ssl3 ,

        [Boolean]$tls1 ,

        [Boolean]$tls11 ,

        [Boolean]$tls12 ,

        [Boolean]$tls13 ,

        [Boolean]$dtls1 ,

        [Boolean]$dtls12 ,

        [Boolean]$snienable ,

        [Boolean]$ocspstapling ,

        [Boolean]$sendclosenotify ,

        [Boolean]$dtlsprofilename ,

        [Boolean]$sslprofile ,

        [Boolean]$hsts ,

        [Boolean]$maxage ,

        [Boolean]$includesubdomains ,

        [Boolean]$preload ,

        [Boolean]$strictsigdigestcheck ,

        [Boolean]$zerorttearlydata ,

        [Boolean]$tls13sessionticketsperauthcontext ,

        [Boolean]$dhekeyexchangewithpsk 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSslvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                vservername = $vservername
            }
            if ($PSBoundParameters.ContainsKey('cleartextport')) { $Payload.Add('cleartextport', $cleartextport) }
            if ($PSBoundParameters.ContainsKey('dh')) { $Payload.Add('dh', $dh) }
            if ($PSBoundParameters.ContainsKey('dhfile')) { $Payload.Add('dhfile', $dhfile) }
            if ($PSBoundParameters.ContainsKey('dhcount')) { $Payload.Add('dhcount', $dhcount) }
            if ($PSBoundParameters.ContainsKey('dhkeyexpsizelimit')) { $Payload.Add('dhkeyexpsizelimit', $dhkeyexpsizelimit) }
            if ($PSBoundParameters.ContainsKey('ersa')) { $Payload.Add('ersa', $ersa) }
            if ($PSBoundParameters.ContainsKey('ersacount')) { $Payload.Add('ersacount', $ersacount) }
            if ($PSBoundParameters.ContainsKey('sessreuse')) { $Payload.Add('sessreuse', $sessreuse) }
            if ($PSBoundParameters.ContainsKey('sesstimeout')) { $Payload.Add('sesstimeout', $sesstimeout) }
            if ($PSBoundParameters.ContainsKey('cipherredirect')) { $Payload.Add('cipherredirect', $cipherredirect) }
            if ($PSBoundParameters.ContainsKey('cipherurl')) { $Payload.Add('cipherurl', $cipherurl) }
            if ($PSBoundParameters.ContainsKey('sslv2redirect')) { $Payload.Add('sslv2redirect', $sslv2redirect) }
            if ($PSBoundParameters.ContainsKey('sslv2url')) { $Payload.Add('sslv2url', $sslv2url) }
            if ($PSBoundParameters.ContainsKey('clientauth')) { $Payload.Add('clientauth', $clientauth) }
            if ($PSBoundParameters.ContainsKey('clientcert')) { $Payload.Add('clientcert', $clientcert) }
            if ($PSBoundParameters.ContainsKey('sslredirect')) { $Payload.Add('sslredirect', $sslredirect) }
            if ($PSBoundParameters.ContainsKey('redirectportrewrite')) { $Payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ($PSBoundParameters.ContainsKey('ssl2')) { $Payload.Add('ssl2', $ssl2) }
            if ($PSBoundParameters.ContainsKey('ssl3')) { $Payload.Add('ssl3', $ssl3) }
            if ($PSBoundParameters.ContainsKey('tls1')) { $Payload.Add('tls1', $tls1) }
            if ($PSBoundParameters.ContainsKey('tls11')) { $Payload.Add('tls11', $tls11) }
            if ($PSBoundParameters.ContainsKey('tls12')) { $Payload.Add('tls12', $tls12) }
            if ($PSBoundParameters.ContainsKey('tls13')) { $Payload.Add('tls13', $tls13) }
            if ($PSBoundParameters.ContainsKey('dtls1')) { $Payload.Add('dtls1', $dtls1) }
            if ($PSBoundParameters.ContainsKey('dtls12')) { $Payload.Add('dtls12', $dtls12) }
            if ($PSBoundParameters.ContainsKey('snienable')) { $Payload.Add('snienable', $snienable) }
            if ($PSBoundParameters.ContainsKey('ocspstapling')) { $Payload.Add('ocspstapling', $ocspstapling) }
            if ($PSBoundParameters.ContainsKey('sendclosenotify')) { $Payload.Add('sendclosenotify', $sendclosenotify) }
            if ($PSBoundParameters.ContainsKey('dtlsprofilename')) { $Payload.Add('dtlsprofilename', $dtlsprofilename) }
            if ($PSBoundParameters.ContainsKey('sslprofile')) { $Payload.Add('sslprofile', $sslprofile) }
            if ($PSBoundParameters.ContainsKey('hsts')) { $Payload.Add('hsts', $hsts) }
            if ($PSBoundParameters.ContainsKey('maxage')) { $Payload.Add('maxage', $maxage) }
            if ($PSBoundParameters.ContainsKey('includesubdomains')) { $Payload.Add('includesubdomains', $includesubdomains) }
            if ($PSBoundParameters.ContainsKey('preload')) { $Payload.Add('preload', $preload) }
            if ($PSBoundParameters.ContainsKey('strictsigdigestcheck')) { $Payload.Add('strictsigdigestcheck', $strictsigdigestcheck) }
            if ($PSBoundParameters.ContainsKey('zerorttearlydata')) { $Payload.Add('zerorttearlydata', $zerorttearlydata) }
            if ($PSBoundParameters.ContainsKey('tls13sessionticketsperauthcontext')) { $Payload.Add('tls13sessionticketsperauthcontext', $tls13sessionticketsperauthcontext) }
            if ($PSBoundParameters.ContainsKey('dhekeyexchangewithpsk')) { $Payload.Add('dhekeyexchangewithpsk', $dhekeyexchangewithpsk) }
            if ($PSCmdlet.ShouldProcess("$vservername", "Unset SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslvserver -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSslvserver: Finished"
    }
}

function Invoke-ADCGetSslvserver {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER vservername 
       Name of the SSL virtual server for which to set advanced configuration. 
    .PARAMETER GetAll 
        Retreive all sslvserver object(s)
    .PARAMETER Count
        If specified, the count of the sslvserver object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslvserver
    .EXAMPLE 
        Invoke-ADCGetSslvserver -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslvserver -Count
    .EXAMPLE
        Invoke-ADCGetSslvserver -name <string>
    .EXAMPLE
        Invoke-ADCGetSslvserver -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver/
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
        [string]$vservername,

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
        Write-Verbose "Invoke-ADCGetSslvserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslvserver objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslvserver configuration for property 'vservername'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver -Resource $vservername -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslvserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslvserver: Ended"
    }
}

function Invoke-ADCGetSslvserverbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER vservername 
       Name of the SSL virtual server for which to show detailed information. 
    .PARAMETER GetAll 
        Retreive all sslvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslvserverbinding
    .EXAMPLE 
        Invoke-ADCGetSslvserverbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetSslvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver_binding/
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
        [string]$vservername,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslvserver_binding configuration for property 'vservername'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_binding -Resource $vservername -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslvserverbinding: Ended"
    }
}

function Invoke-ADCAddSslvserverecccurvebinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER vservername 
        Name of the SSL virtual server.  
        Minimum length = 1 
    .PARAMETER ecccurvename 
        Named ECC curve bound to vserver/service.  
        Possible values = ALL, P_224, P_256, P_384, P_521 
    .PARAMETER PassThru 
        Return details about the created sslvserver_ecccurve_binding item.
    .EXAMPLE
        Invoke-ADCAddSslvserverecccurvebinding -vservername <string>
    .NOTES
        File Name : Invoke-ADCAddSslvserverecccurvebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver_ecccurve_binding/
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
        [string]$vservername ,

        [ValidateSet('ALL', 'P_224', 'P_256', 'P_384', 'P_521')]
        [string]$ecccurvename ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslvserverecccurvebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                vservername = $vservername
            }
            if ($PSBoundParameters.ContainsKey('ecccurvename')) { $Payload.Add('ecccurvename', $ecccurvename) }
 
            if ($PSCmdlet.ShouldProcess("sslvserver_ecccurve_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslvserver_ecccurve_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslvserverecccurvebinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslvserverecccurvebinding: Finished"
    }
}

function Invoke-ADCDeleteSslvserverecccurvebinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER vservername 
       Name of the SSL virtual server.  
       Minimum length = 1    .PARAMETER ecccurvename 
       Named ECC curve bound to vserver/service.  
       Possible values = ALL, P_224, P_256, P_384, P_521
    .EXAMPLE
        Invoke-ADCDeleteSslvserverecccurvebinding -vservername <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslvserverecccurvebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver_ecccurve_binding/
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
        [string]$vservername ,

        [string]$ecccurvename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslvserverecccurvebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ecccurvename')) { $Arguments.Add('ecccurvename', $ecccurvename) }
            if ($PSCmdlet.ShouldProcess("$vservername", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslvserver_ecccurve_binding -Resource $vservername -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslvserverecccurvebinding: Finished"
    }
}

function Invoke-ADCGetSslvserverecccurvebinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER vservername 
       Name of the SSL virtual server. 
    .PARAMETER GetAll 
        Retreive all sslvserver_ecccurve_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslvserver_ecccurve_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslvserverecccurvebinding
    .EXAMPLE 
        Invoke-ADCGetSslvserverecccurvebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslvserverecccurvebinding -Count
    .EXAMPLE
        Invoke-ADCGetSslvserverecccurvebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslvserverecccurvebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslvserverecccurvebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver_ecccurve_binding/
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
        [string]$vservername,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslvserverecccurvebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslvserver_ecccurve_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_ecccurve_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslvserver_ecccurve_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_ecccurve_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslvserver_ecccurve_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_ecccurve_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslvserver_ecccurve_binding configuration for property 'vservername'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_ecccurve_binding -Resource $vservername -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslvserver_ecccurve_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_ecccurve_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslvserverecccurvebinding: Ended"
    }
}

function Invoke-ADCAddSslvserversslcertkeybinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER vservername 
        Name of the SSL virtual server.  
        Minimum length = 1 
    .PARAMETER certkeyname 
        The name of the certificate key pair binding. 
    .PARAMETER ca 
        CA certificate. 
    .PARAMETER crlcheck 
        The state of the CRL check parameter. (Mandatory/Optional).  
        Possible values = Mandatory, Optional 
    .PARAMETER skipcaname 
        The flag is used to indicate whether this particular CA certificate's CA_Name needs to be sent to the SSL client while requesting for client certificate in a SSL handshake. 
    .PARAMETER snicert 
        The name of the CertKey. Use this option to bind Certkey(s) which will be used in SNI processing. 
    .PARAMETER ocspcheck 
        The state of the OCSP check parameter. (Mandatory/Optional).  
        Possible values = Mandatory, Optional 
    .PARAMETER PassThru 
        Return details about the created sslvserver_sslcertkey_binding item.
    .EXAMPLE
        Invoke-ADCAddSslvserversslcertkeybinding -vservername <string>
    .NOTES
        File Name : Invoke-ADCAddSslvserversslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver_sslcertkey_binding/
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
        [string]$vservername ,

        [string]$certkeyname ,

        [boolean]$ca ,

        [ValidateSet('Mandatory', 'Optional')]
        [string]$crlcheck ,

        [boolean]$skipcaname ,

        [boolean]$snicert ,

        [ValidateSet('Mandatory', 'Optional')]
        [string]$ocspcheck ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslvserversslcertkeybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                vservername = $vservername
            }
            if ($PSBoundParameters.ContainsKey('certkeyname')) { $Payload.Add('certkeyname', $certkeyname) }
            if ($PSBoundParameters.ContainsKey('ca')) { $Payload.Add('ca', $ca) }
            if ($PSBoundParameters.ContainsKey('crlcheck')) { $Payload.Add('crlcheck', $crlcheck) }
            if ($PSBoundParameters.ContainsKey('skipcaname')) { $Payload.Add('skipcaname', $skipcaname) }
            if ($PSBoundParameters.ContainsKey('snicert')) { $Payload.Add('snicert', $snicert) }
            if ($PSBoundParameters.ContainsKey('ocspcheck')) { $Payload.Add('ocspcheck', $ocspcheck) }
 
            if ($PSCmdlet.ShouldProcess("sslvserver_sslcertkey_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslvserver_sslcertkey_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslvserversslcertkeybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslvserversslcertkeybinding: Finished"
    }
}

function Invoke-ADCDeleteSslvserversslcertkeybinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER vservername 
       Name of the SSL virtual server.  
       Minimum length = 1    .PARAMETER certkeyname 
       The name of the certificate key pair binding.    .PARAMETER ca 
       CA certificate.    .PARAMETER crlcheck 
       The state of the CRL check parameter. (Mandatory/Optional).  
       Possible values = Mandatory, Optional    .PARAMETER snicert 
       The name of the CertKey. Use this option to bind Certkey(s) which will be used in SNI processing.    .PARAMETER ocspcheck 
       The state of the OCSP check parameter. (Mandatory/Optional).  
       Possible values = Mandatory, Optional
    .EXAMPLE
        Invoke-ADCDeleteSslvserversslcertkeybinding -vservername <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslvserversslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver_sslcertkey_binding/
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
        [string]$vservername ,

        [string]$certkeyname ,

        [boolean]$ca ,

        [string]$crlcheck ,

        [boolean]$snicert ,

        [string]$ocspcheck 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslvserversslcertkeybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('certkeyname')) { $Arguments.Add('certkeyname', $certkeyname) }
            if ($PSBoundParameters.ContainsKey('ca')) { $Arguments.Add('ca', $ca) }
            if ($PSBoundParameters.ContainsKey('crlcheck')) { $Arguments.Add('crlcheck', $crlcheck) }
            if ($PSBoundParameters.ContainsKey('snicert')) { $Arguments.Add('snicert', $snicert) }
            if ($PSBoundParameters.ContainsKey('ocspcheck')) { $Arguments.Add('ocspcheck', $ocspcheck) }
            if ($PSCmdlet.ShouldProcess("$vservername", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslvserver_sslcertkey_binding -Resource $vservername -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslvserversslcertkeybinding: Finished"
    }
}

function Invoke-ADCGetSslvserversslcertkeybinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER vservername 
       Name of the SSL virtual server. 
    .PARAMETER GetAll 
        Retreive all sslvserver_sslcertkey_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslvserver_sslcertkey_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslvserversslcertkeybinding
    .EXAMPLE 
        Invoke-ADCGetSslvserversslcertkeybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslvserversslcertkeybinding -Count
    .EXAMPLE
        Invoke-ADCGetSslvserversslcertkeybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslvserversslcertkeybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslvserversslcertkeybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver_sslcertkey_binding/
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
        [string]$vservername,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslvserversslcertkeybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslvserver_sslcertkey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslcertkey_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslvserver_sslcertkey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslcertkey_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslvserver_sslcertkey_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslcertkey_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslvserver_sslcertkey_binding configuration for property 'vservername'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslcertkey_binding -Resource $vservername -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslvserver_sslcertkey_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslcertkey_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslvserversslcertkeybinding: Ended"
    }
}

function Invoke-ADCAddSslvserversslciphersuitebinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER vservername 
        Name of the SSL virtual server.  
        Minimum length = 1 
    .PARAMETER ciphername 
        The cipher group/alias/individual cipher configuration. 
    .PARAMETER PassThru 
        Return details about the created sslvserver_sslciphersuite_binding item.
    .EXAMPLE
        Invoke-ADCAddSslvserversslciphersuitebinding -vservername <string>
    .NOTES
        File Name : Invoke-ADCAddSslvserversslciphersuitebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver_sslciphersuite_binding/
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
        [string]$vservername ,

        [string]$ciphername ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslvserversslciphersuitebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                vservername = $vservername
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Payload.Add('ciphername', $ciphername) }
 
            if ($PSCmdlet.ShouldProcess("sslvserver_sslciphersuite_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslvserver_sslciphersuite_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslvserversslciphersuitebinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslvserversslciphersuitebinding: Finished"
    }
}

function Invoke-ADCDeleteSslvserversslciphersuitebinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER vservername 
       Name of the SSL virtual server.  
       Minimum length = 1    .PARAMETER ciphername 
       The cipher group/alias/individual cipher configuration.
    .EXAMPLE
        Invoke-ADCDeleteSslvserversslciphersuitebinding -vservername <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslvserversslciphersuitebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver_sslciphersuite_binding/
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
        [string]$vservername ,

        [string]$ciphername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslvserversslciphersuitebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Arguments.Add('ciphername', $ciphername) }
            if ($PSCmdlet.ShouldProcess("$vservername", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslvserver_sslciphersuite_binding -Resource $vservername -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslvserversslciphersuitebinding: Finished"
    }
}

function Invoke-ADCGetSslvserversslciphersuitebinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER vservername 
       Name of the SSL virtual server. 
    .PARAMETER GetAll 
        Retreive all sslvserver_sslciphersuite_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslvserver_sslciphersuite_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslvserversslciphersuitebinding
    .EXAMPLE 
        Invoke-ADCGetSslvserversslciphersuitebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslvserversslciphersuitebinding -Count
    .EXAMPLE
        Invoke-ADCGetSslvserversslciphersuitebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslvserversslciphersuitebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslvserversslciphersuitebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver_sslciphersuite_binding/
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
        [string]$vservername,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslvserversslciphersuitebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslvserver_sslciphersuite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslciphersuite_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslvserver_sslciphersuite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslciphersuite_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslvserver_sslciphersuite_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslciphersuite_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslvserver_sslciphersuite_binding configuration for property 'vservername'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslciphersuite_binding -Resource $vservername -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslvserver_sslciphersuite_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslciphersuite_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslvserversslciphersuitebinding: Ended"
    }
}

function Invoke-ADCAddSslvserversslcipherbinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER vservername 
        Name of the SSL virtual server.  
        Minimum length = 1 
    .PARAMETER ciphername 
        Name of the individual cipher, user-defined cipher group, or predefined (built-in) cipher alias. 
    .PARAMETER PassThru 
        Return details about the created sslvserver_sslcipher_binding item.
    .EXAMPLE
        Invoke-ADCAddSslvserversslcipherbinding -vservername <string>
    .NOTES
        File Name : Invoke-ADCAddSslvserversslcipherbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver_sslcipher_binding/
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
        [string]$vservername ,

        [string]$ciphername ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslvserversslcipherbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                vservername = $vservername
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Payload.Add('ciphername', $ciphername) }
 
            if ($PSCmdlet.ShouldProcess("sslvserver_sslcipher_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslvserver_sslcipher_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslvserversslcipherbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslvserversslcipherbinding: Finished"
    }
}

function Invoke-ADCDeleteSslvserversslcipherbinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER vservername 
       Name of the SSL virtual server.  
       Minimum length = 1    .PARAMETER ciphername 
       Name of the individual cipher, user-defined cipher group, or predefined (built-in) cipher alias.
    .EXAMPLE
        Invoke-ADCDeleteSslvserversslcipherbinding -vservername <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslvserversslcipherbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver_sslcipher_binding/
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
        [string]$vservername ,

        [string]$ciphername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslvserversslcipherbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ciphername')) { $Arguments.Add('ciphername', $ciphername) }
            if ($PSCmdlet.ShouldProcess("$vservername", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslvserver_sslcipher_binding -Resource $vservername -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslvserversslcipherbinding: Finished"
    }
}

function Invoke-ADCGetSslvserversslcipherbinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER vservername 
       Name of the SSL virtual server. 
    .PARAMETER GetAll 
        Retreive all sslvserver_sslcipher_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslvserver_sslcipher_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslvserversslcipherbinding
    .EXAMPLE 
        Invoke-ADCGetSslvserversslcipherbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslvserversslcipherbinding -Count
    .EXAMPLE
        Invoke-ADCGetSslvserversslcipherbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslvserversslcipherbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslvserversslcipherbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver_sslcipher_binding/
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
        [string]$vservername,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslvserversslcipherbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslvserver_sslcipher_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslcipher_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslvserver_sslcipher_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslcipher_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslvserver_sslcipher_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslcipher_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslvserver_sslcipher_binding configuration for property 'vservername'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslcipher_binding -Resource $vservername -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslvserver_sslcipher_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslcipher_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslvserversslcipherbinding: Ended"
    }
}

function Invoke-ADCAddSslvserversslpolicybinding {
<#
    .SYNOPSIS
        Add SSL configuration Object
    .DESCRIPTION
        Add SSL configuration Object 
    .PARAMETER vservername 
        Name of the SSL virtual server.  
        Minimum length = 1 
    .PARAMETER policyname 
        The name of the SSL policy binding. 
    .PARAMETER priority 
        The priority of the policies bound to this SSL service.  
        Minimum value = 0  
        Maximum value = 65534 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER invoke 
        Invoke flag. This attribute is relevant only for ADVANCED policies. 
    .PARAMETER labeltype 
        Type of policy label invocation.  
        Possible values = vserver, service, policylabel 
    .PARAMETER labelname 
        Name of the label to invoke if the current policy rule evaluates to TRUE. 
    .PARAMETER type 
        Bind point to which to bind the policy. Possible Values: REQUEST, INTERCEPT_REQ and CLIENTHELLO_REQ. These bindpoints mean: 1. REQUEST: Policy evaluation will be done at appplication above SSL. This bindpoint is default and is used for actions based on clientauth and client cert. 2. INTERCEPT_REQ: Policy evaluation will be done during SSL handshake to decide whether to intercept or not. Actions allowed with this type are: INTERCEPT, BYPASS and RESET. 3. CLIENTHELLO_REQ: Policy evaluation will be done during handling of Client Hello Request. Action allowed with this type is: RESET, FORWARD and PICKCACERTGRP.  
        Default value: REQUEST  
        Possible values = INTERCEPT_REQ, REQUEST, CLIENTHELLO_REQ 
    .PARAMETER PassThru 
        Return details about the created sslvserver_sslpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddSslvserversslpolicybinding -vservername <string>
    .NOTES
        File Name : Invoke-ADCAddSslvserversslpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver_sslpolicy_binding/
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
        [string]$vservername ,

        [string]$policyname ,

        [ValidateRange(0, 65534)]
        [double]$priority ,

        [string]$gotopriorityexpression ,

        [boolean]$invoke ,

        [ValidateSet('vserver', 'service', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [ValidateSet('INTERCEPT_REQ', 'REQUEST', 'CLIENTHELLO_REQ')]
        [string]$type = 'REQUEST' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSslvserversslpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                vservername = $vservername
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
 
            if ($PSCmdlet.ShouldProcess("sslvserver_sslpolicy_binding", "Add SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslvserver_sslpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSslvserversslpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSslvserversslpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteSslvserversslpolicybinding {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER vservername 
       Name of the SSL virtual server.  
       Minimum length = 1    .PARAMETER policyname 
       The name of the SSL policy binding.    .PARAMETER priority 
       The priority of the policies bound to this SSL service.  
       Minimum value = 0  
       Maximum value = 65534    .PARAMETER type 
       Bind point to which to bind the policy. Possible Values: REQUEST, INTERCEPT_REQ and CLIENTHELLO_REQ. These bindpoints mean: 1. REQUEST: Policy evaluation will be done at appplication above SSL. This bindpoint is default and is used for actions based on clientauth and client cert. 2. INTERCEPT_REQ: Policy evaluation will be done during SSL handshake to decide whether to intercept or not. Actions allowed with this type are: INTERCEPT, BYPASS and RESET. 3. CLIENTHELLO_REQ: Policy evaluation will be done during handling of Client Hello Request. Action allowed with this type is: RESET, FORWARD and PICKCACERTGRP.  
       Default value: REQUEST  
       Possible values = INTERCEPT_REQ, REQUEST, CLIENTHELLO_REQ
    .EXAMPLE
        Invoke-ADCDeleteSslvserversslpolicybinding -vservername <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslvserversslpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver_sslpolicy_binding/
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
        [string]$vservername ,

        [string]$policyname ,

        [double]$priority ,

        [string]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslvserversslpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess("$vservername", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslvserver_sslpolicy_binding -Resource $vservername -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslvserversslpolicybinding: Finished"
    }
}

function Invoke-ADCGetSslvserversslpolicybinding {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER vservername 
       Name of the SSL virtual server. 
    .PARAMETER GetAll 
        Retreive all sslvserver_sslpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the sslvserver_sslpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslvserversslpolicybinding
    .EXAMPLE 
        Invoke-ADCGetSslvserversslpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslvserversslpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetSslvserversslpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSslvserversslpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslvserversslpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslvserver_sslpolicy_binding/
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
        [string]$vservername,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSslvserversslpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all sslvserver_sslpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslvserver_sslpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslvserver_sslpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslvserver_sslpolicy_binding configuration for property 'vservername'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslpolicy_binding -Resource $vservername -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving sslvserver_sslpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslvserver_sslpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslvserversslpolicybinding: Ended"
    }
}

function Invoke-ADCCreateSslwrapkey {
<#
    .SYNOPSIS
        Create SSL configuration Object
    .DESCRIPTION
        Create SSL configuration Object 
    .PARAMETER wrapkeyname 
        Name for the wrap key. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the wrap key is created. 
    .PARAMETER password 
        Password string for the wrap key. 
    .PARAMETER salt 
        Salt string for the wrap key.
    .EXAMPLE
        Invoke-ADCCreateSslwrapkey -wrapkeyname <string> -password <string> -salt <string>
    .NOTES
        File Name : Invoke-ADCCreateSslwrapkey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslwrapkey/
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
        [string]$wrapkeyname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$salt 

    )
    begin {
        Write-Verbose "Invoke-ADCCreateSslwrapkey: Starting"
    }
    process {
        try {
            $Payload = @{
                wrapkeyname = $wrapkeyname
                password = $password
                salt = $salt
            }

            if ($PSCmdlet.ShouldProcess($Name, "Create SSL configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslwrapkey -Action create -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCCreateSslwrapkey: Finished"
    }
}

function Invoke-ADCDeleteSslwrapkey {
<#
    .SYNOPSIS
        Delete SSL configuration Object
    .DESCRIPTION
        Delete SSL configuration Object
    .PARAMETER wrapkeyname 
       Name for the wrap key. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the wrap key is created. 
    .EXAMPLE
        Invoke-ADCDeleteSslwrapkey -wrapkeyname <string>
    .NOTES
        File Name : Invoke-ADCDeleteSslwrapkey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslwrapkey/
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
        [string]$wrapkeyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSslwrapkey: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$wrapkeyname", "Delete SSL configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslwrapkey -Resource $wrapkeyname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSslwrapkey: Finished"
    }
}

function Invoke-ADCGetSslwrapkey {
<#
    .SYNOPSIS
        Get SSL configuration object(s)
    .DESCRIPTION
        Get SSL configuration object(s)
    .PARAMETER GetAll 
        Retreive all sslwrapkey object(s)
    .PARAMETER Count
        If specified, the count of the sslwrapkey object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSslwrapkey
    .EXAMPLE 
        Invoke-ADCGetSslwrapkey -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSslwrapkey -Count
    .EXAMPLE
        Invoke-ADCGetSslwrapkey -name <string>
    .EXAMPLE
        Invoke-ADCGetSslwrapkey -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSslwrapkey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslwrapkey/
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
        Write-Verbose "Invoke-ADCGetSslwrapkey: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all sslwrapkey objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslwrapkey -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for sslwrapkey objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslwrapkey -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving sslwrapkey objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslwrapkey -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving sslwrapkey configuration for property ''"

            } else {
                Write-Verbose "Retrieving sslwrapkey configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslwrapkey -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSslwrapkey: Ended"
    }
}

