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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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


