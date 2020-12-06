function Invoke-ADCEnableNSFeature {
    <#
        .SYNOPSIS
            Enable one or multiple ADC features
        .DESCRIPTION
            Enable one or multiple ADC features
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Feature
            Enter one or more Features that need to be enabled
        .EXAMPLE
            Invoke-ADCEnableNSFeature -Feature LB
        .EXAMPLE
            Invoke-ADCEnableNSFeature -Feature lb, cs, rewrite, responder
        .NOTES
            File Name : Invoke-ADCEnableNSFeature
            Version   : v0.2
            Author    : John Billekens
            Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ns/nsfeature/
            Requires  : PowerShell v5.1 and up
                        ADC 11.x and up
        .LINK
            https://blog.j81.nl
        #>
    [CmdletBinding()]  
    Param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [ValidateSet('wl', 'sp', 'lb', 'cs', 'cr', 'sc', 'cmp', 'pq', 'ssl', 'gslb', 'hdosp', 'routing', 'cf', 'ic', 'sslvpn', `
                'aaa', 'ospf', 'rip', 'bgp', 'rewrite', 'ipv6pt', 'appfw', 'responder', 'htmlinjection', 'push', 'appflow', `
                'cloudbridge', 'isis', 'ch', 'appqoe', 'contentaccelerator', 'rise', 'feo', 'lsn', 'rdpproxy', 'rep', `
                'urlfiltering', 'videooptimization', 'forwardproxy', 'sslinterception', 'adaptivetcp', 'cqa', 'ci', 'bot')]
        [String[]]$Feature = @()
    )
    begin {
        Write-Verbose "Invoke-ADCEnableNSFeature: Starting"
    }
    process {
        try {
            $Payload = @{"feature" = $Feature }
            Write-Verbose "Enable feature: $($Feature -Join ", ")"
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type nsfeature -Payload $payload -Action enable -GetWarning
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCEnableNSFeature: Finished"
    }
}
