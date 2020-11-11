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
        Version   : v0.4
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
    Write-ConsoleText -Title "ADC Connection"
    Write-ConsoleText -Line "Connecting"
    try {
        Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*"
        $ADCSession = Connect-ADCNode -ManagementURL $ManagementURL -Credential $Credential -PassThru -ErrorAction Stop
        $IsConnected = $true
        Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*"
        $HANode = Invoke-ADCGetHANode | Expand-ADCResult
        $nsconfig = Invoke-ADCGetNSConfig | Expand-ADCResult
        if ($nsconfig.ipaddress -ne $nsconfig.primaryip) {
            Write-Warning "You are connected to a secondary node (Primary node is $($nsconfig.primaryip))"
        }
        $NodeState = $nsconfig.systemtype
        $ADCSessions = @()
        if ($NodeState -like "Stand-alone") {
            Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*"
            try {
                $PrimaryURL = [System.URI]"$($ManagementURL.Scheme):\\$($nsconfig.ipaddress)"
                $PriSession = Connect-ADCNode -ManagementURL $PrimaryURL -Credential $Credential -PassThru -ErrorAction Stop
                $PriNode = $HANode | Where-Object { $_.ipaddress -eq $nsconfig.ipaddress }
            } catch {
                $PriSession = $ADCSession
            }
            $ADCSessions += [PsCustomObject]@{ ID = 0; State = "Primary"; Session = $PriSession }
            Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*"
        } elseif ($NodeState -like "HA") {
            Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*"
            try {
                $PriNode = $HANode | Where-Object { $_.state -like "Primary" }
                $PrimaryIP = $PriNode.ipaddress
                $PrimaryURL = [System.URI]"$($ManagementURL.Scheme):\\$PrimaryIP"
                $PriSession = Connect-ADCNode -ManagementURL $PrimaryURL -Credential $Credential -PassThru -ErrorAction Stop
                Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*"
            } catch {
                Write-Verbose "Error, $($_.Exception.Message)"
                $PriSession = $ADCSession
            }
            $ADCSessions += [PsCustomObject]@{ ID = 0; State = "Primary  "; Session = $PriSession }
            Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*"
            try {
                $SecNode = $HANode | Where-Object { $_.state -like "Secondary" }
                if ([String]::IsNullOrEmpty($SecNode)) {
                    $SecNode = $HANode | Where-Object { $_.ipaddress -ne $PriNode.ipaddress }
                }
                $SecondaryIP = $SecNode.ipaddress
                $SecondaryURL = [System.URI]"$($ManagementURL.Scheme):\\$SecondaryIP"
                $SecSession = Connect-ADCNode -ManagementURL $SecondaryURL -Credential $Credential -PassThru -ErrorAction Stop
                Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*"
                $ADCSessions += [PsCustomObject]@{ ID = 1; State = "Secondary"; Session = $SecSession }
            } catch {
                Write-Verbose "Error, $($_.Exception.Message)"
                $SecSession = $null
            }
        }
        Write-ConsoleText -ForeGroundColor Green " Connected"
    } catch {
        Write-Verbose "Caught an error: $_.Exception.Message"
        Write-ConsoleText -ForeGroundColor Red "  ERROR, Could not connect" -PostBlank
        $IsConnected = $false
    }
    if ($IsConnected) {
        Write-ConsoleText -Title "ADC Info"
        Write-ConsoleText -Line "Username"
        Write-ConsoleText -ForeGroundColor Cyan "$($ADCSession.Username)"
        Write-ConsoleText -Line "Password"
        Write-ConsoleText -ForeGroundColor Cyan "**********"
        Write-ConsoleText -Line "Configuration"
        Write-ConsoleText -ForeGroundColor Cyan "$NodeState"
        Write-ConsoleText -Line "Node"
        Write-ConsoleText -ForeGroundColor Cyan "$($PriNode.state)"
        Write-ConsoleText -Line "URL"
        Write-ConsoleText -ForeGroundColor Cyan "$($PrimaryURL.OriginalString)"
        Write-ConsoleText -Line "Version"
        Write-ConsoleText -ForeGroundColor Cyan "$($PriSession.Version)"
        if ((-Not [String]::IsNullOrEmpty($SecSession)) -Or ($SecNode.state -eq "UNKNOWN")) {
            Write-ConsoleText -Line "Node"
            Write-ConsoleText -ForeGroundColor Cyan "$($SecNode.state)"
            Write-ConsoleText -Line "URL"
            Write-ConsoleText -ForeGroundColor Cyan "$($SecondaryURL.OriginalString)"
            Write-ConsoleText -Line "Version"
            Write-ConsoleText -ForeGroundColor Cyan "$($SecSession.Version)"
        }
        if ($($ADCSession | ConvertFrom-ADCVersion) -lt [System.Version]"11.0") {
            Throw "Only ADC version 11 and up is supported"
        }

        Write-ConsoleText -Line "Backup"
        if ($Backup) {
            Write-ConsoleText -ForeGroundColor Cyan "Initiated"
            Write-ConsoleText -Line "Backup Status"
            try {        
                $BackupName = "CleanCerts_$((Get-Date).ToString("yyyyMMdd_HHmm"))"
                $Response = Invoke-ADCNewSystemBackup -ADCSession $PriSession -Name $BackupName -Comment "Backup created by PoSH function Invoke-ADCCleanCertKeyFiles" -SaveConfigFirst -ErrorAction Stop
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
                $Certs = Invoke-ADCRetrieveCertificateRemoveInfo -ADCSession $PriSession
                $RemovableCerts = $Certs | Where-Object { $_.removable -eq $true }
                if ($RemovableCerts.Count -gt 0) {
                    Write-ConsoleText "Removing CertKeys from the configuration for unused certificates, attempt $loop/$Attempts" -PreBlank
                    Foreach ($RemovableCert in $RemovableCerts) {
                
                        $RemovableCert | Where-Object { $_.certData.bound -eq $false } | ForEach-Object {
                            Write-ConsoleText -Line "CertKey"
                            Write-ConsoleText "$($_.certData.certkey)"
                            Write-ConsoleText -Line "Removing"
                            $result = Invoke-ADCDeleteSSLCertKey -ADCSession $PriSession -CertKey $_.certData.certkey -ErrorAction SilentlyContinue | Write-ADCText
                            Write-Verbose "Result: $result"
                        }
                        if ($_.keyData.certkey -ne $_.certData.certkey) {
                            $RemovableCert | Where-Object { $_.keyData.bound -eq $false } | ForEach-Object {
                                Write-ConsoleText -Line "CertKey"
                                Write-ConsoleText "$($_.keyData.certkey)"
                                Write-ConsoleText -Line "Removing"
                                $result = Invoke-ADCDeleteSSLCertKey -ADCSession $PriSession -CertKey $_.keyData.certkey -ErrorAction  SilentlyContinue | Write-ADCText
                                Write-Verbose "Result: $result"
                            }
                        }
                    }
            
                    Write-Verbose "Retrieving certificates and remove unbound files"
                    $Certs = Invoke-ADCRetrieveCertificateRemoveInfo -ADCSession $PriSession
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
                        $result = Invoke-ADCDeleteSystemFile -ADCSession $Session.Session -FileName $_.fileName -FileLocation $_.filelocation | Write-ADCText
                        Write-Verbose "Result: $result"
                    }
                }
            } else {
                Write-ConsoleText "Nothing to remove (anymore), the location `"/nsconfig/ssl/`" is tidy!" -PreBlank
            }

            $Certs = Invoke-ADCRetrieveCertificateRemoveInfo -ADCSession $PriSession
            if ($($Certs | Where-Object { $_.certData.status -eq "Expired" }).count -gt 0) {
                Write-ConsoleText -Blank
                Write-Warning "You still have EXPIRED certificates bound/active in the configuration!"
            }

            $ExpiringCerts = @($Certs | Where-Object { ($_.certData.daystoexpiration -in 0..$ExpirationDays) -and (-Not [String]::IsNullOrEmpty( $($_.certData.daystoexpiration) ) -and (-Not [String]::IsNullOrEmpty( $($_.certData.certkey) ) )) })
            if ($ExpiringCerts.Count -gt 0) {
                Write-ConsoleText -Blank
                Write-Warning "You have $($ExpiringCerts.Count) certificate(s) that will expire within $ExpirationDays days"

                $ExpiringCerts | ForEach-Object {
                    Write-Warning "=> Days To Expiration: $($_.certData.daystoexpiration), CertKey: $($_.certData.certkey)"
                }
                Write-ConsoleText -Blank
            }
            if (-Not $NoSaveConfig) {
                Write-ConsoleText -Line "Saving the config"
                try {
                    $result = Invoke-ADCSaveNSConfig -ADCSession $ADCSession -ErrorAction Stop
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
