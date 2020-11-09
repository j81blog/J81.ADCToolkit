function Invoke-ADCSaveNSConfig {
    [cmdletbinding()]
    param(
        [hashtable]$Session = (Invoke-ADCGetActiveSession)
    )
    try {
        $response = Invoke-ADCNitroApi -Session $Session -Method POST -Type nsconfig -Action save
    } catch {
        $response = $null
    }
    return $response
}
