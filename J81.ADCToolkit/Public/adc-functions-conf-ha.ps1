function Invoke-ADCForceHafailover {
    <#
    .SYNOPSIS
        Force High Availability configuration Object.
    .DESCRIPTION
        Configuration for failover resource.
    .PARAMETER Force 
        Force a failover without prompting for confirmation.
    .EXAMPLE
        PS C:\>Invoke-ADCForceHafailover 
        An example how to force hafailover configuration Object(s).
    .NOTES
        File Name : Invoke-ADCForceHafailover
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hafailover/
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

        [boolean]$Force 

    )
    begin {
        Write-Verbose "Invoke-ADCForceHafailover: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('force') ) { $payload.Add('force', $force) }
            if ( $PSCmdlet.ShouldProcess($Name, "Force High Availability configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type hafailover -Action force -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCForceHafailover: Finished"
    }
}

function Invoke-ADCSyncHafiles {
    <#
    .SYNOPSIS
        Sync High Availability configuration Object.
    .DESCRIPTION
        Configuration for files resource.
    .PARAMETER Mode 
        Specify one of the following modes of synchronization. 
        * all - Synchronize files related to system configuration, Access Gateway bookmarks, SSL certificates, SSL CRL lists, HTML injection scripts, and Application Firewall XML objects. 
        * bookmarks - Synchronize all Access Gateway bookmarks. 
        * ssl - Synchronize all certificates, keys, and CRLs for the SSL feature. 
        * htmlinjection. Synchronize all scripts configured for the HTML injection feature. 
        * imports. Synchronize all XML objects (for example, WSDLs, schemas, error pages) configured for the application firewall. 
        * misc - Synchronize all license files and the rc.conf file. 
        * all_plus_misc - Synchronize files related to system configuration, Access Gateway bookmarks, SSL certificates, SSL CRL lists, HTML injection scripts, application firewall XML objects, licenses, and the rc.conf file. 
        Possible values = all, bookmarks, ssl, htmlinjection, imports, misc, dns, krb, AAA, app_catalog, all_plus_misc, all_minus_misc
    .EXAMPLE
        PS C:\>Invoke-ADCSyncHafiles 
        An example how to sync hafiles configuration Object(s).
    .NOTES
        File Name : Invoke-ADCSyncHafiles
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hafiles/
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
        Write-Verbose "Invoke-ADCSyncHafiles: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('mode') ) { $payload.Add('mode', $mode) }
            if ( $PSCmdlet.ShouldProcess($Name, "Sync High Availability configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type hafiles -Action sync -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCSyncHafiles: Finished"
    }
}

function Invoke-ADCAddHanode {
    <#
    .SYNOPSIS
        Add High Availability configuration Object.
    .DESCRIPTION
        Configuration for node resource.
    .PARAMETER Id 
        Number that uniquely identifies the node. For self node, it will always be 0. Peer node values can range from 1-64. 
    .PARAMETER Ipaddress 
        The NSIP or NSIP6 address of the node to be added for an HA configuration. This setting is neither propagated nor synchronized. 
    .PARAMETER Inc 
        This option is required if the HA nodes reside on different networks. When this mode is enabled, the following independent network entities and configurations are neither propagated nor synced to the other node: MIPs, SNIPs, VLANs, routes (except LLB routes), route monitors, RNAT rules (except any RNAT rule with a VIP as the NAT IP), and dynamic routing configurations. They are maintained independently on each node. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created hanode item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddHanode -id <double> -ipaddress <string>
        An example how to add hanode configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddHanode
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode/
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
        [ValidateRange(1, 64)]
        [double]$Id,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipaddress,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Inc = 'DISABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddHanode: Starting"
    }
    process {
        try {
            $payload = @{ id = $id
                ipaddress    = $ipaddress
            }
            if ( $PSBoundParameters.ContainsKey('inc') ) { $payload.Add('inc', $inc) }
            if ( $PSCmdlet.ShouldProcess("hanode", "Add High Availability configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type hanode -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetHanode -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddHanode: Finished"
    }
}

function Invoke-ADCDeleteHanode {
    <#
    .SYNOPSIS
        Delete High Availability configuration Object.
    .DESCRIPTION
        Configuration for node resource.
    .PARAMETER Id 
        Number that uniquely identifies the node. For self node, it will always be 0. Peer node values can range from 1-64.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteHanode -Id <double>
        An example how to delete hanode configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteHanode
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode/
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
        [double]$Id 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteHanode: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$id", "Delete High Availability configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type hanode -NitroPath nitro/v1/config -Resource $id -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteHanode: Finished"
    }
}

function Invoke-ADCUpdateHanode {
    <#
    .SYNOPSIS
        Update High Availability configuration Object.
    .DESCRIPTION
        Configuration for node resource.
    .PARAMETER Id 
        Number that uniquely identifies the node. For self node, it will always be 0. Peer node values can range from 1-64. 
    .PARAMETER Hastatus 
        The HA status of the node. The HA status STAYSECONDARY is used to force the secondary device stay as secondary independent of the state of the Primary device. For example, in an existing HA setup, the Primary node has to be upgraded and this process would take few seconds. During the upgradation, it is possible that the Primary node may suffer from a downtime for a few seconds. However, the Secondary should not take over as the Primary node. Thus, the Secondary node should remain as Secondary even if there is a failure in the Primary node. 
        STAYPRIMARY configuration keeps the node in primary state in case if it is healthy, even if the peer node was the primary node initially. If the node with STAYPRIMARY setting (and no peer node) is added to a primary node (which has this node as the peer) then this node takes over as the new primary and the older node becomes secondary. ENABLED state means normal HA operation without any constraints/preferences. DISABLED state disables the normal HA operation of the node. 
        Possible values = ENABLED, STAYSECONDARY, DISABLED, STAYPRIMARY 
    .PARAMETER Hasync 
        Automatically maintain synchronization by duplicating the configuration of the primary node on the secondary node. This setting is not propagated. Automatic synchronization requires that this setting be enabled (the default) on the current secondary node. Synchronization uses TCP port 3010. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Haprop 
        Automatically propagate all commands from the primary to the secondary node, except the following: 
        * All HA configuration related commands. For example, add ha node, set ha node, and bind ha node. 
        * All Interface related commands. For example, set interface and unset interface. 
        * All channels related commands. For example, add channel, set channel, and bind channel. 
        The propagated command is executed on the secondary node before it is executed on the primary. If command propagation fails, or if command execution fails on the secondary, the primary node executes the command and logs an error. Command propagation uses port 3010. 
        Note: After enabling propagation, run force synchronization on either node. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Hellointerval 
        Interval, in milliseconds, between heartbeat messages sent to the peer node. The heartbeat messages are UDP packets sent to port 3003 of the peer node. 
    .PARAMETER Deadinterval 
        Number of seconds after which a peer node is marked DOWN if heartbeat messages are not received from the peer node. 
    .PARAMETER Failsafe 
        Keep one node primary if both nodes fail the health check, so that a partially available node can back up data and handle traffic. This mode is set independently on each node. 
        Possible values = ON, OFF 
    .PARAMETER Maxflips 
        Max number of flips allowed before becoming sticky primary. 
    .PARAMETER Maxfliptime 
        Interval after which flipping of node states can again start. 
    .PARAMETER Syncvlan 
        Vlan on which HA related communication is sent. This include sync, propagation, connection mirroring, LB persistency config sync, persistent session sync and session state sync. However HA heartbeats can go all interfaces. 
    .PARAMETER Syncstatusstrictmode 
        strict mode flag for sync status. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created hanode item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateHanode 
        An example how to update hanode configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateHanode
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode/
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

        [ValidateRange(1, 64)]
        [double]$Id,

        [ValidateSet('ENABLED', 'STAYSECONDARY', 'DISABLED', 'STAYPRIMARY')]
        [string]$Hastatus,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Hasync,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Haprop,

        [ValidateRange(200, 1000)]
        [double]$Hellointerval,

        [ValidateRange(3, 60)]
        [double]$Deadinterval,

        [ValidateSet('ON', 'OFF')]
        [string]$Failsafe,

        [double]$Maxflips,

        [double]$Maxfliptime,

        [ValidateRange(1, 4094)]
        [double]$Syncvlan,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Syncstatusstrictmode,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateHanode: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('id') ) { $payload.Add('id', $id) }
            if ( $PSBoundParameters.ContainsKey('hastatus') ) { $payload.Add('hastatus', $hastatus) }
            if ( $PSBoundParameters.ContainsKey('hasync') ) { $payload.Add('hasync', $hasync) }
            if ( $PSBoundParameters.ContainsKey('haprop') ) { $payload.Add('haprop', $haprop) }
            if ( $PSBoundParameters.ContainsKey('hellointerval') ) { $payload.Add('hellointerval', $hellointerval) }
            if ( $PSBoundParameters.ContainsKey('deadinterval') ) { $payload.Add('deadinterval', $deadinterval) }
            if ( $PSBoundParameters.ContainsKey('failsafe') ) { $payload.Add('failsafe', $failsafe) }
            if ( $PSBoundParameters.ContainsKey('maxflips') ) { $payload.Add('maxflips', $maxflips) }
            if ( $PSBoundParameters.ContainsKey('maxfliptime') ) { $payload.Add('maxfliptime', $maxfliptime) }
            if ( $PSBoundParameters.ContainsKey('syncvlan') ) { $payload.Add('syncvlan', $syncvlan) }
            if ( $PSBoundParameters.ContainsKey('syncstatusstrictmode') ) { $payload.Add('syncstatusstrictmode', $syncstatusstrictmode) }
            if ( $PSCmdlet.ShouldProcess("hanode", "Update High Availability configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type hanode -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetHanode -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateHanode: Finished"
    }
}

function Invoke-ADCUnsetHanode {
    <#
    .SYNOPSIS
        Unset High Availability configuration Object.
    .DESCRIPTION
        Configuration for node resource.
    .PARAMETER Id 
        Number that uniquely identifies the node. For self node, it will always be 0. Peer node values can range from 1-64. 
    .PARAMETER Hastatus 
        The HA status of the node. The HA status STAYSECONDARY is used to force the secondary device stay as secondary independent of the state of the Primary device. For example, in an existing HA setup, the Primary node has to be upgraded and this process would take few seconds. During the upgradation, it is possible that the Primary node may suffer from a downtime for a few seconds. However, the Secondary should not take over as the Primary node. Thus, the Secondary node should remain as Secondary even if there is a failure in the Primary node. 
        STAYPRIMARY configuration keeps the node in primary state in case if it is healthy, even if the peer node was the primary node initially. If the node with STAYPRIMARY setting (and no peer node) is added to a primary node (which has this node as the peer) then this node takes over as the new primary and the older node becomes secondary. ENABLED state means normal HA operation without any constraints/preferences. DISABLED state disables the normal HA operation of the node. 
        Possible values = ENABLED, STAYSECONDARY, DISABLED, STAYPRIMARY 
    .PARAMETER Hasync 
        Automatically maintain synchronization by duplicating the configuration of the primary node on the secondary node. This setting is not propagated. Automatic synchronization requires that this setting be enabled (the default) on the current secondary node. Synchronization uses TCP port 3010. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Haprop 
        Automatically propagate all commands from the primary to the secondary node, except the following: 
        * All HA configuration related commands. For example, add ha node, set ha node, and bind ha node. 
        * All Interface related commands. For example, set interface and unset interface. 
        * All channels related commands. For example, add channel, set channel, and bind channel. 
        The propagated command is executed on the secondary node before it is executed on the primary. If command propagation fails, or if command execution fails on the secondary, the primary node executes the command and logs an error. Command propagation uses port 3010. 
        Note: After enabling propagation, run force synchronization on either node. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Hellointerval 
        Interval, in milliseconds, between heartbeat messages sent to the peer node. The heartbeat messages are UDP packets sent to port 3003 of the peer node. 
    .PARAMETER Deadinterval 
        Number of seconds after which a peer node is marked DOWN if heartbeat messages are not received from the peer node. 
    .PARAMETER Failsafe 
        Keep one node primary if both nodes fail the health check, so that a partially available node can back up data and handle traffic. This mode is set independently on each node. 
        Possible values = ON, OFF 
    .PARAMETER Maxflips 
        Max number of flips allowed before becoming sticky primary. 
    .PARAMETER Maxfliptime 
        Interval after which flipping of node states can again start. 
    .PARAMETER Syncvlan 
        Vlan on which HA related communication is sent. This include sync, propagation, connection mirroring, LB persistency config sync, persistent session sync and session state sync. However HA heartbeats can go all interfaces. 
    .PARAMETER Syncstatusstrictmode 
        strict mode flag for sync status. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetHanode 
        An example how to unset hanode configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetHanode
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode
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

        [Boolean]$id,

        [Boolean]$hastatus,

        [Boolean]$hasync,

        [Boolean]$haprop,

        [Boolean]$hellointerval,

        [Boolean]$deadinterval,

        [Boolean]$failsafe,

        [Boolean]$maxflips,

        [Boolean]$maxfliptime,

        [Boolean]$syncvlan,

        [Boolean]$syncstatusstrictmode 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetHanode: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('id') ) { $payload.Add('id', $id) }
            if ( $PSBoundParameters.ContainsKey('hastatus') ) { $payload.Add('hastatus', $hastatus) }
            if ( $PSBoundParameters.ContainsKey('hasync') ) { $payload.Add('hasync', $hasync) }
            if ( $PSBoundParameters.ContainsKey('haprop') ) { $payload.Add('haprop', $haprop) }
            if ( $PSBoundParameters.ContainsKey('hellointerval') ) { $payload.Add('hellointerval', $hellointerval) }
            if ( $PSBoundParameters.ContainsKey('deadinterval') ) { $payload.Add('deadinterval', $deadinterval) }
            if ( $PSBoundParameters.ContainsKey('failsafe') ) { $payload.Add('failsafe', $failsafe) }
            if ( $PSBoundParameters.ContainsKey('maxflips') ) { $payload.Add('maxflips', $maxflips) }
            if ( $PSBoundParameters.ContainsKey('maxfliptime') ) { $payload.Add('maxfliptime', $maxfliptime) }
            if ( $PSBoundParameters.ContainsKey('syncvlan') ) { $payload.Add('syncvlan', $syncvlan) }
            if ( $PSBoundParameters.ContainsKey('syncstatusstrictmode') ) { $payload.Add('syncstatusstrictmode', $syncstatusstrictmode) }
            if ( $PSCmdlet.ShouldProcess("hanode", "Unset High Availability configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type hanode -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetHanode: Finished"
    }
}

function Invoke-ADCGetHanode {
    <#
    .SYNOPSIS
        Get High Availability configuration object(s).
    .DESCRIPTION
        Configuration for node resource.
    .PARAMETER Id 
        Number that uniquely identifies the node. For self node, it will always be 0. Peer node values can range from 1-64. 
    .PARAMETER GetAll 
        Retrieve all hanode object(s).
    .PARAMETER Count
        If specified, the count of the hanode object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanode
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetHanode -GetAll 
        Get all hanode data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetHanode -Count 
        Get the number of hanode objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanode -name <string>
        Get hanode object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanode -Filter @{ 'name'='<value>' }
        Get hanode data with a filter.
    .NOTES
        File Name : Invoke-ADCGetHanode
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode/
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
        [ValidateRange(1, 64)]
        [double]$Id,

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
        Write-Verbose "Invoke-ADCGetHanode: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all hanode objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for hanode objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving hanode objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving hanode configuration for property 'id'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode -NitroPath nitro/v1/config -Resource $id -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving hanode configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetHanode: Ended"
    }
}

function Invoke-ADCGetHanodebinding {
    <#
    .SYNOPSIS
        Get High Availability configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to hanode.
    .PARAMETER Id 
        ID of the node whose HA settings you want to display. (The ID of the local node is always 0.). 
    .PARAMETER GetAll 
        Retrieve all hanode_binding object(s).
    .PARAMETER Count
        If specified, the count of the hanode_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanodebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetHanodebinding -GetAll 
        Get all hanode_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanodebinding -name <string>
        Get hanode_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanodebinding -Filter @{ 'name'='<value>' }
        Get hanode_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetHanodebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_binding/
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
        [ValidateRange(0, 64)]
        [double]$Id,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetHanodebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all hanode_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for hanode_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving hanode_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving hanode_binding configuration for property 'id'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_binding -NitroPath nitro/v1/config -Resource $id -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving hanode_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetHanodebinding: Ended"
    }
}

function Invoke-ADCGetHanodecibinding {
    <#
    .SYNOPSIS
        Get High Availability configuration object(s).
    .DESCRIPTION
        Binding object showing the ci that can be bound to hanode.
    .PARAMETER Id 
        Number that uniquely identifies the local node. The ID of the local node is always 0. 
    .PARAMETER GetAll 
        Retrieve all hanode_ci_binding object(s).
    .PARAMETER Count
        If specified, the count of the hanode_ci_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanodecibinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetHanodecibinding -GetAll 
        Get all hanode_ci_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetHanodecibinding -Count 
        Get the number of hanode_ci_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanodecibinding -name <string>
        Get hanode_ci_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanodecibinding -Filter @{ 'name'='<value>' }
        Get hanode_ci_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetHanodecibinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_ci_binding/
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
        [ValidateRange(0, 64)]
        [double]$Id,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetHanodecibinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all hanode_ci_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_ci_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for hanode_ci_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_ci_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving hanode_ci_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_ci_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving hanode_ci_binding configuration for property 'id'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_ci_binding -NitroPath nitro/v1/config -Resource $id -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving hanode_ci_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_ci_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetHanodecibinding: Ended"
    }
}

function Invoke-ADCGetHanodefisbinding {
    <#
    .SYNOPSIS
        Get High Availability configuration object(s).
    .DESCRIPTION
        Binding object showing the fis that can be bound to hanode.
    .PARAMETER Id 
        Number that uniquely identifies the local node. The ID of the local node is always 0. 
    .PARAMETER GetAll 
        Retrieve all hanode_fis_binding object(s).
    .PARAMETER Count
        If specified, the count of the hanode_fis_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanodefisbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetHanodefisbinding -GetAll 
        Get all hanode_fis_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetHanodefisbinding -Count 
        Get the number of hanode_fis_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanodefisbinding -name <string>
        Get hanode_fis_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanodefisbinding -Filter @{ 'name'='<value>' }
        Get hanode_fis_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetHanodefisbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_fis_binding/
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
        [ValidateRange(0, 64)]
        [double]$Id,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetHanodefisbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all hanode_fis_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_fis_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for hanode_fis_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_fis_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving hanode_fis_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_fis_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving hanode_fis_binding configuration for property 'id'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_fis_binding -NitroPath nitro/v1/config -Resource $id -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving hanode_fis_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_fis_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetHanodefisbinding: Ended"
    }
}

function Invoke-ADCGetHanodepartialfailureinterfacesbinding {
    <#
    .SYNOPSIS
        Get High Availability configuration object(s).
    .DESCRIPTION
        Binding object showing the partialfailureinterfaces that can be bound to hanode.
    .PARAMETER Id 
        Number that uniquely identifies the local node. The ID of the local node is always 0. 
    .PARAMETER GetAll 
        Retrieve all hanode_partialfailureinterfaces_binding object(s).
    .PARAMETER Count
        If specified, the count of the hanode_partialfailureinterfaces_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanodepartialfailureinterfacesbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetHanodepartialfailureinterfacesbinding -GetAll 
        Get all hanode_partialfailureinterfaces_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetHanodepartialfailureinterfacesbinding -Count 
        Get the number of hanode_partialfailureinterfaces_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanodepartialfailureinterfacesbinding -name <string>
        Get hanode_partialfailureinterfaces_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanodepartialfailureinterfacesbinding -Filter @{ 'name'='<value>' }
        Get hanode_partialfailureinterfaces_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetHanodepartialfailureinterfacesbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_partialfailureinterfaces_binding/
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
        [ValidateRange(0, 64)]
        [double]$Id,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetHanodepartialfailureinterfacesbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all hanode_partialfailureinterfaces_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_partialfailureinterfaces_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for hanode_partialfailureinterfaces_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_partialfailureinterfaces_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving hanode_partialfailureinterfaces_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_partialfailureinterfaces_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving hanode_partialfailureinterfaces_binding configuration for property 'id'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_partialfailureinterfaces_binding -NitroPath nitro/v1/config -Resource $id -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving hanode_partialfailureinterfaces_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_partialfailureinterfaces_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetHanodepartialfailureinterfacesbinding: Ended"
    }
}

function Invoke-ADCAddHanoderoutemonitor6binding {
    <#
    .SYNOPSIS
        Add High Availability configuration Object.
    .DESCRIPTION
        Binding object showing the routemonitor6 that can be bound to hanode.
    .PARAMETER Id 
        Number that uniquely identifies the local node. The ID of the local node is always 0. 
    .PARAMETER Routemonitor 
        The IP address (IPv4 or IPv6). 
    .PARAMETER Netmask 
        The netmask. 
    .PARAMETER PassThru 
        Return details about the created hanode_routemonitor6_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddHanoderoutemonitor6binding -routemonitor <string>
        An example how to add hanode_routemonitor6_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddHanoderoutemonitor6binding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_routemonitor6_binding/
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

        [ValidateRange(0, 64)]
        [double]$Id,

        [Parameter(Mandatory)]
        [string]$Routemonitor,

        [string]$Netmask,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddHanoderoutemonitor6binding: Starting"
    }
    process {
        try {
            $payload = @{ routemonitor = $routemonitor }
            if ( $PSBoundParameters.ContainsKey('id') ) { $payload.Add('id', $id) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSCmdlet.ShouldProcess("hanode_routemonitor6_binding", "Add High Availability configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type hanode_routemonitor6_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetHanoderoutemonitor6binding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddHanoderoutemonitor6binding: Finished"
    }
}

function Invoke-ADCDeleteHanoderoutemonitor6binding {
    <#
    .SYNOPSIS
        Delete High Availability configuration Object.
    .DESCRIPTION
        Binding object showing the routemonitor6 that can be bound to hanode.
    .PARAMETER Id 
        Number that uniquely identifies the local node. The ID of the local node is always 0. 
    .PARAMETER Routemonitor 
        The IP address (IPv4 or IPv6). 
    .PARAMETER Netmask 
        The netmask.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteHanoderoutemonitor6binding -Id <double>
        An example how to delete hanode_routemonitor6_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteHanoderoutemonitor6binding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_routemonitor6_binding/
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
        [double]$Id,

        [string]$Routemonitor,

        [string]$Netmask 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteHanoderoutemonitor6binding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Routemonitor') ) { $arguments.Add('routemonitor', $Routemonitor) }
            if ( $PSBoundParameters.ContainsKey('Netmask') ) { $arguments.Add('netmask', $Netmask) }
            if ( $PSCmdlet.ShouldProcess("$id", "Delete High Availability configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type hanode_routemonitor6_binding -NitroPath nitro/v1/config -Resource $id -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteHanoderoutemonitor6binding: Finished"
    }
}

function Invoke-ADCGetHanoderoutemonitor6binding {
    <#
    .SYNOPSIS
        Get High Availability configuration object(s).
    .DESCRIPTION
        Binding object showing the routemonitor6 that can be bound to hanode.
    .PARAMETER Id 
        Number that uniquely identifies the local node. The ID of the local node is always 0. 
    .PARAMETER GetAll 
        Retrieve all hanode_routemonitor6_binding object(s).
    .PARAMETER Count
        If specified, the count of the hanode_routemonitor6_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanoderoutemonitor6binding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetHanoderoutemonitor6binding -GetAll 
        Get all hanode_routemonitor6_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetHanoderoutemonitor6binding -Count 
        Get the number of hanode_routemonitor6_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanoderoutemonitor6binding -name <string>
        Get hanode_routemonitor6_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanoderoutemonitor6binding -Filter @{ 'name'='<value>' }
        Get hanode_routemonitor6_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetHanoderoutemonitor6binding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_routemonitor6_binding/
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
        [ValidateRange(0, 64)]
        [double]$Id,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetHanoderoutemonitor6binding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all hanode_routemonitor6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor6_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for hanode_routemonitor6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor6_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving hanode_routemonitor6_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor6_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving hanode_routemonitor6_binding configuration for property 'id'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor6_binding -NitroPath nitro/v1/config -Resource $id -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving hanode_routemonitor6_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor6_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetHanoderoutemonitor6binding: Ended"
    }
}

function Invoke-ADCAddHanoderoutemonitorbinding {
    <#
    .SYNOPSIS
        Add High Availability configuration Object.
    .DESCRIPTION
        Binding object showing the routemonitor that can be bound to hanode.
    .PARAMETER Id 
        Number that uniquely identifies the local node. The ID of the local node is always 0. 
    .PARAMETER Routemonitor 
        The IP address (IPv4 or IPv6). 
    .PARAMETER Netmask 
        The netmask. 
    .PARAMETER PassThru 
        Return details about the created hanode_routemonitor_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddHanoderoutemonitorbinding -routemonitor <string>
        An example how to add hanode_routemonitor_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddHanoderoutemonitorbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_routemonitor_binding/
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

        [ValidateRange(0, 64)]
        [double]$Id,

        [Parameter(Mandatory)]
        [string]$Routemonitor,

        [string]$Netmask,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddHanoderoutemonitorbinding: Starting"
    }
    process {
        try {
            $payload = @{ routemonitor = $routemonitor }
            if ( $PSBoundParameters.ContainsKey('id') ) { $payload.Add('id', $id) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSCmdlet.ShouldProcess("hanode_routemonitor_binding", "Add High Availability configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type hanode_routemonitor_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetHanoderoutemonitorbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddHanoderoutemonitorbinding: Finished"
    }
}

function Invoke-ADCDeleteHanoderoutemonitorbinding {
    <#
    .SYNOPSIS
        Delete High Availability configuration Object.
    .DESCRIPTION
        Binding object showing the routemonitor that can be bound to hanode.
    .PARAMETER Id 
        Number that uniquely identifies the local node. The ID of the local node is always 0. 
    .PARAMETER Routemonitor 
        The IP address (IPv4 or IPv6). 
    .PARAMETER Netmask 
        The netmask.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteHanoderoutemonitorbinding -Id <double>
        An example how to delete hanode_routemonitor_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteHanoderoutemonitorbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_routemonitor_binding/
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
        [double]$Id,

        [string]$Routemonitor,

        [string]$Netmask 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteHanoderoutemonitorbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Routemonitor') ) { $arguments.Add('routemonitor', $Routemonitor) }
            if ( $PSBoundParameters.ContainsKey('Netmask') ) { $arguments.Add('netmask', $Netmask) }
            if ( $PSCmdlet.ShouldProcess("$id", "Delete High Availability configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type hanode_routemonitor_binding -NitroPath nitro/v1/config -Resource $id -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteHanoderoutemonitorbinding: Finished"
    }
}

function Invoke-ADCGetHanoderoutemonitorbinding {
    <#
    .SYNOPSIS
        Get High Availability configuration object(s).
    .DESCRIPTION
        Binding object showing the routemonitor that can be bound to hanode.
    .PARAMETER Id 
        Number that uniquely identifies the local node. The ID of the local node is always 0. 
    .PARAMETER GetAll 
        Retrieve all hanode_routemonitor_binding object(s).
    .PARAMETER Count
        If specified, the count of the hanode_routemonitor_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanoderoutemonitorbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetHanoderoutemonitorbinding -GetAll 
        Get all hanode_routemonitor_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetHanoderoutemonitorbinding -Count 
        Get the number of hanode_routemonitor_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanoderoutemonitorbinding -name <string>
        Get hanode_routemonitor_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHanoderoutemonitorbinding -Filter @{ 'name'='<value>' }
        Get hanode_routemonitor_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetHanoderoutemonitorbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_routemonitor_binding/
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
        [ValidateRange(0, 64)]
        [double]$Id,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetHanoderoutemonitorbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all hanode_routemonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for hanode_routemonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving hanode_routemonitor_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving hanode_routemonitor_binding configuration for property 'id'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor_binding -NitroPath nitro/v1/config -Resource $id -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving hanode_routemonitor_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetHanoderoutemonitorbinding: Ended"
    }
}

function Invoke-ADCForceHasync {
    <#
    .SYNOPSIS
        Force High Availability configuration Object.
    .DESCRIPTION
        Configuration for sync resource.
    .PARAMETER Force 
        Force synchronization regardless of the state of HA propagation and HA synchronization on either node. 
    .PARAMETER Save 
        After synchronization, automatically save the configuration in the secondary node configuration file (ns.conf) without prompting for confirmation. 
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-ADCForceHasync 
        An example how to force hasync configuration Object(s).
    .NOTES
        File Name : Invoke-ADCForceHasync
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hasync/
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

        [boolean]$Force,

        [ValidateSet('YES', 'NO')]
        [string]$Save 

    )
    begin {
        Write-Verbose "Invoke-ADCForceHasync: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('force') ) { $payload.Add('force', $force) }
            if ( $PSBoundParameters.ContainsKey('save') ) { $payload.Add('save', $save) }
            if ( $PSCmdlet.ShouldProcess($Name, "Force High Availability configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type hasync -Action force -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCForceHasync: Finished"
    }
}

function Invoke-ADCGetHasyncfailures {
    <#
    .SYNOPSIS
        Get High Availability configuration object(s).
    .DESCRIPTION
        Configuration for HA sync failures resource.
    .PARAMETER GetAll 
        Retrieve all hasyncfailures object(s).
    .PARAMETER Count
        If specified, the count of the hasyncfailures object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHasyncfailures
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetHasyncfailures -GetAll 
        Get all hasyncfailures data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHasyncfailures -name <string>
        Get hasyncfailures object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetHasyncfailures -Filter @{ 'name'='<value>' }
        Get hasyncfailures data with a filter.
    .NOTES
        File Name : Invoke-ADCGetHasyncfailures
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hasyncfailures/
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
        Write-Verbose "Invoke-ADCGetHasyncfailures: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all hasyncfailures objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hasyncfailures -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for hasyncfailures objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hasyncfailures -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving hasyncfailures objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hasyncfailures -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving hasyncfailures configuration for property ''"

            } else {
                Write-Verbose "Retrieving hasyncfailures configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hasyncfailures -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetHasyncfailures: Ended"
    }
}

# SIG # Begin signature block
# MIIkrQYJKoZIhvcNAQcCoIIknjCCJJoCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDyco23RqgxJlD8
# /ASRSu+VenHY0f5/j6rWYaCzZfy5n6CCHnAwggTzMIID26ADAgECAhAsJ03zZBC0
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
# DAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQxIgQgjXRUJtF+hOYxWX7VhVw7g6pC
# NXfh4SqQlK+xnXAF9ekwDQYJKoZIhvcNAQEBBQAEggEANkIU01tehl2iZ0AFR4RU
# SnA5P5B+eLC3sQqXpyXaPWwT5fTNGi+OJjDw5CI8eR2Sn4T2UsoLmvTu0Q4hKQJM
# lcb1+d4eCubYlfveZQfshqYlYQ516W+Qr+QiKTi6OejK9/ntIgT+lgPGLRyjzJPA
# 9vvcpPe7nddFZa1XliDFMlsomLGg6L45e2uNT1T2almv0tvJSUoenOpq5PypbhBX
# cSVkx+LfYGHLq0tJQjlq6TjiJpby6UG6NBygcKrfGuHj8nxoZa8jlQb+WxWDLwGL
# w2ab9asUn5FZg9l9M0niGw732DkutyRsbYtckFarSTgASI5PiWClyNuEG+ghqA5e
# uqGCA0wwggNIBgkqhkiG9w0BCQYxggM5MIIDNQIBATCBkjB9MQswCQYDVQQGEwJH
# QjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3Jk
# MRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNB
# IFRpbWUgU3RhbXBpbmcgQ0ECEQCMd6AAj/TRsMY9nzpIg41rMA0GCWCGSAFlAwQC
# AgUAoHkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
# MjIwNDAzMTkwNTU5WjA/BgkqhkiG9w0BCQQxMgQwfhC4l42AeUds67X4U/Dn73Ye
# ntNUBeTUgJjUhigUmy2xE8wDhy3k56ESAi8ZAyKLMA0GCSqGSIb3DQEBAQUABIIC
# ADcNXZVRDPAnsDvOWNiTGgWBOuk/PfKXBJ2pt5I+ygYI85jhbhpHmLrNFCKFC2dH
# zeKW7Iyv0GMalTeSbPj68I33C336NUqPIPpRCeZ6N/dg6se3WxLaNPbgGRCLCpHi
# naFsogWyznKkNbYTi/odQFTuUi4n7PXvVUtKUIuzYYhiwz6bU7gbCq/YTKSnm8J6
# XUxG//Z89PvWQFAkS3EA7/grA+B4q0sy8afkFA3YIU2bi3s534geTGV5VQzwNuSn
# 28CZikIlJQD39UMMW4eVDQr/vkr8lICwBhvntAYdN/0XODSytMpUJDF6sWY+BHRG
# 6LKo9NE0tAGtG6MeJgTzi8fd8D5LgWq6NxA6KLXUQ4NZYq9P0B7oI4o/IQPtMrU7
# vewzBhkeBYmOuMhEIDvbtrmemkWOYQtIV92z9/ei8VbriMgWspBp0u1qp4mQUQK8
# qvM5o4KM3dqpYScZ1IGaCMuvjfxaYAmmbhAiIAcueH83uu4EVSRAE87Olldk9XUj
# QYecwJmsUFj2pbf4kQHFoBGH9mham2qa2kCiU0Wlw2MjFaDtV2Qxw9397NtGJB2C
# S10hU7p6Hqau0UBfPfE53lrlvQp0z8F0HhXh/O8qNEj6nSr7LtusjUHuk4fS5cGr
# E3iJMNJSejgsJIoKyF9EWgk0B6Vf8yXCzQfl7PzWBFVL
# SIG # End signature block
