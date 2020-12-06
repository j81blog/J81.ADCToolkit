function Invoke-ADCUpdateCSPolicy {
    <#
    .SYNOPSIS
        Update an existing Content-Switching Policy resource
    .DESCRIPTION
        Update an existing Content-Switching Policy resource
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER PolicyName
        Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, 
        underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created.
        The following requirement applies only to the Citrix ADC CLI:
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy').
        Minimum length = 1
    .PARAMETER Url
        URL string that is matched with the URL of a request. Can contain a wildcard character. Specify the string value in the following format: [[prefix] [*]] [.suffix].
        Minimum length = 1
        Maximum length = 208
    .PARAMETER Rule
        Expression, or name of a named expression, against which traffic is evaluated.
    .PARAMETER Domain
        The domain name. The string value can range to 63 characters.
        Minimum length = 1
    .PARAMETER Action
        Content switching action that names the target load balancing virtual server to which the traffic is switched.
    .PARAMETER LogAction
        The log action associated with the content switching policy.
    .PARAMETER PassThru
        Return details about the created CertKey.
    .EXAMPLE
        Invoke-ADCUpdateCSPolicy -PolicyName csp_www.domain.com_https -Rule 'HTTP.REQ.HOSTNAME.TO_LOWER.CONTAINS("www.domain.com")'
    .NOTES
        File Name : Invoke-ADCUpdateCSPolicy
        Version   : v0.2
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [ValidateLength(1, 65534)]
        [Parameter(Mandatory = $true)]
        [String]$PolicyName = (Read-Host -Prompt "Name of the existing Content Switch Policy"),
        
        [ValidateLength(1, 208)]
        [String]$Url,
        
        [String]$Rule,
        
        [ValidateLength(1, 63)]
        [String]$Domain,

        [String]$Action,

        [string]$LogAction,

        [Switch]$PassThru

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCSPolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $PolicyName
            }
            if ($PSBoundParameters.ContainsKey('Url')) { $Payload.Add('url', $Url) }
            if ($PSBoundParameters.ContainsKey('Rule')) { $Payload.Add('rule', $Rule) }
            if ($PSBoundParameters.ContainsKey('Domain')) { $Payload.Add('domain', $Domain) }
            if ($PSBoundParameters.ContainsKey('Action')) { $Payload.Add('action', $Action) }
            if ($PSBoundParameters.ContainsKey('LogAction')) { $Payload.Add('logaction', $LogAction) }
 
            if ($PSCmdlet.ShouldProcess($PolicyName, 'Updating Content Switch Policy')) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type cspolicy -Payload $Payload -GetWarning
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCSPolicy -PolicyName $PolicyName)
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
        Write-Verbose "Invoke-ADCUpdateCSPolicy: Finished"
    }
}
