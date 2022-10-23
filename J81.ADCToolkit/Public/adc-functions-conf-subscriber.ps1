function Invoke-ADCUpdateSubscribergxinterface {
    <#
    .SYNOPSIS
        Update Subscriber configuration Object.
    .DESCRIPTION
        Configuration for Gx interface Parameters resource.
    .PARAMETER Vserver 
        Name of the load balancing, or content switching vserver to which the Gx connections are established. The service type of the virtual server must be DIAMETER/SSL_DIAMETER. Mutually exclusive with the service parameter. Therefore, you cannot set both service and the Virtual Server in the Gx Interface. 
    .PARAMETER Service 
        Name of DIAMETER/SSL_DIAMETER service corresponding to PCRF to which the Gx connection is established. The service type of the service must be DIAMETER/SSL_DIAMETER. Mutually exclusive with vserver parameter. Therefore, you cannot set both Service and the Virtual Server in the Gx Interface. 
    .PARAMETER Pcrfrealm 
        PCRF realm is of type DiameterIdentity and contains the realm of PCRF to which the message is to be routed. This is the realm used in Destination-Realm AVP by Citrix ADC Gx client (as a Diameter node). 
    .PARAMETER Holdonsubscriberabsence 
        Set this setting to yes if Citrix ADC needs to Hold pakcets till subscriber session is fetched from PCRF. Else set to NO. By default set to yes. If this setting is set to NO, then till Citrix ADC fetches subscriber from PCRF, default subscriber profile will be applied to this subscriber if configured. If default subscriber profile is also not configured an undef would be raised to expressions which use Subscriber attributes. . 
        Possible values = YES, NO 
    .PARAMETER Requesttimeout 
        q!Time, in seconds, within which the Gx CCR request must complete. If the request does not complete within this time, the request is retransmitted for requestRetryAttempts time. If still reuqest is not complete then default subscriber profile will be applied to this subscriber if configured. If default subscriber profile is also not configured an undef would be raised to expressions which use Subscriber attributes. 
        Zero disables the timeout. !. 
    .PARAMETER Requestretryattempts 
        If the request does not complete within requestTimeout time, the request is retransmitted for requestRetryAttempts time. 
    .PARAMETER Idlettl 
        q!Idle Time, in seconds, after which the Gx CCR-U request will be sent after any PCRF activity on a session. Any RAR or CCA message resets the timer. 
        Zero value disables the idle timeout. !. 
    .PARAMETER Revalidationtimeout 
        q!Revalidation Timeout, in seconds, after which the Gx CCR-U request will be sent after any PCRF activity on a session. Any RAR or CCA message resets the timer. 
        Zero value disables the idle timeout. !. 
    .PARAMETER Healthcheck 
        q!Set this setting to yes if Citrix ADC should send DWR packets to PCRF server. When the session is idle, healthcheck timer expires and DWR packets are initiated in order to check that PCRF server is active. By default set to No. !. 
        Possible values = YES, NO 
    .PARAMETER Healthcheckttl 
        q!Healthcheck timeout, in seconds, after which the DWR will be sent in order to ensure the state of the PCRF server. Any CCR, CCA, RAR or RRA message resets the timer. !. 
    .PARAMETER Cerrequesttimeout 
        q!Healthcheck request timeout, in seconds, after which the Citrix ADC considers that no CCA packet received to the initiated CCR. After this time Citrix ADC should send again CCR to PCRF server. !. 
    .PARAMETER Negativettl 
        q!Negative TTL, in seconds, after which the Gx CCR-I request will be resent for sessions that have not been resolved by PCRF due to server being down or no response or failed response. Instead of polling the PCRF server constantly, negative-TTL makes Citrix ADC stick to un-resolved session. Meanwhile Citrix ADC installs a negative session to avoid going to PCRF. 
        For Negative Sessions, Netcaler inherits the attributes from default subscriber profile if default subscriber is configured. A default subscriber could be configured as 'add subscriber profile *'. Or these attributes can be inherited from Radius as well if Radius is configued. 
        Zero value disables the Negative Sessions. And Citrix ADC does not install Negative sessions even if subscriber session could not be fetched. !. 
    .PARAMETER Negativettllimitedsuccess 
        Set this to YES if Citrix ADC should create negative session for Result-Code DIAMETER_LIMITED_SUCCESS (2002) received in CCA-I. If set to NO, regular session is created. 
        Possible values = YES, NO 
    .PARAMETER Purgesdbongxfailure 
        Set this setting to YES if needed to purge Subscriber Database in case of Gx failure. By default set to NO. . 
        Possible values = YES, NO 
    .PARAMETER Servicepathavp 
        The AVP code in which PCRF sends service path applicable for subscriber. 
    .PARAMETER Servicepathvendorid 
        The vendorid of the AVP in which PCRF sends service path for subscriber.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateSubscribergxinterface 
        An example how to update subscribergxinterface configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateSubscribergxinterface
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscribergxinterface/
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
        [string]$Vserver,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Service,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Pcrfrealm,

        [ValidateSet('YES', 'NO')]
        [string]$Holdonsubscriberabsence,

        [ValidateRange(0, 86400)]
        [double]$Requesttimeout,

        [double]$Requestretryattempts,

        [ValidateRange(0, 86400)]
        [double]$Idlettl,

        [ValidateRange(0, 86400)]
        [double]$Revalidationtimeout,

        [ValidateSet('YES', 'NO')]
        [string]$Healthcheck,

        [ValidateRange(6, 86400)]
        [double]$Healthcheckttl,

        [ValidateRange(0, 86400)]
        [double]$Cerrequesttimeout,

        [ValidateRange(0, 86400)]
        [double]$Negativettl,

        [ValidateSet('YES', 'NO')]
        [string]$Negativettllimitedsuccess,

        [ValidateSet('YES', 'NO')]
        [string]$Purgesdbongxfailure,

        [double[]]$Servicepathavp,

        [double]$Servicepathvendorid 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSubscribergxinterface: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSBoundParameters.ContainsKey('service') ) { $payload.Add('service', $service) }
            if ( $PSBoundParameters.ContainsKey('pcrfrealm') ) { $payload.Add('pcrfrealm', $pcrfrealm) }
            if ( $PSBoundParameters.ContainsKey('holdonsubscriberabsence') ) { $payload.Add('holdonsubscriberabsence', $holdonsubscriberabsence) }
            if ( $PSBoundParameters.ContainsKey('requesttimeout') ) { $payload.Add('requesttimeout', $requesttimeout) }
            if ( $PSBoundParameters.ContainsKey('requestretryattempts') ) { $payload.Add('requestretryattempts', $requestretryattempts) }
            if ( $PSBoundParameters.ContainsKey('idlettl') ) { $payload.Add('idlettl', $idlettl) }
            if ( $PSBoundParameters.ContainsKey('revalidationtimeout') ) { $payload.Add('revalidationtimeout', $revalidationtimeout) }
            if ( $PSBoundParameters.ContainsKey('healthcheck') ) { $payload.Add('healthcheck', $healthcheck) }
            if ( $PSBoundParameters.ContainsKey('healthcheckttl') ) { $payload.Add('healthcheckttl', $healthcheckttl) }
            if ( $PSBoundParameters.ContainsKey('cerrequesttimeout') ) { $payload.Add('cerrequesttimeout', $cerrequesttimeout) }
            if ( $PSBoundParameters.ContainsKey('negativettl') ) { $payload.Add('negativettl', $negativettl) }
            if ( $PSBoundParameters.ContainsKey('negativettllimitedsuccess') ) { $payload.Add('negativettllimitedsuccess', $negativettllimitedsuccess) }
            if ( $PSBoundParameters.ContainsKey('purgesdbongxfailure') ) { $payload.Add('purgesdbongxfailure', $purgesdbongxfailure) }
            if ( $PSBoundParameters.ContainsKey('servicepathavp') ) { $payload.Add('servicepathavp', $servicepathavp) }
            if ( $PSBoundParameters.ContainsKey('servicepathvendorid') ) { $payload.Add('servicepathvendorid', $servicepathvendorid) }
            if ( $PSCmdlet.ShouldProcess("subscribergxinterface", "Update Subscriber configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type subscribergxinterface -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateSubscribergxinterface: Finished"
    }
}

function Invoke-ADCUnsetSubscribergxinterface {
    <#
    .SYNOPSIS
        Unset Subscriber configuration Object.
    .DESCRIPTION
        Configuration for Gx interface Parameters resource.
    .PARAMETER Vserver 
        Name of the load balancing, or content switching vserver to which the Gx connections are established. The service type of the virtual server must be DIAMETER/SSL_DIAMETER. Mutually exclusive with the service parameter. Therefore, you cannot set both service and the Virtual Server in the Gx Interface. 
    .PARAMETER Service 
        Name of DIAMETER/SSL_DIAMETER service corresponding to PCRF to which the Gx connection is established. The service type of the service must be DIAMETER/SSL_DIAMETER. Mutually exclusive with vserver parameter. Therefore, you cannot set both Service and the Virtual Server in the Gx Interface. 
    .PARAMETER Holdonsubscriberabsence 
        Set this setting to yes if Citrix ADC needs to Hold pakcets till subscriber session is fetched from PCRF. Else set to NO. By default set to yes. If this setting is set to NO, then till Citrix ADC fetches subscriber from PCRF, default subscriber profile will be applied to this subscriber if configured. If default subscriber profile is also not configured an undef would be raised to expressions which use Subscriber attributes. . 
        Possible values = YES, NO 
    .PARAMETER Requesttimeout 
        q!Time, in seconds, within which the Gx CCR request must complete. If the request does not complete within this time, the request is retransmitted for requestRetryAttempts time. If still reuqest is not complete then default subscriber profile will be applied to this subscriber if configured. If default subscriber profile is also not configured an undef would be raised to expressions which use Subscriber attributes. 
        Zero disables the timeout. !. 
    .PARAMETER Requestretryattempts 
        If the request does not complete within requestTimeout time, the request is retransmitted for requestRetryAttempts time. 
    .PARAMETER Idlettl 
        q!Idle Time, in seconds, after which the Gx CCR-U request will be sent after any PCRF activity on a session. Any RAR or CCA message resets the timer. 
        Zero value disables the idle timeout. !. 
    .PARAMETER Revalidationtimeout 
        q!Revalidation Timeout, in seconds, after which the Gx CCR-U request will be sent after any PCRF activity on a session. Any RAR or CCA message resets the timer. 
        Zero value disables the idle timeout. !. 
    .PARAMETER Healthcheck 
        q!Set this setting to yes if Citrix ADC should send DWR packets to PCRF server. When the session is idle, healthcheck timer expires and DWR packets are initiated in order to check that PCRF server is active. By default set to No. !. 
        Possible values = YES, NO 
    .PARAMETER Healthcheckttl 
        q!Healthcheck timeout, in seconds, after which the DWR will be sent in order to ensure the state of the PCRF server. Any CCR, CCA, RAR or RRA message resets the timer. !. 
    .PARAMETER Cerrequesttimeout 
        q!Healthcheck request timeout, in seconds, after which the Citrix ADC considers that no CCA packet received to the initiated CCR. After this time Citrix ADC should send again CCR to PCRF server. !. 
    .PARAMETER Negativettl 
        q!Negative TTL, in seconds, after which the Gx CCR-I request will be resent for sessions that have not been resolved by PCRF due to server being down or no response or failed response. Instead of polling the PCRF server constantly, negative-TTL makes Citrix ADC stick to un-resolved session. Meanwhile Citrix ADC installs a negative session to avoid going to PCRF. 
        For Negative Sessions, Netcaler inherits the attributes from default subscriber profile if default subscriber is configured. A default subscriber could be configured as 'add subscriber profile *'. Or these attributes can be inherited from Radius as well if Radius is configued. 
        Zero value disables the Negative Sessions. And Citrix ADC does not install Negative sessions even if subscriber session could not be fetched. !. 
    .PARAMETER Negativettllimitedsuccess 
        Set this to YES if Citrix ADC should create negative session for Result-Code DIAMETER_LIMITED_SUCCESS (2002) received in CCA-I. If set to NO, regular session is created. 
        Possible values = YES, NO 
    .PARAMETER Purgesdbongxfailure 
        Set this setting to YES if needed to purge Subscriber Database in case of Gx failure. By default set to NO. . 
        Possible values = YES, NO 
    .PARAMETER Servicepathavp 
        The AVP code in which PCRF sends service path applicable for subscriber. 
    .PARAMETER Servicepathvendorid 
        The vendorid of the AVP in which PCRF sends service path for subscriber.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetSubscribergxinterface 
        An example how to unset subscribergxinterface configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetSubscribergxinterface
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscribergxinterface
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

        [Boolean]$vserver,

        [Boolean]$service,

        [Boolean]$holdonsubscriberabsence,

        [Boolean]$requesttimeout,

        [Boolean]$requestretryattempts,

        [Boolean]$idlettl,

        [Boolean]$revalidationtimeout,

        [Boolean]$healthcheck,

        [Boolean]$healthcheckttl,

        [Boolean]$cerrequesttimeout,

        [Boolean]$negativettl,

        [Boolean]$negativettllimitedsuccess,

        [Boolean]$purgesdbongxfailure,

        [Boolean]$servicepathavp,

        [Boolean]$servicepathvendorid 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSubscribergxinterface: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSBoundParameters.ContainsKey('service') ) { $payload.Add('service', $service) }
            if ( $PSBoundParameters.ContainsKey('holdonsubscriberabsence') ) { $payload.Add('holdonsubscriberabsence', $holdonsubscriberabsence) }
            if ( $PSBoundParameters.ContainsKey('requesttimeout') ) { $payload.Add('requesttimeout', $requesttimeout) }
            if ( $PSBoundParameters.ContainsKey('requestretryattempts') ) { $payload.Add('requestretryattempts', $requestretryattempts) }
            if ( $PSBoundParameters.ContainsKey('idlettl') ) { $payload.Add('idlettl', $idlettl) }
            if ( $PSBoundParameters.ContainsKey('revalidationtimeout') ) { $payload.Add('revalidationtimeout', $revalidationtimeout) }
            if ( $PSBoundParameters.ContainsKey('healthcheck') ) { $payload.Add('healthcheck', $healthcheck) }
            if ( $PSBoundParameters.ContainsKey('healthcheckttl') ) { $payload.Add('healthcheckttl', $healthcheckttl) }
            if ( $PSBoundParameters.ContainsKey('cerrequesttimeout') ) { $payload.Add('cerrequesttimeout', $cerrequesttimeout) }
            if ( $PSBoundParameters.ContainsKey('negativettl') ) { $payload.Add('negativettl', $negativettl) }
            if ( $PSBoundParameters.ContainsKey('negativettllimitedsuccess') ) { $payload.Add('negativettllimitedsuccess', $negativettllimitedsuccess) }
            if ( $PSBoundParameters.ContainsKey('purgesdbongxfailure') ) { $payload.Add('purgesdbongxfailure', $purgesdbongxfailure) }
            if ( $PSBoundParameters.ContainsKey('servicepathavp') ) { $payload.Add('servicepathavp', $servicepathavp) }
            if ( $PSBoundParameters.ContainsKey('servicepathvendorid') ) { $payload.Add('servicepathvendorid', $servicepathvendorid) }
            if ( $PSCmdlet.ShouldProcess("subscribergxinterface", "Unset Subscriber configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type subscribergxinterface -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSubscribergxinterface: Finished"
    }
}

function Invoke-ADCGetSubscribergxinterface {
    <#
    .SYNOPSIS
        Get Subscriber configuration object(s).
    .DESCRIPTION
        Configuration for Gx interface Parameters resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retrieve all subscribergxinterface object(s).
    .PARAMETER Count
        If specified, the count of the subscribergxinterface object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSubscribergxinterface
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSubscribergxinterface -GetAll 
        Get all subscribergxinterface data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSubscribergxinterface -name <string>
        Get subscribergxinterface object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSubscribergxinterface -Filter @{ 'name'='<value>' }
        Get subscribergxinterface data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSubscribergxinterface
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscribergxinterface/
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
        Write-Verbose "Invoke-ADCGetSubscribergxinterface: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all subscribergxinterface objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscribergxinterface -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for subscribergxinterface objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscribergxinterface -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving subscribergxinterface objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscribergxinterface -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving subscribergxinterface configuration for property ''"

            } else {
                Write-Verbose "Retrieving subscribergxinterface configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscribergxinterface -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSubscribergxinterface: Ended"
    }
}

function Invoke-ADCUpdateSubscriberparam {
    <#
    .SYNOPSIS
        Update Subscriber configuration Object.
    .DESCRIPTION
        Configuration for Subscriber Params resource.
    .PARAMETER Keytype 
        Type of subscriber key type IP or IPANDVLAN. IPANDVLAN option can be used only when the interfaceType is set to gxOnly. 
        Changing the lookup method should result to the subscriber session database being flushed. 
        Possible values = IP, IPANDVLAN 
    .PARAMETER Interfacetype 
        Subscriber Interface refers to Citrix ADC interaction with control plane protocols, RADIUS and GX. 
        Types of subscriber interface: NONE, RadiusOnly, RadiusAndGx, GxOnly. 
        NONE: Only static subscribers can be configured. 
        RadiusOnly: GX interface is absent. Subscriber information is obtained through RADIUS Accounting messages. 
        RadiusAndGx: Subscriber ID obtained through RADIUS Accounting is used to query PCRF. Subscriber information is obtained from both RADIUS and PCRF. 
        GxOnly: RADIUS interface is absent. Subscriber information is queried using Subscriber IP or IP+VLAN. 
        Possible values = None, RadiusOnly, RadiusAndGx, GxOnly 
    .PARAMETER Idlettl 
        q!Idle Timeout, in seconds, after which Citrix ADC will take an idleAction on a subscriber session (refer to 'idleAction' arguement in 'set subscriber param' for more details on idleAction). Any data-plane or control plane activity updates the idleTimeout on subscriber session. idleAction could be to 'just delete the session' or 'delete and CCR-T' (if PCRF is configured) or 'do not delete but send a CCR-U'. 
        Zero value disables the idle timeout. !. 
    .PARAMETER Idleaction 
        q!Once idleTTL exprires on a subscriber session, Citrix ADC will take an idle action on that session. idleAction could be chosen from one of these ==> 
        1. ccrTerminate: (default) send CCR-T to inform PCRF about session termination and delete the session. 
        2. delete: Just delete the subscriber session without informing PCRF. 
        3. ccrUpdate: Do not delete the session and instead send a CCR-U to PCRF requesting for an updated session. !. 
        Possible values = ccrTerminate, delete, ccrUpdate 
    .PARAMETER Ipv6prefixlookuplist 
        The ipv6PrefixLookupList should consist of all the ipv6 prefix lengths assigned to the UE's'.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateSubscriberparam 
        An example how to update subscriberparam configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateSubscriberparam
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberparam/
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

        [ValidateSet('IP', 'IPANDVLAN')]
        [string]$Keytype,

        [ValidateSet('None', 'RadiusOnly', 'RadiusAndGx', 'GxOnly')]
        [string]$Interfacetype,

        [ValidateRange(0, 172800)]
        [double]$Idlettl,

        [ValidateSet('ccrTerminate', 'delete', 'ccrUpdate')]
        [string]$Idleaction,

        [ValidateRange(1, 128)]
        [double[]]$Ipv6prefixlookuplist 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSubscriberparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('keytype') ) { $payload.Add('keytype', $keytype) }
            if ( $PSBoundParameters.ContainsKey('interfacetype') ) { $payload.Add('interfacetype', $interfacetype) }
            if ( $PSBoundParameters.ContainsKey('idlettl') ) { $payload.Add('idlettl', $idlettl) }
            if ( $PSBoundParameters.ContainsKey('idleaction') ) { $payload.Add('idleaction', $idleaction) }
            if ( $PSBoundParameters.ContainsKey('ipv6prefixlookuplist') ) { $payload.Add('ipv6prefixlookuplist', $ipv6prefixlookuplist) }
            if ( $PSCmdlet.ShouldProcess("subscriberparam", "Update Subscriber configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type subscriberparam -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateSubscriberparam: Finished"
    }
}

function Invoke-ADCUnsetSubscriberparam {
    <#
    .SYNOPSIS
        Unset Subscriber configuration Object.
    .DESCRIPTION
        Configuration for Subscriber Params resource.
    .PARAMETER Keytype 
        Type of subscriber key type IP or IPANDVLAN. IPANDVLAN option can be used only when the interfaceType is set to gxOnly. 
        Changing the lookup method should result to the subscriber session database being flushed. 
        Possible values = IP, IPANDVLAN 
    .PARAMETER Interfacetype 
        Subscriber Interface refers to Citrix ADC interaction with control plane protocols, RADIUS and GX. 
        Types of subscriber interface: NONE, RadiusOnly, RadiusAndGx, GxOnly. 
        NONE: Only static subscribers can be configured. 
        RadiusOnly: GX interface is absent. Subscriber information is obtained through RADIUS Accounting messages. 
        RadiusAndGx: Subscriber ID obtained through RADIUS Accounting is used to query PCRF. Subscriber information is obtained from both RADIUS and PCRF. 
        GxOnly: RADIUS interface is absent. Subscriber information is queried using Subscriber IP or IP+VLAN. 
        Possible values = None, RadiusOnly, RadiusAndGx, GxOnly 
    .PARAMETER Idlettl 
        q!Idle Timeout, in seconds, after which Citrix ADC will take an idleAction on a subscriber session (refer to 'idleAction' arguement in 'set subscriber param' for more details on idleAction). Any data-plane or control plane activity updates the idleTimeout on subscriber session. idleAction could be to 'just delete the session' or 'delete and CCR-T' (if PCRF is configured) or 'do not delete but send a CCR-U'. 
        Zero value disables the idle timeout. !. 
    .PARAMETER Idleaction 
        q!Once idleTTL exprires on a subscriber session, Citrix ADC will take an idle action on that session. idleAction could be chosen from one of these ==> 
        1. ccrTerminate: (default) send CCR-T to inform PCRF about session termination and delete the session. 
        2. delete: Just delete the subscriber session without informing PCRF. 
        3. ccrUpdate: Do not delete the session and instead send a CCR-U to PCRF requesting for an updated session. !. 
        Possible values = ccrTerminate, delete, ccrUpdate
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetSubscriberparam 
        An example how to unset subscriberparam configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetSubscriberparam
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberparam
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

        [Boolean]$keytype,

        [Boolean]$interfacetype,

        [Boolean]$idlettl,

        [Boolean]$idleaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSubscriberparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('keytype') ) { $payload.Add('keytype', $keytype) }
            if ( $PSBoundParameters.ContainsKey('interfacetype') ) { $payload.Add('interfacetype', $interfacetype) }
            if ( $PSBoundParameters.ContainsKey('idlettl') ) { $payload.Add('idlettl', $idlettl) }
            if ( $PSBoundParameters.ContainsKey('idleaction') ) { $payload.Add('idleaction', $idleaction) }
            if ( $PSCmdlet.ShouldProcess("subscriberparam", "Unset Subscriber configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type subscriberparam -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSubscriberparam: Finished"
    }
}

function Invoke-ADCGetSubscriberparam {
    <#
    .SYNOPSIS
        Get Subscriber configuration object(s).
    .DESCRIPTION
        Configuration for Subscriber Params resource.
    .PARAMETER GetAll 
        Retrieve all subscriberparam object(s).
    .PARAMETER Count
        If specified, the count of the subscriberparam object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSubscriberparam
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSubscriberparam -GetAll 
        Get all subscriberparam data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSubscriberparam -name <string>
        Get subscriberparam object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSubscriberparam -Filter @{ 'name'='<value>' }
        Get subscriberparam data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSubscriberparam
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberparam/
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
        Write-Verbose "Invoke-ADCGetSubscriberparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all subscriberparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for subscriberparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving subscriberparam objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberparam -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving subscriberparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving subscriberparam configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSubscriberparam: Ended"
    }
}

function Invoke-ADCAddSubscriberprofile {
    <#
    .SYNOPSIS
        Add Subscriber configuration Object.
    .DESCRIPTION
        Configuration for Subscriber Profile resource.
    .PARAMETER Ip 
        Subscriber ip address. 
    .PARAMETER Vlan 
        The vlan number on which the subscriber is located. 
    .PARAMETER Subscriberrules 
        Rules configured for this subscriber. This is similar to rules received from PCRF for dynamic subscriber sessions. 
    .PARAMETER Subscriptionidtype 
        Subscription-Id type. 
        Possible values = E164, IMSI, SIP_URI, NAI, PRIVATE 
    .PARAMETER Subscriptionidvalue 
        Subscription-Id value. 
    .PARAMETER Servicepath 
        Name of the servicepath to be taken for this subscriber.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSubscriberprofile -ip <string>
        An example how to add subscriberprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSubscriberprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberprofile/
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
        [string]$Ip,

        [ValidateRange(0, 4096)]
        [double]$Vlan = '0',

        [string[]]$Subscriberrules,

        [ValidateSet('E164', 'IMSI', 'SIP_URI', 'NAI', 'PRIVATE')]
        [string]$Subscriptionidtype,

        [string]$Subscriptionidvalue,

        [string]$Servicepath 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSubscriberprofile: Starting"
    }
    process {
        try {
            $payload = @{ ip = $ip }
            if ( $PSBoundParameters.ContainsKey('vlan') ) { $payload.Add('vlan', $vlan) }
            if ( $PSBoundParameters.ContainsKey('subscriberrules') ) { $payload.Add('subscriberrules', $subscriberrules) }
            if ( $PSBoundParameters.ContainsKey('subscriptionidtype') ) { $payload.Add('subscriptionidtype', $subscriptionidtype) }
            if ( $PSBoundParameters.ContainsKey('subscriptionidvalue') ) { $payload.Add('subscriptionidvalue', $subscriptionidvalue) }
            if ( $PSBoundParameters.ContainsKey('servicepath') ) { $payload.Add('servicepath', $servicepath) }
            if ( $PSCmdlet.ShouldProcess("subscriberprofile", "Add Subscriber configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type subscriberprofile -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCAddSubscriberprofile: Finished"
    }
}

function Invoke-ADCUpdateSubscriberprofile {
    <#
    .SYNOPSIS
        Update Subscriber configuration Object.
    .DESCRIPTION
        Configuration for Subscriber Profile resource.
    .PARAMETER Ip 
        Subscriber ip address. 
    .PARAMETER Vlan 
        The vlan number on which the subscriber is located. 
    .PARAMETER Subscriberrules 
        Rules configured for this subscriber. This is similar to rules received from PCRF for dynamic subscriber sessions. 
    .PARAMETER Subscriptionidtype 
        Subscription-Id type. 
        Possible values = E164, IMSI, SIP_URI, NAI, PRIVATE 
    .PARAMETER Subscriptionidvalue 
        Subscription-Id value. 
    .PARAMETER Servicepath 
        Name of the servicepath to be taken for this subscriber.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateSubscriberprofile -ip <string>
        An example how to update subscriberprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateSubscriberprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberprofile/
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
        [string]$Ip,

        [ValidateRange(0, 4096)]
        [double]$Vlan,

        [string[]]$Subscriberrules,

        [ValidateSet('E164', 'IMSI', 'SIP_URI', 'NAI', 'PRIVATE')]
        [string]$Subscriptionidtype,

        [string]$Subscriptionidvalue,

        [string]$Servicepath 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSubscriberprofile: Starting"
    }
    process {
        try {
            $payload = @{ ip = $ip }
            if ( $PSBoundParameters.ContainsKey('vlan') ) { $payload.Add('vlan', $vlan) }
            if ( $PSBoundParameters.ContainsKey('subscriberrules') ) { $payload.Add('subscriberrules', $subscriberrules) }
            if ( $PSBoundParameters.ContainsKey('subscriptionidtype') ) { $payload.Add('subscriptionidtype', $subscriptionidtype) }
            if ( $PSBoundParameters.ContainsKey('subscriptionidvalue') ) { $payload.Add('subscriptionidvalue', $subscriptionidvalue) }
            if ( $PSBoundParameters.ContainsKey('servicepath') ) { $payload.Add('servicepath', $servicepath) }
            if ( $PSCmdlet.ShouldProcess("subscriberprofile", "Update Subscriber configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type subscriberprofile -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateSubscriberprofile: Finished"
    }
}

function Invoke-ADCUnsetSubscriberprofile {
    <#
    .SYNOPSIS
        Unset Subscriber configuration Object.
    .DESCRIPTION
        Configuration for Subscriber Profile resource.
    .PARAMETER Ip 
        Subscriber ip address. 
    .PARAMETER Servicepath 
        Name of the servicepath to be taken for this subscriber.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetSubscriberprofile -ip <string>
        An example how to unset subscriberprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetSubscriberprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberprofile
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

        [string]$Ip,

        [Boolean]$servicepath 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSubscriberprofile: Starting"
    }
    process {
        try {
            $payload = @{ ip = $ip }
            if ( $PSBoundParameters.ContainsKey('servicepath') ) { $payload.Add('servicepath', $servicepath) }
            if ( $PSCmdlet.ShouldProcess("$ip", "Unset Subscriber configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type subscriberprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSubscriberprofile: Finished"
    }
}

function Invoke-ADCDeleteSubscriberprofile {
    <#
    .SYNOPSIS
        Delete Subscriber configuration Object.
    .DESCRIPTION
        Configuration for Subscriber Profile resource.
    .PARAMETER Ip 
        Subscriber ip address. 
    .PARAMETER Vlan 
        The vlan number on which the subscriber is located.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSubscriberprofile -Ip <string>
        An example how to delete subscriberprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSubscriberprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberprofile/
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
        [string]$Ip,

        [double]$Vlan 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSubscriberprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Vlan') ) { $arguments.Add('vlan', $Vlan) }
            if ( $PSCmdlet.ShouldProcess("$ip", "Delete Subscriber configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type subscriberprofile -NitroPath nitro/v1/config -Resource $ip -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteSubscriberprofile: Finished"
    }
}

function Invoke-ADCGetSubscriberprofile {
    <#
    .SYNOPSIS
        Get Subscriber configuration object(s).
    .DESCRIPTION
        Configuration for Subscriber Profile resource.
    .PARAMETER GetAll 
        Retrieve all subscriberprofile object(s).
    .PARAMETER Count
        If specified, the count of the subscriberprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSubscriberprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSubscriberprofile -GetAll 
        Get all subscriberprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSubscriberprofile -Count 
        Get the number of subscriberprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSubscriberprofile -name <string>
        Get subscriberprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSubscriberprofile -Filter @{ 'name'='<value>' }
        Get subscriberprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSubscriberprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberprofile/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetSubscriberprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all subscriberprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for subscriberprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving subscriberprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving subscriberprofile configuration for property ''"

            } else {
                Write-Verbose "Retrieving subscriberprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSubscriberprofile: Ended"
    }
}

function Invoke-ADCUpdateSubscriberradiusinterface {
    <#
    .SYNOPSIS
        Update Subscriber configuration Object.
    .DESCRIPTION
        Configuration for RADIUS interface Parameters resource.
    .PARAMETER Listeningservice 
        Name of RADIUS LISTENING service that will process RADIUS accounting requests. 
    .PARAMETER Radiusinterimasstart 
        Treat radius interim message as start radius messages. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateSubscriberradiusinterface 
        An example how to update subscriberradiusinterface configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateSubscriberradiusinterface
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberradiusinterface/
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
        [string]$Listeningservice,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Radiusinterimasstart 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSubscriberradiusinterface: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('listeningservice') ) { $payload.Add('listeningservice', $listeningservice) }
            if ( $PSBoundParameters.ContainsKey('radiusinterimasstart') ) { $payload.Add('radiusinterimasstart', $radiusinterimasstart) }
            if ( $PSCmdlet.ShouldProcess("subscriberradiusinterface", "Update Subscriber configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type subscriberradiusinterface -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateSubscriberradiusinterface: Finished"
    }
}

function Invoke-ADCUnsetSubscriberradiusinterface {
    <#
    .SYNOPSIS
        Unset Subscriber configuration Object.
    .DESCRIPTION
        Configuration for RADIUS interface Parameters resource.
    .PARAMETER Radiusinterimasstart 
        Treat radius interim message as start radius messages. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetSubscriberradiusinterface 
        An example how to unset subscriberradiusinterface configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetSubscriberradiusinterface
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberradiusinterface
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

        [Boolean]$radiusinterimasstart 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSubscriberradiusinterface: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('radiusinterimasstart') ) { $payload.Add('radiusinterimasstart', $radiusinterimasstart) }
            if ( $PSCmdlet.ShouldProcess("subscriberradiusinterface", "Unset Subscriber configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type subscriberradiusinterface -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSubscriberradiusinterface: Finished"
    }
}

function Invoke-ADCGetSubscriberradiusinterface {
    <#
    .SYNOPSIS
        Get Subscriber configuration object(s).
    .DESCRIPTION
        Configuration for RADIUS interface Parameters resource.
    .PARAMETER GetAll 
        Retrieve all subscriberradiusinterface object(s).
    .PARAMETER Count
        If specified, the count of the subscriberradiusinterface object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSubscriberradiusinterface
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSubscriberradiusinterface -GetAll 
        Get all subscriberradiusinterface data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSubscriberradiusinterface -name <string>
        Get subscriberradiusinterface object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSubscriberradiusinterface -Filter @{ 'name'='<value>' }
        Get subscriberradiusinterface data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSubscriberradiusinterface
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberradiusinterface/
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
        Write-Verbose "Invoke-ADCGetSubscriberradiusinterface: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all subscriberradiusinterface objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberradiusinterface -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for subscriberradiusinterface objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberradiusinterface -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving subscriberradiusinterface objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberradiusinterface -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving subscriberradiusinterface configuration for property ''"

            } else {
                Write-Verbose "Retrieving subscriberradiusinterface configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberradiusinterface -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSubscriberradiusinterface: Ended"
    }
}

function Invoke-ADCClearSubscribersessions {
    <#
    .SYNOPSIS
        Clear Subscriber configuration Object.
    .DESCRIPTION
        Configuration for subscriber sesions resource.
    .PARAMETER Ip 
        Subscriber IP Address. 
    .PARAMETER Vlan 
        The vlan number on which the subscriber is located.
    .EXAMPLE
        PS C:\>Invoke-ADCClearSubscribersessions 
        An example how to clear subscribersessions configuration Object(s).
    .NOTES
        File Name : Invoke-ADCClearSubscribersessions
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscribersessions/
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

        [string]$Ip,

        [ValidateRange(0, 4096)]
        [double]$Vlan 

    )
    begin {
        Write-Verbose "Invoke-ADCClearSubscribersessions: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('ip') ) { $payload.Add('ip', $ip) }
            if ( $PSBoundParameters.ContainsKey('vlan') ) { $payload.Add('vlan', $vlan) }
            if ( $PSCmdlet.ShouldProcess($Name, "Clear Subscriber configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type subscribersessions -Action clear -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCClearSubscribersessions: Finished"
    }
}

function Invoke-ADCGetSubscribersessions {
    <#
    .SYNOPSIS
        Get Subscriber configuration object(s).
    .DESCRIPTION
        Configuration for subscriber sesions resource.
    .PARAMETER Ip 
        Subscriber IP Address. 
    .PARAMETER Vlan 
        The vlan number on which the subscriber is located. 
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retrieve all subscribersessions object(s).
    .PARAMETER Count
        If specified, the count of the subscribersessions object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSubscribersessions
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSubscribersessions -GetAll 
        Get all subscribersessions data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSubscribersessions -Count 
        Get the number of subscribersessions objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSubscribersessions -name <string>
        Get subscribersessions object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSubscribersessions -Filter @{ 'name'='<value>' }
        Get subscribersessions data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSubscribersessions
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscribersessions/
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
        [string]$Ip,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 4096)]
        [double]$Vlan,

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
        Write-Verbose "Invoke-ADCGetSubscribersessions: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all subscribersessions objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscribersessions -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for subscribersessions objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscribersessions -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving subscribersessions objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('ip') ) { $arguments.Add('ip', $ip) } 
                if ( $PSBoundParameters.ContainsKey('vlan') ) { $arguments.Add('vlan', $vlan) } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscribersessions -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving subscribersessions configuration for property ''"

            } else {
                Write-Verbose "Retrieving subscribersessions configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscribersessions -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSubscribersessions: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCA4gu6oidtiacA9
# 08PLgqrjxVkn7ZWV7E3O0YaPYIljVqCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# LqPzW0sH3DJZ84enGm1YMYICQzCCAj8CAQEwgZAwfDELMAkGA1UEBhMCR0IxGzAZ
# BgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
# A1UEChMPU2VjdGlnbyBMaW1pdGVkMSQwIgYDVQQDExtTZWN0aWdvIFJTQSBDb2Rl
# IFNpZ25pbmcgQ0ECECwnTfNkELSL/bju5S9Y3lMwDQYJYIZIAWUDBAIBBQCggYQw
# GAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGC
# NwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQx
# IgQgDVi6vXphKntWZl4bQ5aoxjstCsxmmvPE+OaZ9anV4JgwDQYJKoZIhvcNAQEB
# BQAEggEAdX2pr6PGh0XeJK4O/Hk4dI8O1bQRaaySRm8/16febZJtrnI0PqtEhEHJ
# pDfgicWy0iShn9mYtmMvaZpLgfDhguE0bQ9LfEtVlrXoQELepDeD7xcTSuW/+pVy
# XFmusnIv0d18nzCAv6nyvPdyfMs7lbLGL93yfDtCxmQPNPOIQczWFetRssa0m/73
# MMFpF7jZrAaXruC7mhsjEb1GGgbFiIzTx/fF2CBIkfDqQBerPrr39v85OR4A2WZQ
# ISPJ5JAxWL5yBv/e6CgDhFP6l/NkYaYbEHxeT6EFOcdCSPUx6ju7NCnDkkB1UklM
# 538/+AGtzup9DS0s9hXJtkZXdeC5PA==
# SIG # End signature block
