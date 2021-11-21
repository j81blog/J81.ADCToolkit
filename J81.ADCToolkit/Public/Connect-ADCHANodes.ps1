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
        Connect-ADCNode -ManagementURL https://citrixacd.domain.local -Credential (Get-Credential)
    .NOTES
        File Name : Connect-ADCHANodes
        Version   : v2111.1520
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
            $ADCSession = Connect-ADCNode -ManagementURL $ManagementURL -Credential $Credential -Timeout $Timeout -PassThru -ErrorAction Stop
            $IsConnected = $true
            Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*" -NoConsoleOutput:$NoConsoleOutput
            $HANode = Invoke-ADCGetHanode | Expand-ADCResult
            $nsconfig = Invoke-ADCGetNsconfig | Expand-ADCResult
            if ($nsconfig.ipaddress -ne $nsconfig.primaryip) {
                Write-Warning "You are connected to a secondary node (Primary node is $($nsconfig.primaryip))"
            }
            $NodeState = $nsconfig.systemtype
            if ($NodeState -like "Stand-alone") {
                Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*" -NoConsoleOutput:$NoConsoleOutput
                if ($ADCSession.ContainsKey("IsStandalone")) { $ADCSession["IsStandalone"] = $true } else { $ADCSession.Add("IsStandalone", $true) }
                if ($ADCSession.ContainsKey("IsHA")) { $ADCSession["IsHA"] = $false } else { $ADCSession.Add("IsHA", $false) }
                try {
                    $PrimaryURL = [System.URI]"$($ManagementURL.Scheme):\\$($nsconfig.ipaddress)"
                    $PrimarySessionDetails = Connect-ADCNode -ManagementURL $PrimaryURL -Credential $Credential -Timeout $Timeout -PassThru -ErrorAction Stop
                    $PriNode = $HANode | Where-Object { $_.ipaddress -eq $nsconfig.ipaddress }
                } catch {
                    $PrimarySessionDetails = $ADCSession
                }
                $PrimarySession = @{
                    ID      = 0
                    State   = "Primary"
                    Session = $PrimarySessionDetails
                }
                if ($ADCSession.ContainsKey("PrimarySession")) { $ADCSession["PrimarySession"] = $PrimarySession } else { $ADCSession.Add("PrimarySession", $PrimarySession) }
                Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*" -NoConsoleOutput:$NoConsoleOutput
            } elseif ($NodeState -like "HA") {
                Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*" -NoConsoleOutput:$NoConsoleOutput
                try {
                    $PriNode = $HANode | Where-Object { $_.state -like "Primary" }
                    $PrimaryIP = $PriNode.ipaddress
                    $PrimaryURL = [System.URI]"$($ManagementURL.Scheme):\\$PrimaryIP"
                    $PrimarySessionDetails = Connect-ADCNode -ManagementURL $PrimaryURL -Credential $Credential -Timeout $Timeout -PassThru -ErrorAction Stop
                    if ($ADCSession.ContainsKey("PrimarySession")) { $ADCSession["PrimarySession"] = $PriSession } else { $ADCSession.Add("PrimarySession", $PrimarySessionDetails) }
                    Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*" -NoConsoleOutput:$NoConsoleOutput
                } catch {
                    $PrimarySessionDetails = $ADCSession
                }
                $PrimarySession = @{
                    ID      = $PriNode.id
                    State   = $PriNode.state
                    Session = $PrimarySessionDetails
                }
                if ($ADCSession.ContainsKey("PrimarySession")) { $ADCSession["PrimarySession"] = $PrimarySession } else { $ADCSession.Add("PrimarySession", $PrimarySession) }
                Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*" -NoConsoleOutput:$NoConsoleOutput
                try {
                    $SecNode = $HANode | Where-Object { $_.state -like "Secondary" }
                    if ([String]::IsNullOrEmpty($SecNode)) {
                        $SecNode = $HANode | Where-Object { $_.ipaddress -ne $PriNode.ipaddress }
                    }
                    $SecondaryIP = $SecNode.ipaddress
                    $SecondaryURL = [System.URI]"$($ManagementURL.Scheme):\\$SecondaryIP"
                    $SecondarySessionDetails = Connect-ADCNode -ManagementURL $SecondaryURL -Credential $Credential -Timeout $Timeout -PassThru -ErrorAction Stop
                    
                    Write-ConsoleText -ForeGroundColor Yellow -NoNewLine "*" -NoConsoleOutput:$NoConsoleOutput
                    $SecondarySession = @{
                        ID      = $PriNode.id
                        State   = $PriNode.state
                        Session = $SecondarySessionDetails
                    }
                    if ($ADCSession.ContainsKey("SecondarySession")) { $ADCSession["SecondarySession"] = $SecondarySession } else { $ADCSession.Add("SecondarySession", $SecondarySession) }
                    if ($ADCSession.ContainsKey("IsStandalone")) { $ADCSession["IsStandalone"] = $false } else { $ADCSession.Add("IsStandalone", $false) }
                    if ($ADCSession.ContainsKey("IsHA")) { $ADCSession["IsHA"] = $true } else { $ADCSession.Add("IsHA", $true) }
                } catch {
                    Write-Verbose "Error, $($_.Exception.Message)"
                    $SecondarySessionDetails = $null
                    if ($ADCSession.ContainsKey("SecondarySession")) { $ADCSession["SecondarySession"] = $null } else { $ADCSession.Add("SecondarySession", $null) }
                }
            }
            Write-ConsoleText -ForeGroundColor Green " Connected" -NoConsoleOutput:$NoConsoleOutput
        } catch {
            Write-Verbose "Caught an error: $_.Exception.Message"
            Write-ConsoleText -ForeGroundColor Red "  ERROR, Could not connect" -PostBlank -NoConsoleOutput:$NoConsoleOutput
            $IsConnected = $false
        }
        if ($IsConnected) {
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
            if ($($PrimarySessionDetails | ConvertFrom-ADCVersion) -lt [System.Version]"11.0") {
                Throw "Only ADC version 13 and up is supported, version 11.x & 12.x is best effort."
            }
        } else {
            $ADCSession = $null
        }
        Write-Output $ADCSession
    }
    end {
        Write-Verbose "Connect-ADCHANodes: Ended"
    }
}