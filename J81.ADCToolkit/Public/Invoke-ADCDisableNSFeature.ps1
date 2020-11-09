function Invoke-ADCDisableNSFeature {
    <#
        .SYNOPSIS
            Disable one or multiple ADC features
        .DESCRIPTION
            Disable one or multiple ADC features
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Feature
            Enter one or more Features that need to be disabled
        .EXAMPLE
            Invoke-ADCDisableNSFeature -Feature LB
        .EXAMPLE
            Invoke-ADCDisableNSFeature -Feature lb, cs, rewrite, responder
        .NOTES
            File Name : Invoke-ADCDisableNSFeature
            Version   : v0.1
            Author    : John Billekens
            Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ns/nsfeature/
            Requires  : PowerShell v5.1 and up
                        ADC 11.x and up
        .LINK
            https://blog.j81.nl
        #>
    [CmdletBinding()]  
    Param(
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [ValidateSet('wl', 'sp', 'lb', 'cs', 'cr', 'sc', 'cmp', 'pq', 'ssl', 'gslb', 'hdosp', 'routing', 'cf', 'ic', 'sslvpn', `
                'aaa', 'ospf', 'rip', 'bgp', 'rewrite', 'ipv6pt', 'appfw', 'responder', 'htmlinjection', 'push', 'appflow', `
                'cloudbridge', 'isis', 'ch', 'appqoe', 'contentaccelerator', 'rise', 'feo', 'lsn', 'rdpproxy', 'rep', `
                'urlfiltering', 'videooptimization', 'forwardproxy', 'sslinterception', 'adaptivetcp', 'cqa', 'ci', 'bot')]
        [String[]]$Feature = @()
    )
    try {
        $Payload = @{"feature" = $Feature }
        $response = Invoke-ADCNitroApi -Session $ADCSession -Method POST -Type nsfeature -Payload $payload -Action disable -GetWarning
    } catch {
        Write-Verbose "ERROR: $($_.Exception.Message)"
        $response = $null
    }
    return $response
}
