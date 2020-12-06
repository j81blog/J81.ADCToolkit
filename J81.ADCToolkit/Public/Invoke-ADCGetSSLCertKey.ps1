function Invoke-ADCGetSSLCertKey {
    <#
    .SYNOPSIS
        Get SSL Certificate names (CertKey)
    .DESCRIPTION
        Get SSL Certificate names (CertKey)
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER CertKey
        Name for the Certificate Key pair. Must begin with an ASCII alphanumeric or underscore (_) character, 
        and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), 
        equal sign (=), and hyphen (-) characters.
    .PARAMETER Filter
        Specify a filter
        -Filter @{"certkey"="star_domain.com"}
		or -Filter ${"status"="Expired"}
    .PARAMETER Summary
        If specified a subset of info will be returned
    .EXAMPLE
        Invoke-ADCGetSSLCertKey
    .NOTES
        File Name : Invoke-ADCGetSSLCertKey
        Version   : v0.2
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [cmdletbinding(DefaultParameterSetName = "GetAll")]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
            
        [Parameter(ParameterSetName = "GetResource", Mandatory = $true)]
        [String]$CertKey,

        [hashtable]$Filter = @{ },
    
        [Parameter(ParameterSetName = "GetAll")]
        [Switch]$Count = $false,

        [Switch]$Summary = $false
        
    )
    begin {
        Write-Verbose "Invoke-ADCGetSSLCertKey: Starting"
    }
    process {
        $Query = @{ }
        try {
            if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ "count" = "yes" } }

            if ($PSBoundParameters.ContainsKey('CertKey')) {
                Write-Verbose "Retrieving SSL CertKey `"$CertKey`""
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method Get -Type sslcertkey -Resource $CertKey -Summary:$Summary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving all SSL CertKeys"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method Get -Type sslcertkey -Summary:$Summary -Filter $Filter -Query $Query -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSSLCertKey: Finished"
    }
}