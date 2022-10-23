function Invoke-ADCGetStreamidentifierStats {
    <#
    .SYNOPSIS
        Get Stream statistics object(s).
    .DESCRIPTION
        Statistics for identifier resource.
    .PARAMETER Name 
        Name of the stream identifier. 
    .PARAMETER GetAll 
        Retrieve all streamidentifier object(s).
    .PARAMETER Count
        If specified, the count of the streamidentifier object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetStreamidentifierStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetStreamidentifierStats -GetAll 
        Get all streamidentifier data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetStreamidentifierStats -name <string>
        Get streamidentifier object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetStreamidentifierStats -Filter @{ 'name'='<value>' }
        Get streamidentifier data with a filter.
    .NOTES
        File Name : Invoke-ADCGetStreamidentifierStats
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/stream/streamidentifier/
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
        Write-Verbose "Invoke-ADCGetStreamidentifierStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all streamidentifier objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for streamidentifier objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving streamidentifier objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving streamidentifier configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving streamidentifier configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetStreamidentifierStats: Ended"
    }
}


