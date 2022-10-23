function Invoke-ADCCreateSystembackup {
    <#
    .SYNOPSIS
        Create System configuration Object.
    .DESCRIPTION
        Configuration for Backup Data for ns backup and restore resource.
    .PARAMETER Filename 
        Name of the backup file(*.tgz) to be restored. 
    .PARAMETER Uselocaltimezone 
        This option will create backup file with local timezone timestamp. 
    .PARAMETER Level 
        Level of data to be backed up. 
        Possible values = basic, full 
    .PARAMETER Includekernel 
        Use this option to add kernel in the backup file. 
        Possible values = NO, YES 
    .PARAMETER Comment 
        Comment specified at the time of creation of the backup file(*.tgz).
    .EXAMPLE
        PS C:\>Invoke-ADCCreateSystembackup 
        An example how to create systembackup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCCreateSystembackup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systembackup/
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

        [string]$Filename,

        [boolean]$Uselocaltimezone,

        [ValidateSet('basic', 'full')]
        [string]$Level,

        [ValidateSet('NO', 'YES')]
        [string]$Includekernel,

        [string]$Comment 

    )
    begin {
        Write-Verbose "Invoke-ADCCreateSystembackup: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('filename') ) { $payload.Add('filename', $filename) }
            if ( $PSBoundParameters.ContainsKey('uselocaltimezone') ) { $payload.Add('uselocaltimezone', $uselocaltimezone) }
            if ( $PSBoundParameters.ContainsKey('level') ) { $payload.Add('level', $level) }
            if ( $PSBoundParameters.ContainsKey('includekernel') ) { $payload.Add('includekernel', $includekernel) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess($Name, "Create System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type systembackup -Action create -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCCreateSystembackup: Finished"
    }
}

function Invoke-ADCRestoreSystembackup {
    <#
    .SYNOPSIS
        Restore System configuration Object.
    .DESCRIPTION
        Configuration for Backup Data for ns backup and restore resource.
    .PARAMETER Filename 
        Name of the backup file(*.tgz) to be restored. 
    .PARAMETER Skipbackup 
        Use this option to skip taking backup during restore operation.
    .EXAMPLE
        PS C:\>Invoke-ADCRestoreSystembackup -filename <string>
        An example how to restore systembackup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRestoreSystembackup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systembackup/
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
        [string]$Filename,

        [boolean]$Skipbackup 

    )
    begin {
        Write-Verbose "Invoke-ADCRestoreSystembackup: Starting"
    }
    process {
        try {
            $payload = @{ filename = $filename }
            if ( $PSBoundParameters.ContainsKey('skipbackup') ) { $payload.Add('skipbackup', $skipbackup) }
            if ( $PSCmdlet.ShouldProcess($Name, "Restore System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type systembackup -Action restore -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCRestoreSystembackup: Finished"
    }
}

function Invoke-ADCAddSystembackup {
    <#
    .SYNOPSIS
        Add System configuration Object.
    .DESCRIPTION
        Configuration for Backup Data for ns backup and restore resource.
    .PARAMETER Filename 
        Name of the backup file(*.tgz) to be restored. 
    .PARAMETER PassThru 
        Return details about the created systembackup item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSystembackup -filename <string>
        An example how to add systembackup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSystembackup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systembackup/
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
        [string]$Filename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSystembackup: Starting"
    }
    process {
        try {
            $payload = @{ filename = $filename }

            if ( $PSCmdlet.ShouldProcess("systembackup", "Add System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type systembackup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystembackup -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddSystembackup: Finished"
    }
}

function Invoke-ADCDeleteSystembackup {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Configuration for Backup Data for ns backup and restore resource.
    .PARAMETER Filename 
        Name of the backup file(*.tgz) to be restored.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystembackup -Filename <string>
        An example how to delete systembackup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystembackup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systembackup/
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
        [string]$Filename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystembackup: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$filename", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systembackup -NitroPath nitro/v1/config -Resource $filename -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystembackup: Finished"
    }
}

function Invoke-ADCGetSystembackup {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for Backup Data for ns backup and restore resource.
    .PARAMETER Filename 
        Name of the backup file(*.tgz) to be restored. 
    .PARAMETER GetAll 
        Retrieve all systembackup object(s).
    .PARAMETER Count
        If specified, the count of the systembackup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystembackup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystembackup -GetAll 
        Get all systembackup data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystembackup -Count 
        Get the number of systembackup objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystembackup -name <string>
        Get systembackup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystembackup -Filter @{ 'name'='<value>' }
        Get systembackup data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystembackup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systembackup/
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
        [string]$Filename,

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
        Write-Verbose "Invoke-ADCGetSystembackup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systembackup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systembackup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systembackup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systembackup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systembackup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systembackup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systembackup configuration for property 'filename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systembackup -NitroPath nitro/v1/config -Resource $filename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systembackup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systembackup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystembackup: Ended"
    }
}

function Invoke-ADCAddSystemcmdpolicy {
    <#
    .SYNOPSIS
        Add System configuration Object.
    .DESCRIPTION
        Configuration for command policy resource.
    .PARAMETER Policyname 
        Name for a command policy. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the policy is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy'). 
    .PARAMETER Action 
        Action to perform when a request matches the policy. 
        Possible values = ALLOW, DENY 
    .PARAMETER Cmdspec 
        Regular expression specifying the data that matches the policy. 
    .PARAMETER PassThru 
        Return details about the created systemcmdpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSystemcmdpolicy -policyname <string> -action <string> -cmdspec <string>
        An example how to add systemcmdpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSystemcmdpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcmdpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Policyname,

        [Parameter(Mandatory)]
        [ValidateSet('ALLOW', 'DENY')]
        [string]$Action,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cmdspec,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemcmdpolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                action               = $action
                cmdspec              = $cmdspec
            }

            if ( $PSCmdlet.ShouldProcess("systemcmdpolicy", "Add System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type systemcmdpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystemcmdpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddSystemcmdpolicy: Finished"
    }
}

function Invoke-ADCDeleteSystemcmdpolicy {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Configuration for command policy resource.
    .PARAMETER Policyname 
        Name for a command policy. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the policy is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy').
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystemcmdpolicy -Policyname <string>
        An example how to delete systemcmdpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystemcmdpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcmdpolicy/
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
        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemcmdpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$policyname", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemcmdpolicy -NitroPath nitro/v1/config -Resource $policyname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystemcmdpolicy: Finished"
    }
}

function Invoke-ADCUpdateSystemcmdpolicy {
    <#
    .SYNOPSIS
        Update System configuration Object.
    .DESCRIPTION
        Configuration for command policy resource.
    .PARAMETER Policyname 
        Name for a command policy. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the policy is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy'). 
    .PARAMETER Action 
        Action to perform when a request matches the policy. 
        Possible values = ALLOW, DENY 
    .PARAMETER Cmdspec 
        Regular expression specifying the data that matches the policy. 
    .PARAMETER PassThru 
        Return details about the created systemcmdpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateSystemcmdpolicy -policyname <string> -action <string> -cmdspec <string>
        An example how to update systemcmdpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateSystemcmdpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcmdpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Policyname,

        [Parameter(Mandatory)]
        [ValidateSet('ALLOW', 'DENY')]
        [string]$Action,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cmdspec,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSystemcmdpolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                action               = $action
                cmdspec              = $cmdspec
            }

            if ( $PSCmdlet.ShouldProcess("systemcmdpolicy", "Update System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type systemcmdpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystemcmdpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateSystemcmdpolicy: Finished"
    }
}

function Invoke-ADCGetSystemcmdpolicy {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for command policy resource.
    .PARAMETER Policyname 
        Name for a command policy. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the policy is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy'). 
    .PARAMETER GetAll 
        Retrieve all systemcmdpolicy object(s).
    .PARAMETER Count
        If specified, the count of the systemcmdpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemcmdpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemcmdpolicy -GetAll 
        Get all systemcmdpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemcmdpolicy -Count 
        Get the number of systemcmdpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemcmdpolicy -name <string>
        Get systemcmdpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemcmdpolicy -Filter @{ 'name'='<value>' }
        Get systemcmdpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemcmdpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcmdpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Policyname,

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
        Write-Verbose "Invoke-ADCGetSystemcmdpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemcmdpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcmdpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemcmdpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcmdpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemcmdpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcmdpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemcmdpolicy configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcmdpolicy -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemcmdpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcmdpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemcmdpolicy: Ended"
    }
}

function Invoke-ADCUpdateSystemcollectionparam {
    <#
    .SYNOPSIS
        Update System configuration Object.
    .DESCRIPTION
        Configuration for collection parameter resource.
    .PARAMETER Communityname 
        SNMPv1 community name for authentication. 
    .PARAMETER Loglevel 
        specify the log level. Possible values CRITICAL,WARNING,INFO,DEBUG1,DEBUG2. 
    .PARAMETER Datapath 
        specify the data path to the database.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateSystemcollectionparam 
        An example how to update systemcollectionparam configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateSystemcollectionparam
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcollectionparam/
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

        [string]$Communityname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Loglevel,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Datapath 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSystemcollectionparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('communityname') ) { $payload.Add('communityname', $communityname) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('datapath') ) { $payload.Add('datapath', $datapath) }
            if ( $PSCmdlet.ShouldProcess("systemcollectionparam", "Update System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type systemcollectionparam -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateSystemcollectionparam: Finished"
    }
}

function Invoke-ADCUnsetSystemcollectionparam {
    <#
    .SYNOPSIS
        Unset System configuration Object.
    .DESCRIPTION
        Configuration for collection parameter resource.
    .PARAMETER Communityname 
        SNMPv1 community name for authentication. 
    .PARAMETER Loglevel 
        specify the log level. Possible values CRITICAL,WARNING,INFO,DEBUG1,DEBUG2. 
    .PARAMETER Datapath 
        specify the data path to the database.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetSystemcollectionparam 
        An example how to unset systemcollectionparam configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetSystemcollectionparam
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcollectionparam
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

        [Boolean]$communityname,

        [Boolean]$loglevel,

        [Boolean]$datapath 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSystemcollectionparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('communityname') ) { $payload.Add('communityname', $communityname) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('datapath') ) { $payload.Add('datapath', $datapath) }
            if ( $PSCmdlet.ShouldProcess("systemcollectionparam", "Unset System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemcollectionparam -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSystemcollectionparam: Finished"
    }
}

function Invoke-ADCGetSystemcollectionparam {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for collection parameter resource.
    .PARAMETER GetAll 
        Retrieve all systemcollectionparam object(s).
    .PARAMETER Count
        If specified, the count of the systemcollectionparam object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemcollectionparam
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemcollectionparam -GetAll 
        Get all systemcollectionparam data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemcollectionparam -name <string>
        Get systemcollectionparam object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemcollectionparam -Filter @{ 'name'='<value>' }
        Get systemcollectionparam data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemcollectionparam
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcollectionparam/
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
        Write-Verbose "Invoke-ADCGetSystemcollectionparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemcollectionparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcollectionparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemcollectionparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcollectionparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemcollectionparam objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcollectionparam -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemcollectionparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemcollectionparam configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcollectionparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemcollectionparam: Ended"
    }
}

function Invoke-ADCGetSystemcore {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for core resource.
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER GetAll 
        Retrieve all systemcore object(s).
    .PARAMETER Count
        If specified, the count of the systemcore object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemcore
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemcore -GetAll 
        Get all systemcore data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemcore -name <string>
        Get systemcore object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemcore -Filter @{ 'name'='<value>' }
        Get systemcore data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemcore
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcore/
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
        [string]$Datasource,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemcore: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemcore objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcore -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemcore objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcore -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemcore objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('datasource') ) { $arguments.Add('datasource', $datasource) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcore -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemcore configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemcore configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcore -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemcore: Ended"
    }
}

function Invoke-ADCGetSystemcountergroup {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for counter group resource.
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER GetAll 
        Retrieve all systemcountergroup object(s).
    .PARAMETER Count
        If specified, the count of the systemcountergroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemcountergroup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemcountergroup -GetAll 
        Get all systemcountergroup data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemcountergroup -name <string>
        Get systemcountergroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemcountergroup -Filter @{ 'name'='<value>' }
        Get systemcountergroup data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemcountergroup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcountergroup/
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
        [string]$Datasource,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemcountergroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemcountergroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcountergroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemcountergroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcountergroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemcountergroup objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('datasource') ) { $arguments.Add('datasource', $datasource) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcountergroup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemcountergroup configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemcountergroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcountergroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemcountergroup: Ended"
    }
}

function Invoke-ADCGetSystemcounters {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for counters resource.
    .PARAMETER Countergroup 
        Specify the (counter) group name which contains all the counters specific tot his particular group. 
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER GetAll 
        Retrieve all systemcounters object(s).
    .PARAMETER Count
        If specified, the count of the systemcounters object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemcounters
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemcounters -GetAll 
        Get all systemcounters data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemcounters -name <string>
        Get systemcounters object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemcounters -Filter @{ 'name'='<value>' }
        Get systemcounters data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemcounters
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcounters/
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
        [string]$Countergroup,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Datasource,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemcounters: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemcounters objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcounters -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemcounters objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcounters -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemcounters objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('countergroup') ) { $arguments.Add('countergroup', $countergroup) } 
                if ( $PSBoundParameters.ContainsKey('datasource') ) { $arguments.Add('datasource', $datasource) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcounters -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemcounters configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemcounters configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcounters -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemcounters: Ended"
    }
}

function Invoke-ADCGetSystemdatasource {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for historical datasource resource.
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER GetAll 
        Retrieve all systemdatasource object(s).
    .PARAMETER Count
        If specified, the count of the systemdatasource object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemdatasource
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemdatasource -GetAll 
        Get all systemdatasource data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemdatasource -name <string>
        Get systemdatasource object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemdatasource -Filter @{ 'name'='<value>' }
        Get systemdatasource data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemdatasource
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemdatasource/
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
        [string]$Datasource,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemdatasource: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemdatasource objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemdatasource -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemdatasource objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemdatasource -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemdatasource objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('datasource') ) { $arguments.Add('datasource', $datasource) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemdatasource -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemdatasource configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemdatasource configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemdatasource -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemdatasource: Ended"
    }
}

function Invoke-ADCGetSystementity {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for entity resource.
    .PARAMETER Type 
        Specify the entity type. 
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER Core 
        Specify core ID of the PE in nCore. 
    .PARAMETER GetAll 
        Retrieve all systementity object(s).
    .PARAMETER Count
        If specified, the count of the systementity object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystementity
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystementity -GetAll 
        Get all systementity data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystementity -name <string>
        Get systementity object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystementity -Filter @{ 'name'='<value>' }
        Get systementity data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystementity
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systementity/
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
        [string]$Type,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Datasource,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$Core,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystementity: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systementity objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementity -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systementity objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementity -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systementity objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) } 
                if ( $PSBoundParameters.ContainsKey('datasource') ) { $arguments.Add('datasource', $datasource) } 
                if ( $PSBoundParameters.ContainsKey('core') ) { $arguments.Add('core', $core) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementity -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systementity configuration for property ''"

            } else {
                Write-Verbose "Retrieving systementity configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementity -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystementity: Ended"
    }
}

function Invoke-ADCDeleteSystementitydata {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Configuration for entity data resource.
    .PARAMETER Type 
        Specify the entity type. 
    .PARAMETER Name 
        Specify the entity name. 
    .PARAMETER Alldeleted 
        Specify this if you would like to delete information about all deleted entities from the database. 
    .PARAMETER Allinactive 
        Specify this if you would like to delete information about all inactive entities from the database. 
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER Core 
        Specify core ID of the PE in nCore.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystementitydata 
        An example how to delete systementitydata configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystementitydata
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systementitydata/
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

        [string]$Type,

        [string]$Name,

        [boolean]$Alldeleted,

        [boolean]$Allinactive,

        [string]$Datasource,

        [int]$Core 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystementitydata: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Alldeleted') ) { $arguments.Add('alldeleted', $Alldeleted) }
            if ( $PSBoundParameters.ContainsKey('Allinactive') ) { $arguments.Add('allinactive', $Allinactive) }
            if ( $PSBoundParameters.ContainsKey('Datasource') ) { $arguments.Add('datasource', $Datasource) }
            if ( $PSBoundParameters.ContainsKey('Core') ) { $arguments.Add('core', $Core) }
            if ( $PSCmdlet.ShouldProcess("systementitydata", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systementitydata -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystementitydata: Finished"
    }
}

function Invoke-ADCGetSystementitydata {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for entity data resource.
    .PARAMETER Type 
        Specify the entity type. 
    .PARAMETER Name 
        Specify the entity name. 
    .PARAMETER Counters 
        Specify the counters to be collected. 
    .PARAMETER Starttime 
        Specify start time in mmddyyyyhhmm to start collecting values from that timestamp. 
    .PARAMETER Endtime 
        Specify end time in mmddyyyyhhmm upto which values have to be collected. 
    .PARAMETER Last 
        Last is literal way of saying a certain time period from the current moment. Example: -last 1 hour, -last 1 day, et cetera. 
    .PARAMETER Unit 
        Specify the time period from current moment. Example 1 x where x = hours/ days/ years. 
        Possible values = HOURS, DAYS, MONTHS 
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER Core 
        Specify core ID of the PE in nCore. 
    .PARAMETER GetAll 
        Retrieve all systementitydata object(s).
    .PARAMETER Count
        If specified, the count of the systementitydata object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystementitydata
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystementitydata -GetAll 
        Get all systementitydata data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystementitydata -name <string>
        Get systementitydata object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystementitydata -Filter @{ 'name'='<value>' }
        Get systementitydata data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystementitydata
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systementitydata/
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
        [string]$Type,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Name,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Counters,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Starttime,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Endtime,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$Last,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('HOURS', 'DAYS', 'MONTHS')]
        [string]$Unit,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Datasource,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$Core,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystementitydata: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systementitydata objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementitydata -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systementitydata objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementitydata -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systementitydata objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) } 
                if ( $PSBoundParameters.ContainsKey('name') ) { $arguments.Add('name', $name) } 
                if ( $PSBoundParameters.ContainsKey('counters') ) { $arguments.Add('counters', $counters) } 
                if ( $PSBoundParameters.ContainsKey('starttime') ) { $arguments.Add('starttime', $starttime) } 
                if ( $PSBoundParameters.ContainsKey('endtime') ) { $arguments.Add('endtime', $endtime) } 
                if ( $PSBoundParameters.ContainsKey('last') ) { $arguments.Add('last', $last) } 
                if ( $PSBoundParameters.ContainsKey('unit') ) { $arguments.Add('unit', $unit) } 
                if ( $PSBoundParameters.ContainsKey('datasource') ) { $arguments.Add('datasource', $datasource) } 
                if ( $PSBoundParameters.ContainsKey('core') ) { $arguments.Add('core', $core) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementitydata -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systementitydata configuration for property ''"

            } else {
                Write-Verbose "Retrieving systementitydata configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementitydata -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystementitydata: Ended"
    }
}

function Invoke-ADCGetSystementitytype {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for entity type resource.
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER GetAll 
        Retrieve all systementitytype object(s).
    .PARAMETER Count
        If specified, the count of the systementitytype object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystementitytype
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystementitytype -GetAll 
        Get all systementitytype data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystementitytype -name <string>
        Get systementitytype object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystementitytype -Filter @{ 'name'='<value>' }
        Get systementitytype data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystementitytype
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systementitytype/
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
        [string]$Datasource,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystementitytype: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systementitytype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementitytype -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systementitytype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementitytype -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systementitytype objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('datasource') ) { $arguments.Add('datasource', $datasource) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementitytype -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systementitytype configuration for property ''"

            } else {
                Write-Verbose "Retrieving systementitytype configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementitytype -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystementitytype: Ended"
    }
}

function Invoke-ADCGetSystemeventhistory {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for event history resource.
    .PARAMETER Starttime 
        Specify start time in mmddyyyyhhmm to start collecting values from that timestamp. 
    .PARAMETER Endtime 
        Specify end time in mmddyyyyhhmm upto which values have to be collected. 
    .PARAMETER Last 
        Last is literal way of saying a certain time period from the current moment. Example: -last 1 hour, -last 1 day, et cetera. 
    .PARAMETER Unit 
        Specify the time period from current moment. Example 1 x where x = hours/ days/ years. 
        Possible values = HOURS, DAYS, MONTHS 
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER GetAll 
        Retrieve all systemeventhistory object(s).
    .PARAMETER Count
        If specified, the count of the systemeventhistory object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemeventhistory
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemeventhistory -GetAll 
        Get all systemeventhistory data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemeventhistory -name <string>
        Get systemeventhistory object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemeventhistory -Filter @{ 'name'='<value>' }
        Get systemeventhistory data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemeventhistory
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemeventhistory/
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
        [string]$Starttime,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Endtime,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$Last,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('HOURS', 'DAYS', 'MONTHS')]
        [string]$Unit,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Datasource,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemeventhistory: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemeventhistory objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemeventhistory -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemeventhistory objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemeventhistory -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemeventhistory objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('starttime') ) { $arguments.Add('starttime', $starttime) } 
                if ( $PSBoundParameters.ContainsKey('endtime') ) { $arguments.Add('endtime', $endtime) } 
                if ( $PSBoundParameters.ContainsKey('last') ) { $arguments.Add('last', $last) } 
                if ( $PSBoundParameters.ContainsKey('unit') ) { $arguments.Add('unit', $unit) } 
                if ( $PSBoundParameters.ContainsKey('datasource') ) { $arguments.Add('datasource', $datasource) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemeventhistory -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemeventhistory configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemeventhistory configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemeventhistory -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemeventhistory: Ended"
    }
}

function Invoke-ADCEnableSystemextramgmtcpu {
    <#
    .SYNOPSIS
        Enable System configuration Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .EXAMPLE
        PS C:\>Invoke-ADCEnableSystemextramgmtcpu 
        An example how to enable systemextramgmtcpu configuration Object(s).
    .NOTES
        File Name : Invoke-ADCEnableSystemextramgmtcpu
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemextramgmtcpu/
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
        [Object]$ADCSession = (Get-ADCSession) 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableSystemextramgmtcpu: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type systemextramgmtcpu -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCEnableSystemextramgmtcpu: Finished"
    }
}

function Invoke-ADCDisableSystemextramgmtcpu {
    <#
    .SYNOPSIS
        Disable System configuration Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .EXAMPLE
        PS C:\>Invoke-ADCDisableSystemextramgmtcpu 
        An example how to disable systemextramgmtcpu configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDisableSystemextramgmtcpu
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemextramgmtcpu/
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
        [Object]$ADCSession = (Get-ADCSession) 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableSystemextramgmtcpu: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type systemextramgmtcpu -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCDisableSystemextramgmtcpu: Finished"
    }
}

function Invoke-ADCGetSystemextramgmtcpu {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retrieve all systemextramgmtcpu object(s).
    .PARAMETER Count
        If specified, the count of the systemextramgmtcpu object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemextramgmtcpu
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemextramgmtcpu -GetAll 
        Get all systemextramgmtcpu data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemextramgmtcpu -name <string>
        Get systemextramgmtcpu object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemextramgmtcpu -Filter @{ 'name'='<value>' }
        Get systemextramgmtcpu data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemextramgmtcpu
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemextramgmtcpu/
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
        [ValidateRange(0, 31)]
        [double]$Nodeid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemextramgmtcpu: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemextramgmtcpu objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemextramgmtcpu -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemextramgmtcpu objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemextramgmtcpu -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemextramgmtcpu objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemextramgmtcpu -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemextramgmtcpu configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemextramgmtcpu configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemextramgmtcpu -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemextramgmtcpu: Ended"
    }
}

function Invoke-ADCAddSystemfile {
    <#
    .SYNOPSIS
        Add System configuration Object.
    .DESCRIPTION
        Configuration for file resource.
    .PARAMETER Filename 
        Name of the file. It should not include filepath. 
    .PARAMETER Filecontent 
        file content in Base64 format. 
    .PARAMETER Filelocation 
        location of the file on Citrix ADC. 
    .PARAMETER Fileencoding 
        encoding type of the file content.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSystemfile -filename <string> -filecontent <string> -filelocation <string>
        An example how to add systemfile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSystemfile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemfile/
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
        [string]$Filename,

        [Parameter(Mandatory)]
        [string]$Filecontent,

        [Parameter(Mandatory)]
        [string]$Filelocation,

        [string]$Fileencoding = '"BASE64"' 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemfile: Starting"
    }
    process {
        try {
            $payload = @{ filename = $filename
                filecontent        = $filecontent
                filelocation       = $filelocation
            }
            if ( $PSBoundParameters.ContainsKey('fileencoding') ) { $payload.Add('fileencoding', $fileencoding) }
            if ( $PSCmdlet.ShouldProcess("systemfile", "Add System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type systemfile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddSystemfile: Finished"
    }
}

function Invoke-ADCDeleteSystemfile {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Configuration for file resource.
    .PARAMETER Filename 
        Name of the file. It should not include filepath. 
    .PARAMETER Filelocation 
        location of the file on Citrix ADC.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystemfile -Filename <string>
        An example how to delete systemfile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystemfile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemfile/
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
        [string]$Filename,

        [string]$Filelocation 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemfile: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Filelocation') ) { $arguments.Add('filelocation', $Filelocation) }
            if ( $PSCmdlet.ShouldProcess("$filename", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemfile -NitroPath nitro/v1/config -Resource $filename -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystemfile: Finished"
    }
}

function Invoke-ADCGetSystemfile {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for file resource.
    .PARAMETER Filename 
        Name of the file. It should not include filepath. 
    .PARAMETER Filelocation 
        location of the file on Citrix ADC. 
    .PARAMETER GetAll 
        Retrieve all systemfile object(s).
    .PARAMETER Count
        If specified, the count of the systemfile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemfile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemfile -GetAll 
        Get all systemfile data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemfile -name <string>
        Get systemfile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemfile -Filter @{ 'name'='<value>' }
        Get systemfile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemfile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemfile/
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
        [string]$Filename,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Filelocation,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemfile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemfile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemfile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemfile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemfile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemfile objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('filename') ) { $arguments.Add('filename', $filename) } 
                if ( $PSBoundParameters.ContainsKey('filelocation') ) { $arguments.Add('filelocation', $filelocation) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemfile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemfile configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemfile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemfile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemfile: Ended"
    }
}

function Invoke-ADCGetSystemglobaldata {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for global counter data resource.
    .PARAMETER Counters 
        Specify the counters to be collected. 
    .PARAMETER Countergroup 
        Specify the (counter) group name which contains all the counters specific to this particular group. 
    .PARAMETER Starttime 
        Specify start time in mmddyyyyhhmm to start collecting values from that timestamp. 
    .PARAMETER Endtime 
        Specify end time in mmddyyyyhhmm upto which values have to be collected. 
    .PARAMETER Last 
        Last is literal way of saying a certain time period from the current moment. Example: -last 1 hour, -last 1 day, et cetera. 
    .PARAMETER Unit 
        Specify the time period from current moment. Example 1 x where x = hours/ days/ years. 
        Possible values = HOURS, DAYS, MONTHS 
    .PARAMETER Datasource 
        Specifies the source which contains all the stored counter values. 
    .PARAMETER Core 
        Specify core ID of the PE in nCore. 
    .PARAMETER GetAll 
        Retrieve all systemglobaldata object(s).
    .PARAMETER Count
        If specified, the count of the systemglobaldata object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobaldata
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemglobaldata -GetAll 
        Get all systemglobaldata data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobaldata -name <string>
        Get systemglobaldata object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobaldata -Filter @{ 'name'='<value>' }
        Get systemglobaldata data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemglobaldata
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobaldata/
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
        [string]$Counters,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Countergroup,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Starttime,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Endtime,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$Last,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('HOURS', 'DAYS', 'MONTHS')]
        [string]$Unit,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Datasource,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$Core,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemglobaldata: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemglobaldata objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobaldata -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobaldata objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobaldata -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobaldata objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('counters') ) { $arguments.Add('counters', $counters) } 
                if ( $PSBoundParameters.ContainsKey('countergroup') ) { $arguments.Add('countergroup', $countergroup) } 
                if ( $PSBoundParameters.ContainsKey('starttime') ) { $arguments.Add('starttime', $starttime) } 
                if ( $PSBoundParameters.ContainsKey('endtime') ) { $arguments.Add('endtime', $endtime) } 
                if ( $PSBoundParameters.ContainsKey('last') ) { $arguments.Add('last', $last) } 
                if ( $PSBoundParameters.ContainsKey('unit') ) { $arguments.Add('unit', $unit) } 
                if ( $PSBoundParameters.ContainsKey('datasource') ) { $arguments.Add('datasource', $datasource) } 
                if ( $PSBoundParameters.ContainsKey('core') ) { $arguments.Add('core', $core) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobaldata -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobaldata configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobaldata configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobaldata -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemglobaldata: Ended"
    }
}

function Invoke-ADCAddSystemglobalauditnslogpolicybinding {
    <#
    .SYNOPSIS
        Add System configuration Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy. 
    .PARAMETER Priority 
        The priority of the command policy. 
    .PARAMETER Nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER Gotopriorityexpression 
        Applicable only to advance authentication policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_auditnslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSystemglobalauditnslogpolicybinding 
        An example how to add systemglobal_auditnslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSystemglobalauditnslogpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_auditnslogpolicy_binding/
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

        [double]$Priority,

        [string]$Nextfactor,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemglobalauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('nextfactor') ) { $payload.Add('nextfactor', $nextfactor) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_auditnslogpolicy_binding", "Add System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type systemglobal_auditnslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystemglobalauditnslogpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddSystemglobalauditnslogpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteSystemglobalauditnslogpolicybinding {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystemglobalauditnslogpolicybinding 
        An example how to delete systemglobal_auditnslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystemglobalauditnslogpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_auditnslogpolicy_binding/
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

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemglobalauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_auditnslogpolicy_binding", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystemglobalauditnslogpolicybinding: Finished"
    }
}

function Invoke-ADCGetSystemglobalauditnslogpolicybinding {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to systemglobal.
    .PARAMETER GetAll 
        Retrieve all systemglobal_auditnslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemglobal_auditnslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauditnslogpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemglobalauditnslogpolicybinding -GetAll 
        Get all systemglobal_auditnslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemglobalauditnslogpolicybinding -Count 
        Get the number of systemglobal_auditnslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauditnslogpolicybinding -name <string>
        Get systemglobal_auditnslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauditnslogpolicybinding -Filter @{ 'name'='<value>' }
        Get systemglobal_auditnslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemglobalauditnslogpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetSystemglobalauditnslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemglobal_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_auditnslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_auditnslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_auditnslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemglobalauditnslogpolicybinding: Ended"
    }
}

function Invoke-ADCAddSystemglobalauditsyslogpolicybinding {
    <#
    .SYNOPSIS
        Add System configuration Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy. 
    .PARAMETER Priority 
        The priority of the command policy. 
    .PARAMETER Nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER Gotopriorityexpression 
        Applicable only to advance authentication policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_auditsyslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSystemglobalauditsyslogpolicybinding 
        An example how to add systemglobal_auditsyslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSystemglobalauditsyslogpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_auditsyslogpolicy_binding/
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

        [double]$Priority,

        [string]$Nextfactor,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemglobalauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('nextfactor') ) { $payload.Add('nextfactor', $nextfactor) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_auditsyslogpolicy_binding", "Add System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type systemglobal_auditsyslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystemglobalauditsyslogpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddSystemglobalauditsyslogpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteSystemglobalauditsyslogpolicybinding {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystemglobalauditsyslogpolicybinding 
        An example how to delete systemglobal_auditsyslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystemglobalauditsyslogpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_auditsyslogpolicy_binding/
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

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemglobalauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_auditsyslogpolicy_binding", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystemglobalauditsyslogpolicybinding: Finished"
    }
}

function Invoke-ADCGetSystemglobalauditsyslogpolicybinding {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to systemglobal.
    .PARAMETER GetAll 
        Retrieve all systemglobal_auditsyslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemglobal_auditsyslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauditsyslogpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemglobalauditsyslogpolicybinding -GetAll 
        Get all systemglobal_auditsyslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemglobalauditsyslogpolicybinding -Count 
        Get the number of systemglobal_auditsyslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauditsyslogpolicybinding -name <string>
        Get systemglobal_auditsyslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauditsyslogpolicybinding -Filter @{ 'name'='<value>' }
        Get systemglobal_auditsyslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemglobalauditsyslogpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetSystemglobalauditsyslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_auditsyslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_auditsyslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemglobalauditsyslogpolicybinding: Ended"
    }
}

function Invoke-ADCAddSystemglobalauthenticationldappolicybinding {
    <#
    .SYNOPSIS
        Add System configuration Object.
    .DESCRIPTION
        Binding object showing the authenticationldappolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy. 
    .PARAMETER Priority 
        The priority of the command policy. 
    .PARAMETER Nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER Gotopriorityexpression 
        Applicable only to advance authentication policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_authenticationldappolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSystemglobalauthenticationldappolicybinding 
        An example how to add systemglobal_authenticationldappolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSystemglobalauthenticationldappolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationldappolicy_binding/
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

        [double]$Priority,

        [string]$Nextfactor,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemglobalauthenticationldappolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('nextfactor') ) { $payload.Add('nextfactor', $nextfactor) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationldappolicy_binding", "Add System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type systemglobal_authenticationldappolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystemglobalauthenticationldappolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddSystemglobalauthenticationldappolicybinding: Finished"
    }
}

function Invoke-ADCDeleteSystemglobalauthenticationldappolicybinding {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Binding object showing the authenticationldappolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystemglobalauthenticationldappolicybinding 
        An example how to delete systemglobal_authenticationldappolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystemglobalauthenticationldappolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationldappolicy_binding/
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

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemglobalauthenticationldappolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationldappolicy_binding", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemglobal_authenticationldappolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystemglobalauthenticationldappolicybinding: Finished"
    }
}

function Invoke-ADCGetSystemglobalauthenticationldappolicybinding {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Binding object showing the authenticationldappolicy that can be bound to systemglobal.
    .PARAMETER GetAll 
        Retrieve all systemglobal_authenticationldappolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemglobal_authenticationldappolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauthenticationldappolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemglobalauthenticationldappolicybinding -GetAll 
        Get all systemglobal_authenticationldappolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemglobalauthenticationldappolicybinding -Count 
        Get the number of systemglobal_authenticationldappolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauthenticationldappolicybinding -name <string>
        Get systemglobal_authenticationldappolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauthenticationldappolicybinding -Filter @{ 'name'='<value>' }
        Get systemglobal_authenticationldappolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemglobalauthenticationldappolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationldappolicy_binding/
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
        Write-Verbose "Invoke-ADCGetSystemglobalauthenticationldappolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemglobal_authenticationldappolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationldappolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_authenticationldappolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationldappolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_authenticationldappolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationldappolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_authenticationldappolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_authenticationldappolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationldappolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemglobalauthenticationldappolicybinding: Ended"
    }
}

function Invoke-ADCAddSystemglobalauthenticationlocalpolicybinding {
    <#
    .SYNOPSIS
        Add System configuration Object.
    .DESCRIPTION
        Binding object showing the authenticationlocalpolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy. 
    .PARAMETER Priority 
        The priority of the command policy. 
    .PARAMETER Nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER Gotopriorityexpression 
        Applicable only to advance authentication policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_authenticationlocalpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSystemglobalauthenticationlocalpolicybinding 
        An example how to add systemglobal_authenticationlocalpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSystemglobalauthenticationlocalpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationlocalpolicy_binding/
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

        [double]$Priority,

        [string]$Nextfactor,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemglobalauthenticationlocalpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('nextfactor') ) { $payload.Add('nextfactor', $nextfactor) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationlocalpolicy_binding", "Add System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type systemglobal_authenticationlocalpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystemglobalauthenticationlocalpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddSystemglobalauthenticationlocalpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteSystemglobalauthenticationlocalpolicybinding {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Binding object showing the authenticationlocalpolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystemglobalauthenticationlocalpolicybinding 
        An example how to delete systemglobal_authenticationlocalpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystemglobalauthenticationlocalpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationlocalpolicy_binding/
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

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemglobalauthenticationlocalpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationlocalpolicy_binding", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemglobal_authenticationlocalpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystemglobalauthenticationlocalpolicybinding: Finished"
    }
}

function Invoke-ADCGetSystemglobalauthenticationlocalpolicybinding {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Binding object showing the authenticationlocalpolicy that can be bound to systemglobal.
    .PARAMETER GetAll 
        Retrieve all systemglobal_authenticationlocalpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemglobal_authenticationlocalpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauthenticationlocalpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemglobalauthenticationlocalpolicybinding -GetAll 
        Get all systemglobal_authenticationlocalpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemglobalauthenticationlocalpolicybinding -Count 
        Get the number of systemglobal_authenticationlocalpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauthenticationlocalpolicybinding -name <string>
        Get systemglobal_authenticationlocalpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauthenticationlocalpolicybinding -Filter @{ 'name'='<value>' }
        Get systemglobal_authenticationlocalpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemglobalauthenticationlocalpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationlocalpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetSystemglobalauthenticationlocalpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemglobal_authenticationlocalpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationlocalpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_authenticationlocalpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationlocalpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_authenticationlocalpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationlocalpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_authenticationlocalpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_authenticationlocalpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationlocalpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemglobalauthenticationlocalpolicybinding: Ended"
    }
}

function Invoke-ADCAddSystemglobalauthenticationpolicybinding {
    <#
    .SYNOPSIS
        Add System configuration Object.
    .DESCRIPTION
        Binding object showing the authenticationpolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy. 
    .PARAMETER Priority 
        The priority of the command policy. 
    .PARAMETER Nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. Applicable only for advanced authentication policies. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_authenticationpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSystemglobalauthenticationpolicybinding 
        An example how to add systemglobal_authenticationpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSystemglobalauthenticationpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationpolicy_binding/
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

        [double]$Priority,

        [string]$Nextfactor,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemglobalauthenticationpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('nextfactor') ) { $payload.Add('nextfactor', $nextfactor) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationpolicy_binding", "Add System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type systemglobal_authenticationpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystemglobalauthenticationpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddSystemglobalauthenticationpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteSystemglobalauthenticationpolicybinding {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Binding object showing the authenticationpolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystemglobalauthenticationpolicybinding 
        An example how to delete systemglobal_authenticationpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystemglobalauthenticationpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationpolicy_binding/
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

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemglobalauthenticationpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationpolicy_binding", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemglobal_authenticationpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystemglobalauthenticationpolicybinding: Finished"
    }
}

function Invoke-ADCGetSystemglobalauthenticationpolicybinding {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Binding object showing the authenticationpolicy that can be bound to systemglobal.
    .PARAMETER GetAll 
        Retrieve all systemglobal_authenticationpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemglobal_authenticationpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauthenticationpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemglobalauthenticationpolicybinding -GetAll 
        Get all systemglobal_authenticationpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemglobalauthenticationpolicybinding -Count 
        Get the number of systemglobal_authenticationpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauthenticationpolicybinding -name <string>
        Get systemglobal_authenticationpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauthenticationpolicybinding -Filter @{ 'name'='<value>' }
        Get systemglobal_authenticationpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemglobalauthenticationpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetSystemglobalauthenticationpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemglobal_authenticationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_authenticationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_authenticationpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_authenticationpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_authenticationpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemglobalauthenticationpolicybinding: Ended"
    }
}

function Invoke-ADCAddSystemglobalauthenticationradiuspolicybinding {
    <#
    .SYNOPSIS
        Add System configuration Object.
    .DESCRIPTION
        Binding object showing the authenticationradiuspolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy. 
    .PARAMETER Priority 
        The priority of the command policy. 
    .PARAMETER Nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER Gotopriorityexpression 
        Applicable only to advance authentication policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_authenticationradiuspolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSystemglobalauthenticationradiuspolicybinding 
        An example how to add systemglobal_authenticationradiuspolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSystemglobalauthenticationradiuspolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationradiuspolicy_binding/
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

        [double]$Priority,

        [string]$Nextfactor,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemglobalauthenticationradiuspolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('nextfactor') ) { $payload.Add('nextfactor', $nextfactor) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationradiuspolicy_binding", "Add System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type systemglobal_authenticationradiuspolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystemglobalauthenticationradiuspolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddSystemglobalauthenticationradiuspolicybinding: Finished"
    }
}

function Invoke-ADCDeleteSystemglobalauthenticationradiuspolicybinding {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Binding object showing the authenticationradiuspolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystemglobalauthenticationradiuspolicybinding 
        An example how to delete systemglobal_authenticationradiuspolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystemglobalauthenticationradiuspolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationradiuspolicy_binding/
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

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemglobalauthenticationradiuspolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationradiuspolicy_binding", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemglobal_authenticationradiuspolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystemglobalauthenticationradiuspolicybinding: Finished"
    }
}

function Invoke-ADCGetSystemglobalauthenticationradiuspolicybinding {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Binding object showing the authenticationradiuspolicy that can be bound to systemglobal.
    .PARAMETER GetAll 
        Retrieve all systemglobal_authenticationradiuspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemglobal_authenticationradiuspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauthenticationradiuspolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemglobalauthenticationradiuspolicybinding -GetAll 
        Get all systemglobal_authenticationradiuspolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemglobalauthenticationradiuspolicybinding -Count 
        Get the number of systemglobal_authenticationradiuspolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauthenticationradiuspolicybinding -name <string>
        Get systemglobal_authenticationradiuspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauthenticationradiuspolicybinding -Filter @{ 'name'='<value>' }
        Get systemglobal_authenticationradiuspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemglobalauthenticationradiuspolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationradiuspolicy_binding/
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
        Write-Verbose "Invoke-ADCGetSystemglobalauthenticationradiuspolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemglobal_authenticationradiuspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationradiuspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_authenticationradiuspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationradiuspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_authenticationradiuspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationradiuspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_authenticationradiuspolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_authenticationradiuspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationradiuspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemglobalauthenticationradiuspolicybinding: Ended"
    }
}

function Invoke-ADCAddSystemglobalauthenticationtacacspolicybinding {
    <#
    .SYNOPSIS
        Add System configuration Object.
    .DESCRIPTION
        Binding object showing the authenticationtacacspolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy. 
    .PARAMETER Priority 
        The priority of the command policy. 
    .PARAMETER Nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER Gotopriorityexpression 
        Applicable only to advance authentication policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_authenticationtacacspolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSystemglobalauthenticationtacacspolicybinding 
        An example how to add systemglobal_authenticationtacacspolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSystemglobalauthenticationtacacspolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationtacacspolicy_binding/
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

        [double]$Priority,

        [string]$Nextfactor,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemglobalauthenticationtacacspolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('nextfactor') ) { $payload.Add('nextfactor', $nextfactor) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationtacacspolicy_binding", "Add System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type systemglobal_authenticationtacacspolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystemglobalauthenticationtacacspolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddSystemglobalauthenticationtacacspolicybinding: Finished"
    }
}

function Invoke-ADCDeleteSystemglobalauthenticationtacacspolicybinding {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Binding object showing the authenticationtacacspolicy that can be bound to systemglobal.
    .PARAMETER Policyname 
        The name of the command policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystemglobalauthenticationtacacspolicybinding 
        An example how to delete systemglobal_authenticationtacacspolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystemglobalauthenticationtacacspolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationtacacspolicy_binding/
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

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemglobalauthenticationtacacspolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("systemglobal_authenticationtacacspolicy_binding", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemglobal_authenticationtacacspolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystemglobalauthenticationtacacspolicybinding: Finished"
    }
}

function Invoke-ADCGetSystemglobalauthenticationtacacspolicybinding {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Binding object showing the authenticationtacacspolicy that can be bound to systemglobal.
    .PARAMETER GetAll 
        Retrieve all systemglobal_authenticationtacacspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemglobal_authenticationtacacspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauthenticationtacacspolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemglobalauthenticationtacacspolicybinding -GetAll 
        Get all systemglobal_authenticationtacacspolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemglobalauthenticationtacacspolicybinding -Count 
        Get the number of systemglobal_authenticationtacacspolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauthenticationtacacspolicybinding -name <string>
        Get systemglobal_authenticationtacacspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalauthenticationtacacspolicybinding -Filter @{ 'name'='<value>' }
        Get systemglobal_authenticationtacacspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemglobalauthenticationtacacspolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationtacacspolicy_binding/
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
        Write-Verbose "Invoke-ADCGetSystemglobalauthenticationtacacspolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemglobal_authenticationtacacspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationtacacspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_authenticationtacacspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationtacacspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_authenticationtacacspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationtacacspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_authenticationtacacspolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_authenticationtacacspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationtacacspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemglobalauthenticationtacacspolicybinding: Ended"
    }
}

function Invoke-ADCGetSystemglobalbinding {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to systemglobal.
    .PARAMETER GetAll 
        Retrieve all systemglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemglobalbinding -GetAll 
        Get all systemglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalbinding -name <string>
        Get systemglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemglobalbinding -Filter @{ 'name'='<value>' }
        Get systemglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemglobalbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_binding/
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
        Write-Verbose "Invoke-ADCGetSystemglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemglobalbinding: Ended"
    }
}

function Invoke-ADCAddSystemgroup {
    <#
    .SYNOPSIS
        Add System configuration Object.
    .DESCRIPTION
        Configuration for system group resource.
    .PARAMETER Groupname 
        Name for the group. Must begin with a letter, number, hash(#) or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the group is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group'). 
    .PARAMETER Promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables: 
        * %u - Will be replaced by the user name. 
        * %h - Will be replaced by the hostname of the Citrix ADC. 
        * %t - Will be replaced by the current time in 12-hour format. 
        * %T - Will be replaced by the current time in 24-hour format. 
        * %d - Will be replaced by the current date. 
        * %s - Will be replaced by the state of the Citrix ADC. 
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
    .PARAMETER Timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument of system parameter is enabled, Timeout can have values in the range [300-86400] seconds.If Restrictedtimeout argument of system parameter is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER Allowedmanagementinterface 
        Allowed Management interfaces of the system users in the group. By default allowed from both API and CLI interfaces. If management interface for a group is set to API, then all users under this group will not allowed to access NS through CLI. GUI interface will come under API interface. 
        Possible values = CLI, API 
    .PARAMETER PassThru 
        Return details about the created systemgroup item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSystemgroup -groupname <string>
        An example how to add systemgroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSystemgroup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Groupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Promptstring,

        [double]$Timeout,

        [ValidateSet('CLI', 'API')]
        [string[]]$Allowedmanagementinterface = 'NS_INTERFACE_ALL',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemgroup: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('promptstring') ) { $payload.Add('promptstring', $promptstring) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('allowedmanagementinterface') ) { $payload.Add('allowedmanagementinterface', $allowedmanagementinterface) }
            if ( $PSCmdlet.ShouldProcess("systemgroup", "Add System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type systemgroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystemgroup -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddSystemgroup: Finished"
    }
}

function Invoke-ADCDeleteSystemgroup {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Configuration for system group resource.
    .PARAMETER Groupname 
        Name for the group. Must begin with a letter, number, hash(#) or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the group is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group').
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystemgroup -Groupname <string>
        An example how to delete systemgroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystemgroup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup/
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
        [string]$Groupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemgroup: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemgroup -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystemgroup: Finished"
    }
}

function Invoke-ADCUpdateSystemgroup {
    <#
    .SYNOPSIS
        Update System configuration Object.
    .DESCRIPTION
        Configuration for system group resource.
    .PARAMETER Groupname 
        Name for the group. Must begin with a letter, number, hash(#) or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the group is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group'). 
    .PARAMETER Promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables: 
        * %u - Will be replaced by the user name. 
        * %h - Will be replaced by the hostname of the Citrix ADC. 
        * %t - Will be replaced by the current time in 12-hour format. 
        * %T - Will be replaced by the current time in 24-hour format. 
        * %d - Will be replaced by the current date. 
        * %s - Will be replaced by the state of the Citrix ADC. 
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
    .PARAMETER Timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument of system parameter is enabled, Timeout can have values in the range [300-86400] seconds.If Restrictedtimeout argument of system parameter is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER Allowedmanagementinterface 
        Allowed Management interfaces of the system users in the group. By default allowed from both API and CLI interfaces. If management interface for a group is set to API, then all users under this group will not allowed to access NS through CLI. GUI interface will come under API interface. 
        Possible values = CLI, API 
    .PARAMETER PassThru 
        Return details about the created systemgroup item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateSystemgroup -groupname <string>
        An example how to update systemgroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateSystemgroup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Groupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Promptstring,

        [double]$Timeout,

        [ValidateSet('CLI', 'API')]
        [string[]]$Allowedmanagementinterface,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSystemgroup: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('promptstring') ) { $payload.Add('promptstring', $promptstring) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('allowedmanagementinterface') ) { $payload.Add('allowedmanagementinterface', $allowedmanagementinterface) }
            if ( $PSCmdlet.ShouldProcess("systemgroup", "Update System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type systemgroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystemgroup -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateSystemgroup: Finished"
    }
}

function Invoke-ADCUnsetSystemgroup {
    <#
    .SYNOPSIS
        Unset System configuration Object.
    .DESCRIPTION
        Configuration for system group resource.
    .PARAMETER Groupname 
        Name for the group. Must begin with a letter, number, hash(#) or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the group is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group'). 
    .PARAMETER Promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables: 
        * %u - Will be replaced by the user name. 
        * %h - Will be replaced by the hostname of the Citrix ADC. 
        * %t - Will be replaced by the current time in 12-hour format. 
        * %T - Will be replaced by the current time in 24-hour format. 
        * %d - Will be replaced by the current date. 
        * %s - Will be replaced by the state of the Citrix ADC. 
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
    .PARAMETER Timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument of system parameter is enabled, Timeout can have values in the range [300-86400] seconds.If Restrictedtimeout argument of system parameter is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER Allowedmanagementinterface 
        Allowed Management interfaces of the system users in the group. By default allowed from both API and CLI interfaces. If management interface for a group is set to API, then all users under this group will not allowed to access NS through CLI. GUI interface will come under API interface. 
        Possible values = CLI, API
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetSystemgroup -groupname <string>
        An example how to unset systemgroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetSystemgroup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Groupname,

        [Boolean]$promptstring,

        [Boolean]$timeout,

        [Boolean]$allowedmanagementinterface 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSystemgroup: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('promptstring') ) { $payload.Add('promptstring', $promptstring) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('allowedmanagementinterface') ) { $payload.Add('allowedmanagementinterface', $allowedmanagementinterface) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Unset System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemgroup -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSystemgroup: Finished"
    }
}

function Invoke-ADCGetSystemgroup {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for system group resource.
    .PARAMETER Groupname 
        Name for the group. Must begin with a letter, number, hash(#) or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the group is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group'). 
    .PARAMETER GetAll 
        Retrieve all systemgroup object(s).
    .PARAMETER Count
        If specified, the count of the systemgroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemgroup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemgroup -GetAll 
        Get all systemgroup data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemgroup -Count 
        Get the number of systemgroup objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemgroup -name <string>
        Get systemgroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemgroup -Filter @{ 'name'='<value>' }
        Get systemgroup data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemgroup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Groupname,

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
        Write-Verbose "Invoke-ADCGetSystemgroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemgroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemgroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemgroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemgroup configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemgroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemgroup: Ended"
    }
}

function Invoke-ADCGetSystemgroupbinding {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group about which to display information. 
    .PARAMETER GetAll 
        Retrieve all systemgroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemgroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemgroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemgroupbinding -GetAll 
        Get all systemgroup_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemgroupbinding -name <string>
        Get systemgroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemgroupbinding -Filter @{ 'name'='<value>' }
        Get systemgroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemgroupbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_binding/
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
        [string]$Groupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemgroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemgroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemgroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemgroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemgroup_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemgroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemgroupbinding: Ended"
    }
}

function Invoke-ADCAddSystemgroupnspartitionbinding {
    <#
    .SYNOPSIS
        Add System configuration Object.
    .DESCRIPTION
        Binding object showing the nspartition that can be bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group. 
    .PARAMETER Partitionname 
        Name of the Partition to bind to the system group. 
    .PARAMETER PassThru 
        Return details about the created systemgroup_nspartition_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSystemgroupnspartitionbinding -groupname <string>
        An example how to add systemgroup_nspartition_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSystemgroupnspartitionbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_nspartition_binding/
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
        [string]$Groupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Partitionname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemgroupnspartitionbinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('partitionname') ) { $payload.Add('partitionname', $partitionname) }
            if ( $PSCmdlet.ShouldProcess("systemgroup_nspartition_binding", "Add System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type systemgroup_nspartition_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystemgroupnspartitionbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddSystemgroupnspartitionbinding: Finished"
    }
}

function Invoke-ADCDeleteSystemgroupnspartitionbinding {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Binding object showing the nspartition that can be bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group. 
    .PARAMETER Partitionname 
        Name of the Partition to bind to the system group.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystemgroupnspartitionbinding -Groupname <string>
        An example how to delete systemgroup_nspartition_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystemgroupnspartitionbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_nspartition_binding/
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
        [string]$Groupname,

        [string]$Partitionname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemgroupnspartitionbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Partitionname') ) { $arguments.Add('partitionname', $Partitionname) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemgroup_nspartition_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystemgroupnspartitionbinding: Finished"
    }
}

function Invoke-ADCGetSystemgroupnspartitionbinding {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Binding object showing the nspartition that can be bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group. 
    .PARAMETER GetAll 
        Retrieve all systemgroup_nspartition_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemgroup_nspartition_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemgroupnspartitionbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemgroupnspartitionbinding -GetAll 
        Get all systemgroup_nspartition_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemgroupnspartitionbinding -Count 
        Get the number of systemgroup_nspartition_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemgroupnspartitionbinding -name <string>
        Get systemgroup_nspartition_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemgroupnspartitionbinding -Filter @{ 'name'='<value>' }
        Get systemgroup_nspartition_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemgroupnspartitionbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_nspartition_binding/
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
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemgroupnspartitionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemgroup_nspartition_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_nspartition_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemgroup_nspartition_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_nspartition_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemgroup_nspartition_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_nspartition_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemgroup_nspartition_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_nspartition_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemgroup_nspartition_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_nspartition_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemgroupnspartitionbinding: Ended"
    }
}

function Invoke-ADCAddSystemgroupsystemcmdpolicybinding {
    <#
    .SYNOPSIS
        Add System configuration Object.
    .DESCRIPTION
        Binding object showing the systemcmdpolicy that can be bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group. 
    .PARAMETER Policyname 
        The name of command policy. 
    .PARAMETER Priority 
        The priority of the command policy. 
    .PARAMETER PassThru 
        Return details about the created systemgroup_systemcmdpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSystemgroupsystemcmdpolicybinding -groupname <string>
        An example how to add systemgroup_systemcmdpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSystemgroupsystemcmdpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_systemcmdpolicy_binding/
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
        [string]$Groupname,

        [string]$Policyname,

        [double]$Priority,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemgroupsystemcmdpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSCmdlet.ShouldProcess("systemgroup_systemcmdpolicy_binding", "Add System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type systemgroup_systemcmdpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystemgroupsystemcmdpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddSystemgroupsystemcmdpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteSystemgroupsystemcmdpolicybinding {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Binding object showing the systemcmdpolicy that can be bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group. 
    .PARAMETER Policyname 
        The name of command policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystemgroupsystemcmdpolicybinding -Groupname <string>
        An example how to delete systemgroup_systemcmdpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystemgroupsystemcmdpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_systemcmdpolicy_binding/
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
        [string]$Groupname,

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemgroupsystemcmdpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemgroup_systemcmdpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystemgroupsystemcmdpolicybinding: Finished"
    }
}

function Invoke-ADCGetSystemgroupsystemcmdpolicybinding {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Binding object showing the systemcmdpolicy that can be bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group. 
    .PARAMETER GetAll 
        Retrieve all systemgroup_systemcmdpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemgroup_systemcmdpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemgroupsystemcmdpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemgroupsystemcmdpolicybinding -GetAll 
        Get all systemgroup_systemcmdpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemgroupsystemcmdpolicybinding -Count 
        Get the number of systemgroup_systemcmdpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemgroupsystemcmdpolicybinding -name <string>
        Get systemgroup_systemcmdpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemgroupsystemcmdpolicybinding -Filter @{ 'name'='<value>' }
        Get systemgroup_systemcmdpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemgroupsystemcmdpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_systemcmdpolicy_binding/
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
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemgroupsystemcmdpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemgroup_systemcmdpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemcmdpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemgroup_systemcmdpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemcmdpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemgroup_systemcmdpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemcmdpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemgroup_systemcmdpolicy_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemcmdpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemgroup_systemcmdpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemcmdpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemgroupsystemcmdpolicybinding: Ended"
    }
}

function Invoke-ADCAddSystemgroupsystemuserbinding {
    <#
    .SYNOPSIS
        Add System configuration Object.
    .DESCRIPTION
        Binding object showing the systemuser that can be bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group. 
    .PARAMETER Username 
        The system user. 
    .PARAMETER PassThru 
        Return details about the created systemgroup_systemuser_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSystemgroupsystemuserbinding -groupname <string>
        An example how to add systemgroup_systemuser_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSystemgroupsystemuserbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_systemuser_binding/
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
        [string]$Groupname,

        [string]$Username,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemgroupsystemuserbinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('username') ) { $payload.Add('username', $username) }
            if ( $PSCmdlet.ShouldProcess("systemgroup_systemuser_binding", "Add System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type systemgroup_systemuser_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystemgroupsystemuserbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddSystemgroupsystemuserbinding: Finished"
    }
}

function Invoke-ADCDeleteSystemgroupsystemuserbinding {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Binding object showing the systemuser that can be bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group. 
    .PARAMETER Username 
        The system user.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystemgroupsystemuserbinding -Groupname <string>
        An example how to delete systemgroup_systemuser_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystemgroupsystemuserbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_systemuser_binding/
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
        [string]$Groupname,

        [string]$Username 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemgroupsystemuserbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Username') ) { $arguments.Add('username', $Username) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemgroup_systemuser_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystemgroupsystemuserbinding: Finished"
    }
}

function Invoke-ADCGetSystemgroupsystemuserbinding {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Binding object showing the systemuser that can be bound to systemgroup.
    .PARAMETER Groupname 
        Name of the system group. 
    .PARAMETER GetAll 
        Retrieve all systemgroup_systemuser_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemgroup_systemuser_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemgroupsystemuserbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemgroupsystemuserbinding -GetAll 
        Get all systemgroup_systemuser_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemgroupsystemuserbinding -Count 
        Get the number of systemgroup_systemuser_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemgroupsystemuserbinding -name <string>
        Get systemgroup_systemuser_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemgroupsystemuserbinding -Filter @{ 'name'='<value>' }
        Get systemgroup_systemuser_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemgroupsystemuserbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_systemuser_binding/
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
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemgroupsystemuserbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemgroup_systemuser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemuser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemgroup_systemuser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemuser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemgroup_systemuser_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemuser_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemgroup_systemuser_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemuser_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemgroup_systemuser_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemuser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemgroupsystemuserbinding: Ended"
    }
}

function Invoke-ADCCheckSystemhwerror {
    <#
    .SYNOPSIS
        Check System configuration Object.
    .DESCRIPTION
        Configuration for Hardware errors resource.
    .PARAMETER Diskcheck 
        Perform only disk error checking.
    .EXAMPLE
        PS C:\>Invoke-ADCCheckSystemhwerror -diskcheck <boolean>
        An example how to check systemhwerror configuration Object(s).
    .NOTES
        File Name : Invoke-ADCCheckSystemhwerror
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemhwerror/
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
        [boolean]$Diskcheck 

    )
    begin {
        Write-Verbose "Invoke-ADCCheckSystemhwerror: Starting"
    }
    process {
        try {
            $payload = @{ diskcheck = $diskcheck }

            if ( $PSCmdlet.ShouldProcess($Name, "Check System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type systemhwerror -Action check -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCCheckSystemhwerror: Finished"
    }
}

function Invoke-ADCCreateSystemkek {
    <#
    .SYNOPSIS
        Create System configuration Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Passphrase 
        Passphrase required to generate the key encryption key.
    .EXAMPLE
        PS C:\>Invoke-ADCCreateSystemkek -passphrase <string>
        An example how to create systemkek configuration Object(s).
    .NOTES
        File Name : Invoke-ADCCreateSystemkek
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemkek.md/
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
        [ValidateLength(8, 32)]
        [string]$Passphrase 

    )
    begin {
        Write-Verbose "Invoke-ADCCreateSystemkek: Starting"
    }
    process {
        try {
            $payload = @{ passphrase = $passphrase }

            if ( $PSCmdlet.ShouldProcess($Name, "Create System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type systemkek -Action create -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCCreateSystemkek: Finished"
    }
}

function Invoke-ADCExportSystemkek {
    <#
    .SYNOPSIS
        Export System configuration Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Password 
        Password required to import the key encryption key.
    .EXAMPLE
        PS C:\>Invoke-ADCExportSystemkek 
        An example how to export systemkek configuration Object(s).
    .NOTES
        File Name : Invoke-ADCExportSystemkek
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemkek.md/
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

        [ValidateLength(8, 32)]
        [string]$Password 

    )
    begin {
        Write-Verbose "Invoke-ADCExportSystemkek: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('password') ) { $payload.Add('password', $password) }
            if ( $PSCmdlet.ShouldProcess($Name, "Export System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type systemkek -Action export -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCExportSystemkek: Finished"
    }
}

function Invoke-ADCImportSystemkek {
    <#
    .SYNOPSIS
        Import System configuration Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Password 
        Password required to import the key encryption key.
    .EXAMPLE
        PS C:\>Invoke-ADCImportSystemkek 
        An example how to import systemkek configuration Object(s).
    .NOTES
        File Name : Invoke-ADCImportSystemkek
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemkek.md/
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

        [ValidateLength(8, 32)]
        [string]$Password 

    )
    begin {
        Write-Verbose "Invoke-ADCImportSystemkek: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('password') ) { $payload.Add('password', $password) }
            if ( $PSCmdlet.ShouldProcess($Name, "Import System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type systemkek -Action import -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportSystemkek: Finished"
    }
}

function Invoke-ADCUpdateSystemparameter {
    <#
    .SYNOPSIS
        Update System configuration Object.
    .DESCRIPTION
        Configuration for system parameter resource.
    .PARAMETER Rbaonresponse 
        Enable or disable Role-Based Authentication (RBA) on responses. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables: 
        * %u - Will be replaced by the user name. 
        * %h - Will be replaced by the hostname of the Citrix ADC. 
        * %t - Will be replaced by the current time in 12-hour format. 
        * %T - Will be replaced by the current time in 24-hour format. 
        * %d - Will be replaced by the current date. 
        * %s - Will be replaced by the state of the Citrix ADC. 
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
    .PARAMETER Natpcbforceflushlimit 
        Flush the system if the number of Network Address Translation Protocol Control Blocks (NATPCBs) exceeds this value. 
    .PARAMETER Natpcbrstontimeout 
        Send a reset signal to client and server connections when their NATPCBs time out. Avoids the buildup of idle TCP connections on both the sides. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument is enabled, Timeout can have values in the range [300-86400] seconds. 
        If Restrictedtimeout argument is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER Localauth 
        When enabled, local users can access Citrix ADC even when external authentication is configured. When disabled, local users are not allowed to access the Citrix ADC, Local users can access the Citrix ADC only when the configured external authentication servers are unavailable. This parameter is not applicable to SSH Key-based authentication. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Minpasswordlen 
        Minimum length of system user password. When strong password is enabled default minimum length is 4. User entered value can be greater than or equal to 4. Default mininum value is 1 when strong password is disabled. Maximum value is 127 in both cases. 
    .PARAMETER Strongpassword 
        After enabling strong password (enableall / enablelocal - not included in exclude list), all the passwords / sensitive information must have - Atleast 1 Lower case character, Atleast 1 Upper case character, Atleast 1 numeric character, Atleast 1 special character ( ~, `, !, @, #, $, %, ^, ;, *, -, _, =, +, {, }, [, ], |, \, :, <, >, /, .,,, " "). Exclude list in case of enablelocal is - NS_FIPS, NS_CRL, NS_RSAKEY, NS_PKCS12, NS_PKCS8, NS_LDAP, NS_TACACS, NS_TACACSACTION, NS_RADIUS, NS_RADIUSACTION, NS_ENCRYPTION_PARAMS. So no Strong Password checks will be performed on these ObjectType commands for enablelocal case. 
        Possible values = enableall, enablelocal, disabled 
    .PARAMETER Restrictedtimeout 
        Enable/Disable the restricted timeout behaviour. When enabled, timeout cannot be configured beyond admin configured timeout and also it will have the [minimum - maximum] range check. When disabled, timeout will have the old behaviour. By default the value is disabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Fipsusermode 
        Use this option to set the FIPS mode for key user-land processes. When enabled, these user-land processes will operate in FIPS mode. In this mode, these processes will use FIPS 140-2 certified crypto algorithms. 
        With a FIPS license, it is enabled by default and cannot be disabled. 
        Without a FIPS license, it is disabled by default, wherein these user-land processes will not operate in FIPS mode. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Doppler 
        Enable or disable Doppler. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Googleanalytics 
        Enable or disable Google analytics. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Totalauthtimeout 
        Total time a request can take for authentication/authorization. 
    .PARAMETER Cliloglevel 
        Audit log level, which specifies the types of events to log for cli executed commands. 
        Available values function as follows: 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        Possible values = EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
    .PARAMETER Forcepasswordchange 
        Enable or disable force password change for nsroot user. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Basicauth 
        Enable or disable basic authentication for Nitro API. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Reauthonauthparamchange 
        Enable or disable External user reauthentication when authentication parameter changes. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Removesensitivefiles 
        Use this option to remove the sensitive files from the system like authorise keys, public keys etc. The commands which will remove sensitive files when this system paramter is enabled are rm cluster instance, rm cluster node, rm ha node, clear config full, join cluster and add cluster instance. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateSystemparameter 
        An example how to update systemparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateSystemparameter
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemparameter/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Rbaonresponse,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Promptstring,

        [double]$Natpcbforceflushlimit,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Natpcbrstontimeout,

        [double]$Timeout,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Localauth,

        [ValidateRange(1, 127)]
        [double]$Minpasswordlen,

        [ValidateSet('enableall', 'enablelocal', 'disabled')]
        [string]$Strongpassword,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Restrictedtimeout,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Fipsusermode,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Doppler,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Googleanalytics,

        [ValidateRange(5, 120)]
        [double]$Totalauthtimeout,

        [ValidateSet('EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG')]
        [string]$Cliloglevel,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Forcepasswordchange,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Basicauth,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Reauthonauthparamchange,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Removesensitivefiles 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSystemparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('rbaonresponse') ) { $payload.Add('rbaonresponse', $rbaonresponse) }
            if ( $PSBoundParameters.ContainsKey('promptstring') ) { $payload.Add('promptstring', $promptstring) }
            if ( $PSBoundParameters.ContainsKey('natpcbforceflushlimit') ) { $payload.Add('natpcbforceflushlimit', $natpcbforceflushlimit) }
            if ( $PSBoundParameters.ContainsKey('natpcbrstontimeout') ) { $payload.Add('natpcbrstontimeout', $natpcbrstontimeout) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('localauth') ) { $payload.Add('localauth', $localauth) }
            if ( $PSBoundParameters.ContainsKey('minpasswordlen') ) { $payload.Add('minpasswordlen', $minpasswordlen) }
            if ( $PSBoundParameters.ContainsKey('strongpassword') ) { $payload.Add('strongpassword', $strongpassword) }
            if ( $PSBoundParameters.ContainsKey('restrictedtimeout') ) { $payload.Add('restrictedtimeout', $restrictedtimeout) }
            if ( $PSBoundParameters.ContainsKey('fipsusermode') ) { $payload.Add('fipsusermode', $fipsusermode) }
            if ( $PSBoundParameters.ContainsKey('doppler') ) { $payload.Add('doppler', $doppler) }
            if ( $PSBoundParameters.ContainsKey('googleanalytics') ) { $payload.Add('googleanalytics', $googleanalytics) }
            if ( $PSBoundParameters.ContainsKey('totalauthtimeout') ) { $payload.Add('totalauthtimeout', $totalauthtimeout) }
            if ( $PSBoundParameters.ContainsKey('cliloglevel') ) { $payload.Add('cliloglevel', $cliloglevel) }
            if ( $PSBoundParameters.ContainsKey('forcepasswordchange') ) { $payload.Add('forcepasswordchange', $forcepasswordchange) }
            if ( $PSBoundParameters.ContainsKey('basicauth') ) { $payload.Add('basicauth', $basicauth) }
            if ( $PSBoundParameters.ContainsKey('reauthonauthparamchange') ) { $payload.Add('reauthonauthparamchange', $reauthonauthparamchange) }
            if ( $PSBoundParameters.ContainsKey('removesensitivefiles') ) { $payload.Add('removesensitivefiles', $removesensitivefiles) }
            if ( $PSCmdlet.ShouldProcess("systemparameter", "Update System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type systemparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateSystemparameter: Finished"
    }
}

function Invoke-ADCUnsetSystemparameter {
    <#
    .SYNOPSIS
        Unset System configuration Object.
    .DESCRIPTION
        Configuration for system parameter resource.
    .PARAMETER Minpasswordlen 
        Minimum length of system user password. When strong password is enabled default minimum length is 4. User entered value can be greater than or equal to 4. Default mininum value is 1 when strong password is disabled. Maximum value is 127 in both cases. 
    .PARAMETER Rbaonresponse 
        Enable or disable Role-Based Authentication (RBA) on responses. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables: 
        * %u - Will be replaced by the user name. 
        * %h - Will be replaced by the hostname of the Citrix ADC. 
        * %t - Will be replaced by the current time in 12-hour format. 
        * %T - Will be replaced by the current time in 24-hour format. 
        * %d - Will be replaced by the current date. 
        * %s - Will be replaced by the state of the Citrix ADC. 
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
    .PARAMETER Natpcbforceflushlimit 
        Flush the system if the number of Network Address Translation Protocol Control Blocks (NATPCBs) exceeds this value. 
    .PARAMETER Natpcbrstontimeout 
        Send a reset signal to client and server connections when their NATPCBs time out. Avoids the buildup of idle TCP connections on both the sides. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument is enabled, Timeout can have values in the range [300-86400] seconds. 
        If Restrictedtimeout argument is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER Localauth 
        When enabled, local users can access Citrix ADC even when external authentication is configured. When disabled, local users are not allowed to access the Citrix ADC, Local users can access the Citrix ADC only when the configured external authentication servers are unavailable. This parameter is not applicable to SSH Key-based authentication. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Strongpassword 
        After enabling strong password (enableall / enablelocal - not included in exclude list), all the passwords / sensitive information must have - Atleast 1 Lower case character, Atleast 1 Upper case character, Atleast 1 numeric character, Atleast 1 special character ( ~, `, !, @, #, $, %, ^, ;, *, -, _, =, +, {, }, [, ], |, \, :, <, >, /, .,,, " "). Exclude list in case of enablelocal is - NS_FIPS, NS_CRL, NS_RSAKEY, NS_PKCS12, NS_PKCS8, NS_LDAP, NS_TACACS, NS_TACACSACTION, NS_RADIUS, NS_RADIUSACTION, NS_ENCRYPTION_PARAMS. So no Strong Password checks will be performed on these ObjectType commands for enablelocal case. 
        Possible values = enableall, enablelocal, disabled 
    .PARAMETER Restrictedtimeout 
        Enable/Disable the restricted timeout behaviour. When enabled, timeout cannot be configured beyond admin configured timeout and also it will have the [minimum - maximum] range check. When disabled, timeout will have the old behaviour. By default the value is disabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Fipsusermode 
        Use this option to set the FIPS mode for key user-land processes. When enabled, these user-land processes will operate in FIPS mode. In this mode, these processes will use FIPS 140-2 certified crypto algorithms. 
        With a FIPS license, it is enabled by default and cannot be disabled. 
        Without a FIPS license, it is disabled by default, wherein these user-land processes will not operate in FIPS mode. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Doppler 
        Enable or disable Doppler. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Googleanalytics 
        Enable or disable Google analytics. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Totalauthtimeout 
        Total time a request can take for authentication/authorization. 
    .PARAMETER Cliloglevel 
        Audit log level, which specifies the types of events to log for cli executed commands. 
        Available values function as follows: 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        Possible values = EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
    .PARAMETER Forcepasswordchange 
        Enable or disable force password change for nsroot user. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Basicauth 
        Enable or disable basic authentication for Nitro API. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Reauthonauthparamchange 
        Enable or disable External user reauthentication when authentication parameter changes. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Removesensitivefiles 
        Use this option to remove the sensitive files from the system like authorise keys, public keys etc. The commands which will remove sensitive files when this system paramter is enabled are rm cluster instance, rm cluster node, rm ha node, clear config full, join cluster and add cluster instance. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetSystemparameter 
        An example how to unset systemparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetSystemparameter
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemparameter
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

        [Boolean]$minpasswordlen,

        [Boolean]$rbaonresponse,

        [Boolean]$promptstring,

        [Boolean]$natpcbforceflushlimit,

        [Boolean]$natpcbrstontimeout,

        [Boolean]$timeout,

        [Boolean]$localauth,

        [Boolean]$strongpassword,

        [Boolean]$restrictedtimeout,

        [Boolean]$fipsusermode,

        [Boolean]$doppler,

        [Boolean]$googleanalytics,

        [Boolean]$totalauthtimeout,

        [Boolean]$cliloglevel,

        [Boolean]$forcepasswordchange,

        [Boolean]$basicauth,

        [Boolean]$reauthonauthparamchange,

        [Boolean]$removesensitivefiles 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSystemparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('minpasswordlen') ) { $payload.Add('minpasswordlen', $minpasswordlen) }
            if ( $PSBoundParameters.ContainsKey('rbaonresponse') ) { $payload.Add('rbaonresponse', $rbaonresponse) }
            if ( $PSBoundParameters.ContainsKey('promptstring') ) { $payload.Add('promptstring', $promptstring) }
            if ( $PSBoundParameters.ContainsKey('natpcbforceflushlimit') ) { $payload.Add('natpcbforceflushlimit', $natpcbforceflushlimit) }
            if ( $PSBoundParameters.ContainsKey('natpcbrstontimeout') ) { $payload.Add('natpcbrstontimeout', $natpcbrstontimeout) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('localauth') ) { $payload.Add('localauth', $localauth) }
            if ( $PSBoundParameters.ContainsKey('strongpassword') ) { $payload.Add('strongpassword', $strongpassword) }
            if ( $PSBoundParameters.ContainsKey('restrictedtimeout') ) { $payload.Add('restrictedtimeout', $restrictedtimeout) }
            if ( $PSBoundParameters.ContainsKey('fipsusermode') ) { $payload.Add('fipsusermode', $fipsusermode) }
            if ( $PSBoundParameters.ContainsKey('doppler') ) { $payload.Add('doppler', $doppler) }
            if ( $PSBoundParameters.ContainsKey('googleanalytics') ) { $payload.Add('googleanalytics', $googleanalytics) }
            if ( $PSBoundParameters.ContainsKey('totalauthtimeout') ) { $payload.Add('totalauthtimeout', $totalauthtimeout) }
            if ( $PSBoundParameters.ContainsKey('cliloglevel') ) { $payload.Add('cliloglevel', $cliloglevel) }
            if ( $PSBoundParameters.ContainsKey('forcepasswordchange') ) { $payload.Add('forcepasswordchange', $forcepasswordchange) }
            if ( $PSBoundParameters.ContainsKey('basicauth') ) { $payload.Add('basicauth', $basicauth) }
            if ( $PSBoundParameters.ContainsKey('reauthonauthparamchange') ) { $payload.Add('reauthonauthparamchange', $reauthonauthparamchange) }
            if ( $PSBoundParameters.ContainsKey('removesensitivefiles') ) { $payload.Add('removesensitivefiles', $removesensitivefiles) }
            if ( $PSCmdlet.ShouldProcess("systemparameter", "Unset System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSystemparameter: Finished"
    }
}

function Invoke-ADCGetSystemparameter {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for system parameter resource.
    .PARAMETER GetAll 
        Retrieve all systemparameter object(s).
    .PARAMETER Count
        If specified, the count of the systemparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemparameter -GetAll 
        Get all systemparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemparameter -name <string>
        Get systemparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemparameter -Filter @{ 'name'='<value>' }
        Get systemparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemparameter
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemparameter/
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
        Write-Verbose "Invoke-ADCGetSystemparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemparameter: Ended"
    }
}

function Invoke-ADCCreateSystemrestorepoint {
    <#
    .SYNOPSIS
        Create System configuration Object.
    .DESCRIPTION
        Configuration for Setting restorepoints for auto restore resource.
    .PARAMETER Filename 
        Name of the restore point.
    .EXAMPLE
        PS C:\>Invoke-ADCCreateSystemrestorepoint -filename <string>
        An example how to create systemrestorepoint configuration Object(s).
    .NOTES
        File Name : Invoke-ADCCreateSystemrestorepoint
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemrestorepoint/
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
        [ValidateLength(1, 63)]
        [string]$Filename 

    )
    begin {
        Write-Verbose "Invoke-ADCCreateSystemrestorepoint: Starting"
    }
    process {
        try {
            $payload = @{ filename = $filename }

            if ( $PSCmdlet.ShouldProcess($Name, "Create System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type systemrestorepoint -Action create -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCCreateSystemrestorepoint: Finished"
    }
}

function Invoke-ADCDeleteSystemrestorepoint {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Configuration for Setting restorepoints for auto restore resource.
    .PARAMETER Filename 
        Name of the restore point.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystemrestorepoint -Filename <string>
        An example how to delete systemrestorepoint configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystemrestorepoint
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemrestorepoint/
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
        [string]$Filename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemrestorepoint: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$filename", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemrestorepoint -NitroPath nitro/v1/config -Resource $filename -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystemrestorepoint: Finished"
    }
}

function Invoke-ADCGetSystemrestorepoint {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for Setting restorepoints for auto restore resource.
    .PARAMETER Filename 
        Name of the restore point. 
    .PARAMETER GetAll 
        Retrieve all systemrestorepoint object(s).
    .PARAMETER Count
        If specified, the count of the systemrestorepoint object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemrestorepoint
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemrestorepoint -GetAll 
        Get all systemrestorepoint data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemrestorepoint -Count 
        Get the number of systemrestorepoint objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemrestorepoint -name <string>
        Get systemrestorepoint object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemrestorepoint -Filter @{ 'name'='<value>' }
        Get systemrestorepoint data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemrestorepoint
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemrestorepoint/
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
        [ValidateLength(1, 63)]
        [string]$Filename,

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
        Write-Verbose "Invoke-ADCGetSystemrestorepoint: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemrestorepoint objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemrestorepoint -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemrestorepoint objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemrestorepoint -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemrestorepoint objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemrestorepoint -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemrestorepoint configuration for property 'filename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemrestorepoint -NitroPath nitro/v1/config -Resource $filename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemrestorepoint configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemrestorepoint -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemrestorepoint: Ended"
    }
}

function Invoke-ADCKillSystemsession {
    <#
    .SYNOPSIS
        Kill System configuration Object.
    .DESCRIPTION
        Configuration for system session resource.
    .PARAMETER Sid 
        ID of the system session about which to display information. 
    .PARAMETER All 
        Terminate all the system sessions except the current session.
    .EXAMPLE
        PS C:\>Invoke-ADCKillSystemsession 
        An example how to kill systemsession configuration Object(s).
    .NOTES
        File Name : Invoke-ADCKillSystemsession
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemsession/
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

        [double]$Sid,

        [boolean]$All 

    )
    begin {
        Write-Verbose "Invoke-ADCKillSystemsession: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('sid') ) { $payload.Add('sid', $sid) }
            if ( $PSBoundParameters.ContainsKey('all') ) { $payload.Add('all', $all) }
            if ( $PSCmdlet.ShouldProcess($Name, "Kill System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type systemsession -Action kill -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCKillSystemsession: Finished"
    }
}

function Invoke-ADCGetSystemsession {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for system session resource.
    .PARAMETER Sid 
        ID of the system session about which to display information. 
    .PARAMETER GetAll 
        Retrieve all systemsession object(s).
    .PARAMETER Count
        If specified, the count of the systemsession object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemsession
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemsession -GetAll 
        Get all systemsession data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemsession -Count 
        Get the number of systemsession objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemsession -name <string>
        Get systemsession object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemsession -Filter @{ 'name'='<value>' }
        Get systemsession data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemsession
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemsession/
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
        [double]$Sid,

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
        Write-Verbose "Invoke-ADCGetSystemsession: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemsession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemsession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemsession objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemsession -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemsession configuration for property 'sid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemsession -NitroPath nitro/v1/config -Resource $sid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemsession configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemsession -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemsession: Ended"
    }
}

function Invoke-ADCDeleteSystemsshkey {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Name 
        URL \(protocol, host, path, and file name\) from where the location file will be imported. 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER Sshkeytype 
        The type of the ssh key whether public or private key. 
        Possible values = PRIVATE, PUBLIC
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystemsshkey -Name <string>
        An example how to delete systemsshkey configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystemsshkey
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemsshkey/
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
        [string]$Name,

        [string]$Sshkeytype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemsshkey: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Sshkeytype') ) { $arguments.Add('sshkeytype', $Sshkeytype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemsshkey -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystemsshkey: Finished"
    }
}

function Invoke-ADCImportSystemsshkey {
    <#
    .SYNOPSIS
        Import System configuration Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Name 
        URL \(protocol, host, path, and file name\) from where the location file will be imported. 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER Src 
        URL \(protocol, host, path, and file name\) from where the location file will be imported. 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER Sshkeytype 
        The type of the ssh key whether public or private key. 
        Possible values = PRIVATE, PUBLIC
    .EXAMPLE
        PS C:\>Invoke-ADCImportSystemsshkey -name <string> -src <string> -sshkeytype <string>
        An example how to import systemsshkey configuration Object(s).
    .NOTES
        File Name : Invoke-ADCImportSystemsshkey
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemsshkey/
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
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateLength(1, 2047)]
        [string]$Src,

        [Parameter(Mandatory)]
        [ValidateSet('PRIVATE', 'PUBLIC')]
        [string]$Sshkeytype 

    )
    begin {
        Write-Verbose "Invoke-ADCImportSystemsshkey: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                src            = $src
                sshkeytype     = $sshkeytype
            }

            if ( $PSCmdlet.ShouldProcess($Name, "Import System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type systemsshkey -Action import -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportSystemsshkey: Finished"
    }
}

function Invoke-ADCGetSystemsshkey {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Sshkeytype 
        The type of the ssh key whether public or private key. 
        Possible values = PRIVATE, PUBLIC 
    .PARAMETER GetAll 
        Retrieve all systemsshkey object(s).
    .PARAMETER Count
        If specified, the count of the systemsshkey object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemsshkey
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemsshkey -GetAll 
        Get all systemsshkey data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemsshkey -name <string>
        Get systemsshkey object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemsshkey -Filter @{ 'name'='<value>' }
        Get systemsshkey data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemsshkey
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemsshkey/
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
        [ValidateSet('PRIVATE', 'PUBLIC')]
        [string]$Sshkeytype,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemsshkey: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemsshkey objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemsshkey -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemsshkey objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemsshkey -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemsshkey objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('sshkeytype') ) { $arguments.Add('sshkeytype', $sshkeytype) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemsshkey -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemsshkey configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemsshkey configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemsshkey -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemsshkey: Ended"
    }
}

function Invoke-ADCAddSystemuser {
    <#
    .SYNOPSIS
        Add System configuration Object.
    .DESCRIPTION
        Configuration for system user resource.
    .PARAMETER Username 
        Name for a user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my user" or 'my user'). 
    .PARAMETER Password 
        Password for the system user. Can include any ASCII character. 
    .PARAMETER Externalauth 
        Whether to use external authentication servers for the system user authentication or not. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables: 
        * %u - Will be replaced by the user name. 
        * %h - Will be replaced by the hostname of the Citrix ADC. 
        * %t - Will be replaced by the current time in 12-hour format. 
        * %T - Will be replaced by the current time in 24-hour format. 
        * %d - Will be replaced by the current date. 
        * %s - Will be replaced by the state of the Citrix ADC. 
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
    .PARAMETER Timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument of system parameter is enabled, Timeout can have values in the range [300-86400] seconds. If Restrictedtimeout argument of system parameter is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER Logging 
        Users logging privilege. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxsession 
        Maximum number of client connection allowed per user. 
    .PARAMETER Allowedmanagementinterface 
        Allowed Management interfaces to the system user. By default user is allowed from both API and CLI interfaces. If management interface for a user is set to API, then user is not allowed to access NS through CLI. GUI interface will come under API interface. 
        Possible values = CLI, API 
    .PARAMETER PassThru 
        Return details about the created systemuser item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSystemuser -username <string> -password <string>
        An example how to add systemuser configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSystemuser
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Username,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Externalauth = 'ENABLED',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Promptstring,

        [double]$Timeout,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logging = 'DISABLED',

        [ValidateRange(1, 40)]
        [double]$Maxsession = '20',

        [ValidateSet('CLI', 'API')]
        [string[]]$Allowedmanagementinterface = 'NS_INTERFACE_ALL',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemuser: Starting"
    }
    process {
        try {
            $payload = @{ username = $username
                password           = $password
            }
            if ( $PSBoundParameters.ContainsKey('externalauth') ) { $payload.Add('externalauth', $externalauth) }
            if ( $PSBoundParameters.ContainsKey('promptstring') ) { $payload.Add('promptstring', $promptstring) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('logging') ) { $payload.Add('logging', $logging) }
            if ( $PSBoundParameters.ContainsKey('maxsession') ) { $payload.Add('maxsession', $maxsession) }
            if ( $PSBoundParameters.ContainsKey('allowedmanagementinterface') ) { $payload.Add('allowedmanagementinterface', $allowedmanagementinterface) }
            if ( $PSCmdlet.ShouldProcess("systemuser", "Add System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type systemuser -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystemuser -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddSystemuser: Finished"
    }
}

function Invoke-ADCDeleteSystemuser {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Configuration for system user resource.
    .PARAMETER Username 
        Name for a user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my user" or 'my user').
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystemuser -Username <string>
        An example how to delete systemuser configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystemuser
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser/
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
        [string]$Username 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemuser: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$username", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemuser -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystemuser: Finished"
    }
}

function Invoke-ADCUpdateSystemuser {
    <#
    .SYNOPSIS
        Update System configuration Object.
    .DESCRIPTION
        Configuration for system user resource.
    .PARAMETER Username 
        Name for a user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my user" or 'my user'). 
    .PARAMETER Password 
        Password for the system user. Can include any ASCII character. 
    .PARAMETER Externalauth 
        Whether to use external authentication servers for the system user authentication or not. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables: 
        * %u - Will be replaced by the user name. 
        * %h - Will be replaced by the hostname of the Citrix ADC. 
        * %t - Will be replaced by the current time in 12-hour format. 
        * %T - Will be replaced by the current time in 24-hour format. 
        * %d - Will be replaced by the current date. 
        * %s - Will be replaced by the state of the Citrix ADC. 
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
    .PARAMETER Timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument of system parameter is enabled, Timeout can have values in the range [300-86400] seconds. If Restrictedtimeout argument of system parameter is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER Logging 
        Users logging privilege. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxsession 
        Maximum number of client connection allowed per user. 
    .PARAMETER Allowedmanagementinterface 
        Allowed Management interfaces to the system user. By default user is allowed from both API and CLI interfaces. If management interface for a user is set to API, then user is not allowed to access NS through CLI. GUI interface will come under API interface. 
        Possible values = CLI, API 
    .PARAMETER PassThru 
        Return details about the created systemuser item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateSystemuser -username <string>
        An example how to update systemuser configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateSystemuser
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Username,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Externalauth,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Promptstring,

        [double]$Timeout,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logging,

        [ValidateRange(1, 40)]
        [double]$Maxsession,

        [ValidateSet('CLI', 'API')]
        [string[]]$Allowedmanagementinterface,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSystemuser: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('password') ) { $payload.Add('password', $password) }
            if ( $PSBoundParameters.ContainsKey('externalauth') ) { $payload.Add('externalauth', $externalauth) }
            if ( $PSBoundParameters.ContainsKey('promptstring') ) { $payload.Add('promptstring', $promptstring) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('logging') ) { $payload.Add('logging', $logging) }
            if ( $PSBoundParameters.ContainsKey('maxsession') ) { $payload.Add('maxsession', $maxsession) }
            if ( $PSBoundParameters.ContainsKey('allowedmanagementinterface') ) { $payload.Add('allowedmanagementinterface', $allowedmanagementinterface) }
            if ( $PSCmdlet.ShouldProcess("systemuser", "Update System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type systemuser -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystemuser -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateSystemuser: Finished"
    }
}

function Invoke-ADCUnsetSystemuser {
    <#
    .SYNOPSIS
        Unset System configuration Object.
    .DESCRIPTION
        Configuration for system user resource.
    .PARAMETER Allowedmanagementinterface 
        Allowed Management interfaces to the system user. By default user is allowed from both API and CLI interfaces. If management interface for a user is set to API, then user is not allowed to access NS through CLI. GUI interface will come under API interface. 
        Possible values = CLI, API 
    .PARAMETER Username 
        Name for a user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my user" or 'my user'). 
    .PARAMETER Externalauth 
        Whether to use external authentication servers for the system user authentication or not. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables: 
        * %u - Will be replaced by the user name. 
        * %h - Will be replaced by the hostname of the Citrix ADC. 
        * %t - Will be replaced by the current time in 12-hour format. 
        * %T - Will be replaced by the current time in 24-hour format. 
        * %d - Will be replaced by the current date. 
        * %s - Will be replaced by the state of the Citrix ADC. 
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
    .PARAMETER Timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument of system parameter is enabled, Timeout can have values in the range [300-86400] seconds. If Restrictedtimeout argument of system parameter is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER Logging 
        Users logging privilege. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxsession 
        Maximum number of client connection allowed per user.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetSystemuser -username <string>
        An example how to unset systemuser configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetSystemuser
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser
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

        [Boolean]$allowedmanagementinterface,

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Username,

        [Boolean]$externalauth,

        [Boolean]$promptstring,

        [Boolean]$timeout,

        [Boolean]$logging,

        [Boolean]$maxsession 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSystemuser: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('allowedmanagementinterface') ) { $payload.Add('allowedmanagementinterface', $allowedmanagementinterface) }
            if ( $PSBoundParameters.ContainsKey('externalauth') ) { $payload.Add('externalauth', $externalauth) }
            if ( $PSBoundParameters.ContainsKey('promptstring') ) { $payload.Add('promptstring', $promptstring) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('logging') ) { $payload.Add('logging', $logging) }
            if ( $PSBoundParameters.ContainsKey('maxsession') ) { $payload.Add('maxsession', $maxsession) }
            if ( $PSCmdlet.ShouldProcess("$username", "Unset System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemuser -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSystemuser: Finished"
    }
}

function Invoke-ADCGetSystemuser {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Configuration for system user resource.
    .PARAMETER Username 
        Name for a user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my user" or 'my user'). 
    .PARAMETER GetAll 
        Retrieve all systemuser object(s).
    .PARAMETER Count
        If specified, the count of the systemuser object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemuser
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemuser -GetAll 
        Get all systemuser data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemuser -Count 
        Get the number of systemuser objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemuser -name <string>
        Get systemuser object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemuser -Filter @{ 'name'='<value>' }
        Get systemuser data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemuser
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Username,

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
        Write-Verbose "Invoke-ADCGetSystemuser: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all systemuser objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemuser objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemuser objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemuser configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemuser configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemuser: Ended"
    }
}

function Invoke-ADCGetSystemuserbinding {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to systemuser.
    .PARAMETER Username 
        Name of a system user about whom to display information. 
    .PARAMETER GetAll 
        Retrieve all systemuser_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemuser_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemuserbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemuserbinding -GetAll 
        Get all systemuser_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemuserbinding -name <string>
        Get systemuser_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemuserbinding -Filter @{ 'name'='<value>' }
        Get systemuser_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemuserbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser_binding/
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
        [string]$Username,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemuserbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemuser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemuser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemuser_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemuser_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemuser_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemuserbinding: Ended"
    }
}

function Invoke-ADCAddSystemusernspartitionbinding {
    <#
    .SYNOPSIS
        Add System configuration Object.
    .DESCRIPTION
        Binding object showing the nspartition that can be bound to systemuser.
    .PARAMETER Username 
        Name of the system-user entry to which to bind the command policy. 
    .PARAMETER Partitionname 
        Name of the Partition to bind to the system user. 
    .PARAMETER PassThru 
        Return details about the created systemuser_nspartition_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSystemusernspartitionbinding -username <string>
        An example how to add systemuser_nspartition_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSystemusernspartitionbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser_nspartition_binding/
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
        [string]$Username,

        [string]$Partitionname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemusernspartitionbinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('partitionname') ) { $payload.Add('partitionname', $partitionname) }
            if ( $PSCmdlet.ShouldProcess("systemuser_nspartition_binding", "Add System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type systemuser_nspartition_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystemusernspartitionbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddSystemusernspartitionbinding: Finished"
    }
}

function Invoke-ADCDeleteSystemusernspartitionbinding {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Binding object showing the nspartition that can be bound to systemuser.
    .PARAMETER Username 
        Name of the system-user entry to which to bind the command policy. 
    .PARAMETER Partitionname 
        Name of the Partition to bind to the system user.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystemusernspartitionbinding -Username <string>
        An example how to delete systemuser_nspartition_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystemusernspartitionbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser_nspartition_binding/
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
        [string]$Username,

        [string]$Partitionname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemusernspartitionbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Partitionname') ) { $arguments.Add('partitionname', $Partitionname) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemuser_nspartition_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystemusernspartitionbinding: Finished"
    }
}

function Invoke-ADCGetSystemusernspartitionbinding {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Binding object showing the nspartition that can be bound to systemuser.
    .PARAMETER Username 
        Name of the system-user entry to which to bind the command policy. 
    .PARAMETER GetAll 
        Retrieve all systemuser_nspartition_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemuser_nspartition_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemusernspartitionbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemusernspartitionbinding -GetAll 
        Get all systemuser_nspartition_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemusernspartitionbinding -Count 
        Get the number of systemuser_nspartition_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemusernspartitionbinding -name <string>
        Get systemuser_nspartition_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemusernspartitionbinding -Filter @{ 'name'='<value>' }
        Get systemuser_nspartition_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemusernspartitionbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser_nspartition_binding/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemusernspartitionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemuser_nspartition_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_nspartition_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemuser_nspartition_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_nspartition_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemuser_nspartition_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_nspartition_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemuser_nspartition_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_nspartition_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemuser_nspartition_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_nspartition_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemusernspartitionbinding: Ended"
    }
}

function Invoke-ADCAddSystemusersystemcmdpolicybinding {
    <#
    .SYNOPSIS
        Add System configuration Object.
    .DESCRIPTION
        Binding object showing the systemcmdpolicy that can be bound to systemuser.
    .PARAMETER Username 
        Name of the system-user entry to which to bind the command policy. 
    .PARAMETER Policyname 
        The name of command policy. 
    .PARAMETER Priority 
        The priority of the policy. 
    .PARAMETER PassThru 
        Return details about the created systemuser_systemcmdpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSystemusersystemcmdpolicybinding -username <string>
        An example how to add systemuser_systemcmdpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSystemusersystemcmdpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser_systemcmdpolicy_binding/
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
        [string]$Username,

        [string]$Policyname,

        [double]$Priority,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemusersystemcmdpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSCmdlet.ShouldProcess("systemuser_systemcmdpolicy_binding", "Add System configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type systemuser_systemcmdpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSystemusersystemcmdpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddSystemusersystemcmdpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteSystemusersystemcmdpolicybinding {
    <#
    .SYNOPSIS
        Delete System configuration Object.
    .DESCRIPTION
        Binding object showing the systemcmdpolicy that can be bound to systemuser.
    .PARAMETER Username 
        Name of the system-user entry to which to bind the command policy. 
    .PARAMETER Policyname 
        The name of command policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSystemusersystemcmdpolicybinding -Username <string>
        An example how to delete systemuser_systemcmdpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSystemusersystemcmdpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser_systemcmdpolicy_binding/
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
        [string]$Username,

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemusersystemcmdpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete System configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemuser_systemcmdpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSystemusersystemcmdpolicybinding: Finished"
    }
}

function Invoke-ADCGetSystemusersystemcmdpolicybinding {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Binding object showing the systemcmdpolicy that can be bound to systemuser.
    .PARAMETER Username 
        Name of the system-user entry to which to bind the command policy. 
    .PARAMETER GetAll 
        Retrieve all systemuser_systemcmdpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemuser_systemcmdpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemusersystemcmdpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemusersystemcmdpolicybinding -GetAll 
        Get all systemuser_systemcmdpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemusersystemcmdpolicybinding -Count 
        Get the number of systemuser_systemcmdpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemusersystemcmdpolicybinding -name <string>
        Get systemuser_systemcmdpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemusersystemcmdpolicybinding -Filter @{ 'name'='<value>' }
        Get systemuser_systemcmdpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemusersystemcmdpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser_systemcmdpolicy_binding/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemusersystemcmdpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemuser_systemcmdpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemcmdpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemuser_systemcmdpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemcmdpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemuser_systemcmdpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemcmdpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemuser_systemcmdpolicy_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemcmdpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemuser_systemcmdpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemcmdpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemusersystemcmdpolicybinding: Ended"
    }
}

function Invoke-ADCGetSystemusersystemgroupbinding {
    <#
    .SYNOPSIS
        Get System configuration object(s).
    .DESCRIPTION
        Binding object showing the systemgroup that can be bound to systemuser.
    .PARAMETER Username 
        Name of the system-user entry to which to bind the command policy. 
    .PARAMETER GetAll 
        Retrieve all systemuser_systemgroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the systemuser_systemgroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemusersystemgroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemusersystemgroupbinding -GetAll 
        Get all systemuser_systemgroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSystemusersystemgroupbinding -Count 
        Get the number of systemuser_systemgroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemusersystemgroupbinding -name <string>
        Get systemuser_systemgroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSystemusersystemgroupbinding -Filter @{ 'name'='<value>' }
        Get systemuser_systemgroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSystemusersystemgroupbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser_systemgroup_binding/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemusersystemgroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all systemuser_systemgroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemgroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemuser_systemgroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemgroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemuser_systemgroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemgroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemuser_systemgroup_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemgroup_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemuser_systemgroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemgroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemusersystemgroupbinding: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAmLlwWcD/2Dv32
# Q063JdS0bwtx6BGtq0gONQyt5ql6kKCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQgNevH8lK8xse7Ko81+Yho/EAn293zIdSfJrDAt7KFYYIwDQYJKoZIhvcNAQEB
# BQAEggEAWmeQkYbXXBuhxJnsDUoulGo5/aNAM9hNCkDTbY+aLLJHgHQg9gjXNo1g
# IgQOqSBTgO7MewilpKuqcw8HIn0WtoQz8Njps/IzmzAW888CjF/0QEw2oH/BYyeY
# YoF1al8Px33HwvZzCmseW/apU976ibUFOwZF52dRULblGPeCFBkbQOaIpcq6taxA
# O5EdgKGhJ7rCfmwx29dlwbnZeChX/bfwAI9kUk28D3icnMvJ3w4iB5GElfRHDsHl
# EdNL2B+f9EIxaW3w0vf/MMqYRnHozs2zgGdo0Pwn3dv8JcL+gXw1e5621HHHXLz0
# di9nM7myrz/5/JQExl5OQDjd/XGwDg==
# SIG # End signature block
