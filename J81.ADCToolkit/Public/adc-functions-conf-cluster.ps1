function Invoke-ADCSyncClusterfiles {
<#
    .SYNOPSIS
        Sync cluster configuration Object
    .DESCRIPTION
        Sync cluster configuration Object 
    .PARAMETER mode 
        The directories and files to be synchronized. The available settings function as follows:  
        Mode Paths  
        all /nsconfig/ssl/  
        /var/netscaler/ssl/  
        /var/vpn/bookmark/  
        /nsconfig/dns/  
        /nsconfig/htmlinjection/  
        /netscaler/htmlinjection/ens/  
        /nsconfig/monitors/  
        /nsconfig/nstemplates/  
        /nsconfig/ssh/  
        /nsconfig/rc.netscaler  
        /nsconfig/resolv.conf  
        /nsconfig/inetd.conf  
        /nsconfig/syslog.conf  
        /nsconfig/ntp.conf  
        /nsconfig/httpd.conf  
        /nsconfig/sshd_config  
        /nsconfig/hosts  
        /nsconfig/enckey  
        /var/nslw.bin/etc/krb5.conf  
        /var/nslw.bin/etc/krb5.keytab  
        /var/lib/likewise/db/  
        /var/download/  
        /var/wi/tomcat/webapps/  
        /var/wi/tomcat/conf/Catalina/localhost/  
        /var/wi/java_home/lib/security/cacerts  
        /var/wi/java_home/jre/lib/security/cacerts  
        /var/netscaler/locdb/  
        ssl /nsconfig/ssl/  
        /var/netscaler/ssl/  
        bookmarks /var/vpn/bookmark/  
        dns /nsconfig/dns/  
        htmlinjection /nsconfig/htmlinjection/  
        imports /var/download/  
        misc /nsconfig/license/  
        /nsconfig/rc.conf  
        all_plus_misc Includes *all* files and /nsconfig/license/ and /nsconfig/rc.conf.  
        Possible values = all, bookmarks, ssl, htmlinjection, imports, misc, dns, krb, AAA, app_catalog, all_plus_misc, all_minus_misc
    .EXAMPLE
        Invoke-ADCSyncClusterfiles 
    .NOTES
        File Name : Invoke-ADCSyncClusterfiles
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterfiles/
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

        [ValidateSet('all', 'bookmarks', 'ssl', 'htmlinjection', 'imports', 'misc', 'dns', 'krb', 'AAA', 'app_catalog', 'all_plus_misc', 'all_minus_misc')]
        [string[]]$mode 

    )
    begin {
        Write-Verbose "Invoke-ADCSyncClusterfiles: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('mode')) { $Payload.Add('mode', $mode) }
            if ($PSCmdlet.ShouldProcess($Name, "Sync cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type clusterfiles -Action sync -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCSyncClusterfiles: Finished"
    }
}

function Invoke-ADCAddClusterinstance {
<#
    .SYNOPSIS
        Add cluster configuration Object
    .DESCRIPTION
        Add cluster configuration Object 
    .PARAMETER clid 
        Unique number that identifies the cluster.  
        Minimum value = 1  
        Maximum value = 16 
    .PARAMETER deadinterval 
        Amount of time, in seconds, after which nodes that do not respond to the heartbeats are assumed to be down.If the value is less than 3 sec, set the helloInterval parameter to 200 msec.  
        Default value: 3  
        Minimum value = 1  
        Maximum value = 60 
    .PARAMETER hellointerval 
        Interval, in milliseconds, at which heartbeats are sent to each cluster node to check the health status.Set the value to 200 msec, if the deadInterval parameter is less than 3 sec.  
        Default value: 200  
        Minimum value = 200  
        Maximum value = 1000 
    .PARAMETER preemption 
        Preempt a cluster node that is configured as a SPARE if an ACTIVE node becomes available.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER quorumtype 
        Quorum Configuration Choices - "Majority" (recommended) requires majority of nodes to be online for the cluster to be UP. "None" relaxes this requirement.  
        Default value: MAJORITY  
        Possible values = MAJORITY, NONE 
    .PARAMETER inc 
        This option is required if the cluster nodes reside on different networks.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER processlocal 
        By turning on this option packets destined to a service in a cluster will not under go any steering.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER retainconnectionsoncluster 
        This option enables you to retain existing connections on a node joining a Cluster system or when a node is being configured for passive timeout. By default, this option is disabled.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER backplanebasedview 
        View based on heartbeat only on bkplane interface.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER syncstatusstrictmode 
        strict mode for sync status of cluster. Depending on the the mode if there are any errors while applying config, sync status is displayed accordingly. By default the flag is disabled.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created clusterinstance item.
    .EXAMPLE
        Invoke-ADCAddClusterinstance -clid <double>
    .NOTES
        File Name : Invoke-ADCAddClusterinstance
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterinstance/
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
        [ValidateRange(1, 16)]
        [double]$clid ,

        [ValidateRange(1, 60)]
        [double]$deadinterval = '3' ,

        [ValidateRange(200, 1000)]
        [double]$hellointerval = '200' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$preemption = 'DISABLED' ,

        [ValidateSet('MAJORITY', 'NONE')]
        [string]$quorumtype = 'MAJORITY' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$inc = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$processlocal = 'DISABLED' ,

        [ValidateSet('YES', 'NO')]
        [string]$retainconnectionsoncluster = 'NO' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$backplanebasedview = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$syncstatusstrictmode = 'DISABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddClusterinstance: Starting"
    }
    process {
        try {
            $Payload = @{
                clid = $clid
            }
            if ($PSBoundParameters.ContainsKey('deadinterval')) { $Payload.Add('deadinterval', $deadinterval) }
            if ($PSBoundParameters.ContainsKey('hellointerval')) { $Payload.Add('hellointerval', $hellointerval) }
            if ($PSBoundParameters.ContainsKey('preemption')) { $Payload.Add('preemption', $preemption) }
            if ($PSBoundParameters.ContainsKey('quorumtype')) { $Payload.Add('quorumtype', $quorumtype) }
            if ($PSBoundParameters.ContainsKey('inc')) { $Payload.Add('inc', $inc) }
            if ($PSBoundParameters.ContainsKey('processlocal')) { $Payload.Add('processlocal', $processlocal) }
            if ($PSBoundParameters.ContainsKey('retainconnectionsoncluster')) { $Payload.Add('retainconnectionsoncluster', $retainconnectionsoncluster) }
            if ($PSBoundParameters.ContainsKey('backplanebasedview')) { $Payload.Add('backplanebasedview', $backplanebasedview) }
            if ($PSBoundParameters.ContainsKey('syncstatusstrictmode')) { $Payload.Add('syncstatusstrictmode', $syncstatusstrictmode) }
 
            if ($PSCmdlet.ShouldProcess("clusterinstance", "Add cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type clusterinstance -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetClusterinstance -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddClusterinstance: Finished"
    }
}

function Invoke-ADCDeleteClusterinstance {
<#
    .SYNOPSIS
        Delete cluster configuration Object
    .DESCRIPTION
        Delete cluster configuration Object
    .PARAMETER clid 
       Unique number that identifies the cluster.  
       Minimum value = 1  
       Maximum value = 16 
    .EXAMPLE
        Invoke-ADCDeleteClusterinstance -clid <double>
    .NOTES
        File Name : Invoke-ADCDeleteClusterinstance
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterinstance/
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
        [double]$clid 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusterinstance: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$clid", "Delete cluster configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusterinstance -NitroPath nitro/v1/config -Resource $clid -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteClusterinstance: Finished"
    }
}

function Invoke-ADCUpdateClusterinstance {
<#
    .SYNOPSIS
        Update cluster configuration Object
    .DESCRIPTION
        Update cluster configuration Object 
    .PARAMETER clid 
        Unique number that identifies the cluster.  
        Minimum value = 1  
        Maximum value = 16 
    .PARAMETER deadinterval 
        Amount of time, in seconds, after which nodes that do not respond to the heartbeats are assumed to be down.If the value is less than 3 sec, set the helloInterval parameter to 200 msec.  
        Default value: 3  
        Minimum value = 1  
        Maximum value = 60 
    .PARAMETER hellointerval 
        Interval, in milliseconds, at which heartbeats are sent to each cluster node to check the health status.Set the value to 200 msec, if the deadInterval parameter is less than 3 sec.  
        Default value: 200  
        Minimum value = 200  
        Maximum value = 1000 
    .PARAMETER preemption 
        Preempt a cluster node that is configured as a SPARE if an ACTIVE node becomes available.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER quorumtype 
        Quorum Configuration Choices - "Majority" (recommended) requires majority of nodes to be online for the cluster to be UP. "None" relaxes this requirement.  
        Default value: MAJORITY  
        Possible values = MAJORITY, NONE 
    .PARAMETER inc 
        This option is required if the cluster nodes reside on different networks.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER processlocal 
        By turning on this option packets destined to a service in a cluster will not under go any steering.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER nodegroup 
        The node group in a Cluster system used for transition from L2 to L3. 
    .PARAMETER retainconnectionsoncluster 
        This option enables you to retain existing connections on a node joining a Cluster system or when a node is being configured for passive timeout. By default, this option is disabled.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER backplanebasedview 
        View based on heartbeat only on bkplane interface.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER syncstatusstrictmode 
        strict mode for sync status of cluster. Depending on the the mode if there are any errors while applying config, sync status is displayed accordingly. By default the flag is disabled.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created clusterinstance item.
    .EXAMPLE
        Invoke-ADCUpdateClusterinstance -clid <double>
    .NOTES
        File Name : Invoke-ADCUpdateClusterinstance
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterinstance/
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
        [ValidateRange(1, 16)]
        [double]$clid ,

        [ValidateRange(1, 60)]
        [double]$deadinterval ,

        [ValidateRange(200, 1000)]
        [double]$hellointerval ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$preemption ,

        [ValidateSet('MAJORITY', 'NONE')]
        [string]$quorumtype ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$inc ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$processlocal ,

        [string]$nodegroup ,

        [ValidateSet('YES', 'NO')]
        [string]$retainconnectionsoncluster ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$backplanebasedview ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$syncstatusstrictmode ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateClusterinstance: Starting"
    }
    process {
        try {
            $Payload = @{
                clid = $clid
            }
            if ($PSBoundParameters.ContainsKey('deadinterval')) { $Payload.Add('deadinterval', $deadinterval) }
            if ($PSBoundParameters.ContainsKey('hellointerval')) { $Payload.Add('hellointerval', $hellointerval) }
            if ($PSBoundParameters.ContainsKey('preemption')) { $Payload.Add('preemption', $preemption) }
            if ($PSBoundParameters.ContainsKey('quorumtype')) { $Payload.Add('quorumtype', $quorumtype) }
            if ($PSBoundParameters.ContainsKey('inc')) { $Payload.Add('inc', $inc) }
            if ($PSBoundParameters.ContainsKey('processlocal')) { $Payload.Add('processlocal', $processlocal) }
            if ($PSBoundParameters.ContainsKey('nodegroup')) { $Payload.Add('nodegroup', $nodegroup) }
            if ($PSBoundParameters.ContainsKey('retainconnectionsoncluster')) { $Payload.Add('retainconnectionsoncluster', $retainconnectionsoncluster) }
            if ($PSBoundParameters.ContainsKey('backplanebasedview')) { $Payload.Add('backplanebasedview', $backplanebasedview) }
            if ($PSBoundParameters.ContainsKey('syncstatusstrictmode')) { $Payload.Add('syncstatusstrictmode', $syncstatusstrictmode) }
 
            if ($PSCmdlet.ShouldProcess("clusterinstance", "Update cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusterinstance -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetClusterinstance -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateClusterinstance: Finished"
    }
}

function Invoke-ADCUnsetClusterinstance {
<#
    .SYNOPSIS
        Unset cluster configuration Object
    .DESCRIPTION
        Unset cluster configuration Object 
   .PARAMETER clid 
       Unique number that identifies the cluster. 
   .PARAMETER deadinterval 
       Amount of time, in seconds, after which nodes that do not respond to the heartbeats are assumed to be down.If the value is less than 3 sec, set the helloInterval parameter to 200 msec. 
   .PARAMETER hellointerval 
       Interval, in milliseconds, at which heartbeats are sent to each cluster node to check the health status.Set the value to 200 msec, if the deadInterval parameter is less than 3 sec. 
   .PARAMETER preemption 
       Preempt a cluster node that is configured as a SPARE if an ACTIVE node becomes available.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER quorumtype 
       Quorum Configuration Choices - "Majority" (recommended) requires majority of nodes to be online for the cluster to be UP. "None" relaxes this requirement.  
       Possible values = MAJORITY, NONE 
   .PARAMETER inc 
       This option is required if the cluster nodes reside on different networks.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER processlocal 
       By turning on this option packets destined to a service in a cluster will not under go any steering.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER nodegroup 
       The node group in a Cluster system used for transition from L2 to L3. 
   .PARAMETER retainconnectionsoncluster 
       This option enables you to retain existing connections on a node joining a Cluster system or when a node is being configured for passive timeout. By default, this option is disabled.  
       Possible values = YES, NO 
   .PARAMETER backplanebasedview 
       View based on heartbeat only on bkplane interface.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER syncstatusstrictmode 
       strict mode for sync status of cluster. Depending on the the mode if there are any errors while applying config, sync status is displayed accordingly. By default the flag is disabled.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetClusterinstance -clid <double>
    .NOTES
        File Name : Invoke-ADCUnsetClusterinstance
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterinstance
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
        [ValidateRange(1, 16)]
        [double]$clid ,

        [Boolean]$deadinterval ,

        [Boolean]$hellointerval ,

        [Boolean]$preemption ,

        [Boolean]$quorumtype ,

        [Boolean]$inc ,

        [Boolean]$processlocal ,

        [Boolean]$nodegroup ,

        [Boolean]$retainconnectionsoncluster ,

        [Boolean]$backplanebasedview ,

        [Boolean]$syncstatusstrictmode 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetClusterinstance: Starting"
    }
    process {
        try {
            $Payload = @{
                clid = $clid
            }
            if ($PSBoundParameters.ContainsKey('deadinterval')) { $Payload.Add('deadinterval', $deadinterval) }
            if ($PSBoundParameters.ContainsKey('hellointerval')) { $Payload.Add('hellointerval', $hellointerval) }
            if ($PSBoundParameters.ContainsKey('preemption')) { $Payload.Add('preemption', $preemption) }
            if ($PSBoundParameters.ContainsKey('quorumtype')) { $Payload.Add('quorumtype', $quorumtype) }
            if ($PSBoundParameters.ContainsKey('inc')) { $Payload.Add('inc', $inc) }
            if ($PSBoundParameters.ContainsKey('processlocal')) { $Payload.Add('processlocal', $processlocal) }
            if ($PSBoundParameters.ContainsKey('nodegroup')) { $Payload.Add('nodegroup', $nodegroup) }
            if ($PSBoundParameters.ContainsKey('retainconnectionsoncluster')) { $Payload.Add('retainconnectionsoncluster', $retainconnectionsoncluster) }
            if ($PSBoundParameters.ContainsKey('backplanebasedview')) { $Payload.Add('backplanebasedview', $backplanebasedview) }
            if ($PSBoundParameters.ContainsKey('syncstatusstrictmode')) { $Payload.Add('syncstatusstrictmode', $syncstatusstrictmode) }
            if ($PSCmdlet.ShouldProcess("$clid", "Unset cluster configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type clusterinstance -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetClusterinstance: Finished"
    }
}

function Invoke-ADCEnableClusterinstance {
<#
    .SYNOPSIS
        Enable cluster configuration Object
    .DESCRIPTION
        Enable cluster configuration Object 
    .PARAMETER clid 
        Unique number that identifies the cluster.
    .EXAMPLE
        Invoke-ADCEnableClusterinstance -clid <double>
    .NOTES
        File Name : Invoke-ADCEnableClusterinstance
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterinstance/
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
        [ValidateRange(1, 16)]
        [double]$clid 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableClusterinstance: Starting"
    }
    process {
        try {
            $Payload = @{
                clid = $clid
            }

            if ($PSCmdlet.ShouldProcess($Name, "Enable cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type clusterinstance -Action enable -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCEnableClusterinstance: Finished"
    }
}

function Invoke-ADCDisableClusterinstance {
<#
    .SYNOPSIS
        Disable cluster configuration Object
    .DESCRIPTION
        Disable cluster configuration Object 
    .PARAMETER clid 
        Unique number that identifies the cluster.
    .EXAMPLE
        Invoke-ADCDisableClusterinstance -clid <double>
    .NOTES
        File Name : Invoke-ADCDisableClusterinstance
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterinstance/
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
        [ValidateRange(1, 16)]
        [double]$clid 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableClusterinstance: Starting"
    }
    process {
        try {
            $Payload = @{
                clid = $clid
            }

            if ($PSCmdlet.ShouldProcess($Name, "Disable cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type clusterinstance -Action disable -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCDisableClusterinstance: Finished"
    }
}

function Invoke-ADCGetClusterinstance {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER clid 
       Unique number that identifies the cluster. 
    .PARAMETER GetAll 
        Retreive all clusterinstance object(s)
    .PARAMETER Count
        If specified, the count of the clusterinstance object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusterinstance
    .EXAMPLE 
        Invoke-ADCGetClusterinstance -GetAll 
    .EXAMPLE 
        Invoke-ADCGetClusterinstance -Count
    .EXAMPLE
        Invoke-ADCGetClusterinstance -name <string>
    .EXAMPLE
        Invoke-ADCGetClusterinstance -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusterinstance
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterinstance/
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
        [ValidateRange(1, 16)]
        [double]$clid,

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
        Write-Verbose "Invoke-ADCGetClusterinstance: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all clusterinstance objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusterinstance objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusterinstance objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusterinstance configuration for property 'clid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -NitroPath nitro/v1/config -Resource $clid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusterinstance configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusterinstance: Ended"
    }
}

function Invoke-ADCGetClusterinstancebinding {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER clid 
       Unique number that identifies the cluster. 
    .PARAMETER GetAll 
        Retreive all clusterinstance_binding object(s)
    .PARAMETER Count
        If specified, the count of the clusterinstance_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusterinstancebinding
    .EXAMPLE 
        Invoke-ADCGetClusterinstancebinding -GetAll
    .EXAMPLE
        Invoke-ADCGetClusterinstancebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetClusterinstancebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusterinstancebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterinstance_binding/
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
        [ValidateRange(1, 16)]
        [double]$clid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetClusterinstancebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all clusterinstance_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusterinstance_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusterinstance_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusterinstance_binding configuration for property 'clid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_binding -NitroPath nitro/v1/config -Resource $clid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusterinstance_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusterinstancebinding: Ended"
    }
}

function Invoke-ADCGetClusterinstanceclusternodebinding {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER clid 
       Unique number that identifies the cluster. 
    .PARAMETER GetAll 
        Retreive all clusterinstance_clusternode_binding object(s)
    .PARAMETER Count
        If specified, the count of the clusterinstance_clusternode_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusterinstanceclusternodebinding
    .EXAMPLE 
        Invoke-ADCGetClusterinstanceclusternodebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetClusterinstanceclusternodebinding -Count
    .EXAMPLE
        Invoke-ADCGetClusterinstanceclusternodebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetClusterinstanceclusternodebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusterinstanceclusternodebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterinstance_clusternode_binding/
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
        [ValidateRange(1, 16)]
        [double]$clid,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetClusterinstanceclusternodebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all clusterinstance_clusternode_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_clusternode_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusterinstance_clusternode_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_clusternode_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusterinstance_clusternode_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_clusternode_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusterinstance_clusternode_binding configuration for property 'clid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_clusternode_binding -NitroPath nitro/v1/config -Resource $clid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusterinstance_clusternode_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_clusternode_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusterinstanceclusternodebinding: Ended"
    }
}

function Invoke-ADCAddClusternode {
<#
    .SYNOPSIS
        Add cluster configuration Object
    .DESCRIPTION
        Add cluster configuration Object 
    .PARAMETER nodeid 
        Unique number that identifies the cluster node.  
        Minimum value = 0  
        Maximum value = 31 
    .PARAMETER ipaddress 
        Citrix ADC IP (NSIP) address of the appliance to add to the cluster. Must be an IPv4 address.  
        Minimum length = 1 
    .PARAMETER state 
        Admin state of the cluster node. The available settings function as follows:  
        ACTIVE - The node serves traffic.  
        SPARE - The node does not serve traffic unless an ACTIVE node goes down.  
        PASSIVE - The node does not serve traffic, unless you change its state. PASSIVE state is useful during temporary maintenance activities in which you want the node to take part in the consensus protocol but not to serve traffic.  
        Default value: PASSIVE  
        Possible values = ACTIVE, SPARE, PASSIVE 
    .PARAMETER backplane 
        Interface through which the node communicates with the other nodes in the cluster. Must be specified in the three-tuple form n/c/u, where n represents the node ID and c/u refers to the interface on the appliance.  
        Minimum length = 1 
    .PARAMETER priority 
        Preference for selecting a node as the configuration coordinator. The node with the lowest priority value is selected as the configuration coordinator.  
        When the current configuration coordinator goes down, the node with the next lowest priority is made the new configuration coordinator. When the original node comes back up, it will preempt the new configuration coordinator and take over as the configuration coordinator.  
        Note: When priority is not configured for any of the nodes or if multiple nodes have the same priority, the cluster elects one of the nodes as the configuration coordinator.  
        Default value: 31  
        Minimum value = 0  
        Maximum value = 31 
    .PARAMETER nodegroup 
        The default node group in a Cluster system.  
        Default value: DEFAULT_NG  
        Minimum length = 1 
    .PARAMETER delay 
        Applicable for Passive node and node becomes passive after this timeout (in minutes).  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 1440 
    .PARAMETER tunnelmode 
        To set the tunnel mode.  
        Default value: NONE  
        Possible values = NONE, GRE, UDP 
    .PARAMETER PassThru 
        Return details about the created clusternode item.
    .EXAMPLE
        Invoke-ADCAddClusternode -nodeid <double> -ipaddress <string>
    .NOTES
        File Name : Invoke-ADCAddClusternode
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternode/
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
        [ValidateRange(0, 31)]
        [double]$nodeid ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ipaddress ,

        [ValidateSet('ACTIVE', 'SPARE', 'PASSIVE')]
        [string]$state = 'PASSIVE' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$backplane ,

        [ValidateRange(0, 31)]
        [double]$priority = '31' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$nodegroup = 'DEFAULT_NG' ,

        [ValidateRange(0, 1440)]
        [double]$delay = '0' ,

        [ValidateSet('NONE', 'GRE', 'UDP')]
        [string]$tunnelmode = 'NONE' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternode: Starting"
    }
    process {
        try {
            $Payload = @{
                nodeid = $nodeid
                ipaddress = $ipaddress
            }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('backplane')) { $Payload.Add('backplane', $backplane) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('nodegroup')) { $Payload.Add('nodegroup', $nodegroup) }
            if ($PSBoundParameters.ContainsKey('delay')) { $Payload.Add('delay', $delay) }
            if ($PSBoundParameters.ContainsKey('tunnelmode')) { $Payload.Add('tunnelmode', $tunnelmode) }
 
            if ($PSCmdlet.ShouldProcess("clusternode", "Add cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type clusternode -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetClusternode -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddClusternode: Finished"
    }
}

function Invoke-ADCUpdateClusternode {
<#
    .SYNOPSIS
        Update cluster configuration Object
    .DESCRIPTION
        Update cluster configuration Object 
    .PARAMETER nodeid 
        Unique number that identifies the cluster node.  
        Minimum value = 0  
        Maximum value = 31 
    .PARAMETER state 
        Admin state of the cluster node. The available settings function as follows:  
        ACTIVE - The node serves traffic.  
        SPARE - The node does not serve traffic unless an ACTIVE node goes down.  
        PASSIVE - The node does not serve traffic, unless you change its state. PASSIVE state is useful during temporary maintenance activities in which you want the node to take part in the consensus protocol but not to serve traffic.  
        Default value: PASSIVE  
        Possible values = ACTIVE, SPARE, PASSIVE 
    .PARAMETER backplane 
        Interface through which the node communicates with the other nodes in the cluster. Must be specified in the three-tuple form n/c/u, where n represents the node ID and c/u refers to the interface on the appliance.  
        Minimum length = 1 
    .PARAMETER priority 
        Preference for selecting a node as the configuration coordinator. The node with the lowest priority value is selected as the configuration coordinator.  
        When the current configuration coordinator goes down, the node with the next lowest priority is made the new configuration coordinator. When the original node comes back up, it will preempt the new configuration coordinator and take over as the configuration coordinator.  
        Note: When priority is not configured for any of the nodes or if multiple nodes have the same priority, the cluster elects one of the nodes as the configuration coordinator.  
        Default value: 31  
        Minimum value = 0  
        Maximum value = 31 
    .PARAMETER delay 
        Applicable for Passive node and node becomes passive after this timeout (in minutes).  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 1440 
    .PARAMETER tunnelmode 
        To set the tunnel mode.  
        Default value: NONE  
        Possible values = NONE, GRE, UDP 
    .PARAMETER PassThru 
        Return details about the created clusternode item.
    .EXAMPLE
        Invoke-ADCUpdateClusternode -nodeid <double>
    .NOTES
        File Name : Invoke-ADCUpdateClusternode
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternode/
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
        [ValidateRange(0, 31)]
        [double]$nodeid ,

        [ValidateSet('ACTIVE', 'SPARE', 'PASSIVE')]
        [string]$state ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$backplane ,

        [ValidateRange(0, 31)]
        [double]$priority ,

        [ValidateRange(0, 1440)]
        [double]$delay ,

        [ValidateSet('NONE', 'GRE', 'UDP')]
        [string]$tunnelmode ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateClusternode: Starting"
    }
    process {
        try {
            $Payload = @{
                nodeid = $nodeid
            }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('backplane')) { $Payload.Add('backplane', $backplane) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('delay')) { $Payload.Add('delay', $delay) }
            if ($PSBoundParameters.ContainsKey('tunnelmode')) { $Payload.Add('tunnelmode', $tunnelmode) }
 
            if ($PSCmdlet.ShouldProcess("clusternode", "Update cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternode -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetClusternode -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateClusternode: Finished"
    }
}

function Invoke-ADCUnsetClusternode {
<#
    .SYNOPSIS
        Unset cluster configuration Object
    .DESCRIPTION
        Unset cluster configuration Object 
   .PARAMETER nodeid 
       Unique number that identifies the cluster node. 
   .PARAMETER state 
       Admin state of the cluster node. The available settings function as follows:  
       ACTIVE - The node serves traffic.  
       SPARE - The node does not serve traffic unless an ACTIVE node goes down.  
       PASSIVE - The node does not serve traffic, unless you change its state. PASSIVE state is useful during temporary maintenance activities in which you want the node to take part in the consensus protocol but not to serve traffic.  
       Possible values = ACTIVE, SPARE, PASSIVE 
   .PARAMETER backplane 
       Interface through which the node communicates with the other nodes in the cluster. Must be specified in the three-tuple form n/c/u, where n represents the node ID and c/u refers to the interface on the appliance. 
   .PARAMETER priority 
       Preference for selecting a node as the configuration coordinator. The node with the lowest priority value is selected as the configuration coordinator.  
       When the current configuration coordinator goes down, the node with the next lowest priority is made the new configuration coordinator. When the original node comes back up, it will preempt the new configuration coordinator and take over as the configuration coordinator.  
       Note: When priority is not configured for any of the nodes or if multiple nodes have the same priority, the cluster elects one of the nodes as the configuration coordinator. 
   .PARAMETER delay 
       Applicable for Passive node and node becomes passive after this timeout (in minutes). 
   .PARAMETER tunnelmode 
       To set the tunnel mode.  
       Possible values = NONE, GRE, UDP
    .EXAMPLE
        Invoke-ADCUnsetClusternode -nodeid <double>
    .NOTES
        File Name : Invoke-ADCUnsetClusternode
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternode
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
        [ValidateRange(0, 31)]
        [double]$nodeid ,

        [Boolean]$state ,

        [Boolean]$backplane ,

        [Boolean]$priority ,

        [Boolean]$delay ,

        [Boolean]$tunnelmode 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetClusternode: Starting"
    }
    process {
        try {
            $Payload = @{
                nodeid = $nodeid
            }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('backplane')) { $Payload.Add('backplane', $backplane) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('delay')) { $Payload.Add('delay', $delay) }
            if ($PSBoundParameters.ContainsKey('tunnelmode')) { $Payload.Add('tunnelmode', $tunnelmode) }
            if ($PSCmdlet.ShouldProcess("$nodeid", "Unset cluster configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type clusternode -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetClusternode: Finished"
    }
}

function Invoke-ADCDeleteClusternode {
<#
    .SYNOPSIS
        Delete cluster configuration Object
    .DESCRIPTION
        Delete cluster configuration Object
    .PARAMETER nodeid 
       Unique number that identifies the cluster node.  
       Minimum value = 0  
       Maximum value = 31    .PARAMETER clearnodegroupconfig 
       Option to remove nodegroup config.  
       Default value: YES  
       Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCDeleteClusternode -nodeid <double>
    .NOTES
        File Name : Invoke-ADCDeleteClusternode
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternode/
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
        [double]$nodeid ,

        [string]$clearnodegroupconfig 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternode: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('clearnodegroupconfig')) { $Arguments.Add('clearnodegroupconfig', $clearnodegroupconfig) }
            if ($PSCmdlet.ShouldProcess("$nodeid", "Delete cluster configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternode -NitroPath nitro/v1/config -Resource $nodeid -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteClusternode: Finished"
    }
}

function Invoke-ADCGetClusternode {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER nodeid 
       Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retreive all clusternode object(s)
    .PARAMETER Count
        If specified, the count of the clusternode object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusternode
    .EXAMPLE 
        Invoke-ADCGetClusternode -GetAll 
    .EXAMPLE 
        Invoke-ADCGetClusternode -Count
    .EXAMPLE
        Invoke-ADCGetClusternode -name <string>
    .EXAMPLE
        Invoke-ADCGetClusternode -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusternode
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternode/
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
        [ValidateRange(0, 31)]
        [double]$nodeid,

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
        Write-Verbose "Invoke-ADCGetClusternode: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all clusternode objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternode objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternode objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternode configuration for property 'nodeid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -NitroPath nitro/v1/config -Resource $nodeid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternode configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusternode: Ended"
    }
}

function Invoke-ADCAddClusternodegroup {
<#
    .SYNOPSIS
        Add cluster configuration Object
    .DESCRIPTION
        Add cluster configuration Object 
    .PARAMETER name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
        Minimum length = 1 
    .PARAMETER strict 
        Specifies whether cluster nodes, that are not part of the nodegroup, will be used as backup for the nodegroup.  
        * Enabled - When one of the nodes goes down, no other cluster node is picked up to replace it. When the node comes up, it will continue being part of the nodegroup.  
        * Disabled - When one of the nodes goes down, a non-nodegroup cluster node is picked up and acts as part of the nodegroup. When the original node of the nodegroup comes up, the backup node will be replaced.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER sticky 
        Only one node can be bound to nodegroup with this option enabled. It specifies whether to prempt the traffic for the entities bound to nodegroup when owner node goes down and rejoins the cluster.  
        * Enabled - When owner node goes down, backup node will become the owner node and takes the traffic for the entities bound to the nodegroup. When bound node rejoins the cluster, traffic for the entities bound to nodegroup will not be steered back to this bound node. Current owner will have the ownership till it goes down.  
        * Disabled - When one of the nodes goes down, a non-nodegroup cluster node is picked up and acts as part of the nodegroup. When the original node of the nodegroup comes up, the backup node will be replaced.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER state 
        State of the nodegroup. All the nodes binding to this nodegroup must have the same state. ACTIVE/SPARE/PASSIVE.  
        Possible values = ACTIVE, SPARE, PASSIVE 
    .PARAMETER priority 
        Priority of Nodegroup. This priority is used for all the nodes bound to the nodegroup for Nodegroup selection.  
        Minimum value = 0  
        Maximum value = 31 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup item.
    .EXAMPLE
        Invoke-ADCAddClusternodegroup -name <string>
    .NOTES
        File Name : Invoke-ADCAddClusternodegroup
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup/
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

        [ValidateSet('YES', 'NO')]
        [string]$strict = 'NO' ,

        [ValidateSet('YES', 'NO')]
        [string]$sticky = 'NO' ,

        [ValidateSet('ACTIVE', 'SPARE', 'PASSIVE')]
        [string]$state ,

        [ValidateRange(0, 31)]
        [double]$priority ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroup: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('strict')) { $Payload.Add('strict', $strict) }
            if ($PSBoundParameters.ContainsKey('sticky')) { $Payload.Add('sticky', $sticky) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
 
            if ($PSCmdlet.ShouldProcess("clusternodegroup", "Add cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type clusternodegroup -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetClusternodegroup -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddClusternodegroup: Finished"
    }
}

function Invoke-ADCUpdateClusternodegroup {
<#
    .SYNOPSIS
        Update cluster configuration Object
    .DESCRIPTION
        Update cluster configuration Object 
    .PARAMETER name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
        Minimum length = 1 
    .PARAMETER strict 
        Specifies whether cluster nodes, that are not part of the nodegroup, will be used as backup for the nodegroup.  
        * Enabled - When one of the nodes goes down, no other cluster node is picked up to replace it. When the node comes up, it will continue being part of the nodegroup.  
        * Disabled - When one of the nodes goes down, a non-nodegroup cluster node is picked up and acts as part of the nodegroup. When the original node of the nodegroup comes up, the backup node will be replaced.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER state 
        State of the nodegroup. All the nodes binding to this nodegroup must have the same state. ACTIVE/SPARE/PASSIVE.  
        Possible values = ACTIVE, SPARE, PASSIVE 
    .PARAMETER priority 
        Priority of Nodegroup. This priority is used for all the nodes bound to the nodegroup for Nodegroup selection.  
        Minimum value = 0  
        Maximum value = 31 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup item.
    .EXAMPLE
        Invoke-ADCUpdateClusternodegroup -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateClusternodegroup
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup/
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

        [ValidateSet('YES', 'NO')]
        [string]$strict ,

        [ValidateSet('ACTIVE', 'SPARE', 'PASSIVE')]
        [string]$state ,

        [ValidateRange(0, 31)]
        [double]$priority ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateClusternodegroup: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('strict')) { $Payload.Add('strict', $strict) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
 
            if ($PSCmdlet.ShouldProcess("clusternodegroup", "Update cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetClusternodegroup -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateClusternodegroup: Finished"
    }
}

function Invoke-ADCUnsetClusternodegroup {
<#
    .SYNOPSIS
        Unset cluster configuration Object
    .DESCRIPTION
        Unset cluster configuration Object 
   .PARAMETER name 
       Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
   .PARAMETER strict 
       Specifies whether cluster nodes, that are not part of the nodegroup, will be used as backup for the nodegroup.  
       * Enabled - When one of the nodes goes down, no other cluster node is picked up to replace it. When the node comes up, it will continue being part of the nodegroup.  
       * Disabled - When one of the nodes goes down, a non-nodegroup cluster node is picked up and acts as part of the nodegroup. When the original node of the nodegroup comes up, the backup node will be replaced.  
       Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCUnsetClusternodegroup -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetClusternodegroup
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup
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

        [Boolean]$strict 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetClusternodegroup: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('strict')) { $Payload.Add('strict', $strict) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset cluster configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type clusternodegroup -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetClusternodegroup: Finished"
    }
}

function Invoke-ADCDeleteClusternodegroup {
<#
    .SYNOPSIS
        Delete cluster configuration Object
    .DESCRIPTION
        Delete cluster configuration Object
    .PARAMETER name 
       Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteClusternodegroup -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroup
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup/
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
        Write-Verbose "Invoke-ADCDeleteClusternodegroup: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete cluster configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteClusternodegroup: Finished"
    }
}

function Invoke-ADCGetClusternodegroup {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER name 
       Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER GetAll 
        Retreive all clusternodegroup object(s)
    .PARAMETER Count
        If specified, the count of the clusternodegroup object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusternodegroup
    .EXAMPLE 
        Invoke-ADCGetClusternodegroup -GetAll 
    .EXAMPLE 
        Invoke-ADCGetClusternodegroup -Count
    .EXAMPLE
        Invoke-ADCGetClusternodegroup -name <string>
    .EXAMPLE
        Invoke-ADCGetClusternodegroup -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusternodegroup
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup/
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
        Write-Verbose "Invoke-ADCGetClusternodegroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all clusternodegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternodegroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusternodegroup: Ended"
    }
}

function Invoke-ADCAddClusternodegroupauthenticationvserverbinding {
<#
    .SYNOPSIS
        Add cluster configuration Object
    .DESCRIPTION
        Add cluster configuration Object 
    .PARAMETER name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
        Minimum length = 1 
    .PARAMETER vserver 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_authenticationvserver_binding item.
    .EXAMPLE
        Invoke-ADCAddClusternodegroupauthenticationvserverbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupauthenticationvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_authenticationvserver_binding/
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

        [string]$vserver ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupauthenticationvserverbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Payload.Add('vserver', $vserver) }
 
            if ($PSCmdlet.ShouldProcess("clusternodegroup_authenticationvserver_binding", "Add cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_authenticationvserver_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetClusternodegroupauthenticationvserverbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddClusternodegroupauthenticationvserverbinding: Finished"
    }
}

function Invoke-ADCDeleteClusternodegroupauthenticationvserverbinding {
<#
    .SYNOPSIS
        Delete cluster configuration Object
    .DESCRIPTION
        Delete cluster configuration Object
     .PARAMETER name 
       Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
       Minimum length = 1    .PARAMETER vserver 
       vserver that need to be bound to this nodegroup.
    .EXAMPLE
        Invoke-ADCDeleteClusternodegroupauthenticationvserverbinding 
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupauthenticationvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_authenticationvserver_binding/
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

        [string]$name ,

        [string]$vserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupauthenticationvserverbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('name')) { $Arguments.Add('name', $name) }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Arguments.Add('vserver', $vserver) }
            if ($PSCmdlet.ShouldProcess("clusternodegroup_authenticationvserver_binding", "Delete cluster configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_authenticationvserver_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteClusternodegroupauthenticationvserverbinding: Finished"
    }
}

function Invoke-ADCGetClusternodegroupauthenticationvserverbinding {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER GetAll 
        Retreive all clusternodegroup_authenticationvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the clusternodegroup_authenticationvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusternodegroupauthenticationvserverbinding
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupauthenticationvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupauthenticationvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetClusternodegroupauthenticationvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetClusternodegroupauthenticationvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupauthenticationvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_authenticationvserver_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupauthenticationvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all clusternodegroup_authenticationvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_authenticationvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_authenticationvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_authenticationvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_authenticationvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_authenticationvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_authenticationvserver_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_authenticationvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_authenticationvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusternodegroupauthenticationvserverbinding: Ended"
    }
}

function Invoke-ADCGetClusternodegroupbinding {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER name 
       Name of the nodegroup to be displayed. If a name is not provided, information about all nodegroups is displayed. 
    .PARAMETER GetAll 
        Retreive all clusternodegroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the clusternodegroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusternodegroupbinding
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetClusternodegroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetClusternodegroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all clusternodegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternodegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusternodegroupbinding: Ended"
    }
}

function Invoke-ADCAddClusternodegroupclusternodebinding {
<#
    .SYNOPSIS
        Add cluster configuration Object
    .DESCRIPTION
        Add cluster configuration Object 
    .PARAMETER name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
        Minimum length = 1 
    .PARAMETER node 
        Nodes in the nodegroup.  
        Minimum value = 0  
        Maximum value = 31 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_clusternode_binding item.
    .EXAMPLE
        Invoke-ADCAddClusternodegroupclusternodebinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupclusternodebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_clusternode_binding/
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

        [ValidateRange(0, 31)]
        [double]$node ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupclusternodebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('node')) { $Payload.Add('node', $node) }
 
            if ($PSCmdlet.ShouldProcess("clusternodegroup_clusternode_binding", "Add cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_clusternode_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetClusternodegroupclusternodebinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddClusternodegroupclusternodebinding: Finished"
    }
}

function Invoke-ADCDeleteClusternodegroupclusternodebinding {
<#
    .SYNOPSIS
        Delete cluster configuration Object
    .DESCRIPTION
        Delete cluster configuration Object
     .PARAMETER name 
       Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
       Minimum length = 1    .PARAMETER node 
       Nodes in the nodegroup.  
       Minimum value = 0  
       Maximum value = 31
    .EXAMPLE
        Invoke-ADCDeleteClusternodegroupclusternodebinding 
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupclusternodebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_clusternode_binding/
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

        [string]$name ,

        [double]$node 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupclusternodebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('name')) { $Arguments.Add('name', $name) }
            if ($PSBoundParameters.ContainsKey('node')) { $Arguments.Add('node', $node) }
            if ($PSCmdlet.ShouldProcess("clusternodegroup_clusternode_binding", "Delete cluster configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_clusternode_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteClusternodegroupclusternodebinding: Finished"
    }
}

function Invoke-ADCGetClusternodegroupclusternodebinding {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER GetAll 
        Retreive all clusternodegroup_clusternode_binding object(s)
    .PARAMETER Count
        If specified, the count of the clusternodegroup_clusternode_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusternodegroupclusternodebinding
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupclusternodebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupclusternodebinding -Count
    .EXAMPLE
        Invoke-ADCGetClusternodegroupclusternodebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetClusternodegroupclusternodebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupclusternodebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_clusternode_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupclusternodebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all clusternodegroup_clusternode_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_clusternode_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_clusternode_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_clusternode_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_clusternode_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_clusternode_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_clusternode_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_clusternode_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_clusternode_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusternodegroupclusternodebinding: Ended"
    }
}

function Invoke-ADCAddClusternodegroupcrvserverbinding {
<#
    .SYNOPSIS
        Add cluster configuration Object
    .DESCRIPTION
        Add cluster configuration Object 
    .PARAMETER name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
        Minimum length = 1 
    .PARAMETER vserver 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_crvserver_binding item.
    .EXAMPLE
        Invoke-ADCAddClusternodegroupcrvserverbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupcrvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_crvserver_binding/
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

        [string]$vserver ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupcrvserverbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Payload.Add('vserver', $vserver) }
 
            if ($PSCmdlet.ShouldProcess("clusternodegroup_crvserver_binding", "Add cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_crvserver_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetClusternodegroupcrvserverbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddClusternodegroupcrvserverbinding: Finished"
    }
}

function Invoke-ADCDeleteClusternodegroupcrvserverbinding {
<#
    .SYNOPSIS
        Delete cluster configuration Object
    .DESCRIPTION
        Delete cluster configuration Object
     .PARAMETER name 
       Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
       Minimum length = 1    .PARAMETER vserver 
       vserver that need to be bound to this nodegroup.
    .EXAMPLE
        Invoke-ADCDeleteClusternodegroupcrvserverbinding 
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupcrvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_crvserver_binding/
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

        [string]$name ,

        [string]$vserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupcrvserverbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('name')) { $Arguments.Add('name', $name) }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Arguments.Add('vserver', $vserver) }
            if ($PSCmdlet.ShouldProcess("clusternodegroup_crvserver_binding", "Delete cluster configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_crvserver_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteClusternodegroupcrvserverbinding: Finished"
    }
}

function Invoke-ADCGetClusternodegroupcrvserverbinding {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER GetAll 
        Retreive all clusternodegroup_crvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the clusternodegroup_crvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusternodegroupcrvserverbinding
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupcrvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupcrvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetClusternodegroupcrvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetClusternodegroupcrvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupcrvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_crvserver_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupcrvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all clusternodegroup_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_crvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_crvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_crvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_crvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_crvserver_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_crvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_crvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusternodegroupcrvserverbinding: Ended"
    }
}

function Invoke-ADCAddClusternodegroupcsvserverbinding {
<#
    .SYNOPSIS
        Add cluster configuration Object
    .DESCRIPTION
        Add cluster configuration Object 
    .PARAMETER name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
        Minimum length = 1 
    .PARAMETER vserver 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_csvserver_binding item.
    .EXAMPLE
        Invoke-ADCAddClusternodegroupcsvserverbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupcsvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_csvserver_binding/
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

        [string]$vserver ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupcsvserverbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Payload.Add('vserver', $vserver) }
 
            if ($PSCmdlet.ShouldProcess("clusternodegroup_csvserver_binding", "Add cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_csvserver_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetClusternodegroupcsvserverbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddClusternodegroupcsvserverbinding: Finished"
    }
}

function Invoke-ADCDeleteClusternodegroupcsvserverbinding {
<#
    .SYNOPSIS
        Delete cluster configuration Object
    .DESCRIPTION
        Delete cluster configuration Object
     .PARAMETER name 
       Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
       Minimum length = 1    .PARAMETER vserver 
       vserver that need to be bound to this nodegroup.
    .EXAMPLE
        Invoke-ADCDeleteClusternodegroupcsvserverbinding 
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupcsvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_csvserver_binding/
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

        [string]$name ,

        [string]$vserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupcsvserverbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('name')) { $Arguments.Add('name', $name) }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Arguments.Add('vserver', $vserver) }
            if ($PSCmdlet.ShouldProcess("clusternodegroup_csvserver_binding", "Delete cluster configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_csvserver_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteClusternodegroupcsvserverbinding: Finished"
    }
}

function Invoke-ADCGetClusternodegroupcsvserverbinding {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER GetAll 
        Retreive all clusternodegroup_csvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the clusternodegroup_csvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusternodegroupcsvserverbinding
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupcsvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupcsvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetClusternodegroupcsvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetClusternodegroupcsvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupcsvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupcsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all clusternodegroup_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_csvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_csvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_csvserver_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusternodegroupcsvserverbinding: Ended"
    }
}

function Invoke-ADCAddClusternodegroupgslbsitebinding {
<#
    .SYNOPSIS
        Add cluster configuration Object
    .DESCRIPTION
        Add cluster configuration Object 
    .PARAMETER name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
        Minimum length = 1 
    .PARAMETER gslbsite 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_gslbsite_binding item.
    .EXAMPLE
        Invoke-ADCAddClusternodegroupgslbsitebinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupgslbsitebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_gslbsite_binding/
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

        [string]$gslbsite ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupgslbsitebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('gslbsite')) { $Payload.Add('gslbsite', $gslbsite) }
 
            if ($PSCmdlet.ShouldProcess("clusternodegroup_gslbsite_binding", "Add cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_gslbsite_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetClusternodegroupgslbsitebinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddClusternodegroupgslbsitebinding: Finished"
    }
}

function Invoke-ADCDeleteClusternodegroupgslbsitebinding {
<#
    .SYNOPSIS
        Delete cluster configuration Object
    .DESCRIPTION
        Delete cluster configuration Object
     .PARAMETER name 
       Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
       Minimum length = 1    .PARAMETER gslbsite 
       vserver that need to be bound to this nodegroup.
    .EXAMPLE
        Invoke-ADCDeleteClusternodegroupgslbsitebinding 
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupgslbsitebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_gslbsite_binding/
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

        [string]$name ,

        [string]$gslbsite 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupgslbsitebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('name')) { $Arguments.Add('name', $name) }
            if ($PSBoundParameters.ContainsKey('gslbsite')) { $Arguments.Add('gslbsite', $gslbsite) }
            if ($PSCmdlet.ShouldProcess("clusternodegroup_gslbsite_binding", "Delete cluster configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_gslbsite_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteClusternodegroupgslbsitebinding: Finished"
    }
}

function Invoke-ADCGetClusternodegroupgslbsitebinding {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER GetAll 
        Retreive all clusternodegroup_gslbsite_binding object(s)
    .PARAMETER Count
        If specified, the count of the clusternodegroup_gslbsite_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusternodegroupgslbsitebinding
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupgslbsitebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupgslbsitebinding -Count
    .EXAMPLE
        Invoke-ADCGetClusternodegroupgslbsitebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetClusternodegroupgslbsitebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupgslbsitebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_gslbsite_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupgslbsitebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all clusternodegroup_gslbsite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_gslbsite_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_gslbsite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_gslbsite_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_gslbsite_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_gslbsite_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_gslbsite_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_gslbsite_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_gslbsite_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusternodegroupgslbsitebinding: Ended"
    }
}

function Invoke-ADCAddClusternodegroupgslbvserverbinding {
<#
    .SYNOPSIS
        Add cluster configuration Object
    .DESCRIPTION
        Add cluster configuration Object 
    .PARAMETER name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
        Minimum length = 1 
    .PARAMETER vserver 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_gslbvserver_binding item.
    .EXAMPLE
        Invoke-ADCAddClusternodegroupgslbvserverbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupgslbvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_gslbvserver_binding/
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

        [string]$vserver ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupgslbvserverbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Payload.Add('vserver', $vserver) }
 
            if ($PSCmdlet.ShouldProcess("clusternodegroup_gslbvserver_binding", "Add cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_gslbvserver_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetClusternodegroupgslbvserverbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddClusternodegroupgslbvserverbinding: Finished"
    }
}

function Invoke-ADCDeleteClusternodegroupgslbvserverbinding {
<#
    .SYNOPSIS
        Delete cluster configuration Object
    .DESCRIPTION
        Delete cluster configuration Object
     .PARAMETER name 
       Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
       Minimum length = 1    .PARAMETER vserver 
       vserver that need to be bound to this nodegroup.
    .EXAMPLE
        Invoke-ADCDeleteClusternodegroupgslbvserverbinding 
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupgslbvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_gslbvserver_binding/
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

        [string]$name ,

        [string]$vserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupgslbvserverbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('name')) { $Arguments.Add('name', $name) }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Arguments.Add('vserver', $vserver) }
            if ($PSCmdlet.ShouldProcess("clusternodegroup_gslbvserver_binding", "Delete cluster configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_gslbvserver_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteClusternodegroupgslbvserverbinding: Finished"
    }
}

function Invoke-ADCGetClusternodegroupgslbvserverbinding {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER GetAll 
        Retreive all clusternodegroup_gslbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the clusternodegroup_gslbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusternodegroupgslbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupgslbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupgslbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetClusternodegroupgslbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetClusternodegroupgslbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupgslbvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_gslbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupgslbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all clusternodegroup_gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_gslbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_gslbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_gslbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_gslbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_gslbvserver_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_gslbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_gslbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusternodegroupgslbvserverbinding: Ended"
    }
}

function Invoke-ADCAddClusternodegrouplbvserverbinding {
<#
    .SYNOPSIS
        Add cluster configuration Object
    .DESCRIPTION
        Add cluster configuration Object 
    .PARAMETER name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
        Minimum length = 1 
    .PARAMETER vserver 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_lbvserver_binding item.
    .EXAMPLE
        Invoke-ADCAddClusternodegrouplbvserverbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddClusternodegrouplbvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_lbvserver_binding/
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

        [string]$vserver ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegrouplbvserverbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Payload.Add('vserver', $vserver) }
 
            if ($PSCmdlet.ShouldProcess("clusternodegroup_lbvserver_binding", "Add cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_lbvserver_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetClusternodegrouplbvserverbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddClusternodegrouplbvserverbinding: Finished"
    }
}

function Invoke-ADCDeleteClusternodegrouplbvserverbinding {
<#
    .SYNOPSIS
        Delete cluster configuration Object
    .DESCRIPTION
        Delete cluster configuration Object
     .PARAMETER name 
       Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
       Minimum length = 1    .PARAMETER vserver 
       vserver that need to be bound to this nodegroup.
    .EXAMPLE
        Invoke-ADCDeleteClusternodegrouplbvserverbinding 
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegrouplbvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_lbvserver_binding/
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

        [string]$name ,

        [string]$vserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegrouplbvserverbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('name')) { $Arguments.Add('name', $name) }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Arguments.Add('vserver', $vserver) }
            if ($PSCmdlet.ShouldProcess("clusternodegroup_lbvserver_binding", "Delete cluster configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_lbvserver_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteClusternodegrouplbvserverbinding: Finished"
    }
}

function Invoke-ADCGetClusternodegrouplbvserverbinding {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER GetAll 
        Retreive all clusternodegroup_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the clusternodegroup_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusternodegrouplbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetClusternodegrouplbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetClusternodegrouplbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetClusternodegrouplbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetClusternodegrouplbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusternodegrouplbvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegrouplbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all clusternodegroup_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_lbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_lbvserver_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusternodegrouplbvserverbinding: Ended"
    }
}

function Invoke-ADCAddClusternodegroupnslimitidentifierbinding {
<#
    .SYNOPSIS
        Add cluster configuration Object
    .DESCRIPTION
        Add cluster configuration Object 
    .PARAMETER name 
        Name of the nodegroup to which you want to bind a cluster node or an entity.  
        Minimum length = 1 
    .PARAMETER identifiername 
        stream identifier and rate limit identifier that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_nslimitidentifier_binding item.
    .EXAMPLE
        Invoke-ADCAddClusternodegroupnslimitidentifierbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupnslimitidentifierbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_nslimitidentifier_binding/
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

        [string]$identifiername ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupnslimitidentifierbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('identifiername')) { $Payload.Add('identifiername', $identifiername) }
 
            if ($PSCmdlet.ShouldProcess("clusternodegroup_nslimitidentifier_binding", "Add cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_nslimitidentifier_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetClusternodegroupnslimitidentifierbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddClusternodegroupnslimitidentifierbinding: Finished"
    }
}

function Invoke-ADCDeleteClusternodegroupnslimitidentifierbinding {
<#
    .SYNOPSIS
        Delete cluster configuration Object
    .DESCRIPTION
        Delete cluster configuration Object
    .PARAMETER name 
       Name of the nodegroup to which you want to bind a cluster node or an entity.  
       Minimum length = 1    .PARAMETER identifiername 
       stream identifier and rate limit identifier that need to be bound to this nodegroup.
    .EXAMPLE
        Invoke-ADCDeleteClusternodegroupnslimitidentifierbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupnslimitidentifierbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_nslimitidentifier_binding/
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

        [string]$identifiername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupnslimitidentifierbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('identifiername')) { $Arguments.Add('identifiername', $identifiername) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete cluster configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_nslimitidentifier_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteClusternodegroupnslimitidentifierbinding: Finished"
    }
}

function Invoke-ADCGetClusternodegroupnslimitidentifierbinding {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER name 
       Name of the nodegroup to which you want to bind a cluster node or an entity. 
    .PARAMETER GetAll 
        Retreive all clusternodegroup_nslimitidentifier_binding object(s)
    .PARAMETER Count
        If specified, the count of the clusternodegroup_nslimitidentifier_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusternodegroupnslimitidentifierbinding
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupnslimitidentifierbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupnslimitidentifierbinding -Count
    .EXAMPLE
        Invoke-ADCGetClusternodegroupnslimitidentifierbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetClusternodegroupnslimitidentifierbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupnslimitidentifierbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_nslimitidentifier_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupnslimitidentifierbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all clusternodegroup_nslimitidentifier_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_nslimitidentifier_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_nslimitidentifier_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_nslimitidentifier_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_nslimitidentifier_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_nslimitidentifier_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_nslimitidentifier_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_nslimitidentifier_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternodegroup_nslimitidentifier_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_nslimitidentifier_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusternodegroupnslimitidentifierbinding: Ended"
    }
}

function Invoke-ADCAddClusternodegroupservicebinding {
<#
    .SYNOPSIS
        Add cluster configuration Object
    .DESCRIPTION
        Add cluster configuration Object 
    .PARAMETER name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
        Minimum length = 1 
    .PARAMETER service 
        name of the service bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_service_binding item.
    .EXAMPLE
        Invoke-ADCAddClusternodegroupservicebinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupservicebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_service_binding/
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

        [string]$service ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupservicebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('service')) { $Payload.Add('service', $service) }
 
            if ($PSCmdlet.ShouldProcess("clusternodegroup_service_binding", "Add cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_service_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetClusternodegroupservicebinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddClusternodegroupservicebinding: Finished"
    }
}

function Invoke-ADCDeleteClusternodegroupservicebinding {
<#
    .SYNOPSIS
        Delete cluster configuration Object
    .DESCRIPTION
        Delete cluster configuration Object
     .PARAMETER name 
       Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
       Minimum length = 1    .PARAMETER service 
       name of the service bound to this nodegroup.
    .EXAMPLE
        Invoke-ADCDeleteClusternodegroupservicebinding 
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupservicebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_service_binding/
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

        [string]$name ,

        [string]$service 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupservicebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('name')) { $Arguments.Add('name', $name) }
            if ($PSBoundParameters.ContainsKey('service')) { $Arguments.Add('service', $service) }
            if ($PSCmdlet.ShouldProcess("clusternodegroup_service_binding", "Delete cluster configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_service_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteClusternodegroupservicebinding: Finished"
    }
}

function Invoke-ADCGetClusternodegroupservicebinding {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER GetAll 
        Retreive all clusternodegroup_service_binding object(s)
    .PARAMETER Count
        If specified, the count of the clusternodegroup_service_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusternodegroupservicebinding
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupservicebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupservicebinding -Count
    .EXAMPLE
        Invoke-ADCGetClusternodegroupservicebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetClusternodegroupservicebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupservicebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_service_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupservicebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all clusternodegroup_service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_service_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_service_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_service_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_service_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_service_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_service_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_service_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusternodegroupservicebinding: Ended"
    }
}

function Invoke-ADCAddClusternodegroupstreamidentifierbinding {
<#
    .SYNOPSIS
        Add cluster configuration Object
    .DESCRIPTION
        Add cluster configuration Object 
    .PARAMETER name 
        Name of the nodegroup to which you want to bind a cluster node or an entity.  
        Minimum length = 1 
    .PARAMETER identifiername 
        stream identifier and rate limit identifier that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_streamidentifier_binding item.
    .EXAMPLE
        Invoke-ADCAddClusternodegroupstreamidentifierbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupstreamidentifierbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_streamidentifier_binding/
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

        [string]$identifiername ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupstreamidentifierbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('identifiername')) { $Payload.Add('identifiername', $identifiername) }
 
            if ($PSCmdlet.ShouldProcess("clusternodegroup_streamidentifier_binding", "Add cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_streamidentifier_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetClusternodegroupstreamidentifierbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddClusternodegroupstreamidentifierbinding: Finished"
    }
}

function Invoke-ADCDeleteClusternodegroupstreamidentifierbinding {
<#
    .SYNOPSIS
        Delete cluster configuration Object
    .DESCRIPTION
        Delete cluster configuration Object
    .PARAMETER name 
       Name of the nodegroup to which you want to bind a cluster node or an entity.  
       Minimum length = 1    .PARAMETER identifiername 
       stream identifier and rate limit identifier that need to be bound to this nodegroup.
    .EXAMPLE
        Invoke-ADCDeleteClusternodegroupstreamidentifierbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupstreamidentifierbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_streamidentifier_binding/
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

        [string]$identifiername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupstreamidentifierbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('identifiername')) { $Arguments.Add('identifiername', $identifiername) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete cluster configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_streamidentifier_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteClusternodegroupstreamidentifierbinding: Finished"
    }
}

function Invoke-ADCGetClusternodegroupstreamidentifierbinding {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER name 
       Name of the nodegroup to which you want to bind a cluster node or an entity. 
    .PARAMETER GetAll 
        Retreive all clusternodegroup_streamidentifier_binding object(s)
    .PARAMETER Count
        If specified, the count of the clusternodegroup_streamidentifier_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusternodegroupstreamidentifierbinding
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupstreamidentifierbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupstreamidentifierbinding -Count
    .EXAMPLE
        Invoke-ADCGetClusternodegroupstreamidentifierbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetClusternodegroupstreamidentifierbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupstreamidentifierbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_streamidentifier_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupstreamidentifierbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all clusternodegroup_streamidentifier_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_streamidentifier_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_streamidentifier_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_streamidentifier_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_streamidentifier_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_streamidentifier_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_streamidentifier_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_streamidentifier_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternodegroup_streamidentifier_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_streamidentifier_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusternodegroupstreamidentifierbinding: Ended"
    }
}

function Invoke-ADCAddClusternodegroupvpnvserverbinding {
<#
    .SYNOPSIS
        Add cluster configuration Object
    .DESCRIPTION
        Add cluster configuration Object 
    .PARAMETER name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
        Minimum length = 1 
    .PARAMETER vserver 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_vpnvserver_binding item.
    .EXAMPLE
        Invoke-ADCAddClusternodegroupvpnvserverbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupvpnvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_vpnvserver_binding/
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

        [string]$vserver ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupvpnvserverbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Payload.Add('vserver', $vserver) }
 
            if ($PSCmdlet.ShouldProcess("clusternodegroup_vpnvserver_binding", "Add cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_vpnvserver_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetClusternodegroupvpnvserverbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddClusternodegroupvpnvserverbinding: Finished"
    }
}

function Invoke-ADCDeleteClusternodegroupvpnvserverbinding {
<#
    .SYNOPSIS
        Delete cluster configuration Object
    .DESCRIPTION
        Delete cluster configuration Object
     .PARAMETER name 
       Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.  
       Minimum length = 1    .PARAMETER vserver 
       vserver that need to be bound to this nodegroup.
    .EXAMPLE
        Invoke-ADCDeleteClusternodegroupvpnvserverbinding 
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupvpnvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_vpnvserver_binding/
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

        [string]$name ,

        [string]$vserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupvpnvserverbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('name')) { $Arguments.Add('name', $name) }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Arguments.Add('vserver', $vserver) }
            if ($PSCmdlet.ShouldProcess("clusternodegroup_vpnvserver_binding", "Delete cluster configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_vpnvserver_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteClusternodegroupvpnvserverbinding: Finished"
    }
}

function Invoke-ADCGetClusternodegroupvpnvserverbinding {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER GetAll 
        Retreive all clusternodegroup_vpnvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the clusternodegroup_vpnvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusternodegroupvpnvserverbinding
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupvpnvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetClusternodegroupvpnvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetClusternodegroupvpnvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetClusternodegroupvpnvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupvpnvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_vpnvserver_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupvpnvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all clusternodegroup_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_vpnvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_vpnvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_vpnvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_vpnvserver_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_vpnvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusternodegroupvpnvserverbinding: Ended"
    }
}

function Invoke-ADCGetClusternodebinding {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER nodeid 
       ID of the cluster node for which to display information. If an ID is not provided, information about all nodes is shown. 
    .PARAMETER GetAll 
        Retreive all clusternode_binding object(s)
    .PARAMETER Count
        If specified, the count of the clusternode_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusternodebinding
    .EXAMPLE 
        Invoke-ADCGetClusternodebinding -GetAll
    .EXAMPLE
        Invoke-ADCGetClusternodebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetClusternodebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusternodebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternode_binding/
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
        [ValidateRange(0, 31)]
        [double]$nodeid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetClusternodebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all clusternode_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternode_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternode_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternode_binding configuration for property 'nodeid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_binding -NitroPath nitro/v1/config -Resource $nodeid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternode_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusternodebinding: Ended"
    }
}

function Invoke-ADCAddClusternoderoutemonitorbinding {
<#
    .SYNOPSIS
        Add cluster configuration Object
    .DESCRIPTION
        Add cluster configuration Object 
    .PARAMETER nodeid 
        A number that uniquely identifies the cluster node. .  
        Minimum value = 0  
        Maximum value = 31 
    .PARAMETER routemonitor 
        The IP address (IPv4 or IPv6). 
    .PARAMETER netmask 
        The netmask. 
    .PARAMETER PassThru 
        Return details about the created clusternode_routemonitor_binding item.
    .EXAMPLE
        Invoke-ADCAddClusternoderoutemonitorbinding -nodeid <double> -routemonitor <string>
    .NOTES
        File Name : Invoke-ADCAddClusternoderoutemonitorbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternode_routemonitor_binding/
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
        [ValidateRange(0, 31)]
        [double]$nodeid ,

        [Parameter(Mandatory = $true)]
        [string]$routemonitor ,

        [string]$netmask ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternoderoutemonitorbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                nodeid = $nodeid
                routemonitor = $routemonitor
            }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Payload.Add('netmask', $netmask) }
 
            if ($PSCmdlet.ShouldProcess("clusternode_routemonitor_binding", "Add cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternode_routemonitor_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetClusternoderoutemonitorbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddClusternoderoutemonitorbinding: Finished"
    }
}

function Invoke-ADCDeleteClusternoderoutemonitorbinding {
<#
    .SYNOPSIS
        Delete cluster configuration Object
    .DESCRIPTION
        Delete cluster configuration Object
    .PARAMETER nodeid 
       A number that uniquely identifies the cluster node. .  
       Minimum value = 0  
       Maximum value = 31    .PARAMETER routemonitor 
       The IP address (IPv4 or IPv6).    .PARAMETER netmask 
       The netmask.
    .EXAMPLE
        Invoke-ADCDeleteClusternoderoutemonitorbinding -nodeid <double>
    .NOTES
        File Name : Invoke-ADCDeleteClusternoderoutemonitorbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternode_routemonitor_binding/
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
        [double]$nodeid ,

        [string]$routemonitor ,

        [string]$netmask 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternoderoutemonitorbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('routemonitor')) { $Arguments.Add('routemonitor', $routemonitor) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Arguments.Add('netmask', $netmask) }
            if ($PSCmdlet.ShouldProcess("$nodeid", "Delete cluster configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternode_routemonitor_binding -NitroPath nitro/v1/config -Resource $nodeid -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteClusternoderoutemonitorbinding: Finished"
    }
}

function Invoke-ADCGetClusternoderoutemonitorbinding {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER nodeid 
       A number that uniquely identifies the cluster node. . 
    .PARAMETER GetAll 
        Retreive all clusternode_routemonitor_binding object(s)
    .PARAMETER Count
        If specified, the count of the clusternode_routemonitor_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusternoderoutemonitorbinding
    .EXAMPLE 
        Invoke-ADCGetClusternoderoutemonitorbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetClusternoderoutemonitorbinding -Count
    .EXAMPLE
        Invoke-ADCGetClusternoderoutemonitorbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetClusternoderoutemonitorbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusternoderoutemonitorbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternode_routemonitor_binding/
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
        [ValidateRange(0, 31)]
        [double]$nodeid,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetClusternoderoutemonitorbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all clusternode_routemonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_routemonitor_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternode_routemonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_routemonitor_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternode_routemonitor_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_routemonitor_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternode_routemonitor_binding configuration for property 'nodeid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_routemonitor_binding -NitroPath nitro/v1/config -Resource $nodeid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternode_routemonitor_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_routemonitor_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusternoderoutemonitorbinding: Ended"
    }
}

function Invoke-ADCClearClusterpropstatus {
<#
    .SYNOPSIS
        Clear cluster configuration Object
    .DESCRIPTION
        Clear cluster configuration Object 
    .EXAMPLE
        Invoke-ADCClearClusterpropstatus 
    .NOTES
        File Name : Invoke-ADCClearClusterpropstatus
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterpropstatus/
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
        Write-Verbose "Invoke-ADCClearClusterpropstatus: Starting"
    }
    process {
        try {
            $Payload = @{

            }

            if ($PSCmdlet.ShouldProcess($Name, "Clear cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type clusterpropstatus -Action clear -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCClearClusterpropstatus: Finished"
    }
}

function Invoke-ADCGetClusterpropstatus {
<#
    .SYNOPSIS
        Get cluster configuration object(s)
    .DESCRIPTION
        Get cluster configuration object(s)
    .PARAMETER nodeid 
       Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retreive all clusterpropstatus object(s)
    .PARAMETER Count
        If specified, the count of the clusterpropstatus object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusterpropstatus
    .EXAMPLE 
        Invoke-ADCGetClusterpropstatus -GetAll 
    .EXAMPLE 
        Invoke-ADCGetClusterpropstatus -Count
    .EXAMPLE
        Invoke-ADCGetClusterpropstatus -name <string>
    .EXAMPLE
        Invoke-ADCGetClusterpropstatus -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusterpropstatus
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterpropstatus/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetClusterpropstatus: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all clusterpropstatus objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterpropstatus -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusterpropstatus objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterpropstatus -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusterpropstatus objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('nodeid')) { $Arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterpropstatus -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusterpropstatus configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusterpropstatus configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterpropstatus -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusterpropstatus: Ended"
    }
}

function Invoke-ADCForceClustersync {
<#
    .SYNOPSIS
        Force cluster configuration Object
    .DESCRIPTION
        Force cluster configuration Object 
    .EXAMPLE
        Invoke-ADCForceClustersync 
    .NOTES
        File Name : Invoke-ADCForceClustersync
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clustersync/
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
        Write-Verbose "Invoke-ADCForceClustersync: Starting"
    }
    process {
        try {
            $Payload = @{

            }

            if ($PSCmdlet.ShouldProcess($Name, "Force cluster configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type clustersync -Action force -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCForceClustersync: Finished"
    }
}


