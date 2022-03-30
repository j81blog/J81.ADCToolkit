function Invoke-ADCAddIcaaccessprofile {
    <#
    .SYNOPSIS
        Add Ica configuration Object.
    .DESCRIPTION
        Configuration for ica accessprofile resource.
    .PARAMETER Name 
        Name for the ICA accessprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA accessprofile is added. 
    .PARAMETER Connectclientlptports 
        Allow Default access/Disable automatic connection of LPT ports from the client when the user logs on. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientaudioredirection 
        Allow Default access/Disable applications hosted on the server to play sounds through a sound device installed on the client computer, also allows or prevents users to record audio input. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Localremotedatasharing 
        Allow Default access/Disable file/data sharing via the Receiver for HTML5. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientclipboardredirection 
        Allow Default access/Disable the clipboard on the client device to be mapped to the clipboard on the server. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientcomportredirection 
        Allow Default access/Disable COM port redirection to and from the client. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientdriveredirection 
        Allow Default access/Disables drive redirection to and from the client. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientprinterredirection 
        Allow Default access/Disable client printers to be mapped to a server when a user logs on to a session. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Multistream 
        Allow Default access/Disable the multistream feature for the specified users. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientusbdriveredirection 
        Allow Default access/Disable the redirection of USB devices to and from the client. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER PassThru 
        Return details about the created icaaccessprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddIcaaccessprofile -name <string>
        An example how to add icaaccessprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddIcaaccessprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaccessprofile/
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

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Connectclientlptports = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientaudioredirection = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Localremotedatasharing = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientclipboardredirection = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientcomportredirection = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientdriveredirection = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientprinterredirection = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Multistream = 'DISABLED',

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientusbdriveredirection = 'DISABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddIcaaccessprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('connectclientlptports') ) { $payload.Add('connectclientlptports', $connectclientlptports) }
            if ( $PSBoundParameters.ContainsKey('clientaudioredirection') ) { $payload.Add('clientaudioredirection', $clientaudioredirection) }
            if ( $PSBoundParameters.ContainsKey('localremotedatasharing') ) { $payload.Add('localremotedatasharing', $localremotedatasharing) }
            if ( $PSBoundParameters.ContainsKey('clientclipboardredirection') ) { $payload.Add('clientclipboardredirection', $clientclipboardredirection) }
            if ( $PSBoundParameters.ContainsKey('clientcomportredirection') ) { $payload.Add('clientcomportredirection', $clientcomportredirection) }
            if ( $PSBoundParameters.ContainsKey('clientdriveredirection') ) { $payload.Add('clientdriveredirection', $clientdriveredirection) }
            if ( $PSBoundParameters.ContainsKey('clientprinterredirection') ) { $payload.Add('clientprinterredirection', $clientprinterredirection) }
            if ( $PSBoundParameters.ContainsKey('multistream') ) { $payload.Add('multistream', $multistream) }
            if ( $PSBoundParameters.ContainsKey('clientusbdriveredirection') ) { $payload.Add('clientusbdriveredirection', $clientusbdriveredirection) }
            if ( $PSCmdlet.ShouldProcess("icaaccessprofile", "Add Ica configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type icaaccessprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetIcaaccessprofile -Filter $payload)
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
        Delete Ica configuration Object.
    .DESCRIPTION
        Configuration for ica accessprofile resource.
    .PARAMETER Name 
        Name for the ICA accessprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA accessprofile is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteIcaaccessprofile -Name <string>
        An example how to delete icaaccessprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteIcaaccessprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaccessprofile/
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
        Write-Verbose "Invoke-ADCDeleteIcaaccessprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Ica configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type icaaccessprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update Ica configuration Object.
    .DESCRIPTION
        Configuration for ica accessprofile resource.
    .PARAMETER Name 
        Name for the ICA accessprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA accessprofile is added. 
    .PARAMETER Connectclientlptports 
        Allow Default access/Disable automatic connection of LPT ports from the client when the user logs on. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientaudioredirection 
        Allow Default access/Disable applications hosted on the server to play sounds through a sound device installed on the client computer, also allows or prevents users to record audio input. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Localremotedatasharing 
        Allow Default access/Disable file/data sharing via the Receiver for HTML5. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientclipboardredirection 
        Allow Default access/Disable the clipboard on the client device to be mapped to the clipboard on the server. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientcomportredirection 
        Allow Default access/Disable COM port redirection to and from the client. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientdriveredirection 
        Allow Default access/Disables drive redirection to and from the client. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientprinterredirection 
        Allow Default access/Disable client printers to be mapped to a server when a user logs on to a session. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Multistream 
        Allow Default access/Disable the multistream feature for the specified users. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientusbdriveredirection 
        Allow Default access/Disable the redirection of USB devices to and from the client. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER PassThru 
        Return details about the created icaaccessprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateIcaaccessprofile -name <string>
        An example how to update icaaccessprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateIcaaccessprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaccessprofile/
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

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Connectclientlptports,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientaudioredirection,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Localremotedatasharing,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientclipboardredirection,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientcomportredirection,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientdriveredirection,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientprinterredirection,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Multistream,

        [ValidateSet('DEFAULT', 'DISABLED')]
        [string]$Clientusbdriveredirection,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateIcaaccessprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('connectclientlptports') ) { $payload.Add('connectclientlptports', $connectclientlptports) }
            if ( $PSBoundParameters.ContainsKey('clientaudioredirection') ) { $payload.Add('clientaudioredirection', $clientaudioredirection) }
            if ( $PSBoundParameters.ContainsKey('localremotedatasharing') ) { $payload.Add('localremotedatasharing', $localremotedatasharing) }
            if ( $PSBoundParameters.ContainsKey('clientclipboardredirection') ) { $payload.Add('clientclipboardredirection', $clientclipboardredirection) }
            if ( $PSBoundParameters.ContainsKey('clientcomportredirection') ) { $payload.Add('clientcomportredirection', $clientcomportredirection) }
            if ( $PSBoundParameters.ContainsKey('clientdriveredirection') ) { $payload.Add('clientdriveredirection', $clientdriveredirection) }
            if ( $PSBoundParameters.ContainsKey('clientprinterredirection') ) { $payload.Add('clientprinterredirection', $clientprinterredirection) }
            if ( $PSBoundParameters.ContainsKey('multistream') ) { $payload.Add('multistream', $multistream) }
            if ( $PSBoundParameters.ContainsKey('clientusbdriveredirection') ) { $payload.Add('clientusbdriveredirection', $clientusbdriveredirection) }
            if ( $PSCmdlet.ShouldProcess("icaaccessprofile", "Update Ica configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type icaaccessprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetIcaaccessprofile -Filter $payload)
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
        Unset Ica configuration Object.
    .DESCRIPTION
        Configuration for ica accessprofile resource.
    .PARAMETER Name 
        Name for the ICA accessprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA accessprofile is added. 
    .PARAMETER Connectclientlptports 
        Allow Default access/Disable automatic connection of LPT ports from the client when the user logs on. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientaudioredirection 
        Allow Default access/Disable applications hosted on the server to play sounds through a sound device installed on the client computer, also allows or prevents users to record audio input. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Localremotedatasharing 
        Allow Default access/Disable file/data sharing via the Receiver for HTML5. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientclipboardredirection 
        Allow Default access/Disable the clipboard on the client device to be mapped to the clipboard on the server. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientcomportredirection 
        Allow Default access/Disable COM port redirection to and from the client. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientdriveredirection 
        Allow Default access/Disables drive redirection to and from the client. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientprinterredirection 
        Allow Default access/Disable client printers to be mapped to a server when a user logs on to a session. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Multistream 
        Allow Default access/Disable the multistream feature for the specified users. 
        Possible values = DEFAULT, DISABLED 
    .PARAMETER Clientusbdriveredirection 
        Allow Default access/Disable the redirection of USB devices to and from the client. 
        Possible values = DEFAULT, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetIcaaccessprofile -name <string>
        An example how to unset icaaccessprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetIcaaccessprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaccessprofile
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

        [Boolean]$connectclientlptports,

        [Boolean]$clientaudioredirection,

        [Boolean]$localremotedatasharing,

        [Boolean]$clientclipboardredirection,

        [Boolean]$clientcomportredirection,

        [Boolean]$clientdriveredirection,

        [Boolean]$clientprinterredirection,

        [Boolean]$multistream,

        [Boolean]$clientusbdriveredirection 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetIcaaccessprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('connectclientlptports') ) { $payload.Add('connectclientlptports', $connectclientlptports) }
            if ( $PSBoundParameters.ContainsKey('clientaudioredirection') ) { $payload.Add('clientaudioredirection', $clientaudioredirection) }
            if ( $PSBoundParameters.ContainsKey('localremotedatasharing') ) { $payload.Add('localremotedatasharing', $localremotedatasharing) }
            if ( $PSBoundParameters.ContainsKey('clientclipboardredirection') ) { $payload.Add('clientclipboardredirection', $clientclipboardredirection) }
            if ( $PSBoundParameters.ContainsKey('clientcomportredirection') ) { $payload.Add('clientcomportredirection', $clientcomportredirection) }
            if ( $PSBoundParameters.ContainsKey('clientdriveredirection') ) { $payload.Add('clientdriveredirection', $clientdriveredirection) }
            if ( $PSBoundParameters.ContainsKey('clientprinterredirection') ) { $payload.Add('clientprinterredirection', $clientprinterredirection) }
            if ( $PSBoundParameters.ContainsKey('multistream') ) { $payload.Add('multistream', $multistream) }
            if ( $PSBoundParameters.ContainsKey('clientusbdriveredirection') ) { $payload.Add('clientusbdriveredirection', $clientusbdriveredirection) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Ica configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type icaaccessprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get Ica configuration object(s).
    .DESCRIPTION
        Configuration for ica accessprofile resource.
    .PARAMETER Name 
        Name for the ICA accessprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA accessprofile is added. 
    .PARAMETER GetAll 
        Retrieve all icaaccessprofile object(s).
    .PARAMETER Count
        If specified, the count of the icaaccessprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcaaccessprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcaaccessprofile -GetAll 
        Get all icaaccessprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcaaccessprofile -Count 
        Get the number of icaaccessprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcaaccessprofile -name <string>
        Get icaaccessprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcaaccessprofile -Filter @{ 'name'='<value>' }
        Get icaaccessprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetIcaaccessprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaccessprofile/
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
        Write-Verbose "Invoke-ADCGetIcaaccessprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all icaaccessprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaccessprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icaaccessprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaccessprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icaaccessprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaccessprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icaaccessprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaccessprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icaaccessprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaccessprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Ica configuration Object.
    .DESCRIPTION
        Configuration for ica action resource.
    .PARAMETER Name 
        Name for the ICA action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA action is added. 
    .PARAMETER Accessprofilename 
        Name of the ica accessprofile to be associated with this action. 
    .PARAMETER Latencyprofilename 
        Name of the ica latencyprofile to be associated with this action. 
    .PARAMETER PassThru 
        Return details about the created icaaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddIcaaction -name <string>
        An example how to add icaaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddIcaaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaction/
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

        [string]$Accessprofilename,

        [string]$Latencyprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddIcaaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('accessprofilename') ) { $payload.Add('accessprofilename', $accessprofilename) }
            if ( $PSBoundParameters.ContainsKey('latencyprofilename') ) { $payload.Add('latencyprofilename', $latencyprofilename) }
            if ( $PSCmdlet.ShouldProcess("icaaction", "Add Ica configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type icaaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetIcaaction -Filter $payload)
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
        Delete Ica configuration Object.
    .DESCRIPTION
        Configuration for ica action resource.
    .PARAMETER Name 
        Name for the ICA action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA action is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteIcaaction -Name <string>
        An example how to delete icaaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteIcaaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaction/
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
        Write-Verbose "Invoke-ADCDeleteIcaaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Ica configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type icaaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update Ica configuration Object.
    .DESCRIPTION
        Configuration for ica action resource.
    .PARAMETER Name 
        Name for the ICA action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA action is added. 
    .PARAMETER Accessprofilename 
        Name of the ica accessprofile to be associated with this action. 
    .PARAMETER Latencyprofilename 
        Name of the ica latencyprofile to be associated with this action. 
    .PARAMETER PassThru 
        Return details about the created icaaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateIcaaction -name <string>
        An example how to update icaaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateIcaaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaction/
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

        [string]$Accessprofilename,

        [string]$Latencyprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateIcaaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('accessprofilename') ) { $payload.Add('accessprofilename', $accessprofilename) }
            if ( $PSBoundParameters.ContainsKey('latencyprofilename') ) { $payload.Add('latencyprofilename', $latencyprofilename) }
            if ( $PSCmdlet.ShouldProcess("icaaction", "Update Ica configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type icaaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetIcaaction -Filter $payload)
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
        Unset Ica configuration Object.
    .DESCRIPTION
        Configuration for ica action resource.
    .PARAMETER Name 
        Name for the ICA action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA action is added. 
    .PARAMETER Accessprofilename 
        Name of the ica accessprofile to be associated with this action. 
    .PARAMETER Latencyprofilename 
        Name of the ica latencyprofile to be associated with this action.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetIcaaction -name <string>
        An example how to unset icaaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetIcaaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaction
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

        [Boolean]$accessprofilename,

        [Boolean]$latencyprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetIcaaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('accessprofilename') ) { $payload.Add('accessprofilename', $accessprofilename) }
            if ( $PSBoundParameters.ContainsKey('latencyprofilename') ) { $payload.Add('latencyprofilename', $latencyprofilename) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Ica configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type icaaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Rename Ica configuration Object.
    .DESCRIPTION
        Configuration for ica action resource.
    .PARAMETER Name 
        Name for the ICA action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA action is added. 
    .PARAMETER Newname 
        New name for the ICA action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#),period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created icaaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameIcaaction -name <string> -newname <string>
        An example how to rename icaaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameIcaaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaction/
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

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameIcaaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("icaaction", "Rename Ica configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type icaaction -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetIcaaction -Filter $payload)
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
        Get Ica configuration object(s).
    .DESCRIPTION
        Configuration for ica action resource.
    .PARAMETER Name 
        Name for the ICA action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA action is added. 
    .PARAMETER GetAll 
        Retrieve all icaaction object(s).
    .PARAMETER Count
        If specified, the count of the icaaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcaaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcaaction -GetAll 
        Get all icaaction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcaaction -Count 
        Get the number of icaaction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcaaction -name <string>
        Get icaaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcaaction -Filter @{ 'name'='<value>' }
        Get icaaction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetIcaaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaaction/
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
        Write-Verbose "Invoke-ADCGetIcaaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all icaaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icaaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icaaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icaaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icaaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Ica configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to icaglobal.
    .PARAMETER GetAll 
        Retrieve all icaglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the icaglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcaglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcaglobalbinding -GetAll 
        Get all icaglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcaglobalbinding -name <string>
        Get icaglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcaglobalbinding -Filter @{ 'name'='<value>' }
        Get icaglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetIcaglobalbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaglobal_binding/
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
        Write-Verbose "Invoke-ADCGetIcaglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all icaglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icaglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icaglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icaglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving icaglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Ica configuration Object.
    .DESCRIPTION
        Binding object showing the icapolicy that can be bound to icaglobal.
    .PARAMETER Policyname 
        Name of the ICA policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Type 
        Global bind point for which to show detailed information about the policies bound to the bind point. 
        Possible values = ICA_REQ_OVERRIDE, ICA_REQ_DEFAULT 
    .PARAMETER PassThru 
        Return details about the created icaglobal_icapolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddIcaglobalicapolicybinding -policyname <string> -priority <double>
        An example how to add icaglobal_icapolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddIcaglobalicapolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaglobal_icapolicy_binding/
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
        [string]$Policyname,

        [Parameter(Mandatory)]
        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('ICA_REQ_OVERRIDE', 'ICA_REQ_DEFAULT')]
        [string]$Type,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddIcaglobalicapolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                priority             = $priority
            }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSCmdlet.ShouldProcess("icaglobal_icapolicy_binding", "Add Ica configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type icaglobal_icapolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetIcaglobalicapolicybinding -Filter $payload)
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
        Delete Ica configuration Object.
    .DESCRIPTION
        Binding object showing the icapolicy that can be bound to icaglobal.
    .PARAMETER Policyname 
        Name of the ICA policy. 
    .PARAMETER Type 
        Global bind point for which to show detailed information about the policies bound to the bind point. 
        Possible values = ICA_REQ_OVERRIDE, ICA_REQ_DEFAULT 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteIcaglobalicapolicybinding 
        An example how to delete icaglobal_icapolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteIcaglobalicapolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaglobal_icapolicy_binding/
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

        [string]$Policyname,

        [string]$Type,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteIcaglobalicapolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("icaglobal_icapolicy_binding", "Delete Ica configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type icaglobal_icapolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Get Ica configuration object(s).
    .DESCRIPTION
        Binding object showing the icapolicy that can be bound to icaglobal.
    .PARAMETER GetAll 
        Retrieve all icaglobal_icapolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the icaglobal_icapolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcaglobalicapolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcaglobalicapolicybinding -GetAll 
        Get all icaglobal_icapolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcaglobalicapolicybinding -Count 
        Get the number of icaglobal_icapolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcaglobalicapolicybinding -name <string>
        Get icaglobal_icapolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcaglobalicapolicybinding -Filter @{ 'name'='<value>' }
        Get icaglobal_icapolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetIcaglobalicapolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaglobal_icapolicy_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all icaglobal_icapolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaglobal_icapolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icaglobal_icapolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaglobal_icapolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icaglobal_icapolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaglobal_icapolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icaglobal_icapolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving icaglobal_icapolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaglobal_icapolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Ica configuration Object.
    .DESCRIPTION
        Configuration for Profile for Latency monitoring resource.
    .PARAMETER Name 
        Name for the ICA latencyprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA latency profile is added. 
    .PARAMETER L7latencymonitoring 
        Enable/Disable L7 Latency monitoring for L7 latency notifications. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER L7latencythresholdfactor 
        L7 Latency threshold factor. This is the factor by which the active latency should be greater than the minimum observed value to determine that the latency is high and may need to be reported. 
    .PARAMETER L7latencywaittime 
        L7 Latency Wait time. This is the time for which the Citrix ADC waits after the threshold is exceeded before it sends out a Notification to the Insight Center. 
    .PARAMETER L7latencynotifyinterval 
        L7 Latency Notify Interval. This is the interval at which the Citrix ADC sends out notifications to the Insight Center after the wait time has passed. 
    .PARAMETER L7latencymaxnotifycount 
        L7 Latency Max notify Count. This is the upper limit on the number of notifications sent to the Insight Center within an interval where the Latency is above the threshold. 
    .PARAMETER PassThru 
        Return details about the created icalatencyprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddIcalatencyprofile -name <string>
        An example how to add icalatencyprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddIcalatencyprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icalatencyprofile/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$L7latencymonitoring = 'DISABLED',

        [ValidateRange(2, 65535)]
        [double]$L7latencythresholdfactor = '4',

        [ValidateRange(1, 65535)]
        [double]$L7latencywaittime = '20',

        [ValidateRange(1, 65535)]
        [double]$L7latencynotifyinterval = '20',

        [ValidateRange(1, 65535)]
        [double]$L7latencymaxnotifycount = '5',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddIcalatencyprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('l7latencymonitoring') ) { $payload.Add('l7latencymonitoring', $l7latencymonitoring) }
            if ( $PSBoundParameters.ContainsKey('l7latencythresholdfactor') ) { $payload.Add('l7latencythresholdfactor', $l7latencythresholdfactor) }
            if ( $PSBoundParameters.ContainsKey('l7latencywaittime') ) { $payload.Add('l7latencywaittime', $l7latencywaittime) }
            if ( $PSBoundParameters.ContainsKey('l7latencynotifyinterval') ) { $payload.Add('l7latencynotifyinterval', $l7latencynotifyinterval) }
            if ( $PSBoundParameters.ContainsKey('l7latencymaxnotifycount') ) { $payload.Add('l7latencymaxnotifycount', $l7latencymaxnotifycount) }
            if ( $PSCmdlet.ShouldProcess("icalatencyprofile", "Add Ica configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type icalatencyprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetIcalatencyprofile -Filter $payload)
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
        Delete Ica configuration Object.
    .DESCRIPTION
        Configuration for Profile for Latency monitoring resource.
    .PARAMETER Name 
        Name for the ICA latencyprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA latency profile is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteIcalatencyprofile -Name <string>
        An example how to delete icalatencyprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteIcalatencyprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icalatencyprofile/
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
        Write-Verbose "Invoke-ADCDeleteIcalatencyprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Ica configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type icalatencyprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update Ica configuration Object.
    .DESCRIPTION
        Configuration for Profile for Latency monitoring resource.
    .PARAMETER Name 
        Name for the ICA latencyprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA latency profile is added. 
    .PARAMETER L7latencymonitoring 
        Enable/Disable L7 Latency monitoring for L7 latency notifications. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER L7latencythresholdfactor 
        L7 Latency threshold factor. This is the factor by which the active latency should be greater than the minimum observed value to determine that the latency is high and may need to be reported. 
    .PARAMETER L7latencywaittime 
        L7 Latency Wait time. This is the time for which the Citrix ADC waits after the threshold is exceeded before it sends out a Notification to the Insight Center. 
    .PARAMETER L7latencynotifyinterval 
        L7 Latency Notify Interval. This is the interval at which the Citrix ADC sends out notifications to the Insight Center after the wait time has passed. 
    .PARAMETER L7latencymaxnotifycount 
        L7 Latency Max notify Count. This is the upper limit on the number of notifications sent to the Insight Center within an interval where the Latency is above the threshold. 
    .PARAMETER PassThru 
        Return details about the created icalatencyprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateIcalatencyprofile -name <string>
        An example how to update icalatencyprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateIcalatencyprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icalatencyprofile/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$L7latencymonitoring,

        [ValidateRange(2, 65535)]
        [double]$L7latencythresholdfactor,

        [ValidateRange(1, 65535)]
        [double]$L7latencywaittime,

        [ValidateRange(1, 65535)]
        [double]$L7latencynotifyinterval,

        [ValidateRange(1, 65535)]
        [double]$L7latencymaxnotifycount,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateIcalatencyprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('l7latencymonitoring') ) { $payload.Add('l7latencymonitoring', $l7latencymonitoring) }
            if ( $PSBoundParameters.ContainsKey('l7latencythresholdfactor') ) { $payload.Add('l7latencythresholdfactor', $l7latencythresholdfactor) }
            if ( $PSBoundParameters.ContainsKey('l7latencywaittime') ) { $payload.Add('l7latencywaittime', $l7latencywaittime) }
            if ( $PSBoundParameters.ContainsKey('l7latencynotifyinterval') ) { $payload.Add('l7latencynotifyinterval', $l7latencynotifyinterval) }
            if ( $PSBoundParameters.ContainsKey('l7latencymaxnotifycount') ) { $payload.Add('l7latencymaxnotifycount', $l7latencymaxnotifycount) }
            if ( $PSCmdlet.ShouldProcess("icalatencyprofile", "Update Ica configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type icalatencyprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetIcalatencyprofile -Filter $payload)
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
        Unset Ica configuration Object.
    .DESCRIPTION
        Configuration for Profile for Latency monitoring resource.
    .PARAMETER Name 
        Name for the ICA latencyprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA latency profile is added. 
    .PARAMETER L7latencymonitoring 
        Enable/Disable L7 Latency monitoring for L7 latency notifications. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER L7latencythresholdfactor 
        L7 Latency threshold factor. This is the factor by which the active latency should be greater than the minimum observed value to determine that the latency is high and may need to be reported. 
    .PARAMETER L7latencywaittime 
        L7 Latency Wait time. This is the time for which the Citrix ADC waits after the threshold is exceeded before it sends out a Notification to the Insight Center. 
    .PARAMETER L7latencynotifyinterval 
        L7 Latency Notify Interval. This is the interval at which the Citrix ADC sends out notifications to the Insight Center after the wait time has passed. 
    .PARAMETER L7latencymaxnotifycount 
        L7 Latency Max notify Count. This is the upper limit on the number of notifications sent to the Insight Center within an interval where the Latency is above the threshold.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetIcalatencyprofile -name <string>
        An example how to unset icalatencyprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetIcalatencyprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icalatencyprofile
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

        [Boolean]$l7latencymonitoring,

        [Boolean]$l7latencythresholdfactor,

        [Boolean]$l7latencywaittime,

        [Boolean]$l7latencynotifyinterval,

        [Boolean]$l7latencymaxnotifycount 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetIcalatencyprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('l7latencymonitoring') ) { $payload.Add('l7latencymonitoring', $l7latencymonitoring) }
            if ( $PSBoundParameters.ContainsKey('l7latencythresholdfactor') ) { $payload.Add('l7latencythresholdfactor', $l7latencythresholdfactor) }
            if ( $PSBoundParameters.ContainsKey('l7latencywaittime') ) { $payload.Add('l7latencywaittime', $l7latencywaittime) }
            if ( $PSBoundParameters.ContainsKey('l7latencynotifyinterval') ) { $payload.Add('l7latencynotifyinterval', $l7latencynotifyinterval) }
            if ( $PSBoundParameters.ContainsKey('l7latencymaxnotifycount') ) { $payload.Add('l7latencymaxnotifycount', $l7latencymaxnotifycount) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Ica configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type icalatencyprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get Ica configuration object(s).
    .DESCRIPTION
        Configuration for Profile for Latency monitoring resource.
    .PARAMETER Name 
        Name for the ICA latencyprofile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and 
        the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the ICA latency profile is added. 
    .PARAMETER GetAll 
        Retrieve all icalatencyprofile object(s).
    .PARAMETER Count
        If specified, the count of the icalatencyprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcalatencyprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcalatencyprofile -GetAll 
        Get all icalatencyprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcalatencyprofile -Count 
        Get the number of icalatencyprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcalatencyprofile -name <string>
        Get icalatencyprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcalatencyprofile -Filter @{ 'name'='<value>' }
        Get icalatencyprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetIcalatencyprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icalatencyprofile/
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
        Write-Verbose "Invoke-ADCGetIcalatencyprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all icalatencyprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icalatencyprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icalatencyprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icalatencyprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icalatencyprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icalatencyprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icalatencyprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icalatencyprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icalatencyprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icalatencyprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Update Ica configuration Object.
    .DESCRIPTION
        Configuration for Config Parameters for NS ICA resource.
    .PARAMETER Enablesronhafailover 
        Enable/Disable Session Reliability on HA failover. The default value is No. 
        Possible values = YES, NO 
    .PARAMETER Hdxinsightnonnsap 
        Enable/Disable HDXInsight for Non NSAP ICA Sessions. The default value is Yes. 
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateIcaparameter 
        An example how to update icaparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateIcaparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaparameter/
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

        [ValidateSet('YES', 'NO')]
        [string]$Enablesronhafailover,

        [ValidateSet('YES', 'NO')]
        [string]$Hdxinsightnonnsap 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateIcaparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('enablesronhafailover') ) { $payload.Add('enablesronhafailover', $enablesronhafailover) }
            if ( $PSBoundParameters.ContainsKey('hdxinsightnonnsap') ) { $payload.Add('hdxinsightnonnsap', $hdxinsightnonnsap) }
            if ( $PSCmdlet.ShouldProcess("icaparameter", "Update Ica configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type icaparameter -Payload $payload -GetWarning
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
        Unset Ica configuration Object.
    .DESCRIPTION
        Configuration for Config Parameters for NS ICA resource.
    .PARAMETER Enablesronhafailover 
        Enable/Disable Session Reliability on HA failover. The default value is No. 
        Possible values = YES, NO 
    .PARAMETER Hdxinsightnonnsap 
        Enable/Disable HDXInsight for Non NSAP ICA Sessions. The default value is Yes. 
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetIcaparameter 
        An example how to unset icaparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetIcaparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaparameter
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

        [Boolean]$enablesronhafailover,

        [Boolean]$hdxinsightnonnsap 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetIcaparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('enablesronhafailover') ) { $payload.Add('enablesronhafailover', $enablesronhafailover) }
            if ( $PSBoundParameters.ContainsKey('hdxinsightnonnsap') ) { $payload.Add('hdxinsightnonnsap', $hdxinsightnonnsap) }
            if ( $PSCmdlet.ShouldProcess("icaparameter", "Unset Ica configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type icaparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get Ica configuration object(s).
    .DESCRIPTION
        Configuration for Config Parameters for NS ICA resource.
    .PARAMETER GetAll 
        Retrieve all icaparameter object(s).
    .PARAMETER Count
        If specified, the count of the icaparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcaparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcaparameter -GetAll 
        Get all icaparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcaparameter -name <string>
        Get icaparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcaparameter -Filter @{ 'name'='<value>' }
        Get icaparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetIcaparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icaparameter/
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
        Write-Verbose "Invoke-ADCGetIcaparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all icaparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icaparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icaparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icaparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving icaparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icaparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Ica configuration Object.
    .DESCRIPTION
        Configuration for ICA policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Rule 
        Expression or other value against which the traffic is evaluated. Must be a Boolean expression. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the ica action to be associated with this policy. 
    .PARAMETER Comment 
        Any type of information about this ICA policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created icapolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddIcapolicy -name <string> -rule <string> -action <string>
        An example how to add icapolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddIcapolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Rule,

        [Parameter(Mandatory)]
        [string]$Action,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddIcapolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("icapolicy", "Add Ica configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type icapolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetIcapolicy -Filter $payload)
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
        Delete Ica configuration Object.
    .DESCRIPTION
        Configuration for ICA policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteIcapolicy -Name <string>
        An example how to delete icapolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteIcapolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy/
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
        Write-Verbose "Invoke-ADCDeleteIcapolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Ica configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type icapolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update Ica configuration Object.
    .DESCRIPTION
        Configuration for ICA policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Rule 
        Expression or other value against which the traffic is evaluated. Must be a Boolean expression. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the ica action to be associated with this policy. 
    .PARAMETER Comment 
        Any type of information about this ICA policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created icapolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateIcapolicy -name <string>
        An example how to update icapolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateIcapolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [string]$Rule,

        [string]$Action,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateIcapolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("icapolicy", "Update Ica configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type icapolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetIcapolicy -Filter $payload)
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
        Unset Ica configuration Object.
    .DESCRIPTION
        Configuration for ICA policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Comment 
        Any type of information about this ICA policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetIcapolicy -name <string>
        An example how to unset icapolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetIcapolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy
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

        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Boolean]$comment,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetIcapolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Ica configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type icapolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Rename Ica configuration Object.
    .DESCRIPTION
        Configuration for ICA policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Newname 
        New name for the policy. Must begin with an ASCII alphabetic or underscore (_)character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), s 
        pace, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created icapolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameIcapolicy -name <string> -newname <string>
        An example how to rename icapolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameIcapolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameIcapolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("icapolicy", "Rename Ica configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type icapolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetIcapolicy -Filter $payload)
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
        Get Ica configuration object(s).
    .DESCRIPTION
        Configuration for ICA policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retrieve all icapolicy object(s).
    .PARAMETER Count
        If specified, the count of the icapolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcapolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcapolicy -GetAll 
        Get all icapolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcapolicy -Count 
        Get the number of icapolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcapolicy -name <string>
        Get icapolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcapolicy -Filter @{ 'name'='<value>' }
        Get icapolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetIcapolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
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
        Write-Verbose "Invoke-ADCGetIcapolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all icapolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icapolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icapolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icapolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icapolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Ica configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to icapolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all icapolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the icapolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcapolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcapolicybinding -GetAll 
        Get all icapolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcapolicybinding -name <string>
        Get icapolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcapolicybinding -Filter @{ 'name'='<value>' }
        Get icapolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetIcapolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy_binding/
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
        [string]$Name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetIcapolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all icapolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icapolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icapolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icapolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icapolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Ica configuration object(s).
    .DESCRIPTION
        Binding object showing the crvserver that can be bound to icapolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all icapolicy_crvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the icapolicy_crvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcapolicycrvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcapolicycrvserverbinding -GetAll 
        Get all icapolicy_crvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcapolicycrvserverbinding -Count 
        Get the number of icapolicy_crvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcapolicycrvserverbinding -name <string>
        Get icapolicy_crvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcapolicycrvserverbinding -Filter @{ 'name'='<value>' }
        Get icapolicy_crvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetIcapolicycrvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy_crvserver_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all icapolicy_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icapolicy_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icapolicy_crvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_crvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icapolicy_crvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_crvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icapolicy_crvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_crvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Ica configuration object(s).
    .DESCRIPTION
        Binding object showing the icaglobal that can be bound to icapolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all icapolicy_icaglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the icapolicy_icaglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcapolicyicaglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcapolicyicaglobalbinding -GetAll 
        Get all icapolicy_icaglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcapolicyicaglobalbinding -Count 
        Get the number of icapolicy_icaglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcapolicyicaglobalbinding -name <string>
        Get icapolicy_icaglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcapolicyicaglobalbinding -Filter @{ 'name'='<value>' }
        Get icapolicy_icaglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetIcapolicyicaglobalbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy_icaglobal_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all icapolicy_icaglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_icaglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icapolicy_icaglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_icaglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icapolicy_icaglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_icaglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icapolicy_icaglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_icaglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icapolicy_icaglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_icaglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Ica configuration object(s).
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to icapolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all icapolicy_vpnvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the icapolicy_vpnvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcapolicyvpnvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcapolicyvpnvserverbinding -GetAll 
        Get all icapolicy_vpnvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIcapolicyvpnvserverbinding -Count 
        Get the number of icapolicy_vpnvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcapolicyvpnvserverbinding -name <string>
        Get icapolicy_vpnvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIcapolicyvpnvserverbinding -Filter @{ 'name'='<value>' }
        Get icapolicy_vpnvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetIcapolicyvpnvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ica/icapolicy_vpnvserver_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all icapolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for icapolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving icapolicy_vpnvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving icapolicy_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving icapolicy_vpnvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type icapolicy_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

# SIG # Begin signature block
# MIIkrQYJKoZIhvcNAQcCoIIknjCCJJoCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCC77cefOlnrqepS
# npxMH1qqZ/KZl/yyKW9vyIGUHmS9jqCCHnAwggTzMIID26ADAgECAhAsJ03zZBC0
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
# LqPzW0sH3DJZ84enGm1YMIIG7DCCBNSgAwIBAgIQMA9vrN1mmHR8qUY2p3gtuTAN
# BgkqhkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJz
# ZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNU
# IE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBB
# dXRob3JpdHkwHhcNMTkwNTAyMDAwMDAwWhcNMzgwMTE4MjM1OTU5WjB9MQswCQYD
# VQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
# YWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJTAjBgNVBAMTHFNlY3Rp
# Z28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAw
# ggIKAoICAQDIGwGv2Sx+iJl9AZg/IJC9nIAhVJO5z6A+U++zWsB21hoEpc5Hg7Xr
# xMxJNMvzRWW5+adkFiYJ+9UyUnkuyWPCE5u2hj8BBZJmbyGr1XEQeYf0RirNxFrJ
# 29ddSU1yVg/cyeNTmDoqHvzOWEnTv/M5u7mkI0Ks0BXDf56iXNc48RaycNOjxN+z
# xXKsLgp3/A2UUrf8H5VzJD0BKLwPDU+zkQGObp0ndVXRFzs0IXuXAZSvf4DP0REK
# V4TJf1bgvUacgr6Unb+0ILBgfrhN9Q0/29DqhYyKVnHRLZRMyIw80xSinL0m/9NT
# IMdgaZtYClT0Bef9Maz5yIUXx7gpGaQpL0bj3duRX58/Nj4OMGcrRrc1r5a+2kxg
# zKi7nw0U1BjEMJh0giHPYla1IXMSHv2qyghYh3ekFesZVf/QOVQtJu5FGjpvzdeE
# 8NfwKMVPZIMC1Pvi3vG8Aij0bdonigbSlofe6GsO8Ft96XZpkyAcSpcsdxkrk5WY
# nJee647BeFbGRCXfBhKaBi2fA179g6JTZ8qx+o2hZMmIklnLqEbAyfKm/31X2xJ2
# +opBJNQb/HKlFKLUrUMcpEmLQTkUAx4p+hulIq6lw02C0I3aa7fb9xhAV3PwcaP7
# Sn1FNsH3jYL6uckNU4B9+rY5WDLvbxhQiddPnTO9GrWdod6VQXqngwIDAQABo4IB
# WjCCAVYwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYE
# FBqh+GEZIA/DQXdFKI7RNV8GEgRVMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8E
# CDAGAQH/AgEAMBMGA1UdJQQMMAoGCCsGAQUFBwMIMBEGA1UdIAQKMAgwBgYEVR0g
# ADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNF
# UlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEE
# ajBoMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRy
# dXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVz
# ZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggIBAG1UgaUzXRbhtVOBkXXfA3oy
# Cy0lhBGysNsqfSoF9bw7J/RaoLlJWZApbGHLtVDb4n35nwDvQMOt0+LkVvlYQc/x
# QuUQff+wdB+PxlwJ+TNe6qAcJlhc87QRD9XVw+K81Vh4v0h24URnbY+wQxAPjeT5
# OGK/EwHFhaNMxcyyUzCVpNb0llYIuM1cfwGWvnJSajtCN3wWeDmTk5SbsdyybUFt
# Z83Jb5A9f0VywRsj1sJVhGbks8VmBvbz1kteraMrQoohkv6ob1olcGKBc2NeoLvY
# 3NdK0z2vgwY4Eh0khy3k/ALWPncEvAQ2ted3y5wujSMYuaPCRx3wXdahc1cFaJqn
# yTdlHb7qvNhCg0MFpYumCf/RoZSmTqo9CfUFbLfSZFrYKiLCS53xOV5M3kg9mzSW
# mglfjv33sVKRzj+J9hyhtal1H3G/W0NdZT1QgW6r8NDT/LKzH7aZlib0PHmLXGTM
# ze4nmuWgwAxyh8FuTVrTHurwROYybxzrF06Uw3hlIDsPQaof6aFBnf6xuKBlKjTg
# 3qj5PObBMLvAoGMs/FwWAKjQxH/qEZ0eBsambTJdtDgJK0kHqv3sMNrxpy/Pt/36
# 0KOE2See+wFmd7lWEOEgbsausfm2usg1XTN2jvF8IAwqd661ogKGuinutFoAsYyr
# 4/kKyVRd1LlqdJ69SK6YMIIHBzCCBO+gAwIBAgIRAIx3oACP9NGwxj2fOkiDjWsw
# DQYJKoZIhvcNAQEMBQAwfTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
# TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBM
# aW1pdGVkMSUwIwYDVQQDExxTZWN0aWdvIFJTQSBUaW1lIFN0YW1waW5nIENBMB4X
# DTIwMTAyMzAwMDAwMFoXDTMyMDEyMjIzNTk1OVowgYQxCzAJBgNVBAYTAkdCMRsw
# GQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAW
# BgNVBAoTD1NlY3RpZ28gTGltaXRlZDEsMCoGA1UEAwwjU2VjdGlnbyBSU0EgVGlt
# ZSBTdGFtcGluZyBTaWduZXIgIzIwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIK
# AoICAQCRh0ssi8HxHqCe0wfGAcpSsL55eV0JZgYtLzV9u8D7J9pCalkbJUzq70DW
# mn4yyGqBfbRcPlYQgTU6IjaM+/ggKYesdNAbYrw/ZIcCX+/FgO8GHNxeTpOHuJre
# TAdOhcxwxQ177MPZ45fpyxnbVkVs7ksgbMk+bP3wm/Eo+JGZqvxawZqCIDq37+fW
# uCVJwjkbh4E5y8O3Os2fUAQfGpmkgAJNHQWoVdNtUoCD5m5IpV/BiVhgiu/xrM2H
# YxiOdMuEh0FpY4G89h+qfNfBQc6tq3aLIIDULZUHjcf1CxcemuXWmWlRx06mnSlv
# 53mTDTJjU67MximKIMFgxvICLMT5yCLf+SeCoYNRwrzJghohhLKXvNSvRByWgiKV
# KoVUrvH9Pkl0dPyOrj+lcvTDWgGqUKWLdpUbZuvv2t+ULtka60wnfUwF9/gjXcRX
# yCYFevyBI19UCTgqYtWqyt/tz1OrH/ZEnNWZWcVWZFv3jlIPZvyYP0QGE2Ru6eEV
# YFClsezPuOjJC77FhPfdCp3avClsPVbtv3hntlvIXhQcua+ELXei9zmVN29OfxzG
# PATWMcV+7z3oUX5xrSR0Gyzc+Xyq78J2SWhi1Yv1A9++fY4PNnVGW5N2xIPugr4s
# rjcS8bxWw+StQ8O3ZpZelDL6oPariVD6zqDzCIEa0USnzPe4MQIDAQABo4IBeDCC
# AXQwHwYDVR0jBBgwFoAUGqH4YRkgD8NBd0UojtE1XwYSBFUwHQYDVR0OBBYEFGl1
# N3u7nTVCTr9X05rbnwHRrt7QMA4GA1UdDwEB/wQEAwIGwDAMBgNVHRMBAf8EAjAA
# MBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMIMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQEC
# AQMIMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMEQGA1Ud
# HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQVRp
# bWVTdGFtcGluZ0NBLmNybDB0BggrBgEFBQcBAQRoMGYwPwYIKwYBBQUHMAKGM2h0
# dHA6Ly9jcnQuc2VjdGlnby5jb20vU2VjdGlnb1JTQVRpbWVTdGFtcGluZ0NBLmNy
# dDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wDQYJKoZIhvcN
# AQEMBQADggIBAEoDeJBCM+x7GoMJNjOYVbudQAYwa0Vq8ZQOGVD/WyVeO+E5xFu6
# 6ZWQNze93/tk7OWCt5XMV1VwS070qIfdIoWmV7u4ISfUoCoxlIoHIZ6Kvaca9QIV
# y0RQmYzsProDd6aCApDCLpOpviE0dWO54C0PzwE3y42i+rhamq6hep4TkxlVjwmQ
# Lt/qiBcW62nW4SW9RQiXgNdUIChPynuzs6XSALBgNGXE48XDpeS6hap6adt1pD55
# aJo2i0OuNtRhcjwOhWINoF5w22QvAcfBoccklKOyPG6yXqLQ+qjRuCUcFubA1X9o
# GsRlKTUqLYi86q501oLnwIi44U948FzKwEBcwp/VMhws2jysNvcGUpqjQDAXsCkW
# mcmqt4hJ9+gLJTO1P22vn18KVt8SscPuzpF36CAT6Vwkx+pEC0rmE4QcTesNtbiG
# oDCni6GftCzMwBYjyZHlQgNLgM7kTeYqAT7AXoWgJKEXQNXb2+eYEKTx6hkbgFT6
# R4nomIGpdcAO39BolHmhoJ6OtrdCZsvZ2WsvTdjePjIeIOTsnE1CjZ3HM5mCN0TU
# JikmQI54L7nu+i/x8Y/+ULh43RSW3hwOcLAqhWqxbGjpKuQQK24h/dN8nTfkKgbW
# w/HXaONPB3mBCBP+smRe6bE85tB4I7IJLOImYr87qZdRzMdEMoGyr8/fMYIFkzCC
# BY8CAQEwgZAwfDELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
# c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVk
# MSQwIgYDVQQDExtTZWN0aWdvIFJTQSBDb2RlIFNpZ25pbmcgQ0ECECwnTfNkELSL
# /bju5S9Y3lMwDQYJYIZIAWUDBAIBBQCggYQwGAYKKwYBBAGCNwIBDDEKMAigAoAA
# oQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4w
# DAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQxIgQg8OdYMRPGqM49NcRsqOYkhrgb
# 6ZUeOtlFYcCkJ0Lm0hUwDQYJKoZIhvcNAQEBBQAEggEAfETU+YBUE47BYeB1qa3J
# j+mddUXMI1IyiOKIJn6Mu43r52388BpiJ/OUa9jxeYtYGgSVBy+TEjsJ3ALQYox/
# DTWt35IQufWCuBNluArihapgYesDv9IsVJUeLUFUW3AMhpLTgxFQF0yB4ojvlNnd
# ZxeHzdSiKuxfrW9KVSoNx735NDgxzCAhOKe+79D/4Nhac0h6qLmomArEDCaxx9ts
# 9Y5q/zoiM9njBoOXFhPQwIxBPmSb1M2zPu35S9bMDweE5H6HSdPFo/0Sg5c6Iu47
# tjB4Y/ZPrGV580n/j/T04eKJCYAKytDzY9MvaCNoau+SjwGdyPoieO0m7U/Cl8Y2
# 3qGCA0wwggNIBgkqhkiG9w0BCQYxggM5MIIDNQIBATCBkjB9MQswCQYDVQQGEwJH
# QjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3Jk
# MRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNB
# IFRpbWUgU3RhbXBpbmcgQ0ECEQCMd6AAj/TRsMY9nzpIg41rMA0GCWCGSAFlAwQC
# AgUAoHkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
# MjIwMzMwMTkzMjU2WjA/BgkqhkiG9w0BCQQxMgQwCksJpqKQmWeiIcaoMz1aV03D
# t49HqBVu18eRWqSCFInjZOxbMlIcy9i8sSeG95SPMA0GCSqGSIb3DQEBAQUABIIC
# AF1/f+8YeP+VhxfPhbUAhgC6L/kzRpzHumLCk6qTJojre3+C9D/FMFAyJpDKusdB
# qoi2L28eITk1bLazJbU6WyxIJs2kopK/dmhFw1WlQXFZ5tKCbwAeJBk7Lw2m68kr
# Qfkogc9Vb3q6ZCPn4GuS2gA36ptzyr3f4vF8fIEjtnVfaHHhbJcVZUHU4Xw8GDTZ
# jOnrulH3cDFt2sqQpsCz1EVDcVYyjiwnQ/esu0V0V/n31uTr3F6j36ciaT+oVzbI
# zPTy3Ay1S9RGhom0M9tUlJAhF9P4wnDQUI5VTuoBhmRdrmbeHgir4PGRXsoJl091
# dVsjP9AwLlmVXOwa8l4NXoga3Nh90zBpQZcfUSBbGMlJ2sHCGivV0Z4Po/hMCpAM
# PCJ+Hgz1c4bJ5qHMt5ttqpQ2hfYPqwy+CSvo2Gj2f6ZvrPTrIJfdq4CmUvYSBLfJ
# zCCS2dNtayrKaKzZ7wjIKRYphCihq45KCCHxJNLx2zSV0VFyuJIxjtOqwo6DgYgx
# luka3y2LFOxIUzOxUfm9VaDUJn9WMzXGdeAs85+1Rhtw/hZ63dwlejW/mNHT8cTS
# jUcmNhafPgN+qN4MlXGSUe6iHia+2CZInfKV4rCKqXjR/51BzfGhtrEV3gUMuUrT
# VPLuYTq8RU6XNawUxDgzOHGzPQtnHpcQhu3SkgmLyrBQ
# SIG # End signature block
