function Invoke-ADCGetPqbinding {
<#
    .SYNOPSIS
        Get Priority Queuing configuration object(s)
    .DESCRIPTION
        Get Priority Queuing configuration object(s)
    .PARAMETER vservername 
       Name of the load balancing virtual server for which to display the priority queuing policy. 
    .PARAMETER GetAll 
        Retreive all pqbinding object(s)
    .PARAMETER Count
        If specified, the count of the pqbinding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPqbinding
    .EXAMPLE 
        Invoke-ADCGetPqbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetPqbinding -Count
    .EXAMPLE
        Invoke-ADCGetPqbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetPqbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPqbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pq/pqbinding/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$vservername,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetPqbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all pqbinding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pqbinding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for pqbinding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pqbinding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving pqbinding objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('vservername')) { $Arguments.Add('vservername', $vservername) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pqbinding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving pqbinding configuration for property ''"

            } else {
                Write-Verbose "Retrieving pqbinding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pqbinding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPqbinding: Ended"
    }
}

function Invoke-ADCAddPqpolicy {
<#
    .SYNOPSIS
        Add Priority Queuing configuration Object
    .DESCRIPTION
        Add Priority Queuing configuration Object 
    .PARAMETER policyname 
        Name for the priority queuing policy. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters.  
        Minimum length = 1 
    .PARAMETER rule 
        Expression or name of a named expression, against which the request is evaluated. The priority queuing policy is applied if the rule evaluates to true.  
        Note:  
        * On the command line interface, if the expression includes blank spaces, the entire expression must be enclosed in double quotation marks.  
        * If the expression itself includes double quotation marks, you must escape the quotations by using the \ character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you will not have to escape the double quotation marks.  
        * Maximum length of a string literal in the expression is 255 characters. A longer string can be split into smaller strings of up to 255 characters each, and the smaller strings concatenated with the + operator. For example, you can create a 500-character string as follows: '"<string of 255 characters>" + "<string of 245 characters>"'. 
    .PARAMETER priority 
        Priority for queuing the request. If server resources are not available for a request that matches the configured rule, this option specifies a priority for queuing the request until the server resources are available again. Enter the value of positive_integer as 1, 2 or 3. The highest priority level is 1 and the lowest priority value is 3.  
        Minimum value = 1  
        Maximum value = 3 
    .PARAMETER weight 
        Weight of the priority. Each priority is assigned a weight according to which it is served when server resources are available. The weight for a higher priority request must be set higher than that of a lower priority request.  
        To prevent delays for low-priority requests across multiple priority levels, you can configure weighted queuing for serving requests. The default weights for the priorities  
        are:  
        * Gold - Priority 1 - Weight 3  
        * Silver - Priority 2 - Weight 2  
        * Bronze - Priority 3 - Weight 1  
        Specify the weights as 0 through 101. A weight of 0 indicates that the particular priority level should be served only when there are no requests in any of the priority queues.  
        A weight of 101 specifies a weight of infinity. This means that this priority level is served irrespective of the number of clients waiting in other priority queues.  
        Minimum value = 0  
        Maximum value = 101 
    .PARAMETER qdepth 
        Queue depth threshold value. When the queue size (number of requests in the queue) on the virtual server to which this policy is bound, increases to the specified qDepth value, subsequent requests are dropped to the lowest priority level.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER polqdepth 
        Policy queue depth threshold value. When the policy queue size (number of requests in all the queues belonging to this policy) increases to the specified polqDepth value, subsequent requests are dropped to the lowest priority level.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER PassThru 
        Return details about the created pqpolicy item.
    .EXAMPLE
        Invoke-ADCAddPqpolicy -policyname <string> -rule <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddPqpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pq/pqpolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$policyname ,

        [Parameter(Mandatory = $true)]
        [string]$rule ,

        [Parameter(Mandatory = $true)]
        [ValidateRange(1, 3)]
        [double]$priority ,

        [ValidateRange(0, 101)]
        [double]$weight ,

        [ValidateRange(0, 4294967294)]
        [double]$qdepth = '0' ,

        [ValidateRange(0, 4294967294)]
        [double]$polqdepth = '0' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddPqpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
                rule = $rule
                priority = $priority
            }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('qdepth')) { $Payload.Add('qdepth', $qdepth) }
            if ($PSBoundParameters.ContainsKey('polqdepth')) { $Payload.Add('polqdepth', $polqdepth) }
 
            if ($PSCmdlet.ShouldProcess("pqpolicy", "Add Priority Queuing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type pqpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPqpolicy -Filter $Payload)
                } else {
                    Write-Output $result
                }

            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddPqpolicy: Finished"
    }
}

function Invoke-ADCDeletePqpolicy {
<#
    .SYNOPSIS
        Delete Priority Queuing configuration Object
    .DESCRIPTION
        Delete Priority Queuing configuration Object
    .PARAMETER policyname 
       Name for the priority queuing policy. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeletePqpolicy -policyname <string>
    .NOTES
        File Name : Invoke-ADCDeletePqpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pq/pqpolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeletePqpolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$policyname", "Delete Priority Queuing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type pqpolicy -NitroPath nitro/v1/config -Resource $policyname -Arguments $Arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeletePqpolicy: Finished"
    }
}

function Invoke-ADCUpdatePqpolicy {
<#
    .SYNOPSIS
        Update Priority Queuing configuration Object
    .DESCRIPTION
        Update Priority Queuing configuration Object 
    .PARAMETER policyname 
        Name for the priority queuing policy. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters.  
        Minimum length = 1 
    .PARAMETER weight 
        Weight of the priority. Each priority is assigned a weight according to which it is served when server resources are available. The weight for a higher priority request must be set higher than that of a lower priority request.  
        To prevent delays for low-priority requests across multiple priority levels, you can configure weighted queuing for serving requests. The default weights for the priorities  
        are:  
        * Gold - Priority 1 - Weight 3  
        * Silver - Priority 2 - Weight 2  
        * Bronze - Priority 3 - Weight 1  
        Specify the weights as 0 through 101. A weight of 0 indicates that the particular priority level should be served only when there are no requests in any of the priority queues.  
        A weight of 101 specifies a weight of infinity. This means that this priority level is served irrespective of the number of clients waiting in other priority queues.  
        Minimum value = 0  
        Maximum value = 101 
    .PARAMETER qdepth 
        Queue depth threshold value. When the queue size (number of requests in the queue) on the virtual server to which this policy is bound, increases to the specified qDepth value, subsequent requests are dropped to the lowest priority level.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER polqdepth 
        Policy queue depth threshold value. When the policy queue size (number of requests in all the queues belonging to this policy) increases to the specified polqDepth value, subsequent requests are dropped to the lowest priority level.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER PassThru 
        Return details about the created pqpolicy item.
    .EXAMPLE
        Invoke-ADCUpdatePqpolicy -policyname <string>
    .NOTES
        File Name : Invoke-ADCUpdatePqpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pq/pqpolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$policyname ,

        [ValidateRange(0, 101)]
        [double]$weight ,

        [ValidateRange(0, 4294967294)]
        [double]$qdepth ,

        [ValidateRange(0, 4294967294)]
        [double]$polqdepth ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdatePqpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
            }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('qdepth')) { $Payload.Add('qdepth', $qdepth) }
            if ($PSBoundParameters.ContainsKey('polqdepth')) { $Payload.Add('polqdepth', $polqdepth) }
 
            if ($PSCmdlet.ShouldProcess("pqpolicy", "Update Priority Queuing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type pqpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetPqpolicy -Filter $Payload)
                } else {
                    Write-Output $result
                }

            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUpdatePqpolicy: Finished"
    }
}

function Invoke-ADCUnsetPqpolicy {
<#
    .SYNOPSIS
        Unset Priority Queuing configuration Object
    .DESCRIPTION
        Unset Priority Queuing configuration Object 
   .PARAMETER policyname 
       Name for the priority queuing policy. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters. 
   .PARAMETER weight 
       Weight of the priority. Each priority is assigned a weight according to which it is served when server resources are available. The weight for a higher priority request must be set higher than that of a lower priority request.  
       To prevent delays for low-priority requests across multiple priority levels, you can configure weighted queuing for serving requests. The default weights for the priorities  
       are:  
       * Gold - Priority 1 - Weight 3  
       * Silver - Priority 2 - Weight 2  
       * Bronze - Priority 3 - Weight 1  
       Specify the weights as 0 through 101. A weight of 0 indicates that the particular priority level should be served only when there are no requests in any of the priority queues.  
       A weight of 101 specifies a weight of infinity. This means that this priority level is served irrespective of the number of clients waiting in other priority queues. 
   .PARAMETER qdepth 
       Queue depth threshold value. When the queue size (number of requests in the queue) on the virtual server to which this policy is bound, increases to the specified qDepth value, subsequent requests are dropped to the lowest priority level. 
   .PARAMETER polqdepth 
       Policy queue depth threshold value. When the policy queue size (number of requests in all the queues belonging to this policy) increases to the specified polqDepth value, subsequent requests are dropped to the lowest priority level.
    .EXAMPLE
        Invoke-ADCUnsetPqpolicy -policyname <string>
    .NOTES
        File Name : Invoke-ADCUnsetPqpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pq/pqpolicy
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$policyname ,

        [Boolean]$weight ,

        [Boolean]$qdepth ,

        [Boolean]$polqdepth 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetPqpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
            }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('qdepth')) { $Payload.Add('qdepth', $qdepth) }
            if ($PSBoundParameters.ContainsKey('polqdepth')) { $Payload.Add('polqdepth', $polqdepth) }
            if ($PSCmdlet.ShouldProcess("$policyname", "Unset Priority Queuing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type pqpolicy -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUnsetPqpolicy: Finished"
    }
}

function Invoke-ADCGetPqpolicy {
<#
    .SYNOPSIS
        Get Priority Queuing configuration object(s)
    .DESCRIPTION
        Get Priority Queuing configuration object(s)
    .PARAMETER policyname 
       Name for the priority queuing policy. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters. 
    .PARAMETER GetAll 
        Retreive all pqpolicy object(s)
    .PARAMETER Count
        If specified, the count of the pqpolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetPqpolicy
    .EXAMPLE 
        Invoke-ADCGetPqpolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetPqpolicy -Count
    .EXAMPLE
        Invoke-ADCGetPqpolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetPqpolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetPqpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/pq/pqpolicy/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$policyname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetPqpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all pqpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pqpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for pqpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pqpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving pqpolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pqpolicy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving pqpolicy configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pqpolicy -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving pqpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pqpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPqpolicy: Ended"
    }
}


