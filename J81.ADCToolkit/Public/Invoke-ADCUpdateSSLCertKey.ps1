function Invoke-ADCUpdateSSLCertKey {
    <#
    .SYNOPSIS
        Update SSL CertKey
    .DESCRIPTION
        Update SSL CertKey
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER CertKey
        Specify the CertKey Name
    .PARAMETER ExpiryMonitor
        Issue an alert when the certificate is about to expire.
    .PARAMETER NotificationPeriod
        Time, in number of days, before certificate expiration, at which to generate an alert that the certificate is about to expire.
        Minimum value = 10
        Maximum value = 100
    .EXAMPLE
        Invoke-ADCUpdateSSLCertKey -CertKey "wildcard_domain.com" -ExpiryMonitor ACTIVE -NotificationPeriod 30
    .NOTES
        File Name : Invoke-ADCUpdateSSLCertKey
        Version   : v0.2
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [cmdletbinding()]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
            
        [parameter(Mandatory = $true)]
        [String]$CertKey = (Read-Host -Prompt "Name for the Certificate Key pair"),

        [ValidateSet("PASSIVE", "ACTIVE")]
        [String]$ExpiryMonitor = "ACTIVE",

        [ValidatePattern('^([1-9][0-9]|[1-9][0-9]|100)$', Options = 'None')]
        [Double]$NotificationPeriod

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSSLCertKey: Starting"
    }
    process {
        try {
            Write-Verbose "Updating `"$CertKey`""
            $Payload = @{
                certkey = $CertKey
            }
            if ($PSBoundParameters.ContainsKey('ExpiryMonitor')) { $Payload.Add('expirymonitor', $ExpiryMonitor) }
            if ($PSBoundParameters.ContainsKey('NotificationPeriod')) { $Payload.Add('notificationperiod', $NotificationPeriod) }

            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type sslcertkey -Payload $Payload
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCUpdateSSLCertKey: Finished"
    } 
}
