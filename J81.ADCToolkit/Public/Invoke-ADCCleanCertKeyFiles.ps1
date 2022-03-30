function Invoke-ADCCleanCertKeyFiles {
    <#
    .SYNOPSIS
        Cleanup old/unused certificates on a Citrix ADC.
    .DESCRIPTION
        With the Invoke-ADCCleanCertKeyFiles function you can cleanup old (unused) CertKey files on your Citrix ADC. It will validate if a file is in use somewhere in the configuration, if not it will be marked for deletion. Then it will try to delete the marked files.
        By default the script will NOT make a full backup. Best practice is to specify the -Backup parameter. If anything might go wrong you will have a (full) backup (including the certificates).
    .PARAMETER ManagementURL
        The URI/URL to connect to, E.g. "https://citrixadc.domain.local".
    .PARAMETER Credential
        The credential to authenticate to the NetScaler with.
    .PARAMETER Backup
        Backup the configuration first (full) before any changes are made.
    .PARAMETER NoSaveConfig
        The configuration will be saved by default after all changes are made.
        Specify "-NoSaveConfig" to disable saving the configuration.
    .PARAMETER Attempts
        By default 2 attempts will be taken trying to delete cert-files.
        Specify a number between 2-4.
    .PARAMETER ExpirationDays
        If you have soon to be expired certificates (within 30 days) you will receive a warning message.
        By specifying this parameter you can change the nr of days.
    .EXAMPLE
        PS C:\>Invoke-ADCCleanCertKeyFiles -ManagementURL = "https://citrixadc.domain.local" -Credential $(Get-Credential -UserName "nsroot" -Message "Citrix ADC account")
        An example with only the required parameters, this will scan and delete unused certificates.
    .EXAMPLE
        PS C:\>Invoke-ADCCleanCertKeyFiles -ManagementURL = "https://citrixadc.domain.local" -Credential $(Get-Credential -UserName "nsroot" -Message "Citrix ADC account") -Backup
        This example will first make a backup and then clean the ADC.
    .NOTES
        File Name : Invoke-ADCCleanCertKeyFiles.ps1
        Version   : v2203.2922
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
        
        [ValidateRange(2, 4)]
        [Int]$Attempts = 2,
        
        [Int]$ExpirationDays = 30
    )
    Write-Verbose "Invoke-ADCCleanCertKeyFiles: Starting"
    Write-Verbose "Trying to login into the Citrix ADC."
    $ADCSession = Connect-ADCHANodes -ManagementURL $ManagementURL -Credential $Credential -PassThru -DisplayConsoleText
    $ADCSessions = @()
    $ADCSessions += $ADCSession["PrimarySession"]
    if ($ADCSession.IsHA) {
        $ADCSessions += $ADCSession["SecondarySession"]
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
                            $Response = Invoke-ADCDeleteSslcertkey -ADCSession $ADCSession["PrimarySession"].Session -certkey $_.certData.certkey -ErrorAction SilentlyContinue | Write-ADCText
                            Write-Verbose "Response: $Response"
                        }
                        if ($_.keyData.certkey -ne $_.certData.certkey) {
                            $RemovableCert | Where-Object { $_.keyData.bound -eq $false } | ForEach-Object {
                                Write-ConsoleText -Line "CertKey"
                                Write-ConsoleText "$($_.keyData.certkey)"
                                Write-ConsoleText -Line "Removing"
                                $Response = Invoke-ADCDeleteSslcertkey -ADCSession $ADCSession["PrimarySession"].Session -certkey $_.keyData.certkey -ErrorAction  SilentlyContinue | Write-ADCText
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
                        $Response = Invoke-ADCDeleteSystemfile -ADCSession $Session.Session -filename $_.fileName -filelocation $_.filelocation | Write-ADCText
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

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCrelNPfMW//qoS
# oCBaHLUVJ0V3cafrV/0v5Cp3c51lgaCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
# i/247uUvWN5TMA0GCSqGSIb3DQEBCwUAMHwxCzAJBgNVBAYTAkdCMRswGQYDVQQI
# ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoT
# D1NlY3RpZ28gTGltaXRlZDEkMCIGA1UEAxMbU2VjdGlnbyBSU0EgQ29kZSBTaWdu
# aW5nIENBMB4XDTIxMDUwNTAwMDAwMFoXDTI0MDUwNDIzNTk1OVowWzELMAkGA1UE
# BhMCTkwxEjAQBgNVBAcMCVZlbGRob3ZlbjEbMBkGA1UECgwSSm9oYW5uZXMgQmls
# bGVrZW5zMRswGQYDVQQDDBJKb2hhbm5lcyBCaWxsZWtlbnMwggEiMA0GCSqGSIb3
# DQEBAQUAA4IBDwAwggEKAoIBAQCsfgRG81keOHalHfCUgxOa1Qy4VNOnGxB8SL8e
# rjP9SfcF13McP7F1HGka5Be495pTZ+duGbaQMNozwg/5Dg9IRJEeBabeSSJJCbZo
# SNpmUu7NNRRfidQxlPC81LxTVHxJ7In0MEfCVm7rWcri28MRCAuafqOfSE+hyb1Z
# /tKyCyQ5RUq3kjs/CF+VfMHsJn6ZT63YqewRkwHuc7UogTTZKjhPJ9prGLTer8UX
# UgvsGRbvhYZXIEuy+bmx/iJ1yRl1kX4nj6gUYzlhemOnlSDD66YOrkLDhXPMXLym
# AN7h0/W5Bo//R5itgvdGBkXkWCKRASnq/9PTcoxW6mwtgU8xAgMBAAGjggGQMIIB
# jDAfBgNVHSMEGDAWgBQO4TqoUzox1Yq+wbutZxoDha00DjAdBgNVHQ4EFgQUZWMy
# gC0i1u2NZ1msk2Mm5nJm5AswDgYDVR0PAQH/BAQDAgeAMAwGA1UdEwEB/wQCMAAw
# EwYDVR0lBAwwCgYIKwYBBQUHAwMwEQYJYIZIAYb4QgEBBAQDAgQQMEoGA1UdIARD
# MEEwNQYMKwYBBAGyMQECAQMCMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
# by5jb20vQ1BTMAgGBmeBDAEEATBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3Js
# LnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDb2RlU2lnbmluZ0NBLmNybDBzBggrBgEF
# BQcBAQRnMGUwPgYIKwYBBQUHMAKGMmh0dHA6Ly9jcnQuc2VjdGlnby5jb20vU2Vj
# dGlnb1JTQUNvZGVTaWduaW5nQ0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2Nz
# cC5zZWN0aWdvLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEARjv9ieRocb1DXRWm3XtY
# jjuSRjlvkoPd9wS6DNfsGlSU42BFd9LCKSyRREZVu8FDq7dN0PhD4bBTT+k6AgrY
# KG6f/8yUponOdxskv850SjN2S2FeVuR20pqActMrpd1+GCylG8mj8RGjdrLQ3QuX
# qYKS68WJ39WWYdVB/8Ftajir5p6sAfwHErLhbJS6WwmYjGI/9SekossvU8mZjZwo
# Gbu+fjZhPc4PhjbEh0ABSsPMfGjQQsg5zLFjg/P+cS6hgYI7qctToo0TexGe32DY
# fFWHrHuBErW2qXEJvzSqM5OtLRD06a4lH5ZkhojhMOX9S8xDs/ArDKgX1j1Xm4Tu
# DjCCBYEwggRpoAMCAQICEDlyRDr5IrdR19NsEN0xNZUwDQYJKoZIhvcNAQEMBQAw
# ezELMAkGA1UEBhMCR0IxGzAZBgNVBAgMEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
# A1UEBwwHU2FsZm9yZDEaMBgGA1UECgwRQ29tb2RvIENBIExpbWl0ZWQxITAfBgNV
# BAMMGEFBQSBDZXJ0aWZpY2F0ZSBTZXJ2aWNlczAeFw0xOTAzMTIwMDAwMDBaFw0y
# ODEyMzEyMzU5NTlaMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEplcnNl
# eTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1Qg
# TmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1
# dGhvcml0eTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAIASZRc2DsPb
# CLPQrFcNdu3NJ9NMrVCDYeKqIE0JLWQJ3M6Jn8w9qez2z8Hc8dOx1ns3KBErR9o5
# xrw6GbRfpr19naNjQrZ28qk7K5H44m/Q7BYgkAk+4uh0yRi0kdRiZNt/owbxiBhq
# kCI8vP4T8IcUe/bkH47U5FHGEWdGCFHLhhRUP7wz/n5snP8WnRi9UY41pqdmyHJn
# 2yFmsdSbeAPAUDrozPDcvJ5M/q8FljUfV1q3/875PbcstvZU3cjnEjpNrkyKt1ya
# tLcgPcp/IjSufjtoZgFE5wFORlObM2D3lL5TN5BzQ/Myw1Pv26r+dE5px2uMYJPe
# xMcM3+EyrsyTO1F4lWeL7j1W/gzQaQ8bD/MlJmszbfduR/pzQ+V+DqVmsSl8MoRj
# VYnEDcGTVDAZE6zTfTen6106bDVc20HXEtqpSQvf2ICKCZNijrVmzyWIzYS4sT+k
# OQ/ZAp7rEkyVfPNrBaleFoPMuGfi6BOdzFuC00yz7Vv/3uVzrCM7LQC/NVV0CUnY
# SVgaf5I25lGSDvMmfRxNF7zJ7EMm0L9BX0CpRET0medXh55QH1dUqD79dGMvsVBl
# CeZYQi5DGky08CVHWfoEHpPUJkZKUIGy3r54t/xnFeHJV4QeD2PW6WK61l9VLupc
# xigIBCU5uA4rqfJMlxwHPw1S9e3vL4IPAgMBAAGjgfIwge8wHwYDVR0jBBgwFoAU
# oBEKIz6W8Qfs4q8p74Klf9AwpLQwHQYDVR0OBBYEFFN5v1qqK0rPVIDh2JvAnfKy
# A2bLMA4GA1UdDwEB/wQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MBEGA1UdIAQKMAgw
# BgYEVR0gADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLmNvbW9kb2NhLmNv
# bS9BQUFDZXJ0aWZpY2F0ZVNlcnZpY2VzLmNybDA0BggrBgEFBQcBAQQoMCYwJAYI
# KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwF
# AAOCAQEAGIdR3HQhPZyK4Ce3M9AuzOzw5steEd4ib5t1jp5y/uTW/qofnJYt7wNK
# fq70jW9yPEM7wD/ruN9cqqnGrvL82O6je0P2hjZ8FODN9Pc//t64tIrwkZb+/UNk
# fv3M0gGhfX34GRnJQisTv1iLuqSiZgR2iJFODIkUzqJNyTKzuugUGrxx8VvwQQuY
# AAoiAxDlDLH5zZI3Ge078eQ6tvlFEyZ1r7uq7z97dzvSxAKRPRkA0xdcOds/exgN
# Rc2ThZYvXd9ZFk8/Ub3VRRg/7UqO6AZhdCMWtQ1QcydER38QXYkqa4UxFMToqWpM
# gLxqeM+4f452cpkMnf7XkQgWoaNflTCCBfUwggPdoAMCAQICEB2iSDBvmyYY0ILg
# ln0z02owDQYJKoZIhvcNAQEMBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpO
# ZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVT
# RVJUUlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmlj
# YXRpb24gQXV0aG9yaXR5MB4XDTE4MTEwMjAwMDAwMFoXDTMwMTIzMTIzNTk1OVow
# fDELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
# A1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSQwIgYDVQQD
# ExtTZWN0aWdvIFJTQSBDb2RlIFNpZ25pbmcgQ0EwggEiMA0GCSqGSIb3DQEBAQUA
# A4IBDwAwggEKAoIBAQCGIo0yhXoYn0nwli9jCB4t3HyfFM/jJrYlZilAhlRGdDFi
# xRDtsocnppnLlTDAVvWkdcapDlBipVGREGrgS2Ku/fD4GKyn/+4uMyD6DBmJqGx7
# rQDDYaHcaWVtH24nlteXUYam9CflfGqLlR5bYNV+1xaSnAAvaPeX7Wpyvjg7Y96P
# v25MQV0SIAhZ6DnNj9LWzwa0VwW2TqE+V2sfmLzEYtYbC43HZhtKn52BxHJAteJf
# 7wtF/6POF6YtVbC3sLxUap28jVZTxvC6eVBJLPcDuf4vZTXyIuosB69G2flGHNyM
# fHEo8/6nxhTdVZFuihEN3wYklX0Pp6F8OtqGNWHTAgMBAAGjggFkMIIBYDAfBgNV
# HSMEGDAWgBRTeb9aqitKz1SA4dibwJ3ysgNmyzAdBgNVHQ4EFgQUDuE6qFM6MdWK
# vsG7rWcaA4WtNA4wDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAw
# HQYDVR0lBBYwFAYIKwYBBQUHAwMGCCsGAQUFBwMIMBEGA1UdIAQKMAgwBgYEVR0g
# ADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNF
# UlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEE
# ajBoMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRy
# dXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVz
# ZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggIBAE1jUO1HNEphpNveaiqMm/EA
# AB4dYns61zLC9rPgY7P7YQCImhttEAcET7646ol4IusPRuzzRl5ARokS9At3Wpwq
# QTr81vTr5/cVlTPDoYMot94v5JT3hTODLUpASL+awk9KsY8k9LOBN9O3ZLCmI2pZ
# aFJCX/8E6+F0ZXkI9amT3mtxQJmWunjxucjiwwgWsatjWsgVgG10Xkp1fqW4w2y1
# z99KeYdcx0BNYzX2MNPPtQoOCwR/oEuuu6Ol0IQAkz5TXTSlADVpbL6fICUQDRn7
# UJBhvjmPeo5N9p8OHv4HURJmgyYZSJXOSsnBf/M6BZv5b9+If8AjntIeQ3pFMcGc
# TanwWbJZGehqjSkEAnd8S0vNcL46slVaeD68u28DECV3FTSK+TbMQ5Lkuk/xYpMo
# JVcp+1EZx6ElQGqEV8aynbG8HArafGd+fS7pKEwYfsR7MUFxmksp7As9V1DSyt39
# ngVR5UR43QHesXWYDVQk/fBO4+L4g71yuss9Ou7wXheSaG3IYfmm8SoKC6W59J7u
# mDIFhZ7r+YMp08Ysfb06dy6LN0KgaoLtO0qqlBCk4Q34F8W2WnkzGJLjtXX4oemO
# CiUe5B7xn1qHI/+fpFGe+zmAEc3btcSnqIBv5VPU4OOiwtJbGvoyJi1qV3AcPKRY
# LqPzW0sH3DJZ84enGm1YMYICQzCCAj8CAQEwgZAwfDELMAkGA1UEBhMCR0IxGzAZ
# BgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
# A1UEChMPU2VjdGlnbyBMaW1pdGVkMSQwIgYDVQQDExtTZWN0aWdvIFJTQSBDb2Rl
# IFNpZ25pbmcgQ0ECECwnTfNkELSL/bju5S9Y3lMwDQYJYIZIAWUDBAIBBQCggYQw
# GAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGC
# NwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQx
# IgQg1abxGdF5YL/M0mvwXZSufv5Q9WaRiQhnKBgiSwRQb1wwDQYJKoZIhvcNAQEB
# BQAEggEAbvH/DnCZ/6qGKAeEIAec5mAcndLANCpgxdqZ40OZIokPg6qIRjtI7dIn
# DGpcSSfqDzjZr3MF5C3Xo7g4BDhJE7ULPVJId8bybK6Kp+QPh+X4IY6IgLpjP3Rv
# B/h1I6rdHNvauSiWqe2q27MTtWPcGLWJgA/lZhFX09gfaLX4Y18/wNzl55dgoLyz
# zeX7p2atKlsR5TunVI2uOntwlnFedJJjXj8kJFBhsQFs9w3HjFFi1Y4f/aeC28ne
# iGVU23WWZdNIJtHzUh1SDcv00sp5q3kzeRuXjg7z9SITFlHSY0TeIEs/DLDso9rT
# muecl08skcyArRsoG7pht6T1QVFTmQ==
# SIG # End signature block
