function Invoke-ADCGetBfdsession {
    <#
    .SYNOPSIS
        Get Bfd configuration object(s).
    .DESCRIPTION
        Configuration for BFD configuration resource.
    .PARAMETER Localip 
        IPV4 or IPV6 Address of Local Node. 
    .PARAMETER Remoteip 
        IPV4 or IPV6 Address of Remote Node. 
    .PARAMETER GetAll 
        Retrieve all bfdsession object(s).
    .PARAMETER Count
        If specified, the count of the bfdsession object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBfdsession
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBfdsession -GetAll 
        Get all bfdsession data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBfdsession -Count 
        Get the number of bfdsession objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBfdsession -name <string>
        Get bfdsession object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBfdsession -Filter @{ 'name'='<value>' }
        Get bfdsession data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBfdsession
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bfd/bfdsession/
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
        [string]$Localip,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Remoteip,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all bfdsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type bfdsession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for bfdsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type bfdsession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving bfdsession objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('localip') ) { $arguments.Add('localip', $localip) } 
                if ( $PSBoundParameters.ContainsKey('remoteip') ) { $arguments.Add('remoteip', $remoteip) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type bfdsession -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving bfdsession configuration for property ''"

            } else {
                Write-Verbose "Retrieving bfdsession configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type bfdsession -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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


