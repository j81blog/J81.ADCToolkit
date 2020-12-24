function Invoke-ADCAddIcaaccessprofile {
<#
    .SYNOPSIS
        Add Ica configuration Object
    .DESCRIPTION
        Add Ica configuration Object 
    .PARAMETER name 
        Name for the ICA accessprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and  
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA accessprofile is added. 
    .PARAMETER connectclientlptports 
        Allow Default access/Disable automatic connection of LPT ports from the client when the user logs on.  
        Default value: DISABLED  
        Possible values = DEFAULT, DISABLED 
    .PARAMETER clientaudioredirection 
        Allow Default access/Disable applications hosted on the server to play sounds through a sound device installed on the client computer, also allows or prevents users to record audio input.  
        Default value: DISABLED  
        Possible values = DEFAULT, DISABLED 
    .PARAMETER localremotedatasharing 
        Allow Default access/Disable file/data sharing via the Receiver for HTML5.  
        Default value: DISABLED  
        Possible values = DEFAULT, DISABLED 
    .PARAMETER clientclipboardredirection 
        Allow Default access/Disable the clipboard on the client device to be mapped to the clipboard on the server.  
        Default value: DISABLED  
        Possible values = DEFAULT, DISABLED 
    .PARAMETER clientcomportredirection 
        Allow Default access/Disable COM port redirection to and from the client.  
        Default value: DISABLED  
        Possible values = DEFAULT, DISABLED 
    .PARAMETER clientdriveredirection 
        Allow Default access/Disables drive redirection to and from the client.  
        Default value: DISABLED  
        Possible values = DEFAULT, DISABLED 
    .PARAMETER clientprinterredirection 
        Allow Default access/Disable client printers to be mapped to a server when a user logs on to a session.  
        Default value: DISABLED  
        Possible values = DEFAULT, DISABLED 
    .PARAMETER multistream 
        Allow Default access/Disable the multistream feature for the specified users.  
        Default value: DISABLED  
        Possible values = DEFAULT, DISABLED 
    .PARAMETER clientusbdriveredirection 
        Allow Default access/Disable the redirection of USB devices to and from the client.  
        Default value: DISABLED  
        Possible values = DEFAULT, DISABLED 
    .PARAMETER PassThru 
        Return details about the created icaaccessprofile item.
    .EXAMPLE
        Invoke-ADCAddIcaaccessprofile -name <string>
    .NOTES
        File Name : Invoke-ADCAddIcaaccessprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaccessprofile/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$connectclientlptports = 'DISABLED' ,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$clientaudioredirection = 'DISABLED' ,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$localremotedatasharing = 'DISABLED' ,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$clientclipboardredirection = 'DISABLED' ,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$clientcomportredirection = 'DISABLED' ,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$clientdriveredirection = 'DISABLED' ,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$clientprinterredirection = 'DISABLED' ,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$multistream = 'DISABLED' ,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$clientusbdriveredirection = 'DISABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddIcaaccessprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('connectclientlptports')) { $Payload.Add('connectclientlptports', $connectclientlptports) }
            if ($PSBoundParameters.ContainsKey('clientaudioredirection')) { $Payload.Add('clientaudioredirection', $clientaudioredirection) }
            if ($PSBoundParameters.ContainsKey('localremotedatasharing')) { $Payload.Add('localremotedatasharing', $localremotedatasharing) }
            if ($PSBoundParameters.ContainsKey('clientclipboardredirection')) { $Payload.Add('clientclipboardredirection', $clientclipboardredirection) }
            if ($PSBoundParameters.ContainsKey('clientcomportredirection')) { $Payload.Add('clientcomportredirection', $clientcomportredirection) }
            if ($PSBoundParameters.ContainsKey('clientdriveredirection')) { $Payload.Add('clientdriveredirection', $clientdriveredirection) }
            if ($PSBoundParameters.ContainsKey('clientprinterredirection')) { $Payload.Add('clientprinterredirection', $clientprinterredirection) }
            if ($PSBoundParameters.ContainsKey('multistream')) { $Payload.Add('multistream', $multistream) }
            if ($PSBoundParameters.ContainsKey('clientusbdriveredirection')) { $Payload.Add('clientusbdriveredirection', $clientusbdriveredirection) }
 
            if ($PSCmdlet.ShouldProcess("icaaccessprofile", "Add Ica configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type icaaccessprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetIcaaccessprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddIcaaccessprofile: Finished"
    }
}

function Invoke-ADCDeleteIcaaccessprofile {
<#
    .SYNOPSIS
        Delete Ica configuration Object
    .DESCRIPTION
        Delete Ica configuration Object
    .PARAMETER name 
       Name for the ICA accessprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and  
       the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA accessprofile is added. 
    .EXAMPLE
        Invoke-ADCDeleteIcaaccessprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteIcaaccessprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaccessprofile/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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
        Write-Verbose "Invoke-ADCDeleteIcaaccessprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Ica configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type icaaccessprofile -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteIcaaccessprofile: Finished"
    }
}

function Invoke-ADCUpdateIcaaccessprofile {
<#
    .SYNOPSIS
        Update Ica configuration Object
    .DESCRIPTION
        Update Ica configuration Object 
    .PARAMETER name 
        Name for the ICA accessprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and  
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA accessprofile is added. 
    .PARAMETER connectclientlptports 
        Allow Default access/Disable automatic connection of LPT ports from the client when the user logs on.  
        Default value: DISABLED  
        Possible values = DEFAULT, DISABLED 
    .PARAMETER clientaudioredirection 
        Allow Default access/Disable applications hosted on the server to play sounds through a sound device installed on the client computer, also allows or prevents users to record audio input.  
        Default value: DISABLED  
        Possible values = DEFAULT, DISABLED 
    .PARAMETER localremotedatasharing 
        Allow Default access/Disable file/data sharing via the Receiver for HTML5.  
        Default value: DISABLED  
        Possible values = DEFAULT, DISABLED 
    .PARAMETER clientclipboardredirection 
        Allow Default access/Disable the clipboard on the client device to be mapped to the clipboard on the server.  
        Default value: DISABLED  
        Possible values = DEFAULT, DISABLED 
    .PARAMETER clientcomportredirection 
        Allow Default access/Disable COM port redirection to and from the client.  
        Default value: DISABLED  
        Possible values = DEFAULT, DISABLED 
    .PARAMETER clientdriveredirection 
        Allow Default access/Disables drive redirection to and from the client.  
        Default value: DISABLED  
        Possible values = DEFAULT, DISABLED 
    .PARAMETER clientprinterredirection 
        Allow Default access/Disable client printers to be mapped to a server when a user logs on to a session.  
        Default value: DISABLED  
        Possible values = DEFAULT, DISABLED 
    .PARAMETER multistream 
        Allow Default access/Disable the multistream feature for the specified users.  
        Default value: DISABLED  
        Possible values = DEFAULT, DISABLED 
    .PARAMETER clientusbdriveredirection 
        Allow Default access/Disable the redirection of USB devices to and from the client.  
        Default value: DISABLED  
        Possible values = DEFAULT, DISABLED 
    .PARAMETER PassThru 
        Return details about the created icaaccessprofile item.
    .EXAMPLE
        Invoke-ADCUpdateIcaaccessprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateIcaaccessprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaccessprofile/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$connectclientlptports ,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$clientaudioredirection ,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$localremotedatasharing ,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$clientclipboardredirection ,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$clientcomportredirection ,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$clientdriveredirection ,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$clientprinterredirection ,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$multistream ,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$clientusbdriveredirection ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateIcaaccessprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('connectclientlptports')) { $Payload.Add('connectclientlptports', $connectclientlptports) }
            if ($PSBoundParameters.ContainsKey('clientaudioredirection')) { $Payload.Add('clientaudioredirection', $clientaudioredirection) }
            if ($PSBoundParameters.ContainsKey('localremotedatasharing')) { $Payload.Add('localremotedatasharing', $localremotedatasharing) }
            if ($PSBoundParameters.ContainsKey('clientclipboardredirection')) { $Payload.Add('clientclipboardredirection', $clientclipboardredirection) }
            if ($PSBoundParameters.ContainsKey('clientcomportredirection')) { $Payload.Add('clientcomportredirection', $clientcomportredirection) }
            if ($PSBoundParameters.ContainsKey('clientdriveredirection')) { $Payload.Add('clientdriveredirection', $clientdriveredirection) }
            if ($PSBoundParameters.ContainsKey('clientprinterredirection')) { $Payload.Add('clientprinterredirection', $clientprinterredirection) }
            if ($PSBoundParameters.ContainsKey('multistream')) { $Payload.Add('multistream', $multistream) }
            if ($PSBoundParameters.ContainsKey('clientusbdriveredirection')) { $Payload.Add('clientusbdriveredirection', $clientusbdriveredirection) }
 
            if ($PSCmdlet.ShouldProcess("icaaccessprofile", "Update Ica configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type icaaccessprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetIcaaccessprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateIcaaccessprofile: Finished"
    }
}

function Invoke-ADCUnsetIcaaccessprofile {
<#
    .SYNOPSIS
        Unset Ica configuration Object
    .DESCRIPTION
        Unset Ica configuration Object 
   .PARAMETER name 
       Name for the ICA accessprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and  
       the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA accessprofile is added. 
   .PARAMETER connectclientlptports 
       Allow Default access/Disable automatic connection of LPT ports from the client when the user logs on.  
       Possible values = DEFAULT, DISABLED 
   .PARAMETER clientaudioredirection 
       Allow Default access/Disable applications hosted on the server to play sounds through a sound device installed on the client computer, also allows or prevents users to record audio input.  
       Possible values = DEFAULT, DISABLED 
   .PARAMETER localremotedatasharing 
       Allow Default access/Disable file/data sharing via the Receiver for HTML5.  
       Possible values = DEFAULT, DISABLED 
   .PARAMETER clientclipboardredirection 
       Allow Default access/Disable the clipboard on the client device to be mapped to the clipboard on the server.  
       Possible values = DEFAULT, DISABLED 
   .PARAMETER clientcomportredirection 
       Allow Default access/Disable COM port redirection to and from the client.  
       Possible values = DEFAULT, DISABLED 
   .PARAMETER clientdriveredirection 
       Allow Default access/Disables drive redirection to and from the client.  
       Possible values = DEFAULT, DISABLED 
   .PARAMETER clientprinterredirection 
       Allow Default access/Disable client printers to be mapped to a server when a user logs on to a session.  
       Possible values = DEFAULT, DISABLED 
   .PARAMETER multistream 
       Allow Default access/Disable the multistream feature for the specified users.  
       Possible values = DEFAULT, DISABLED 
   .PARAMETER clientusbdriveredirection 
       Allow Default access/Disable the redirection of USB devices to and from the client.  
       Possible values = DEFAULT, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetIcaaccessprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetIcaaccessprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaccessprofile
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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

        [Boolean]$connectclientlptports ,

        [Boolean]$clientaudioredirection ,

        [Boolean]$localremotedatasharing ,

        [Boolean]$clientclipboardredirection ,

        [Boolean]$clientcomportredirection ,

        [Boolean]$clientdriveredirection ,

        [Boolean]$clientprinterredirection ,

        [Boolean]$multistream ,

        [Boolean]$clientusbdriveredirection 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetIcaaccessprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('connectclientlptports')) { $Payload.Add('connectclientlptports', $connectclientlptports) }
            if ($PSBoundParameters.ContainsKey('clientaudioredirection')) { $Payload.Add('clientaudioredirection', $clientaudioredirection) }
            if ($PSBoundParameters.ContainsKey('localremotedatasharing')) { $Payload.Add('localremotedatasharing', $localremotedatasharing) }
            if ($PSBoundParameters.ContainsKey('clientclipboardredirection')) { $Payload.Add('clientclipboardredirection', $clientclipboardredirection) }
            if ($PSBoundParameters.ContainsKey('clientcomportredirection')) { $Payload.Add('clientcomportredirection', $clientcomportredirection) }
            if ($PSBoundParameters.ContainsKey('clientdriveredirection')) { $Payload.Add('clientdriveredirection', $clientdriveredirection) }
            if ($PSBoundParameters.ContainsKey('clientprinterredirection')) { $Payload.Add('clientprinterredirection', $clientprinterredirection) }
            if ($PSBoundParameters.ContainsKey('multistream')) { $Payload.Add('multistream', $multistream) }
            if ($PSBoundParameters.ContainsKey('clientusbdriveredirection')) { $Payload.Add('clientusbdriveredirection', $clientusbdriveredirection) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Ica configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type icaaccessprofile -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetIcaaccessprofile: Finished"
    }
}

function Invoke-ADCGetIcaaccessprofile {
<#
    .SYNOPSIS
        Get Ica configuration object(s)
    .DESCRIPTION
        Get Ica configuration object(s)
    .PARAMETER name 
       Name for the ICA accessprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and  
       the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA accessprofile is added. 
    .PARAMETER GetAll 
        Retreive all icaaccessprofile object(s)
    .PARAMETER Count
        If specified, the count of the icaaccessprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetIcaaccessprofile
    .EXAMPLE 
        Invoke-ADCGetIcaaccessprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetIcaaccessprofile -Count
    .EXAMPLE
        Invoke-ADCGetIcaaccessprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetIcaaccessprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetIcaaccessprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaccessprofile/
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
        Write-Verbose "Invoke-ADCGetIcaaccessprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all icaaccessprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaccessprofile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icaaccessprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaccessprofile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icaaccessprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaccessprofile -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icaaccessprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaccessprofile -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icaaccessprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaccessprofile -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetIcaaccessprofile: Ended"
    }
}

function Invoke-ADCAddIcaaction {
<#
    .SYNOPSIS
        Add Ica configuration Object
    .DESCRIPTION
        Add Ica configuration Object 
    .PARAMETER name 
        Name for the ICA action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA action is added. 
    .PARAMETER accessprofilename 
        Name of the ica accessprofile to be associated with this action. 
    .PARAMETER latencyprofilename 
        Name of the ica latencyprofile to be associated with this action. 
    .PARAMETER PassThru 
        Return details about the created icaaction item.
    .EXAMPLE
        Invoke-ADCAddIcaaction -name <string>
    .NOTES
        File Name : Invoke-ADCAddIcaaction
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaction/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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

        [string]$accessprofilename ,

        [string]$latencyprofilename ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddIcaaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('accessprofilename')) { $Payload.Add('accessprofilename', $accessprofilename) }
            if ($PSBoundParameters.ContainsKey('latencyprofilename')) { $Payload.Add('latencyprofilename', $latencyprofilename) }
 
            if ($PSCmdlet.ShouldProcess("icaaction", "Add Ica configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type icaaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetIcaaction -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddIcaaction: Finished"
    }
}

function Invoke-ADCDeleteIcaaction {
<#
    .SYNOPSIS
        Delete Ica configuration Object
    .DESCRIPTION
        Delete Ica configuration Object
    .PARAMETER name 
       Name for the ICA action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA action is added. 
    .EXAMPLE
        Invoke-ADCDeleteIcaaction -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteIcaaction
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaction/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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
        Write-Verbose "Invoke-ADCDeleteIcaaction: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Ica configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type icaaction -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteIcaaction: Finished"
    }
}

function Invoke-ADCUpdateIcaaction {
<#
    .SYNOPSIS
        Update Ica configuration Object
    .DESCRIPTION
        Update Ica configuration Object 
    .PARAMETER name 
        Name for the ICA action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA action is added. 
    .PARAMETER accessprofilename 
        Name of the ica accessprofile to be associated with this action. 
    .PARAMETER latencyprofilename 
        Name of the ica latencyprofile to be associated with this action. 
    .PARAMETER PassThru 
        Return details about the created icaaction item.
    .EXAMPLE
        Invoke-ADCUpdateIcaaction -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateIcaaction
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaction/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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

        [string]$accessprofilename ,

        [string]$latencyprofilename ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateIcaaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('accessprofilename')) { $Payload.Add('accessprofilename', $accessprofilename) }
            if ($PSBoundParameters.ContainsKey('latencyprofilename')) { $Payload.Add('latencyprofilename', $latencyprofilename) }
 
            if ($PSCmdlet.ShouldProcess("icaaction", "Update Ica configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type icaaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetIcaaction -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateIcaaction: Finished"
    }
}

function Invoke-ADCUnsetIcaaction {
<#
    .SYNOPSIS
        Unset Ica configuration Object
    .DESCRIPTION
        Unset Ica configuration Object 
   .PARAMETER name 
       Name for the ICA action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA action is added. 
   .PARAMETER accessprofilename 
       Name of the ica accessprofile to be associated with this action. 
   .PARAMETER latencyprofilename 
       Name of the ica latencyprofile to be associated with this action.
    .EXAMPLE
        Invoke-ADCUnsetIcaaction -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetIcaaction
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaction
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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

        [Boolean]$accessprofilename ,

        [Boolean]$latencyprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetIcaaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('accessprofilename')) { $Payload.Add('accessprofilename', $accessprofilename) }
            if ($PSBoundParameters.ContainsKey('latencyprofilename')) { $Payload.Add('latencyprofilename', $latencyprofilename) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Ica configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type icaaction -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetIcaaction: Finished"
    }
}

function Invoke-ADCRenameIcaaction {
<#
    .SYNOPSIS
        Rename Ica configuration Object
    .DESCRIPTION
        Rename Ica configuration Object 
    .PARAMETER name 
        Name for the ICA action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA action is added. 
    .PARAMETER newname 
        New name for the ICA action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#),period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created icaaction item.
    .EXAMPLE
        Invoke-ADCRenameIcaaction -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameIcaaction
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaction/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameIcaaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("icaaction", "Rename Ica configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type icaaction -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetIcaaction -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameIcaaction: Finished"
    }
}

function Invoke-ADCGetIcaaction {
<#
    .SYNOPSIS
        Get Ica configuration object(s)
    .DESCRIPTION
        Get Ica configuration object(s)
    .PARAMETER name 
       Name for the ICA action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA action is added. 
    .PARAMETER GetAll 
        Retreive all icaaction object(s)
    .PARAMETER Count
        If specified, the count of the icaaction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetIcaaction
    .EXAMPLE 
        Invoke-ADCGetIcaaction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetIcaaction -Count
    .EXAMPLE
        Invoke-ADCGetIcaaction -name <string>
    .EXAMPLE
        Invoke-ADCGetIcaaction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetIcaaction
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaction/
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
        Write-Verbose "Invoke-ADCGetIcaaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all icaaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaction -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icaaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaction -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icaaction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaction -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icaaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaction -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icaaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaction -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetIcaaction: Ended"
    }
}

function Invoke-ADCGetIcaglobalbinding {
<#
    .SYNOPSIS
        Get Ica configuration object(s)
    .DESCRIPTION
        Get Ica configuration object(s)
    .PARAMETER GetAll 
        Retreive all icaglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the icaglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetIcaglobalbinding
    .EXAMPLE 
        Invoke-ADCGetIcaglobalbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetIcaglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetIcaglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetIcaglobalbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaglobal_binding/
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
        Write-Verbose "Invoke-ADCGetIcaglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all icaglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaglobal_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icaglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaglobal_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icaglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaglobal_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icaglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving icaglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaglobal_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetIcaglobalbinding: Ended"
    }
}

function Invoke-ADCAddIcaglobalicapolicybinding {
<#
    .SYNOPSIS
        Add Ica configuration Object
    .DESCRIPTION
        Add Ica configuration Object 
    .PARAMETER policyname 
        Name of the ICA policy. 
    .PARAMETER priority 
        Specifies the priority of the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER type 
        Global bind point for which to show detailed information about the policies bound to the bind point.  
        Possible values = ICA_REQ_OVERRIDE, ICA_REQ_DEFAULT 
    .PARAMETER PassThru 
        Return details about the created icaglobal_icapolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddIcaglobalicapolicybinding -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddIcaglobalicapolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaglobal_icapolicy_binding/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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
        [string]$policyname ,

        [Parameter(Mandatory = $true)]
        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('ICA_REQ_OVERRIDE', 'ICA_REQ_DEFAULT')]
        [string]$type ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddIcaglobalicapolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
                priority = $priority
            }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
 
            if ($PSCmdlet.ShouldProcess("icaglobal_icapolicy_binding", "Add Ica configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type icaglobal_icapolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetIcaglobalicapolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddIcaglobalicapolicybinding: Finished"
    }
}

function Invoke-ADCDeleteIcaglobalicapolicybinding {
<#
    .SYNOPSIS
        Delete Ica configuration Object
    .DESCRIPTION
        Delete Ica configuration Object
     .PARAMETER policyname 
       Name of the ICA policy.    .PARAMETER type 
       Global bind point for which to show detailed information about the policies bound to the bind point.  
       Possible values = ICA_REQ_OVERRIDE, ICA_REQ_DEFAULT    .PARAMETER priority 
       Specifies the priority of the policy.
    .EXAMPLE
        Invoke-ADCDeleteIcaglobalicapolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteIcaglobalicapolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaglobal_icapolicy_binding/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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
        Write-Verbose "Invoke-ADCDeleteIcaglobalicapolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("icaglobal_icapolicy_binding", "Delete Ica configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type icaglobal_icapolicy_binding -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteIcaglobalicapolicybinding: Finished"
    }
}

function Invoke-ADCGetIcaglobalicapolicybinding {
<#
    .SYNOPSIS
        Get Ica configuration object(s)
    .DESCRIPTION
        Get Ica configuration object(s)
    .PARAMETER GetAll 
        Retreive all icaglobal_icapolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the icaglobal_icapolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetIcaglobalicapolicybinding
    .EXAMPLE 
        Invoke-ADCGetIcaglobalicapolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetIcaglobalicapolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetIcaglobalicapolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetIcaglobalicapolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetIcaglobalicapolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaglobal_icapolicy_binding/
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
        Write-Verbose "Invoke-ADCGetIcaglobalicapolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all icaglobal_icapolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaglobal_icapolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icaglobal_icapolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaglobal_icapolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icaglobal_icapolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaglobal_icapolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icaglobal_icapolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving icaglobal_icapolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaglobal_icapolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetIcaglobalicapolicybinding: Ended"
    }
}

function Invoke-ADCAddIcalatencyprofile {
<#
    .SYNOPSIS
        Add Ica configuration Object
    .DESCRIPTION
        Add Ica configuration Object 
    .PARAMETER name 
        Name for the ICA latencyprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and  
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA latency profile is added. 
    .PARAMETER l7latencymonitoring 
        Enable/Disable L7 Latency monitoring for L7 latency notifications.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER l7latencythresholdfactor 
        L7 Latency threshold factor. This is the factor by which the active latency should be greater than the minimum observed value to determine that the latency is high and may need to be reported.  
        Default value: 4  
        Minimum value = 2  
        Maximum value = 65535 
    .PARAMETER l7latencywaittime 
        L7 Latency Wait time. This is the time for which the Citrix ADC waits after the threshold is exceeded before it sends out a Notification to the Insight Center.  
        Default value: 20  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER l7latencynotifyinterval 
        L7 Latency Notify Interval. This is the interval at which the Citrix ADC sends out notifications to the Insight Center after the wait time has passed.  
        Default value: 20  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER l7latencymaxnotifycount 
        L7 Latency Max notify Count. This is the upper limit on the number of notifications sent to the Insight Center within an interval where the Latency is above the threshold.  
        Default value: 5  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER PassThru 
        Return details about the created icalatencyprofile item.
    .EXAMPLE
        Invoke-ADCAddIcalatencyprofile -name <string>
    .NOTES
        File Name : Invoke-ADCAddIcalatencyprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icalatencyprofile/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$l7latencymonitoring = 'DISABLED' ,

        [ValidateRange(2, 65535)]
        [double]$l7latencythresholdfactor = '4' ,

        [ValidateRange(1, 65535)]
        [double]$l7latencywaittime = '20' ,

        [ValidateRange(1, 65535)]
        [double]$l7latencynotifyinterval = '20' ,

        [ValidateRange(1, 65535)]
        [double]$l7latencymaxnotifycount = '5' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddIcalatencyprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('l7latencymonitoring')) { $Payload.Add('l7latencymonitoring', $l7latencymonitoring) }
            if ($PSBoundParameters.ContainsKey('l7latencythresholdfactor')) { $Payload.Add('l7latencythresholdfactor', $l7latencythresholdfactor) }
            if ($PSBoundParameters.ContainsKey('l7latencywaittime')) { $Payload.Add('l7latencywaittime', $l7latencywaittime) }
            if ($PSBoundParameters.ContainsKey('l7latencynotifyinterval')) { $Payload.Add('l7latencynotifyinterval', $l7latencynotifyinterval) }
            if ($PSBoundParameters.ContainsKey('l7latencymaxnotifycount')) { $Payload.Add('l7latencymaxnotifycount', $l7latencymaxnotifycount) }
 
            if ($PSCmdlet.ShouldProcess("icalatencyprofile", "Add Ica configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type icalatencyprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetIcalatencyprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddIcalatencyprofile: Finished"
    }
}

function Invoke-ADCDeleteIcalatencyprofile {
<#
    .SYNOPSIS
        Delete Ica configuration Object
    .DESCRIPTION
        Delete Ica configuration Object
    .PARAMETER name 
       Name for the ICA latencyprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and  
       the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA latency profile is added. 
    .EXAMPLE
        Invoke-ADCDeleteIcalatencyprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteIcalatencyprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icalatencyprofile/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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
        Write-Verbose "Invoke-ADCDeleteIcalatencyprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Ica configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type icalatencyprofile -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteIcalatencyprofile: Finished"
    }
}

function Invoke-ADCUpdateIcalatencyprofile {
<#
    .SYNOPSIS
        Update Ica configuration Object
    .DESCRIPTION
        Update Ica configuration Object 
    .PARAMETER name 
        Name for the ICA latencyprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and  
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA latency profile is added. 
    .PARAMETER l7latencymonitoring 
        Enable/Disable L7 Latency monitoring for L7 latency notifications.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER l7latencythresholdfactor 
        L7 Latency threshold factor. This is the factor by which the active latency should be greater than the minimum observed value to determine that the latency is high and may need to be reported.  
        Default value: 4  
        Minimum value = 2  
        Maximum value = 65535 
    .PARAMETER l7latencywaittime 
        L7 Latency Wait time. This is the time for which the Citrix ADC waits after the threshold is exceeded before it sends out a Notification to the Insight Center.  
        Default value: 20  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER l7latencynotifyinterval 
        L7 Latency Notify Interval. This is the interval at which the Citrix ADC sends out notifications to the Insight Center after the wait time has passed.  
        Default value: 20  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER l7latencymaxnotifycount 
        L7 Latency Max notify Count. This is the upper limit on the number of notifications sent to the Insight Center within an interval where the Latency is above the threshold.  
        Default value: 5  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER PassThru 
        Return details about the created icalatencyprofile item.
    .EXAMPLE
        Invoke-ADCUpdateIcalatencyprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateIcalatencyprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icalatencyprofile/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$l7latencymonitoring ,

        [ValidateRange(2, 65535)]
        [double]$l7latencythresholdfactor ,

        [ValidateRange(1, 65535)]
        [double]$l7latencywaittime ,

        [ValidateRange(1, 65535)]
        [double]$l7latencynotifyinterval ,

        [ValidateRange(1, 65535)]
        [double]$l7latencymaxnotifycount ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateIcalatencyprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('l7latencymonitoring')) { $Payload.Add('l7latencymonitoring', $l7latencymonitoring) }
            if ($PSBoundParameters.ContainsKey('l7latencythresholdfactor')) { $Payload.Add('l7latencythresholdfactor', $l7latencythresholdfactor) }
            if ($PSBoundParameters.ContainsKey('l7latencywaittime')) { $Payload.Add('l7latencywaittime', $l7latencywaittime) }
            if ($PSBoundParameters.ContainsKey('l7latencynotifyinterval')) { $Payload.Add('l7latencynotifyinterval', $l7latencynotifyinterval) }
            if ($PSBoundParameters.ContainsKey('l7latencymaxnotifycount')) { $Payload.Add('l7latencymaxnotifycount', $l7latencymaxnotifycount) }
 
            if ($PSCmdlet.ShouldProcess("icalatencyprofile", "Update Ica configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type icalatencyprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetIcalatencyprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateIcalatencyprofile: Finished"
    }
}

function Invoke-ADCUnsetIcalatencyprofile {
<#
    .SYNOPSIS
        Unset Ica configuration Object
    .DESCRIPTION
        Unset Ica configuration Object 
   .PARAMETER name 
       Name for the ICA latencyprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and  
       the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA latency profile is added. 
   .PARAMETER l7latencymonitoring 
       Enable/Disable L7 Latency monitoring for L7 latency notifications.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER l7latencythresholdfactor 
       L7 Latency threshold factor. This is the factor by which the active latency should be greater than the minimum observed value to determine that the latency is high and may need to be reported. 
   .PARAMETER l7latencywaittime 
       L7 Latency Wait time. This is the time for which the Citrix ADC waits after the threshold is exceeded before it sends out a Notification to the Insight Center. 
   .PARAMETER l7latencynotifyinterval 
       L7 Latency Notify Interval. This is the interval at which the Citrix ADC sends out notifications to the Insight Center after the wait time has passed. 
   .PARAMETER l7latencymaxnotifycount 
       L7 Latency Max notify Count. This is the upper limit on the number of notifications sent to the Insight Center within an interval where the Latency is above the threshold.
    .EXAMPLE
        Invoke-ADCUnsetIcalatencyprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetIcalatencyprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icalatencyprofile
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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

        [Boolean]$l7latencymonitoring ,

        [Boolean]$l7latencythresholdfactor ,

        [Boolean]$l7latencywaittime ,

        [Boolean]$l7latencynotifyinterval ,

        [Boolean]$l7latencymaxnotifycount 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetIcalatencyprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('l7latencymonitoring')) { $Payload.Add('l7latencymonitoring', $l7latencymonitoring) }
            if ($PSBoundParameters.ContainsKey('l7latencythresholdfactor')) { $Payload.Add('l7latencythresholdfactor', $l7latencythresholdfactor) }
            if ($PSBoundParameters.ContainsKey('l7latencywaittime')) { $Payload.Add('l7latencywaittime', $l7latencywaittime) }
            if ($PSBoundParameters.ContainsKey('l7latencynotifyinterval')) { $Payload.Add('l7latencynotifyinterval', $l7latencynotifyinterval) }
            if ($PSBoundParameters.ContainsKey('l7latencymaxnotifycount')) { $Payload.Add('l7latencymaxnotifycount', $l7latencymaxnotifycount) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Ica configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type icalatencyprofile -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetIcalatencyprofile: Finished"
    }
}

function Invoke-ADCGetIcalatencyprofile {
<#
    .SYNOPSIS
        Get Ica configuration object(s)
    .DESCRIPTION
        Get Ica configuration object(s)
    .PARAMETER name 
       Name for the ICA latencyprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and  
       the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA latency profile is added. 
    .PARAMETER GetAll 
        Retreive all icalatencyprofile object(s)
    .PARAMETER Count
        If specified, the count of the icalatencyprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetIcalatencyprofile
    .EXAMPLE 
        Invoke-ADCGetIcalatencyprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetIcalatencyprofile -Count
    .EXAMPLE
        Invoke-ADCGetIcalatencyprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetIcalatencyprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetIcalatencyprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icalatencyprofile/
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
        Write-Verbose "Invoke-ADCGetIcalatencyprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all icalatencyprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icalatencyprofile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icalatencyprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icalatencyprofile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icalatencyprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icalatencyprofile -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icalatencyprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icalatencyprofile -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icalatencyprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icalatencyprofile -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetIcalatencyprofile: Ended"
    }
}

function Invoke-ADCUpdateIcaparameter {
<#
    .SYNOPSIS
        Update Ica configuration Object
    .DESCRIPTION
        Update Ica configuration Object 
    .PARAMETER enablesronhafailover 
        Enable/Disable Session Reliability on HA failover. The default value is No.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER hdxinsightnonnsap 
        Enable/Disable HDXInsight for Non NSAP ICA Sessions. The default value is Yes.  
        Default value: YES  
        Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCUpdateIcaparameter 
    .NOTES
        File Name : Invoke-ADCUpdateIcaparameter
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaparameter/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [ValidateSet('YES', 'NO')]
        [string]$enablesronhafailover ,

        [ValidateSet('YES', 'NO')]
        [string]$hdxinsightnonnsap 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateIcaparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('enablesronhafailover')) { $Payload.Add('enablesronhafailover', $enablesronhafailover) }
            if ($PSBoundParameters.ContainsKey('hdxinsightnonnsap')) { $Payload.Add('hdxinsightnonnsap', $hdxinsightnonnsap) }
 
            if ($PSCmdlet.ShouldProcess("icaparameter", "Update Ica configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type icaparameter -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateIcaparameter: Finished"
    }
}

function Invoke-ADCUnsetIcaparameter {
<#
    .SYNOPSIS
        Unset Ica configuration Object
    .DESCRIPTION
        Unset Ica configuration Object 
   .PARAMETER enablesronhafailover 
       Enable/Disable Session Reliability on HA failover. The default value is No.  
       Possible values = YES, NO 
   .PARAMETER hdxinsightnonnsap 
       Enable/Disable HDXInsight for Non NSAP ICA Sessions. The default value is Yes.  
       Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCUnsetIcaparameter 
    .NOTES
        File Name : Invoke-ADCUnsetIcaparameter
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaparameter
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Boolean]$enablesronhafailover ,

        [Boolean]$hdxinsightnonnsap 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetIcaparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('enablesronhafailover')) { $Payload.Add('enablesronhafailover', $enablesronhafailover) }
            if ($PSBoundParameters.ContainsKey('hdxinsightnonnsap')) { $Payload.Add('hdxinsightnonnsap', $hdxinsightnonnsap) }
            if ($PSCmdlet.ShouldProcess("icaparameter", "Unset Ica configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type icaparameter -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetIcaparameter: Finished"
    }
}

function Invoke-ADCGetIcaparameter {
<#
    .SYNOPSIS
        Get Ica configuration object(s)
    .DESCRIPTION
        Get Ica configuration object(s)
    .PARAMETER GetAll 
        Retreive all icaparameter object(s)
    .PARAMETER Count
        If specified, the count of the icaparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetIcaparameter
    .EXAMPLE 
        Invoke-ADCGetIcaparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetIcaparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetIcaparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetIcaparameter
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaparameter/
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
        Write-Verbose "Invoke-ADCGetIcaparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all icaparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaparameter -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icaparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaparameter -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icaparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaparameter -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icaparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving icaparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaparameter -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetIcaparameter: Ended"
    }
}

function Invoke-ADCAddIcapolicy {
<#
    .SYNOPSIS
        Add Ica configuration Object
    .DESCRIPTION
        Add Ica configuration Object 
    .PARAMETER name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER rule 
        Expression or other value against which the traffic is evaluated. Must be a Boolean expression.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER action 
        Name of the ica action to be associated with this policy. 
    .PARAMETER comment 
        Any type of information about this ICA policy. 
    .PARAMETER logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created icapolicy item.
    .EXAMPLE
        Invoke-ADCAddIcapolicy -name <string> -rule <string> -action <string>
    .NOTES
        File Name : Invoke-ADCAddIcapolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [string]$rule ,

        [Parameter(Mandatory = $true)]
        [string]$action ,

        [string]$comment ,

        [string]$logaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddIcapolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                rule = $rule
                action = $action
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
 
            if ($PSCmdlet.ShouldProcess("icapolicy", "Add Ica configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type icapolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetIcapolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddIcapolicy: Finished"
    }
}

function Invoke-ADCDeleteIcapolicy {
<#
    .SYNOPSIS
        Delete Ica configuration Object
    .DESCRIPTION
        Delete Ica configuration Object
    .PARAMETER name 
       Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .EXAMPLE
        Invoke-ADCDeleteIcapolicy -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteIcapolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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
        Write-Verbose "Invoke-ADCDeleteIcapolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Ica configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type icapolicy -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteIcapolicy: Finished"
    }
}

function Invoke-ADCUpdateIcapolicy {
<#
    .SYNOPSIS
        Update Ica configuration Object
    .DESCRIPTION
        Update Ica configuration Object 
    .PARAMETER name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER rule 
        Expression or other value against which the traffic is evaluated. Must be a Boolean expression.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER action 
        Name of the ica action to be associated with this policy. 
    .PARAMETER comment 
        Any type of information about this ICA policy. 
    .PARAMETER logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created icapolicy item.
    .EXAMPLE
        Invoke-ADCUpdateIcapolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateIcapolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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
        [string]$name ,

        [string]$rule ,

        [string]$action ,

        [string]$comment ,

        [string]$logaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateIcapolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
 
            if ($PSCmdlet.ShouldProcess("icapolicy", "Update Ica configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type icapolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetIcapolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateIcapolicy: Finished"
    }
}

function Invoke-ADCUnsetIcapolicy {
<#
    .SYNOPSIS
        Unset Ica configuration Object
    .DESCRIPTION
        Unset Ica configuration Object 
   .PARAMETER name 
       Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
   .PARAMETER comment 
       Any type of information about this ICA policy. 
   .PARAMETER logaction 
       Name of the messagelog action to use for requests that match this policy.
    .EXAMPLE
        Invoke-ADCUnsetIcapolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetIcapolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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
        [string]$name ,

        [Boolean]$comment ,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetIcapolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Ica configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type icapolicy -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetIcapolicy: Finished"
    }
}

function Invoke-ADCRenameIcapolicy {
<#
    .SYNOPSIS
        Rename Ica configuration Object
    .DESCRIPTION
        Rename Ica configuration Object 
    .PARAMETER name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER newname 
        New name for the policy. Must begin with an ASCII alphabetic or underscore (_)character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), s  
        pace, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created icapolicy item.
    .EXAMPLE
        Invoke-ADCRenameIcapolicy -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameIcapolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
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
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameIcapolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("icapolicy", "Rename Ica configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type icapolicy -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetIcapolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameIcapolicy: Finished"
    }
}

function Invoke-ADCGetIcapolicy {
<#
    .SYNOPSIS
        Get Ica configuration object(s)
    .DESCRIPTION
        Get Ica configuration object(s)
    .PARAMETER name 
       Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retreive all icapolicy object(s)
    .PARAMETER Count
        If specified, the count of the icapolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetIcapolicy
    .EXAMPLE 
        Invoke-ADCGetIcapolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetIcapolicy -Count
    .EXAMPLE
        Invoke-ADCGetIcapolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetIcapolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetIcapolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy/
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
        Write-Verbose "Invoke-ADCGetIcapolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all icapolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icapolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icapolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icapolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icapolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetIcapolicy: Ended"
    }
}

function Invoke-ADCGetIcapolicybinding {
<#
    .SYNOPSIS
        Get Ica configuration object(s)
    .DESCRIPTION
        Get Ica configuration object(s)
    .PARAMETER name 
       Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all icapolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the icapolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetIcapolicybinding
    .EXAMPLE 
        Invoke-ADCGetIcapolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetIcapolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetIcapolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetIcapolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy_binding/
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
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetIcapolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all icapolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icapolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icapolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icapolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icapolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetIcapolicybinding: Ended"
    }
}

function Invoke-ADCGetIcapolicycrvserverbinding {
<#
    .SYNOPSIS
        Get Ica configuration object(s)
    .DESCRIPTION
        Get Ica configuration object(s)
    .PARAMETER name 
       Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all icapolicy_crvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the icapolicy_crvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetIcapolicycrvserverbinding
    .EXAMPLE 
        Invoke-ADCGetIcapolicycrvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetIcapolicycrvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetIcapolicycrvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetIcapolicycrvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetIcapolicycrvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy_crvserver_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetIcapolicycrvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all icapolicy_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_crvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icapolicy_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_crvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icapolicy_crvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_crvserver_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icapolicy_crvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_crvserver_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icapolicy_crvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_crvserver_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetIcapolicycrvserverbinding: Ended"
    }
}

function Invoke-ADCGetIcapolicyicaglobalbinding {
<#
    .SYNOPSIS
        Get Ica configuration object(s)
    .DESCRIPTION
        Get Ica configuration object(s)
    .PARAMETER name 
       Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all icapolicy_icaglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the icapolicy_icaglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetIcapolicyicaglobalbinding
    .EXAMPLE 
        Invoke-ADCGetIcapolicyicaglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetIcapolicyicaglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetIcapolicyicaglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetIcapolicyicaglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetIcapolicyicaglobalbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy_icaglobal_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetIcapolicyicaglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all icapolicy_icaglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_icaglobal_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icapolicy_icaglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_icaglobal_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icapolicy_icaglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_icaglobal_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icapolicy_icaglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_icaglobal_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icapolicy_icaglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_icaglobal_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetIcapolicyicaglobalbinding: Ended"
    }
}

function Invoke-ADCGetIcapolicyvpnvserverbinding {
<#
    .SYNOPSIS
        Get Ica configuration object(s)
    .DESCRIPTION
        Get Ica configuration object(s)
    .PARAMETER name 
       Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all icapolicy_vpnvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the icapolicy_vpnvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetIcapolicyvpnvserverbinding
    .EXAMPLE 
        Invoke-ADCGetIcapolicyvpnvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetIcapolicyvpnvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetIcapolicyvpnvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetIcapolicyvpnvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetIcapolicyvpnvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy_vpnvserver_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetIcapolicyvpnvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all icapolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_vpnvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icapolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_vpnvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icapolicy_vpnvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_vpnvserver_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icapolicy_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_vpnvserver_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icapolicy_vpnvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_vpnvserver_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetIcapolicyvpnvserverbinding: Ended"
    }
}


