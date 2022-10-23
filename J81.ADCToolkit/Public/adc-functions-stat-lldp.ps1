function Invoke-ADCGetLldpStats {
    <#
    .SYNOPSIS
        Get LLDP statistics object(s).
    .DESCRIPTION
        Statistics for lldp.
    .PARAMETER Ifnum 
        LLDP Statistics per interfaces. 
    .PARAMETER GetAll 
        Retrieve all lldp object(s).
    .PARAMETER Count
        If specified, the count of the lldp object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLldpStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLldpStats -GetAll 
        Get all lldp data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLldpStats -name <string>
        Get lldp object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLldpStats -Filter @{ 'name'='<value>' }
        Get lldp data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLldpStats
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/lldp/lldp/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [string]$Ifnum,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLldpStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lldp objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldp -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lldp objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldp -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lldp objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldp -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lldp configuration for property 'ifnum'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldp -NitroPath nitro/v1/stat -Resource $ifnum -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lldp configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldp -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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


