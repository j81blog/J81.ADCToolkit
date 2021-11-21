function Get-ADCSession {
    <#
    .SYNOPSIS
        Verify and retrieve an active session variable
    .DESCRIPTION
        Verify and retrieve an active session variable
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER Credential
        Credential object
    .EXAMPLE
        Get-ADCSession
    .NOTES
        File Name : Get-ADCSession
        Version   : v2111.1816
        Author    : John Billekens
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding()]
    param(
        $ADCSession = $Script:ADCSession
    )
    Write-Verbose "Get-ADCSession: Starting"
    $IsActive = $false
    if ($null -eq $ADCSession -and ([String]::IsNullOrEmpty($ADCSession)) -and (-Not ( ($ADCSession -eq [PSObject]) -or ($ADCSession -eq [PSCustomObject]))) ) {
        $IsActive = $false
    } elseif ( ($null -ne $ADCSession.SessionExpiration ) -and ($ADCSession.SessionExpiration -is [datetime]) -and ($ADCSession.SessionExpiration -le (Get-Date)) ) {
        $IsActive = $false
        $ADCSession.IsConnected = $false
        $Script:ADCSession = $ADCSession
    } elseif ($ADCSession.IsConnected -and ($ADCSession.SessionExpiration -gt (Get-Date).AddSeconds(120))) {
        $IsActive = $true
    }
    $ManagementURL = ""
    $MessageText = ". E.g. https://citrixacd.domain.local"
    #Assign parameter credential
    if (-Not $IsActive) {
        try {
            #Check if the ADCSession variable contains a hostname
            if ($null -ne $ADCSession -and (-Not [String]::IsNullOrEmpty(($ADCSession.ManagementURL.ToString())))) {
                $ManagementURL = $ADCSession.ManagementURL.ToString().TrimEnd('/')
                $MessageText = ": $ManagementURL"
            }
        } finally { }
        try {
            if ([String]::IsNullOrEmpty($ManagementURL)) {
                $ManagementURL = Get-Variable -Name ManagementURL -Scope Script -ValueOnly -ErrorAction SilentlyContinue
                $MessageText = ": $ManagementURL"
            }
        } finally { }
        try {
            if ([String]::IsNullOrEmpty($ManagementURL)) {
                $ManagementURL = Get-Variable -Name ManagementURL -Scope Global -ValueOnly -ErrorAction SilentlyContinue
                $MessageText = ": $ManagementURL"
            }
        } finally { }
        $ADCCredential = $Credential
        try {
            #Test if Parameter ADCCredential is a valid credential
            if (([String]::IsNullOrEmpty($ADCCredential)) -or ($ADCCredential -eq [System.Management.Automation.PSCredential]::Empty)) {
                #Get (if it exists) the Script ADCCredential variable for the ADC Credential
                $ADCCredential = Get-Variable -Name ADCCredential -Scope Script -ValueOnly -ErrorAction SilentlyContinue
            }
        } finally { }
        try {
            #Test if Script ADCCredential is a valid credential
            if (([String]::IsNullOrEmpty($ADCCredential)) -or ($ADCCredential -eq [System.Management.Automation.PSCredential]::Empty)) {
                #Get (if it exists) the Global ADCCredential variable for the ADC Credential
                $ADCCredential = Get-Variable -Name ADCCredential -Scope Global -ValueOnly -ErrorAction SilentlyContinue
            }
        } finally { }
        #If no ManagementURL is available then request a URL
        try {
            if ([String]::IsNullOrEmpty($ManagementURL)) {
                $ManagementURL = $(Read-Host -Prompt "Enter the Citrix ADC Management URL$($MessageText)") 
            }
        } finally { }
        try {
            #Test if Global ADCCredential is a valid credential
            if (([String]::IsNullOrEmpty($ADCCredential)) -or ($ADCCredential -eq [System.Management.Automation.PSCredential]::Empty)) {
                #No valid credential was found, requesting credential.
                $ADCCredential = (Get-Credential -Message "Enter username and password for the Citrix ADC`r`nE.g. nsroot / P@ssw0rd" )
            }
        } finally { }
        try {
            $ADCSession = Connect-ADCNode -ManagementURL $ManagementURL -Credential $ADCCredential -PassThru
        } finally { }
    }
    if ([String]::IsNullOrEmpty($ADCSession) -and [String]::IsNullOrEmpty($(Get-Variable -Scope Script -ErrorAction SilentlyContinue | Where-Object Name -EQ "ADCSession"))) {
        $ADCSession = Connect-ADCNode -ManagementURL $(Read-Host -Prompt "Enter the Citrix ADC Management URL$($MessageText)") -Credential (Get-Credential) -PassThru
    }
    if ([String]::IsNullOrEmpty($ADCSession) -or (-Not $ADCSession.IsConnected)) {
        throw "Connect to the Citrix ADC Appliance first!"
    } else {
        Write-Verbose "Active Session found, returning Session data"
        Write-Output $ADCSession
    }
    Write-Verbose "Get-ADCSession: Finished"
}
