function Invoke-ADCGetRewritepolicyStats {
    <#
    .SYNOPSIS
        Get Rewrite statistics object(s).
    .DESCRIPTION
        Statistics for rewrite policy resource.
    .PARAMETER Name 
        Name of the rewrite policy. 
    .PARAMETER GetAll 
        Retrieve all rewritepolicy object(s).
    .PARAMETER Count
        If specified, the count of the rewritepolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicyStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicyStats -GetAll 
        Get all rewritepolicy data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicyStats -name <string>
        Get rewritepolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicyStats -Filter @{ 'name'='<value>' }
        Get rewritepolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRewritepolicyStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/rewrite/rewritepolicy/
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
        Write-Verbose "Invoke-ADCGetRewritepolicyStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all rewritepolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rewritepolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rewritepolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rewritepolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rewritepolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRewritepolicyStats: Ended"
    }
}

function Invoke-ADCGetRewritepolicylabelStats {
    <#
    .SYNOPSIS
        Get Rewrite statistics object(s).
    .DESCRIPTION
        Statistics for rewrite policy label resource.
    .PARAMETER Labelname 
        Name of the rewrite policy label. 
    .PARAMETER GetAll 
        Retrieve all rewritepolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the rewritepolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicylabelStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicylabelStats -GetAll 
        Get all rewritepolicylabel data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicylabelStats -name <string>
        Get rewritepolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicylabelStats -Filter @{ 'name'='<value>' }
        Get rewritepolicylabel data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRewritepolicylabelStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/rewrite/rewritepolicylabel/
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
        [string]$Labelname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetRewritepolicylabelStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all rewritepolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rewritepolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rewritepolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rewritepolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel -NitroPath nitro/v1/stat -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rewritepolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRewritepolicylabelStats: Ended"
    }
}


