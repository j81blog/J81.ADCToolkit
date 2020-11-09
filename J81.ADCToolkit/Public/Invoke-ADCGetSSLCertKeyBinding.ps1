function Invoke-ADCGetSSLCertKeyBinding {
    <#
        .SYNOPSIS
            Get Binding information for CertKeys (TLS Certificates)
        .DESCRIPTION
            Get Binding information for CertKeys (TLS Certificates)
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER CertKey
            Specify a CertKey name
        .EXAMPLE
            Invoke-ADCGetSSLCertKeyBinding
        .EXAMPLE
            Invoke-ADCGetSSLCertKeyBinding -CertKey "domain.com"
        .NOTES
            File Name : Invoke-ADCGetSSLCertKeyBinding
            Version   : v0.1
            Author    : John Billekens
            Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey_binding/
            Requires  : PowerShell v5.1 and up
                        ADC 11.x and up
        .LINK
            https://blog.j81.nl
        #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]  
    Param(
        
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
			
        [Parameter(ParameterSetName = "GetResource", Mandatory = $true)]
        [String]$CertKey
    )

    try {
        if ($PSBoundParameters.ContainsKey('CertKey')) {
            $response = Invoke-ADCNitroApi -Session $ADCSession -Method Get -Type sslcertkey_binding -Resource $CertKey -GetWarning
        } else {
            $Query = @{"bulkbindings" = "yes"; }
            $response = Invoke-ADCNitroApi -Session $ADCSession -Method Get -Type sslcertkey_binding -Query $Query -GetWarning
        }
    } catch {
        Write-Verbose "ERROR: $($_.Exception.Message)"
        $response = $null
    }
    return $response
}
