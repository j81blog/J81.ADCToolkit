function Connect-ADCHANodes {
    <#
    .SYNOPSIS
        Establish a session with (all) Citrix ADCs in a HA configuration
    .DESCRIPTION
        Establish a session with (all) Citrix ADCs in a HA configuration
    .PARAMETER ManagementURL
        The URL to connect to, E.g. "https://citrixadc.domain.local"
    .PARAMETER Credential
        The credential to authenticate to the ADC with
    .PARAMETER Timeout
        Timeout in seconds for session object
    .PARAMETER DisplayConsoleText
        The command will display text during each step when specified
    .PARAMETER PassThru
        Return the ADC session object
    .EXAMPLE
        PS C:\>Connect-ADCHANode -ManagementURL https://citrixacd.domain.local -Credential (Get-Credential)
        Connect to the ADC  nodes with specified management url and credential
    .NOTES
        File Name : Connect-ADCHANodes
        Version   : v2204.1122
        Author    : John Billekens
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding()]
    param (
        [ValidatePattern('^(https?:[\/]{2}.*)$', Options = 'None')]
        [ValidateNotNullOrEmpty()]
        [System.Uri]$ManagementURL = (Read-Host -Prompt "Enter the Citrix ADC Management URL. E.g. https://citrixacd.domain.local"),
    
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]$Credential = (Get-Credential -Message "Enter username and password for the Citrix ADC`r`nE.g. nsroot / P@ssw0rd" ),
        
        [Switch]$DisplayConsoleText,
        
        [int]$Timeout = 900,

        [switch]$PassThru
    )
    
    begin {
        Write-Verbose "Connect-ADCHANodes: Starting"
        $NoConsoleOutput = (-Not $DisplayConsoleText.ToBool())
        if (-Not (Get-Command 'Write-ConsoleText' -ErrorAction SilentlyContinue)) {
            #Create mock function so script won't generate issues
            function Write-ConsoleText { }
        }
    }
    
    process {
        Write-Verbose "Trying to login into the Citrix ADC."
        Write-ConsoleText -Title "ADC Connection" -NoConsoleOutput:$NoConsoleOutput
        Write-ConsoleText -Line "Connecting" -NoConsoleOutput:$NoConsoleOutput
        try {
            Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*" -NoConsoleOutput:$NoConsoleOutput
            $ADCHASession = Connect-ADCNode -ManagementURL $ManagementURL -Credential $Credential -Timeout $Timeout -PassThru -ErrorAction Stop
            $IsConnected = $true
            Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*" -NoConsoleOutput:$NoConsoleOutput
            $HANode = Invoke-ADCGetHanode -ADCSession $ADCHASession | Expand-ADCResult
            $nsconfig = Invoke-ADCGetNsconfig -ADCSession $ADCHASession | Expand-ADCResult
            if ($nsconfig.ipaddress -ne $nsconfig.primaryip) {
                Write-Warning "You are connected to a secondary node (Primary node is $($nsconfig.primaryip))"
            }
            $NodeState = $nsconfig.systemtype
            if ($NodeState -like "Stand-alone") {
                Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*" -NoConsoleOutput:$NoConsoleOutput
                if ($ADCHASession.ContainsKey("IsStandalone")) { $ADCHASession["IsStandalone"] = $true } else { $ADCHASession.Add("IsStandalone", $true) }
                if ($ADCHASession.ContainsKey("IsHA")) { $ADCHASession["IsHA"] = $false } else { $ADCHASession.Add("IsHA", $false) }
                try {
                    $PrimaryURL = [System.URI]"$($ManagementURL.Scheme):\\$($nsconfig.ipaddress)"
                    $PrimarySessionDetails = Connect-ADCNode -ManagementURL $PrimaryURL -Credential $Credential -Timeout $Timeout -PassThru -ErrorAction Stop
                    $PriNode = $HANode | Where-Object { $_.ipaddress -eq $nsconfig.ipaddress }
                } catch {
                    $PrimarySessionDetails = $ADCSession.psobject.copy()
                }
                $PrimarySession = @{
                    ID      = 0
                    State   = "Primary"
                    Session = $PrimarySessionDetails.psobject.copy()
                }
                $ADCHASession = $PrimarySessionDetails.psobject.copy()
                if ($ADCHASession.ContainsKey("PrimarySession")) { $ADCHASession["PrimarySession"] = $ADCHASession } else { $ADCHASession.Add("PrimarySession", $PrimarySession) }
                Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*" -NoConsoleOutput:$NoConsoleOutput
            } elseif ($NodeState -like "HA") {
                Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*" -NoConsoleOutput:$NoConsoleOutput
                try {
                    $PriNode = $HANode | Where-Object { $_.state -like "Primary" }
                    $PrimaryIP = $PriNode.ipaddress
                    $PrimaryURL = [System.URI]"$($ManagementURL.Scheme):\\$PrimaryIP"
                    Write-Verbose "Connecting to Primary node $($PrimaryURL)"
                    $PrimarySessionDetails = Connect-ADCNode -ManagementURL $PrimaryURL -Credential $Credential -Timeout $Timeout -PassThru -ErrorAction Stop
                    Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*" -NoConsoleOutput:$NoConsoleOutput
                } catch {
                    $PrimarySessionDetails = $ADCSession.psobject.copy()
                }
                $PrimarySession = @{
                    ID      = $PriNode.id
                    State   = $PriNode.state
                    Session = $PrimarySessionDetails.psobject.copy()
                }
                $ADCHASession = $PrimarySessionDetails.psobject.copy()
                if ($ADCHASession.ContainsKey("PrimarySession")) { $ADCHASession["PrimarySession"] = $PrimarySession } else { $ADCHASession.Add("PrimarySession", $PrimarySession) }
                Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*" -NoConsoleOutput:$NoConsoleOutput
                try {
                    $SecNode = $HANode | Where-Object { $_.state -like "Secondary" }
                    if ([String]::IsNullOrEmpty($SecNode)) {
                        $SecNode = $HANode | Where-Object { $_.ipaddress -ne $PriNode.ipaddress }
                    }
                    $SecondaryIP = $SecNode.ipaddress
                    $SecondaryURL = [System.URI]"$($ManagementURL.Scheme):\\$SecondaryIP"
                    Write-Verbose "Connecting to Secondary node $($SecondaryURL)"
                    $SecondarySessionDetails = Connect-ADCNode -ManagementURL $SecondaryURL -Credential $Credential -Timeout $Timeout -PassThru -ErrorAction Stop
                    Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*" -NoConsoleOutput:$NoConsoleOutput
                    $SecondarySession = @{
                        ID      = $SecNode.id
                        State   = $SecNode.state
                        Session = $SecondarySessionDetails.psobject.copy()
                    }
                    if ($ADCHASession.ContainsKey("SecondarySession")) { $ADCHASession["SecondarySession"] = $SecondarySession } else { $ADCHASession.Add("SecondarySession", $SecondarySession) }
                    if ($ADCHASession.ContainsKey("IsStandalone")) { $ADCHASession["IsStandalone"] = $false } else { $ADCHASession.Add("IsStandalone", $false) }
                    if ($ADCHASession.ContainsKey("IsHA")) { $ADCHASession["IsHA"] = $true } else { $ADCHASession.Add("IsHA", $true) }
                } catch {
                    Write-Verbose "Error, $($_.Exception.Message)"
                    $SecondarySessionDetails = $null
                    if ($ADCHASession.ContainsKey("SecondarySession")) { $ADCHASession["SecondarySession"] = $null } else { $ADCHASession.Add("SecondarySession", $null) }
                }
            }
            Write-ConsoleText -ForeGroundColor Green " Connected" -NoConsoleOutput:$NoConsoleOutput
        } catch {
            Write-Verbose "Caught an error: $_.Exception.Message"
            Write-ConsoleText -ForeGroundColor Red "  ERROR, Could not connect" -PostBlank -NoConsoleOutput:$NoConsoleOutput
            $IsConnected = $false
        }
        if ($IsConnected) {
            Write-Verbose "IsConnected: $IsConnected"
            Write-ConsoleText -Title "ADC Info" -NoConsoleOutput:$NoConsoleOutput
            Write-ConsoleText -Line "Username" -NoConsoleOutput:$NoConsoleOutput
            Write-ConsoleText -ForeGroundColor Cyan "$($PrimarySessionDetails.Username)" -NoConsoleOutput:$NoConsoleOutput
            Write-ConsoleText -Line "Password" -NoConsoleOutput:$NoConsoleOutput
            Write-ConsoleText -ForeGroundColor Cyan "**********" -NoConsoleOutput:$NoConsoleOutput
            Write-ConsoleText -Line "Configuration" -NoConsoleOutput:$NoConsoleOutput
            Write-ConsoleText -ForeGroundColor Cyan "$NodeState" -NoConsoleOutput:$NoConsoleOutput
            Write-ConsoleText -Line "Node" -NoConsoleOutput:$NoConsoleOutput
            Write-ConsoleText -ForeGroundColor Cyan "$($PriNode.state)" -NoConsoleOutput:$NoConsoleOutput
            Write-ConsoleText -Line "URL" -NoConsoleOutput:$NoConsoleOutput
            Write-ConsoleText -ForeGroundColor Cyan "$($PrimaryURL.OriginalString)" -NoConsoleOutput:$NoConsoleOutput
            Write-ConsoleText -Line "Version" -NoConsoleOutput:$NoConsoleOutput
            Write-ConsoleText -ForeGroundColor Cyan "$($PrimarySessionDetails.Version)" -NoConsoleOutput:$NoConsoleOutput
            if ((-Not [String]::IsNullOrEmpty($SecondarySessionDetails)) -Or ($SecNode.state -eq "UNKNOWN")) {
                Write-ConsoleText -Line "Node" -NoConsoleOutput:$NoConsoleOutput
                Write-ConsoleText -ForeGroundColor Cyan "$($SecNode.state)" -NoConsoleOutput:$NoConsoleOutput
                Write-ConsoleText -Line "URL" -NoConsoleOutput:$NoConsoleOutput
                Write-ConsoleText -ForeGroundColor Cyan "$($SecondaryURL.OriginalString)" -NoConsoleOutput:$NoConsoleOutput
                Write-ConsoleText -Line "Version" -NoConsoleOutput:$NoConsoleOutput
                Write-ConsoleText -ForeGroundColor Cyan "$($SecondarySessionDetails.Version)" -NoConsoleOutput:$NoConsoleOutput
            }
            Write-Verbose "All done, validating version."
            if ($(ConvertFrom-ADCVersion -ADCSession $PrimarySessionDetails) -lt [System.Version]"11.0") {
                Throw "Only ADC version 13 and up is supported, version 11.x & 12.x is best effort."
            }
        } else {
            $ADCHASession = $null
        }
        $Script:ADCLastSession = [PSObject]$PrimarySessionDetails.PSObject.Copy()
        Write-Output $ADCHASession
    }
    end {
        Write-Verbose "Connect-ADCHANodes: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAByW7hXuWTPcr4
# v1Chk8NqE6AABnjx6F9Ezsuy/hjjG6CCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQg5bfUU3JIMLrzepPFUdez8+fr2NIO9tOTS3qd+iU246cwDQYJKoZIhvcNAQEB
# BQAEggEABVXALTjf2TGaf37eF42CJDAFqkXf74df90T+enFtw0DVXKLwV9r8RQvB
# 6R/54XP8N7aFosKaa1TwiOR1h5iu17StBOICP0aSdODNFpJifgeWYxk4sXJRjgp7
# Fizj3aJhzy3Vu9FwwM+PElwEOqrbklg4COvkZcLtqIlkUAf8WMdTKAyDt+UQbD96
# XeFBWj1L2PH9K3H7nYAOTQioG6wUTGizXPqdPQnqd/9SkBJ3eWqEuF6HljU1+OXt
# 9kEMrtzyCSAc47QdIdVdfgOACsxLmYD0Qx4cR1Dh9286TdNrzMB15xHwt38vYXF+
# Md5/sRP5nElPs7W7KMEpROMfoD12bw==
# SIG # End signature block
