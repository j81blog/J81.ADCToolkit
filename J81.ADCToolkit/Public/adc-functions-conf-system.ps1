function Invoke-ADCEnableSystemautorestorefeature {
<#
    .SYNOPSIS
        Enable System configuration Object
    .DESCRIPTION
        Enable System configuration Object 
    .EXAMPLE
        Invoke-ADCEnableSystemautorestorefeature 
    .NOTES
        File Name : Invoke-ADCEnableSystemautorestorefeature
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemautorestorefeature/
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
        Write-Verbose "Invoke-ADCEnableSystemautorestorefeature: Starting"
    }
    process {
        try {
            $Payload = @{

            }

            if ($PSCmdlet.ShouldProcess($Name, "Enable System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemautorestorefeature -Action enable -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCEnableSystemautorestorefeature: Finished"
    }
}

function Invoke-ADCDisableSystemautorestorefeature {
<#
    .SYNOPSIS
        Disable System configuration Object
    .DESCRIPTION
        Disable System configuration Object 
    .EXAMPLE
        Invoke-ADCDisableSystemautorestorefeature 
    .NOTES
        File Name : Invoke-ADCDisableSystemautorestorefeature
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemautorestorefeature/
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
        Write-Verbose "Invoke-ADCDisableSystemautorestorefeature: Starting"
    }
    process {
        try {
            $Payload = @{

            }

            if ($PSCmdlet.ShouldProcess($Name, "Disable System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemautorestorefeature -Action disable -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCDisableSystemautorestorefeature: Finished"
    }
}

function Invoke-ADCCreateSystembackup {
<#
    .SYNOPSIS
        Create System configuration Object
    .DESCRIPTION
        Create System configuration Object 
    .PARAMETER filename 
        Name of the backup file(*.tgz) to be restored. 
    .PARAMETER uselocaltimezone 
        This option will create backup file with local timezone timestamp. 
    .PARAMETER level 
        Level of data to be backed up.  
        Possible values = basic, full 
    .PARAMETER includekernel 
        Use this option to add kernel in the backup file.  
        Possible values = NO, YES 
    .PARAMETER comment 
        Comment specified at the time of creation of the backup file(*.tgz).
    .EXAMPLE
        Invoke-ADCCreateSystembackup 
    .NOTES
        File Name : Invoke-ADCCreateSystembackup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systembackup/
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

        [string]$filename ,

        [boolean]$uselocaltimezone ,

        [ValidateSet('basic', 'full')]
        [string]$level ,

        [ValidateSet('NO', 'YES')]
        [string]$includekernel ,

        [string]$comment 

    )
    begin {
        Write-Verbose "Invoke-ADCCreateSystembackup: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('filename')) { $Payload.Add('filename', $filename) }
            if ($PSBoundParameters.ContainsKey('uselocaltimezone')) { $Payload.Add('uselocaltimezone', $uselocaltimezone) }
            if ($PSBoundParameters.ContainsKey('level')) { $Payload.Add('level', $level) }
            if ($PSBoundParameters.ContainsKey('includekernel')) { $Payload.Add('includekernel', $includekernel) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSCmdlet.ShouldProcess($Name, "Create System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systembackup -Action create -Payload $Payload -GetWarning
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
        Restore System configuration Object
    .DESCRIPTION
        Restore System configuration Object 
    .PARAMETER filename 
        Name of the backup file(*.tgz) to be restored. 
    .PARAMETER skipbackup 
        Use this option to skip taking backup during restore operation.
    .EXAMPLE
        Invoke-ADCRestoreSystembackup -filename <string>
    .NOTES
        File Name : Invoke-ADCRestoreSystembackup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systembackup/
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
        [string]$filename ,

        [boolean]$skipbackup 

    )
    begin {
        Write-Verbose "Invoke-ADCRestoreSystembackup: Starting"
    }
    process {
        try {
            $Payload = @{
                filename = $filename
            }
            if ($PSBoundParameters.ContainsKey('skipbackup')) { $Payload.Add('skipbackup', $skipbackup) }
            if ($PSCmdlet.ShouldProcess($Name, "Restore System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systembackup -Action restore -Payload $Payload -GetWarning
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
        Add System configuration Object
    .DESCRIPTION
        Add System configuration Object 
    .PARAMETER filename 
        Name of the backup file(*.tgz) to be restored.  
        Maximum length = 63 
    .PARAMETER PassThru 
        Return details about the created systembackup item.
    .EXAMPLE
        Invoke-ADCAddSystembackup -filename <string>
    .NOTES
        File Name : Invoke-ADCAddSystembackup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systembackup/
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
        [string]$filename ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSystembackup: Starting"
    }
    process {
        try {
            $Payload = @{
                filename = $filename
            }

 
            if ($PSCmdlet.ShouldProcess("systembackup", "Add System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systembackup -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystembackup -Filter $Payload)
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
    .PARAMETER filename 
       Name of the backup file(*.tgz) to be restored.  
       Maximum length = 63 
    .EXAMPLE
        Invoke-ADCDeleteSystembackup -filename <string>
    .NOTES
        File Name : Invoke-ADCDeleteSystembackup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systembackup/
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
        [string]$filename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystembackup: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$filename", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systembackup -Resource $filename -Arguments $Arguments
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER filename 
       Name of the backup file(*.tgz) to be restored. 
    .PARAMETER GetAll 
        Retreive all systembackup object(s)
    .PARAMETER Count
        If specified, the count of the systembackup object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystembackup
    .EXAMPLE 
        Invoke-ADCGetSystembackup -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystembackup -Count
    .EXAMPLE
        Invoke-ADCGetSystembackup -name <string>
    .EXAMPLE
        Invoke-ADCGetSystembackup -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystembackup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systembackup/
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
        [string]$filename,

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
        Write-Verbose "Invoke-ADCGetSystembackup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systembackup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systembackup -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systembackup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systembackup -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systembackup objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systembackup -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systembackup configuration for property 'filename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systembackup -Resource $filename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systembackup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systembackup -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add System configuration Object
    .DESCRIPTION
        Add System configuration Object 
    .PARAMETER policyname 
        Name for a command policy. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the policy is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy').  
        Minimum length = 1 
    .PARAMETER action 
        Action to perform when a request matches the policy.  
        Possible values = ALLOW, DENY 
    .PARAMETER cmdspec 
        Regular expression specifying the data that matches the policy.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created systemcmdpolicy item.
    .EXAMPLE
        Invoke-ADCAddSystemcmdpolicy -policyname <string> -action <string> -cmdspec <string>
    .NOTES
        File Name : Invoke-ADCAddSystemcmdpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcmdpolicy/
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
        [string]$policyname ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('ALLOW', 'DENY')]
        [string]$action ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cmdspec ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemcmdpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
                action = $action
                cmdspec = $cmdspec
            }

 
            if ($PSCmdlet.ShouldProcess("systemcmdpolicy", "Add System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemcmdpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystemcmdpolicy -Filter $Payload)
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
    .PARAMETER policyname 
       Name for a command policy. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the policy is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy').  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteSystemcmdpolicy -policyname <string>
    .NOTES
        File Name : Invoke-ADCDeleteSystemcmdpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcmdpolicy/
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
        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemcmdpolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$policyname", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemcmdpolicy -Resource $policyname -Arguments $Arguments
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
        Update System configuration Object
    .DESCRIPTION
        Update System configuration Object 
    .PARAMETER policyname 
        Name for a command policy. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the policy is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy').  
        Minimum length = 1 
    .PARAMETER action 
        Action to perform when a request matches the policy.  
        Possible values = ALLOW, DENY 
    .PARAMETER cmdspec 
        Regular expression specifying the data that matches the policy.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created systemcmdpolicy item.
    .EXAMPLE
        Invoke-ADCUpdateSystemcmdpolicy -policyname <string> -action <string> -cmdspec <string>
    .NOTES
        File Name : Invoke-ADCUpdateSystemcmdpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcmdpolicy/
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
        [string]$policyname ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('ALLOW', 'DENY')]
        [string]$action ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cmdspec ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSystemcmdpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
                action = $action
                cmdspec = $cmdspec
            }

 
            if ($PSCmdlet.ShouldProcess("systemcmdpolicy", "Update System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type systemcmdpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystemcmdpolicy -Filter $Payload)
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER policyname 
       Name for a command policy. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the policy is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy'). 
    .PARAMETER GetAll 
        Retreive all systemcmdpolicy object(s)
    .PARAMETER Count
        If specified, the count of the systemcmdpolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemcmdpolicy
    .EXAMPLE 
        Invoke-ADCGetSystemcmdpolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystemcmdpolicy -Count
    .EXAMPLE
        Invoke-ADCGetSystemcmdpolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemcmdpolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemcmdpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcmdpolicy/
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
        [string]$policyname,

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
        Write-Verbose "Invoke-ADCGetSystemcmdpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systemcmdpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcmdpolicy -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemcmdpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcmdpolicy -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemcmdpolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcmdpolicy -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemcmdpolicy configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcmdpolicy -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemcmdpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcmdpolicy -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Update System configuration Object
    .DESCRIPTION
        Update System configuration Object 
    .PARAMETER communityname 
        SNMPv1 community name for authentication. 
    .PARAMETER loglevel 
        specify the log level. Possible values CRITICAL,WARNING,INFO,DEBUG1,DEBUG2.  
        Minimum length = 1 
    .PARAMETER datapath 
        specify the data path to the database.  
        Minimum length = 1
    .EXAMPLE
        Invoke-ADCUpdateSystemcollectionparam 
    .NOTES
        File Name : Invoke-ADCUpdateSystemcollectionparam
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcollectionparam/
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

        [string]$communityname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$loglevel ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$datapath 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSystemcollectionparam: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('communityname')) { $Payload.Add('communityname', $communityname) }
            if ($PSBoundParameters.ContainsKey('loglevel')) { $Payload.Add('loglevel', $loglevel) }
            if ($PSBoundParameters.ContainsKey('datapath')) { $Payload.Add('datapath', $datapath) }
 
            if ($PSCmdlet.ShouldProcess("systemcollectionparam", "Update System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type systemcollectionparam -Payload $Payload -GetWarning
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
        Unset System configuration Object
    .DESCRIPTION
        Unset System configuration Object 
   .PARAMETER communityname 
       SNMPv1 community name for authentication. 
   .PARAMETER loglevel 
       specify the log level. Possible values CRITICAL,WARNING,INFO,DEBUG1,DEBUG2. 
   .PARAMETER datapath 
       specify the data path to the database.
    .EXAMPLE
        Invoke-ADCUnsetSystemcollectionparam 
    .NOTES
        File Name : Invoke-ADCUnsetSystemcollectionparam
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcollectionparam
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

        [Boolean]$communityname ,

        [Boolean]$loglevel ,

        [Boolean]$datapath 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSystemcollectionparam: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('communityname')) { $Payload.Add('communityname', $communityname) }
            if ($PSBoundParameters.ContainsKey('loglevel')) { $Payload.Add('loglevel', $loglevel) }
            if ($PSBoundParameters.ContainsKey('datapath')) { $Payload.Add('datapath', $datapath) }
            if ($PSCmdlet.ShouldProcess("systemcollectionparam", "Unset System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemcollectionparam -Action unset -Payload $Payload -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER GetAll 
        Retreive all systemcollectionparam object(s)
    .PARAMETER Count
        If specified, the count of the systemcollectionparam object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemcollectionparam
    .EXAMPLE 
        Invoke-ADCGetSystemcollectionparam -GetAll
    .EXAMPLE
        Invoke-ADCGetSystemcollectionparam -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemcollectionparam -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemcollectionparam
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcollectionparam/
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
        Write-Verbose "Invoke-ADCGetSystemcollectionparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systemcollectionparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcollectionparam -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemcollectionparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcollectionparam -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemcollectionparam objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcollectionparam -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemcollectionparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemcollectionparam configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcollectionparam -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER datasource 
       Specifies the source which contains all the stored counter values. 
    .PARAMETER GetAll 
        Retreive all systemcore object(s)
    .PARAMETER Count
        If specified, the count of the systemcore object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemcore
    .EXAMPLE 
        Invoke-ADCGetSystemcore -GetAll
    .EXAMPLE
        Invoke-ADCGetSystemcore -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemcore -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemcore
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcore/
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
        [string]$datasource,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemcore: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systemcore objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcore -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemcore objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcore -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemcore objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('datasource')) { $Arguments.Add('datasource', $datasource) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcore -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemcore configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemcore configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcore -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER datasource 
       Specifies the source which contains all the stored counter values. 
    .PARAMETER GetAll 
        Retreive all systemcountergroup object(s)
    .PARAMETER Count
        If specified, the count of the systemcountergroup object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemcountergroup
    .EXAMPLE 
        Invoke-ADCGetSystemcountergroup -GetAll
    .EXAMPLE
        Invoke-ADCGetSystemcountergroup -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemcountergroup -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemcountergroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcountergroup/
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
        [string]$datasource,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemcountergroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systemcountergroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcountergroup -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemcountergroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcountergroup -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemcountergroup objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('datasource')) { $Arguments.Add('datasource', $datasource) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcountergroup -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemcountergroup configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemcountergroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcountergroup -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER countergroup 
       Specify the (counter) group name which contains all the counters specific tot his particular group. 
    .PARAMETER datasource 
       Specifies the source which contains all the stored counter values. 
    .PARAMETER GetAll 
        Retreive all systemcounters object(s)
    .PARAMETER Count
        If specified, the count of the systemcounters object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemcounters
    .EXAMPLE 
        Invoke-ADCGetSystemcounters -GetAll
    .EXAMPLE
        Invoke-ADCGetSystemcounters -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemcounters -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemcounters
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemcounters/
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
        [string]$countergroup ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$datasource,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemcounters: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systemcounters objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcounters -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemcounters objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcounters -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemcounters objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('countergroup')) { $Arguments.Add('countergroup', $countergroup) } 
                if ($PSBoundParameters.ContainsKey('datasource')) { $Arguments.Add('datasource', $datasource) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcounters -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemcounters configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemcounters configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemcounters -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER datasource 
       Specifies the source which contains all the stored counter values. 
    .PARAMETER GetAll 
        Retreive all systemdatasource object(s)
    .PARAMETER Count
        If specified, the count of the systemdatasource object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemdatasource
    .EXAMPLE 
        Invoke-ADCGetSystemdatasource -GetAll
    .EXAMPLE
        Invoke-ADCGetSystemdatasource -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemdatasource -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemdatasource
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemdatasource/
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
        [string]$datasource,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemdatasource: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systemdatasource objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemdatasource -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemdatasource objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemdatasource -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemdatasource objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('datasource')) { $Arguments.Add('datasource', $datasource) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemdatasource -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemdatasource configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemdatasource configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemdatasource -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER type 
       Specify the entity type. 
    .PARAMETER datasource 
       Specifies the source which contains all the stored counter values. 
    .PARAMETER core 
       Specify core ID of the PE in nCore. 
    .PARAMETER GetAll 
        Retreive all systementity object(s)
    .PARAMETER Count
        If specified, the count of the systementity object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystementity
    .EXAMPLE 
        Invoke-ADCGetSystementity -GetAll
    .EXAMPLE
        Invoke-ADCGetSystementity -name <string>
    .EXAMPLE
        Invoke-ADCGetSystementity -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystementity
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systementity/
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
        [string]$type ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$datasource ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$core,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystementity: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systementity objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementity -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systementity objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementity -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systementity objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) } 
                if ($PSBoundParameters.ContainsKey('datasource')) { $Arguments.Add('datasource', $datasource) } 
                if ($PSBoundParameters.ContainsKey('core')) { $Arguments.Add('core', $core) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementity -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systementity configuration for property ''"

            } else {
                Write-Verbose "Retrieving systementity configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementity -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
     .PARAMETER type 
       Specify the entity type.    .PARAMETER name 
       Specify the entity name.    .PARAMETER alldeleted 
       Specify this if you would like to delete information about all deleted entities from the database.    .PARAMETER allinactive 
       Specify this if you would like to delete information about all inactive entities from the database.    .PARAMETER datasource 
       Specifies the source which contains all the stored counter values.    .PARAMETER core 
       Specify core ID of the PE in nCore.
    .EXAMPLE
        Invoke-ADCDeleteSystementitydata 
    .NOTES
        File Name : Invoke-ADCDeleteSystementitydata
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systementitydata/
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

        [string]$type ,

        [string]$name ,

        [boolean]$alldeleted ,

        [boolean]$allinactive ,

        [string]$datasource ,

        [int]$core 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystementitydata: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('name')) { $Arguments.Add('name', $name) }
            if ($PSBoundParameters.ContainsKey('alldeleted')) { $Arguments.Add('alldeleted', $alldeleted) }
            if ($PSBoundParameters.ContainsKey('allinactive')) { $Arguments.Add('allinactive', $allinactive) }
            if ($PSBoundParameters.ContainsKey('datasource')) { $Arguments.Add('datasource', $datasource) }
            if ($PSBoundParameters.ContainsKey('core')) { $Arguments.Add('core', $core) }
            if ($PSCmdlet.ShouldProcess("systementitydata", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systementitydata -Resource $ -Arguments $Arguments
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER type 
       Specify the entity type. 
    .PARAMETER name 
       Specify the entity name. 
    .PARAMETER counters 
       Specify the counters to be collected. 
    .PARAMETER starttime 
       Specify start time in mmddyyyyhhmm to start collecting values from that timestamp. 
    .PARAMETER endtime 
       Specify end time in mmddyyyyhhmm upto which values have to be collected. 
    .PARAMETER last 
       Last is literal way of saying a certain time period from the current moment. Example: -last 1 hour, -last 1 day, et cetera. 
    .PARAMETER unit 
       Specify the time period from current moment. Example 1 x where x = hours/ days/ years.  
       Possible values = HOURS, DAYS, MONTHS 
    .PARAMETER datasource 
       Specifies the source which contains all the stored counter values. 
    .PARAMETER core 
       Specify core ID of the PE in nCore. 
    .PARAMETER GetAll 
        Retreive all systementitydata object(s)
    .PARAMETER Count
        If specified, the count of the systementitydata object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystementitydata
    .EXAMPLE 
        Invoke-ADCGetSystementitydata -GetAll
    .EXAMPLE
        Invoke-ADCGetSystementitydata -name <string>
    .EXAMPLE
        Invoke-ADCGetSystementitydata -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystementitydata
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systementitydata/
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
        [string]$type ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$name ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$counters ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$starttime ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$endtime ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$last ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('HOURS', 'DAYS', 'MONTHS')]
        [string]$unit ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$datasource ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$core,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystementitydata: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systementitydata objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementitydata -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systementitydata objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementitydata -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systementitydata objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) } 
                if ($PSBoundParameters.ContainsKey('name')) { $Arguments.Add('name', $name) } 
                if ($PSBoundParameters.ContainsKey('counters')) { $Arguments.Add('counters', $counters) } 
                if ($PSBoundParameters.ContainsKey('starttime')) { $Arguments.Add('starttime', $starttime) } 
                if ($PSBoundParameters.ContainsKey('endtime')) { $Arguments.Add('endtime', $endtime) } 
                if ($PSBoundParameters.ContainsKey('last')) { $Arguments.Add('last', $last) } 
                if ($PSBoundParameters.ContainsKey('unit')) { $Arguments.Add('unit', $unit) } 
                if ($PSBoundParameters.ContainsKey('datasource')) { $Arguments.Add('datasource', $datasource) } 
                if ($PSBoundParameters.ContainsKey('core')) { $Arguments.Add('core', $core) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementitydata -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systementitydata configuration for property ''"

            } else {
                Write-Verbose "Retrieving systementitydata configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementitydata -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER datasource 
       Specifies the source which contains all the stored counter values. 
    .PARAMETER GetAll 
        Retreive all systementitytype object(s)
    .PARAMETER Count
        If specified, the count of the systementitytype object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystementitytype
    .EXAMPLE 
        Invoke-ADCGetSystementitytype -GetAll
    .EXAMPLE
        Invoke-ADCGetSystementitytype -name <string>
    .EXAMPLE
        Invoke-ADCGetSystementitytype -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystementitytype
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systementitytype/
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
        [string]$datasource,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystementitytype: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systementitytype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementitytype -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systementitytype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementitytype -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systementitytype objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('datasource')) { $Arguments.Add('datasource', $datasource) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementitytype -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systementitytype configuration for property ''"

            } else {
                Write-Verbose "Retrieving systementitytype configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systementitytype -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER starttime 
       Specify start time in mmddyyyyhhmm to start collecting values from that timestamp. 
    .PARAMETER endtime 
       Specify end time in mmddyyyyhhmm upto which values have to be collected. 
    .PARAMETER last 
       Last is literal way of saying a certain time period from the current moment. Example: -last 1 hour, -last 1 day, et cetera. 
    .PARAMETER unit 
       Specify the time period from current moment. Example 1 x where x = hours/ days/ years.  
       Possible values = HOURS, DAYS, MONTHS 
    .PARAMETER datasource 
       Specifies the source which contains all the stored counter values. 
    .PARAMETER GetAll 
        Retreive all systemeventhistory object(s)
    .PARAMETER Count
        If specified, the count of the systemeventhistory object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemeventhistory
    .EXAMPLE 
        Invoke-ADCGetSystemeventhistory -GetAll
    .EXAMPLE
        Invoke-ADCGetSystemeventhistory -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemeventhistory -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemeventhistory
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemeventhistory/
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
        [string]$starttime ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$endtime ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$last ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('HOURS', 'DAYS', 'MONTHS')]
        [string]$unit ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$datasource,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemeventhistory: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systemeventhistory objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemeventhistory -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemeventhistory objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemeventhistory -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemeventhistory objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('starttime')) { $Arguments.Add('starttime', $starttime) } 
                if ($PSBoundParameters.ContainsKey('endtime')) { $Arguments.Add('endtime', $endtime) } 
                if ($PSBoundParameters.ContainsKey('last')) { $Arguments.Add('last', $last) } 
                if ($PSBoundParameters.ContainsKey('unit')) { $Arguments.Add('unit', $unit) } 
                if ($PSBoundParameters.ContainsKey('datasource')) { $Arguments.Add('datasource', $datasource) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemeventhistory -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemeventhistory configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemeventhistory configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemeventhistory -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Enable System configuration Object
    .DESCRIPTION
        Enable System configuration Object 
    .EXAMPLE
        Invoke-ADCEnableSystemextramgmtcpu 
    .NOTES
        File Name : Invoke-ADCEnableSystemextramgmtcpu
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemextramgmtcpu/
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
        Write-Verbose "Invoke-ADCEnableSystemextramgmtcpu: Starting"
    }
    process {
        try {
            $Payload = @{

            }

            if ($PSCmdlet.ShouldProcess($Name, "Enable System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemextramgmtcpu -Action enable -Payload $Payload -GetWarning
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
        Disable System configuration Object
    .DESCRIPTION
        Disable System configuration Object 
    .EXAMPLE
        Invoke-ADCDisableSystemextramgmtcpu 
    .NOTES
        File Name : Invoke-ADCDisableSystemextramgmtcpu
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemextramgmtcpu/
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
        Write-Verbose "Invoke-ADCDisableSystemextramgmtcpu: Starting"
    }
    process {
        try {
            $Payload = @{

            }

            if ($PSCmdlet.ShouldProcess($Name, "Disable System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemextramgmtcpu -Action disable -Payload $Payload -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER nodeid 
       Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retreive all systemextramgmtcpu object(s)
    .PARAMETER Count
        If specified, the count of the systemextramgmtcpu object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemextramgmtcpu
    .EXAMPLE 
        Invoke-ADCGetSystemextramgmtcpu -GetAll
    .EXAMPLE
        Invoke-ADCGetSystemextramgmtcpu -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemextramgmtcpu -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemextramgmtcpu
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemextramgmtcpu/
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
        [ValidateRange(0, 31)]
        [double]$nodeid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemextramgmtcpu: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systemextramgmtcpu objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemextramgmtcpu -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemextramgmtcpu objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemextramgmtcpu -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemextramgmtcpu objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('nodeid')) { $Arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemextramgmtcpu -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemextramgmtcpu configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemextramgmtcpu configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemextramgmtcpu -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add System configuration Object
    .DESCRIPTION
        Add System configuration Object 
    .PARAMETER filename 
        Name of the file. It should not include filepath.  
        Maximum length = 63 
    .PARAMETER filecontent 
        file content in Base64 format. 
    .PARAMETER filelocation 
        location of the file on Citrix ADC.  
        Maximum length = 127 
    .PARAMETER fileencoding 
        encoding type of the file content.  
        Default value: "BASE64"
    .EXAMPLE
        Invoke-ADCAddSystemfile -filename <string> -filecontent <string> -filelocation <string>
    .NOTES
        File Name : Invoke-ADCAddSystemfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemfile/
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
        [string]$filename ,

        [Parameter(Mandatory = $true)]
        [string]$filecontent ,

        [Parameter(Mandatory = $true)]
        [string]$filelocation ,

        [string]$fileencoding = '"BASE64"' 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemfile: Starting"
    }
    process {
        try {
            $Payload = @{
                filename = $filename
                filecontent = $filecontent
                filelocation = $filelocation
            }
            if ($PSBoundParameters.ContainsKey('fileencoding')) { $Payload.Add('fileencoding', $fileencoding) }
 
            if ($PSCmdlet.ShouldProcess("systemfile", "Add System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemfile -Payload $Payload -GetWarning
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
    .PARAMETER filename 
       Name of the file. It should not include filepath.  
       Maximum length = 63    .PARAMETER filelocation 
       location of the file on Citrix ADC.  
       Maximum length = 127
    .EXAMPLE
        Invoke-ADCDeleteSystemfile -filename <string>
    .NOTES
        File Name : Invoke-ADCDeleteSystemfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemfile/
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
        [string]$filename ,

        [string]$filelocation 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemfile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('filelocation')) { $Arguments.Add('filelocation', $filelocation) }
            if ($PSCmdlet.ShouldProcess("$filename", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemfile -Resource $filename -Arguments $Arguments
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER filename 
       Name of the file. It should not include filepath. 
    .PARAMETER filelocation 
       location of the file on Citrix ADC. 
    .PARAMETER GetAll 
        Retreive all systemfile object(s)
    .PARAMETER Count
        If specified, the count of the systemfile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemfile
    .EXAMPLE 
        Invoke-ADCGetSystemfile -GetAll
    .EXAMPLE
        Invoke-ADCGetSystemfile -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemfile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemfile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemfile/
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
        [string]$filename ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$filelocation,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemfile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systemfile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemfile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemfile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemfile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemfile objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('filename')) { $Arguments.Add('filename', $filename) } 
                if ($PSBoundParameters.ContainsKey('filelocation')) { $Arguments.Add('filelocation', $filelocation) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemfile -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemfile configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemfile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemfile -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER counters 
       Specify the counters to be collected. 
    .PARAMETER countergroup 
       Specify the (counter) group name which contains all the counters specific to this particular group. 
    .PARAMETER starttime 
       Specify start time in mmddyyyyhhmm to start collecting values from that timestamp. 
    .PARAMETER endtime 
       Specify end time in mmddyyyyhhmm upto which values have to be collected. 
    .PARAMETER last 
       Last is literal way of saying a certain time period from the current moment. Example: -last 1 hour, -last 1 day, et cetera. 
    .PARAMETER unit 
       Specify the time period from current moment. Example 1 x where x = hours/ days/ years.  
       Possible values = HOURS, DAYS, MONTHS 
    .PARAMETER datasource 
       Specifies the source which contains all the stored counter values. 
    .PARAMETER core 
       Specify core ID of the PE in nCore. 
    .PARAMETER GetAll 
        Retreive all systemglobaldata object(s)
    .PARAMETER Count
        If specified, the count of the systemglobaldata object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemglobaldata
    .EXAMPLE 
        Invoke-ADCGetSystemglobaldata -GetAll
    .EXAMPLE
        Invoke-ADCGetSystemglobaldata -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemglobaldata -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemglobaldata
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobaldata/
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
        [string]$counters ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$countergroup ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$starttime ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$endtime ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$last ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('HOURS', 'DAYS', 'MONTHS')]
        [string]$unit ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$datasource ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$core,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemglobaldata: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systemglobaldata objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobaldata -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobaldata objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobaldata -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobaldata objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('counters')) { $Arguments.Add('counters', $counters) } 
                if ($PSBoundParameters.ContainsKey('countergroup')) { $Arguments.Add('countergroup', $countergroup) } 
                if ($PSBoundParameters.ContainsKey('starttime')) { $Arguments.Add('starttime', $starttime) } 
                if ($PSBoundParameters.ContainsKey('endtime')) { $Arguments.Add('endtime', $endtime) } 
                if ($PSBoundParameters.ContainsKey('last')) { $Arguments.Add('last', $last) } 
                if ($PSBoundParameters.ContainsKey('unit')) { $Arguments.Add('unit', $unit) } 
                if ($PSBoundParameters.ContainsKey('datasource')) { $Arguments.Add('datasource', $datasource) } 
                if ($PSBoundParameters.ContainsKey('core')) { $Arguments.Add('core', $core) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobaldata -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobaldata configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobaldata configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobaldata -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add System configuration Object
    .DESCRIPTION
        Add System configuration Object 
    .PARAMETER policyname 
        The name of the command policy. 
    .PARAMETER priority 
        The priority of the command policy. 
    .PARAMETER nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER gotopriorityexpression 
        Applicable only to advance authentication policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_auditnslogpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddSystemglobalauditnslogpolicybinding 
    .NOTES
        File Name : Invoke-ADCAddSystemglobalauditnslogpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_auditnslogpolicy_binding/
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

        [string]$nextfactor ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemglobalauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('nextfactor')) { $Payload.Add('nextfactor', $nextfactor) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("systemglobal_auditnslogpolicy_binding", "Add System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type systemglobal_auditnslogpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystemglobalauditnslogpolicybinding -Filter $Payload)
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
     .PARAMETER policyname 
       The name of the command policy.
    .EXAMPLE
        Invoke-ADCDeleteSystemglobalauditnslogpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteSystemglobalauditnslogpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_auditnslogpolicy_binding/
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

        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemglobalauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSCmdlet.ShouldProcess("systemglobal_auditnslogpolicy_binding", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemglobal_auditnslogpolicy_binding -Resource $ -Arguments $Arguments
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER GetAll 
        Retreive all systemglobal_auditnslogpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the systemglobal_auditnslogpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemglobalauditnslogpolicybinding
    .EXAMPLE 
        Invoke-ADCGetSystemglobalauditnslogpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystemglobalauditnslogpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetSystemglobalauditnslogpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemglobalauditnslogpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemglobalauditnslogpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetSystemglobalauditnslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all systemglobal_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_auditnslogpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_auditnslogpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_auditnslogpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_auditnslogpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_auditnslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_auditnslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_auditnslogpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add System configuration Object
    .DESCRIPTION
        Add System configuration Object 
    .PARAMETER policyname 
        The name of the command policy. 
    .PARAMETER priority 
        The priority of the command policy. 
    .PARAMETER nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER gotopriorityexpression 
        Applicable only to advance authentication policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_auditsyslogpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddSystemglobalauditsyslogpolicybinding 
    .NOTES
        File Name : Invoke-ADCAddSystemglobalauditsyslogpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_auditsyslogpolicy_binding/
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

        [string]$nextfactor ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemglobalauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('nextfactor')) { $Payload.Add('nextfactor', $nextfactor) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("systemglobal_auditsyslogpolicy_binding", "Add System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type systemglobal_auditsyslogpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystemglobalauditsyslogpolicybinding -Filter $Payload)
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
     .PARAMETER policyname 
       The name of the command policy.
    .EXAMPLE
        Invoke-ADCDeleteSystemglobalauditsyslogpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteSystemglobalauditsyslogpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_auditsyslogpolicy_binding/
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

        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemglobalauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSCmdlet.ShouldProcess("systemglobal_auditsyslogpolicy_binding", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemglobal_auditsyslogpolicy_binding -Resource $ -Arguments $Arguments
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER GetAll 
        Retreive all systemglobal_auditsyslogpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the systemglobal_auditsyslogpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemglobalauditsyslogpolicybinding
    .EXAMPLE 
        Invoke-ADCGetSystemglobalauditsyslogpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystemglobalauditsyslogpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetSystemglobalauditsyslogpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemglobalauditsyslogpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemglobalauditsyslogpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetSystemglobalauditsyslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all systemglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_auditsyslogpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_auditsyslogpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_auditsyslogpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_auditsyslogpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_auditsyslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_auditsyslogpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add System configuration Object
    .DESCRIPTION
        Add System configuration Object 
    .PARAMETER policyname 
        The name of the command policy. 
    .PARAMETER priority 
        The priority of the command policy. 
    .PARAMETER nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER gotopriorityexpression 
        Applicable only to advance authentication policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_authenticationldappolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddSystemglobalauthenticationldappolicybinding 
    .NOTES
        File Name : Invoke-ADCAddSystemglobalauthenticationldappolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationldappolicy_binding/
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

        [string]$nextfactor ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemglobalauthenticationldappolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('nextfactor')) { $Payload.Add('nextfactor', $nextfactor) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("systemglobal_authenticationldappolicy_binding", "Add System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type systemglobal_authenticationldappolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystemglobalauthenticationldappolicybinding -Filter $Payload)
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
     .PARAMETER policyname 
       The name of the command policy.
    .EXAMPLE
        Invoke-ADCDeleteSystemglobalauthenticationldappolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteSystemglobalauthenticationldappolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationldappolicy_binding/
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

        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemglobalauthenticationldappolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSCmdlet.ShouldProcess("systemglobal_authenticationldappolicy_binding", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemglobal_authenticationldappolicy_binding -Resource $ -Arguments $Arguments
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER GetAll 
        Retreive all systemglobal_authenticationldappolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the systemglobal_authenticationldappolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemglobalauthenticationldappolicybinding
    .EXAMPLE 
        Invoke-ADCGetSystemglobalauthenticationldappolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystemglobalauthenticationldappolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetSystemglobalauthenticationldappolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemglobalauthenticationldappolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemglobalauthenticationldappolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationldappolicy_binding/
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
        Write-Verbose "Invoke-ADCGetSystemglobalauthenticationldappolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all systemglobal_authenticationldappolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationldappolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_authenticationldappolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationldappolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_authenticationldappolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationldappolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_authenticationldappolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_authenticationldappolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationldappolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add System configuration Object
    .DESCRIPTION
        Add System configuration Object 
    .PARAMETER policyname 
        The name of the command policy. 
    .PARAMETER priority 
        The priority of the command policy. 
    .PARAMETER nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER gotopriorityexpression 
        Applicable only to advance authentication policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_authenticationlocalpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddSystemglobalauthenticationlocalpolicybinding 
    .NOTES
        File Name : Invoke-ADCAddSystemglobalauthenticationlocalpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationlocalpolicy_binding/
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

        [string]$nextfactor ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemglobalauthenticationlocalpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('nextfactor')) { $Payload.Add('nextfactor', $nextfactor) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("systemglobal_authenticationlocalpolicy_binding", "Add System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type systemglobal_authenticationlocalpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystemglobalauthenticationlocalpolicybinding -Filter $Payload)
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
     .PARAMETER policyname 
       The name of the command policy.
    .EXAMPLE
        Invoke-ADCDeleteSystemglobalauthenticationlocalpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteSystemglobalauthenticationlocalpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationlocalpolicy_binding/
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

        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemglobalauthenticationlocalpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSCmdlet.ShouldProcess("systemglobal_authenticationlocalpolicy_binding", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemglobal_authenticationlocalpolicy_binding -Resource $ -Arguments $Arguments
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER GetAll 
        Retreive all systemglobal_authenticationlocalpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the systemglobal_authenticationlocalpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemglobalauthenticationlocalpolicybinding
    .EXAMPLE 
        Invoke-ADCGetSystemglobalauthenticationlocalpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystemglobalauthenticationlocalpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetSystemglobalauthenticationlocalpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemglobalauthenticationlocalpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemglobalauthenticationlocalpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationlocalpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetSystemglobalauthenticationlocalpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all systemglobal_authenticationlocalpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationlocalpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_authenticationlocalpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationlocalpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_authenticationlocalpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationlocalpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_authenticationlocalpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_authenticationlocalpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationlocalpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add System configuration Object
    .DESCRIPTION
        Add System configuration Object 
    .PARAMETER policyname 
        The name of the command policy. 
    .PARAMETER priority 
        The priority of the command policy. 
    .PARAMETER nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. Applicable only for advanced authentication policies. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_authenticationpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddSystemglobalauthenticationpolicybinding 
    .NOTES
        File Name : Invoke-ADCAddSystemglobalauthenticationpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationpolicy_binding/
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

        [string]$nextfactor ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemglobalauthenticationpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('nextfactor')) { $Payload.Add('nextfactor', $nextfactor) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("systemglobal_authenticationpolicy_binding", "Add System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type systemglobal_authenticationpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystemglobalauthenticationpolicybinding -Filter $Payload)
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
     .PARAMETER policyname 
       The name of the command policy.
    .EXAMPLE
        Invoke-ADCDeleteSystemglobalauthenticationpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteSystemglobalauthenticationpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationpolicy_binding/
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

        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemglobalauthenticationpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSCmdlet.ShouldProcess("systemglobal_authenticationpolicy_binding", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemglobal_authenticationpolicy_binding -Resource $ -Arguments $Arguments
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER GetAll 
        Retreive all systemglobal_authenticationpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the systemglobal_authenticationpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemglobalauthenticationpolicybinding
    .EXAMPLE 
        Invoke-ADCGetSystemglobalauthenticationpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystemglobalauthenticationpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetSystemglobalauthenticationpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemglobalauthenticationpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemglobalauthenticationpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetSystemglobalauthenticationpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all systemglobal_authenticationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_authenticationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_authenticationpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_authenticationpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_authenticationpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add System configuration Object
    .DESCRIPTION
        Add System configuration Object 
    .PARAMETER policyname 
        The name of the command policy. 
    .PARAMETER priority 
        The priority of the command policy. 
    .PARAMETER nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER gotopriorityexpression 
        Applicable only to advance authentication policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_authenticationradiuspolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddSystemglobalauthenticationradiuspolicybinding 
    .NOTES
        File Name : Invoke-ADCAddSystemglobalauthenticationradiuspolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationradiuspolicy_binding/
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

        [string]$nextfactor ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemglobalauthenticationradiuspolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('nextfactor')) { $Payload.Add('nextfactor', $nextfactor) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("systemglobal_authenticationradiuspolicy_binding", "Add System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type systemglobal_authenticationradiuspolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystemglobalauthenticationradiuspolicybinding -Filter $Payload)
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
     .PARAMETER policyname 
       The name of the command policy.
    .EXAMPLE
        Invoke-ADCDeleteSystemglobalauthenticationradiuspolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteSystemglobalauthenticationradiuspolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationradiuspolicy_binding/
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

        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemglobalauthenticationradiuspolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSCmdlet.ShouldProcess("systemglobal_authenticationradiuspolicy_binding", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemglobal_authenticationradiuspolicy_binding -Resource $ -Arguments $Arguments
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER GetAll 
        Retreive all systemglobal_authenticationradiuspolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the systemglobal_authenticationradiuspolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemglobalauthenticationradiuspolicybinding
    .EXAMPLE 
        Invoke-ADCGetSystemglobalauthenticationradiuspolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystemglobalauthenticationradiuspolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetSystemglobalauthenticationradiuspolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemglobalauthenticationradiuspolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemglobalauthenticationradiuspolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationradiuspolicy_binding/
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
        Write-Verbose "Invoke-ADCGetSystemglobalauthenticationradiuspolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all systemglobal_authenticationradiuspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationradiuspolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_authenticationradiuspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationradiuspolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_authenticationradiuspolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationradiuspolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_authenticationradiuspolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_authenticationradiuspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationradiuspolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add System configuration Object
    .DESCRIPTION
        Add System configuration Object 
    .PARAMETER policyname 
        The name of the command policy. 
    .PARAMETER priority 
        The priority of the command policy. 
    .PARAMETER nextfactor 
        On success invoke label. Applicable for advanced authentication policy binding. 
    .PARAMETER gotopriorityexpression 
        Applicable only to advance authentication policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. 
    .PARAMETER PassThru 
        Return details about the created systemglobal_authenticationtacacspolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddSystemglobalauthenticationtacacspolicybinding 
    .NOTES
        File Name : Invoke-ADCAddSystemglobalauthenticationtacacspolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationtacacspolicy_binding/
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

        [string]$nextfactor ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemglobalauthenticationtacacspolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('nextfactor')) { $Payload.Add('nextfactor', $nextfactor) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("systemglobal_authenticationtacacspolicy_binding", "Add System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type systemglobal_authenticationtacacspolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystemglobalauthenticationtacacspolicybinding -Filter $Payload)
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
     .PARAMETER policyname 
       The name of the command policy.
    .EXAMPLE
        Invoke-ADCDeleteSystemglobalauthenticationtacacspolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteSystemglobalauthenticationtacacspolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationtacacspolicy_binding/
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

        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemglobalauthenticationtacacspolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSCmdlet.ShouldProcess("systemglobal_authenticationtacacspolicy_binding", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemglobal_authenticationtacacspolicy_binding -Resource $ -Arguments $Arguments
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER GetAll 
        Retreive all systemglobal_authenticationtacacspolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the systemglobal_authenticationtacacspolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemglobalauthenticationtacacspolicybinding
    .EXAMPLE 
        Invoke-ADCGetSystemglobalauthenticationtacacspolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystemglobalauthenticationtacacspolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetSystemglobalauthenticationtacacspolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemglobalauthenticationtacacspolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemglobalauthenticationtacacspolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_authenticationtacacspolicy_binding/
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
        Write-Verbose "Invoke-ADCGetSystemglobalauthenticationtacacspolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all systemglobal_authenticationtacacspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationtacacspolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_authenticationtacacspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationtacacspolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_authenticationtacacspolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationtacacspolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_authenticationtacacspolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_authenticationtacacspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_authenticationtacacspolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER GetAll 
        Retreive all systemglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the systemglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemglobalbinding
    .EXAMPLE 
        Invoke-ADCGetSystemglobalbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetSystemglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemglobalbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemglobal_binding/
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
        Write-Verbose "Invoke-ADCGetSystemglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all systemglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemglobal_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add System configuration Object
    .DESCRIPTION
        Add System configuration Object 
    .PARAMETER groupname 
        Name for the group. Must begin with a letter, number, hash(#) or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the group is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group').  
        Minimum length = 1 
    .PARAMETER promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables:  
        * %u - Will be replaced by the user name.  
        * %h - Will be replaced by the hostname of the Citrix ADC.  
        * %t - Will be replaced by the current time in 12-hour format.  
        * %T - Will be replaced by the current time in 24-hour format.  
        * %d - Will be replaced by the current date.  
        * %s - Will be replaced by the state of the Citrix ADC.  
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables.  
        Minimum length = 1 
    .PARAMETER timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument of system parameter is enabled, Timeout can have values in the range [300-86400] seconds.If Restrictedtimeout argument of system parameter is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER allowedmanagementinterface 
        Allowed Management interfaces of the system users in the group. By default allowed from both API and CLI interfaces. If management interface for a group is set to API, then all users under this group will not allowed to access NS through CLI. GUI interface will come under API interface.  
        Default value: NS_INTERFACE_ALL  
        Possible values = CLI, API 
    .PARAMETER PassThru 
        Return details about the created systemgroup item.
    .EXAMPLE
        Invoke-ADCAddSystemgroup -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddSystemgroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup/
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
        [string]$groupname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$promptstring ,

        [ValidateRange(300, 86400)]
        [double]$timeout ,

        [ValidateSet('CLI', 'API')]
        [string[]]$allowedmanagementinterface = 'NS_INTERFACE_ALL' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemgroup: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('promptstring')) { $Payload.Add('promptstring', $promptstring) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('allowedmanagementinterface')) { $Payload.Add('allowedmanagementinterface', $allowedmanagementinterface) }
 
            if ($PSCmdlet.ShouldProcess("systemgroup", "Add System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemgroup -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystemgroup -Filter $Payload)
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
    .PARAMETER groupname 
       Name for the group. Must begin with a letter, number, hash(#) or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the group is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group').  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteSystemgroup -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteSystemgroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup/
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
        [string]$groupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemgroup: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$groupname", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemgroup -Resource $groupname -Arguments $Arguments
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
        Update System configuration Object
    .DESCRIPTION
        Update System configuration Object 
    .PARAMETER groupname 
        Name for the group. Must begin with a letter, number, hash(#) or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the group is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group').  
        Minimum length = 1 
    .PARAMETER promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables:  
        * %u - Will be replaced by the user name.  
        * %h - Will be replaced by the hostname of the Citrix ADC.  
        * %t - Will be replaced by the current time in 12-hour format.  
        * %T - Will be replaced by the current time in 24-hour format.  
        * %d - Will be replaced by the current date.  
        * %s - Will be replaced by the state of the Citrix ADC.  
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables.  
        Minimum length = 1 
    .PARAMETER timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument of system parameter is enabled, Timeout can have values in the range [300-86400] seconds.If Restrictedtimeout argument of system parameter is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER allowedmanagementinterface 
        Allowed Management interfaces of the system users in the group. By default allowed from both API and CLI interfaces. If management interface for a group is set to API, then all users under this group will not allowed to access NS through CLI. GUI interface will come under API interface.  
        Default value: NS_INTERFACE_ALL  
        Possible values = CLI, API 
    .PARAMETER PassThru 
        Return details about the created systemgroup item.
    .EXAMPLE
        Invoke-ADCUpdateSystemgroup -groupname <string>
    .NOTES
        File Name : Invoke-ADCUpdateSystemgroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup/
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
        [string]$groupname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$promptstring ,

        [ValidateRange(300, 86400)]
        [double]$timeout ,

        [ValidateSet('CLI', 'API')]
        [string[]]$allowedmanagementinterface ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSystemgroup: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('promptstring')) { $Payload.Add('promptstring', $promptstring) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('allowedmanagementinterface')) { $Payload.Add('allowedmanagementinterface', $allowedmanagementinterface) }
 
            if ($PSCmdlet.ShouldProcess("systemgroup", "Update System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type systemgroup -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystemgroup -Filter $Payload)
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
        Unset System configuration Object
    .DESCRIPTION
        Unset System configuration Object 
   .PARAMETER groupname 
       Name for the group. Must begin with a letter, number, hash(#) or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the group is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group'). 
   .PARAMETER promptstring 
       String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables:  
       * %u - Will be replaced by the user name.  
       * %h - Will be replaced by the hostname of the Citrix ADC.  
       * %t - Will be replaced by the current time in 12-hour format.  
       * %T - Will be replaced by the current time in 24-hour format.  
       * %d - Will be replaced by the current date.  
       * %s - Will be replaced by the state of the Citrix ADC.  
       Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
   .PARAMETER timeout 
       CLI session inactivity timeout, in seconds. If Restrictedtimeout argument of system parameter is enabled, Timeout can have values in the ] seconds.If Restrictedtimeout argument of system parameter is disabled, Timeout can have values in the ] seconds. Default value is 900 seconds. 
   .PARAMETER allowedmanagementinterface 
       Allowed Management interfaces of the system users in the group. By default allowed from both API and CLI interfaces. If management interface for a group is set to API, then all users under this group will not allowed to access NS through CLI. GUI interface will come under API interface.  
       Possible values = CLI, API
    .EXAMPLE
        Invoke-ADCUnsetSystemgroup -groupname <string>
    .NOTES
        File Name : Invoke-ADCUnsetSystemgroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup
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
        [string]$groupname ,

        [Boolean]$promptstring ,

        [Boolean]$timeout ,

        [Boolean]$allowedmanagementinterface 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSystemgroup: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('promptstring')) { $Payload.Add('promptstring', $promptstring) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('allowedmanagementinterface')) { $Payload.Add('allowedmanagementinterface', $allowedmanagementinterface) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Unset System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemgroup -Action unset -Payload $Payload -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER groupname 
       Name for the group. Must begin with a letter, number, hash(#) or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the group is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group'). 
    .PARAMETER GetAll 
        Retreive all systemgroup object(s)
    .PARAMETER Count
        If specified, the count of the systemgroup object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemgroup
    .EXAMPLE 
        Invoke-ADCGetSystemgroup -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystemgroup -Count
    .EXAMPLE
        Invoke-ADCGetSystemgroup -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemgroup -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemgroup
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup/
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
        [string]$groupname,

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
        Write-Verbose "Invoke-ADCGetSystemgroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systemgroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemgroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemgroup objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemgroup configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemgroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER groupname 
       Name of the system group about which to display information. 
    .PARAMETER GetAll 
        Retreive all systemgroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the systemgroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemgroupbinding
    .EXAMPLE 
        Invoke-ADCGetSystemgroupbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetSystemgroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemgroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemgroupbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_binding/
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
        [string]$groupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemgroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all systemgroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemgroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemgroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemgroup_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_binding -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemgroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add System configuration Object
    .DESCRIPTION
        Add System configuration Object 
    .PARAMETER groupname 
        Name of the system group.  
        Minimum length = 1 
    .PARAMETER partitionname 
        Name of the Partition to bind to the system group.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created systemgroup_nspartition_binding item.
    .EXAMPLE
        Invoke-ADCAddSystemgroupnspartitionbinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddSystemgroupnspartitionbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_nspartition_binding/
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
        [string]$groupname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$partitionname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemgroupnspartitionbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('partitionname')) { $Payload.Add('partitionname', $partitionname) }
 
            if ($PSCmdlet.ShouldProcess("systemgroup_nspartition_binding", "Add System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type systemgroup_nspartition_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystemgroupnspartitionbinding -Filter $Payload)
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
    .PARAMETER groupname 
       Name of the system group.  
       Minimum length = 1    .PARAMETER partitionname 
       Name of the Partition to bind to the system group.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteSystemgroupnspartitionbinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteSystemgroupnspartitionbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_nspartition_binding/
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
        [string]$groupname ,

        [string]$partitionname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemgroupnspartitionbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('partitionname')) { $Arguments.Add('partitionname', $partitionname) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemgroup_nspartition_binding -Resource $groupname -Arguments $Arguments
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER groupname 
       Name of the system group. 
    .PARAMETER GetAll 
        Retreive all systemgroup_nspartition_binding object(s)
    .PARAMETER Count
        If specified, the count of the systemgroup_nspartition_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemgroupnspartitionbinding
    .EXAMPLE 
        Invoke-ADCGetSystemgroupnspartitionbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystemgroupnspartitionbinding -Count
    .EXAMPLE
        Invoke-ADCGetSystemgroupnspartitionbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemgroupnspartitionbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemgroupnspartitionbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_nspartition_binding/
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
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all systemgroup_nspartition_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_nspartition_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemgroup_nspartition_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_nspartition_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemgroup_nspartition_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_nspartition_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemgroup_nspartition_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_nspartition_binding -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemgroup_nspartition_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_nspartition_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add System configuration Object
    .DESCRIPTION
        Add System configuration Object 
    .PARAMETER groupname 
        Name of the system group.  
        Minimum length = 1 
    .PARAMETER policyname 
        The name of command policy. 
    .PARAMETER priority 
        The priority of the command policy. 
    .PARAMETER PassThru 
        Return details about the created systemgroup_systemcmdpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddSystemgroupsystemcmdpolicybinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddSystemgroupsystemcmdpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_systemcmdpolicy_binding/
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
        [string]$groupname ,

        [string]$policyname ,

        [double]$priority ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemgroupsystemcmdpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
 
            if ($PSCmdlet.ShouldProcess("systemgroup_systemcmdpolicy_binding", "Add System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type systemgroup_systemcmdpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystemgroupsystemcmdpolicybinding -Filter $Payload)
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
    .PARAMETER groupname 
       Name of the system group.  
       Minimum length = 1    .PARAMETER policyname 
       The name of command policy.
    .EXAMPLE
        Invoke-ADCDeleteSystemgroupsystemcmdpolicybinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteSystemgroupsystemcmdpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_systemcmdpolicy_binding/
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
        [string]$groupname ,

        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemgroupsystemcmdpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemgroup_systemcmdpolicy_binding -Resource $groupname -Arguments $Arguments
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER groupname 
       Name of the system group. 
    .PARAMETER GetAll 
        Retreive all systemgroup_systemcmdpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the systemgroup_systemcmdpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemgroupsystemcmdpolicybinding
    .EXAMPLE 
        Invoke-ADCGetSystemgroupsystemcmdpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystemgroupsystemcmdpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetSystemgroupsystemcmdpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemgroupsystemcmdpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemgroupsystemcmdpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_systemcmdpolicy_binding/
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
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all systemgroup_systemcmdpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemcmdpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemgroup_systemcmdpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemcmdpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemgroup_systemcmdpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemcmdpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemgroup_systemcmdpolicy_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemcmdpolicy_binding -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemgroup_systemcmdpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemcmdpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add System configuration Object
    .DESCRIPTION
        Add System configuration Object 
    .PARAMETER groupname 
        Name of the system group.  
        Minimum length = 1 
    .PARAMETER username 
        The system user. 
    .PARAMETER PassThru 
        Return details about the created systemgroup_systemuser_binding item.
    .EXAMPLE
        Invoke-ADCAddSystemgroupsystemuserbinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddSystemgroupsystemuserbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_systemuser_binding/
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
        [string]$groupname ,

        [string]$username ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemgroupsystemuserbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('username')) { $Payload.Add('username', $username) }
 
            if ($PSCmdlet.ShouldProcess("systemgroup_systemuser_binding", "Add System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type systemgroup_systemuser_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystemgroupsystemuserbinding -Filter $Payload)
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
    .PARAMETER groupname 
       Name of the system group.  
       Minimum length = 1    .PARAMETER username 
       The system user.
    .EXAMPLE
        Invoke-ADCDeleteSystemgroupsystemuserbinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteSystemgroupsystemuserbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_systemuser_binding/
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
        [string]$groupname ,

        [string]$username 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemgroupsystemuserbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('username')) { $Arguments.Add('username', $username) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemgroup_systemuser_binding -Resource $groupname -Arguments $Arguments
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER groupname 
       Name of the system group. 
    .PARAMETER GetAll 
        Retreive all systemgroup_systemuser_binding object(s)
    .PARAMETER Count
        If specified, the count of the systemgroup_systemuser_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemgroupsystemuserbinding
    .EXAMPLE 
        Invoke-ADCGetSystemgroupsystemuserbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystemgroupsystemuserbinding -Count
    .EXAMPLE
        Invoke-ADCGetSystemgroupsystemuserbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemgroupsystemuserbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemgroupsystemuserbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemgroup_systemuser_binding/
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
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all systemgroup_systemuser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemuser_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemgroup_systemuser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemuser_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemgroup_systemuser_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemuser_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemgroup_systemuser_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemuser_binding -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemgroup_systemuser_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemgroup_systemuser_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Check System configuration Object
    .DESCRIPTION
        Check System configuration Object 
    .PARAMETER diskcheck 
        Perform only disk error checking.
    .EXAMPLE
        Invoke-ADCCheckSystemhwerror -diskcheck <boolean>
    .NOTES
        File Name : Invoke-ADCCheckSystemhwerror
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemhwerror/
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
        [boolean]$diskcheck 

    )
    begin {
        Write-Verbose "Invoke-ADCCheckSystemhwerror: Starting"
    }
    process {
        try {
            $Payload = @{
                diskcheck = $diskcheck
            }

            if ($PSCmdlet.ShouldProcess($Name, "Check System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemhwerror -Action check -Payload $Payload -GetWarning
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
        Create System configuration Object
    .DESCRIPTION
        Create System configuration Object 
    .PARAMETER passphrase 
        Passphrase required to generate the key encryption key.
    .EXAMPLE
        Invoke-ADCCreateSystemkek -passphrase <string>
    .NOTES
        File Name : Invoke-ADCCreateSystemkek
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemkek/
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
        [ValidateLength(8, 32)]
        [string]$passphrase 

    )
    begin {
        Write-Verbose "Invoke-ADCCreateSystemkek: Starting"
    }
    process {
        try {
            $Payload = @{
                passphrase = $passphrase
            }

            if ($PSCmdlet.ShouldProcess($Name, "Create System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemkek -Action create -Payload $Payload -GetWarning
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
        Export System configuration Object
    .DESCRIPTION
        Export System configuration Object 
    .PARAMETER password 
        Password required to import the key encryption key.
    .EXAMPLE
        Invoke-ADCExportSystemkek 
    .NOTES
        File Name : Invoke-ADCExportSystemkek
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemkek/
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

        [ValidateLength(8, 32)]
        [string]$password 

    )
    begin {
        Write-Verbose "Invoke-ADCExportSystemkek: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSCmdlet.ShouldProcess($Name, "Export System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemkek -Action export -Payload $Payload -GetWarning
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
        Import System configuration Object
    .DESCRIPTION
        Import System configuration Object 
    .PARAMETER password 
        Password required to import the key encryption key.
    .EXAMPLE
        Invoke-ADCImportSystemkek 
    .NOTES
        File Name : Invoke-ADCImportSystemkek
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemkek/
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

        [ValidateLength(8, 32)]
        [string]$password 

    )
    begin {
        Write-Verbose "Invoke-ADCImportSystemkek: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSCmdlet.ShouldProcess($Name, "Import System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemkek -Action import -Payload $Payload -GetWarning
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
        Update System configuration Object
    .DESCRIPTION
        Update System configuration Object 
    .PARAMETER rbaonresponse 
        Enable or disable Role-Based Authentication (RBA) on responses.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables:  
        * %u - Will be replaced by the user name.  
        * %h - Will be replaced by the hostname of the Citrix ADC.  
        * %t - Will be replaced by the current time in 12-hour format.  
        * %T - Will be replaced by the current time in 24-hour format.  
        * %d - Will be replaced by the current date.  
        * %s - Will be replaced by the state of the Citrix ADC.  
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables.  
        Minimum length = 1 
    .PARAMETER natpcbforceflushlimit 
        Flush the system if the number of Network Address Translation Protocol Control Blocks (NATPCBs) exceeds this value.  
        Default value: 2147483647  
        Minimum value = 1000 
    .PARAMETER natpcbrstontimeout 
        Send a reset signal to client and server connections when their NATPCBs time out. Avoids the buildup of idle TCP connections on both the sides.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument is enabled, Timeout can have values in the range [300-86400] seconds.  
        If Restrictedtimeout argument is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER localauth 
        When enabled, local users can access Citrix ADC even when external authentication is configured. When disabled, local users are not allowed to access the Citrix ADC, Local users can access the Citrix ADC only when the configured external authentication servers are unavailable. This parameter is not applicable to SSH Key-based authentication.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER minpasswordlen 
        Minimum length of system user password. When strong password is enabled default minimum length is 4. User entered value can be greater than or equal to 4. Default mininum value is 1 when strong password is disabled. Maximum value is 127 in both cases.  
        Minimum value = 1  
        Maximum value = 127 
    .PARAMETER strongpassword 
        After enabling strong password (enableall / enablelocal - not included in exclude list), all the passwords / sensitive information must have - Atleast 1 Lower case character, Atleast 1 Upper case character, Atleast 1 numeric character, Atleast 1 special character ( ~, `, !, @, #, $, %, ^, ;, *, -, _, =, +, {, }, [, ], |, \, :, <, >, /, ., ,, " "). Exclude list in case of enablelocal is - NS_FIPS, NS_CRL, NS_RSAKEY, NS_PKCS12, NS_PKCS8, NS_LDAP, NS_TACACS, NS_TACACSACTION, NS_RADIUS, NS_RADIUSACTION, NS_ENCRYPTION_PARAMS. So no Strong Password checks will be performed on these ObjectType commands for enablelocal case.  
        Default value: disabled  
        Possible values = enableall, enablelocal, disabled 
    .PARAMETER restrictedtimeout 
        Enable/Disable the restricted timeout behaviour. When enabled, timeout cannot be configured beyond admin configured timeout and also it will have the [minimum - maximum] range check. When disabled, timeout will have the old behaviour. By default the value is disabled.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER fipsusermode 
        Use this option to set the FIPS mode for key user-land processes. When enabled, these user-land processes will operate in FIPS mode. In this mode, theses processes will use FIPS 140-2 Level-1 certified crypto algorithms. Default is disabled, wherein, these user-land processes will not operate in FIPS mode.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER doppler 
        Enable or disable Doppler.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER googleanalytics 
        Enable or disable Google analytics.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER totalauthtimeout 
        Total time a request can take for authentication/authorization.  
        Default value: 20  
        Minimum value = 5  
        Maximum value = 120 
    .PARAMETER cliloglevel 
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
        Default value: INFORMATIONAL  
        Possible values = EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
    .PARAMETER forcepasswordchange 
        Enable or disable force password change for nsroot user.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER basicauth 
        Enable or disable basic authentication for Nitro API.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER reauthonauthparamchange 
        Enable or disable External user reauthentication when authentication parameter changes.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER removesensitivefiles 
        Use this option to remove the sensitive files from the system like authorise keys, public keys etc. The commands which will remove sensitive files when this system paramter is enabled are rm cluster instance, rm cluster node, rm ha node, clear config full, join cluster and add cluster instance.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUpdateSystemparameter 
    .NOTES
        File Name : Invoke-ADCUpdateSystemparameter
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemparameter/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$rbaonresponse ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$promptstring ,

        [double]$natpcbforceflushlimit ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$natpcbrstontimeout ,

        [ValidateRange(300, 86400)]
        [double]$timeout ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$localauth ,

        [ValidateRange(1, 127)]
        [double]$minpasswordlen ,

        [ValidateSet('enableall', 'enablelocal', 'disabled')]
        [string]$strongpassword ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$restrictedtimeout ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$fipsusermode ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$doppler ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$googleanalytics ,

        [ValidateRange(5, 120)]
        [double]$totalauthtimeout ,

        [ValidateSet('EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG')]
        [string]$cliloglevel ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$forcepasswordchange ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$basicauth ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$reauthonauthparamchange ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$removesensitivefiles 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSystemparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('rbaonresponse')) { $Payload.Add('rbaonresponse', $rbaonresponse) }
            if ($PSBoundParameters.ContainsKey('promptstring')) { $Payload.Add('promptstring', $promptstring) }
            if ($PSBoundParameters.ContainsKey('natpcbforceflushlimit')) { $Payload.Add('natpcbforceflushlimit', $natpcbforceflushlimit) }
            if ($PSBoundParameters.ContainsKey('natpcbrstontimeout')) { $Payload.Add('natpcbrstontimeout', $natpcbrstontimeout) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('localauth')) { $Payload.Add('localauth', $localauth) }
            if ($PSBoundParameters.ContainsKey('minpasswordlen')) { $Payload.Add('minpasswordlen', $minpasswordlen) }
            if ($PSBoundParameters.ContainsKey('strongpassword')) { $Payload.Add('strongpassword', $strongpassword) }
            if ($PSBoundParameters.ContainsKey('restrictedtimeout')) { $Payload.Add('restrictedtimeout', $restrictedtimeout) }
            if ($PSBoundParameters.ContainsKey('fipsusermode')) { $Payload.Add('fipsusermode', $fipsusermode) }
            if ($PSBoundParameters.ContainsKey('doppler')) { $Payload.Add('doppler', $doppler) }
            if ($PSBoundParameters.ContainsKey('googleanalytics')) { $Payload.Add('googleanalytics', $googleanalytics) }
            if ($PSBoundParameters.ContainsKey('totalauthtimeout')) { $Payload.Add('totalauthtimeout', $totalauthtimeout) }
            if ($PSBoundParameters.ContainsKey('cliloglevel')) { $Payload.Add('cliloglevel', $cliloglevel) }
            if ($PSBoundParameters.ContainsKey('forcepasswordchange')) { $Payload.Add('forcepasswordchange', $forcepasswordchange) }
            if ($PSBoundParameters.ContainsKey('basicauth')) { $Payload.Add('basicauth', $basicauth) }
            if ($PSBoundParameters.ContainsKey('reauthonauthparamchange')) { $Payload.Add('reauthonauthparamchange', $reauthonauthparamchange) }
            if ($PSBoundParameters.ContainsKey('removesensitivefiles')) { $Payload.Add('removesensitivefiles', $removesensitivefiles) }
 
            if ($PSCmdlet.ShouldProcess("systemparameter", "Update System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type systemparameter -Payload $Payload -GetWarning
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
        Unset System configuration Object
    .DESCRIPTION
        Unset System configuration Object 
   .PARAMETER minpasswordlen 
       Minimum length of system user password. When strong password is enabled default minimum length is 4. User entered value can be greater than or equal to 4. Default mininum value is 1 when strong password is disabled. Maximum value is 127 in both cases. 
   .PARAMETER rbaonresponse 
       Enable or disable Role-Based Authentication (RBA) on responses.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER promptstring 
       String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables:  
       * %u - Will be replaced by the user name.  
       * %h - Will be replaced by the hostname of the Citrix ADC.  
       * %t - Will be replaced by the current time in 12-hour format.  
       * %T - Will be replaced by the current time in 24-hour format.  
       * %d - Will be replaced by the current date.  
       * %s - Will be replaced by the state of the Citrix ADC.  
       Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
   .PARAMETER natpcbforceflushlimit 
       Flush the system if the number of Network Address Translation Protocol Control Blocks (NATPCBs) exceeds this value. 
   .PARAMETER natpcbrstontimeout 
       Send a reset signal to client and server connections when their NATPCBs time out. Avoids the buildup of idle TCP connections on both the sides.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER timeout 
       CLI session inactivity timeout, in seconds. If Restrictedtimeout argument is enabled, Timeout can have values in the ] seconds.  
       If Restrictedtimeout argument is disabled, Timeout can have values in the ] seconds. Default value is 900 seconds. 
   .PARAMETER localauth 
       When enabled, local users can access Citrix ADC even when external authentication is configured. When disabled, local users are not allowed to access the Citrix ADC, Local users can access the Citrix ADC only when the configured external authentication servers are unavailable. This parameter is not applicable to SSH Key-based authentication.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER strongpassword 
       After enabling strong password (enableall / enablelocal - not included in exclude list), all the passwords / sensitive information must have - Atleast 1 Lower case character, Atleast 1 Upper case character, Atleast 1 numeric character, Atleast 1 special character ( ~, `, !, @, #, $, %, ^, ;, *, -, _, =, +, {, }, [, ], |, \, :, <, >, /, ., ,, " "). Exclude list in case of enablelocal is - NS_FIPS, NS_CRL, NS_RSAKEY, NS_PKCS12, NS_PKCS8, NS_LDAP, NS_TACACS, NS_TACACSACTION, NS_RADIUS, NS_RADIUSACTION, NS_ENCRYPTION_PARAMS. So no Strong Password checks will be performed on these ObjectType commands for enablelocal case.  
       Possible values = enableall, enablelocal, disabled 
   .PARAMETER restrictedtimeout 
       Enable/Disable the restricted timeout behaviour. When enabled, timeout cannot be configured beyond admin configured timeout and also it will have the [minimum - maximum] range check. When disabled, timeout will have the old behaviour. By default the value is disabled.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER fipsusermode 
       Use this option to set the FIPS mode for key user-land processes. When enabled, these user-land processes will operate in FIPS mode. In this mode, theses processes will use FIPS 140-2 Level-1 certified crypto algorithms. Default is disabled, wherein, these user-land processes will not operate in FIPS mode.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER doppler 
       Enable or disable Doppler.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER googleanalytics 
       Enable or disable Google analytics.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER totalauthtimeout 
       Total time a request can take for authentication/authorization. 
   .PARAMETER cliloglevel 
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
   .PARAMETER forcepasswordchange 
       Enable or disable force password change for nsroot user.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER basicauth 
       Enable or disable basic authentication for Nitro API.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER reauthonauthparamchange 
       Enable or disable External user reauthentication when authentication parameter changes.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER removesensitivefiles 
       Use this option to remove the sensitive files from the system like authorise keys, public keys etc. The commands which will remove sensitive files when this system paramter is enabled are rm cluster instance, rm cluster node, rm ha node, clear config full, join cluster and add cluster instance.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetSystemparameter 
    .NOTES
        File Name : Invoke-ADCUnsetSystemparameter
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemparameter
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

        [Boolean]$minpasswordlen ,

        [Boolean]$rbaonresponse ,

        [Boolean]$promptstring ,

        [Boolean]$natpcbforceflushlimit ,

        [Boolean]$natpcbrstontimeout ,

        [Boolean]$timeout ,

        [Boolean]$localauth ,

        [Boolean]$strongpassword ,

        [Boolean]$restrictedtimeout ,

        [Boolean]$fipsusermode ,

        [Boolean]$doppler ,

        [Boolean]$googleanalytics ,

        [Boolean]$totalauthtimeout ,

        [Boolean]$cliloglevel ,

        [Boolean]$forcepasswordchange ,

        [Boolean]$basicauth ,

        [Boolean]$reauthonauthparamchange ,

        [Boolean]$removesensitivefiles 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSystemparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('minpasswordlen')) { $Payload.Add('minpasswordlen', $minpasswordlen) }
            if ($PSBoundParameters.ContainsKey('rbaonresponse')) { $Payload.Add('rbaonresponse', $rbaonresponse) }
            if ($PSBoundParameters.ContainsKey('promptstring')) { $Payload.Add('promptstring', $promptstring) }
            if ($PSBoundParameters.ContainsKey('natpcbforceflushlimit')) { $Payload.Add('natpcbforceflushlimit', $natpcbforceflushlimit) }
            if ($PSBoundParameters.ContainsKey('natpcbrstontimeout')) { $Payload.Add('natpcbrstontimeout', $natpcbrstontimeout) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('localauth')) { $Payload.Add('localauth', $localauth) }
            if ($PSBoundParameters.ContainsKey('strongpassword')) { $Payload.Add('strongpassword', $strongpassword) }
            if ($PSBoundParameters.ContainsKey('restrictedtimeout')) { $Payload.Add('restrictedtimeout', $restrictedtimeout) }
            if ($PSBoundParameters.ContainsKey('fipsusermode')) { $Payload.Add('fipsusermode', $fipsusermode) }
            if ($PSBoundParameters.ContainsKey('doppler')) { $Payload.Add('doppler', $doppler) }
            if ($PSBoundParameters.ContainsKey('googleanalytics')) { $Payload.Add('googleanalytics', $googleanalytics) }
            if ($PSBoundParameters.ContainsKey('totalauthtimeout')) { $Payload.Add('totalauthtimeout', $totalauthtimeout) }
            if ($PSBoundParameters.ContainsKey('cliloglevel')) { $Payload.Add('cliloglevel', $cliloglevel) }
            if ($PSBoundParameters.ContainsKey('forcepasswordchange')) { $Payload.Add('forcepasswordchange', $forcepasswordchange) }
            if ($PSBoundParameters.ContainsKey('basicauth')) { $Payload.Add('basicauth', $basicauth) }
            if ($PSBoundParameters.ContainsKey('reauthonauthparamchange')) { $Payload.Add('reauthonauthparamchange', $reauthonauthparamchange) }
            if ($PSBoundParameters.ContainsKey('removesensitivefiles')) { $Payload.Add('removesensitivefiles', $removesensitivefiles) }
            if ($PSCmdlet.ShouldProcess("systemparameter", "Unset System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemparameter -Action unset -Payload $Payload -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER GetAll 
        Retreive all systemparameter object(s)
    .PARAMETER Count
        If specified, the count of the systemparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemparameter
    .EXAMPLE 
        Invoke-ADCGetSystemparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetSystemparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemparameter
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemparameter/
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
        Write-Verbose "Invoke-ADCGetSystemparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systemparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemparameter -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemparameter -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemparameter -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemparameter -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Create System configuration Object
    .DESCRIPTION
        Create System configuration Object 
    .PARAMETER filename 
        Name of the restore point.
    .EXAMPLE
        Invoke-ADCCreateSystemrestorepoint -filename <string>
    .NOTES
        File Name : Invoke-ADCCreateSystemrestorepoint
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemrestorepoint/
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
        [ValidateLength(1, 63)]
        [string]$filename 

    )
    begin {
        Write-Verbose "Invoke-ADCCreateSystemrestorepoint: Starting"
    }
    process {
        try {
            $Payload = @{
                filename = $filename
            }

            if ($PSCmdlet.ShouldProcess($Name, "Create System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemrestorepoint -Action create -Payload $Payload -GetWarning
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
    .PARAMETER filename 
       Name of the restore point.  
       Minimum length = 1  
       Maximum length = 63 
    .EXAMPLE
        Invoke-ADCDeleteSystemrestorepoint -filename <string>
    .NOTES
        File Name : Invoke-ADCDeleteSystemrestorepoint
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemrestorepoint/
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
        [string]$filename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemrestorepoint: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$filename", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemrestorepoint -Resource $filename -Arguments $Arguments
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER filename 
       Name of the restore point. 
    .PARAMETER GetAll 
        Retreive all systemrestorepoint object(s)
    .PARAMETER Count
        If specified, the count of the systemrestorepoint object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemrestorepoint
    .EXAMPLE 
        Invoke-ADCGetSystemrestorepoint -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystemrestorepoint -Count
    .EXAMPLE
        Invoke-ADCGetSystemrestorepoint -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemrestorepoint -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemrestorepoint
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemrestorepoint/
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
        [ValidateLength(1, 63)]
        [string]$filename,

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
        Write-Verbose "Invoke-ADCGetSystemrestorepoint: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systemrestorepoint objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemrestorepoint -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemrestorepoint objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemrestorepoint -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemrestorepoint objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemrestorepoint -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemrestorepoint configuration for property 'filename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemrestorepoint -Resource $filename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemrestorepoint configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemrestorepoint -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Kill System configuration Object
    .DESCRIPTION
        Kill System configuration Object 
    .PARAMETER sid 
        ID of the system session about which to display information. 
    .PARAMETER all 
        Terminate all the system sessions except the current session.
    .EXAMPLE
        Invoke-ADCKillSystemsession 
    .NOTES
        File Name : Invoke-ADCKillSystemsession
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemsession/
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

        [double]$sid ,

        [boolean]$all 

    )
    begin {
        Write-Verbose "Invoke-ADCKillSystemsession: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('sid')) { $Payload.Add('sid', $sid) }
            if ($PSBoundParameters.ContainsKey('all')) { $Payload.Add('all', $all) }
            if ($PSCmdlet.ShouldProcess($Name, "Kill System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemsession -Action kill -Payload $Payload -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER sid 
       ID of the system session about which to display information. 
    .PARAMETER GetAll 
        Retreive all systemsession object(s)
    .PARAMETER Count
        If specified, the count of the systemsession object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemsession
    .EXAMPLE 
        Invoke-ADCGetSystemsession -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystemsession -Count
    .EXAMPLE
        Invoke-ADCGetSystemsession -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemsession -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemsession
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemsession/
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
        [double]$sid,

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
        Write-Verbose "Invoke-ADCGetSystemsession: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systemsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemsession -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemsession -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemsession objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemsession -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemsession configuration for property 'sid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemsession -Resource $sid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemsession configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemsession -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
    .PARAMETER name 
       URL \(protocol, host, path, and file name\) from where the location file will be imported.  
       NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access.  
       Minimum length = 1  
       Maximum length = 255    .PARAMETER sshkeytype 
       The type of the ssh key whether public or private key.  
       Possible values = PRIVATE, PUBLIC
    .EXAMPLE
        Invoke-ADCDeleteSystemsshkey -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteSystemsshkey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemsshkey/
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

        [string]$sshkeytype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemsshkey: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('sshkeytype')) { $Arguments.Add('sshkeytype', $sshkeytype) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemsshkey -Resource $name -Arguments $Arguments
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
        Import System configuration Object
    .DESCRIPTION
        Import System configuration Object 
    .PARAMETER name 
        URL \(protocol, host, path, and file name\) from where the location file will be imported.  
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER src 
        URL \(protocol, host, path, and file name\) from where the location file will be imported.  
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER sshkeytype 
        The type of the ssh key whether public or private key.  
        Possible values = PRIVATE, PUBLIC
    .EXAMPLE
        Invoke-ADCImportSystemsshkey -name <string> -src <string> -sshkeytype <string>
    .NOTES
        File Name : Invoke-ADCImportSystemsshkey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemsshkey/
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
        [ValidateLength(1, 255)]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 2047)]
        [string]$src ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('PRIVATE', 'PUBLIC')]
        [string]$sshkeytype 

    )
    begin {
        Write-Verbose "Invoke-ADCImportSystemsshkey: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                src = $src
                sshkeytype = $sshkeytype
            }

            if ($PSCmdlet.ShouldProcess($Name, "Import System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemsshkey -Action import -Payload $Payload -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER sshkeytype 
       The type of the ssh key whether public or private key.  
       Possible values = PRIVATE, PUBLIC 
    .PARAMETER GetAll 
        Retreive all systemsshkey object(s)
    .PARAMETER Count
        If specified, the count of the systemsshkey object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemsshkey
    .EXAMPLE 
        Invoke-ADCGetSystemsshkey -GetAll
    .EXAMPLE
        Invoke-ADCGetSystemsshkey -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemsshkey -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemsshkey
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemsshkey/
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
        [ValidateSet('PRIVATE', 'PUBLIC')]
        [string]$sshkeytype,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemsshkey: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systemsshkey objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemsshkey -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemsshkey objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemsshkey -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemsshkey objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('sshkeytype')) { $Arguments.Add('sshkeytype', $sshkeytype) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemsshkey -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemsshkey configuration for property ''"

            } else {
                Write-Verbose "Retrieving systemsshkey configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemsshkey -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add System configuration Object
    .DESCRIPTION
        Add System configuration Object 
    .PARAMETER username 
        Name for a user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the user is added.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my user" or 'my user').  
        Minimum length = 1 
    .PARAMETER password 
        Password for the system user. Can include any ASCII character.  
        Minimum length = 1 
    .PARAMETER externalauth 
        Whether to use external authentication servers for the system user authentication or not.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables:  
        * %u - Will be replaced by the user name.  
        * %h - Will be replaced by the hostname of the Citrix ADC.  
        * %t - Will be replaced by the current time in 12-hour format.  
        * %T - Will be replaced by the current time in 24-hour format.  
        * %d - Will be replaced by the current date.  
        * %s - Will be replaced by the state of the Citrix ADC.  
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables.  
        Minimum length = 1 
    .PARAMETER timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument of system parameter is enabled, Timeout can have values in the range [300-86400] seconds. If Restrictedtimeout argument of system parameter is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER logging 
        Users logging privilege.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER maxsession 
        Maximum number of client connection allowed per user.  
        Default value: 20  
        Minimum value = 1  
        Maximum value = 40 
    .PARAMETER allowedmanagementinterface 
        Allowed Management interfaces to the system user. By default user is allowed from both API and CLI interfaces. If management interface for a user is set to API, then user is not allowed to access NS through CLI. GUI interface will come under API interface.  
        Default value: NS_INTERFACE_ALL  
        Possible values = CLI, API 
    .PARAMETER PassThru 
        Return details about the created systemuser item.
    .EXAMPLE
        Invoke-ADCAddSystemuser -username <string> -password <string>
    .NOTES
        File Name : Invoke-ADCAddSystemuser
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser/
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
        [string]$username ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$externalauth = 'ENABLED' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$promptstring ,

        [ValidateRange(300, 86400)]
        [double]$timeout ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logging = 'DISABLED' ,

        [ValidateRange(1, 40)]
        [double]$maxsession = '20' ,

        [ValidateSet('CLI', 'API')]
        [string[]]$allowedmanagementinterface = 'NS_INTERFACE_ALL' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemuser: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
                password = $password
            }
            if ($PSBoundParameters.ContainsKey('externalauth')) { $Payload.Add('externalauth', $externalauth) }
            if ($PSBoundParameters.ContainsKey('promptstring')) { $Payload.Add('promptstring', $promptstring) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('logging')) { $Payload.Add('logging', $logging) }
            if ($PSBoundParameters.ContainsKey('maxsession')) { $Payload.Add('maxsession', $maxsession) }
            if ($PSBoundParameters.ContainsKey('allowedmanagementinterface')) { $Payload.Add('allowedmanagementinterface', $allowedmanagementinterface) }
 
            if ($PSCmdlet.ShouldProcess("systemuser", "Add System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemuser -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystemuser -Filter $Payload)
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
    .PARAMETER username 
       Name for a user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the user is added.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my user" or 'my user').  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteSystemuser -username <string>
    .NOTES
        File Name : Invoke-ADCDeleteSystemuser
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser/
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
        [string]$username 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemuser: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$username", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemuser -Resource $username -Arguments $Arguments
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
        Update System configuration Object
    .DESCRIPTION
        Update System configuration Object 
    .PARAMETER username 
        Name for a user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the user is added.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my user" or 'my user').  
        Minimum length = 1 
    .PARAMETER password 
        Password for the system user. Can include any ASCII character.  
        Minimum length = 1 
    .PARAMETER externalauth 
        Whether to use external authentication servers for the system user authentication or not.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER promptstring 
        String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables:  
        * %u - Will be replaced by the user name.  
        * %h - Will be replaced by the hostname of the Citrix ADC.  
        * %t - Will be replaced by the current time in 12-hour format.  
        * %T - Will be replaced by the current time in 24-hour format.  
        * %d - Will be replaced by the current date.  
        * %s - Will be replaced by the state of the Citrix ADC.  
        Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables.  
        Minimum length = 1 
    .PARAMETER timeout 
        CLI session inactivity timeout, in seconds. If Restrictedtimeout argument of system parameter is enabled, Timeout can have values in the range [300-86400] seconds. If Restrictedtimeout argument of system parameter is disabled, Timeout can have values in the range [0, 10-100000000] seconds. Default value is 900 seconds. 
    .PARAMETER logging 
        Users logging privilege.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER maxsession 
        Maximum number of client connection allowed per user.  
        Default value: 20  
        Minimum value = 1  
        Maximum value = 40 
    .PARAMETER allowedmanagementinterface 
        Allowed Management interfaces to the system user. By default user is allowed from both API and CLI interfaces. If management interface for a user is set to API, then user is not allowed to access NS through CLI. GUI interface will come under API interface.  
        Default value: NS_INTERFACE_ALL  
        Possible values = CLI, API 
    .PARAMETER PassThru 
        Return details about the created systemuser item.
    .EXAMPLE
        Invoke-ADCUpdateSystemuser -username <string>
    .NOTES
        File Name : Invoke-ADCUpdateSystemuser
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser/
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
        [string]$username ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$externalauth ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$promptstring ,

        [ValidateRange(300, 86400)]
        [double]$timeout ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logging ,

        [ValidateRange(1, 40)]
        [double]$maxsession ,

        [ValidateSet('CLI', 'API')]
        [string[]]$allowedmanagementinterface ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSystemuser: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSBoundParameters.ContainsKey('externalauth')) { $Payload.Add('externalauth', $externalauth) }
            if ($PSBoundParameters.ContainsKey('promptstring')) { $Payload.Add('promptstring', $promptstring) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('logging')) { $Payload.Add('logging', $logging) }
            if ($PSBoundParameters.ContainsKey('maxsession')) { $Payload.Add('maxsession', $maxsession) }
            if ($PSBoundParameters.ContainsKey('allowedmanagementinterface')) { $Payload.Add('allowedmanagementinterface', $allowedmanagementinterface) }
 
            if ($PSCmdlet.ShouldProcess("systemuser", "Update System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type systemuser -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystemuser -Filter $Payload)
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
        Unset System configuration Object
    .DESCRIPTION
        Unset System configuration Object 
   .PARAMETER allowedmanagementinterface 
       Allowed Management interfaces to the system user. By default user is allowed from both API and CLI interfaces. If management interface for a user is set to API, then user is not allowed to access NS through CLI. GUI interface will come under API interface.  
       Possible values = CLI, API 
   .PARAMETER username 
       Name for a user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the user is added.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my user" or 'my user'). 
   .PARAMETER externalauth 
       Whether to use external authentication servers for the system user authentication or not.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER promptstring 
       String to display at the command-line prompt. Can consist of letters, numbers, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), underscore (_), and the following variables:  
       * %u - Will be replaced by the user name.  
       * %h - Will be replaced by the hostname of the Citrix ADC.  
       * %t - Will be replaced by the current time in 12-hour format.  
       * %T - Will be replaced by the current time in 24-hour format.  
       * %d - Will be replaced by the current date.  
       * %s - Will be replaced by the state of the Citrix ADC.  
       Note: The 63-character limit for the length of the string does not apply to the characters that replace the variables. 
   .PARAMETER timeout 
       CLI session inactivity timeout, in seconds. If Restrictedtimeout argument of system parameter is enabled, Timeout can have values in the ] seconds. If Restrictedtimeout argument of system parameter is disabled, Timeout can have values in the ] seconds. Default value is 900 seconds. 
   .PARAMETER logging 
       Users logging privilege.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER maxsession 
       Maximum number of client connection allowed per user.
    .EXAMPLE
        Invoke-ADCUnsetSystemuser -username <string>
    .NOTES
        File Name : Invoke-ADCUnsetSystemuser
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser
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

        [Boolean]$allowedmanagementinterface ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$username ,

        [Boolean]$externalauth ,

        [Boolean]$promptstring ,

        [Boolean]$timeout ,

        [Boolean]$logging ,

        [Boolean]$maxsession 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSystemuser: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('allowedmanagementinterface')) { $Payload.Add('allowedmanagementinterface', $allowedmanagementinterface) }
            if ($PSBoundParameters.ContainsKey('externalauth')) { $Payload.Add('externalauth', $externalauth) }
            if ($PSBoundParameters.ContainsKey('promptstring')) { $Payload.Add('promptstring', $promptstring) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('logging')) { $Payload.Add('logging', $logging) }
            if ($PSBoundParameters.ContainsKey('maxsession')) { $Payload.Add('maxsession', $maxsession) }
            if ($PSCmdlet.ShouldProcess("$username", "Unset System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systemuser -Action unset -Payload $Payload -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER username 
       Name for a user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. Cannot be changed after the user is added.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my user" or 'my user'). 
    .PARAMETER GetAll 
        Retreive all systemuser object(s)
    .PARAMETER Count
        If specified, the count of the systemuser object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemuser
    .EXAMPLE 
        Invoke-ADCGetSystemuser -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystemuser -Count
    .EXAMPLE
        Invoke-ADCGetSystemuser -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemuser -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemuser
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser/
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
        [string]$username,

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
        Write-Verbose "Invoke-ADCGetSystemuser: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all systemuser objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemuser objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemuser objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemuser configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemuser configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER username 
       Name of a system user about whom to display information. 
    .PARAMETER GetAll 
        Retreive all systemuser_binding object(s)
    .PARAMETER Count
        If specified, the count of the systemuser_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemuserbinding
    .EXAMPLE 
        Invoke-ADCGetSystemuserbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetSystemuserbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemuserbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemuserbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser_binding/
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
        [string]$username,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemuserbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all systemuser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemuser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemuser_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemuser_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_binding -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemuser_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add System configuration Object
    .DESCRIPTION
        Add System configuration Object 
    .PARAMETER username 
        Name of the system-user entry to which to bind the command policy.  
        Minimum length = 1 
    .PARAMETER partitionname 
        Name of the Partition to bind to the system user. 
    .PARAMETER PassThru 
        Return details about the created systemuser_nspartition_binding item.
    .EXAMPLE
        Invoke-ADCAddSystemusernspartitionbinding -username <string>
    .NOTES
        File Name : Invoke-ADCAddSystemusernspartitionbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser_nspartition_binding/
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
        [string]$username ,

        [string]$partitionname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemusernspartitionbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('partitionname')) { $Payload.Add('partitionname', $partitionname) }
 
            if ($PSCmdlet.ShouldProcess("systemuser_nspartition_binding", "Add System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type systemuser_nspartition_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystemusernspartitionbinding -Filter $Payload)
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
    .PARAMETER username 
       Name of the system-user entry to which to bind the command policy.  
       Minimum length = 1    .PARAMETER partitionname 
       Name of the Partition to bind to the system user.
    .EXAMPLE
        Invoke-ADCDeleteSystemusernspartitionbinding -username <string>
    .NOTES
        File Name : Invoke-ADCDeleteSystemusernspartitionbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser_nspartition_binding/
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
        [string]$username ,

        [string]$partitionname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemusernspartitionbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('partitionname')) { $Arguments.Add('partitionname', $partitionname) }
            if ($PSCmdlet.ShouldProcess("$username", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemuser_nspartition_binding -Resource $username -Arguments $Arguments
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER username 
       Name of the system-user entry to which to bind the command policy. 
    .PARAMETER GetAll 
        Retreive all systemuser_nspartition_binding object(s)
    .PARAMETER Count
        If specified, the count of the systemuser_nspartition_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemusernspartitionbinding
    .EXAMPLE 
        Invoke-ADCGetSystemusernspartitionbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystemusernspartitionbinding -Count
    .EXAMPLE
        Invoke-ADCGetSystemusernspartitionbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemusernspartitionbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemusernspartitionbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser_nspartition_binding/
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
        [string]$username,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all systemuser_nspartition_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_nspartition_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemuser_nspartition_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_nspartition_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemuser_nspartition_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_nspartition_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemuser_nspartition_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_nspartition_binding -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemuser_nspartition_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_nspartition_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add System configuration Object
    .DESCRIPTION
        Add System configuration Object 
    .PARAMETER username 
        Name of the system-user entry to which to bind the command policy.  
        Minimum length = 1 
    .PARAMETER policyname 
        The name of command policy. 
    .PARAMETER priority 
        The priority of the policy. 
    .PARAMETER PassThru 
        Return details about the created systemuser_systemcmdpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddSystemusersystemcmdpolicybinding -username <string>
    .NOTES
        File Name : Invoke-ADCAddSystemusersystemcmdpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser_systemcmdpolicy_binding/
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
        [string]$username ,

        [string]$policyname ,

        [double]$priority ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemusersystemcmdpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
 
            if ($PSCmdlet.ShouldProcess("systemuser_systemcmdpolicy_binding", "Add System configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type systemuser_systemcmdpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSystemusersystemcmdpolicybinding -Filter $Payload)
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
        Delete System configuration Object
    .DESCRIPTION
        Delete System configuration Object
    .PARAMETER username 
       Name of the system-user entry to which to bind the command policy.  
       Minimum length = 1    .PARAMETER policyname 
       The name of command policy.
    .EXAMPLE
        Invoke-ADCDeleteSystemusersystemcmdpolicybinding -username <string>
    .NOTES
        File Name : Invoke-ADCDeleteSystemusersystemcmdpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser_systemcmdpolicy_binding/
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
        [string]$username ,

        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemusersystemcmdpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSCmdlet.ShouldProcess("$username", "Delete System configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemuser_systemcmdpolicy_binding -Resource $username -Arguments $Arguments
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER username 
       Name of the system-user entry to which to bind the command policy. 
    .PARAMETER GetAll 
        Retreive all systemuser_systemcmdpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the systemuser_systemcmdpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemusersystemcmdpolicybinding
    .EXAMPLE 
        Invoke-ADCGetSystemusersystemcmdpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystemusersystemcmdpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetSystemusersystemcmdpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemusersystemcmdpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemusersystemcmdpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser_systemcmdpolicy_binding/
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
        [string]$username,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all systemuser_systemcmdpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemcmdpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemuser_systemcmdpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemcmdpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemuser_systemcmdpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemcmdpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemuser_systemcmdpolicy_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemcmdpolicy_binding -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemuser_systemcmdpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemcmdpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get System configuration object(s)
    .DESCRIPTION
        Get System configuration object(s)
    .PARAMETER username 
       Name of the system-user entry to which to bind the command policy. 
    .PARAMETER GetAll 
        Retreive all systemuser_systemgroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the systemuser_systemgroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSystemusersystemgroupbinding
    .EXAMPLE 
        Invoke-ADCGetSystemusersystemgroupbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSystemusersystemgroupbinding -Count
    .EXAMPLE
        Invoke-ADCGetSystemusersystemgroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSystemusersystemgroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSystemusersystemgroupbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemuser_systemgroup_binding/
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
        [string]$username,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all systemuser_systemgroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemgroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for systemuser_systemgroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemgroup_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving systemuser_systemgroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemgroup_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving systemuser_systemgroup_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemgroup_binding -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving systemuser_systemgroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemuser_systemgroup_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


