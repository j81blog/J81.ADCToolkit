function Invoke-ADCGetHANode {
    <#
        .SYNOPSIS
            Get HA Node Info
        .DESCRIPTION
            Get HA Node Info
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Filter
            Specify a filter
            -Filter @{"Ipaddress"="10.254.0.11";"State"="Primary"}
        .PARAMETER Summary
            If specified a subset of info will be returned
        .EXAMPLE
            Invoke-ADCGetHANode -Summary
        .NOTES
            File Name : Invoke-ADCGetHANode
            Version   : v0.1
            Author    : John Billekens
            Requires  : PowerShell v5.1 and up
                        ADC 11.x and up
        .LINK
            https://blog.j81.nl
        #>
    [cmdletbinding()]
    param(
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
            
        #
        [Parameter(ParameterSetName = 'Filter')]
        [hashtable]$Filter = @{ },
    
        [Switch]$Summary
    )
    try {
        Write-Verbose "$($ADCSession | ConvertTo-json -compress)"
        $response = Invoke-ADCNitroApi -Session $ADCSession -Method GET -Type hanode -Filter $Filter -Summary:$Summary
    } catch {
        Write-Verbose "ERROR: $($_.Exception.Message)"
        $response = $null
    }
    return $response
}