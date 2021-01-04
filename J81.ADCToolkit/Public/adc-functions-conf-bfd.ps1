function Invoke-ADCGetBfdsession {
<#
    .SYNOPSIS
        Get Bfd configuration object(s)
    .DESCRIPTION
        Get Bfd configuration object(s)
    .PARAMETER localip 
       IPV4 or IPV6 Address of Local Node. 
    .PARAMETER remoteip 
       IPV4 or IPV6 Address of Remote Node. 
    .PARAMETER GetAll 
        Retreive all bfdsession object(s)
    .PARAMETER Count
        If specified, the count of the bfdsession object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBfdsession
    .EXAMPLE 
        Invoke-ADCGetBfdsession -GetAll 
    .EXAMPLE 
        Invoke-ADCGetBfdsession -Count
    .EXAMPLE
        Invoke-ADCGetBfdsession -name <string>
    .EXAMPLE
        Invoke-ADCGetBfdsession -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBfdsession
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bfd/bfdsession/
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

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$localip ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$remoteip,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetBfdsession: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all bfdsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type bfdsession -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for bfdsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type bfdsession -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving bfdsession objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('localip')) { $Arguments.Add('localip', $localip) } 
                if ($PSBoundParameters.ContainsKey('remoteip')) { $Arguments.Add('remoteip', $remoteip) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type bfdsession -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving bfdsession configuration for property ''"

            } else {
                Write-Verbose "Retrieving bfdsession configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type bfdsession -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBfdsession: Ended"
    }
}


