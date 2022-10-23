function Invoke-ADCUpdateCallhome {
    <#
    .SYNOPSIS
        Update Utility configuration Object.
    .DESCRIPTION
        Configuration for callhome resource.
    .PARAMETER Mode 
        CallHome mode of operation. 
        Possible values = Default, CSP 
    .PARAMETER Emailaddress 
        Email address of the contact administrator. 
    .PARAMETER Hbcustominterval 
        Interval (in days) between CallHome heartbeats. 
    .PARAMETER Proxymode 
        Enables or disables the proxy mode. The proxy server can be set by either specifying the IP address of the server or the name of the service representing the proxy server. 
        Possible values = YES, NO 
    .PARAMETER Ipaddress 
        IP address of the proxy server. 
    .PARAMETER Proxyauthservice 
        Name of the service that represents the proxy server. 
    .PARAMETER Port 
        HTTP port on the Proxy server. This is a mandatory parameter for both IP address and service name based configuration. 
        * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateCallhome 
        An example how to update callhome configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateCallhome
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/utility/callhome/
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

        [ValidateSet('Default', 'CSP')]
        [string]$Mode,

        [string]$Emailaddress,

        [ValidateRange(1, 30)]
        [double]$Hbcustominterval,

        [ValidateSet('YES', 'NO')]
        [string]$Proxymode,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipaddress,

        [string]$Proxyauthservice,

        [ValidateRange(1, 65535)]
        [int]$Port 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCallhome: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('mode') ) { $payload.Add('mode', $mode) }
            if ( $PSBoundParameters.ContainsKey('emailaddress') ) { $payload.Add('emailaddress', $emailaddress) }
            if ( $PSBoundParameters.ContainsKey('hbcustominterval') ) { $payload.Add('hbcustominterval', $hbcustominterval) }
            if ( $PSBoundParameters.ContainsKey('proxymode') ) { $payload.Add('proxymode', $proxymode) }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('proxyauthservice') ) { $payload.Add('proxyauthservice', $proxyauthservice) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSCmdlet.ShouldProcess("callhome", "Update Utility configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type callhome -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateCallhome: Finished"
    }
}

function Invoke-ADCUnsetCallhome {
    <#
    .SYNOPSIS
        Unset Utility configuration Object.
    .DESCRIPTION
        Configuration for callhome resource.
    .PARAMETER Mode 
        CallHome mode of operation. 
        Possible values = Default, CSP 
    .PARAMETER Emailaddress 
        Email address of the contact administrator. 
    .PARAMETER Hbcustominterval 
        Interval (in days) between CallHome heartbeats. 
    .PARAMETER Proxymode 
        Enables or disables the proxy mode. The proxy server can be set by either specifying the IP address of the server or the name of the service representing the proxy server. 
        Possible values = YES, NO 
    .PARAMETER Ipaddress 
        IP address of the proxy server. 
    .PARAMETER Proxyauthservice 
        Name of the service that represents the proxy server. 
    .PARAMETER Port 
        HTTP port on the Proxy server. This is a mandatory parameter for both IP address and service name based configuration. 
        * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetCallhome 
        An example how to unset callhome configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetCallhome
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/utility/callhome
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

        [Boolean]$mode,

        [Boolean]$emailaddress,

        [Boolean]$hbcustominterval,

        [Boolean]$proxymode,

        [Boolean]$ipaddress,

        [Boolean]$proxyauthservice,

        [Boolean]$port 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCallhome: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('mode') ) { $payload.Add('mode', $mode) }
            if ( $PSBoundParameters.ContainsKey('emailaddress') ) { $payload.Add('emailaddress', $emailaddress) }
            if ( $PSBoundParameters.ContainsKey('hbcustominterval') ) { $payload.Add('hbcustominterval', $hbcustominterval) }
            if ( $PSBoundParameters.ContainsKey('proxymode') ) { $payload.Add('proxymode', $proxymode) }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('proxyauthservice') ) { $payload.Add('proxyauthservice', $proxyauthservice) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSCmdlet.ShouldProcess("callhome", "Unset Utility configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type callhome -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetCallhome: Finished"
    }
}

function Invoke-ADCGetCallhome {
    <#
    .SYNOPSIS
        Get Utility configuration object(s).
    .DESCRIPTION
        Configuration for callhome resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retrieve all callhome object(s).
    .PARAMETER Count
        If specified, the count of the callhome object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCallhome
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCallhome -GetAll 
        Get all callhome data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCallhome -name <string>
        Get callhome object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCallhome -Filter @{ 'name'='<value>' }
        Get callhome data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCallhome
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/utility/callhome/
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
        Write-Verbose "Invoke-ADCGetCallhome: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all callhome objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type callhome -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for callhome objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type callhome -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving callhome objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type callhome -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving callhome configuration for property ''"

            } else {
                Write-Verbose "Retrieving callhome configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type callhome -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCallhome: Ended"
    }
}

function Invoke-ADCInstall {
    <#
    .SYNOPSIS
        Install Utility configuration Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Url 
        Url for the build file. Must be in the following formats: 
        http://[user]:[password]@host/path/to/file 
        https://[user]:[password]@host/path/to/file 
        sftp://[user]:[password]@host/path/to/file 
        scp://[user]:[password]@host/path/to/file 
        ftp://[user]:[password]@host/path/to/file 
        file://path/to/file. 
    .PARAMETER Y 
        Do not prompt for yes/no before rebooting. 
    .PARAMETER L 
        Use this flag to enable callhome. 
    .PARAMETER A 
        Use this flag to enable Citrix ADM Service Connect. This feature helps you discover your Citrix ADC instances effortlessly on Citrix ADM service and get insights and curated machine learning based recommendations for applications and Citrix ADC infrastructure. This feature lets the Citrix ADC instance automatically send system, usage and telemetry data to Citrix ADM service. View here [https://docs.citrix.com/en-us/citrix-adc/13/data-governance.html] to learn more about this feature. Use of this feature is subject to the Citrix End User ServiceAgreement. View here [https://www.citrix.com/buy/licensing/agreements.html]. 
    .PARAMETER Enhancedupgrade 
        Use this flag for upgrading from/to enhancement mode. 
    .PARAMETER Resizeswapvar 
        Use this flag to change swap size on ONLY 64bit nCore/MCNS/VMPE systems NON-VPX systems.
    .EXAMPLE
        PS C:\>Invoke-ADCInstall -url <string>
        An example how to install install configuration Object(s).
    .NOTES
        File Name : Invoke-ADCInstall
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/utility/install/
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
        [string]$Url,

        [boolean]$Y,

        [boolean]$L,

        [boolean]$A,

        [boolean]$Enhancedupgrade,

        [boolean]$Resizeswapvar 

    )
    begin {
        Write-Verbose "Invoke-ADCInstall: Starting"
    }
    process {
        try {
            $payload = @{ url = $url }
            if ( $PSBoundParameters.ContainsKey('y') ) { $payload.Add('y', $y) }
            if ( $PSBoundParameters.ContainsKey('l') ) { $payload.Add('l', $l) }
            if ( $PSBoundParameters.ContainsKey('a') ) { $payload.Add('a', $a) }
            if ( $PSBoundParameters.ContainsKey('enhancedupgrade') ) { $payload.Add('enhancedupgrade', $enhancedupgrade) }
            if ( $PSBoundParameters.ContainsKey('resizeswapvar') ) { $payload.Add('resizeswapvar', $resizeswapvar) }
            if ( $PSCmdlet.ShouldProcess($Name, "Install Utility configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type install -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCInstall: Finished"
    }
}

function Invoke-ADCGetTechsupport {
    <#
    .SYNOPSIS
        Get Utility configuration object(s).
    .DESCRIPTION
        Configuration for tech support resource.
    .PARAMETER Scope 
        Use this option to gather data on the present node, all cluster nodes, or for the specified partitions. The CLUSTER scope generates smaller abbreviated archives for all nodes. The PARTITION scope collects the admin partition in addition to those specified. The partitionName option is only required for the PARTITION scope. 
        Possible values = NODE, CLUSTER, PARTITION 
    .PARAMETER Partitionname 
        Name of the partition. 
    .PARAMETER Upload 
        Securely upload the collector archive to Citrix Technical Support using SSL. MyCitrix credentials will be required. If used with the -file option, no new collector archive is generated. Instead, the specified archive is uploaded. Note that the upload operation time depends on the size of the archive file, and the connection bandwidth. 
    .PARAMETER Proxy 
        Specifies the proxy server to be used when uploading a collector archive. Use this parameter if the Citrix ADC does not have direct internet connectivity. The basic format of the proxy string is: "proxy_IP:<proxy_port>" (without quotes). If the proxy requires authentication the format is: "username:password@proxy_IP:<proxy_port>". 
    .PARAMETER Casenumber 
        Specifies the associated case or service request number if it has already been opened with Citrix Technical Support. 
    .PARAMETER File 
        Specifies the name (with full path) of the collector archive file to be uploaded. If this is specified, no new collector archive is generated. 
    .PARAMETER Description 
        Provides a text description for the the upload, and can be used for logging purposes. 
    .PARAMETER Username 
        Specifies My Citrix user name, which is used to login to Citrix upload server. 
    .PARAMETER Password 
        Specifies My Citrix password, which is used to login to Citrix upload server. 
    .PARAMETER GetAll 
        Retrieve all techsupport object(s).
    .PARAMETER Count
        If specified, the count of the techsupport object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTechsupport
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTechsupport -GetAll 
        Get all techsupport data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTechsupport -name <string>
        Get techsupport object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTechsupport -Filter @{ 'name'='<value>' }
        Get techsupport data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTechsupport
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/utility/techsupport/
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
        [ValidateSet('NODE', 'CLUSTER', 'PARTITION')]
        [string]$Scope,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Partitionname,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [boolean]$Upload,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Proxy,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Casenumber,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$File,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Description,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Username,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Password,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetTechsupport: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all techsupport objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type techsupport -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for techsupport objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type techsupport -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving techsupport objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('scope') ) { $arguments.Add('scope', $scope) } 
                if ( $PSBoundParameters.ContainsKey('partitionname') ) { $arguments.Add('partitionname', $partitionname) } 
                if ( $PSBoundParameters.ContainsKey('upload') ) { $arguments.Add('upload', $upload) } 
                if ( $PSBoundParameters.ContainsKey('proxy') ) { $arguments.Add('proxy', $proxy) } 
                if ( $PSBoundParameters.ContainsKey('casenumber') ) { $arguments.Add('casenumber', $casenumber) } 
                if ( $PSBoundParameters.ContainsKey('file') ) { $arguments.Add('file', $file) } 
                if ( $PSBoundParameters.ContainsKey('description') ) { $arguments.Add('description', $description) } 
                if ( $PSBoundParameters.ContainsKey('username') ) { $arguments.Add('username', $username) } 
                if ( $PSBoundParameters.ContainsKey('password') ) { $arguments.Add('password', $password) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type techsupport -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving techsupport configuration for property ''"

            } else {
                Write-Verbose "Retrieving techsupport configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type techsupport -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTechsupport: Ended"
    }
}


