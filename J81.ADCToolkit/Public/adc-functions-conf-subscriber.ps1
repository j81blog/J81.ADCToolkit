function Invoke-ADCUpdateSubscribergxinterface {
<#
    .SYNOPSIS
        Update Subscriber configuration Object
    .DESCRIPTION
        Update Subscriber configuration Object 
    .PARAMETER vserver 
        Name of the load balancing, or content switching vserver to which the Gx connections are established. The service type of the virtual server must be DIAMETER/SSL_DIAMETER. Mutually exclusive with the service parameter. Therefore, you cannot set both service and the Virtual Server in the Gx Interface.  
        Minimum length = 1 
    .PARAMETER service 
        Name of DIAMETER/SSL_DIAMETER service corresponding to PCRF to which the Gx connection is established. The service type of the service must be DIAMETER/SSL_DIAMETER. Mutually exclusive with vserver parameter. Therefore, you cannot set both Service and the Virtual Server in the Gx Interface.  
        Minimum length = 1 
    .PARAMETER pcrfrealm 
        PCRF realm is of type DiameterIdentity and contains the realm of PCRF to which the message is to be routed. This is the realm used in Destination-Realm AVP by Citrix ADC Gx client (as a Diameter node).  
        Minimum length = 1 
    .PARAMETER holdonsubscriberabsence 
        Set this setting to yes if Citrix ADC needs to Hold pakcets till subscriber session is fetched from PCRF. Else set to NO. By default set to yes. If this setting is set to NO, then till Citrix ADC fetches subscriber from PCRF, default subscriber profile will be applied to this subscriber if configured. If default subscriber profile is also not configured an undef would be raised to expressions which use Subscriber attributes. .  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER requesttimeout 
        q!Time, in seconds, within which the Gx CCR request must complete. If the request does not complete within this time, the request is retransmitted for requestRetryAttempts time. If still reuqest is not complete then default subscriber profile will be applied to this subscriber if configured. If default subscriber profile is also not configured an undef would be raised to expressions which use Subscriber attributes.  
        Zero disables the timeout. !.  
        Default value: 10  
        Minimum value = 0  
        Maximum value = 86400 
    .PARAMETER requestretryattempts 
        If the request does not complete within requestTimeout time, the request is retransmitted for requestRetryAttempts time.  
        Default value: 3 
    .PARAMETER idlettl 
        q!Idle Time, in seconds, after which the Gx CCR-U request will be sent after any PCRF activity on a session. Any RAR or CCA message resets the timer.  
        Zero value disables the idle timeout. !.  
        Default value: 900  
        Minimum value = 0  
        Maximum value = 86400 
    .PARAMETER revalidationtimeout 
        q!Revalidation Timeout, in seconds, after which the Gx CCR-U request will be sent after any PCRF activity on a session. Any RAR or CCA message resets the timer.  
        Zero value disables the idle timeout. !.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 86400 
    .PARAMETER healthcheck 
        q!Set this setting to yes if Citrix ADC should send DWR packets to PCRF server. When the session is idle, healthcheck timer expires and DWR packets are initiated in order to check that PCRF server is active. By default set to No. !.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER healthcheckttl 
        q!Healthcheck timeout, in seconds, after which the DWR will be sent in order to ensure the state of the PCRF server. Any CCR, CCA, RAR or RRA message resets the timer. !.  
        Default value: 30  
        Minimum value = 6  
        Maximum value = 86400 
    .PARAMETER cerrequesttimeout 
        q!Healthcheck request timeout, in seconds, after which the Citrix ADC considers that no CCA packet received to the initiated CCR. After this time Citrix ADC should send again CCR to PCRF server. !.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 86400 
    .PARAMETER negativettl 
        q!Negative TTL, in seconds, after which the Gx CCR-I request will be resent for sessions that have not been resolved by PCRF due to server being down or no response or failed response. Instead of polling the PCRF server constantly, negative-TTL makes Citrix ADC stick to un-resolved session. Meanwhile Citrix ADC installs a negative session to avoid going to PCRF.  
        For Negative Sessions, Netcaler inherits the attributes from default subscriber profile if default subscriber is configured. A default subscriber could be configured as 'add subscriber profile *'. Or these attributes can be inherited from Radius as well if Radius is configued.  
        Zero value disables the Negative Sessions. And Citrix ADC does not install Negative sessions even if subscriber session could not be fetched. !.  
        Default value: 600  
        Minimum value = 0  
        Maximum value = 86400 
    .PARAMETER negativettllimitedsuccess 
        Set this to YES if Citrix ADC should create negative session for Result-Code DIAMETER_LIMITED_SUCCESS (2002) received in CCA-I. If set to NO, regular session is created.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER purgesdbongxfailure 
        Set this setting to YES if needed to purge Subscriber Database in case of Gx failure. By default set to NO. .  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER servicepathavp 
        The AVP code in which PCRF sends service path applicable for subscriber.  
        Minimum value = 1 
    .PARAMETER servicepathvendorid 
        The vendorid of the AVP in which PCRF sends service path for subscriber.
    .EXAMPLE
        Invoke-ADCUpdateSubscribergxinterface 
    .NOTES
        File Name : Invoke-ADCUpdateSubscribergxinterface
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscribergxinterface/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$vserver ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$service ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$pcrfrealm ,

        [ValidateSet('YES', 'NO')]
        [string]$holdonsubscriberabsence ,

        [ValidateRange(0, 86400)]
        [double]$requesttimeout ,

        [double]$requestretryattempts ,

        [ValidateRange(0, 86400)]
        [double]$idlettl ,

        [ValidateRange(0, 86400)]
        [double]$revalidationtimeout ,

        [ValidateSet('YES', 'NO')]
        [string]$healthcheck ,

        [ValidateRange(6, 86400)]
        [double]$healthcheckttl ,

        [ValidateRange(0, 86400)]
        [double]$cerrequesttimeout ,

        [ValidateRange(0, 86400)]
        [double]$negativettl ,

        [ValidateSet('YES', 'NO')]
        [string]$negativettllimitedsuccess ,

        [ValidateSet('YES', 'NO')]
        [string]$purgesdbongxfailure ,

        [double[]]$servicepathavp ,

        [double]$servicepathvendorid 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSubscribergxinterface: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Payload.Add('vserver', $vserver) }
            if ($PSBoundParameters.ContainsKey('service')) { $Payload.Add('service', $service) }
            if ($PSBoundParameters.ContainsKey('pcrfrealm')) { $Payload.Add('pcrfrealm', $pcrfrealm) }
            if ($PSBoundParameters.ContainsKey('holdonsubscriberabsence')) { $Payload.Add('holdonsubscriberabsence', $holdonsubscriberabsence) }
            if ($PSBoundParameters.ContainsKey('requesttimeout')) { $Payload.Add('requesttimeout', $requesttimeout) }
            if ($PSBoundParameters.ContainsKey('requestretryattempts')) { $Payload.Add('requestretryattempts', $requestretryattempts) }
            if ($PSBoundParameters.ContainsKey('idlettl')) { $Payload.Add('idlettl', $idlettl) }
            if ($PSBoundParameters.ContainsKey('revalidationtimeout')) { $Payload.Add('revalidationtimeout', $revalidationtimeout) }
            if ($PSBoundParameters.ContainsKey('healthcheck')) { $Payload.Add('healthcheck', $healthcheck) }
            if ($PSBoundParameters.ContainsKey('healthcheckttl')) { $Payload.Add('healthcheckttl', $healthcheckttl) }
            if ($PSBoundParameters.ContainsKey('cerrequesttimeout')) { $Payload.Add('cerrequesttimeout', $cerrequesttimeout) }
            if ($PSBoundParameters.ContainsKey('negativettl')) { $Payload.Add('negativettl', $negativettl) }
            if ($PSBoundParameters.ContainsKey('negativettllimitedsuccess')) { $Payload.Add('negativettllimitedsuccess', $negativettllimitedsuccess) }
            if ($PSBoundParameters.ContainsKey('purgesdbongxfailure')) { $Payload.Add('purgesdbongxfailure', $purgesdbongxfailure) }
            if ($PSBoundParameters.ContainsKey('servicepathavp')) { $Payload.Add('servicepathavp', $servicepathavp) }
            if ($PSBoundParameters.ContainsKey('servicepathvendorid')) { $Payload.Add('servicepathvendorid', $servicepathvendorid) }
 
            if ($PSCmdlet.ShouldProcess("subscribergxinterface", "Update Subscriber configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type subscribergxinterface -Payload $Payload -GetWarning
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
        Unset Subscriber configuration Object
    .DESCRIPTION
        Unset Subscriber configuration Object 
   .PARAMETER vserver 
       Name of the load balancing, or content switching vserver to which the Gx connections are established. The service type of the virtual server must be DIAMETER/SSL_DIAMETER. Mutually exclusive with the service parameter. Therefore, you cannot set both service and the Virtual Server in the Gx Interface. 
   .PARAMETER service 
       Name of DIAMETER/SSL_DIAMETER service corresponding to PCRF to which the Gx connection is established. The service type of the service must be DIAMETER/SSL_DIAMETER. Mutually exclusive with vserver parameter. Therefore, you cannot set both Service and the Virtual Server in the Gx Interface. 
   .PARAMETER holdonsubscriberabsence 
       Set this setting to yes if Citrix ADC needs to Hold pakcets till subscriber session is fetched from PCRF. Else set to NO. By default set to yes. If this setting is set to NO, then till Citrix ADC fetches subscriber from PCRF, default subscriber profile will be applied to this subscriber if configured. If default subscriber profile is also not configured an undef would be raised to expressions which use Subscriber attributes. .  
       Possible values = YES, NO 
   .PARAMETER requesttimeout 
       q!Time, in seconds, within which the Gx CCR request must complete. If the request does not complete within this time, the request is retransmitted for requestRetryAttempts time. If still reuqest is not complete then default subscriber profile will be applied to this subscriber if configured. If default subscriber profile is also not configured an undef would be raised to expressions which use Subscriber attributes.  
       Zero disables the timeout. !. 
   .PARAMETER requestretryattempts 
       If the request does not complete within requestTimeout time, the request is retransmitted for requestRetryAttempts time. 
   .PARAMETER idlettl 
       q!Idle Time, in seconds, after which the Gx CCR-U request will be sent after any PCRF activity on a session. Any RAR or CCA message resets the timer.  
       Zero value disables the idle timeout. !. 
   .PARAMETER revalidationtimeout 
       q!Revalidation Timeout, in seconds, after which the Gx CCR-U request will be sent after any PCRF activity on a session. Any RAR or CCA message resets the timer.  
       Zero value disables the idle timeout. !. 
   .PARAMETER healthcheck 
       q!Set this setting to yes if Citrix ADC should send DWR packets to PCRF server. When the session is idle, healthcheck timer expires and DWR packets are initiated in order to check that PCRF server is active. By default set to No. !.  
       Possible values = YES, NO 
   .PARAMETER healthcheckttl 
       q!Healthcheck timeout, in seconds, after which the DWR will be sent in order to ensure the state of the PCRF server. Any CCR, CCA, RAR or RRA message resets the timer. !. 
   .PARAMETER cerrequesttimeout 
       q!Healthcheck request timeout, in seconds, after which the Citrix ADC considers that no CCA packet received to the initiated CCR. After this time Citrix ADC should send again CCR to PCRF server. !. 
   .PARAMETER negativettl 
       q!Negative TTL, in seconds, after which the Gx CCR-I request will be resent for sessions that have not been resolved by PCRF due to server being down or no response or failed response. Instead of polling the PCRF server constantly, negative-TTL makes Citrix ADC stick to un-resolved session. Meanwhile Citrix ADC installs a negative session to avoid going to PCRF.  
       For Negative Sessions, Netcaler inherits the attributes from default subscriber profile if default subscriber is configured. A default subscriber could be configured as 'add subscriber profile *'. Or these attributes can be inherited from Radius as well if Radius is configued.  
       Zero value disables the Negative Sessions. And Citrix ADC does not install Negative sessions even if subscriber session could not be fetched. !. 
   .PARAMETER negativettllimitedsuccess 
       Set this to YES if Citrix ADC should create negative session for Result-Code DIAMETER_LIMITED_SUCCESS (2002) received in CCA-I. If set to NO, regular session is created.  
       Possible values = YES, NO 
   .PARAMETER purgesdbongxfailure 
       Set this setting to YES if needed to purge Subscriber Database in case of Gx failure. By default set to NO. .  
       Possible values = YES, NO 
   .PARAMETER servicepathavp 
       The AVP code in which PCRF sends service path applicable for subscriber. 
   .PARAMETER servicepathvendorid 
       The vendorid of the AVP in which PCRF sends service path for subscriber.
    .EXAMPLE
        Invoke-ADCUnsetSubscribergxinterface 
    .NOTES
        File Name : Invoke-ADCUnsetSubscribergxinterface
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscribergxinterface
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

        [Boolean]$vserver ,

        [Boolean]$service ,

        [Boolean]$holdonsubscriberabsence ,

        [Boolean]$requesttimeout ,

        [Boolean]$requestretryattempts ,

        [Boolean]$idlettl ,

        [Boolean]$revalidationtimeout ,

        [Boolean]$healthcheck ,

        [Boolean]$healthcheckttl ,

        [Boolean]$cerrequesttimeout ,

        [Boolean]$negativettl ,

        [Boolean]$negativettllimitedsuccess ,

        [Boolean]$purgesdbongxfailure ,

        [Boolean]$servicepathavp ,

        [Boolean]$servicepathvendorid 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSubscribergxinterface: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Payload.Add('vserver', $vserver) }
            if ($PSBoundParameters.ContainsKey('service')) { $Payload.Add('service', $service) }
            if ($PSBoundParameters.ContainsKey('holdonsubscriberabsence')) { $Payload.Add('holdonsubscriberabsence', $holdonsubscriberabsence) }
            if ($PSBoundParameters.ContainsKey('requesttimeout')) { $Payload.Add('requesttimeout', $requesttimeout) }
            if ($PSBoundParameters.ContainsKey('requestretryattempts')) { $Payload.Add('requestretryattempts', $requestretryattempts) }
            if ($PSBoundParameters.ContainsKey('idlettl')) { $Payload.Add('idlettl', $idlettl) }
            if ($PSBoundParameters.ContainsKey('revalidationtimeout')) { $Payload.Add('revalidationtimeout', $revalidationtimeout) }
            if ($PSBoundParameters.ContainsKey('healthcheck')) { $Payload.Add('healthcheck', $healthcheck) }
            if ($PSBoundParameters.ContainsKey('healthcheckttl')) { $Payload.Add('healthcheckttl', $healthcheckttl) }
            if ($PSBoundParameters.ContainsKey('cerrequesttimeout')) { $Payload.Add('cerrequesttimeout', $cerrequesttimeout) }
            if ($PSBoundParameters.ContainsKey('negativettl')) { $Payload.Add('negativettl', $negativettl) }
            if ($PSBoundParameters.ContainsKey('negativettllimitedsuccess')) { $Payload.Add('negativettllimitedsuccess', $negativettllimitedsuccess) }
            if ($PSBoundParameters.ContainsKey('purgesdbongxfailure')) { $Payload.Add('purgesdbongxfailure', $purgesdbongxfailure) }
            if ($PSBoundParameters.ContainsKey('servicepathavp')) { $Payload.Add('servicepathavp', $servicepathavp) }
            if ($PSBoundParameters.ContainsKey('servicepathvendorid')) { $Payload.Add('servicepathvendorid', $servicepathvendorid) }
            if ($PSCmdlet.ShouldProcess("subscribergxinterface", "Unset Subscriber configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type subscribergxinterface -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Subscriber configuration object(s)
    .DESCRIPTION
        Get Subscriber configuration object(s)
    .PARAMETER nodeid 
       Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retreive all subscribergxinterface object(s)
    .PARAMETER Count
        If specified, the count of the subscribergxinterface object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSubscribergxinterface
    .EXAMPLE 
        Invoke-ADCGetSubscribergxinterface -GetAll
    .EXAMPLE
        Invoke-ADCGetSubscribergxinterface -name <string>
    .EXAMPLE
        Invoke-ADCGetSubscribergxinterface -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSubscribergxinterface
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscribergxinterface/
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
        Write-Verbose "Invoke-ADCGetSubscribergxinterface: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all subscribergxinterface objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscribergxinterface -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for subscribergxinterface objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscribergxinterface -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving subscribergxinterface objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('nodeid')) { $Arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscribergxinterface -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving subscribergxinterface configuration for property ''"

            } else {
                Write-Verbose "Retrieving subscribergxinterface configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscribergxinterface -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Update Subscriber configuration Object
    .DESCRIPTION
        Update Subscriber configuration Object 
    .PARAMETER keytype 
        Type of subscriber key type IP or IPANDVLAN. IPANDVLAN option can be used only when the interfaceType is set to gxOnly.  
        Changing the lookup method should result to the subscriber session database being flushed.  
        Default value: IP  
        Possible values = IP, IPANDVLAN 
    .PARAMETER interfacetype 
        Subscriber Interface refers to Citrix ADC interaction with control plane protocols, RADIUS and GX.  
        Types of subscriber interface: NONE, RadiusOnly, RadiusAndGx, GxOnly.  
        NONE: Only static subscribers can be configured.  
        RadiusOnly: GX interface is absent. Subscriber information is obtained through RADIUS Accounting messages.  
        RadiusAndGx: Subscriber ID obtained through RADIUS Accounting is used to query PCRF. Subscriber information is obtained from both RADIUS and PCRF.  
        GxOnly: RADIUS interface is absent. Subscriber information is queried using Subscriber IP or IP+VLAN.  
        Default value: None  
        Possible values = None, RadiusOnly, RadiusAndGx, GxOnly 
    .PARAMETER idlettl 
        q!Idle Timeout, in seconds, after which Citrix ADC will take an idleAction on a subscriber session (refer to 'idleAction' arguement in 'set subscriber param' for more details on idleAction). Any data-plane or control plane activity updates the idleTimeout on subscriber session. idleAction could be to 'just delete the session' or 'delete and CCR-T' (if PCRF is configured) or 'do not delete but send a CCR-U'.  
        Zero value disables the idle timeout. !.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 172800 
    .PARAMETER idleaction 
        q!Once idleTTL exprires on a subscriber session, Citrix ADC will take an idle action on that session. idleAction could be chosen from one of these ==>  
        1. ccrTerminate: (default) send CCR-T to inform PCRF about session termination and delete the session.  
        2. delete: Just delete the subscriber session without informing PCRF.  
        3. ccrUpdate: Do not delete the session and instead send a CCR-U to PCRF requesting for an updated session. !.  
        Default value: ccrTerminate  
        Possible values = ccrTerminate, delete, ccrUpdate 
    .PARAMETER ipv6prefixlookuplist 
        The ipv6PrefixLookupList should consist of all the ipv6 prefix lengths assigned to the UE's'.  
        Minimum value = 1  
        Maximum value = 128
    .EXAMPLE
        Invoke-ADCUpdateSubscriberparam 
    .NOTES
        File Name : Invoke-ADCUpdateSubscriberparam
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberparam/
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

        [ValidateSet('IP', 'IPANDVLAN')]
        [string]$keytype ,

        [ValidateSet('None', 'RadiusOnly', 'RadiusAndGx', 'GxOnly')]
        [string]$interfacetype ,

        [ValidateRange(0, 172800)]
        [double]$idlettl ,

        [ValidateSet('ccrTerminate', 'delete', 'ccrUpdate')]
        [string]$idleaction ,

        [ValidateRange(1, 128)]
        [double[]]$ipv6prefixlookuplist 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSubscriberparam: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('keytype')) { $Payload.Add('keytype', $keytype) }
            if ($PSBoundParameters.ContainsKey('interfacetype')) { $Payload.Add('interfacetype', $interfacetype) }
            if ($PSBoundParameters.ContainsKey('idlettl')) { $Payload.Add('idlettl', $idlettl) }
            if ($PSBoundParameters.ContainsKey('idleaction')) { $Payload.Add('idleaction', $idleaction) }
            if ($PSBoundParameters.ContainsKey('ipv6prefixlookuplist')) { $Payload.Add('ipv6prefixlookuplist', $ipv6prefixlookuplist) }
 
            if ($PSCmdlet.ShouldProcess("subscriberparam", "Update Subscriber configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type subscriberparam -Payload $Payload -GetWarning
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
        Unset Subscriber configuration Object
    .DESCRIPTION
        Unset Subscriber configuration Object 
   .PARAMETER keytype 
       Type of subscriber key type IP or IPANDVLAN. IPANDVLAN option can be used only when the interfaceType is set to gxOnly.  
       Changing the lookup method should result to the subscriber session database being flushed.  
       Possible values = IP, IPANDVLAN 
   .PARAMETER interfacetype 
       Subscriber Interface refers to Citrix ADC interaction with control plane protocols, RADIUS and GX.  
       Types of subscriber interface: NONE, RadiusOnly, RadiusAndGx, GxOnly.  
       NONE: Only static subscribers can be configured.  
       RadiusOnly: GX interface is absent. Subscriber information is obtained through RADIUS Accounting messages.  
       RadiusAndGx: Subscriber ID obtained through RADIUS Accounting is used to query PCRF. Subscriber information is obtained from both RADIUS and PCRF.  
       GxOnly: RADIUS interface is absent. Subscriber information is queried using Subscriber IP or IP+VLAN.  
       Possible values = None, RadiusOnly, RadiusAndGx, GxOnly 
   .PARAMETER idlettl 
       q!Idle Timeout, in seconds, after which Citrix ADC will take an idleAction on a subscriber session (refer to 'idleAction' arguement in 'set subscriber param' for more details on idleAction). Any data-plane or control plane activity updates the idleTimeout on subscriber session. idleAction could be to 'just delete the session' or 'delete and CCR-T' (if PCRF is configured) or 'do not delete but send a CCR-U'.  
       Zero value disables the idle timeout. !. 
   .PARAMETER idleaction 
       q!Once idleTTL exprires on a subscriber session, Citrix ADC will take an idle action on that session. idleAction could be chosen from one of these ==>  
       1. ccrTerminate: (default) send CCR-T to inform PCRF about session termination and delete the session.  
       2. delete: Just delete the subscriber session without informing PCRF.  
       3. ccrUpdate: Do not delete the session and instead send a CCR-U to PCRF requesting for an updated session. !.  
       Possible values = ccrTerminate, delete, ccrUpdate
    .EXAMPLE
        Invoke-ADCUnsetSubscriberparam 
    .NOTES
        File Name : Invoke-ADCUnsetSubscriberparam
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberparam
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

        [Boolean]$keytype ,

        [Boolean]$interfacetype ,

        [Boolean]$idlettl ,

        [Boolean]$idleaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSubscriberparam: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('keytype')) { $Payload.Add('keytype', $keytype) }
            if ($PSBoundParameters.ContainsKey('interfacetype')) { $Payload.Add('interfacetype', $interfacetype) }
            if ($PSBoundParameters.ContainsKey('idlettl')) { $Payload.Add('idlettl', $idlettl) }
            if ($PSBoundParameters.ContainsKey('idleaction')) { $Payload.Add('idleaction', $idleaction) }
            if ($PSCmdlet.ShouldProcess("subscriberparam", "Unset Subscriber configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type subscriberparam -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Subscriber configuration object(s)
    .DESCRIPTION
        Get Subscriber configuration object(s)
    .PARAMETER GetAll 
        Retreive all subscriberparam object(s)
    .PARAMETER Count
        If specified, the count of the subscriberparam object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSubscriberparam
    .EXAMPLE 
        Invoke-ADCGetSubscriberparam -GetAll
    .EXAMPLE
        Invoke-ADCGetSubscriberparam -name <string>
    .EXAMPLE
        Invoke-ADCGetSubscriberparam -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSubscriberparam
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberparam/
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
        Write-Verbose "Invoke-ADCGetSubscriberparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all subscriberparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberparam -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for subscriberparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberparam -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving subscriberparam objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberparam -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving subscriberparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving subscriberparam configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Subscriber configuration Object
    .DESCRIPTION
        Add Subscriber configuration Object 
    .PARAMETER ip 
        Subscriber ip address. 
    .PARAMETER vlan 
        The vlan number on which the subscriber is located.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 4096 
    .PARAMETER subscriberrules 
        Rules configured for this subscriber. This is similar to rules received from PCRF for dynamic subscriber sessions. 
    .PARAMETER subscriptionidtype 
        Subscription-Id type.  
        Possible values = E164, IMSI, SIP_URI, NAI, PRIVATE 
    .PARAMETER subscriptionidvalue 
        Subscription-Id value. 
    .PARAMETER servicepath 
        Name of the servicepath to be taken for this subscriber.
    .EXAMPLE
        Invoke-ADCAddSubscriberprofile -ip <string>
    .NOTES
        File Name : Invoke-ADCAddSubscriberprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberprofile/
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
        [string]$ip ,

        [ValidateRange(0, 4096)]
        [double]$vlan = '0' ,

        [string[]]$subscriberrules ,

        [ValidateSet('E164', 'IMSI', 'SIP_URI', 'NAI', 'PRIVATE')]
        [string]$subscriptionidtype ,

        [string]$subscriptionidvalue ,

        [string]$servicepath 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSubscriberprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                ip = $ip
            }
            if ($PSBoundParameters.ContainsKey('vlan')) { $Payload.Add('vlan', $vlan) }
            if ($PSBoundParameters.ContainsKey('subscriberrules')) { $Payload.Add('subscriberrules', $subscriberrules) }
            if ($PSBoundParameters.ContainsKey('subscriptionidtype')) { $Payload.Add('subscriptionidtype', $subscriptionidtype) }
            if ($PSBoundParameters.ContainsKey('subscriptionidvalue')) { $Payload.Add('subscriptionidvalue', $subscriptionidvalue) }
            if ($PSBoundParameters.ContainsKey('servicepath')) { $Payload.Add('servicepath', $servicepath) }
 
            if ($PSCmdlet.ShouldProcess("subscriberprofile", "Add Subscriber configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type subscriberprofile -Payload $Payload -GetWarning
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
        Update Subscriber configuration Object
    .DESCRIPTION
        Update Subscriber configuration Object 
    .PARAMETER ip 
        Subscriber ip address. 
    .PARAMETER vlan 
        The vlan number on which the subscriber is located.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 4096 
    .PARAMETER subscriberrules 
        Rules configured for this subscriber. This is similar to rules received from PCRF for dynamic subscriber sessions. 
    .PARAMETER subscriptionidtype 
        Subscription-Id type.  
        Possible values = E164, IMSI, SIP_URI, NAI, PRIVATE 
    .PARAMETER subscriptionidvalue 
        Subscription-Id value. 
    .PARAMETER servicepath 
        Name of the servicepath to be taken for this subscriber.
    .EXAMPLE
        Invoke-ADCUpdateSubscriberprofile -ip <string>
    .NOTES
        File Name : Invoke-ADCUpdateSubscriberprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberprofile/
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
        [string]$ip ,

        [ValidateRange(0, 4096)]
        [double]$vlan ,

        [string[]]$subscriberrules ,

        [ValidateSet('E164', 'IMSI', 'SIP_URI', 'NAI', 'PRIVATE')]
        [string]$subscriptionidtype ,

        [string]$subscriptionidvalue ,

        [string]$servicepath 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSubscriberprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                ip = $ip
            }
            if ($PSBoundParameters.ContainsKey('vlan')) { $Payload.Add('vlan', $vlan) }
            if ($PSBoundParameters.ContainsKey('subscriberrules')) { $Payload.Add('subscriberrules', $subscriberrules) }
            if ($PSBoundParameters.ContainsKey('subscriptionidtype')) { $Payload.Add('subscriptionidtype', $subscriptionidtype) }
            if ($PSBoundParameters.ContainsKey('subscriptionidvalue')) { $Payload.Add('subscriptionidvalue', $subscriptionidvalue) }
            if ($PSBoundParameters.ContainsKey('servicepath')) { $Payload.Add('servicepath', $servicepath) }
 
            if ($PSCmdlet.ShouldProcess("subscriberprofile", "Update Subscriber configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type subscriberprofile -Payload $Payload -GetWarning
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
        Unset Subscriber configuration Object
    .DESCRIPTION
        Unset Subscriber configuration Object 
   .PARAMETER ip 
       Subscriber ip address. 
   .PARAMETER servicepath 
       Name of the servicepath to be taken for this subscriber.
    .EXAMPLE
        Invoke-ADCUnsetSubscriberprofile -ip <string>
    .NOTES
        File Name : Invoke-ADCUnsetSubscriberprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberprofile
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
        [string]$ip ,

        [Boolean]$servicepath 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSubscriberprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                ip = $ip
            }
            if ($PSBoundParameters.ContainsKey('servicepath')) { $Payload.Add('servicepath', $servicepath) }
            if ($PSCmdlet.ShouldProcess("$ip", "Unset Subscriber configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type subscriberprofile -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Delete Subscriber configuration Object
    .DESCRIPTION
        Delete Subscriber configuration Object
    .PARAMETER ip 
       Subscriber ip address.    .PARAMETER vlan 
       The vlan number on which the subscriber is located.  
       Default value: 0  
       Minimum value = 0  
       Maximum value = 4096
    .EXAMPLE
        Invoke-ADCDeleteSubscriberprofile -ip <string>
    .NOTES
        File Name : Invoke-ADCDeleteSubscriberprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberprofile/
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
        [string]$ip ,

        [double]$vlan 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSubscriberprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('vlan')) { $Arguments.Add('vlan', $vlan) }
            if ($PSCmdlet.ShouldProcess("$ip", "Delete Subscriber configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type subscriberprofile -NitroPath nitro/v1/config -Resource $ip -Arguments $Arguments
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
        Get Subscriber configuration object(s)
    .DESCRIPTION
        Get Subscriber configuration object(s)
    .PARAMETER GetAll 
        Retreive all subscriberprofile object(s)
    .PARAMETER Count
        If specified, the count of the subscriberprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSubscriberprofile
    .EXAMPLE 
        Invoke-ADCGetSubscriberprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSubscriberprofile -Count
    .EXAMPLE
        Invoke-ADCGetSubscriberprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetSubscriberprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSubscriberprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberprofile/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all subscriberprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for subscriberprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving subscriberprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving subscriberprofile configuration for property ''"

            } else {
                Write-Verbose "Retrieving subscriberprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Update Subscriber configuration Object
    .DESCRIPTION
        Update Subscriber configuration Object 
    .PARAMETER listeningservice 
        Name of RADIUS LISTENING service that will process RADIUS accounting requests.  
        Minimum length = 1 
    .PARAMETER radiusinterimasstart 
        Treat radius interim message as start radius messages.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUpdateSubscriberradiusinterface 
    .NOTES
        File Name : Invoke-ADCUpdateSubscriberradiusinterface
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberradiusinterface/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$listeningservice ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$radiusinterimasstart 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSubscriberradiusinterface: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('listeningservice')) { $Payload.Add('listeningservice', $listeningservice) }
            if ($PSBoundParameters.ContainsKey('radiusinterimasstart')) { $Payload.Add('radiusinterimasstart', $radiusinterimasstart) }
 
            if ($PSCmdlet.ShouldProcess("subscriberradiusinterface", "Update Subscriber configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type subscriberradiusinterface -Payload $Payload -GetWarning
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
        Unset Subscriber configuration Object
    .DESCRIPTION
        Unset Subscriber configuration Object 
   .PARAMETER radiusinterimasstart 
       Treat radius interim message as start radius messages.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetSubscriberradiusinterface 
    .NOTES
        File Name : Invoke-ADCUnsetSubscriberradiusinterface
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberradiusinterface
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

        [Boolean]$radiusinterimasstart 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSubscriberradiusinterface: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('radiusinterimasstart')) { $Payload.Add('radiusinterimasstart', $radiusinterimasstart) }
            if ($PSCmdlet.ShouldProcess("subscriberradiusinterface", "Unset Subscriber configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type subscriberradiusinterface -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Subscriber configuration object(s)
    .DESCRIPTION
        Get Subscriber configuration object(s)
    .PARAMETER GetAll 
        Retreive all subscriberradiusinterface object(s)
    .PARAMETER Count
        If specified, the count of the subscriberradiusinterface object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSubscriberradiusinterface
    .EXAMPLE 
        Invoke-ADCGetSubscriberradiusinterface -GetAll
    .EXAMPLE
        Invoke-ADCGetSubscriberradiusinterface -name <string>
    .EXAMPLE
        Invoke-ADCGetSubscriberradiusinterface -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSubscriberradiusinterface
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscriberradiusinterface/
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
        Write-Verbose "Invoke-ADCGetSubscriberradiusinterface: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all subscriberradiusinterface objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberradiusinterface -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for subscriberradiusinterface objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberradiusinterface -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving subscriberradiusinterface objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberradiusinterface -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving subscriberradiusinterface configuration for property ''"

            } else {
                Write-Verbose "Retrieving subscriberradiusinterface configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscriberradiusinterface -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Clear Subscriber configuration Object
    .DESCRIPTION
        Clear Subscriber configuration Object 
    .PARAMETER ip 
        Subscriber IP Address. 
    .PARAMETER vlan 
        The vlan number on which the subscriber is located.
    .EXAMPLE
        Invoke-ADCClearSubscribersessions 
    .NOTES
        File Name : Invoke-ADCClearSubscribersessions
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscribersessions/
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

        [string]$ip ,

        [ValidateRange(0, 4096)]
        [double]$vlan 

    )
    begin {
        Write-Verbose "Invoke-ADCClearSubscribersessions: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('ip')) { $Payload.Add('ip', $ip) }
            if ($PSBoundParameters.ContainsKey('vlan')) { $Payload.Add('vlan', $vlan) }
            if ($PSCmdlet.ShouldProcess($Name, "Clear Subscriber configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type subscribersessions -Action clear -Payload $Payload -GetWarning
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
        Get Subscriber configuration object(s)
    .DESCRIPTION
        Get Subscriber configuration object(s)
    .PARAMETER ip 
       Subscriber IP Address. 
    .PARAMETER vlan 
       The vlan number on which the subscriber is located. 
    .PARAMETER nodeid 
       Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retreive all subscribersessions object(s)
    .PARAMETER Count
        If specified, the count of the subscribersessions object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSubscribersessions
    .EXAMPLE 
        Invoke-ADCGetSubscribersessions -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSubscribersessions -Count
    .EXAMPLE
        Invoke-ADCGetSubscribersessions -name <string>
    .EXAMPLE
        Invoke-ADCGetSubscribersessions -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSubscribersessions
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/subscriber/subscribersessions/
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
        [string]$ip ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 4096)]
        [double]$vlan ,

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
        Write-Verbose "Invoke-ADCGetSubscribersessions: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all subscribersessions objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscribersessions -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for subscribersessions objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscribersessions -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving subscribersessions objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('ip')) { $Arguments.Add('ip', $ip) } 
                if ($PSBoundParameters.ContainsKey('vlan')) { $Arguments.Add('vlan', $vlan) } 
                if ($PSBoundParameters.ContainsKey('nodeid')) { $Arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscribersessions -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving subscribersessions configuration for property ''"

            } else {
                Write-Verbose "Retrieving subscribersessions configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type subscribersessions -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


