function Invoke-ADCRetrieveCertificateRemoveInfo {
    <#
    .SYNOPSIS
        Get CertKey file info, determining files that can be removed
    .DESCRIPTION
        Get CertKey file info, determining files that can be removed
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER ExcludedCertKey
        Specify CertKeys that need to be excluded
    .EXAMPLE
        Invoke-ADCRetrieveCertificateRemoveInfo
    .NOTES
        File Name : Invoke-ADCRetrieveCertificateRemoveInfo
        Version   : v0.3
        Author    : John Billekens
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [cmdletbinding()]
    param(
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
        
        [String[]]$ExcludedCertKey = @()
    )
    begin {
        Write-Verbose "Invoke-ADCRetrieveCertificateRemoveInfo: Starting"
    }
    process {
        $SSLFileLocation = "/nsconfig/ssl"
        $InstalledCertificates = Invoke-ADCGetSSLCertKey -ADCSession $ADCSession | Expand-ADCResult | Where-Object { $_.certkey -NotMatch '^ns-server-certificate$' } | Select-Object certkey, status, linkcertkeyname, serial, @{label = "daystoexpiration"; expression = { $_.daystoexpiration -as [int] } }, @{label = "cert"; expression = { "$($_.cert.Replace('/nsconfig/ssl/',''))" } }, @{label = "key"; expression = { "$($_.key.Replace('/nsconfig/ssl/',''))" } }
        $FileLocations = Invoke-ADCGetSystemFileDirectories -FileLocation $SSLFileLocation
        $CertificateFiles = $FileLocations | ForEach-Object { Invoke-ADCGetSystemFile -FileLocation $_ -ADCSession $ADCSession | Expand-ADCResult | Where-Object { ($_.filename -NotMatch '^ns-root.*$|^ns-server.*$|^ns-sftrust.*$|^trusted_root_certs.*$') -And ($_.filemode -ne "DIRECTORY") } }
        $CertificateBindings = Invoke-ADCGetSSLCertKeyBinding -ADCSession $ADCSession | Expand-ADCResult
        $LinkedCertificate = Invoke-ADCGetSSLCertLink -ADCSession $ADCSession | Expand-ADCResult
        $SAMLCertificates = Invoke-ADCGetAuthenticationSAMLAction | Expand-ADCResult | ForEach-Object { $_ | Select-Object -ExpandProperty samlidpcertname -ErrorAction SilentlyContinue ; $_ | Select-Object -ExpandProperty samlsigningcertname -ErrorAction SilentlyContinue} | Select-Object -Unique
        $Certificates = @()
        Foreach ($cert in $CertificateFiles) {
            $Removable = $true
            $certData = $InstalledCertificates | Where-Object { $_.cert -match "^$($cert.filename)$|^.*/$($cert.filename)$" }
            $keyData = $InstalledCertificates | Where-Object { $_.key -match "^$($cert.filename)$|^.*/$($cert.filename)$" }
            $CertFileData = @()
            Foreach ($item in $certData) {
                $Linked = $LinkedCertificate | Where-Object { $_.linkcertkeyname -eq $item.certkey } | Select-Object -ExpandProperty certkeyname
                if ((($CertificateBindings | Where-Object { $_.certkey -eq $item.certkey } | Get-Member -MemberType NoteProperty | Where-Object {($_.Name -like "*binding") -and -not ($_.Name -like "*crldistribution*") }).Name) -or ($Linked)) {
                    $CertFileData += $item | Select-Object *, @{label = "bound"; expression = { $true } }, @{label = "linkedcertkey"; expression = { $Linked } }
                    $Removable = $false
                } elseif ($item.certkey -in $SAMLCertificates) {
                    $CertFileData += $item | Select-Object *, @{label = "bound"; expression = { $true } }, @{label = "linkedcertkey"; expression = { "AuthenticationSAMLAction" } }
                    $Removable = $false
                } else {
                    $CertFileData += $item | Select-Object *, @{label = "bound"; expression = { $false } }, @{label = "linkedcertkey"; expression = { $Linked } }
                }
            }
            $KeyFileData = @()
            Foreach ($item in $keyData) {
                $Linked = $InstalledCertificates | Where-Object { $_.linkcertkeyname -eq $item.certkey -and $null -ne $_.linkcertkeyname } | Select-Object -ExpandProperty certkey
                if ((($CertificateBindings | Where-Object { $_.certkey -eq $item.certkey } | Get-Member -MemberType NoteProperty | Where-Object {($_.Name -like "*binding") -and -not ($_.Name -like "*crldistribution*") }).Name) -or ($Linked)) {
                    $KeyFileData += $item | Select-Object *, @{label = "bound"; expression = { $true } }, @{label = "linkedcertkey"; expression = { $Linked } }
                    $Removable = $false
                } else {
                    $KeyFileData += $item | Select-Object *, @{label = "bound"; expression = { $false } }, @{label = "linkedcertkey"; expression = { $Linked } }
                }
            }
            $Certificates += [PsCustomObject]@{
                filename     = $cert.filename
                filelocation = $cert.filelocation
                certData     = $CertFileData
                keyData      = $KeyFileData
                removable    = $Removable
            }
        }
        Write-Output $Certificates
    }
    end {
        Write-Verbose "Invoke-ADCRetrieveCertificateRemoveInfo: Finished"
    }
}
