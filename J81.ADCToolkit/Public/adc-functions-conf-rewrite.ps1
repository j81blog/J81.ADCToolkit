function Invoke-ADCAddRewriteaction {
    <#
    .SYNOPSIS
        Add Rewrite configuration Object.
    .DESCRIPTION
        Configuration for rewrite action resource.
    .PARAMETER Name 
        Name for the user-defined rewrite action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the rewrite policy is added. 
    .PARAMETER Type 
        Type of user-defined rewrite action. The information that you provide for, and the effect of, each type are as follows:: 
        * REPLACE <target> <string_builder_expr>. Replaces the string with the string-builder expression. 
        * REPLACE_ALL <target> <string_builder_expr> -search <search_expr>. In the request or response specified by <target>, replaces all occurrences of the string defined by <string_builder_expr> with the string defined by <search_expr>. 
        * REPLACE_HTTP_RES <string_builder_expr>. Replaces the complete HTTP response with the string defined by the string-builder expression. 
        * REPLACE_SIP_RES <target> - Replaces the complete SIP response with the string specified by <target>. 
        * INSERT_HTTP_HEADER <header_string_builder_expr> <contents_string_builder_expr>. Inserts the HTTP header specified by <header_string_builder_expr> and header contents specified by <contents_string_builder_expr>. 
        * DELETE_HTTP_HEADER <target>. Deletes the HTTP header specified by <target>. 
        * CORRUPT_HTTP_HEADER <target>. Replaces the header name of all occurrences of the HTTP header specified by <target> with a corrupted name, so that it will not be recognized by the receiver Example: MY_HEADER is changed to MHEY_ADER. 
        * INSERT_BEFORE <target_expr> <string_builder_expr>. Finds the string specified in <target_expr> and inserts the string in <string_builder_expr> before it. 
        * INSERT_BEFORE_ALL <target> <string_builder_expr> -search <search_expr>. In the request or response specified by <target>, locates all occurrences of the string specified in <string_builder_expr> and inserts the string specified in <search_expr> before each. 
        * INSERT_AFTER <target_expr> <string_builder_expr>. Finds the string specified in <target_expr>, and inserts the string specified in <string_builder_expr> after it. 
        * INSERT_AFTER_ALL <target> <string_builder_expr> -search <search_expr>. In the request or response specified by <target>, locates all occurrences of the string specified by <string_builder_expr> and inserts the string specified by <search_expr> after each. 
        * DELETE <target>. Finds and deletes the specified target. 
        * DELETE_ALL <target> -search <string_builder_expr>. In the request or response specified by <target>, locates and deletes all occurrences of the string specified by <string_builder_expr>. 
        * REPLACE_DIAMETER_HEADER_FIELD <target> <field value>. In the request or response modify the header field specified by <target>. Use Diameter.req.flags.SET(<flag>) or Diameter.req.flags.UNSET<flag> as 'stringbuilderexpression' to set or unset flags. 
        * REPLACE_DNS_HEADER_FIELD <target>. In the request or response modify the header field specified by <target>. 
        * REPLACE_DNS_ANSWER_SECTION <target>. Replace the DNS answer section in the response. This is currently applicable for A and AAAA records only. Use DNS.NEW_RRSET_A ; DNS.NEW_RRSET_AAAA expressions to configure the new answer section . 
        Possible values = noop, delete, insert_http_header, delete_http_header, corrupt_http_header, insert_before, insert_after, replace, replace_http_res, delete_all, replace_all, insert_before_all, insert_after_all, clientless_vpn_encode, clientless_vpn_encode_all, clientless_vpn_decode, clientless_vpn_decode_all, insert_sip_header, delete_sip_header, corrupt_sip_header, replace_sip_res, replace_diameter_header_field, replace_dns_header_field, replace_dns_answer_section 
    .PARAMETER Target 
        Expression that specifies which part of the request or response to rewrite. 
    .PARAMETER Stringbuilderexpr 
        Expression that specifies the content to insert into the request or response at the specified location, or that replaces the specified string. 
    .PARAMETER Search 
        Search facility that is used to match multiple strings in the request or response. Used in the INSERT_BEFORE_ALL, INSERT_AFTER_ALL, REPLACE_ALL, and DELETE_ALL action types. The following search types are supported: 
        * Text ("text(string)") - A literal string. Example: -search text("hello") 
        * Regular expression ("regex(re<delimiter>regular exp<delimiter>)") - Pattern that is used to match multiple strings in the request or response. The pattern may be a PCRE-format regular expression with a delimiter that consists of any printable ASCII non-alphanumeric character except for the underscore (_) and space ( ) that is not otherwise used in the expression. Example: -search regex(re~^hello*~) The preceding regular expression can use the tilde (~) as the delimiter because that character does not appear in the regular expression itself. 
        * XPath ("xpath(xp<delimiter>xpath expression<delimiter>)") - An XPath expression to search XML. The delimiter has the same rules as for regex. Example: -search xpath(xp%/a/b%) 
        * JSON ("xpath_json(xp<delimiter>xpath expression<delimiter>)") - An XPath expression to search JSON. The delimiter has the same rules as for regex. Example: -search xpath_json(xp%/a/b%) 
        NOTE: JSON searches use the same syntax as XPath searches, but operate on JSON files instead of standard XML files. 
        * HTML ("xpath_html(xp<delimiter>xpath expression<delimiter>)") - An XPath expression to search HTML. The delimiter has the same rules as for regex. Example: -search xpath_html(xp%/html/body%) 
        NOTE: HTML searches use the same syntax as XPath searches, but operate on HTML files instead of standard XML files; HTML 5 rules for the file syntax are used; HTML 4 and later are supported. 
        * Patset ("patset(patset)") - A predefined pattern set. Example: -search patset("patset1"). 
        * Datset ("dataset(dataset)") - A predefined dataset. Example: -search dataset("dataset1"). 
        * AVP ("avp(avp number)") - AVP number that is used to match multiple AVPs in a Diameter/Radius Message. Example: -search avp(999) 
        Note: for all these the TARGET prefix can be used in the replacement expression to specify the text that was selected by the -search parameter, optionally adjusted by the -refineSearch parameter. 
        Example: TARGET.BEFORE_STR(","). 
    .PARAMETER Refinesearch 
        Specify additional criteria to refine the results of the search. 
        Always starts with the "extend(m,n)" operation, where 'm' specifies number of bytes to the left of selected data and 'n' specifies number of bytes to the right of selected data to extend the selected area. 
        You can use refineSearch only on body expressions, and for the INSERT_BEFORE_ALL, INSERT_AFTER_ALL, REPLACE_ALL, and DELETE_ALL action types. 
        Example: -refineSearch 'EXTEND(10, 20).REGEX_SELECT(re~0x[0-9a-zA-Z]+~). 
    .PARAMETER Comment 
        Comment. Can be used to preserve information about this rewrite action. 
    .PARAMETER PassThru 
        Return details about the created rewriteaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddRewriteaction -name <string> -type <string> -target <string>
        An example how to add rewriteaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddRewriteaction
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewriteaction/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateSet('noop', 'delete', 'insert_http_header', 'delete_http_header', 'corrupt_http_header', 'insert_before', 'insert_after', 'replace', 'replace_http_res', 'delete_all', 'replace_all', 'insert_before_all', 'insert_after_all', 'clientless_vpn_encode', 'clientless_vpn_encode_all', 'clientless_vpn_decode', 'clientless_vpn_decode_all', 'insert_sip_header', 'delete_sip_header', 'corrupt_sip_header', 'replace_sip_res', 'replace_diameter_header_field', 'replace_dns_header_field', 'replace_dns_answer_section')]
        [string]$Type,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Target,

        [string]$Stringbuilderexpr,

        [string]$Search,

        [string]$Refinesearch,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddRewriteaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                type           = $type
                target         = $target
            }
            if ( $PSBoundParameters.ContainsKey('stringbuilderexpr') ) { $payload.Add('stringbuilderexpr', $stringbuilderexpr) }
            if ( $PSBoundParameters.ContainsKey('search') ) { $payload.Add('search', $search) }
            if ( $PSBoundParameters.ContainsKey('refinesearch') ) { $payload.Add('refinesearch', $refinesearch) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("rewriteaction", "Add Rewrite configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type rewriteaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetRewriteaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddRewriteaction: Finished"
    }
}

function Invoke-ADCDeleteRewriteaction {
    <#
    .SYNOPSIS
        Delete Rewrite configuration Object.
    .DESCRIPTION
        Configuration for rewrite action resource.
    .PARAMETER Name 
        Name for the user-defined rewrite action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the rewrite policy is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteRewriteaction -Name <string>
        An example how to delete rewriteaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteRewriteaction
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewriteaction/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteRewriteaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Rewrite configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type rewriteaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteRewriteaction: Finished"
    }
}

function Invoke-ADCUpdateRewriteaction {
    <#
    .SYNOPSIS
        Update Rewrite configuration Object.
    .DESCRIPTION
        Configuration for rewrite action resource.
    .PARAMETER Name 
        Name for the user-defined rewrite action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the rewrite policy is added. 
    .PARAMETER Target 
        Expression that specifies which part of the request or response to rewrite. 
    .PARAMETER Stringbuilderexpr 
        Expression that specifies the content to insert into the request or response at the specified location, or that replaces the specified string. 
    .PARAMETER Search 
        Search facility that is used to match multiple strings in the request or response. Used in the INSERT_BEFORE_ALL, INSERT_AFTER_ALL, REPLACE_ALL, and DELETE_ALL action types. The following search types are supported: 
        * Text ("text(string)") - A literal string. Example: -search text("hello") 
        * Regular expression ("regex(re<delimiter>regular exp<delimiter>)") - Pattern that is used to match multiple strings in the request or response. The pattern may be a PCRE-format regular expression with a delimiter that consists of any printable ASCII non-alphanumeric character except for the underscore (_) and space ( ) that is not otherwise used in the expression. Example: -search regex(re~^hello*~) The preceding regular expression can use the tilde (~) as the delimiter because that character does not appear in the regular expression itself. 
        * XPath ("xpath(xp<delimiter>xpath expression<delimiter>)") - An XPath expression to search XML. The delimiter has the same rules as for regex. Example: -search xpath(xp%/a/b%) 
        * JSON ("xpath_json(xp<delimiter>xpath expression<delimiter>)") - An XPath expression to search JSON. The delimiter has the same rules as for regex. Example: -search xpath_json(xp%/a/b%) 
        NOTE: JSON searches use the same syntax as XPath searches, but operate on JSON files instead of standard XML files. 
        * HTML ("xpath_html(xp<delimiter>xpath expression<delimiter>)") - An XPath expression to search HTML. The delimiter has the same rules as for regex. Example: -search xpath_html(xp%/html/body%) 
        NOTE: HTML searches use the same syntax as XPath searches, but operate on HTML files instead of standard XML files; HTML 5 rules for the file syntax are used; HTML 4 and later are supported. 
        * Patset ("patset(patset)") - A predefined pattern set. Example: -search patset("patset1"). 
        * Datset ("dataset(dataset)") - A predefined dataset. Example: -search dataset("dataset1"). 
        * AVP ("avp(avp number)") - AVP number that is used to match multiple AVPs in a Diameter/Radius Message. Example: -search avp(999) 
        Note: for all these the TARGET prefix can be used in the replacement expression to specify the text that was selected by the -search parameter, optionally adjusted by the -refineSearch parameter. 
        Example: TARGET.BEFORE_STR(","). 
    .PARAMETER Refinesearch 
        Specify additional criteria to refine the results of the search. 
        Always starts with the "extend(m,n)" operation, where 'm' specifies number of bytes to the left of selected data and 'n' specifies number of bytes to the right of selected data to extend the selected area. 
        You can use refineSearch only on body expressions, and for the INSERT_BEFORE_ALL, INSERT_AFTER_ALL, REPLACE_ALL, and DELETE_ALL action types. 
        Example: -refineSearch 'EXTEND(10, 20).REGEX_SELECT(re~0x[0-9a-zA-Z]+~). 
    .PARAMETER Comment 
        Comment. Can be used to preserve information about this rewrite action. 
    .PARAMETER PassThru 
        Return details about the created rewriteaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateRewriteaction -name <string>
        An example how to update rewriteaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateRewriteaction
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewriteaction/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Name,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Target,

        [string]$Stringbuilderexpr,

        [string]$Search,

        [string]$Refinesearch,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateRewriteaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('target') ) { $payload.Add('target', $target) }
            if ( $PSBoundParameters.ContainsKey('stringbuilderexpr') ) { $payload.Add('stringbuilderexpr', $stringbuilderexpr) }
            if ( $PSBoundParameters.ContainsKey('search') ) { $payload.Add('search', $search) }
            if ( $PSBoundParameters.ContainsKey('refinesearch') ) { $payload.Add('refinesearch', $refinesearch) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("rewriteaction", "Update Rewrite configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type rewriteaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetRewriteaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateRewriteaction: Finished"
    }
}

function Invoke-ADCUnsetRewriteaction {
    <#
    .SYNOPSIS
        Unset Rewrite configuration Object.
    .DESCRIPTION
        Configuration for rewrite action resource.
    .PARAMETER Name 
        Name for the user-defined rewrite action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the rewrite policy is added. 
    .PARAMETER Stringbuilderexpr 
        Expression that specifies the content to insert into the request or response at the specified location, or that replaces the specified string. 
    .PARAMETER Refinesearch 
        Specify additional criteria to refine the results of the search. 
        Always starts with the "extend(m,n)" operation, where 'm' specifies number of bytes to the left of selected data and 'n' specifies number of bytes to the right of selected data to extend the selected area. 
        You can use refineSearch only on body expressions, and for the INSERT_BEFORE_ALL, INSERT_AFTER_ALL, REPLACE_ALL, and DELETE_ALL action types. 
        Example: -refineSearch 'EXTEND(10, 20).REGEX_SELECT(re~0x[0-9a-zA-Z]+~). 
    .PARAMETER Comment 
        Comment. Can be used to preserve information about this rewrite action.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetRewriteaction -name <string>
        An example how to unset rewriteaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetRewriteaction
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewriteaction
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [string]$Name,

        [Boolean]$stringbuilderexpr,

        [Boolean]$refinesearch,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetRewriteaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('stringbuilderexpr') ) { $payload.Add('stringbuilderexpr', $stringbuilderexpr) }
            if ( $PSBoundParameters.ContainsKey('refinesearch') ) { $payload.Add('refinesearch', $refinesearch) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Rewrite configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type rewriteaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetRewriteaction: Finished"
    }
}

function Invoke-ADCRenameRewriteaction {
    <#
    .SYNOPSIS
        Rename Rewrite configuration Object.
    .DESCRIPTION
        Configuration for rewrite action resource.
    .PARAMETER Name 
        Name for the user-defined rewrite action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the rewrite policy is added. 
    .PARAMETER Newname 
        New name for the rewrite action. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the rewrite policy is added. 
    .PARAMETER PassThru 
        Return details about the created rewriteaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameRewriteaction -name <string> -newname <string>
        An example how to rename rewriteaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameRewriteaction
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewriteaction/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameRewriteaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("rewriteaction", "Rename Rewrite configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type rewriteaction -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetRewriteaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameRewriteaction: Finished"
    }
}

function Invoke-ADCGetRewriteaction {
    <#
    .SYNOPSIS
        Get Rewrite configuration object(s).
    .DESCRIPTION
        Configuration for rewrite action resource.
    .PARAMETER Name 
        Name for the user-defined rewrite action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the rewrite policy is added. 
    .PARAMETER GetAll 
        Retrieve all rewriteaction object(s).
    .PARAMETER Count
        If specified, the count of the rewriteaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewriteaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewriteaction -GetAll 
        Get all rewriteaction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewriteaction -Count 
        Get the number of rewriteaction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewriteaction -name <string>
        Get rewriteaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewriteaction -Filter @{ 'name'='<value>' }
        Get rewriteaction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRewriteaction
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewriteaction/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetRewriteaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all rewriteaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewriteaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rewriteaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewriteaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rewriteaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewriteaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rewriteaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewriteaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rewriteaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewriteaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRewriteaction: Ended"
    }
}

function Invoke-ADCGetRewriteglobalbinding {
    <#
    .SYNOPSIS
        Get Rewrite configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to rewriteglobal.
    .PARAMETER GetAll 
        Retrieve all rewriteglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the rewriteglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewriteglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewriteglobalbinding -GetAll 
        Get all rewriteglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewriteglobalbinding -name <string>
        Get rewriteglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewriteglobalbinding -Filter @{ 'name'='<value>' }
        Get rewriteglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRewriteglobalbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewriteglobal_binding/
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
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetRewriteglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all rewriteglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewriteglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rewriteglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewriteglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rewriteglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewriteglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rewriteglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving rewriteglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewriteglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRewriteglobalbinding: Ended"
    }
}

function Invoke-ADCAddRewriteglobalrewritepolicybinding {
    <#
    .SYNOPSIS
        Add Rewrite configuration Object.
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to rewriteglobal.
    .PARAMETER Policyname 
        Name of the rewrite policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Type 
        The bindpoint to which to policy is bound. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT, OTHERTCP_REQ_OVERRIDE, OTHERTCP_REQ_DEFAULT, OTHERTCP_RES_OVERRIDE, OTHERTCP_RES_DEFAULT, SIPUDP_REQ_OVERRIDE, SIPUDP_REQ_DEFAULT, SIPUDP_RES_OVERRIDE, SIPUDP_RES_DEFAULT, SIPTCP_REQ_OVERRIDE, SIPTCP_REQ_DEFAULT, SIPTCP_RES_OVERRIDE, SIPTCP_RES_DEFAULT, DIAMETER_REQ_OVERRIDE, DIAMETER_REQ_DEFAULT, DIAMETER_RES_OVERRIDE, DIAMETER_RES_DEFAULT, RADIUS_REQ_OVERRIDE, RADIUS_REQ_DEFAULT, RADIUS_RES_OVERRIDE, RADIUS_RES_DEFAULT, DNS_REQ_OVERRIDE, DNS_REQ_DEFAULT, DNS_RES_OVERRIDE, DNS_RES_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT, HTTPQUIC_RES_OVERRIDE, HTTPQUIC_RES_DEFAULT 
    .PARAMETER Invoke 
        Terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of invocation. Available settings function as follows: * reqvserver - Forward the request to the specified request virtual server. * resvserver - Forward the response to the specified response virtual server. * policylabel - Invoke the specified policy label. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        * If labelType is policylabel, name of the policy label to invoke. * If labelType is reqvserver or resvserver, name of the virtual server to which to forward the request of response. 
    .PARAMETER PassThru 
        Return details about the created rewriteglobal_rewritepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddRewriteglobalrewritepolicybinding -policyname <string> -priority <double>
        An example how to add rewriteglobal_rewritepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddRewriteglobalrewritepolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewriteglobal_rewritepolicy_binding/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Policyname,

        [Parameter(Mandatory)]
        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT', 'OTHERTCP_REQ_OVERRIDE', 'OTHERTCP_REQ_DEFAULT', 'OTHERTCP_RES_OVERRIDE', 'OTHERTCP_RES_DEFAULT', 'SIPUDP_REQ_OVERRIDE', 'SIPUDP_REQ_DEFAULT', 'SIPUDP_RES_OVERRIDE', 'SIPUDP_RES_DEFAULT', 'SIPTCP_REQ_OVERRIDE', 'SIPTCP_REQ_DEFAULT', 'SIPTCP_RES_OVERRIDE', 'SIPTCP_RES_DEFAULT', 'DIAMETER_REQ_OVERRIDE', 'DIAMETER_REQ_DEFAULT', 'DIAMETER_RES_OVERRIDE', 'DIAMETER_RES_DEFAULT', 'RADIUS_REQ_OVERRIDE', 'RADIUS_REQ_DEFAULT', 'RADIUS_RES_OVERRIDE', 'RADIUS_RES_DEFAULT', 'DNS_REQ_OVERRIDE', 'DNS_REQ_DEFAULT', 'DNS_RES_OVERRIDE', 'DNS_RES_DEFAULT', 'HTTPQUIC_REQ_OVERRIDE', 'HTTPQUIC_REQ_DEFAULT', 'HTTPQUIC_RES_OVERRIDE', 'HTTPQUIC_RES_DEFAULT')]
        [string]$Type,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddRewriteglobalrewritepolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                priority             = $priority
            }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("rewriteglobal_rewritepolicy_binding", "Add Rewrite configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type rewriteglobal_rewritepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetRewriteglobalrewritepolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddRewriteglobalrewritepolicybinding: Finished"
    }
}

function Invoke-ADCDeleteRewriteglobalrewritepolicybinding {
    <#
    .SYNOPSIS
        Delete Rewrite configuration Object.
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to rewriteglobal.
    .PARAMETER Policyname 
        Name of the rewrite policy. 
    .PARAMETER Type 
        The bindpoint to which to policy is bound. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT, OTHERTCP_REQ_OVERRIDE, OTHERTCP_REQ_DEFAULT, OTHERTCP_RES_OVERRIDE, OTHERTCP_RES_DEFAULT, SIPUDP_REQ_OVERRIDE, SIPUDP_REQ_DEFAULT, SIPUDP_RES_OVERRIDE, SIPUDP_RES_DEFAULT, SIPTCP_REQ_OVERRIDE, SIPTCP_REQ_DEFAULT, SIPTCP_RES_OVERRIDE, SIPTCP_RES_DEFAULT, DIAMETER_REQ_OVERRIDE, DIAMETER_REQ_DEFAULT, DIAMETER_RES_OVERRIDE, DIAMETER_RES_DEFAULT, RADIUS_REQ_OVERRIDE, RADIUS_REQ_DEFAULT, RADIUS_RES_OVERRIDE, RADIUS_RES_DEFAULT, DNS_REQ_OVERRIDE, DNS_REQ_DEFAULT, DNS_RES_OVERRIDE, DNS_RES_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT, HTTPQUIC_RES_OVERRIDE, HTTPQUIC_RES_DEFAULT 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteRewriteglobalrewritepolicybinding 
        An example how to delete rewriteglobal_rewritepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteRewriteglobalrewritepolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewriteglobal_rewritepolicy_binding/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [string]$Policyname,

        [string]$Type,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteRewriteglobalrewritepolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("rewriteglobal_rewritepolicy_binding", "Delete Rewrite configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type rewriteglobal_rewritepolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteRewriteglobalrewritepolicybinding: Finished"
    }
}

function Invoke-ADCGetRewriteglobalrewritepolicybinding {
    <#
    .SYNOPSIS
        Get Rewrite configuration object(s).
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to rewriteglobal.
    .PARAMETER GetAll 
        Retrieve all rewriteglobal_rewritepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the rewriteglobal_rewritepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewriteglobalrewritepolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewriteglobalrewritepolicybinding -GetAll 
        Get all rewriteglobal_rewritepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewriteglobalrewritepolicybinding -Count 
        Get the number of rewriteglobal_rewritepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewriteglobalrewritepolicybinding -name <string>
        Get rewriteglobal_rewritepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewriteglobalrewritepolicybinding -Filter @{ 'name'='<value>' }
        Get rewriteglobal_rewritepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRewriteglobalrewritepolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewriteglobal_rewritepolicy_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetRewriteglobalrewritepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all rewriteglobal_rewritepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewriteglobal_rewritepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rewriteglobal_rewritepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewriteglobal_rewritepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rewriteglobal_rewritepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewriteglobal_rewritepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rewriteglobal_rewritepolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving rewriteglobal_rewritepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewriteglobal_rewritepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRewriteglobalrewritepolicybinding: Ended"
    }
}

function Invoke-ADCUpdateRewriteparam {
    <#
    .SYNOPSIS
        Update Rewrite configuration Object.
    .DESCRIPTION
        Configuration for rewrite parameter resource.
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an error condition in evaluating the expression. 
        Available settings function as follows: 
        * NOREWRITE - Do not modify the message. 
        * RESET - Reset the connection and notify the user's browser, so that the user can resend the request. 
        * DROP - Drop the message without sending a response to the user. 
    .PARAMETER Timeout 
        Maximum time in milliseconds to allow for processing all the policies and their selected actions without interruption. If the timeout is reached then the evaluation causes an UNDEF to be raised and no further processing is performed. Note that some rewrites may have already been performed.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateRewriteparam 
        An example how to update rewriteparam configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateRewriteparam
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewriteparam/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [string]$Undefaction,

        [ValidateRange(1, 5000)]
        [double]$Timeout 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateRewriteparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSCmdlet.ShouldProcess("rewriteparam", "Update Rewrite configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type rewriteparam -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUpdateRewriteparam: Finished"
    }
}

function Invoke-ADCUnsetRewriteparam {
    <#
    .SYNOPSIS
        Unset Rewrite configuration Object.
    .DESCRIPTION
        Configuration for rewrite parameter resource.
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an error condition in evaluating the expression. 
        Available settings function as follows: 
        * NOREWRITE - Do not modify the message. 
        * RESET - Reset the connection and notify the user's browser, so that the user can resend the request. 
        * DROP - Drop the message without sending a response to the user. 
    .PARAMETER Timeout 
        Maximum time in milliseconds to allow for processing all the policies and their selected actions without interruption. If the timeout is reached then the evaluation causes an UNDEF to be raised and no further processing is performed. Note that some rewrites may have already been performed.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetRewriteparam 
        An example how to unset rewriteparam configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetRewriteparam
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewriteparam
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Boolean]$undefaction,

        [Boolean]$timeout 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetRewriteparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSCmdlet.ShouldProcess("rewriteparam", "Unset Rewrite configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type rewriteparam -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetRewriteparam: Finished"
    }
}

function Invoke-ADCGetRewriteparam {
    <#
    .SYNOPSIS
        Get Rewrite configuration object(s).
    .DESCRIPTION
        Configuration for rewrite parameter resource.
    .PARAMETER GetAll 
        Retrieve all rewriteparam object(s).
    .PARAMETER Count
        If specified, the count of the rewriteparam object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewriteparam
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewriteparam -GetAll 
        Get all rewriteparam data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewriteparam -name <string>
        Get rewriteparam object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewriteparam -Filter @{ 'name'='<value>' }
        Get rewriteparam data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRewriteparam
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewriteparam/
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
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetRewriteparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all rewriteparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewriteparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rewriteparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewriteparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rewriteparam objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewriteparam -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rewriteparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving rewriteparam configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewriteparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRewriteparam: Ended"
    }
}

function Invoke-ADCAddRewritepolicy {
    <#
    .SYNOPSIS
        Add Rewrite configuration Object.
    .DESCRIPTION
        Configuration for rewrite policy resource.
    .PARAMETER Name 
        Name for the rewrite policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the rewrite policy is added. 
    .PARAMETER Rule 
        Expression against which traffic is evaluated. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the rewrite action to perform if the request or response matches this rewrite policy. 
        There are also some built-in actions which can be used. These are: 
        * NOREWRITE - Send the request from the client to the server or response from the server to the client without making any changes in the message. 
        * RESET - Resets the client connection by closing it. The client program, such as a browser, will handle this and may inform the user. The client may then resend the request if desired. 
        * DROP - Drop the request without sending a response to the user. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER Comment 
        Any comments to preserve information about this rewrite policy. 
    .PARAMETER Logaction 
        Name of messagelog action to use when a request matches this policy. 
    .PARAMETER PassThru 
        Return details about the created rewritepolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddRewritepolicy -name <string> -rule <string> -action <string>
        An example how to add rewritepolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddRewritepolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Rule,

        [Parameter(Mandatory)]
        [string]$Action,

        [string]$Undefaction,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddRewritepolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("rewritepolicy", "Add Rewrite configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type rewritepolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetRewritepolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddRewritepolicy: Finished"
    }
}

function Invoke-ADCDeleteRewritepolicy {
    <#
    .SYNOPSIS
        Delete Rewrite configuration Object.
    .DESCRIPTION
        Configuration for rewrite policy resource.
    .PARAMETER Name 
        Name for the rewrite policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the rewrite policy is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteRewritepolicy -Name <string>
        An example how to delete rewritepolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteRewritepolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteRewritepolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Rewrite configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type rewritepolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteRewritepolicy: Finished"
    }
}

function Invoke-ADCUpdateRewritepolicy {
    <#
    .SYNOPSIS
        Update Rewrite configuration Object.
    .DESCRIPTION
        Configuration for rewrite policy resource.
    .PARAMETER Name 
        Name for the rewrite policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the rewrite policy is added. 
    .PARAMETER Rule 
        Expression against which traffic is evaluated. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the rewrite action to perform if the request or response matches this rewrite policy. 
        There are also some built-in actions which can be used. These are: 
        * NOREWRITE - Send the request from the client to the server or response from the server to the client without making any changes in the message. 
        * RESET - Resets the client connection by closing it. The client program, such as a browser, will handle this and may inform the user. The client may then resend the request if desired. 
        * DROP - Drop the request without sending a response to the user. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER Comment 
        Any comments to preserve information about this rewrite policy. 
    .PARAMETER Logaction 
        Name of messagelog action to use when a request matches this policy. 
    .PARAMETER PassThru 
        Return details about the created rewritepolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateRewritepolicy -name <string>
        An example how to update rewritepolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateRewritepolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Name,

        [string]$Rule,

        [string]$Action,

        [string]$Undefaction,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateRewritepolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("rewritepolicy", "Update Rewrite configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type rewritepolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetRewritepolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateRewritepolicy: Finished"
    }
}

function Invoke-ADCUnsetRewritepolicy {
    <#
    .SYNOPSIS
        Unset Rewrite configuration Object.
    .DESCRIPTION
        Configuration for rewrite policy resource.
    .PARAMETER Name 
        Name for the rewrite policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the rewrite policy is added. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER Comment 
        Any comments to preserve information about this rewrite policy. 
    .PARAMETER Logaction 
        Name of messagelog action to use when a request matches this policy.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetRewritepolicy -name <string>
        An example how to unset rewritepolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetRewritepolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicy
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [string]$Name,

        [Boolean]$undefaction,

        [Boolean]$comment,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetRewritepolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Rewrite configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type rewritepolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetRewritepolicy: Finished"
    }
}

function Invoke-ADCRenameRewritepolicy {
    <#
    .SYNOPSIS
        Rename Rewrite configuration Object.
    .DESCRIPTION
        Configuration for rewrite policy resource.
    .PARAMETER Name 
        Name for the rewrite policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the rewrite policy is added. 
    .PARAMETER Newname 
        New name for the rewrite policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created rewritepolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameRewritepolicy -name <string> -newname <string>
        An example how to rename rewritepolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameRewritepolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameRewritepolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("rewritepolicy", "Rename Rewrite configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type rewritepolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetRewritepolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameRewritepolicy: Finished"
    }
}

function Invoke-ADCGetRewritepolicy {
    <#
    .SYNOPSIS
        Get Rewrite configuration object(s).
    .DESCRIPTION
        Configuration for rewrite policy resource.
    .PARAMETER Name 
        Name for the rewrite policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the rewrite policy is added. 
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
        PS C:\>Invoke-ADCGetRewritepolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicy -GetAll 
        Get all rewritepolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicy -Count 
        Get the number of rewritepolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicy -name <string>
        Get rewritepolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicy -Filter @{ 'name'='<value>' }
        Get rewritepolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRewritepolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicy/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetRewritepolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all rewritepolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rewritepolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rewritepolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rewritepolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rewritepolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRewritepolicy: Ended"
    }
}

function Invoke-ADCAddRewritepolicylabel {
    <#
    .SYNOPSIS
        Add Rewrite configuration Object.
    .DESCRIPTION
        Configuration for rewrite policy label resource.
    .PARAMETER Labelname 
        Name for the rewrite policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the rewrite policy label is added. 
    .PARAMETER Transform 
        Types of transformations allowed by the policies bound to the label. For Rewrite, the following types are supported: 
        * http_req - HTTP requests 
        * http_res - HTTP responses 
        * othertcp_req - Non-HTTP TCP requests 
        * othertcp_res - Non-HTTP TCP responses 
        * url - URLs 
        * text - Text strings 
        * clientless_vpn_req - Citrix ADC clientless VPN requests 
        * clientless_vpn_res - Citrix ADC clientless VPN responses 
        * sipudp_req - SIP requests 
        * sipudp_res - SIP responses 
        * diameter_req - DIAMETER requests 
        * diameter_res - DIAMETER responses 
        * radius_req - RADIUS requests 
        * radius_res - RADIUS responses 
        * dns_req - DNS requests 
        * dns_res - DNS responses. 
        Possible values = http_req, http_res, othertcp_req, othertcp_res, url, text, clientless_vpn_req, clientless_vpn_res, sipudp_req, sipudp_res, siptcp_req, siptcp_res, diameter_req, diameter_res, radius_req, radius_res, dns_req, dns_res, httpquic_req, httpquic_res 
    .PARAMETER Comment 
        Any comments to preserve information about this rewrite policy label. 
    .PARAMETER PassThru 
        Return details about the created rewritepolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddRewritepolicylabel -labelname <string> -transform <string>
        An example how to add rewritepolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddRewritepolicylabel
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicylabel/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Labelname,

        [Parameter(Mandatory)]
        [ValidateSet('http_req', 'http_res', 'othertcp_req', 'othertcp_res', 'url', 'text', 'clientless_vpn_req', 'clientless_vpn_res', 'sipudp_req', 'sipudp_res', 'siptcp_req', 'siptcp_res', 'diameter_req', 'diameter_res', 'radius_req', 'radius_res', 'dns_req', 'dns_res', 'httpquic_req', 'httpquic_res')]
        [string]$Transform,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddRewritepolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                transform           = $transform
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("rewritepolicylabel", "Add Rewrite configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type rewritepolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetRewritepolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddRewritepolicylabel: Finished"
    }
}

function Invoke-ADCDeleteRewritepolicylabel {
    <#
    .SYNOPSIS
        Delete Rewrite configuration Object.
    .DESCRIPTION
        Configuration for rewrite policy label resource.
    .PARAMETER Labelname 
        Name for the rewrite policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the rewrite policy label is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteRewritepolicylabel -Labelname <string>
        An example how to delete rewritepolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteRewritepolicylabel
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicylabel/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Labelname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteRewritepolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Rewrite configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type rewritepolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteRewritepolicylabel: Finished"
    }
}

function Invoke-ADCRenameRewritepolicylabel {
    <#
    .SYNOPSIS
        Rename Rewrite configuration Object.
    .DESCRIPTION
        Configuration for rewrite policy label resource.
    .PARAMETER Labelname 
        Name for the rewrite policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the rewrite policy label is added. 
    .PARAMETER Newname 
        New name for the rewrite policy label. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created rewritepolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameRewritepolicylabel -labelname <string> -newname <string>
        An example how to rename rewritepolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameRewritepolicylabel
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicylabel/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Labelname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameRewritepolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("rewritepolicylabel", "Rename Rewrite configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type rewritepolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetRewritepolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameRewritepolicylabel: Finished"
    }
}

function Invoke-ADCGetRewritepolicylabel {
    <#
    .SYNOPSIS
        Get Rewrite configuration object(s).
    .DESCRIPTION
        Configuration for rewrite policy label resource.
    .PARAMETER Labelname 
        Name for the rewrite policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the rewrite policy label is added. 
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
        PS C:\>Invoke-ADCGetRewritepolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicylabel -GetAll 
        Get all rewritepolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicylabel -Count 
        Get the number of rewritepolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicylabel -name <string>
        Get rewritepolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicylabel -Filter @{ 'name'='<value>' }
        Get rewritepolicylabel data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRewritepolicylabel
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicylabel/
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
        [string]$Labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetRewritepolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all rewritepolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rewritepolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rewritepolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rewritepolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rewritepolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRewritepolicylabel: Ended"
    }
}

function Invoke-ADCGetRewritepolicylabelbinding {
    <#
    .SYNOPSIS
        Get Rewrite configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to rewritepolicylabel.
    .PARAMETER Labelname 
        Name of the rewrite policy label. 
    .PARAMETER GetAll 
        Retrieve all rewritepolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the rewritepolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicylabelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicylabelbinding -GetAll 
        Get all rewritepolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicylabelbinding -name <string>
        Get rewritepolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicylabelbinding -Filter @{ 'name'='<value>' }
        Get rewritepolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRewritepolicylabelbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicylabel_binding/
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
        [string]$Labelname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetRewritepolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all rewritepolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rewritepolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rewritepolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rewritepolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rewritepolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRewritepolicylabelbinding: Ended"
    }
}

function Invoke-ADCGetRewritepolicylabelpolicybindingbinding {
    <#
    .SYNOPSIS
        Get Rewrite configuration object(s).
    .DESCRIPTION
        Binding object showing the policybinding that can be bound to rewritepolicylabel.
    .PARAMETER Labelname 
        Name of the rewrite policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all rewritepolicylabel_policybinding_binding object(s).
    .PARAMETER Count
        If specified, the count of the rewritepolicylabel_policybinding_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicylabelpolicybindingbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicylabelpolicybindingbinding -GetAll 
        Get all rewritepolicylabel_policybinding_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicylabelpolicybindingbinding -Count 
        Get the number of rewritepolicylabel_policybinding_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicylabelpolicybindingbinding -name <string>
        Get rewritepolicylabel_policybinding_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicylabelpolicybindingbinding -Filter @{ 'name'='<value>' }
        Get rewritepolicylabel_policybinding_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRewritepolicylabelpolicybindingbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicylabel_policybinding_binding/
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
        [string]$Labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetRewritepolicylabelpolicybindingbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all rewritepolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rewritepolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rewritepolicylabel_policybinding_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rewritepolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rewritepolicylabel_policybinding_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRewritepolicylabelpolicybindingbinding: Ended"
    }
}

function Invoke-ADCAddRewritepolicylabelrewritepolicybinding {
    <#
    .SYNOPSIS
        Add Rewrite configuration Object.
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to rewritepolicylabel.
    .PARAMETER Labelname 
        Name of the rewrite policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the rewrite policy to bind to the policy label. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Invoke 
        Suspend evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of invocation. Available settings function as follows: * reqvserver - Forward the request to the specified request virtual server. * resvserver - Forward the response to the specified response virtual server. * policylabel - Invoke the specified policy label. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Invoke_labelname 
        * If labelType is policylabel, name of the policy label to invoke. * If labelType is reqvserver or resvserver, name of the virtual server to which to forward the request or response. 
    .PARAMETER PassThru 
        Return details about the created rewritepolicylabel_rewritepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddRewritepolicylabelrewritepolicybinding -labelname <string> -policyname <string> -priority <double>
        An example how to add rewritepolicylabel_rewritepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddRewritepolicylabelrewritepolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicylabel_rewritepolicy_binding/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Labelname,

        [Parameter(Mandatory)]
        [string]$Policyname,

        [Parameter(Mandatory)]
        [double]$Priority,

        [string]$Gotopriorityexpression,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Invoke_labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddRewritepolicylabelrewritepolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                policyname          = $policyname
                priority            = $priority
            }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('invoke_labelname') ) { $payload.Add('invoke_labelname', $invoke_labelname) }
            if ( $PSCmdlet.ShouldProcess("rewritepolicylabel_rewritepolicy_binding", "Add Rewrite configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type rewritepolicylabel_rewritepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetRewritepolicylabelrewritepolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddRewritepolicylabelrewritepolicybinding: Finished"
    }
}

function Invoke-ADCDeleteRewritepolicylabelrewritepolicybinding {
    <#
    .SYNOPSIS
        Delete Rewrite configuration Object.
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to rewritepolicylabel.
    .PARAMETER Labelname 
        Name of the rewrite policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the rewrite policy to bind to the policy label. 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteRewritepolicylabelrewritepolicybinding -Labelname <string>
        An example how to delete rewritepolicylabel_rewritepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteRewritepolicylabelrewritepolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicylabel_rewritepolicy_binding/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Labelname,

        [string]$Policyname,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteRewritepolicylabelrewritepolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Rewrite configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type rewritepolicylabel_rewritepolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteRewritepolicylabelrewritepolicybinding: Finished"
    }
}

function Invoke-ADCGetRewritepolicylabelrewritepolicybinding {
    <#
    .SYNOPSIS
        Get Rewrite configuration object(s).
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to rewritepolicylabel.
    .PARAMETER Labelname 
        Name of the rewrite policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all rewritepolicylabel_rewritepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the rewritepolicylabel_rewritepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicylabelrewritepolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicylabelrewritepolicybinding -GetAll 
        Get all rewritepolicylabel_rewritepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicylabelrewritepolicybinding -Count 
        Get the number of rewritepolicylabel_rewritepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicylabelrewritepolicybinding -name <string>
        Get rewritepolicylabel_rewritepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicylabelrewritepolicybinding -Filter @{ 'name'='<value>' }
        Get rewritepolicylabel_rewritepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRewritepolicylabelrewritepolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicylabel_rewritepolicy_binding/
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
        [string]$Labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetRewritepolicylabelrewritepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all rewritepolicylabel_rewritepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel_rewritepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rewritepolicylabel_rewritepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel_rewritepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rewritepolicylabel_rewritepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel_rewritepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rewritepolicylabel_rewritepolicy_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel_rewritepolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rewritepolicylabel_rewritepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicylabel_rewritepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRewritepolicylabelrewritepolicybinding: Ended"
    }
}

function Invoke-ADCGetRewritepolicybinding {
    <#
    .SYNOPSIS
        Get Rewrite configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to rewritepolicy.
    .PARAMETER Name 
        Name of the rewrite policy. 
    .PARAMETER GetAll 
        Retrieve all rewritepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the rewritepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicybinding -GetAll 
        Get all rewritepolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicybinding -name <string>
        Get rewritepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicybinding -Filter @{ 'name'='<value>' }
        Get rewritepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRewritepolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicy_binding/
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
        [string]$Name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetRewritepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all rewritepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rewritepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rewritepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rewritepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rewritepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRewritepolicybinding: Ended"
    }
}

function Invoke-ADCGetRewritepolicycsvserverbinding {
    <#
    .SYNOPSIS
        Get Rewrite configuration object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to rewritepolicy.
    .PARAMETER Name 
        Name of the rewrite policy. 
    .PARAMETER GetAll 
        Retrieve all rewritepolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the rewritepolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicycsvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicycsvserverbinding -GetAll 
        Get all rewritepolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicycsvserverbinding -Count 
        Get the number of rewritepolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicycsvserverbinding -name <string>
        Get rewritepolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicycsvserverbinding -Filter @{ 'name'='<value>' }
        Get rewritepolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRewritepolicycsvserverbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicy_csvserver_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetRewritepolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all rewritepolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rewritepolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rewritepolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rewritepolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rewritepolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRewritepolicycsvserverbinding: Ended"
    }
}

function Invoke-ADCGetRewritepolicylbvserverbinding {
    <#
    .SYNOPSIS
        Get Rewrite configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to rewritepolicy.
    .PARAMETER Name 
        Name of the rewrite policy. 
    .PARAMETER GetAll 
        Retrieve all rewritepolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the rewritepolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicylbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicylbvserverbinding -GetAll 
        Get all rewritepolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicylbvserverbinding -Count 
        Get the number of rewritepolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicylbvserverbinding -name <string>
        Get rewritepolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicylbvserverbinding -Filter @{ 'name'='<value>' }
        Get rewritepolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRewritepolicylbvserverbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicy_lbvserver_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetRewritepolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all rewritepolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rewritepolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rewritepolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rewritepolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rewritepolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRewritepolicylbvserverbinding: Ended"
    }
}

function Invoke-ADCGetRewritepolicyrewriteglobalbinding {
    <#
    .SYNOPSIS
        Get Rewrite configuration object(s).
    .DESCRIPTION
        Binding object showing the rewriteglobal that can be bound to rewritepolicy.
    .PARAMETER Name 
        Name of the rewrite policy. 
    .PARAMETER GetAll 
        Retrieve all rewritepolicy_rewriteglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the rewritepolicy_rewriteglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicyrewriteglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicyrewriteglobalbinding -GetAll 
        Get all rewritepolicy_rewriteglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicyrewriteglobalbinding -Count 
        Get the number of rewritepolicy_rewriteglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicyrewriteglobalbinding -name <string>
        Get rewritepolicy_rewriteglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicyrewriteglobalbinding -Filter @{ 'name'='<value>' }
        Get rewritepolicy_rewriteglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRewritepolicyrewriteglobalbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicy_rewriteglobal_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetRewritepolicyrewriteglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all rewritepolicy_rewriteglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_rewriteglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rewritepolicy_rewriteglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_rewriteglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rewritepolicy_rewriteglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_rewriteglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rewritepolicy_rewriteglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_rewriteglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rewritepolicy_rewriteglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_rewriteglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRewritepolicyrewriteglobalbinding: Ended"
    }
}

function Invoke-ADCGetRewritepolicyrewritepolicylabelbinding {
    <#
    .SYNOPSIS
        Get Rewrite configuration object(s).
    .DESCRIPTION
        Binding object showing the rewritepolicylabel that can be bound to rewritepolicy.
    .PARAMETER Name 
        Name of the rewrite policy. 
    .PARAMETER GetAll 
        Retrieve all rewritepolicy_rewritepolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the rewritepolicy_rewritepolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicyrewritepolicylabelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicyrewritepolicylabelbinding -GetAll 
        Get all rewritepolicy_rewritepolicylabel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicyrewritepolicylabelbinding -Count 
        Get the number of rewritepolicy_rewritepolicylabel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicyrewritepolicylabelbinding -name <string>
        Get rewritepolicy_rewritepolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicyrewritepolicylabelbinding -Filter @{ 'name'='<value>' }
        Get rewritepolicy_rewritepolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRewritepolicyrewritepolicylabelbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicy_rewritepolicylabel_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetRewritepolicyrewritepolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all rewritepolicy_rewritepolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_rewritepolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rewritepolicy_rewritepolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_rewritepolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rewritepolicy_rewritepolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_rewritepolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rewritepolicy_rewritepolicylabel_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_rewritepolicylabel_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rewritepolicy_rewritepolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_rewritepolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRewritepolicyrewritepolicylabelbinding: Ended"
    }
}

function Invoke-ADCGetRewritepolicyvpnvserverbinding {
    <#
    .SYNOPSIS
        Get Rewrite configuration object(s).
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to rewritepolicy.
    .PARAMETER Name 
        Name of the rewrite policy. 
    .PARAMETER GetAll 
        Retrieve all rewritepolicy_vpnvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the rewritepolicy_vpnvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicyvpnvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicyvpnvserverbinding -GetAll 
        Get all rewritepolicy_vpnvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRewritepolicyvpnvserverbinding -Count 
        Get the number of rewritepolicy_vpnvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicyvpnvserverbinding -name <string>
        Get rewritepolicy_vpnvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRewritepolicyvpnvserverbinding -Filter @{ 'name'='<value>' }
        Get rewritepolicy_vpnvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRewritepolicyvpnvserverbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/rewrite/rewritepolicy_vpnvserver_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetRewritepolicyvpnvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all rewritepolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for rewritepolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving rewritepolicy_vpnvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving rewritepolicy_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving rewritepolicy_vpnvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type rewritepolicy_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRewritepolicyvpnvserverbinding: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDwl3OPEhinRyL3
# xS/tyTLnxSUHq8HI079xVUIbCGhRAqCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
# i/247uUvWN5TMA0GCSqGSIb3DQEBCwUAMHwxCzAJBgNVBAYTAkdCMRswGQYDVQQI
# ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoT
# D1NlY3RpZ28gTGltaXRlZDEkMCIGA1UEAxMbU2VjdGlnbyBSU0EgQ29kZSBTaWdu
# aW5nIENBMB4XDTIxMDUwNTAwMDAwMFoXDTI0MDUwNDIzNTk1OVowWzELMAkGA1UE
# BhMCTkwxEjAQBgNVBAcMCVZlbGRob3ZlbjEbMBkGA1UECgwSSm9oYW5uZXMgQmls
# bGVrZW5zMRswGQYDVQQDDBJKb2hhbm5lcyBCaWxsZWtlbnMwggEiMA0GCSqGSIb3
# DQEBAQUAA4IBDwAwggEKAoIBAQCsfgRG81keOHalHfCUgxOa1Qy4VNOnGxB8SL8e
# rjP9SfcF13McP7F1HGka5Be495pTZ+duGbaQMNozwg/5Dg9IRJEeBabeSSJJCbZo
# SNpmUu7NNRRfidQxlPC81LxTVHxJ7In0MEfCVm7rWcri28MRCAuafqOfSE+hyb1Z
# /tKyCyQ5RUq3kjs/CF+VfMHsJn6ZT63YqewRkwHuc7UogTTZKjhPJ9prGLTer8UX
# UgvsGRbvhYZXIEuy+bmx/iJ1yRl1kX4nj6gUYzlhemOnlSDD66YOrkLDhXPMXLym
# AN7h0/W5Bo//R5itgvdGBkXkWCKRASnq/9PTcoxW6mwtgU8xAgMBAAGjggGQMIIB
# jDAfBgNVHSMEGDAWgBQO4TqoUzox1Yq+wbutZxoDha00DjAdBgNVHQ4EFgQUZWMy
# gC0i1u2NZ1msk2Mm5nJm5AswDgYDVR0PAQH/BAQDAgeAMAwGA1UdEwEB/wQCMAAw
# EwYDVR0lBAwwCgYIKwYBBQUHAwMwEQYJYIZIAYb4QgEBBAQDAgQQMEoGA1UdIARD
# MEEwNQYMKwYBBAGyMQECAQMCMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
# by5jb20vQ1BTMAgGBmeBDAEEATBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3Js
# LnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDb2RlU2lnbmluZ0NBLmNybDBzBggrBgEF
# BQcBAQRnMGUwPgYIKwYBBQUHMAKGMmh0dHA6Ly9jcnQuc2VjdGlnby5jb20vU2Vj
# dGlnb1JTQUNvZGVTaWduaW5nQ0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2Nz
# cC5zZWN0aWdvLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEARjv9ieRocb1DXRWm3XtY
# jjuSRjlvkoPd9wS6DNfsGlSU42BFd9LCKSyRREZVu8FDq7dN0PhD4bBTT+k6AgrY
# KG6f/8yUponOdxskv850SjN2S2FeVuR20pqActMrpd1+GCylG8mj8RGjdrLQ3QuX
# qYKS68WJ39WWYdVB/8Ftajir5p6sAfwHErLhbJS6WwmYjGI/9SekossvU8mZjZwo
# Gbu+fjZhPc4PhjbEh0ABSsPMfGjQQsg5zLFjg/P+cS6hgYI7qctToo0TexGe32DY
# fFWHrHuBErW2qXEJvzSqM5OtLRD06a4lH5ZkhojhMOX9S8xDs/ArDKgX1j1Xm4Tu
# DjCCBYEwggRpoAMCAQICEDlyRDr5IrdR19NsEN0xNZUwDQYJKoZIhvcNAQEMBQAw
# ezELMAkGA1UEBhMCR0IxGzAZBgNVBAgMEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
# A1UEBwwHU2FsZm9yZDEaMBgGA1UECgwRQ29tb2RvIENBIExpbWl0ZWQxITAfBgNV
# BAMMGEFBQSBDZXJ0aWZpY2F0ZSBTZXJ2aWNlczAeFw0xOTAzMTIwMDAwMDBaFw0y
# ODEyMzEyMzU5NTlaMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEplcnNl
# eTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1Qg
# TmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1
# dGhvcml0eTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAIASZRc2DsPb
# CLPQrFcNdu3NJ9NMrVCDYeKqIE0JLWQJ3M6Jn8w9qez2z8Hc8dOx1ns3KBErR9o5
# xrw6GbRfpr19naNjQrZ28qk7K5H44m/Q7BYgkAk+4uh0yRi0kdRiZNt/owbxiBhq
# kCI8vP4T8IcUe/bkH47U5FHGEWdGCFHLhhRUP7wz/n5snP8WnRi9UY41pqdmyHJn
# 2yFmsdSbeAPAUDrozPDcvJ5M/q8FljUfV1q3/875PbcstvZU3cjnEjpNrkyKt1ya
# tLcgPcp/IjSufjtoZgFE5wFORlObM2D3lL5TN5BzQ/Myw1Pv26r+dE5px2uMYJPe
# xMcM3+EyrsyTO1F4lWeL7j1W/gzQaQ8bD/MlJmszbfduR/pzQ+V+DqVmsSl8MoRj
# VYnEDcGTVDAZE6zTfTen6106bDVc20HXEtqpSQvf2ICKCZNijrVmzyWIzYS4sT+k
# OQ/ZAp7rEkyVfPNrBaleFoPMuGfi6BOdzFuC00yz7Vv/3uVzrCM7LQC/NVV0CUnY
# SVgaf5I25lGSDvMmfRxNF7zJ7EMm0L9BX0CpRET0medXh55QH1dUqD79dGMvsVBl
# CeZYQi5DGky08CVHWfoEHpPUJkZKUIGy3r54t/xnFeHJV4QeD2PW6WK61l9VLupc
# xigIBCU5uA4rqfJMlxwHPw1S9e3vL4IPAgMBAAGjgfIwge8wHwYDVR0jBBgwFoAU
# oBEKIz6W8Qfs4q8p74Klf9AwpLQwHQYDVR0OBBYEFFN5v1qqK0rPVIDh2JvAnfKy
# A2bLMA4GA1UdDwEB/wQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MBEGA1UdIAQKMAgw
# BgYEVR0gADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLmNvbW9kb2NhLmNv
# bS9BQUFDZXJ0aWZpY2F0ZVNlcnZpY2VzLmNybDA0BggrBgEFBQcBAQQoMCYwJAYI
# KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwF
# AAOCAQEAGIdR3HQhPZyK4Ce3M9AuzOzw5steEd4ib5t1jp5y/uTW/qofnJYt7wNK
# fq70jW9yPEM7wD/ruN9cqqnGrvL82O6je0P2hjZ8FODN9Pc//t64tIrwkZb+/UNk
# fv3M0gGhfX34GRnJQisTv1iLuqSiZgR2iJFODIkUzqJNyTKzuugUGrxx8VvwQQuY
# AAoiAxDlDLH5zZI3Ge078eQ6tvlFEyZ1r7uq7z97dzvSxAKRPRkA0xdcOds/exgN
# Rc2ThZYvXd9ZFk8/Ub3VRRg/7UqO6AZhdCMWtQ1QcydER38QXYkqa4UxFMToqWpM
# gLxqeM+4f452cpkMnf7XkQgWoaNflTCCBfUwggPdoAMCAQICEB2iSDBvmyYY0ILg
# ln0z02owDQYJKoZIhvcNAQEMBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpO
# ZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVT
# RVJUUlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmlj
# YXRpb24gQXV0aG9yaXR5MB4XDTE4MTEwMjAwMDAwMFoXDTMwMTIzMTIzNTk1OVow
# fDELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
# A1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSQwIgYDVQQD
# ExtTZWN0aWdvIFJTQSBDb2RlIFNpZ25pbmcgQ0EwggEiMA0GCSqGSIb3DQEBAQUA
# A4IBDwAwggEKAoIBAQCGIo0yhXoYn0nwli9jCB4t3HyfFM/jJrYlZilAhlRGdDFi
# xRDtsocnppnLlTDAVvWkdcapDlBipVGREGrgS2Ku/fD4GKyn/+4uMyD6DBmJqGx7
# rQDDYaHcaWVtH24nlteXUYam9CflfGqLlR5bYNV+1xaSnAAvaPeX7Wpyvjg7Y96P
# v25MQV0SIAhZ6DnNj9LWzwa0VwW2TqE+V2sfmLzEYtYbC43HZhtKn52BxHJAteJf
# 7wtF/6POF6YtVbC3sLxUap28jVZTxvC6eVBJLPcDuf4vZTXyIuosB69G2flGHNyM
# fHEo8/6nxhTdVZFuihEN3wYklX0Pp6F8OtqGNWHTAgMBAAGjggFkMIIBYDAfBgNV
# HSMEGDAWgBRTeb9aqitKz1SA4dibwJ3ysgNmyzAdBgNVHQ4EFgQUDuE6qFM6MdWK
# vsG7rWcaA4WtNA4wDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAw
# HQYDVR0lBBYwFAYIKwYBBQUHAwMGCCsGAQUFBwMIMBEGA1UdIAQKMAgwBgYEVR0g
# ADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNF
# UlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEE
# ajBoMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRy
# dXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVz
# ZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggIBAE1jUO1HNEphpNveaiqMm/EA
# AB4dYns61zLC9rPgY7P7YQCImhttEAcET7646ol4IusPRuzzRl5ARokS9At3Wpwq
# QTr81vTr5/cVlTPDoYMot94v5JT3hTODLUpASL+awk9KsY8k9LOBN9O3ZLCmI2pZ
# aFJCX/8E6+F0ZXkI9amT3mtxQJmWunjxucjiwwgWsatjWsgVgG10Xkp1fqW4w2y1
# z99KeYdcx0BNYzX2MNPPtQoOCwR/oEuuu6Ol0IQAkz5TXTSlADVpbL6fICUQDRn7
# UJBhvjmPeo5N9p8OHv4HURJmgyYZSJXOSsnBf/M6BZv5b9+If8AjntIeQ3pFMcGc
# TanwWbJZGehqjSkEAnd8S0vNcL46slVaeD68u28DECV3FTSK+TbMQ5Lkuk/xYpMo
# JVcp+1EZx6ElQGqEV8aynbG8HArafGd+fS7pKEwYfsR7MUFxmksp7As9V1DSyt39
# ngVR5UR43QHesXWYDVQk/fBO4+L4g71yuss9Ou7wXheSaG3IYfmm8SoKC6W59J7u
# mDIFhZ7r+YMp08Ysfb06dy6LN0KgaoLtO0qqlBCk4Q34F8W2WnkzGJLjtXX4oemO
# CiUe5B7xn1qHI/+fpFGe+zmAEc3btcSnqIBv5VPU4OOiwtJbGvoyJi1qV3AcPKRY
# LqPzW0sH3DJZ84enGm1YMYICQzCCAj8CAQEwgZAwfDELMAkGA1UEBhMCR0IxGzAZ
# BgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
# A1UEChMPU2VjdGlnbyBMaW1pdGVkMSQwIgYDVQQDExtTZWN0aWdvIFJTQSBDb2Rl
# IFNpZ25pbmcgQ0ECECwnTfNkELSL/bju5S9Y3lMwDQYJYIZIAWUDBAIBBQCggYQw
# GAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGC
# NwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQx
# IgQgYItGlNGY/b4yeeyAgIFQ/dTEzQcZz1C8N0TumyfleZkwDQYJKoZIhvcNAQEB
# BQAEggEAfoVaOE5q9eeTrHGMrADfv4SUuouchM6WRgAFTpnzrvcvMStxQV0uVEIj
# nhTarH+KrGiUbIMPhKH8KCfFxomUkX393WkunCDB6aS1tVBvo6miEjZ40L86//0F
# dfLzAtJuPH69vbfkHfz+8am/1AM59/Z8JyWSvHikZ3q9MXuPOmAR03QTxbgs+Sw8
# 3qHGXV9bDgfvlOQthjE30Labwv4dxbZMbFNPjIc/+O4a6fWWqnXMs1BHaWHJcPaP
# guUNioCBoj7Fdh20mOSHcT8tuBrarUTyz30V7fVszBBtmb4xWMKhkjoECPkGFb5K
# 6nMSziobIyl11c4ijpgaM/TLqIrPVw==
# SIG # End signature block
