function Invoke-ADCImportApplication {
    <#
    .SYNOPSIS
        Import App configuration Object.
    .DESCRIPTION
        Configuration for application resource.
    .PARAMETER Apptemplatefilename 
        Name of the AppExpert application template file. 
    .PARAMETER Appname 
        Name to assign to the application on the Citrix ADC. If you do not provide a name, the appliance assigns the application the name of the template file. 
    .PARAMETER Deploymentfilename 
        Name of the deployment file.
    .EXAMPLE
        PS C:\>Invoke-ADCImportApplication -apptemplatefilename <string>
        An example how to import application configuration Object(s).
    .NOTES
        File Name : Invoke-ADCImportApplication
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/app/application/
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
        [string]$Apptemplatefilename,

        [string]$Appname,

        [string]$Deploymentfilename 

    )
    begin {
        Write-Verbose "Invoke-ADCImportApplication: Starting"
    }
    process {
        try {
            $payload = @{ apptemplatefilename = $apptemplatefilename }
            if ( $PSBoundParameters.ContainsKey('appname') ) { $payload.Add('appname', $appname) }
            if ( $PSBoundParameters.ContainsKey('deploymentfilename') ) { $payload.Add('deploymentfilename', $deploymentfilename) }
            if ( $PSCmdlet.ShouldProcess($Name, "Import App configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type application -Action import -Payload $payload -GetWarning
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
        Export App configuration Object.
    .DESCRIPTION
        Configuration for application resource.
    .PARAMETER Appname 
        Name to assign to the application on the Citrix ADC. If you do not provide a name, the appliance assigns the application the name of the template file. 
    .PARAMETER Apptemplatefilename 
        Name of the AppExpert application template file. 
    .PARAMETER Deploymentfilename 
        Name of the deployment file.
    .EXAMPLE
        PS C:\>Invoke-ADCExportApplication -appname <string>
        An example how to export application configuration Object(s).
    .NOTES
        File Name : Invoke-ADCExportApplication
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/app/application/
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
        [string]$Appname,

        [string]$Apptemplatefilename,

        [string]$Deploymentfilename 

    )
    begin {
        Write-Verbose "Invoke-ADCExportApplication: Starting"
    }
    process {
        try {
            $payload = @{ appname = $appname }
            if ( $PSBoundParameters.ContainsKey('apptemplatefilename') ) { $payload.Add('apptemplatefilename', $apptemplatefilename) }
            if ( $PSBoundParameters.ContainsKey('deploymentfilename') ) { $payload.Add('deploymentfilename', $deploymentfilename) }
            if ( $PSCmdlet.ShouldProcess($Name, "Export App configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type application -Action export -Payload $payload -GetWarning
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
        Delete App configuration Object.
    .DESCRIPTION
        Configuration for application resource.
    .PARAMETER Appname 
        Name to assign to the application on the Citrix ADC. If you do not provide a name, the appliance assigns the application the name of the template file.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteApplication 
        An example how to delete application configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteApplication
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/app/application/
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

        [string]$Appname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteApplication: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Appname') ) { $arguments.Add('appname', $Appname) }
            if ( $PSCmdlet.ShouldProcess("application", "Delete App configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type application -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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


