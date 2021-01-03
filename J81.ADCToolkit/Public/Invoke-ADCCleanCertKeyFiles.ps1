function Invoke-ADCCleanCertKeyFiles {
    <#
    .SYNOPSIS
        Cleanup old/unused certificates on a Citrix ADC.
    .DESCRIPTION
        Remotely cleanup old/unused certificates on a Citrix ADC.
    .PARAMETER ManagementURL
        The URI/URL to connect to, E.g. "https://citrixadc.domain.local".
    .PARAMETER Credential
        The credential to authenticate to the NetScaler with.
    .PARAMETER Backup
        Backup the configuration first (full) before any changes are made.
    .PARAMETER noSaveConfig
        The configuration will be saved by default after all changes are made.
        Specify "-NoSaveConfig" to disable saving the configuration.
    .PARAMETER ExpirationDays
        If you have soon to be expired certificates (within 30 days) you will receive a warning message.
        By specifying this parameter you can change the nr of days.
    .EXAMPLE
        $Credential = Get-Credential -UserName "nsroot" -Message "Citrix ADC account"
        Invoke-ADCCleanCertKeyFiles -ManagementURL = "https://citrixadc.domain.local" -Credential $Credential
    .EXAMPLE
        $Params = @{
            ManagementURL = "https://citrixadc.domain.local"
            Credential = (Get-Credential -UserName "nsroot" -Message "Citrix ADC account")
            Backup = $true
        }
        Invoke-ADCCleanCertKeyFiles @Params
    .NOTES
        File Name : Invoke-ADCCleanCertKeyFiles.ps1
        Version   : v2101.0121
        Author    : John Billekens
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory)]
        [System.Uri]$ManagementURL,

        [parameter(Mandatory)]
        [PSCredential]$Credential,
        
        [Switch]$Backup,
        
        [Switch]$NoSaveConfig,
        
        [Int]$Attempts = 2,
        
        [Int]$ExpirationDays = 30
    )
    Write-Verbose "Invoke-ADCCleanCertKeyFiles: Starting"
    Write-Verbose "Trying to login into the Citrix ADC."
    $ADCSession = Connect-ADCHANodes -ManagementURL $ManagementURL -Credential $Credential -PassThru -DisplayConsoleText
    $ADCSessions = @()
    $ADCSessions += $ADCSession["PrimarySession"].Session
    if ($ADCSession.IsHA) {
        $ADCSessions += $ADCSession["SecondarySession"].Session
    }
    if (-Not [String]::IsNullOrEmpty($($ADCSession["PrimarySession"].Session))) {

        Write-ConsoleText -Line "Backup"
        if ($Backup) {
            Write-ConsoleText -ForeGroundColor Cyan "Initiated"
            Write-ConsoleText -Line "Backup Status"
            try {        
                $BackupName = "CleanCerts_$((Get-Date).ToString("yyyyMMdd_HHmm"))"
                $Response = Invoke-ADCSaveNsconfig -all $true -ADCSession $ADCSession["PrimarySession"].Session -ErrorAction Stop
                $Response = Invoke-ADCCreateSystembackup -ADCSession $ADCSession["PrimarySession"].Session -filename $BackupName -level full -comment "Backup created by PoSH function Invoke-ADCCleanCertKeyFiles" -ErrorAction Stop
                Write-ConsoleText -ForeGroundColor Green "OK [$BackupName]"
            } catch {
                Write-ConsoleText -ForeGroundColor Red "Failed $($Response.message)"
            }
        } else {
            Write-ConsoleText -ForeGroundColor Yellow "Skipped, not configured"
        }
        $loop = 1
        try {
            Write-Verbose "Retrieving the certificate details."
            Do {
                $Certs = Invoke-ADCRetrieveCertificateRemoveInfo -ADCSession $ADCSession["PrimarySession"].Session
                $RemovableCerts = $Certs | Where-Object { $_.removable -eq $true }
                if ($RemovableCerts.Count -gt 0) {
                    Write-ConsoleText "Removing CertKeys from the configuration for unused certificates, attempt $loop/$Attempts" -PreBlank
                    Foreach ($RemovableCert in $RemovableCerts) {
                
                        $RemovableCert | Where-Object { $_.certData.bound -eq $false } | ForEach-Object {
                            Write-ConsoleText -Line "CertKey"
                            Write-ConsoleText "$($_.certData.certkey)"
                            Write-ConsoleText -Line "Removing"
                            $Response = Invoke-ADCDeleteSslCertkey -ADCSession $ADCSession["PrimarySession"].Session -certkey $_.certData.certkey -ErrorAction SilentlyContinue | Write-ADCText
                            Write-Verbose "Response: $Response"
                        }
                        if ($_.keyData.certkey -ne $_.certData.certkey) {
                            $RemovableCert | Where-Object { $_.keyData.bound -eq $false } | ForEach-Object {
                                Write-ConsoleText -Line "CertKey"
                                Write-ConsoleText "$($_.keyData.certkey)"
                                Write-ConsoleText -Line "Removing"
                                $Response = Invoke-ADCDeleteSslCertkey -ADCSession $ADCSession["PrimarySession"].Session -certkey $_.keyData.certkey -ErrorAction  SilentlyContinue | Write-ADCText
                                Write-Verbose "Response: $Response"
                            }
                        }
                    }
            
                    Write-Verbose "Retrieving certificates and remove unbound files"
                    $Certs = Invoke-ADCRetrieveCertificateRemoveInfo -ADCSession $ADCSession["PrimarySession"].Session
                }
                $loop++
            } While ($loop -lt ($Attempts + 1) )
            $RemovableCerts = $Certs | Where-Object { ($_.removable -eq $true) -and ($_.certData.count -eq 0) -and ($_.keyData.count -eq 0) }
            if ($RemovableCerts.Count -gt 0) {
                Write-ConsoleText -Title "Removing certificate files"
                $RemovableCerts | ForEach-Object {
                    Write-ConsoleText -Line "Filename"
                    Write-ConsoleText "$($_.filelocation)/$($_.fileName)"
                    foreach ($Session in $ADCSessions) {
                        Write-ConsoleText -Line "Deleting"
                        Write-ConsoleText -NoNewLine -ForeGroundColor Cyan "[$($Session.State)] "
                        $Response = Invoke-ADCDeleteSystemFile -ADCSession $Session.Session -filename $_.fileName -filelocation $_.filelocation | Write-ADCText
                        Write-Verbose "Response: $Response"
                    }
                }
            } else {
                Write-ConsoleText "Nothing to remove (anymore), the location `"/nsconfig/ssl/`" is tidy!" -PreBlank
            }

            $Certs = Invoke-ADCRetrieveCertificateRemoveInfo -ADCSession $ADCSession["PrimarySession"].Session
            if ($($Certs | Where-Object { $_.certData.status -eq "Expired" }).count -gt 0) {
                Write-ConsoleText -Blank
                Write-Warning "You still have EXPIRED certificates bound/active in the configuration!"
            }

            $ExpiringCerts = @($Certs | Where-Object { ($_.certData.daystoexpiration -in 0..$ExpirationDays) -and (-Not [String]::IsNullOrEmpty( $($_.certData.daystoexpiration) ) -and (-Not [String]::IsNullOrEmpty( $($_.certData.certkey) ) )) })
            if ($ExpiringCerts.Count -gt 0) {
                Write-ConsoleText -Blank
                Write-Warning "You have $($ExpiringCerts.Count) certificate(s) that will expire within $ExpirationDays days"
                $ExpiringCerts | ForEach-Object {
                    if ($_.certData.daystoexpiration -eq 0) {
                        Write-Warning "=> Days To Expiration: $($_.certData.daystoexpiration), CertKey: $($_.certData.certkey) !! EXPIRED !!"
                    } else {
                        Write-Warning "=> Days To Expiration: $($_.certData.daystoexpiration), CertKey: $($_.certData.certkey)"
                    }
                }
                Write-ConsoleText -Blank
            }
            if (-Not $NoSaveConfig) {
                Write-ConsoleText -Line "Saving the config"
                try {
                    $Response = Invoke-ADCSaveNsconfig -all $true -ADCSession $ADCSession["PrimarySession"].Session -ErrorAction Stop
                    Write-ConsoleText -ForeGroundColor Green "Done"
                } catch {
                    Write-ConsoleText -ForeGroundColor Red "Failed"
                }
            }
            Write-ConsoleText -ForeGroundColor Green "Finished!" -PreBlank -PostBlank
        } catch {
            Write-ConsoleText -ForeGroundColor Red "Caught an error. Exception Message: $($_.Exception.Message)"
        }
        Write-Verbose "Invoke-ADCCleanCertKeyFiles: Finished"
    }
}
