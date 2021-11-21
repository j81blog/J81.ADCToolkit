function Invoke-ADCGetQosStats {
    <#
    .SYNOPSIS
        Get Qos statistics object(s).
    .DESCRIPTION
        Statistics for qos.
    .PARAMETER Name 
        . 
    .PARAMETER Clearstats 
        Clear the statsistics / counters. 
        Possible values = basic, full 
    .PARAMETER GetAll 
        Retrieve all qos object(s).
    .PARAMETER Count
        If specified, the count of the qos object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetQosStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetQosStats -GetAll 
        Get all qos data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetQosStats -name <string>
        Get qos object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetQosStats -Filter @{ 'name'='<value>' }
        Get qos data with a filter.
    .NOTES
        File Name : Invoke-ADCGetQosStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/qos/qos/
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

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Name,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('basic', 'full')]
        [string]$Clearstats,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetQosStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all qos objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type qos -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for qos objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type qos -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving qos objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('name') ) { $arguments.Add('name', $name) } 
                if ( $PSBoundParameters.ContainsKey('detail') ) { $arguments.Add('detail', $detail) } 
                if ( $PSBoundParameters.ContainsKey('fullvalues') ) { $arguments.Add('fullvalues', $fullvalues) } 
                if ( $PSBoundParameters.ContainsKey('ntimes') ) { $arguments.Add('ntimes', $ntimes) } 
                if ( $PSBoundParameters.ContainsKey('logfile') ) { $arguments.Add('logfile', $logfile) } 
                if ( $PSBoundParameters.ContainsKey('clearstats') ) { $arguments.Add('clearstats', $clearstats) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type qos -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving qos configuration for property ''"

            } else {
                Write-Verbose "Retrieving qos configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type qos -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetQosStats: Ended"
    }
}


