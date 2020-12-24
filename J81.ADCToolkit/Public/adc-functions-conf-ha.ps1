function Invoke-ADCForceHafailover {
<#
    .SYNOPSIS
        Force High Availability configuration Object
    .DESCRIPTION
        Force High Availability configuration Object 
    .PARAMETER force 
        Force a failover without prompting for confirmation.
    .EXAMPLE
        Invoke-ADCForceHafailover 
    .NOTES
        File Name : Invoke-ADCForceHafailover
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hafailover/
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

        [boolean]$force 

    )
    begin {
        Write-Verbose "Invoke-ADCForceHafailover: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('force')) { $Payload.Add('force', $force) }
            if ($PSCmdlet.ShouldProcess($Name, "Force High Availability configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type hafailover -Action force -Payload $Payload -GetWarning
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
        Sync High Availability configuration Object
    .DESCRIPTION
        Sync High Availability configuration Object 
    .PARAMETER mode 
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
        Invoke-ADCSyncHafiles 
    .NOTES
        File Name : Invoke-ADCSyncHafiles
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hafiles/
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
        Write-Verbose "Invoke-ADCSyncHafiles: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('mode')) { $Payload.Add('mode', $mode) }
            if ($PSCmdlet.ShouldProcess($Name, "Sync High Availability configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type hafiles -Action sync -Payload $Payload -GetWarning
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
        Add High Availability configuration Object
    .DESCRIPTION
        Add High Availability configuration Object 
    .PARAMETER id 
        Number that uniquely identifies the node. For self node, it will always be 0. Peer node values can range from 1-64.  
        Minimum value = 1  
        Maximum value = 64 
    .PARAMETER ipaddress 
        The NSIP or NSIP6 address of the node to be added for an HA configuration. This setting is neither propagated nor synchronized.  
        Minimum length = 1 
    .PARAMETER inc 
        This option is required if the HA nodes reside on different networks. When this mode is enabled, the following independent network entities and configurations are neither propagated nor synced to the other node: MIPs, SNIPs, VLANs, routes (except LLB routes), route monitors, RNAT rules (except any RNAT rule with a VIP as the NAT IP), and dynamic routing configurations. They are maintained independently on each node.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created hanode item.
    .EXAMPLE
        Invoke-ADCAddHanode -id <double> -ipaddress <string>
    .NOTES
        File Name : Invoke-ADCAddHanode
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode/
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
        [ValidateRange(1, 64)]
        [double]$id ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ipaddress ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$inc = 'DISABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddHanode: Starting"
    }
    process {
        try {
            $Payload = @{
                id = $id
                ipaddress = $ipaddress
            }
            if ($PSBoundParameters.ContainsKey('inc')) { $Payload.Add('inc', $inc) }
 
            if ($PSCmdlet.ShouldProcess("hanode", "Add High Availability configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type hanode -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetHanode -Filter $Payload)
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
        Delete High Availability configuration Object
    .DESCRIPTION
        Delete High Availability configuration Object
    .PARAMETER id 
       Number that uniquely identifies the node. For self node, it will always be 0. Peer node values can range from 1-64.  
       Minimum value = 1  
       Maximum value = 64 
    .EXAMPLE
        Invoke-ADCDeleteHanode -id <double>
    .NOTES
        File Name : Invoke-ADCDeleteHanode
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode/
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
        [double]$id 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteHanode: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$id", "Delete High Availability configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type hanode -Resource $id -Arguments $Arguments
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
        Update High Availability configuration Object
    .DESCRIPTION
        Update High Availability configuration Object 
    .PARAMETER id 
        Number that uniquely identifies the node. For self node, it will always be 0. Peer node values can range from 1-64.  
        Minimum value = 1  
        Maximum value = 64 
    .PARAMETER hastatus 
        The HA status of the node. The HA status STAYSECONDARY is used to force the secondary device stay as secondary independent of the state of the Primary device. For example, in an existing HA setup, the Primary node has to be upgraded and this process would take few seconds. During the upgradation, it is possible that the Primary node may suffer from a downtime for a few seconds. However, the Secondary should not take over as the Primary node. Thus, the Secondary node should remain as Secondary even if there is a failure in the Primary node.  
        STAYPRIMARY configuration keeps the node in primary state in case if it is healthy, even if the peer node was the primary node initially. If the node with STAYPRIMARY setting (and no peer node) is added to a primary node (which has this node as the peer) then this node takes over as the new primary and the older node becomes secondary. ENABLED state means normal HA operation without any constraints/preferences. DISABLED state disables the normal HA operation of the node.  
        Possible values = ENABLED, STAYSECONDARY, DISABLED, STAYPRIMARY 
    .PARAMETER hasync 
        Automatically maintain synchronization by duplicating the configuration of the primary node on the secondary node. This setting is not propagated. Automatic synchronization requires that this setting be enabled (the default) on the current secondary node. Synchronization uses TCP port 3010.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER haprop 
        Automatically propagate all commands from the primary to the secondary node, except the following:  
        * All HA configuration related commands. For example, add ha node, set ha node, and bind ha node.  
        * All Interface related commands. For example, set interface and unset interface.  
        * All channels related commands. For example, add channel, set channel, and bind channel.  
        The propagated command is executed on the secondary node before it is executed on the primary. If command propagation fails, or if command execution fails on the secondary, the primary node executes the command and logs an error. Command propagation uses port 3010.  
        Note: After enabling propagation, run force synchronization on either node.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER hellointerval 
        Interval, in milliseconds, between heartbeat messages sent to the peer node. The heartbeat messages are UDP packets sent to port 3003 of the peer node.  
        Default value: 200  
        Minimum value = 200  
        Maximum value = 1000 
    .PARAMETER deadinterval 
        Number of seconds after which a peer node is marked DOWN if heartbeat messages are not received from the peer node.  
        Default value: 3  
        Minimum value = 3  
        Maximum value = 60 
    .PARAMETER failsafe 
        Keep one node primary if both nodes fail the health check, so that a partially available node can back up data and handle traffic. This mode is set independently on each node.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER maxflips 
        Max number of flips allowed before becoming sticky primary.  
        Default value: 0 
    .PARAMETER maxfliptime 
        Interval after which flipping of node states can again start.  
        Default value: 0 
    .PARAMETER syncvlan 
        Vlan on which HA related communication is sent. This include sync, propagation , connection mirroring , LB persistency config sync, persistent session sync and session state sync. However HA heartbeats can go all interfaces.  
        Minimum value = 1  
        Maximum value = 4094 
    .PARAMETER syncstatusstrictmode 
        strict mode flag for sync status.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created hanode item.
    .EXAMPLE
        Invoke-ADCUpdateHanode 
    .NOTES
        File Name : Invoke-ADCUpdateHanode
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode/
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

        [ValidateRange(1, 64)]
        [double]$id ,

        [ValidateSet('ENABLED', 'STAYSECONDARY', 'DISABLED', 'STAYPRIMARY')]
        [string]$hastatus ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$hasync ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$haprop ,

        [ValidateRange(200, 1000)]
        [double]$hellointerval ,

        [ValidateRange(3, 60)]
        [double]$deadinterval ,

        [ValidateSet('ON', 'OFF')]
        [string]$failsafe ,

        [double]$maxflips ,

        [double]$maxfliptime ,

        [ValidateRange(1, 4094)]
        [double]$syncvlan ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$syncstatusstrictmode ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateHanode: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('id')) { $Payload.Add('id', $id) }
            if ($PSBoundParameters.ContainsKey('hastatus')) { $Payload.Add('hastatus', $hastatus) }
            if ($PSBoundParameters.ContainsKey('hasync')) { $Payload.Add('hasync', $hasync) }
            if ($PSBoundParameters.ContainsKey('haprop')) { $Payload.Add('haprop', $haprop) }
            if ($PSBoundParameters.ContainsKey('hellointerval')) { $Payload.Add('hellointerval', $hellointerval) }
            if ($PSBoundParameters.ContainsKey('deadinterval')) { $Payload.Add('deadinterval', $deadinterval) }
            if ($PSBoundParameters.ContainsKey('failsafe')) { $Payload.Add('failsafe', $failsafe) }
            if ($PSBoundParameters.ContainsKey('maxflips')) { $Payload.Add('maxflips', $maxflips) }
            if ($PSBoundParameters.ContainsKey('maxfliptime')) { $Payload.Add('maxfliptime', $maxfliptime) }
            if ($PSBoundParameters.ContainsKey('syncvlan')) { $Payload.Add('syncvlan', $syncvlan) }
            if ($PSBoundParameters.ContainsKey('syncstatusstrictmode')) { $Payload.Add('syncstatusstrictmode', $syncstatusstrictmode) }
 
            if ($PSCmdlet.ShouldProcess("hanode", "Update High Availability configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type hanode -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetHanode -Filter $Payload)
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
        Unset High Availability configuration Object
    .DESCRIPTION
        Unset High Availability configuration Object 
   .PARAMETER id 
       Number that uniquely identifies the node. For self node, it will always be 0. Peer node values can . 
   .PARAMETER hastatus 
       The HA status of the node. The HA status STAYSECONDARY is used to force the secondary device stay as secondary independent of the state of the Primary device. For example, in an existing HA setup, the Primary node has to be upgraded and this process would take few seconds. During the upgradation, it is possible that the Primary node may suffer from a downtime for a few seconds. However, the Secondary should not take over as the Primary node. Thus, the Secondary node should remain as Secondary even if there is a failure in the Primary node.  
       STAYPRIMARY configuration keeps the node in primary state in case if it is healthy, even if the peer node was the primary node initially. If the node with STAYPRIMARY setting (and no peer node) is added to a primary node (which has this node as the peer) then this node takes over as the new primary and the older node becomes secondary. ENABLED state means normal HA operation without any constraints/preferences. DISABLED state disables the normal HA operation of the node.  
       Possible values = ENABLED, STAYSECONDARY, DISABLED, STAYPRIMARY 
   .PARAMETER hasync 
       Automatically maintain synchronization by duplicating the configuration of the primary node on the secondary node. This setting is not propagated. Automatic synchronization requires that this setting be enabled (the default) on the current secondary node. Synchronization uses TCP port 3010.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER haprop 
       Automatically propagate all commands from the primary to the secondary node, except the following:  
       * All HA configuration related commands. For example, add ha node, set ha node, and bind ha node.  
       * All Interface related commands. For example, set interface and unset interface.  
       * All channels related commands. For example, add channel, set channel, and bind channel.  
       The propagated command is executed on the secondary node before it is executed on the primary. If command propagation fails, or if command execution fails on the secondary, the primary node executes the command and logs an error. Command propagation uses port 3010.  
       Note: After enabling propagation, run force synchronization on either node.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER hellointerval 
       Interval, in milliseconds, between heartbeat messages sent to the peer node. The heartbeat messages are UDP packets sent to port 3003 of the peer node. 
   .PARAMETER deadinterval 
       Number of seconds after which a peer node is marked DOWN if heartbeat messages are not received from the peer node. 
   .PARAMETER failsafe 
       Keep one node primary if both nodes fail the health check, so that a partially available node can back up data and handle traffic. This mode is set independently on each node.  
       Possible values = ON, OFF 
   .PARAMETER maxflips 
       Max number of flips allowed before becoming sticky primary. 
   .PARAMETER maxfliptime 
       Interval after which flipping of node states can again start. 
   .PARAMETER syncvlan 
       Vlan on which HA related communication is sent. This include sync, propagation , connection mirroring , LB persistency config sync, persistent session sync and session state sync. However HA heartbeats can go all interfaces. 
   .PARAMETER syncstatusstrictmode 
       strict mode flag for sync status.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetHanode 
    .NOTES
        File Name : Invoke-ADCUnsetHanode
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode
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

        [Boolean]$id ,

        [Boolean]$hastatus ,

        [Boolean]$hasync ,

        [Boolean]$haprop ,

        [Boolean]$hellointerval ,

        [Boolean]$deadinterval ,

        [Boolean]$failsafe ,

        [Boolean]$maxflips ,

        [Boolean]$maxfliptime ,

        [Boolean]$syncvlan ,

        [Boolean]$syncstatusstrictmode 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetHanode: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('id')) { $Payload.Add('id', $id) }
            if ($PSBoundParameters.ContainsKey('hastatus')) { $Payload.Add('hastatus', $hastatus) }
            if ($PSBoundParameters.ContainsKey('hasync')) { $Payload.Add('hasync', $hasync) }
            if ($PSBoundParameters.ContainsKey('haprop')) { $Payload.Add('haprop', $haprop) }
            if ($PSBoundParameters.ContainsKey('hellointerval')) { $Payload.Add('hellointerval', $hellointerval) }
            if ($PSBoundParameters.ContainsKey('deadinterval')) { $Payload.Add('deadinterval', $deadinterval) }
            if ($PSBoundParameters.ContainsKey('failsafe')) { $Payload.Add('failsafe', $failsafe) }
            if ($PSBoundParameters.ContainsKey('maxflips')) { $Payload.Add('maxflips', $maxflips) }
            if ($PSBoundParameters.ContainsKey('maxfliptime')) { $Payload.Add('maxfliptime', $maxfliptime) }
            if ($PSBoundParameters.ContainsKey('syncvlan')) { $Payload.Add('syncvlan', $syncvlan) }
            if ($PSBoundParameters.ContainsKey('syncstatusstrictmode')) { $Payload.Add('syncstatusstrictmode', $syncstatusstrictmode) }
            if ($PSCmdlet.ShouldProcess("hanode", "Unset High Availability configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type hanode -Action unset -Payload $Payload -GetWarning
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
        Get High Availability configuration object(s)
    .DESCRIPTION
        Get High Availability configuration object(s)
    .PARAMETER id 
       Number that uniquely identifies the node. For self node, it will always be 0. Peer node values can . 
    .PARAMETER GetAll 
        Retreive all hanode object(s)
    .PARAMETER Count
        If specified, the count of the hanode object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetHanode
    .EXAMPLE 
        Invoke-ADCGetHanode -GetAll 
    .EXAMPLE 
        Invoke-ADCGetHanode -Count
    .EXAMPLE
        Invoke-ADCGetHanode -name <string>
    .EXAMPLE
        Invoke-ADCGetHanode -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetHanode
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode/
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
        [ValidateRange(1, 64)]
        [double]$id,

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
        Write-Verbose "Invoke-ADCGetHanode: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all hanode objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for hanode objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving hanode objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving hanode configuration for property 'id'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode -Resource $id -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving hanode configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get High Availability configuration object(s)
    .DESCRIPTION
        Get High Availability configuration object(s)
    .PARAMETER id 
       ID of the node whose HA settings you want to display. (The ID of the local node is always 0.). 
    .PARAMETER GetAll 
        Retreive all hanode_binding object(s)
    .PARAMETER Count
        If specified, the count of the hanode_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetHanodebinding
    .EXAMPLE 
        Invoke-ADCGetHanodebinding -GetAll
    .EXAMPLE
        Invoke-ADCGetHanodebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetHanodebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetHanodebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_binding/
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
        [ValidateRange(0, 64)]
        [double]$id,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetHanodebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all hanode_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for hanode_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving hanode_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving hanode_binding configuration for property 'id'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_binding -Resource $id -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving hanode_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get High Availability configuration object(s)
    .DESCRIPTION
        Get High Availability configuration object(s)
    .PARAMETER id 
       Number that uniquely identifies the local node. The ID of the local node is always 0. 
    .PARAMETER GetAll 
        Retreive all hanode_ci_binding object(s)
    .PARAMETER Count
        If specified, the count of the hanode_ci_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetHanodecibinding
    .EXAMPLE 
        Invoke-ADCGetHanodecibinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetHanodecibinding -Count
    .EXAMPLE
        Invoke-ADCGetHanodecibinding -name <string>
    .EXAMPLE
        Invoke-ADCGetHanodecibinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetHanodecibinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_ci_binding/
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
        [ValidateRange(0, 64)]
        [double]$id,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all hanode_ci_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_ci_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for hanode_ci_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_ci_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving hanode_ci_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_ci_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving hanode_ci_binding configuration for property 'id'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_ci_binding -Resource $id -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving hanode_ci_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_ci_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get High Availability configuration object(s)
    .DESCRIPTION
        Get High Availability configuration object(s)
    .PARAMETER id 
       Number that uniquely identifies the local node. The ID of the local node is always 0. 
    .PARAMETER GetAll 
        Retreive all hanode_fis_binding object(s)
    .PARAMETER Count
        If specified, the count of the hanode_fis_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetHanodefisbinding
    .EXAMPLE 
        Invoke-ADCGetHanodefisbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetHanodefisbinding -Count
    .EXAMPLE
        Invoke-ADCGetHanodefisbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetHanodefisbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetHanodefisbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_fis_binding/
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
        [ValidateRange(0, 64)]
        [double]$id,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all hanode_fis_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_fis_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for hanode_fis_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_fis_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving hanode_fis_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_fis_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving hanode_fis_binding configuration for property 'id'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_fis_binding -Resource $id -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving hanode_fis_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_fis_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get High Availability configuration object(s)
    .DESCRIPTION
        Get High Availability configuration object(s)
    .PARAMETER id 
       Number that uniquely identifies the local node. The ID of the local node is always 0. 
    .PARAMETER GetAll 
        Retreive all hanode_partialfailureinterfaces_binding object(s)
    .PARAMETER Count
        If specified, the count of the hanode_partialfailureinterfaces_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetHanodepartialfailureinterfacesbinding
    .EXAMPLE 
        Invoke-ADCGetHanodepartialfailureinterfacesbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetHanodepartialfailureinterfacesbinding -Count
    .EXAMPLE
        Invoke-ADCGetHanodepartialfailureinterfacesbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetHanodepartialfailureinterfacesbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetHanodepartialfailureinterfacesbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_partialfailureinterfaces_binding/
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
        [ValidateRange(0, 64)]
        [double]$id,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all hanode_partialfailureinterfaces_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_partialfailureinterfaces_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for hanode_partialfailureinterfaces_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_partialfailureinterfaces_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving hanode_partialfailureinterfaces_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_partialfailureinterfaces_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving hanode_partialfailureinterfaces_binding configuration for property 'id'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_partialfailureinterfaces_binding -Resource $id -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving hanode_partialfailureinterfaces_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_partialfailureinterfaces_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add High Availability configuration Object
    .DESCRIPTION
        Add High Availability configuration Object 
    .PARAMETER id 
        Number that uniquely identifies the local node. The ID of the local node is always 0.  
        Minimum value = 0  
        Maximum value = 64 
    .PARAMETER routemonitor 
        The IP address (IPv4 or IPv6). 
    .PARAMETER netmask 
        The netmask. 
    .PARAMETER PassThru 
        Return details about the created hanode_routemonitor6_binding item.
    .EXAMPLE
        Invoke-ADCAddHanoderoutemonitor6binding -routemonitor <string>
    .NOTES
        File Name : Invoke-ADCAddHanoderoutemonitor6binding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_routemonitor6_binding/
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

        [ValidateRange(0, 64)]
        [double]$id ,

        [Parameter(Mandatory = $true)]
        [string]$routemonitor ,

        [string]$netmask ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddHanoderoutemonitor6binding: Starting"
    }
    process {
        try {
            $Payload = @{
                routemonitor = $routemonitor
            }
            if ($PSBoundParameters.ContainsKey('id')) { $Payload.Add('id', $id) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Payload.Add('netmask', $netmask) }
 
            if ($PSCmdlet.ShouldProcess("hanode_routemonitor6_binding", "Add High Availability configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type hanode_routemonitor6_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetHanoderoutemonitor6binding -Filter $Payload)
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
        Delete High Availability configuration Object
    .DESCRIPTION
        Delete High Availability configuration Object
    .PARAMETER id 
       Number that uniquely identifies the local node. The ID of the local node is always 0.  
       Minimum value = 0  
       Maximum value = 64    .PARAMETER routemonitor 
       The IP address (IPv4 or IPv6).    .PARAMETER netmask 
       The netmask.
    .EXAMPLE
        Invoke-ADCDeleteHanoderoutemonitor6binding -id <double>
    .NOTES
        File Name : Invoke-ADCDeleteHanoderoutemonitor6binding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_routemonitor6_binding/
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
        [double]$id ,

        [string]$routemonitor ,

        [string]$netmask 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteHanoderoutemonitor6binding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('routemonitor')) { $Arguments.Add('routemonitor', $routemonitor) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Arguments.Add('netmask', $netmask) }
            if ($PSCmdlet.ShouldProcess("$id", "Delete High Availability configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type hanode_routemonitor6_binding -Resource $id -Arguments $Arguments
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
        Get High Availability configuration object(s)
    .DESCRIPTION
        Get High Availability configuration object(s)
    .PARAMETER id 
       Number that uniquely identifies the local node. The ID of the local node is always 0. 
    .PARAMETER GetAll 
        Retreive all hanode_routemonitor6_binding object(s)
    .PARAMETER Count
        If specified, the count of the hanode_routemonitor6_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetHanoderoutemonitor6binding
    .EXAMPLE 
        Invoke-ADCGetHanoderoutemonitor6binding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetHanoderoutemonitor6binding -Count
    .EXAMPLE
        Invoke-ADCGetHanoderoutemonitor6binding -name <string>
    .EXAMPLE
        Invoke-ADCGetHanoderoutemonitor6binding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetHanoderoutemonitor6binding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_routemonitor6_binding/
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
        [ValidateRange(0, 64)]
        [double]$id,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all hanode_routemonitor6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor6_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for hanode_routemonitor6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor6_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving hanode_routemonitor6_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor6_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving hanode_routemonitor6_binding configuration for property 'id'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor6_binding -Resource $id -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving hanode_routemonitor6_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor6_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add High Availability configuration Object
    .DESCRIPTION
        Add High Availability configuration Object 
    .PARAMETER id 
        Number that uniquely identifies the local node. The ID of the local node is always 0.  
        Minimum value = 0  
        Maximum value = 64 
    .PARAMETER routemonitor 
        The IP address (IPv4 or IPv6). 
    .PARAMETER netmask 
        The netmask. 
    .PARAMETER PassThru 
        Return details about the created hanode_routemonitor_binding item.
    .EXAMPLE
        Invoke-ADCAddHanoderoutemonitorbinding -routemonitor <string>
    .NOTES
        File Name : Invoke-ADCAddHanoderoutemonitorbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_routemonitor_binding/
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

        [ValidateRange(0, 64)]
        [double]$id ,

        [Parameter(Mandatory = $true)]
        [string]$routemonitor ,

        [string]$netmask ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddHanoderoutemonitorbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                routemonitor = $routemonitor
            }
            if ($PSBoundParameters.ContainsKey('id')) { $Payload.Add('id', $id) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Payload.Add('netmask', $netmask) }
 
            if ($PSCmdlet.ShouldProcess("hanode_routemonitor_binding", "Add High Availability configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type hanode_routemonitor_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetHanoderoutemonitorbinding -Filter $Payload)
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
        Delete High Availability configuration Object
    .DESCRIPTION
        Delete High Availability configuration Object
    .PARAMETER id 
       Number that uniquely identifies the local node. The ID of the local node is always 0.  
       Minimum value = 0  
       Maximum value = 64    .PARAMETER routemonitor 
       The IP address (IPv4 or IPv6).    .PARAMETER netmask 
       The netmask.
    .EXAMPLE
        Invoke-ADCDeleteHanoderoutemonitorbinding -id <double>
    .NOTES
        File Name : Invoke-ADCDeleteHanoderoutemonitorbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_routemonitor_binding/
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
        [double]$id ,

        [string]$routemonitor ,

        [string]$netmask 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteHanoderoutemonitorbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('routemonitor')) { $Arguments.Add('routemonitor', $routemonitor) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Arguments.Add('netmask', $netmask) }
            if ($PSCmdlet.ShouldProcess("$id", "Delete High Availability configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type hanode_routemonitor_binding -Resource $id -Arguments $Arguments
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
        Get High Availability configuration object(s)
    .DESCRIPTION
        Get High Availability configuration object(s)
    .PARAMETER id 
       Number that uniquely identifies the local node. The ID of the local node is always 0. 
    .PARAMETER GetAll 
        Retreive all hanode_routemonitor_binding object(s)
    .PARAMETER Count
        If specified, the count of the hanode_routemonitor_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetHanoderoutemonitorbinding
    .EXAMPLE 
        Invoke-ADCGetHanoderoutemonitorbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetHanoderoutemonitorbinding -Count
    .EXAMPLE
        Invoke-ADCGetHanoderoutemonitorbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetHanoderoutemonitorbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetHanoderoutemonitorbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hanode_routemonitor_binding/
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
        [ValidateRange(0, 64)]
        [double]$id,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all hanode_routemonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for hanode_routemonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving hanode_routemonitor_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving hanode_routemonitor_binding configuration for property 'id'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor_binding -Resource $id -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving hanode_routemonitor_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hanode_routemonitor_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Force High Availability configuration Object
    .DESCRIPTION
        Force High Availability configuration Object 
    .PARAMETER force 
        Force synchronization regardless of the state of HA propagation and HA synchronization on either node. 
    .PARAMETER save 
        After synchronization, automatically save the configuration in the secondary node configuration file (ns.conf) without prompting for confirmation.  
        Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCForceHasync 
    .NOTES
        File Name : Invoke-ADCForceHasync
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hasync/
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

        [boolean]$force ,

        [ValidateSet('YES', 'NO')]
        [string]$save 

    )
    begin {
        Write-Verbose "Invoke-ADCForceHasync: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('force')) { $Payload.Add('force', $force) }
            if ($PSBoundParameters.ContainsKey('save')) { $Payload.Add('save', $save) }
            if ($PSCmdlet.ShouldProcess($Name, "Force High Availability configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type hasync -Action force -Payload $Payload -GetWarning
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
        Get High Availability configuration object(s)
    .DESCRIPTION
        Get High Availability configuration object(s)
    .PARAMETER GetAll 
        Retreive all hasyncfailures object(s)
    .PARAMETER Count
        If specified, the count of the hasyncfailures object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetHasyncfailures
    .EXAMPLE 
        Invoke-ADCGetHasyncfailures -GetAll
    .EXAMPLE
        Invoke-ADCGetHasyncfailures -name <string>
    .EXAMPLE
        Invoke-ADCGetHasyncfailures -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetHasyncfailures
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ha/hasyncfailures/
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
        Write-Verbose "Invoke-ADCGetHasyncfailures: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all hasyncfailures objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hasyncfailures -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for hasyncfailures objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hasyncfailures -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving hasyncfailures objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hasyncfailures -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving hasyncfailures configuration for property ''"

            } else {
                Write-Verbose "Retrieving hasyncfailures configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type hasyncfailures -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


