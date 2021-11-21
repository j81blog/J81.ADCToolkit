function Invoke-ADCGetLbvserverStats {
    <#
    .SYNOPSIS
        Get Load Balancing statistics object(s).
    .DESCRIPTION
        Statistics for Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name of the virtual server. If no name is provided, statistical data of all configured virtual servers is displayed. 
    .PARAMETER GetAll 
        Retrieve all lbvserver object(s).
    .PARAMETER Count
        If specified, the count of the lbvserver object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLbvserverStats -GetAll 
        Get all lbvserver data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverStats -name <string>
        Get lbvserver object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLbvserverStats -Filter @{ 'name'='<value>' }
        Get lbvserver data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLbvserverStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/lb/lbvserver/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLbvserverStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lbvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lbvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lbvserver objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lbvserver configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lbvserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lbvserver -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLbvserverStats: Ended"
    }
}


