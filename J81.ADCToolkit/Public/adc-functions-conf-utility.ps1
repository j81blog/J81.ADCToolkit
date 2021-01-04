function Invoke-ADCUpdateCallhome {
<#
    .SYNOPSIS
        Update Utility configuration Object
    .DESCRIPTION
        Update Utility configuration Object 
    .PARAMETER mode 
        CallHome mode of operation.  
        Default value: Default  
        Possible values = Default, CSP 
    .PARAMETER emailaddress 
        Email address of the contact administrator.  
        Maximum length = 78 
    .PARAMETER hbcustominterval 
        Interval (in days) between CallHome heartbeats.  
        Default value: 7  
        Minimum value = 1  
        Maximum value = 30 
    .PARAMETER proxymode 
        Enables or disables the proxy mode. The proxy server can be set by either specifying the IP address of the server or the name of the service representing the proxy server.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER ipaddress 
        IP address of the proxy server.  
        Minimum length = 1 
    .PARAMETER proxyauthservice 
        Name of the service that represents the proxy server.  
        Maximum length = 128 
    .PARAMETER port 
        HTTP port on the Proxy server. This is a mandatory parameter for both IP address and service name based configuration.  
        Minimum value = 1  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        Invoke-ADCUpdateCallhome 
    .NOTES
        File Name : Invoke-ADCUpdateCallhome
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/utility/callhome/
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

        [ValidateSet('Default', 'CSP')]
        [string]$mode ,

        [string]$emailaddress ,

        [ValidateRange(1, 30)]
        [double]$hbcustominterval ,

        [ValidateSet('YES', 'NO')]
        [string]$proxymode ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ipaddress ,

        [string]$proxyauthservice ,

        [ValidateRange(1, 65535)]
        [int]$port 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCallhome: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('mode')) { $Payload.Add('mode', $mode) }
            if ($PSBoundParameters.ContainsKey('emailaddress')) { $Payload.Add('emailaddress', $emailaddress) }
            if ($PSBoundParameters.ContainsKey('hbcustominterval')) { $Payload.Add('hbcustominterval', $hbcustominterval) }
            if ($PSBoundParameters.ContainsKey('proxymode')) { $Payload.Add('proxymode', $proxymode) }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Payload.Add('ipaddress', $ipaddress) }
            if ($PSBoundParameters.ContainsKey('proxyauthservice')) { $Payload.Add('proxyauthservice', $proxyauthservice) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
 
            if ($PSCmdlet.ShouldProcess("callhome", "Update Utility configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type callhome -Payload $Payload -GetWarning
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
        Unset Utility configuration Object
    .DESCRIPTION
        Unset Utility configuration Object 
   .PARAMETER mode 
       CallHome mode of operation.  
       Possible values = Default, CSP 
   .PARAMETER emailaddress 
       Email address of the contact administrator. 
   .PARAMETER hbcustominterval 
       Interval (in days) between CallHome heartbeats. 
   .PARAMETER proxymode 
       Enables or disables the proxy mode. The proxy server can be set by either specifying the IP address of the server or the name of the service representing the proxy server.  
       Possible values = YES, NO 
   .PARAMETER ipaddress 
       IP address of the proxy server. 
   .PARAMETER proxyauthservice 
       Name of the service that represents the proxy server. 
   .PARAMETER port 
       HTTP port on the Proxy server. This is a mandatory parameter for both IP address and service name based configuration.  
       * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        Invoke-ADCUnsetCallhome 
    .NOTES
        File Name : Invoke-ADCUnsetCallhome
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/utility/callhome
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

        [Boolean]$mode ,

        [Boolean]$emailaddress ,

        [Boolean]$hbcustominterval ,

        [Boolean]$proxymode ,

        [Boolean]$ipaddress ,

        [Boolean]$proxyauthservice ,

        [Boolean]$port 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCallhome: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('mode')) { $Payload.Add('mode', $mode) }
            if ($PSBoundParameters.ContainsKey('emailaddress')) { $Payload.Add('emailaddress', $emailaddress) }
            if ($PSBoundParameters.ContainsKey('hbcustominterval')) { $Payload.Add('hbcustominterval', $hbcustominterval) }
            if ($PSBoundParameters.ContainsKey('proxymode')) { $Payload.Add('proxymode', $proxymode) }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Payload.Add('ipaddress', $ipaddress) }
            if ($PSBoundParameters.ContainsKey('proxyauthservice')) { $Payload.Add('proxyauthservice', $proxyauthservice) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSCmdlet.ShouldProcess("callhome", "Unset Utility configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type callhome -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Utility configuration object(s)
    .DESCRIPTION
        Get Utility configuration object(s)
    .PARAMETER nodeid 
       Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retreive all callhome object(s)
    .PARAMETER Count
        If specified, the count of the callhome object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCallhome
    .EXAMPLE 
        Invoke-ADCGetCallhome -GetAll
    .EXAMPLE
        Invoke-ADCGetCallhome -name <string>
    .EXAMPLE
        Invoke-ADCGetCallhome -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCallhome
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/utility/callhome/
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
        Write-Verbose "Invoke-ADCGetCallhome: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all callhome objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type callhome -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for callhome objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type callhome -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving callhome objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('nodeid')) { $Arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type callhome -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving callhome configuration for property ''"

            } else {
                Write-Verbose "Retrieving callhome configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type callhome -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Install Utility configuration Object
    .DESCRIPTION
        Install Utility configuration Object 
    .PARAMETER url 
        Url for the build file. Must be in the following formats:  
        http://[user]:[password]@host/path/to/file  
        https://[user]:[password]@host/path/to/file  
        sftp://[user]:[password]@host/path/to/file  
        scp://[user]:[password]@host/path/to/file  
        ftp://[user]:[password]@host/path/to/file  
        file://path/to/file. 
    .PARAMETER y 
        Do not prompt for yes/no before rebooting. 
    .PARAMETER l 
        Use this flag to enable callhome. 
    .PARAMETER enhancedupgrade 
        Use this flag for upgrading from/to enhancement mode. 
    .PARAMETER resizeswapvar 
        Use this flag to change swap size on ONLY 64bit nCore/MCNS/VMPE systems NON-VPX systems.
    .EXAMPLE
        Invoke-ADCInstall -url <string>
    .NOTES
        File Name : Invoke-ADCInstall
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/utility/install/
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
        [string]$url ,

        [boolean]$y ,

        [boolean]$l ,

        [boolean]$enhancedupgrade ,

        [boolean]$resizeswapvar 

    )
    begin {
        Write-Verbose "Invoke-ADCInstall: Starting"
    }
    process {
        try {
            $Payload = @{
                url = $url
            }
            if ($PSBoundParameters.ContainsKey('y')) { $Payload.Add('y', $y) }
            if ($PSBoundParameters.ContainsKey('l')) { $Payload.Add('l', $l) }
            if ($PSBoundParameters.ContainsKey('enhancedupgrade')) { $Payload.Add('enhancedupgrade', $enhancedupgrade) }
            if ($PSBoundParameters.ContainsKey('resizeswapvar')) { $Payload.Add('resizeswapvar', $resizeswapvar) }
            if ($PSCmdlet.ShouldProcess($Name, "Install Utility configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type install -Payload $Payload -GetWarning
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

function Invoke-ADCGetRaid {
<#
    .SYNOPSIS
        Get Utility configuration object(s)
    .DESCRIPTION
        Get Utility configuration object(s)
    .PARAMETER GetAll 
        Retreive all raid object(s)
    .PARAMETER Count
        If specified, the count of the raid object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetRaid
    .EXAMPLE 
        Invoke-ADCGetRaid -GetAll
    .EXAMPLE
        Invoke-ADCGetRaid -name <string>
    .EXAMPLE
        Invoke-ADCGetRaid -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetRaid
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/utility/raid/
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
        Write-Verbose "Invoke-ADCGetRaid: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all raid objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type raid -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for raid objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type raid -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving raid objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type raid -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving raid configuration for property ''"

            } else {
                Write-Verbose "Retrieving raid configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type raid -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRaid: Ended"
    }
}

function Invoke-ADCGetTechsupport {
<#
    .SYNOPSIS
        Get Utility configuration object(s)
    .DESCRIPTION
        Get Utility configuration object(s)
    .PARAMETER scope 
       Use this option to gather data on the present node, all cluster nodes, or for the specified partitions. The CLUSTER scope generates smaller abbreviated archives for all nodes. The PARTITION scope collects the admin partition in addition to those specified. The partitionName option is only required for the PARTITION scope.  
       Possible values = NODE, CLUSTER, PARTITION 
    .PARAMETER partitionname 
       Name of the partition. 
    .PARAMETER upload 
       Securely upload the collector archive to Citrix Technical Support using SSL. MyCitrix credentials will be required. If used with the -file option, no new collector archive is generated. Instead, the specified archive is uploaded. Note that the upload operation time depends on the size of the archive file, and the connection bandwidth. 
    .PARAMETER proxy 
       Specifies the proxy server to be used when uploading a collector archive. Use this parameter if the Citrix ADC does not have direct internet connectivity. The basic format of the proxy string is: "proxy_IP:<proxy_port>" (without quotes). If the proxy requires authentication the format is: "username:password@proxy_IP:<proxy_port>". 
    .PARAMETER casenumber 
       Specifies the associated case or service request number if it has already been opened with Citrix Technical Support. 
    .PARAMETER file 
       Specifies the name (with full path) of the collector archive file to be uploaded. If this is specified, no new collector archive is generated. 
    .PARAMETER description 
       Provides a text description for the the upload, and can be used for logging purposes. 
    .PARAMETER username 
       Specifies My Citrix user name, which is used to login to Citrix upload server. 
    .PARAMETER password 
       Specifies My Citrix password, which is used to login to Citrix upload server. 
    .PARAMETER GetAll 
        Retreive all techsupport object(s)
    .PARAMETER Count
        If specified, the count of the techsupport object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTechsupport
    .EXAMPLE 
        Invoke-ADCGetTechsupport -GetAll
    .EXAMPLE
        Invoke-ADCGetTechsupport -name <string>
    .EXAMPLE
        Invoke-ADCGetTechsupport -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTechsupport
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/utility/techsupport/
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
        [ValidateSet('NODE', 'CLUSTER', 'PARTITION')]
        [string]$scope ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$partitionname ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [boolean]$upload ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$proxy ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$casenumber ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$file ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$description ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$username ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$password,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetTechsupport: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all techsupport objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type techsupport -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for techsupport objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type techsupport -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving techsupport objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('scope')) { $Arguments.Add('scope', $scope) } 
                if ($PSBoundParameters.ContainsKey('partitionname')) { $Arguments.Add('partitionname', $partitionname) } 
                if ($PSBoundParameters.ContainsKey('upload')) { $Arguments.Add('upload', $upload) } 
                if ($PSBoundParameters.ContainsKey('proxy')) { $Arguments.Add('proxy', $proxy) } 
                if ($PSBoundParameters.ContainsKey('casenumber')) { $Arguments.Add('casenumber', $casenumber) } 
                if ($PSBoundParameters.ContainsKey('file')) { $Arguments.Add('file', $file) } 
                if ($PSBoundParameters.ContainsKey('description')) { $Arguments.Add('description', $description) } 
                if ($PSBoundParameters.ContainsKey('username')) { $Arguments.Add('username', $username) } 
                if ($PSBoundParameters.ContainsKey('password')) { $Arguments.Add('password', $password) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type techsupport -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving techsupport configuration for property ''"

            } else {
                Write-Verbose "Retrieving techsupport configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type techsupport -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


