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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
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
        Version   : v2210.2317
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

        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
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
        Version   : v2210.2317
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
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
        Version   : v2210.2317
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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


