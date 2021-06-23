function Invoke-ADCGetLldpStats {
<#
    .SYNOPSIS
        Get LLDP statistics object(s)
    .DESCRIPTION
        Get LLDP statistics object(s)
    .PARAMETER ifnum 
       LLDP Statistics per interfaces. 
    .PARAMETER GetAll 
        Retreive all lldp object(s)
    .PARAMETER Count
        If specified, the count of the lldp object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLldpStats
    .EXAMPLE 
        Invoke-ADCGetLldpStats -GetAll
    .EXAMPLE
        Invoke-ADCGetLldpStats -name <string>
    .EXAMPLE
        Invoke-ADCGetLldpStats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLldpStats
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/lldp/lldp/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(DefaultParameterSetName = "Getall")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [string]$ifnum,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLldpStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lldp objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldp -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lldp objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldp -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lldp objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldp -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lldp configuration for property 'ifnum'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldp -NitroPath nitro/v1/stat -Resource $ifnum -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lldp configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldp -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLldpStats: Ended"
    }
}


