function Invoke-ADCDeleteSystemFile {
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param(
        [hashtable]$Session = (Invoke-ADCGetActiveSession),
            
        [String]$FileName,
            
        [String]$FileLocation
    )
    if ($PSCmdlet.ShouldProcess($FileName, 'Delete File')) {
        try {
            $Arguments = @{"filelocation" = "$FileLocation"; }
            $response = Invoke-ADCNitroApi -Session $Session -Method DELETE -Type systemfile -Resource $FileName -Arguments $Arguments
        } catch {
            $response = $null
        }
        return $response
    }
}