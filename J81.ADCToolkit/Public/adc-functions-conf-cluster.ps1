function Invoke-ADCSyncClusterfiles {
    <#
    .SYNOPSIS
        Sync cluster configuration Object.
    .DESCRIPTION
        Configuration for files resource.
    .PARAMETER Mode 
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
        PS C:\>Invoke-ADCSyncClusterfiles 
        An example how to sync clusterfiles configuration Object(s).
    .NOTES
        File Name : Invoke-ADCSyncClusterfiles
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterfiles/
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

        [ValidateSet('all', 'bookmarks', 'ssl', 'htmlinjection', 'imports', 'misc', 'dns', 'krb', 'AAA', 'app_catalog', 'all_plus_misc', 'all_minus_misc')]
        [string[]]$Mode 

    )
    begin {
        Write-Verbose "Invoke-ADCSyncClusterfiles: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('mode') ) { $payload.Add('mode', $mode) }
            if ( $PSCmdlet.ShouldProcess($Name, "Sync cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type clusterfiles -Action sync -Payload $payload -GetWarning
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
        Add cluster configuration Object.
    .DESCRIPTION
        Configuration for cluster instance resource.
    .PARAMETER Clid 
        Unique number that identifies the cluster. 
    .PARAMETER Deadinterval 
        Amount of time, in seconds, after which nodes that do not respond to the heartbeats are assumed to be down.If the value is less than 3 sec, set the helloInterval parameter to 200 msec. 
    .PARAMETER Hellointerval 
        Interval, in milliseconds, at which heartbeats are sent to each cluster node to check the health status.Set the value to 200 msec, if the deadInterval parameter is less than 3 sec. 
    .PARAMETER Preemption 
        Preempt a cluster node that is configured as a SPARE if an ACTIVE node becomes available. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Quorumtype 
        Quorum Configuration Choices - "Majority" (recommended) requires majority of nodes to be online for the cluster to be UP. "None" relaxes this requirement. 
        Possible values = MAJORITY, NONE 
    .PARAMETER Inc 
        This option is required if the cluster nodes reside on different networks. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Processlocal 
        By turning on this option packets destined to a service in a cluster will not under go any steering. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Retainconnectionsoncluster 
        This option enables you to retain existing connections on a node joining a Cluster system or when a node is being configured for passive timeout. By default, this option is disabled. 
        Possible values = YES, NO 
    .PARAMETER Backplanebasedview 
        View based on heartbeat only on bkplane interface. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Syncstatusstrictmode 
        strict mode for sync status of cluster. Depending on the the mode if there are any errors while applying config, sync status is displayed accordingly. By default the flag is disabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created clusterinstance item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddClusterinstance -clid <double>
        An example how to add clusterinstance configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddClusterinstance
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterinstance/
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
        [ValidateRange(1, 16)]
        [double]$Clid,

        [ValidateRange(1, 60)]
        [double]$Deadinterval = '3',

        [ValidateRange(200, 1000)]
        [double]$Hellointerval = '200',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Preemption = 'DISABLED',

        [ValidateSet('MAJORITY', 'NONE')]
        [string]$Quorumtype = 'MAJORITY',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Inc = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Processlocal = 'DISABLED',

        [ValidateSet('YES', 'NO')]
        [string]$Retainconnectionsoncluster = 'NO',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Backplanebasedview = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Syncstatusstrictmode = 'DISABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddClusterinstance: Starting"
    }
    process {
        try {
            $payload = @{ clid = $clid }
            if ( $PSBoundParameters.ContainsKey('deadinterval') ) { $payload.Add('deadinterval', $deadinterval) }
            if ( $PSBoundParameters.ContainsKey('hellointerval') ) { $payload.Add('hellointerval', $hellointerval) }
            if ( $PSBoundParameters.ContainsKey('preemption') ) { $payload.Add('preemption', $preemption) }
            if ( $PSBoundParameters.ContainsKey('quorumtype') ) { $payload.Add('quorumtype', $quorumtype) }
            if ( $PSBoundParameters.ContainsKey('inc') ) { $payload.Add('inc', $inc) }
            if ( $PSBoundParameters.ContainsKey('processlocal') ) { $payload.Add('processlocal', $processlocal) }
            if ( $PSBoundParameters.ContainsKey('retainconnectionsoncluster') ) { $payload.Add('retainconnectionsoncluster', $retainconnectionsoncluster) }
            if ( $PSBoundParameters.ContainsKey('backplanebasedview') ) { $payload.Add('backplanebasedview', $backplanebasedview) }
            if ( $PSBoundParameters.ContainsKey('syncstatusstrictmode') ) { $payload.Add('syncstatusstrictmode', $syncstatusstrictmode) }
            if ( $PSCmdlet.ShouldProcess("clusterinstance", "Add cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type clusterinstance -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetClusterinstance -Filter $payload)
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
        Delete cluster configuration Object.
    .DESCRIPTION
        Configuration for cluster instance resource.
    .PARAMETER Clid 
        Unique number that identifies the cluster.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteClusterinstance -Clid <double>
        An example how to delete clusterinstance configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteClusterinstance
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterinstance/
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
        [double]$Clid 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusterinstance: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$clid", "Delete cluster configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusterinstance -NitroPath nitro/v1/config -Resource $clid -Arguments $arguments
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
        Update cluster configuration Object.
    .DESCRIPTION
        Configuration for cluster instance resource.
    .PARAMETER Clid 
        Unique number that identifies the cluster. 
    .PARAMETER Deadinterval 
        Amount of time, in seconds, after which nodes that do not respond to the heartbeats are assumed to be down.If the value is less than 3 sec, set the helloInterval parameter to 200 msec. 
    .PARAMETER Hellointerval 
        Interval, in milliseconds, at which heartbeats are sent to each cluster node to check the health status.Set the value to 200 msec, if the deadInterval parameter is less than 3 sec. 
    .PARAMETER Preemption 
        Preempt a cluster node that is configured as a SPARE if an ACTIVE node becomes available. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Quorumtype 
        Quorum Configuration Choices - "Majority" (recommended) requires majority of nodes to be online for the cluster to be UP. "None" relaxes this requirement. 
        Possible values = MAJORITY, NONE 
    .PARAMETER Inc 
        This option is required if the cluster nodes reside on different networks. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Processlocal 
        By turning on this option packets destined to a service in a cluster will not under go any steering. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nodegroup 
        The node group in a Cluster system used for transition from L2 to L3. 
    .PARAMETER Retainconnectionsoncluster 
        This option enables you to retain existing connections on a node joining a Cluster system or when a node is being configured for passive timeout. By default, this option is disabled. 
        Possible values = YES, NO 
    .PARAMETER Backplanebasedview 
        View based on heartbeat only on bkplane interface. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Syncstatusstrictmode 
        strict mode for sync status of cluster. Depending on the the mode if there are any errors while applying config, sync status is displayed accordingly. By default the flag is disabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created clusterinstance item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateClusterinstance -clid <double>
        An example how to update clusterinstance configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateClusterinstance
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterinstance/
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
        [ValidateRange(1, 16)]
        [double]$Clid,

        [ValidateRange(1, 60)]
        [double]$Deadinterval,

        [ValidateRange(200, 1000)]
        [double]$Hellointerval,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Preemption,

        [ValidateSet('MAJORITY', 'NONE')]
        [string]$Quorumtype,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Inc,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Processlocal,

        [string]$Nodegroup,

        [ValidateSet('YES', 'NO')]
        [string]$Retainconnectionsoncluster,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Backplanebasedview,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Syncstatusstrictmode,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateClusterinstance: Starting"
    }
    process {
        try {
            $payload = @{ clid = $clid }
            if ( $PSBoundParameters.ContainsKey('deadinterval') ) { $payload.Add('deadinterval', $deadinterval) }
            if ( $PSBoundParameters.ContainsKey('hellointerval') ) { $payload.Add('hellointerval', $hellointerval) }
            if ( $PSBoundParameters.ContainsKey('preemption') ) { $payload.Add('preemption', $preemption) }
            if ( $PSBoundParameters.ContainsKey('quorumtype') ) { $payload.Add('quorumtype', $quorumtype) }
            if ( $PSBoundParameters.ContainsKey('inc') ) { $payload.Add('inc', $inc) }
            if ( $PSBoundParameters.ContainsKey('processlocal') ) { $payload.Add('processlocal', $processlocal) }
            if ( $PSBoundParameters.ContainsKey('nodegroup') ) { $payload.Add('nodegroup', $nodegroup) }
            if ( $PSBoundParameters.ContainsKey('retainconnectionsoncluster') ) { $payload.Add('retainconnectionsoncluster', $retainconnectionsoncluster) }
            if ( $PSBoundParameters.ContainsKey('backplanebasedview') ) { $payload.Add('backplanebasedview', $backplanebasedview) }
            if ( $PSBoundParameters.ContainsKey('syncstatusstrictmode') ) { $payload.Add('syncstatusstrictmode', $syncstatusstrictmode) }
            if ( $PSCmdlet.ShouldProcess("clusterinstance", "Update cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusterinstance -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetClusterinstance -Filter $payload)
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
        Unset cluster configuration Object.
    .DESCRIPTION
        Configuration for cluster instance resource.
    .PARAMETER Clid 
        Unique number that identifies the cluster. 
    .PARAMETER Deadinterval 
        Amount of time, in seconds, after which nodes that do not respond to the heartbeats are assumed to be down.If the value is less than 3 sec, set the helloInterval parameter to 200 msec. 
    .PARAMETER Hellointerval 
        Interval, in milliseconds, at which heartbeats are sent to each cluster node to check the health status.Set the value to 200 msec, if the deadInterval parameter is less than 3 sec. 
    .PARAMETER Preemption 
        Preempt a cluster node that is configured as a SPARE if an ACTIVE node becomes available. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Quorumtype 
        Quorum Configuration Choices - "Majority" (recommended) requires majority of nodes to be online for the cluster to be UP. "None" relaxes this requirement. 
        Possible values = MAJORITY, NONE 
    .PARAMETER Inc 
        This option is required if the cluster nodes reside on different networks. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Processlocal 
        By turning on this option packets destined to a service in a cluster will not under go any steering. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nodegroup 
        The node group in a Cluster system used for transition from L2 to L3. 
    .PARAMETER Retainconnectionsoncluster 
        This option enables you to retain existing connections on a node joining a Cluster system or when a node is being configured for passive timeout. By default, this option is disabled. 
        Possible values = YES, NO 
    .PARAMETER Backplanebasedview 
        View based on heartbeat only on bkplane interface. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Syncstatusstrictmode 
        strict mode for sync status of cluster. Depending on the the mode if there are any errors while applying config, sync status is displayed accordingly. By default the flag is disabled. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetClusterinstance -clid <double>
        An example how to unset clusterinstance configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetClusterinstance
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterinstance
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

        [ValidateRange(1, 16)]
        [double]$Clid,

        [Boolean]$deadinterval,

        [Boolean]$hellointerval,

        [Boolean]$preemption,

        [Boolean]$quorumtype,

        [Boolean]$inc,

        [Boolean]$processlocal,

        [Boolean]$nodegroup,

        [Boolean]$retainconnectionsoncluster,

        [Boolean]$backplanebasedview,

        [Boolean]$syncstatusstrictmode 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetClusterinstance: Starting"
    }
    process {
        try {
            $payload = @{ clid = $clid }
            if ( $PSBoundParameters.ContainsKey('deadinterval') ) { $payload.Add('deadinterval', $deadinterval) }
            if ( $PSBoundParameters.ContainsKey('hellointerval') ) { $payload.Add('hellointerval', $hellointerval) }
            if ( $PSBoundParameters.ContainsKey('preemption') ) { $payload.Add('preemption', $preemption) }
            if ( $PSBoundParameters.ContainsKey('quorumtype') ) { $payload.Add('quorumtype', $quorumtype) }
            if ( $PSBoundParameters.ContainsKey('inc') ) { $payload.Add('inc', $inc) }
            if ( $PSBoundParameters.ContainsKey('processlocal') ) { $payload.Add('processlocal', $processlocal) }
            if ( $PSBoundParameters.ContainsKey('nodegroup') ) { $payload.Add('nodegroup', $nodegroup) }
            if ( $PSBoundParameters.ContainsKey('retainconnectionsoncluster') ) { $payload.Add('retainconnectionsoncluster', $retainconnectionsoncluster) }
            if ( $PSBoundParameters.ContainsKey('backplanebasedview') ) { $payload.Add('backplanebasedview', $backplanebasedview) }
            if ( $PSBoundParameters.ContainsKey('syncstatusstrictmode') ) { $payload.Add('syncstatusstrictmode', $syncstatusstrictmode) }
            if ( $PSCmdlet.ShouldProcess("$clid", "Unset cluster configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type clusterinstance -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Enable cluster configuration Object.
    .DESCRIPTION
        Configuration for cluster instance resource.
    .PARAMETER Clid 
        Unique number that identifies the cluster.
    .EXAMPLE
        PS C:\>Invoke-ADCEnableClusterinstance -clid <double>
        An example how to enable clusterinstance configuration Object(s).
    .NOTES
        File Name : Invoke-ADCEnableClusterinstance
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterinstance/
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
        [ValidateRange(1, 16)]
        [double]$Clid 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableClusterinstance: Starting"
    }
    process {
        try {
            $payload = @{ clid = $clid }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type clusterinstance -Action enable -Payload $payload -GetWarning
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
        Disable cluster configuration Object.
    .DESCRIPTION
        Configuration for cluster instance resource.
    .PARAMETER Clid 
        Unique number that identifies the cluster.
    .EXAMPLE
        PS C:\>Invoke-ADCDisableClusterinstance -clid <double>
        An example how to disable clusterinstance configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDisableClusterinstance
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterinstance/
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
        [ValidateRange(1, 16)]
        [double]$Clid 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableClusterinstance: Starting"
    }
    process {
        try {
            $payload = @{ clid = $clid }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type clusterinstance -Action disable -Payload $payload -GetWarning
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Configuration for cluster instance resource.
    .PARAMETER Clid 
        Unique number that identifies the cluster. 
    .PARAMETER GetAll 
        Retrieve all clusterinstance object(s).
    .PARAMETER Count
        If specified, the count of the clusterinstance object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusterinstance
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusterinstance -GetAll 
        Get all clusterinstance data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusterinstance -Count 
        Get the number of clusterinstance objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusterinstance -name <string>
        Get clusterinstance object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusterinstance -Filter @{ 'name'='<value>' }
        Get clusterinstance data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusterinstance
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterinstance/
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
        [ValidateRange(1, 16)]
        [double]$Clid,

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
        Write-Verbose "Invoke-ADCGetClusterinstance: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all clusterinstance objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusterinstance objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusterinstance objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusterinstance configuration for property 'clid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -NitroPath nitro/v1/config -Resource $clid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusterinstance configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to clusterinstance.
    .PARAMETER Clid 
        Unique number that identifies the cluster. 
    .PARAMETER GetAll 
        Retrieve all clusterinstance_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusterinstance_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusterinstancebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusterinstancebinding -GetAll 
        Get all clusterinstance_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusterinstancebinding -name <string>
        Get clusterinstance_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusterinstancebinding -Filter @{ 'name'='<value>' }
        Get clusterinstance_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusterinstancebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterinstance_binding/
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
        [ValidateRange(1, 16)]
        [double]$Clid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetClusterinstancebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusterinstance_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusterinstance_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusterinstance_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusterinstance_binding configuration for property 'clid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_binding -NitroPath nitro/v1/config -Resource $clid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusterinstance_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Binding object showing the clusternode that can be bound to clusterinstance.
    .PARAMETER Clid 
        Unique number that identifies the cluster. 
    .PARAMETER GetAll 
        Retrieve all clusterinstance_clusternode_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusterinstance_clusternode_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusterinstanceclusternodebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusterinstanceclusternodebinding -GetAll 
        Get all clusterinstance_clusternode_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusterinstanceclusternodebinding -Count 
        Get the number of clusterinstance_clusternode_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusterinstanceclusternodebinding -name <string>
        Get clusterinstance_clusternode_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusterinstanceclusternodebinding -Filter @{ 'name'='<value>' }
        Get clusterinstance_clusternode_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusterinstanceclusternodebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterinstance_clusternode_binding/
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
        [ValidateRange(1, 16)]
        [double]$Clid,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusterinstance_clusternode_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_clusternode_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusterinstance_clusternode_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_clusternode_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusterinstance_clusternode_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_clusternode_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusterinstance_clusternode_binding configuration for property 'clid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_clusternode_binding -NitroPath nitro/v1/config -Resource $clid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusterinstance_clusternode_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance_clusternode_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add cluster configuration Object.
    .DESCRIPTION
        Configuration for cluster node resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER Ipaddress 
        Citrix ADC IP (NSIP) address of the appliance to add to the cluster. Must be an IPv4 address. 
    .PARAMETER State 
        Admin state of the cluster node. The available settings function as follows: 
        ACTIVE - The node serves traffic. 
        SPARE - The node does not serve traffic unless an ACTIVE node goes down. 
        PASSIVE - The node does not serve traffic, unless you change its state. PASSIVE state is useful during temporary maintenance activities in which you want the node to take part in the consensus protocol but not to serve traffic. 
        Possible values = ACTIVE, SPARE, PASSIVE 
    .PARAMETER Backplane 
        Interface through which the node communicates with the other nodes in the cluster. Must be specified in the three-tuple form n/c/u, where n represents the node ID and c/u refers to the interface on the appliance. 
    .PARAMETER Priority 
        Preference for selecting a node as the configuration coordinator. The node with the lowest priority value is selected as the configuration coordinator. 
        When the current configuration coordinator goes down, the node with the next lowest priority is made the new configuration coordinator. When the original node comes back up, it will preempt the new configuration coordinator and take over as the configuration coordinator. 
        Note: When priority is not configured for any of the nodes or if multiple nodes have the same priority, the cluster elects one of the nodes as the configuration coordinator. 
    .PARAMETER Nodegroup 
        The default node group in a Cluster system. 
    .PARAMETER Delay 
        Applicable for Passive node and node becomes passive after this timeout (in minutes). 
    .PARAMETER Tunnelmode 
        To set the tunnel mode. 
        Possible values = NONE, GRE, UDP 
    .PARAMETER PassThru 
        Return details about the created clusternode item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddClusternode -nodeid <double> -ipaddress <string>
        An example how to add clusternode configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddClusternode
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternode/
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
        [ValidateRange(0, 31)]
        [double]$Nodeid,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipaddress,

        [ValidateSet('ACTIVE', 'SPARE', 'PASSIVE')]
        [string]$State = 'PASSIVE',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backplane,

        [ValidateRange(0, 31)]
        [double]$Priority = '31',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Nodegroup = 'DEFAULT_NG',

        [ValidateRange(0, 1440)]
        [double]$Delay = '0',

        [ValidateSet('NONE', 'GRE', 'UDP')]
        [string]$Tunnelmode = 'NONE',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternode: Starting"
    }
    process {
        try {
            $payload = @{ nodeid = $nodeid
                ipaddress        = $ipaddress
            }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('backplane') ) { $payload.Add('backplane', $backplane) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('nodegroup') ) { $payload.Add('nodegroup', $nodegroup) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('tunnelmode') ) { $payload.Add('tunnelmode', $tunnelmode) }
            if ( $PSCmdlet.ShouldProcess("clusternode", "Add cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type clusternode -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetClusternode -Filter $payload)
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
        Update cluster configuration Object.
    .DESCRIPTION
        Configuration for cluster node resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER State 
        Admin state of the cluster node. The available settings function as follows: 
        ACTIVE - The node serves traffic. 
        SPARE - The node does not serve traffic unless an ACTIVE node goes down. 
        PASSIVE - The node does not serve traffic, unless you change its state. PASSIVE state is useful during temporary maintenance activities in which you want the node to take part in the consensus protocol but not to serve traffic. 
        Possible values = ACTIVE, SPARE, PASSIVE 
    .PARAMETER Backplane 
        Interface through which the node communicates with the other nodes in the cluster. Must be specified in the three-tuple form n/c/u, where n represents the node ID and c/u refers to the interface on the appliance. 
    .PARAMETER Priority 
        Preference for selecting a node as the configuration coordinator. The node with the lowest priority value is selected as the configuration coordinator. 
        When the current configuration coordinator goes down, the node with the next lowest priority is made the new configuration coordinator. When the original node comes back up, it will preempt the new configuration coordinator and take over as the configuration coordinator. 
        Note: When priority is not configured for any of the nodes or if multiple nodes have the same priority, the cluster elects one of the nodes as the configuration coordinator. 
    .PARAMETER Delay 
        Applicable for Passive node and node becomes passive after this timeout (in minutes). 
    .PARAMETER Tunnelmode 
        To set the tunnel mode. 
        Possible values = NONE, GRE, UDP 
    .PARAMETER PassThru 
        Return details about the created clusternode item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateClusternode -nodeid <double>
        An example how to update clusternode configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateClusternode
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternode/
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
        [ValidateRange(0, 31)]
        [double]$Nodeid,

        [ValidateSet('ACTIVE', 'SPARE', 'PASSIVE')]
        [string]$State,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backplane,

        [ValidateRange(0, 31)]
        [double]$Priority,

        [ValidateRange(0, 1440)]
        [double]$Delay,

        [ValidateSet('NONE', 'GRE', 'UDP')]
        [string]$Tunnelmode,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateClusternode: Starting"
    }
    process {
        try {
            $payload = @{ nodeid = $nodeid }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('backplane') ) { $payload.Add('backplane', $backplane) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('tunnelmode') ) { $payload.Add('tunnelmode', $tunnelmode) }
            if ( $PSCmdlet.ShouldProcess("clusternode", "Update cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternode -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetClusternode -Filter $payload)
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
        Unset cluster configuration Object.
    .DESCRIPTION
        Configuration for cluster node resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER State 
        Admin state of the cluster node. The available settings function as follows: 
        ACTIVE - The node serves traffic. 
        SPARE - The node does not serve traffic unless an ACTIVE node goes down. 
        PASSIVE - The node does not serve traffic, unless you change its state. PASSIVE state is useful during temporary maintenance activities in which you want the node to take part in the consensus protocol but not to serve traffic. 
        Possible values = ACTIVE, SPARE, PASSIVE 
    .PARAMETER Backplane 
        Interface through which the node communicates with the other nodes in the cluster. Must be specified in the three-tuple form n/c/u, where n represents the node ID and c/u refers to the interface on the appliance. 
    .PARAMETER Priority 
        Preference for selecting a node as the configuration coordinator. The node with the lowest priority value is selected as the configuration coordinator. 
        When the current configuration coordinator goes down, the node with the next lowest priority is made the new configuration coordinator. When the original node comes back up, it will preempt the new configuration coordinator and take over as the configuration coordinator. 
        Note: When priority is not configured for any of the nodes or if multiple nodes have the same priority, the cluster elects one of the nodes as the configuration coordinator. 
    .PARAMETER Delay 
        Applicable for Passive node and node becomes passive after this timeout (in minutes). 
    .PARAMETER Tunnelmode 
        To set the tunnel mode. 
        Possible values = NONE, GRE, UDP
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetClusternode -nodeid <double>
        An example how to unset clusternode configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetClusternode
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternode
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

        [ValidateRange(0, 31)]
        [double]$Nodeid,

        [Boolean]$state,

        [Boolean]$backplane,

        [Boolean]$priority,

        [Boolean]$delay,

        [Boolean]$tunnelmode 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetClusternode: Starting"
    }
    process {
        try {
            $payload = @{ nodeid = $nodeid }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('backplane') ) { $payload.Add('backplane', $backplane) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('tunnelmode') ) { $payload.Add('tunnelmode', $tunnelmode) }
            if ( $PSCmdlet.ShouldProcess("$nodeid", "Unset cluster configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type clusternode -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Delete cluster configuration Object.
    .DESCRIPTION
        Configuration for cluster node resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER Clearnodegroupconfig 
        Option to remove nodegroup config. 
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteClusternode -Nodeid <double>
        An example how to delete clusternode configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteClusternode
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternode/
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
        [double]$Nodeid,

        [string]$Clearnodegroupconfig 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternode: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Clearnodegroupconfig') ) { $arguments.Add('clearnodegroupconfig', $Clearnodegroupconfig) }
            if ( $PSCmdlet.ShouldProcess("$nodeid", "Delete cluster configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternode -NitroPath nitro/v1/config -Resource $nodeid -Arguments $arguments
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Configuration for cluster node resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retrieve all clusternode object(s).
    .PARAMETER Count
        If specified, the count of the clusternode object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternode
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternode -GetAll 
        Get all clusternode data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternode -Count 
        Get the number of clusternode objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternode -name <string>
        Get clusternode object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternode -Filter @{ 'name'='<value>' }
        Get clusternode data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusternode
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternode/
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
        [ValidateRange(0, 31)]
        [double]$Nodeid,

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
        Write-Verbose "Invoke-ADCGetClusternode: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all clusternode objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternode objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternode objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternode configuration for property 'nodeid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -NitroPath nitro/v1/config -Resource $nodeid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternode configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add cluster configuration Object.
    .DESCRIPTION
        Configuration for Node group object type resource.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Strict 
        Specifies whether cluster nodes, that are not part of the nodegroup, will be used as backup for the nodegroup. 
        * Enabled - When one of the nodes goes down, no other cluster node is picked up to replace it. When the node comes up, it will continue being part of the nodegroup. 
        * Disabled - When one of the nodes goes down, a non-nodegroup cluster node is picked up and acts as part of the nodegroup. When the original node of the nodegroup comes up, the backup node will be replaced. 
        Possible values = YES, NO 
    .PARAMETER Sticky 
        Only one node can be bound to nodegroup with this option enabled. It specifies whether to prempt the traffic for the entities bound to nodegroup when owner node goes down and rejoins the cluster. 
        * Enabled - When owner node goes down, backup node will become the owner node and takes the traffic for the entities bound to the nodegroup. When bound node rejoins the cluster, traffic for the entities bound to nodegroup will not be steered back to this bound node. Current owner will have the ownership till it goes down. 
        * Disabled - When one of the nodes goes down, a non-nodegroup cluster node is picked up and acts as part of the nodegroup. When the original node of the nodegroup comes up, the backup node will be replaced. 
        Possible values = YES, NO 
    .PARAMETER State 
        State of the nodegroup. All the nodes binding to this nodegroup must have the same state. ACTIVE/SPARE/PASSIVE. 
        Possible values = ACTIVE, SPARE, PASSIVE 
    .PARAMETER Priority 
        Priority of Nodegroup. This priority is used for all the nodes bound to the nodegroup for Nodegroup selection. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddClusternodegroup -name <string>
        An example how to add clusternodegroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddClusternodegroup
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup/
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

        [ValidateSet('YES', 'NO')]
        [string]$Strict = 'NO',

        [ValidateSet('YES', 'NO')]
        [string]$Sticky = 'NO',

        [ValidateSet('ACTIVE', 'SPARE', 'PASSIVE')]
        [string]$State,

        [ValidateRange(0, 31)]
        [double]$Priority,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroup: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('strict') ) { $payload.Add('strict', $strict) }
            if ( $PSBoundParameters.ContainsKey('sticky') ) { $payload.Add('sticky', $sticky) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup", "Add cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type clusternodegroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetClusternodegroup -Filter $payload)
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
        Update cluster configuration Object.
    .DESCRIPTION
        Configuration for Node group object type resource.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Strict 
        Specifies whether cluster nodes, that are not part of the nodegroup, will be used as backup for the nodegroup. 
        * Enabled - When one of the nodes goes down, no other cluster node is picked up to replace it. When the node comes up, it will continue being part of the nodegroup. 
        * Disabled - When one of the nodes goes down, a non-nodegroup cluster node is picked up and acts as part of the nodegroup. When the original node of the nodegroup comes up, the backup node will be replaced. 
        Possible values = YES, NO 
    .PARAMETER State 
        State of the nodegroup. All the nodes binding to this nodegroup must have the same state. ACTIVE/SPARE/PASSIVE. 
        Possible values = ACTIVE, SPARE, PASSIVE 
    .PARAMETER Priority 
        Priority of Nodegroup. This priority is used for all the nodes bound to the nodegroup for Nodegroup selection. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateClusternodegroup -name <string>
        An example how to update clusternodegroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateClusternodegroup
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup/
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

        [ValidateSet('YES', 'NO')]
        [string]$Strict,

        [ValidateSet('ACTIVE', 'SPARE', 'PASSIVE')]
        [string]$State,

        [ValidateRange(0, 31)]
        [double]$Priority,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateClusternodegroup: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('strict') ) { $payload.Add('strict', $strict) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup", "Update cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetClusternodegroup -Filter $payload)
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
        Unset cluster configuration Object.
    .DESCRIPTION
        Configuration for Node group object type resource.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Strict 
        Specifies whether cluster nodes, that are not part of the nodegroup, will be used as backup for the nodegroup. 
        * Enabled - When one of the nodes goes down, no other cluster node is picked up to replace it. When the node comes up, it will continue being part of the nodegroup. 
        * Disabled - When one of the nodes goes down, a non-nodegroup cluster node is picked up and acts as part of the nodegroup. When the original node of the nodegroup comes up, the backup node will be replaced. 
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetClusternodegroup -name <string>
        An example how to unset clusternodegroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetClusternodegroup
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup
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

        [Boolean]$strict 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetClusternodegroup: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('strict') ) { $payload.Add('strict', $strict) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset cluster configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type clusternodegroup -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Delete cluster configuration Object.
    .DESCRIPTION
        Configuration for Node group object type resource.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteClusternodegroup -Name <string>
        An example how to delete clusternodegroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroup
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup/
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
        Write-Verbose "Invoke-ADCDeleteClusternodegroup: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete cluster configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Configuration for Node group object type resource.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER GetAll 
        Retrieve all clusternodegroup object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroup -GetAll 
        Get all clusternodegroup data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroup -Count 
        Get the number of clusternodegroup objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroup -name <string>
        Get clusternodegroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroup -Filter @{ 'name'='<value>' }
        Get clusternodegroup data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusternodegroup
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup/
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
        Write-Verbose "Invoke-ADCGetClusternodegroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all clusternodegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternodegroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add cluster configuration Object.
    .DESCRIPTION
        Binding object showing the authenticationvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_authenticationvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddClusternodegroupauthenticationvserverbinding -name <string>
        An example how to add clusternodegroup_authenticationvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupauthenticationvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_authenticationvserver_binding/
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

        [string]$Vserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupauthenticationvserverbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_authenticationvserver_binding", "Add cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_authenticationvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetClusternodegroupauthenticationvserverbinding -Filter $payload)
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
        Delete cluster configuration Object.
    .DESCRIPTION
        Binding object showing the authenticationvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteClusternodegroupauthenticationvserverbinding 
        An example how to delete clusternodegroup_authenticationvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupauthenticationvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_authenticationvserver_binding/
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

        [string]$Name,

        [string]$Vserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupauthenticationvserverbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Vserver') ) { $arguments.Add('vserver', $Vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_authenticationvserver_binding", "Delete cluster configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_authenticationvserver_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Binding object showing the authenticationvserver that can be bound to clusternodegroup.
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_authenticationvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_authenticationvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupauthenticationvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupauthenticationvserverbinding -GetAll 
        Get all clusternodegroup_authenticationvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupauthenticationvserverbinding -Count 
        Get the number of clusternodegroup_authenticationvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupauthenticationvserverbinding -name <string>
        Get clusternodegroup_authenticationvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupauthenticationvserverbinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_authenticationvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupauthenticationvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_authenticationvserver_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupauthenticationvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_authenticationvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_authenticationvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_authenticationvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_authenticationvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_authenticationvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_authenticationvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_authenticationvserver_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_authenticationvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_authenticationvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup to be displayed. If a name is not provided, information about all nodegroups is displayed. 
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupbinding -GetAll 
        Get all clusternodegroup_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupbinding -name <string>
        Get clusternodegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupbinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_binding/
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
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetClusternodegroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternodegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add cluster configuration Object.
    .DESCRIPTION
        Binding object showing the clusternode that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Node 
        Nodes in the nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_clusternode_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddClusternodegroupclusternodebinding -name <string>
        An example how to add clusternodegroup_clusternode_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupclusternodebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_clusternode_binding/
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

        [ValidateRange(0, 31)]
        [double]$Node,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupclusternodebinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('node') ) { $payload.Add('node', $node) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_clusternode_binding", "Add cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_clusternode_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetClusternodegroupclusternodebinding -Filter $payload)
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
        Delete cluster configuration Object.
    .DESCRIPTION
        Binding object showing the clusternode that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Node 
        Nodes in the nodegroup.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteClusternodegroupclusternodebinding 
        An example how to delete clusternodegroup_clusternode_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupclusternodebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_clusternode_binding/
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

        [string]$Name,

        [double]$Node 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupclusternodebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Node') ) { $arguments.Add('node', $Node) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_clusternode_binding", "Delete cluster configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_clusternode_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Binding object showing the clusternode that can be bound to clusternodegroup.
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_clusternode_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_clusternode_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupclusternodebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupclusternodebinding -GetAll 
        Get all clusternodegroup_clusternode_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupclusternodebinding -Count 
        Get the number of clusternodegroup_clusternode_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupclusternodebinding -name <string>
        Get clusternodegroup_clusternode_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupclusternodebinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_clusternode_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupclusternodebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_clusternode_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupclusternodebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_clusternode_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_clusternode_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_clusternode_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_clusternode_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_clusternode_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_clusternode_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_clusternode_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_clusternode_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_clusternode_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add cluster configuration Object.
    .DESCRIPTION
        Binding object showing the crvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_crvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddClusternodegroupcrvserverbinding -name <string>
        An example how to add clusternodegroup_crvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupcrvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_crvserver_binding/
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

        [string]$Vserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupcrvserverbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_crvserver_binding", "Add cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_crvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetClusternodegroupcrvserverbinding -Filter $payload)
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
        Delete cluster configuration Object.
    .DESCRIPTION
        Binding object showing the crvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteClusternodegroupcrvserverbinding 
        An example how to delete clusternodegroup_crvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupcrvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_crvserver_binding/
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

        [string]$Name,

        [string]$Vserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupcrvserverbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Vserver') ) { $arguments.Add('vserver', $Vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_crvserver_binding", "Delete cluster configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_crvserver_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Binding object showing the crvserver that can be bound to clusternodegroup.
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_crvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_crvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupcrvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupcrvserverbinding -GetAll 
        Get all clusternodegroup_crvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupcrvserverbinding -Count 
        Get the number of clusternodegroup_crvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupcrvserverbinding -name <string>
        Get clusternodegroup_crvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupcrvserverbinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_crvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupcrvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_crvserver_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupcrvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_crvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_crvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_crvserver_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_crvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_crvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add cluster configuration Object.
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_csvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddClusternodegroupcsvserverbinding -name <string>
        An example how to add clusternodegroup_csvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupcsvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_csvserver_binding/
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

        [string]$Vserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupcsvserverbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_csvserver_binding", "Add cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_csvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetClusternodegroupcsvserverbinding -Filter $payload)
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
        Delete cluster configuration Object.
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteClusternodegroupcsvserverbinding 
        An example how to delete clusternodegroup_csvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupcsvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_csvserver_binding/
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

        [string]$Name,

        [string]$Vserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupcsvserverbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Vserver') ) { $arguments.Add('vserver', $Vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_csvserver_binding", "Delete cluster configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_csvserver_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to clusternodegroup.
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupcsvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupcsvserverbinding -GetAll 
        Get all clusternodegroup_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupcsvserverbinding -Count 
        Get the number of clusternodegroup_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupcsvserverbinding -name <string>
        Get clusternodegroup_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupcsvserverbinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupcsvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupcsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_csvserver_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add cluster configuration Object.
    .DESCRIPTION
        Binding object showing the gslbsite that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Gslbsite 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_gslbsite_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddClusternodegroupgslbsitebinding -name <string>
        An example how to add clusternodegroup_gslbsite_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupgslbsitebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_gslbsite_binding/
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

        [string]$Gslbsite,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupgslbsitebinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('gslbsite') ) { $payload.Add('gslbsite', $gslbsite) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_gslbsite_binding", "Add cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_gslbsite_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetClusternodegroupgslbsitebinding -Filter $payload)
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
        Delete cluster configuration Object.
    .DESCRIPTION
        Binding object showing the gslbsite that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Gslbsite 
        vserver that need to be bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteClusternodegroupgslbsitebinding 
        An example how to delete clusternodegroup_gslbsite_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupgslbsitebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_gslbsite_binding/
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

        [string]$Name,

        [string]$Gslbsite 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupgslbsitebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Gslbsite') ) { $arguments.Add('gslbsite', $Gslbsite) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_gslbsite_binding", "Delete cluster configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_gslbsite_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbsite that can be bound to clusternodegroup.
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_gslbsite_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_gslbsite_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupgslbsitebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupgslbsitebinding -GetAll 
        Get all clusternodegroup_gslbsite_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupgslbsitebinding -Count 
        Get the number of clusternodegroup_gslbsite_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupgslbsitebinding -name <string>
        Get clusternodegroup_gslbsite_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupgslbsitebinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_gslbsite_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupgslbsitebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_gslbsite_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupgslbsitebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_gslbsite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_gslbsite_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_gslbsite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_gslbsite_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_gslbsite_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_gslbsite_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_gslbsite_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_gslbsite_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_gslbsite_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add cluster configuration Object.
    .DESCRIPTION
        Binding object showing the gslbvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_gslbvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddClusternodegroupgslbvserverbinding -name <string>
        An example how to add clusternodegroup_gslbvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupgslbvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_gslbvserver_binding/
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

        [string]$Vserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupgslbvserverbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_gslbvserver_binding", "Add cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_gslbvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetClusternodegroupgslbvserverbinding -Filter $payload)
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
        Delete cluster configuration Object.
    .DESCRIPTION
        Binding object showing the gslbvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteClusternodegroupgslbvserverbinding 
        An example how to delete clusternodegroup_gslbvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupgslbvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_gslbvserver_binding/
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

        [string]$Name,

        [string]$Vserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupgslbvserverbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Vserver') ) { $arguments.Add('vserver', $Vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_gslbvserver_binding", "Delete cluster configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_gslbvserver_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbvserver that can be bound to clusternodegroup.
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_gslbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_gslbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupgslbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupgslbvserverbinding -GetAll 
        Get all clusternodegroup_gslbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupgslbvserverbinding -Count 
        Get the number of clusternodegroup_gslbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupgslbvserverbinding -name <string>
        Get clusternodegroup_gslbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupgslbvserverbinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_gslbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupgslbvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_gslbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupgslbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_gslbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_gslbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_gslbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_gslbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_gslbvserver_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_gslbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_gslbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add cluster configuration Object.
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_lbvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddClusternodegrouplbvserverbinding -name <string>
        An example how to add clusternodegroup_lbvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddClusternodegrouplbvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_lbvserver_binding/
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

        [string]$Vserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegrouplbvserverbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_lbvserver_binding", "Add cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_lbvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetClusternodegrouplbvserverbinding -Filter $payload)
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
        Delete cluster configuration Object.
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteClusternodegrouplbvserverbinding 
        An example how to delete clusternodegroup_lbvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegrouplbvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_lbvserver_binding/
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

        [string]$Name,

        [string]$Vserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegrouplbvserverbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Vserver') ) { $arguments.Add('vserver', $Vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_lbvserver_binding", "Delete cluster configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_lbvserver_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to clusternodegroup.
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegrouplbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegrouplbvserverbinding -GetAll 
        Get all clusternodegroup_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegrouplbvserverbinding -Count 
        Get the number of clusternodegroup_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegrouplbvserverbinding -name <string>
        Get clusternodegroup_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegrouplbvserverbinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusternodegrouplbvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegrouplbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_lbvserver_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add cluster configuration Object.
    .DESCRIPTION
        Binding object showing the nslimitidentifier that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup to which you want to bind a cluster node or an entity. 
    .PARAMETER Identifiername 
        stream identifier and rate limit identifier that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_nslimitidentifier_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddClusternodegroupnslimitidentifierbinding -name <string>
        An example how to add clusternodegroup_nslimitidentifier_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupnslimitidentifierbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_nslimitidentifier_binding/
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

        [string]$Identifiername,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupnslimitidentifierbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('identifiername') ) { $payload.Add('identifiername', $identifiername) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_nslimitidentifier_binding", "Add cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_nslimitidentifier_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetClusternodegroupnslimitidentifierbinding -Filter $payload)
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
        Delete cluster configuration Object.
    .DESCRIPTION
        Binding object showing the nslimitidentifier that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup to which you want to bind a cluster node or an entity. 
    .PARAMETER Identifiername 
        stream identifier and rate limit identifier that need to be bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteClusternodegroupnslimitidentifierbinding -Name <string>
        An example how to delete clusternodegroup_nslimitidentifier_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupnslimitidentifierbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_nslimitidentifier_binding/
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

        [string]$Identifiername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupnslimitidentifierbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Identifiername') ) { $arguments.Add('identifiername', $Identifiername) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete cluster configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_nslimitidentifier_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Binding object showing the nslimitidentifier that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup to which you want to bind a cluster node or an entity. 
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_nslimitidentifier_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_nslimitidentifier_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupnslimitidentifierbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupnslimitidentifierbinding -GetAll 
        Get all clusternodegroup_nslimitidentifier_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupnslimitidentifierbinding -Count 
        Get the number of clusternodegroup_nslimitidentifier_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupnslimitidentifierbinding -name <string>
        Get clusternodegroup_nslimitidentifier_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupnslimitidentifierbinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_nslimitidentifier_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupnslimitidentifierbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_nslimitidentifier_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetClusternodegroupnslimitidentifierbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_nslimitidentifier_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_nslimitidentifier_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_nslimitidentifier_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_nslimitidentifier_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_nslimitidentifier_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_nslimitidentifier_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_nslimitidentifier_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_nslimitidentifier_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternodegroup_nslimitidentifier_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_nslimitidentifier_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add cluster configuration Object.
    .DESCRIPTION
        Binding object showing the service that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Service 
        name of the service bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_service_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddClusternodegroupservicebinding -name <string>
        An example how to add clusternodegroup_service_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupservicebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_service_binding/
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

        [string]$Service,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupservicebinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('service') ) { $payload.Add('service', $service) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_service_binding", "Add cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_service_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetClusternodegroupservicebinding -Filter $payload)
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
        Delete cluster configuration Object.
    .DESCRIPTION
        Binding object showing the service that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Service 
        name of the service bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteClusternodegroupservicebinding 
        An example how to delete clusternodegroup_service_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupservicebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_service_binding/
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

        [string]$Name,

        [string]$Service 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupservicebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Service') ) { $arguments.Add('service', $Service) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_service_binding", "Delete cluster configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_service_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Binding object showing the service that can be bound to clusternodegroup.
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_service_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_service_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupservicebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupservicebinding -GetAll 
        Get all clusternodegroup_service_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupservicebinding -Count 
        Get the number of clusternodegroup_service_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupservicebinding -name <string>
        Get clusternodegroup_service_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupservicebinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_service_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupservicebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_service_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupservicebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_service_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_service_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_service_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_service_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_service_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_service_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_service_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_service_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add cluster configuration Object.
    .DESCRIPTION
        Binding object showing the streamidentifier that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup to which you want to bind a cluster node or an entity. 
    .PARAMETER Identifiername 
        stream identifier and rate limit identifier that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_streamidentifier_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddClusternodegroupstreamidentifierbinding -name <string>
        An example how to add clusternodegroup_streamidentifier_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupstreamidentifierbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_streamidentifier_binding/
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

        [string]$Identifiername,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupstreamidentifierbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('identifiername') ) { $payload.Add('identifiername', $identifiername) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_streamidentifier_binding", "Add cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_streamidentifier_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetClusternodegroupstreamidentifierbinding -Filter $payload)
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
        Delete cluster configuration Object.
    .DESCRIPTION
        Binding object showing the streamidentifier that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup to which you want to bind a cluster node or an entity. 
    .PARAMETER Identifiername 
        stream identifier and rate limit identifier that need to be bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteClusternodegroupstreamidentifierbinding -Name <string>
        An example how to delete clusternodegroup_streamidentifier_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupstreamidentifierbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_streamidentifier_binding/
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

        [string]$Identifiername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupstreamidentifierbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Identifiername') ) { $arguments.Add('identifiername', $Identifiername) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete cluster configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_streamidentifier_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Binding object showing the streamidentifier that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup to which you want to bind a cluster node or an entity. 
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_streamidentifier_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_streamidentifier_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupstreamidentifierbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupstreamidentifierbinding -GetAll 
        Get all clusternodegroup_streamidentifier_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupstreamidentifierbinding -Count 
        Get the number of clusternodegroup_streamidentifier_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupstreamidentifierbinding -name <string>
        Get clusternodegroup_streamidentifier_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupstreamidentifierbinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_streamidentifier_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupstreamidentifierbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_streamidentifier_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetClusternodegroupstreamidentifierbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_streamidentifier_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_streamidentifier_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_streamidentifier_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_streamidentifier_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_streamidentifier_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_streamidentifier_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_streamidentifier_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_streamidentifier_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternodegroup_streamidentifier_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_streamidentifier_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add cluster configuration Object.
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup. 
    .PARAMETER PassThru 
        Return details about the created clusternodegroup_vpnvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddClusternodegroupvpnvserverbinding -name <string>
        An example how to add clusternodegroup_vpnvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddClusternodegroupvpnvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_vpnvserver_binding/
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

        [string]$Vserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternodegroupvpnvserverbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_vpnvserver_binding", "Add cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternodegroup_vpnvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetClusternodegroupvpnvserverbinding -Filter $payload)
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
        Delete cluster configuration Object.
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to clusternodegroup.
    .PARAMETER Name 
        Name of the nodegroup. The name uniquely identifies the nodegroup on the cluster. 
    .PARAMETER Vserver 
        vserver that need to be bound to this nodegroup.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteClusternodegroupvpnvserverbinding 
        An example how to delete clusternodegroup_vpnvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteClusternodegroupvpnvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_vpnvserver_binding/
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

        [string]$Name,

        [string]$Vserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternodegroupvpnvserverbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Name') ) { $arguments.Add('name', $Name) }
            if ( $PSBoundParameters.ContainsKey('Vserver') ) { $arguments.Add('vserver', $Vserver) }
            if ( $PSCmdlet.ShouldProcess("clusternodegroup_vpnvserver_binding", "Delete cluster configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternodegroup_vpnvserver_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to clusternodegroup.
    .PARAMETER GetAll 
        Retrieve all clusternodegroup_vpnvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternodegroup_vpnvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupvpnvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupvpnvserverbinding -GetAll 
        Get all clusternodegroup_vpnvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodegroupvpnvserverbinding -Count 
        Get the number of clusternodegroup_vpnvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupvpnvserverbinding -name <string>
        Get clusternodegroup_vpnvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodegroupvpnvserverbinding -Filter @{ 'name'='<value>' }
        Get clusternodegroup_vpnvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusternodegroupvpnvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternodegroup_vpnvserver_binding/
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
        Write-Verbose "Invoke-ADCGetClusternodegroupvpnvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternodegroup_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternodegroup_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternodegroup_vpnvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternodegroup_vpnvserver_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusternodegroup_vpnvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternodegroup_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to clusternode.
    .PARAMETER Nodeid 
        ID of the cluster node for which to display information. If an ID is not provided, information about all nodes is shown. 
    .PARAMETER GetAll 
        Retrieve all clusternode_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternode_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodebinding -GetAll 
        Get all clusternode_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodebinding -name <string>
        Get clusternode_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodebinding -Filter @{ 'name'='<value>' }
        Get clusternode_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusternodebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternode_binding/
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
        [ValidateRange(0, 31)]
        [double]$Nodeid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetClusternodebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternode_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternode_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternode_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternode_binding configuration for property 'nodeid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_binding -NitroPath nitro/v1/config -Resource $nodeid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternode_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add cluster configuration Object.
    .DESCRIPTION
        Binding object showing the routemonitor that can be bound to clusternode.
    .PARAMETER Nodeid 
        A number that uniquely identifies the cluster node. . 
    .PARAMETER Routemonitor 
        The IP address (IPv4 or IPv6). 
    .PARAMETER Netmask 
        The netmask. 
    .PARAMETER PassThru 
        Return details about the created clusternode_routemonitor_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddClusternoderoutemonitorbinding -nodeid <double> -routemonitor <string>
        An example how to add clusternode_routemonitor_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddClusternoderoutemonitorbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternode_routemonitor_binding/
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
        [ValidateRange(0, 31)]
        [double]$Nodeid,

        [Parameter(Mandatory)]
        [string]$Routemonitor,

        [string]$Netmask,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddClusternoderoutemonitorbinding: Starting"
    }
    process {
        try {
            $payload = @{ nodeid = $nodeid
                routemonitor     = $routemonitor
            }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSCmdlet.ShouldProcess("clusternode_routemonitor_binding", "Add cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type clusternode_routemonitor_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetClusternoderoutemonitorbinding -Filter $payload)
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
        Delete cluster configuration Object.
    .DESCRIPTION
        Binding object showing the routemonitor that can be bound to clusternode.
    .PARAMETER Nodeid 
        A number that uniquely identifies the cluster node. . 
    .PARAMETER Routemonitor 
        The IP address (IPv4 or IPv6). 
    .PARAMETER Netmask 
        The netmask.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteClusternoderoutemonitorbinding -Nodeid <double>
        An example how to delete clusternode_routemonitor_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteClusternoderoutemonitorbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternode_routemonitor_binding/
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
        [double]$Nodeid,

        [string]$Routemonitor,

        [string]$Netmask 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteClusternoderoutemonitorbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Routemonitor') ) { $arguments.Add('routemonitor', $Routemonitor) }
            if ( $PSBoundParameters.ContainsKey('Netmask') ) { $arguments.Add('netmask', $Netmask) }
            if ( $PSCmdlet.ShouldProcess("$nodeid", "Delete cluster configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type clusternode_routemonitor_binding -NitroPath nitro/v1/config -Resource $nodeid -Arguments $arguments
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Binding object showing the routemonitor that can be bound to clusternode.
    .PARAMETER Nodeid 
        A number that uniquely identifies the cluster node. . 
    .PARAMETER GetAll 
        Retrieve all clusternode_routemonitor_binding object(s).
    .PARAMETER Count
        If specified, the count of the clusternode_routemonitor_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternoderoutemonitorbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternoderoutemonitorbinding -GetAll 
        Get all clusternode_routemonitor_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternoderoutemonitorbinding -Count 
        Get the number of clusternode_routemonitor_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternoderoutemonitorbinding -name <string>
        Get clusternode_routemonitor_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternoderoutemonitorbinding -Filter @{ 'name'='<value>' }
        Get clusternode_routemonitor_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusternoderoutemonitorbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusternode_routemonitor_binding/
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
        [ValidateRange(0, 31)]
        [double]$Nodeid,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all clusternode_routemonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_routemonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternode_routemonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_routemonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternode_routemonitor_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_routemonitor_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternode_routemonitor_binding configuration for property 'nodeid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_routemonitor_binding -NitroPath nitro/v1/config -Resource $nodeid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternode_routemonitor_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode_routemonitor_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Clear cluster configuration Object.
    .DESCRIPTION
        Configuration for 0 resource.
    .EXAMPLE
        PS C:\>Invoke-ADCClearClusterpropstatus 
        An example how to clear clusterpropstatus configuration Object(s).
    .NOTES
        File Name : Invoke-ADCClearClusterpropstatus
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterpropstatus/
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
        Write-Verbose "Invoke-ADCClearClusterpropstatus: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Clear cluster configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type clusterpropstatus -Action clear -Payload $payload -GetWarning
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
        Get cluster configuration object(s).
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retrieve all clusterpropstatus object(s).
    .PARAMETER Count
        If specified, the count of the clusterpropstatus object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusterpropstatus
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusterpropstatus -GetAll 
        Get all clusterpropstatus data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusterpropstatus -Count 
        Get the number of clusterpropstatus objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusterpropstatus -name <string>
        Get clusterpropstatus object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusterpropstatus -Filter @{ 'name'='<value>' }
        Get clusterpropstatus data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusterpropstatus
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cluster/clusterpropstatus/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all clusterpropstatus objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterpropstatus -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusterpropstatus objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterpropstatus -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusterpropstatus objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterpropstatus -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusterpropstatus configuration for property ''"

            } else {
                Write-Verbose "Retrieving clusterpropstatus configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterpropstatus -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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


