function Invoke-ADCImportApplication {
<#
    .SYNOPSIS
        Import App configuration Object
    .DESCRIPTION
        Import App configuration Object 
    .PARAMETER apptemplatefilename 
        Name of the AppExpert application template file. 
    .PARAMETER appname 
        Name to assign to the application on the Citrix ADC. If you do not provide a name, the appliance assigns the application the name of the template file. 
    .PARAMETER deploymentfilename 
        Name of the deployment file.
    .EXAMPLE
        Invoke-ADCImportApplication -apptemplatefilename <string>
    .NOTES
        File Name : Invoke-ADCImportApplication
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/app/application/
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
        [string]$apptemplatefilename ,

        [string]$appname ,

        [string]$deploymentfilename 

    )
    begin {
        Write-Verbose "Invoke-ADCImportApplication: Starting"
    }
    process {
        try {
            $Payload = @{
                apptemplatefilename = $apptemplatefilename
            }
            if ($PSBoundParameters.ContainsKey('appname')) { $Payload.Add('appname', $appname) }
            if ($PSBoundParameters.ContainsKey('deploymentfilename')) { $Payload.Add('deploymentfilename', $deploymentfilename) }
            if ($PSCmdlet.ShouldProcess($Name, "Import App configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type application -Action import -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportApplication: Finished"
    }
}

function Invoke-ADCExportApplication {
<#
    .SYNOPSIS
        Export App configuration Object
    .DESCRIPTION
        Export App configuration Object 
    .PARAMETER appname 
        Name to assign to the application on the Citrix ADC. If you do not provide a name, the appliance assigns the application the name of the template file. 
    .PARAMETER apptemplatefilename 
        Name of the AppExpert application template file. 
    .PARAMETER deploymentfilename 
        Name of the deployment file.
    .EXAMPLE
        Invoke-ADCExportApplication -appname <string>
    .NOTES
        File Name : Invoke-ADCExportApplication
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/app/application/
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
        [string]$appname ,

        [string]$apptemplatefilename ,

        [string]$deploymentfilename 

    )
    begin {
        Write-Verbose "Invoke-ADCExportApplication: Starting"
    }
    process {
        try {
            $Payload = @{
                appname = $appname
            }
            if ($PSBoundParameters.ContainsKey('apptemplatefilename')) { $Payload.Add('apptemplatefilename', $apptemplatefilename) }
            if ($PSBoundParameters.ContainsKey('deploymentfilename')) { $Payload.Add('deploymentfilename', $deploymentfilename) }
            if ($PSCmdlet.ShouldProcess($Name, "Export App configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type application -Action export -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCExportApplication: Finished"
    }
}

function Invoke-ADCDeleteApplication {
<#
    .SYNOPSIS
        Delete App configuration Object
    .DESCRIPTION
        Delete App configuration Object
     .PARAMETER appname 
       Name to assign to the application on the Citrix ADC. If you do not provide a name, the appliance assigns the application the name of the template file.
    .EXAMPLE
        Invoke-ADCDeleteApplication 
    .NOTES
        File Name : Invoke-ADCDeleteApplication
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/app/application/
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

        [string]$appname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteApplication: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('appname')) { $Arguments.Add('appname', $appname) }
            if ($PSCmdlet.ShouldProcess("application", "Delete App configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type application -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteApplication: Finished"
    }
}


