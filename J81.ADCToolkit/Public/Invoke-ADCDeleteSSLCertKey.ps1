function Invoke-ADCDeleteSSLCertKey {
    [cmdletbinding()]
    param(
        [hashtable]$Session = (Invoke-ADCGetActiveSession),
            
        [String]$CertKey,
            
        [Switch]$Text
    )
    try {
        $response = Invoke-ADCNitroApi -Session $Session -Method DELETE -Type sslcertkey -Resource $CertKey
    } catch {
        $response = $null
    }
    return $response
}
