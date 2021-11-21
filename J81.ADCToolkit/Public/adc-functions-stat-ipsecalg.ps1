function Invoke-ADCGetIpsecalgcountersStats {
    <#
    .SYNOPSIS
        Get Ipsecalg statistics object(s).
    .DESCRIPTION
        Statistics for counters resource.
    .PARAMETER Name 
        Name of IPSec ALG Profile. 
    .PARAMETER GetAll 
        Retrieve all ipsecalgcounters object(s).
    .PARAMETER Count
        If specified, the count of the ipsecalgcounters object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIpsecalgcountersStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIpsecalgcountersStats -GetAll 
        Get all ipsecalgcounters data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIpsecalgcountersStats -name <string>
        Get ipsecalgcounters object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIpsecalgcountersStats -Filter @{ 'name'='<value>' }
        Get ipsecalgcounters data with a filter.
    .NOTES
        File Name : Invoke-ADCGetIpsecalgcountersStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ipsecalg/ipsecalgcounters/
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
        [ValidateLength(1, 32)]
        [string]$Name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetIpsecalgcountersStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all ipsecalgcounters objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgcounters -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ipsecalgcounters objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgcounters -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ipsecalgcounters objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgcounters -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ipsecalgcounters configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgcounters -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving ipsecalgcounters configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgcounters -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetIpsecalgcountersStats: Ended"
    }
}


