function Invoke-ADCAddCachecontentgroup {
<#
    .SYNOPSIS
        Add Integrated Caching configuration Object
    .DESCRIPTION
        Add Integrated Caching configuration Object 
    .PARAMETER name 
        Name for the content group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the content group is created.  
        Minimum length = 1 
    .PARAMETER weakposrelexpiry 
        Relative expiry time, in seconds, for expiring positive responses with response codes between 200 and 399. Cannot be used in combination with other Expiry attributes. Similar to -relExpiry but has lower precedence.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER heurexpiryparam 
        Heuristic expiry time, in percent of the duration, since the object was last modified.  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER relexpiry 
        Relative expiry time, in seconds, after which to expire an object cached in this content group.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER relexpirymillisec 
        Relative expiry time, in milliseconds, after which to expire an object cached in this content group.  
        Minimum value = 0  
        Maximum value = 86400000 
    .PARAMETER absexpiry 
        Local time, up to 4 times a day, at which all objects in the content group must expire.  
        CLI Users:  
        For example, to specify that the objects in the content group should expire by 11:00 PM, type the following command: add cache contentgroup <contentgroup name> -absexpiry 23:00  
        To specify that the objects in the content group should expire at 10:00 AM, 3 PM, 6 PM, and 11:00 PM, type: add cache contentgroup <contentgroup name> -absexpiry 10:00 15:00 18:00 23:00. 
    .PARAMETER absexpirygmt 
        Coordinated Universal Time (GMT), up to 4 times a day, when all objects in the content group must expire. 
    .PARAMETER weaknegrelexpiry 
        Relative expiry time, in seconds, for expiring negative responses. This value is used only if the expiry time cannot be determined from any other source. It is applicable only to the following status codes: 307, 403, 404, and 410.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER hitparams 
        Parameters to use for parameterized hit evaluation of an object. Up to 128 parameters can be specified. Mutually exclusive with the Hit Selector parameter.  
        Minimum length = 1 
    .PARAMETER invalparams 
        Parameters for parameterized invalidation of an object. You can specify up to 8 parameters. Mutually exclusive with invalSelector.  
        Minimum length = 1 
    .PARAMETER ignoreparamvaluecase 
        Ignore case when comparing parameter values during parameterized hit evaluation. (Parameter value case is ignored by default during parameterized invalidation.).  
        Possible values = YES, NO 
    .PARAMETER matchcookies 
        Evaluate for parameters in the cookie header also.  
        Possible values = YES, NO 
    .PARAMETER invalrestrictedtohost 
        Take the host header into account during parameterized invalidation.  
        Possible values = YES, NO 
    .PARAMETER polleverytime 
        Always poll for the objects in this content group. That is, retrieve the objects from the origin server whenever they are requested.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER ignorereloadreq 
        Ignore any request to reload a cached object from the origin server.  
        To guard against Denial of Service attacks, set this parameter to YES. For RFC-compliant behavior, set it to NO.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER removecookies 
        Remove cookies from responses.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER prefetch 
        Attempt to refresh objects that are about to go stale.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER prefetchperiod 
        Time period, in seconds before an object's calculated expiry time, during which to attempt prefetch.  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER prefetchperiodmillisec 
        Time period, in milliseconds before an object's calculated expiry time, during which to attempt prefetch.  
        Minimum value = 0  
        Maximum value = 4294967290 
    .PARAMETER prefetchmaxpending 
        Maximum number of outstanding prefetches that can be queued for the content group.  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER flashcache 
        Perform flash cache. Mutually exclusive with Poll Every Time (PET) on the same content group.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER expireatlastbyte 
        Force expiration of the content immediately after the response is downloaded (upon receipt of the last byte of the response body). Applicable only to positive responses.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER insertvia 
        Insert a Via header into the response.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER insertage 
        Insert an Age header into the response. An Age header contains information about the age of the object, in seconds, as calculated by the integrated cache.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER insertetag 
        Insert an ETag header in the response. With ETag header insertion, the integrated cache does not serve full responses on repeat requests.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER cachecontrol 
        Insert a Cache-Control header into the response.  
        Minimum length = 1 
    .PARAMETER quickabortsize 
        If the size of an object that is being downloaded is less than or equal to the quick abort value, and a client aborts during the download, the cache stops downloading the response. If the object is larger than the quick abort size, the cache continues to download the response.  
        Default value: 4194303  
        Minimum value = 0  
        Maximum value = 4194303 
    .PARAMETER minressize 
        Minimum size of a response that can be cached in this content group.  
        Default minimum response size is 0.  
        Minimum value = 0  
        Maximum value = 2097151 
    .PARAMETER maxressize 
        Maximum size of a response that can be cached in this content group.  
        Default value: 80  
        Minimum value = 0  
        Maximum value = 2097151 
    .PARAMETER memlimit 
        Maximum amount of memory that the cache can use. The effective limit is based on the available memory of the Citrix ADC.  
        Default value: 65536 
    .PARAMETER ignorereqcachinghdrs 
        Ignore Cache-Control and Pragma headers in the incoming request.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER minhits 
        Number of hits that qualifies a response for storage in this content group.  
        Default value: 0 
    .PARAMETER alwaysevalpolicies 
        Force policy evaluation for each response arriving from the origin server. Cannot be set to YES if the Prefetch parameter is also set to YES.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER persistha 
        Setting persistHA to YES causes IC to save objects in contentgroup to Secondary node in HA deployment.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER pinned 
        Do not flush objects from this content group under memory pressure.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER lazydnsresolve 
        Perform DNS resolution for responses only if the destination IP address in the request does not match the destination IP address of the cached response.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER hitselector 
        Selector for evaluating whether an object gets stored in a particular content group. A selector is an abstraction for a collection of PIXL expressions. 
    .PARAMETER invalselector 
        Selector for invalidating objects in the content group. A selector is an abstraction for a collection of PIXL expressions. 
    .PARAMETER type 
        The type of the content group.  
        Default value: HTTP  
        Possible values = HTTP, MYSQL, MSSQL 
    .PARAMETER PassThru 
        Return details about the created cachecontentgroup item.
    .EXAMPLE
        Invoke-ADCAddCachecontentgroup -name <string>
    .NOTES
        File Name : Invoke-ADCAddCachecontentgroup
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachecontentgroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [ValidateRange(0, 31536000)]
        [double]$weakposrelexpiry ,

        [ValidateRange(0, 100)]
        [double]$heurexpiryparam ,

        [ValidateRange(0, 31536000)]
        [double]$relexpiry ,

        [ValidateRange(0, 86400000)]
        [double]$relexpirymillisec ,

        [string[]]$absexpiry ,

        [string[]]$absexpirygmt ,

        [ValidateRange(0, 31536000)]
        [double]$weaknegrelexpiry ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$hitparams ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$invalparams ,

        [ValidateSet('YES', 'NO')]
        [string]$ignoreparamvaluecase ,

        [ValidateSet('YES', 'NO')]
        [string]$matchcookies ,

        [ValidateSet('YES', 'NO')]
        [string]$invalrestrictedtohost ,

        [ValidateSet('YES', 'NO')]
        [string]$polleverytime = 'NO' ,

        [ValidateSet('YES', 'NO')]
        [string]$ignorereloadreq = 'YES' ,

        [ValidateSet('YES', 'NO')]
        [string]$removecookies = 'YES' ,

        [ValidateSet('YES', 'NO')]
        [string]$prefetch = 'YES' ,

        [ValidateRange(0, 4294967294)]
        [double]$prefetchperiod ,

        [ValidateRange(0, 4294967290)]
        [double]$prefetchperiodmillisec ,

        [ValidateRange(0, 4294967294)]
        [double]$prefetchmaxpending ,

        [ValidateSet('YES', 'NO')]
        [string]$flashcache = 'NO' ,

        [ValidateSet('YES', 'NO')]
        [string]$expireatlastbyte = 'NO' ,

        [ValidateSet('YES', 'NO')]
        [string]$insertvia = 'YES' ,

        [ValidateSet('YES', 'NO')]
        [string]$insertage = 'YES' ,

        [ValidateSet('YES', 'NO')]
        [string]$insertetag = 'YES' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cachecontrol ,

        [ValidateRange(0, 4194303)]
        [double]$quickabortsize = '4194303' ,

        [ValidateRange(0, 2097151)]
        [double]$minressize ,

        [ValidateRange(0, 2097151)]
        [double]$maxressize = '80' ,

        [double]$memlimit = '65536' ,

        [ValidateSet('YES', 'NO')]
        [string]$ignorereqcachinghdrs = 'YES' ,

        [int]$minhits = '0' ,

        [ValidateSet('YES', 'NO')]
        [string]$alwaysevalpolicies = 'NO' ,

        [ValidateSet('YES', 'NO')]
        [string]$persistha = 'NO' ,

        [ValidateSet('YES', 'NO')]
        [string]$pinned = 'NO' ,

        [ValidateSet('YES', 'NO')]
        [string]$lazydnsresolve = 'YES' ,

        [string]$hitselector ,

        [string]$invalselector ,

        [ValidateSet('HTTP', 'MYSQL', 'MSSQL')]
        [string]$type = 'HTTP' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCachecontentgroup: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('weakposrelexpiry')) { $Payload.Add('weakposrelexpiry', $weakposrelexpiry) }
            if ($PSBoundParameters.ContainsKey('heurexpiryparam')) { $Payload.Add('heurexpiryparam', $heurexpiryparam) }
            if ($PSBoundParameters.ContainsKey('relexpiry')) { $Payload.Add('relexpiry', $relexpiry) }
            if ($PSBoundParameters.ContainsKey('relexpirymillisec')) { $Payload.Add('relexpirymillisec', $relexpirymillisec) }
            if ($PSBoundParameters.ContainsKey('absexpiry')) { $Payload.Add('absexpiry', $absexpiry) }
            if ($PSBoundParameters.ContainsKey('absexpirygmt')) { $Payload.Add('absexpirygmt', $absexpirygmt) }
            if ($PSBoundParameters.ContainsKey('weaknegrelexpiry')) { $Payload.Add('weaknegrelexpiry', $weaknegrelexpiry) }
            if ($PSBoundParameters.ContainsKey('hitparams')) { $Payload.Add('hitparams', $hitparams) }
            if ($PSBoundParameters.ContainsKey('invalparams')) { $Payload.Add('invalparams', $invalparams) }
            if ($PSBoundParameters.ContainsKey('ignoreparamvaluecase')) { $Payload.Add('ignoreparamvaluecase', $ignoreparamvaluecase) }
            if ($PSBoundParameters.ContainsKey('matchcookies')) { $Payload.Add('matchcookies', $matchcookies) }
            if ($PSBoundParameters.ContainsKey('invalrestrictedtohost')) { $Payload.Add('invalrestrictedtohost', $invalrestrictedtohost) }
            if ($PSBoundParameters.ContainsKey('polleverytime')) { $Payload.Add('polleverytime', $polleverytime) }
            if ($PSBoundParameters.ContainsKey('ignorereloadreq')) { $Payload.Add('ignorereloadreq', $ignorereloadreq) }
            if ($PSBoundParameters.ContainsKey('removecookies')) { $Payload.Add('removecookies', $removecookies) }
            if ($PSBoundParameters.ContainsKey('prefetch')) { $Payload.Add('prefetch', $prefetch) }
            if ($PSBoundParameters.ContainsKey('prefetchperiod')) { $Payload.Add('prefetchperiod', $prefetchperiod) }
            if ($PSBoundParameters.ContainsKey('prefetchperiodmillisec')) { $Payload.Add('prefetchperiodmillisec', $prefetchperiodmillisec) }
            if ($PSBoundParameters.ContainsKey('prefetchmaxpending')) { $Payload.Add('prefetchmaxpending', $prefetchmaxpending) }
            if ($PSBoundParameters.ContainsKey('flashcache')) { $Payload.Add('flashcache', $flashcache) }
            if ($PSBoundParameters.ContainsKey('expireatlastbyte')) { $Payload.Add('expireatlastbyte', $expireatlastbyte) }
            if ($PSBoundParameters.ContainsKey('insertvia')) { $Payload.Add('insertvia', $insertvia) }
            if ($PSBoundParameters.ContainsKey('insertage')) { $Payload.Add('insertage', $insertage) }
            if ($PSBoundParameters.ContainsKey('insertetag')) { $Payload.Add('insertetag', $insertetag) }
            if ($PSBoundParameters.ContainsKey('cachecontrol')) { $Payload.Add('cachecontrol', $cachecontrol) }
            if ($PSBoundParameters.ContainsKey('quickabortsize')) { $Payload.Add('quickabortsize', $quickabortsize) }
            if ($PSBoundParameters.ContainsKey('minressize')) { $Payload.Add('minressize', $minressize) }
            if ($PSBoundParameters.ContainsKey('maxressize')) { $Payload.Add('maxressize', $maxressize) }
            if ($PSBoundParameters.ContainsKey('memlimit')) { $Payload.Add('memlimit', $memlimit) }
            if ($PSBoundParameters.ContainsKey('ignorereqcachinghdrs')) { $Payload.Add('ignorereqcachinghdrs', $ignorereqcachinghdrs) }
            if ($PSBoundParameters.ContainsKey('minhits')) { $Payload.Add('minhits', $minhits) }
            if ($PSBoundParameters.ContainsKey('alwaysevalpolicies')) { $Payload.Add('alwaysevalpolicies', $alwaysevalpolicies) }
            if ($PSBoundParameters.ContainsKey('persistha')) { $Payload.Add('persistha', $persistha) }
            if ($PSBoundParameters.ContainsKey('pinned')) { $Payload.Add('pinned', $pinned) }
            if ($PSBoundParameters.ContainsKey('lazydnsresolve')) { $Payload.Add('lazydnsresolve', $lazydnsresolve) }
            if ($PSBoundParameters.ContainsKey('hitselector')) { $Payload.Add('hitselector', $hitselector) }
            if ($PSBoundParameters.ContainsKey('invalselector')) { $Payload.Add('invalselector', $invalselector) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
 
            if ($PSCmdlet.ShouldProcess("cachecontentgroup", "Add Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cachecontentgroup -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCachecontentgroup -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddCachecontentgroup: Finished"
    }
}

function Invoke-ADCDeleteCachecontentgroup {
<#
    .SYNOPSIS
        Delete Integrated Caching configuration Object
    .DESCRIPTION
        Delete Integrated Caching configuration Object
    .PARAMETER name 
       Name for the content group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the content group is created.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteCachecontentgroup -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCachecontentgroup
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachecontentgroup/
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
        [string]$name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCachecontentgroup: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Integrated Caching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type cachecontentgroup -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteCachecontentgroup: Finished"
    }
}

function Invoke-ADCUpdateCachecontentgroup {
<#
    .SYNOPSIS
        Update Integrated Caching configuration Object
    .DESCRIPTION
        Update Integrated Caching configuration Object 
    .PARAMETER name 
        Name for the content group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the content group is created.  
        Minimum length = 1 
    .PARAMETER weakposrelexpiry 
        Relative expiry time, in seconds, for expiring positive responses with response codes between 200 and 399. Cannot be used in combination with other Expiry attributes. Similar to -relExpiry but has lower precedence.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER heurexpiryparam 
        Heuristic expiry time, in percent of the duration, since the object was last modified.  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER relexpiry 
        Relative expiry time, in seconds, after which to expire an object cached in this content group.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER relexpirymillisec 
        Relative expiry time, in milliseconds, after which to expire an object cached in this content group.  
        Minimum value = 0  
        Maximum value = 86400000 
    .PARAMETER absexpiry 
        Local time, up to 4 times a day, at which all objects in the content group must expire.  
        CLI Users:  
        For example, to specify that the objects in the content group should expire by 11:00 PM, type the following command: add cache contentgroup <contentgroup name> -absexpiry 23:00  
        To specify that the objects in the content group should expire at 10:00 AM, 3 PM, 6 PM, and 11:00 PM, type: add cache contentgroup <contentgroup name> -absexpiry 10:00 15:00 18:00 23:00. 
    .PARAMETER absexpirygmt 
        Coordinated Universal Time (GMT), up to 4 times a day, when all objects in the content group must expire. 
    .PARAMETER weaknegrelexpiry 
        Relative expiry time, in seconds, for expiring negative responses. This value is used only if the expiry time cannot be determined from any other source. It is applicable only to the following status codes: 307, 403, 404, and 410.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER hitparams 
        Parameters to use for parameterized hit evaluation of an object. Up to 128 parameters can be specified. Mutually exclusive with the Hit Selector parameter.  
        Minimum length = 1 
    .PARAMETER invalparams 
        Parameters for parameterized invalidation of an object. You can specify up to 8 parameters. Mutually exclusive with invalSelector.  
        Minimum length = 1 
    .PARAMETER ignoreparamvaluecase 
        Ignore case when comparing parameter values during parameterized hit evaluation. (Parameter value case is ignored by default during parameterized invalidation.).  
        Possible values = YES, NO 
    .PARAMETER matchcookies 
        Evaluate for parameters in the cookie header also.  
        Possible values = YES, NO 
    .PARAMETER invalrestrictedtohost 
        Take the host header into account during parameterized invalidation.  
        Possible values = YES, NO 
    .PARAMETER polleverytime 
        Always poll for the objects in this content group. That is, retrieve the objects from the origin server whenever they are requested.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER ignorereloadreq 
        Ignore any request to reload a cached object from the origin server.  
        To guard against Denial of Service attacks, set this parameter to YES. For RFC-compliant behavior, set it to NO.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER removecookies 
        Remove cookies from responses.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER prefetch 
        Attempt to refresh objects that are about to go stale.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER prefetchperiod 
        Time period, in seconds before an object's calculated expiry time, during which to attempt prefetch.  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER prefetchperiodmillisec 
        Time period, in milliseconds before an object's calculated expiry time, during which to attempt prefetch.  
        Minimum value = 0  
        Maximum value = 4294967290 
    .PARAMETER prefetchmaxpending 
        Maximum number of outstanding prefetches that can be queued for the content group.  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER flashcache 
        Perform flash cache. Mutually exclusive with Poll Every Time (PET) on the same content group.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER expireatlastbyte 
        Force expiration of the content immediately after the response is downloaded (upon receipt of the last byte of the response body). Applicable only to positive responses.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER insertvia 
        Insert a Via header into the response.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER insertage 
        Insert an Age header into the response. An Age header contains information about the age of the object, in seconds, as calculated by the integrated cache.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER insertetag 
        Insert an ETag header in the response. With ETag header insertion, the integrated cache does not serve full responses on repeat requests.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER cachecontrol 
        Insert a Cache-Control header into the response.  
        Minimum length = 1 
    .PARAMETER quickabortsize 
        If the size of an object that is being downloaded is less than or equal to the quick abort value, and a client aborts during the download, the cache stops downloading the response. If the object is larger than the quick abort size, the cache continues to download the response.  
        Default value: 4194303  
        Minimum value = 0  
        Maximum value = 4194303 
    .PARAMETER minressize 
        Minimum size of a response that can be cached in this content group.  
        Default minimum response size is 0.  
        Minimum value = 0  
        Maximum value = 2097151 
    .PARAMETER maxressize 
        Maximum size of a response that can be cached in this content group.  
        Default value: 80  
        Minimum value = 0  
        Maximum value = 2097151 
    .PARAMETER memlimit 
        Maximum amount of memory that the cache can use. The effective limit is based on the available memory of the Citrix ADC.  
        Default value: 65536 
    .PARAMETER ignorereqcachinghdrs 
        Ignore Cache-Control and Pragma headers in the incoming request.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER minhits 
        Number of hits that qualifies a response for storage in this content group.  
        Default value: 0 
    .PARAMETER alwaysevalpolicies 
        Force policy evaluation for each response arriving from the origin server. Cannot be set to YES if the Prefetch parameter is also set to YES.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER persistha 
        Setting persistHA to YES causes IC to save objects in contentgroup to Secondary node in HA deployment.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER pinned 
        Do not flush objects from this content group under memory pressure.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER lazydnsresolve 
        Perform DNS resolution for responses only if the destination IP address in the request does not match the destination IP address of the cached response.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER hitselector 
        Selector for evaluating whether an object gets stored in a particular content group. A selector is an abstraction for a collection of PIXL expressions. 
    .PARAMETER invalselector 
        Selector for invalidating objects in the content group. A selector is an abstraction for a collection of PIXL expressions. 
    .PARAMETER PassThru 
        Return details about the created cachecontentgroup item.
    .EXAMPLE
        Invoke-ADCUpdateCachecontentgroup -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateCachecontentgroup
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachecontentgroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [ValidateRange(0, 31536000)]
        [double]$weakposrelexpiry ,

        [ValidateRange(0, 100)]
        [double]$heurexpiryparam ,

        [ValidateRange(0, 31536000)]
        [double]$relexpiry ,

        [ValidateRange(0, 86400000)]
        [double]$relexpirymillisec ,

        [string[]]$absexpiry ,

        [string[]]$absexpirygmt ,

        [ValidateRange(0, 31536000)]
        [double]$weaknegrelexpiry ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$hitparams ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$invalparams ,

        [ValidateSet('YES', 'NO')]
        [string]$ignoreparamvaluecase ,

        [ValidateSet('YES', 'NO')]
        [string]$matchcookies ,

        [ValidateSet('YES', 'NO')]
        [string]$invalrestrictedtohost ,

        [ValidateSet('YES', 'NO')]
        [string]$polleverytime ,

        [ValidateSet('YES', 'NO')]
        [string]$ignorereloadreq ,

        [ValidateSet('YES', 'NO')]
        [string]$removecookies ,

        [ValidateSet('YES', 'NO')]
        [string]$prefetch ,

        [ValidateRange(0, 4294967294)]
        [double]$prefetchperiod ,

        [ValidateRange(0, 4294967290)]
        [double]$prefetchperiodmillisec ,

        [ValidateRange(0, 4294967294)]
        [double]$prefetchmaxpending ,

        [ValidateSet('YES', 'NO')]
        [string]$flashcache ,

        [ValidateSet('YES', 'NO')]
        [string]$expireatlastbyte ,

        [ValidateSet('YES', 'NO')]
        [string]$insertvia ,

        [ValidateSet('YES', 'NO')]
        [string]$insertage ,

        [ValidateSet('YES', 'NO')]
        [string]$insertetag ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cachecontrol ,

        [ValidateRange(0, 4194303)]
        [double]$quickabortsize ,

        [ValidateRange(0, 2097151)]
        [double]$minressize ,

        [ValidateRange(0, 2097151)]
        [double]$maxressize ,

        [double]$memlimit ,

        [ValidateSet('YES', 'NO')]
        [string]$ignorereqcachinghdrs ,

        [int]$minhits ,

        [ValidateSet('YES', 'NO')]
        [string]$alwaysevalpolicies ,

        [ValidateSet('YES', 'NO')]
        [string]$persistha ,

        [ValidateSet('YES', 'NO')]
        [string]$pinned ,

        [ValidateSet('YES', 'NO')]
        [string]$lazydnsresolve ,

        [string]$hitselector ,

        [string]$invalselector ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCachecontentgroup: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('weakposrelexpiry')) { $Payload.Add('weakposrelexpiry', $weakposrelexpiry) }
            if ($PSBoundParameters.ContainsKey('heurexpiryparam')) { $Payload.Add('heurexpiryparam', $heurexpiryparam) }
            if ($PSBoundParameters.ContainsKey('relexpiry')) { $Payload.Add('relexpiry', $relexpiry) }
            if ($PSBoundParameters.ContainsKey('relexpirymillisec')) { $Payload.Add('relexpirymillisec', $relexpirymillisec) }
            if ($PSBoundParameters.ContainsKey('absexpiry')) { $Payload.Add('absexpiry', $absexpiry) }
            if ($PSBoundParameters.ContainsKey('absexpirygmt')) { $Payload.Add('absexpirygmt', $absexpirygmt) }
            if ($PSBoundParameters.ContainsKey('weaknegrelexpiry')) { $Payload.Add('weaknegrelexpiry', $weaknegrelexpiry) }
            if ($PSBoundParameters.ContainsKey('hitparams')) { $Payload.Add('hitparams', $hitparams) }
            if ($PSBoundParameters.ContainsKey('invalparams')) { $Payload.Add('invalparams', $invalparams) }
            if ($PSBoundParameters.ContainsKey('ignoreparamvaluecase')) { $Payload.Add('ignoreparamvaluecase', $ignoreparamvaluecase) }
            if ($PSBoundParameters.ContainsKey('matchcookies')) { $Payload.Add('matchcookies', $matchcookies) }
            if ($PSBoundParameters.ContainsKey('invalrestrictedtohost')) { $Payload.Add('invalrestrictedtohost', $invalrestrictedtohost) }
            if ($PSBoundParameters.ContainsKey('polleverytime')) { $Payload.Add('polleverytime', $polleverytime) }
            if ($PSBoundParameters.ContainsKey('ignorereloadreq')) { $Payload.Add('ignorereloadreq', $ignorereloadreq) }
            if ($PSBoundParameters.ContainsKey('removecookies')) { $Payload.Add('removecookies', $removecookies) }
            if ($PSBoundParameters.ContainsKey('prefetch')) { $Payload.Add('prefetch', $prefetch) }
            if ($PSBoundParameters.ContainsKey('prefetchperiod')) { $Payload.Add('prefetchperiod', $prefetchperiod) }
            if ($PSBoundParameters.ContainsKey('prefetchperiodmillisec')) { $Payload.Add('prefetchperiodmillisec', $prefetchperiodmillisec) }
            if ($PSBoundParameters.ContainsKey('prefetchmaxpending')) { $Payload.Add('prefetchmaxpending', $prefetchmaxpending) }
            if ($PSBoundParameters.ContainsKey('flashcache')) { $Payload.Add('flashcache', $flashcache) }
            if ($PSBoundParameters.ContainsKey('expireatlastbyte')) { $Payload.Add('expireatlastbyte', $expireatlastbyte) }
            if ($PSBoundParameters.ContainsKey('insertvia')) { $Payload.Add('insertvia', $insertvia) }
            if ($PSBoundParameters.ContainsKey('insertage')) { $Payload.Add('insertage', $insertage) }
            if ($PSBoundParameters.ContainsKey('insertetag')) { $Payload.Add('insertetag', $insertetag) }
            if ($PSBoundParameters.ContainsKey('cachecontrol')) { $Payload.Add('cachecontrol', $cachecontrol) }
            if ($PSBoundParameters.ContainsKey('quickabortsize')) { $Payload.Add('quickabortsize', $quickabortsize) }
            if ($PSBoundParameters.ContainsKey('minressize')) { $Payload.Add('minressize', $minressize) }
            if ($PSBoundParameters.ContainsKey('maxressize')) { $Payload.Add('maxressize', $maxressize) }
            if ($PSBoundParameters.ContainsKey('memlimit')) { $Payload.Add('memlimit', $memlimit) }
            if ($PSBoundParameters.ContainsKey('ignorereqcachinghdrs')) { $Payload.Add('ignorereqcachinghdrs', $ignorereqcachinghdrs) }
            if ($PSBoundParameters.ContainsKey('minhits')) { $Payload.Add('minhits', $minhits) }
            if ($PSBoundParameters.ContainsKey('alwaysevalpolicies')) { $Payload.Add('alwaysevalpolicies', $alwaysevalpolicies) }
            if ($PSBoundParameters.ContainsKey('persistha')) { $Payload.Add('persistha', $persistha) }
            if ($PSBoundParameters.ContainsKey('pinned')) { $Payload.Add('pinned', $pinned) }
            if ($PSBoundParameters.ContainsKey('lazydnsresolve')) { $Payload.Add('lazydnsresolve', $lazydnsresolve) }
            if ($PSBoundParameters.ContainsKey('hitselector')) { $Payload.Add('hitselector', $hitselector) }
            if ($PSBoundParameters.ContainsKey('invalselector')) { $Payload.Add('invalselector', $invalselector) }
 
            if ($PSCmdlet.ShouldProcess("cachecontentgroup", "Update Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type cachecontentgroup -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCachecontentgroup -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateCachecontentgroup: Finished"
    }
}

function Invoke-ADCUnsetCachecontentgroup {
<#
    .SYNOPSIS
        Unset Integrated Caching configuration Object
    .DESCRIPTION
        Unset Integrated Caching configuration Object 
   .PARAMETER name 
       Name for the content group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the content group is created. 
   .PARAMETER weakposrelexpiry 
       Relative expiry time, in seconds, for expiring positive responses with response codes between 200 and 399. Cannot be used in combination with other Expiry attributes. Similar to -relExpiry but has lower precedence. 
   .PARAMETER heurexpiryparam 
       Heuristic expiry time, in percent of the duration, since the object was last modified. 
   .PARAMETER relexpiry 
       Relative expiry time, in seconds, after which to expire an object cached in this content group. 
   .PARAMETER relexpirymillisec 
       Relative expiry time, in milliseconds, after which to expire an object cached in this content group. 
   .PARAMETER absexpiry 
       Local time, up to 4 times a day, at which all objects in the content group must expire.  
       CLI Users:  
       For example, to specify that the objects in the content group should expire by 11:00 PM, type the following command: add cache contentgroup <contentgroup name> -absexpiry 23:00  
       To specify that the objects in the content group should expire at 10:00 AM, 3 PM, 6 PM, and 11:00 PM, type: add cache contentgroup <contentgroup name> -absexpiry 10:00 15:00 18:00 23:00. 
   .PARAMETER absexpirygmt 
       Coordinated Universal Time (GMT), up to 4 times a day, when all objects in the content group must expire. 
   .PARAMETER weaknegrelexpiry 
       Relative expiry time, in seconds, for expiring negative responses. This value is used only if the expiry time cannot be determined from any other source. It is applicable only to the following status codes: 307, 403, 404, and 410. 
   .PARAMETER hitparams 
       Parameters to use for parameterized hit evaluation of an object. Up to 128 parameters can be specified. Mutually exclusive with the Hit Selector parameter. 
   .PARAMETER invalparams 
       Parameters for parameterized invalidation of an object. You can specify up to 8 parameters. Mutually exclusive with invalSelector. 
   .PARAMETER ignoreparamvaluecase 
       Ignore case when comparing parameter values during parameterized hit evaluation. (Parameter value case is ignored by default during parameterized invalidation.).  
       Possible values = YES, NO 
   .PARAMETER matchcookies 
       Evaluate for parameters in the cookie header also.  
       Possible values = YES, NO 
   .PARAMETER invalrestrictedtohost 
       Take the host header into account during parameterized invalidation.  
       Possible values = YES, NO 
   .PARAMETER polleverytime 
       Always poll for the objects in this content group. That is, retrieve the objects from the origin server whenever they are requested.  
       Possible values = YES, NO 
   .PARAMETER ignorereloadreq 
       Ignore any request to reload a cached object from the origin server.  
       To guard against Denial of Service attacks, set this parameter to YES. For RFC-compliant behavior, set it to NO.  
       Possible values = YES, NO 
   .PARAMETER removecookies 
       Remove cookies from responses.  
       Possible values = YES, NO 
   .PARAMETER prefetch 
       Attempt to refresh objects that are about to go stale.  
       Possible values = YES, NO 
   .PARAMETER prefetchperiod 
       Time period, in seconds before an object's calculated expiry time, during which to attempt prefetch. 
   .PARAMETER prefetchperiodmillisec 
       Time period, in milliseconds before an object's calculated expiry time, during which to attempt prefetch. 
   .PARAMETER prefetchmaxpending 
       Maximum number of outstanding prefetches that can be queued for the content group. 
   .PARAMETER flashcache 
       Perform flash cache. Mutually exclusive with Poll Every Time (PET) on the same content group.  
       Possible values = YES, NO 
   .PARAMETER expireatlastbyte 
       Force expiration of the content immediately after the response is downloaded (upon receipt of the last byte of the response body). Applicable only to positive responses.  
       Possible values = YES, NO 
   .PARAMETER insertvia 
       Insert a Via header into the response.  
       Possible values = YES, NO 
   .PARAMETER insertage 
       Insert an Age header into the response. An Age header contains information about the age of the object, in seconds, as calculated by the integrated cache.  
       Possible values = YES, NO 
   .PARAMETER insertetag 
       Insert an ETag header in the response. With ETag header insertion, the integrated cache does not serve full responses on repeat requests.  
       Possible values = YES, NO 
   .PARAMETER cachecontrol 
       Insert a Cache-Control header into the response. 
   .PARAMETER quickabortsize 
       If the size of an object that is being downloaded is less than or equal to the quick abort value, and a client aborts during the download, the cache stops downloading the response. If the object is larger than the quick abort size, the cache continues to download the response. 
   .PARAMETER minressize 
       Minimum size of a response that can be cached in this content group.  
       Default minimum response size is 0. 
   .PARAMETER maxressize 
       Maximum size of a response that can be cached in this content group. 
   .PARAMETER memlimit 
       Maximum amount of memory that the cache can use. The effective limit is based on the available memory of the Citrix ADC. 
   .PARAMETER ignorereqcachinghdrs 
       Ignore Cache-Control and Pragma headers in the incoming request.  
       Possible values = YES, NO 
   .PARAMETER minhits 
       Number of hits that qualifies a response for storage in this content group. 
   .PARAMETER alwaysevalpolicies 
       Force policy evaluation for each response arriving from the origin server. Cannot be set to YES if the Prefetch parameter is also set to YES.  
       Possible values = YES, NO 
   .PARAMETER persistha 
       Setting persistHA to YES causes IC to save objects in contentgroup to Secondary node in HA deployment.  
       Possible values = YES, NO 
   .PARAMETER pinned 
       Do not flush objects from this content group under memory pressure.  
       Possible values = YES, NO 
   .PARAMETER lazydnsresolve 
       Perform DNS resolution for responses only if the destination IP address in the request does not match the destination IP address of the cached response.  
       Possible values = YES, NO 
   .PARAMETER hitselector 
       Selector for evaluating whether an object gets stored in a particular content group. A selector is an abstraction for a collection of PIXL expressions. 
   .PARAMETER invalselector 
       Selector for invalidating objects in the content group. A selector is an abstraction for a collection of PIXL expressions.
    .EXAMPLE
        Invoke-ADCUnsetCachecontentgroup -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetCachecontentgroup
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachecontentgroup
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [Boolean]$weakposrelexpiry ,

        [Boolean]$heurexpiryparam ,

        [Boolean]$relexpiry ,

        [Boolean]$relexpirymillisec ,

        [Boolean]$absexpiry ,

        [Boolean]$absexpirygmt ,

        [Boolean]$weaknegrelexpiry ,

        [Boolean]$hitparams ,

        [Boolean]$invalparams ,

        [Boolean]$ignoreparamvaluecase ,

        [Boolean]$matchcookies ,

        [Boolean]$invalrestrictedtohost ,

        [Boolean]$polleverytime ,

        [Boolean]$ignorereloadreq ,

        [Boolean]$removecookies ,

        [Boolean]$prefetch ,

        [Boolean]$prefetchperiod ,

        [Boolean]$prefetchperiodmillisec ,

        [Boolean]$prefetchmaxpending ,

        [Boolean]$flashcache ,

        [Boolean]$expireatlastbyte ,

        [Boolean]$insertvia ,

        [Boolean]$insertage ,

        [Boolean]$insertetag ,

        [Boolean]$cachecontrol ,

        [Boolean]$quickabortsize ,

        [Boolean]$minressize ,

        [Boolean]$maxressize ,

        [Boolean]$memlimit ,

        [Boolean]$ignorereqcachinghdrs ,

        [Boolean]$minhits ,

        [Boolean]$alwaysevalpolicies ,

        [Boolean]$persistha ,

        [Boolean]$pinned ,

        [Boolean]$lazydnsresolve ,

        [Boolean]$hitselector ,

        [Boolean]$invalselector 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCachecontentgroup: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('weakposrelexpiry')) { $Payload.Add('weakposrelexpiry', $weakposrelexpiry) }
            if ($PSBoundParameters.ContainsKey('heurexpiryparam')) { $Payload.Add('heurexpiryparam', $heurexpiryparam) }
            if ($PSBoundParameters.ContainsKey('relexpiry')) { $Payload.Add('relexpiry', $relexpiry) }
            if ($PSBoundParameters.ContainsKey('relexpirymillisec')) { $Payload.Add('relexpirymillisec', $relexpirymillisec) }
            if ($PSBoundParameters.ContainsKey('absexpiry')) { $Payload.Add('absexpiry', $absexpiry) }
            if ($PSBoundParameters.ContainsKey('absexpirygmt')) { $Payload.Add('absexpirygmt', $absexpirygmt) }
            if ($PSBoundParameters.ContainsKey('weaknegrelexpiry')) { $Payload.Add('weaknegrelexpiry', $weaknegrelexpiry) }
            if ($PSBoundParameters.ContainsKey('hitparams')) { $Payload.Add('hitparams', $hitparams) }
            if ($PSBoundParameters.ContainsKey('invalparams')) { $Payload.Add('invalparams', $invalparams) }
            if ($PSBoundParameters.ContainsKey('ignoreparamvaluecase')) { $Payload.Add('ignoreparamvaluecase', $ignoreparamvaluecase) }
            if ($PSBoundParameters.ContainsKey('matchcookies')) { $Payload.Add('matchcookies', $matchcookies) }
            if ($PSBoundParameters.ContainsKey('invalrestrictedtohost')) { $Payload.Add('invalrestrictedtohost', $invalrestrictedtohost) }
            if ($PSBoundParameters.ContainsKey('polleverytime')) { $Payload.Add('polleverytime', $polleverytime) }
            if ($PSBoundParameters.ContainsKey('ignorereloadreq')) { $Payload.Add('ignorereloadreq', $ignorereloadreq) }
            if ($PSBoundParameters.ContainsKey('removecookies')) { $Payload.Add('removecookies', $removecookies) }
            if ($PSBoundParameters.ContainsKey('prefetch')) { $Payload.Add('prefetch', $prefetch) }
            if ($PSBoundParameters.ContainsKey('prefetchperiod')) { $Payload.Add('prefetchperiod', $prefetchperiod) }
            if ($PSBoundParameters.ContainsKey('prefetchperiodmillisec')) { $Payload.Add('prefetchperiodmillisec', $prefetchperiodmillisec) }
            if ($PSBoundParameters.ContainsKey('prefetchmaxpending')) { $Payload.Add('prefetchmaxpending', $prefetchmaxpending) }
            if ($PSBoundParameters.ContainsKey('flashcache')) { $Payload.Add('flashcache', $flashcache) }
            if ($PSBoundParameters.ContainsKey('expireatlastbyte')) { $Payload.Add('expireatlastbyte', $expireatlastbyte) }
            if ($PSBoundParameters.ContainsKey('insertvia')) { $Payload.Add('insertvia', $insertvia) }
            if ($PSBoundParameters.ContainsKey('insertage')) { $Payload.Add('insertage', $insertage) }
            if ($PSBoundParameters.ContainsKey('insertetag')) { $Payload.Add('insertetag', $insertetag) }
            if ($PSBoundParameters.ContainsKey('cachecontrol')) { $Payload.Add('cachecontrol', $cachecontrol) }
            if ($PSBoundParameters.ContainsKey('quickabortsize')) { $Payload.Add('quickabortsize', $quickabortsize) }
            if ($PSBoundParameters.ContainsKey('minressize')) { $Payload.Add('minressize', $minressize) }
            if ($PSBoundParameters.ContainsKey('maxressize')) { $Payload.Add('maxressize', $maxressize) }
            if ($PSBoundParameters.ContainsKey('memlimit')) { $Payload.Add('memlimit', $memlimit) }
            if ($PSBoundParameters.ContainsKey('ignorereqcachinghdrs')) { $Payload.Add('ignorereqcachinghdrs', $ignorereqcachinghdrs) }
            if ($PSBoundParameters.ContainsKey('minhits')) { $Payload.Add('minhits', $minhits) }
            if ($PSBoundParameters.ContainsKey('alwaysevalpolicies')) { $Payload.Add('alwaysevalpolicies', $alwaysevalpolicies) }
            if ($PSBoundParameters.ContainsKey('persistha')) { $Payload.Add('persistha', $persistha) }
            if ($PSBoundParameters.ContainsKey('pinned')) { $Payload.Add('pinned', $pinned) }
            if ($PSBoundParameters.ContainsKey('lazydnsresolve')) { $Payload.Add('lazydnsresolve', $lazydnsresolve) }
            if ($PSBoundParameters.ContainsKey('hitselector')) { $Payload.Add('hitselector', $hitselector) }
            if ($PSBoundParameters.ContainsKey('invalselector')) { $Payload.Add('invalselector', $invalselector) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Integrated Caching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type cachecontentgroup -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetCachecontentgroup: Finished"
    }
}

function Invoke-ADCExpireCachecontentgroup {
<#
    .SYNOPSIS
        Expire Integrated Caching configuration Object
    .DESCRIPTION
        Expire Integrated Caching configuration Object 
    .PARAMETER name 
        Name for the content group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the content group is created.
    .EXAMPLE
        Invoke-ADCExpireCachecontentgroup -name <string>
    .NOTES
        File Name : Invoke-ADCExpireCachecontentgroup
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachecontentgroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name 

    )
    begin {
        Write-Verbose "Invoke-ADCExpireCachecontentgroup: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

            if ($PSCmdlet.ShouldProcess($Name, "Expire Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cachecontentgroup -Action expire -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCExpireCachecontentgroup: Finished"
    }
}

function Invoke-ADCFlushCachecontentgroup {
<#
    .SYNOPSIS
        Flush Integrated Caching configuration Object
    .DESCRIPTION
        Flush Integrated Caching configuration Object 
    .PARAMETER name 
        Name for the content group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the content group is created. 
    .PARAMETER query 
        Query string specifying individual objects to flush from this group by using parameterized invalidation. If this parameter is not set, all objects are flushed from the group. 
    .PARAMETER hostname 
        Flush only objects that belong to the specified host. Do not use except with parameterized invalidation. Also, the Invalidation Restricted to Host parameter for the group must be set to YES. 
        NOTE: The Nitro parameter "host" cannot be used in PowerShell thus an alternative name was chosen. 
    .PARAMETER selectorvalue 
        Value of the selector to be used for flushing objects from the content group. Requires that an invalidation selector be configured for the content group.
    .EXAMPLE
        Invoke-ADCFlushCachecontentgroup -name <string>
    .NOTES
        File Name : Invoke-ADCFlushCachecontentgroup
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachecontentgroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$query ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$hostname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$selectorvalue 

    )
    begin {
        Write-Verbose "Invoke-ADCFlushCachecontentgroup: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('query')) { $Payload.Add('query', $query) }
            if ($PSBoundParameters.ContainsKey('hostname')) { $Payload.Add('host', $hostname) }
            if ($PSBoundParameters.ContainsKey('selectorvalue')) { $Payload.Add('selectorvalue', $selectorvalue) }
            if ($PSCmdlet.ShouldProcess($Name, "Flush Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cachecontentgroup -Action flush -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCFlushCachecontentgroup: Finished"
    }
}

function Invoke-ADCSaveCachecontentgroup {
<#
    .SYNOPSIS
        Save Integrated Caching configuration Object
    .DESCRIPTION
        Save Integrated Caching configuration Object 
    .PARAMETER name 
        Name for the content group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the content group is created. 
    .PARAMETER tosecondary 
        content group whose objects are to be sent to secondary.  
        Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCSaveCachecontentgroup -name <string>
    .NOTES
        File Name : Invoke-ADCSaveCachecontentgroup
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachecontentgroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [ValidateSet('YES', 'NO')]
        [string]$tosecondary 

    )
    begin {
        Write-Verbose "Invoke-ADCSaveCachecontentgroup: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('tosecondary')) { $Payload.Add('tosecondary', $tosecondary) }
            if ($PSCmdlet.ShouldProcess($Name, "Save Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cachecontentgroup -Action save -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCSaveCachecontentgroup: Finished"
    }
}

function Invoke-ADCGetCachecontentgroup {
<#
    .SYNOPSIS
        Get Integrated Caching configuration object(s)
    .DESCRIPTION
        Get Integrated Caching configuration object(s)
    .PARAMETER name 
       Name for the content group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the content group is created. 
    .PARAMETER GetAll 
        Retreive all cachecontentgroup object(s)
    .PARAMETER Count
        If specified, the count of the cachecontentgroup object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCachecontentgroup
    .EXAMPLE 
        Invoke-ADCGetCachecontentgroup -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCachecontentgroup -Count
    .EXAMPLE
        Invoke-ADCGetCachecontentgroup -name <string>
    .EXAMPLE
        Invoke-ADCGetCachecontentgroup -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCachecontentgroup
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachecontentgroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name,

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
        Write-Verbose "Invoke-ADCGetCachecontentgroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all cachecontentgroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachecontentgroup -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachecontentgroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachecontentgroup -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachecontentgroup objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachecontentgroup -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachecontentgroup configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachecontentgroup -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachecontentgroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachecontentgroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCachecontentgroup: Ended"
    }
}

function Invoke-ADCAddCacheforwardproxy {
<#
    .SYNOPSIS
        Add Integrated Caching configuration Object
    .DESCRIPTION
        Add Integrated Caching configuration Object 
    .PARAMETER ipaddress 
        IP address of the Citrix ADC or a cache server for which the cache acts as a proxy. Requests coming to the Citrix ADC with the configured IP address are forwarded to the particular address, without involving the Integrated Cache in any way.  
        Minimum length = 1 
    .PARAMETER port 
        Port on the Citrix ADC or a server for which the cache acts as a proxy.  
        Minimum value = 1  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        Invoke-ADCAddCacheforwardproxy -ipaddress <string> -port <int>
    .NOTES
        File Name : Invoke-ADCAddCacheforwardproxy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cacheforwardproxy/
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
        [string]$ipaddress ,

        [Parameter(Mandatory = $true)]
        [ValidateRange(1, 65535)]
        [int]$port 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCacheforwardproxy: Starting"
    }
    process {
        try {
            $Payload = @{
                ipaddress = $ipaddress
                port = $port
            }

 
            if ($PSCmdlet.ShouldProcess("cacheforwardproxy", "Add Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cacheforwardproxy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
            Write-Output $result

            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddCacheforwardproxy: Finished"
    }
}

function Invoke-ADCDeleteCacheforwardproxy {
<#
    .SYNOPSIS
        Delete Integrated Caching configuration Object
    .DESCRIPTION
        Delete Integrated Caching configuration Object
    .PARAMETER ipaddress 
       IP address of the Citrix ADC or a cache server for which the cache acts as a proxy. Requests coming to the Citrix ADC with the configured IP address are forwarded to the particular address, without involving the Integrated Cache in any way.  
       Minimum length = 1    .PARAMETER port 
       Port on the Citrix ADC or a server for which the cache acts as a proxy.  
       Minimum value = 1  
       Range 1 - 65535  
       * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        Invoke-ADCDeleteCacheforwardproxy -ipaddress <string>
    .NOTES
        File Name : Invoke-ADCDeleteCacheforwardproxy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cacheforwardproxy/
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
        [string]$ipaddress ,

        [int]$port 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCacheforwardproxy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('port')) { $Arguments.Add('port', $port) }
            if ($PSCmdlet.ShouldProcess("$ipaddress", "Delete Integrated Caching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type cacheforwardproxy -NitroPath nitro/v1/config -Resource $ipaddress -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteCacheforwardproxy: Finished"
    }
}

function Invoke-ADCGetCacheforwardproxy {
<#
    .SYNOPSIS
        Get Integrated Caching configuration object(s)
    .DESCRIPTION
        Get Integrated Caching configuration object(s)
    .PARAMETER GetAll 
        Retreive all cacheforwardproxy object(s)
    .PARAMETER Count
        If specified, the count of the cacheforwardproxy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCacheforwardproxy
    .EXAMPLE 
        Invoke-ADCGetCacheforwardproxy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCacheforwardproxy -Count
    .EXAMPLE
        Invoke-ADCGetCacheforwardproxy -name <string>
    .EXAMPLE
        Invoke-ADCGetCacheforwardproxy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCacheforwardproxy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cacheforwardproxy/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetCacheforwardproxy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all cacheforwardproxy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheforwardproxy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cacheforwardproxy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheforwardproxy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cacheforwardproxy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheforwardproxy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cacheforwardproxy configuration for property ''"

            } else {
                Write-Verbose "Retrieving cacheforwardproxy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheforwardproxy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCacheforwardproxy: Ended"
    }
}

function Invoke-ADCGetCacheglobalbinding {
<#
    .SYNOPSIS
        Get Integrated Caching configuration object(s)
    .DESCRIPTION
        Get Integrated Caching configuration object(s)
    .PARAMETER GetAll 
        Retreive all cacheglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the cacheglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCacheglobalbinding
    .EXAMPLE 
        Invoke-ADCGetCacheglobalbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetCacheglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCacheglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCacheglobalbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cacheglobal_binding/
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
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCacheglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all cacheglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cacheglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cacheglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cacheglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving cacheglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCacheglobalbinding: Ended"
    }
}

function Invoke-ADCAddCacheglobalcachepolicybinding {
<#
    .SYNOPSIS
        Add Integrated Caching configuration Object
    .DESCRIPTION
        Add Integrated Caching configuration Object 
    .PARAMETER policy 
        Name of the cache policy. 
    .PARAMETER priority 
        Specifies the priority of the policy. 
    .PARAMETER precededefrules 
        Specify whether this policy should be evaluated.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER type 
        The bind point to which policy is bound. When you specify the type, detailed information about that bind point appears.  
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or a user-defined policy label. After the invoked policies are evaluated, the flow returns to the policy with the next priority. Applicable only to default-syntax policies. 
    .PARAMETER labeltype 
        Type of policy label to invoke.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label to invoke if the current policy rule evaluates to TRUE. (To invoke a label associated with a virtual server, specify the name of the virtual server.). 
    .PARAMETER PassThru 
        Return details about the created cacheglobal_cachepolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCacheglobalcachepolicybinding -policy <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddCacheglobalcachepolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cacheglobal_cachepolicy_binding/
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
        [string]$policy ,

        [Parameter(Mandatory = $true)]
        [double]$priority ,

        [ValidateSet('YES', 'NO')]
        [string]$precededefrules = 'NO' ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT')]
        [string]$type ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCacheglobalcachepolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                policy = $policy
                priority = $priority
            }
            if ($PSBoundParameters.ContainsKey('precededefrules')) { $Payload.Add('precededefrules', $precededefrules) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("cacheglobal_cachepolicy_binding", "Add Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type cacheglobal_cachepolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCacheglobalcachepolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddCacheglobalcachepolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCacheglobalcachepolicybinding {
<#
    .SYNOPSIS
        Delete Integrated Caching configuration Object
    .DESCRIPTION
        Delete Integrated Caching configuration Object
     .PARAMETER policy 
       Name of the cache policy.    .PARAMETER type 
       The bind point to which policy is bound. When you specify the type, detailed information about that bind point appears.  
       Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT    .PARAMETER priority 
       Specifies the priority of the policy.
    .EXAMPLE
        Invoke-ADCDeleteCacheglobalcachepolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteCacheglobalcachepolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cacheglobal_cachepolicy_binding/
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

        [string]$policy ,

        [string]$type ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCacheglobalcachepolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Arguments.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("cacheglobal_cachepolicy_binding", "Delete Integrated Caching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type cacheglobal_cachepolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteCacheglobalcachepolicybinding: Finished"
    }
}

function Invoke-ADCGetCacheglobalcachepolicybinding {
<#
    .SYNOPSIS
        Get Integrated Caching configuration object(s)
    .DESCRIPTION
        Get Integrated Caching configuration object(s)
    .PARAMETER GetAll 
        Retreive all cacheglobal_cachepolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the cacheglobal_cachepolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCacheglobalcachepolicybinding
    .EXAMPLE 
        Invoke-ADCGetCacheglobalcachepolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCacheglobalcachepolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCacheglobalcachepolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCacheglobalcachepolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCacheglobalcachepolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cacheglobal_cachepolicy_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCacheglobalcachepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all cacheglobal_cachepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheglobal_cachepolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cacheglobal_cachepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheglobal_cachepolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cacheglobal_cachepolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheglobal_cachepolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cacheglobal_cachepolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving cacheglobal_cachepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheglobal_cachepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCacheglobalcachepolicybinding: Ended"
    }
}

function Invoke-ADCExpireCacheobject {
<#
    .SYNOPSIS
        Expire Integrated Caching configuration Object
    .DESCRIPTION
        Expire Integrated Caching configuration Object 
    .PARAMETER locator 
        ID of the cached object. 
    .PARAMETER url 
        URL of the particular object whose details is required. Parameter "host" must be specified along with the URL. 
    .PARAMETER hostname 
        Host name of the object. Parameter "url" must be specified. 
        NOTE: The Nitro parameter "host" cannot be used in PowerShell thus an alternative name was chosen. 
    .PARAMETER port 
        Host port of the object. You must also set the Host parameter. 
    .PARAMETER groupname 
        Name of the content group to which the object belongs. It will display only the objects belonging to the specified content group. You must also set the Host parameter. 
    .PARAMETER httpmethod 
        HTTP request method that caused the object to be stored.  
        Possible values = GET, POST
    .EXAMPLE
        Invoke-ADCExpireCacheobject 
    .NOTES
        File Name : Invoke-ADCExpireCacheobject
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cacheobject/
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

        [double]$locator ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$url ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$hostname ,

        [int]$port ,

        [string]$groupname ,

        [ValidateSet('GET', 'POST')]
        [string]$httpmethod 

    )
    begin {
        Write-Verbose "Invoke-ADCExpireCacheobject: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('locator')) { $Payload.Add('locator', $locator) }
            if ($PSBoundParameters.ContainsKey('url')) { $Payload.Add('url', $url) }
            if ($PSBoundParameters.ContainsKey('hostname')) { $Payload.Add('host', $hostname) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('groupname')) { $Payload.Add('groupname', $groupname) }
            if ($PSBoundParameters.ContainsKey('httpmethod')) { $Payload.Add('httpmethod', $httpmethod) }
            if ($PSCmdlet.ShouldProcess($Name, "Expire Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cacheobject -Action expire -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCExpireCacheobject: Finished"
    }
}

function Invoke-ADCFlushCacheobject {
<#
    .SYNOPSIS
        Flush Integrated Caching configuration Object
    .DESCRIPTION
        Flush Integrated Caching configuration Object 
    .PARAMETER locator 
        ID of the cached object. 
    .PARAMETER url 
        URL of the particular object whose details is required. Parameter "host" must be specified along with the URL. 
    .PARAMETER hostname 
        Host name of the object. Parameter "url" must be specified. 
        NOTE: The Nitro parameter "host" cannot be used in PowerShell thus an alternative name was chosen. 
    .PARAMETER port 
        Host port of the object. You must also set the Host parameter. 
    .PARAMETER groupname 
        Name of the content group to which the object belongs. It will display only the objects belonging to the specified content group. You must also set the Host parameter. 
    .PARAMETER httpmethod 
        HTTP request method that caused the object to be stored.  
        Possible values = GET, POST
    .EXAMPLE
        Invoke-ADCFlushCacheobject 
    .NOTES
        File Name : Invoke-ADCFlushCacheobject
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cacheobject/
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

        [double]$locator ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$url ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$hostname ,

        [int]$port ,

        [string]$groupname ,

        [ValidateSet('GET', 'POST')]
        [string]$httpmethod 

    )
    begin {
        Write-Verbose "Invoke-ADCFlushCacheobject: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('locator')) { $Payload.Add('locator', $locator) }
            if ($PSBoundParameters.ContainsKey('url')) { $Payload.Add('url', $url) }
            if ($PSBoundParameters.ContainsKey('hostname')) { $Payload.Add('host', $hostname) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('groupname')) { $Payload.Add('groupname', $groupname) }
            if ($PSBoundParameters.ContainsKey('httpmethod')) { $Payload.Add('httpmethod', $httpmethod) }
            if ($PSCmdlet.ShouldProcess($Name, "Flush Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cacheobject -Action flush -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCFlushCacheobject: Finished"
    }
}

function Invoke-ADCSaveCacheobject {
<#
    .SYNOPSIS
        Save Integrated Caching configuration Object
    .DESCRIPTION
        Save Integrated Caching configuration Object 
    .PARAMETER locator 
        ID of the cached object. 
    .PARAMETER tosecondary 
        Object will be saved onto Secondary.  
        Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCSaveCacheobject 
    .NOTES
        File Name : Invoke-ADCSaveCacheobject
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cacheobject/
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

        [double]$locator ,

        [ValidateSet('YES', 'NO')]
        [string]$tosecondary 

    )
    begin {
        Write-Verbose "Invoke-ADCSaveCacheobject: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('locator')) { $Payload.Add('locator', $locator) }
            if ($PSBoundParameters.ContainsKey('tosecondary')) { $Payload.Add('tosecondary', $tosecondary) }
            if ($PSCmdlet.ShouldProcess($Name, "Save Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cacheobject -Action save -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCSaveCacheobject: Finished"
    }
}

function Invoke-ADCGetCacheobject {
<#
    .SYNOPSIS
        Get Integrated Caching configuration object(s)
    .DESCRIPTION
        Get Integrated Caching configuration object(s)
    .PARAMETER url 
       URL of the particular object whose details is required. Parameter "host" must be specified along with the URL. 
    .PARAMETER locator 
       ID of the cached object. 
    .PARAMETER httpstatus 
       HTTP status of the object. 
    .PARAMETER hostname 
       Host name of the object. Parameter "url" must be specified. 
       NOTE: The Nitro parameter "host" cannot be used in PowerShell thus an alternative name was chosen. 
    .PARAMETER port 
       Host port of the object. You must also set the Host parameter. 
    .PARAMETER groupname 
       Name of the content group to which the object belongs. It will display only the objects belonging to the specified content group. You must also set the Host parameter. 
    .PARAMETER httpmethod 
       HTTP request method that caused the object to be stored.  
       Possible values = GET, POST 
    .PARAMETER group 
       Name of the content group whose objects should be listed. 
    .PARAMETER ignoremarkerobjects 
       Ignore marker objects. Marker objects are created when a response exceeds the maximum or minimum response size for the content group or has not yet received the minimum number of hits for the content group.  
       Possible values = ON, OFF 
    .PARAMETER includenotreadyobjects 
       Include responses that have not yet reached a minimum number of hits before being cached.  
       Possible values = ON, OFF 
    .PARAMETER nodeid 
       Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retreive all cacheobject object(s)
    .PARAMETER Count
        If specified, the count of the cacheobject object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCacheobject
    .EXAMPLE 
        Invoke-ADCGetCacheobject -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCacheobject -Count
    .EXAMPLE
        Invoke-ADCGetCacheobject -name <string>
    .EXAMPLE
        Invoke-ADCGetCacheobject -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCacheobject
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cacheobject/
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
        [string]$url ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [double]$locator ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [double]$httpstatus ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$hostname ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [int]$port ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$groupname ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('GET', 'POST')]
        [string]$httpmethod ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$group ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('ON', 'OFF')]
        [string]$ignoremarkerobjects ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('ON', 'OFF')]
        [string]$includenotreadyobjects ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 31)]
        [double]$nodeid,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetCacheobject: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all cacheobject objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheobject -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cacheobject objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheobject -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cacheobject objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('url')) { $Arguments.Add('url', $url) } 
                if ($PSBoundParameters.ContainsKey('locator')) { $Arguments.Add('locator', $locator) } 
                if ($PSBoundParameters.ContainsKey('httpstatus')) { $Arguments.Add('httpstatus', $httpstatus) } 
                if ($PSBoundParameters.ContainsKey('hostname')) { $Arguments.Add('host', $hostname) } 
                if ($PSBoundParameters.ContainsKey('port')) { $Arguments.Add('port', $port) } 
                if ($PSBoundParameters.ContainsKey('groupname')) { $Arguments.Add('groupname', $groupname) } 
                if ($PSBoundParameters.ContainsKey('httpmethod')) { $Arguments.Add('httpmethod', $httpmethod) } 
                if ($PSBoundParameters.ContainsKey('group')) { $Arguments.Add('group', $group) } 
                if ($PSBoundParameters.ContainsKey('ignoremarkerobjects')) { $Arguments.Add('ignoremarkerobjects', $ignoremarkerobjects) } 
                if ($PSBoundParameters.ContainsKey('includenotreadyobjects')) { $Arguments.Add('includenotreadyobjects', $includenotreadyobjects) } 
                if ($PSBoundParameters.ContainsKey('nodeid')) { $Arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheobject -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cacheobject configuration for property ''"

            } else {
                Write-Verbose "Retrieving cacheobject configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheobject -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCacheobject: Ended"
    }
}

function Invoke-ADCUpdateCacheparameter {
<#
    .SYNOPSIS
        Update Integrated Caching configuration Object
    .DESCRIPTION
        Update Integrated Caching configuration Object 
    .PARAMETER memlimit 
        Amount of memory available for storing the cache objects. In practice, the amount of memory available for caching can be less than half the total memory of the Citrix ADC. 
    .PARAMETER via 
        String to include in the Via header. A Via header is inserted into all responses served from a content group if its Insert Via flag is set.  
        Minimum length = 1 
    .PARAMETER verifyusing 
        Criteria for deciding whether a cached object can be served for an incoming HTTP request. Available settings function as follows:  
        HOSTNAME - The URL, host name, and host port values in the incoming HTTP request header must match the cache policy. The IP address and the TCP port of the destination host are not evaluated. Do not use the HOSTNAME setting unless you are certain that no rogue client can access a rogue server through the cache.  
        HOSTNAME_AND_IP - The URL, host name, host port in the incoming HTTP request header, and the IP address and TCP port of  
        the destination server, must match the cache policy.  
        DNS - The URL, host name and host port in the incoming HTTP request, and the TCP port must match the cache policy. The host name is used for DNS lookup of the destination server's IP address, and is compared with the set of addresses returned by the DNS lookup.  
        Possible values = HOSTNAME, HOSTNAME_AND_IP, DNS 
    .PARAMETER maxpostlen 
        Maximum number of POST body bytes to consider when evaluating parameters for a content group for which you have configured hit parameters and invalidation parameters.  
        Default value: 4096  
        Minimum value = 0  
        Maximum value = 131072 
    .PARAMETER prefetchmaxpending 
        Maximum number of outstanding prefetches in the Integrated Cache. 
    .PARAMETER enablebypass 
        Evaluate the request-time policies before attempting hit selection. If set to NO, an incoming request for which a matching object is found in cache storage results in a response regardless of the policy configuration.  
        If the request matches a policy with a NOCACHE action, the request bypasses all cache processing.  
        This parameter does not affect processing of requests that match any invalidation policy.  
        Possible values = YES, NO 
    .PARAMETER undefaction 
        Action to take when a policy cannot be evaluated.  
        Possible values = NOCACHE, RESET 
    .PARAMETER enablehaobjpersist 
        The HA object persisting parameter. When this value is set to YES, cache objects can be synced to Secondary in a HA deployment. If set to NO, objects will never be synced to Secondary node.  
        Default value: NO  
        Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCUpdateCacheparameter 
    .NOTES
        File Name : Invoke-ADCUpdateCacheparameter
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cacheparameter/
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

        [double]$memlimit ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$via ,

        [ValidateSet('HOSTNAME', 'HOSTNAME_AND_IP', 'DNS')]
        [string]$verifyusing ,

        [ValidateRange(0, 131072)]
        [double]$maxpostlen ,

        [double]$prefetchmaxpending ,

        [ValidateSet('YES', 'NO')]
        [string]$enablebypass ,

        [ValidateSet('NOCACHE', 'RESET')]
        [string]$undefaction ,

        [ValidateSet('YES', 'NO')]
        [string]$enablehaobjpersist 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCacheparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('memlimit')) { $Payload.Add('memlimit', $memlimit) }
            if ($PSBoundParameters.ContainsKey('via')) { $Payload.Add('via', $via) }
            if ($PSBoundParameters.ContainsKey('verifyusing')) { $Payload.Add('verifyusing', $verifyusing) }
            if ($PSBoundParameters.ContainsKey('maxpostlen')) { $Payload.Add('maxpostlen', $maxpostlen) }
            if ($PSBoundParameters.ContainsKey('prefetchmaxpending')) { $Payload.Add('prefetchmaxpending', $prefetchmaxpending) }
            if ($PSBoundParameters.ContainsKey('enablebypass')) { $Payload.Add('enablebypass', $enablebypass) }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
            if ($PSBoundParameters.ContainsKey('enablehaobjpersist')) { $Payload.Add('enablehaobjpersist', $enablehaobjpersist) }
 
            if ($PSCmdlet.ShouldProcess("cacheparameter", "Update Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type cacheparameter -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateCacheparameter: Finished"
    }
}

function Invoke-ADCUnsetCacheparameter {
<#
    .SYNOPSIS
        Unset Integrated Caching configuration Object
    .DESCRIPTION
        Unset Integrated Caching configuration Object 
   .PARAMETER memlimit 
       Amount of memory available for storing the cache objects. In practice, the amount of memory available for caching can be less than half the total memory of the Citrix ADC. 
   .PARAMETER via 
       String to include in the Via header. A Via header is inserted into all responses served from a content group if its Insert Via flag is set. 
   .PARAMETER verifyusing 
       Criteria for deciding whether a cached object can be served for an incoming HTTP request. Available settings function as follows:  
       HOSTNAME - The URL, host name, and host port values in the incoming HTTP request header must match the cache policy. The IP address and the TCP port of the destination host are not evaluated. Do not use the HOSTNAME setting unless you are certain that no rogue client can access a rogue server through the cache.  
       HOSTNAME_AND_IP - The URL, host name, host port in the incoming HTTP request header, and the IP address and TCP port of  
       the destination server, must match the cache policy.  
       DNS - The URL, host name and host port in the incoming HTTP request, and the TCP port must match the cache policy. The host name is used for DNS lookup of the destination server's IP address, and is compared with the set of addresses returned by the DNS lookup.  
       Possible values = HOSTNAME, HOSTNAME_AND_IP, DNS 
   .PARAMETER maxpostlen 
       Maximum number of POST body bytes to consider when evaluating parameters for a content group for which you have configured hit parameters and invalidation parameters. 
   .PARAMETER prefetchmaxpending 
       Maximum number of outstanding prefetches in the Integrated Cache. 
   .PARAMETER enablebypass 
       Evaluate the request-time policies before attempting hit selection. If set to NO, an incoming request for which a matching object is found in cache storage results in a response regardless of the policy configuration.  
       If the request matches a policy with a NOCACHE action, the request bypasses all cache processing.  
       This parameter does not affect processing of requests that match any invalidation policy.  
       Possible values = YES, NO 
   .PARAMETER undefaction 
       Action to take when a policy cannot be evaluated.  
       Possible values = NOCACHE, RESET 
   .PARAMETER enablehaobjpersist 
       The HA object persisting parameter. When this value is set to YES, cache objects can be synced to Secondary in a HA deployment. If set to NO, objects will never be synced to Secondary node.  
       Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCUnsetCacheparameter 
    .NOTES
        File Name : Invoke-ADCUnsetCacheparameter
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cacheparameter
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

        [Boolean]$memlimit ,

        [Boolean]$via ,

        [Boolean]$verifyusing ,

        [Boolean]$maxpostlen ,

        [Boolean]$prefetchmaxpending ,

        [Boolean]$enablebypass ,

        [Boolean]$undefaction ,

        [Boolean]$enablehaobjpersist 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCacheparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('memlimit')) { $Payload.Add('memlimit', $memlimit) }
            if ($PSBoundParameters.ContainsKey('via')) { $Payload.Add('via', $via) }
            if ($PSBoundParameters.ContainsKey('verifyusing')) { $Payload.Add('verifyusing', $verifyusing) }
            if ($PSBoundParameters.ContainsKey('maxpostlen')) { $Payload.Add('maxpostlen', $maxpostlen) }
            if ($PSBoundParameters.ContainsKey('prefetchmaxpending')) { $Payload.Add('prefetchmaxpending', $prefetchmaxpending) }
            if ($PSBoundParameters.ContainsKey('enablebypass')) { $Payload.Add('enablebypass', $enablebypass) }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
            if ($PSBoundParameters.ContainsKey('enablehaobjpersist')) { $Payload.Add('enablehaobjpersist', $enablehaobjpersist) }
            if ($PSCmdlet.ShouldProcess("cacheparameter", "Unset Integrated Caching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type cacheparameter -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetCacheparameter: Finished"
    }
}

function Invoke-ADCGetCacheparameter {
<#
    .SYNOPSIS
        Get Integrated Caching configuration object(s)
    .DESCRIPTION
        Get Integrated Caching configuration object(s)
    .PARAMETER GetAll 
        Retreive all cacheparameter object(s)
    .PARAMETER Count
        If specified, the count of the cacheparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCacheparameter
    .EXAMPLE 
        Invoke-ADCGetCacheparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetCacheparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetCacheparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCacheparameter
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cacheparameter/
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
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCacheparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all cacheparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cacheparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cacheparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheparameter -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cacheparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving cacheparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCacheparameter: Ended"
    }
}

function Invoke-ADCAddCachepolicy {
<#
    .SYNOPSIS
        Add Integrated Caching configuration Object
    .DESCRIPTION
        Add Integrated Caching configuration Object 
    .PARAMETER policyname 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the policy is created.  
        Minimum length = 1 
    .PARAMETER rule 
        Expression against which the traffic is evaluated.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER action 
        Action to apply to content that matches the policy.  
        * CACHE or MAY_CACHE action - positive cachability policy  
        * NOCACHE or MAY_NOCACHE action - negative cachability policy  
        * INVAL action - Dynamic Invalidation Policy.  
        Possible values = CACHE, NOCACHE, MAY_CACHE, MAY_NOCACHE, INVAL 
    .PARAMETER storeingroup 
        Name of the content group in which to store the object when the final result of policy evaluation is CACHE. The content group must exist before being mentioned here. Use the "show cache contentgroup" command to view the list of existing content groups.  
        Minimum length = 1 
    .PARAMETER invalgroups 
        Content group(s) to be invalidated when the INVAL action is applied. Maximum number of content groups that can be specified is 16.  
        Minimum length = 1 
    .PARAMETER invalobjects 
        Content groups(s) in which the objects will be invalidated if the action is INVAL.  
        Minimum length = 1 
    .PARAMETER undefaction 
        Action to be performed when the result of rule evaluation is undefined.  
        Possible values = NOCACHE, RESET 
    .PARAMETER PassThru 
        Return details about the created cachepolicy item.
    .EXAMPLE
        Invoke-ADCAddCachepolicy -policyname <string> -rule <string> -action <string>
    .NOTES
        File Name : Invoke-ADCAddCachepolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$policyname ,

        [Parameter(Mandatory = $true)]
        [string]$rule ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('CACHE', 'NOCACHE', 'MAY_CACHE', 'MAY_NOCACHE', 'INVAL')]
        [string]$action ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$storeingroup ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$invalgroups ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$invalobjects ,

        [ValidateSet('NOCACHE', 'RESET')]
        [string]$undefaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCachepolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
                rule = $rule
                action = $action
            }
            if ($PSBoundParameters.ContainsKey('storeingroup')) { $Payload.Add('storeingroup', $storeingroup) }
            if ($PSBoundParameters.ContainsKey('invalgroups')) { $Payload.Add('invalgroups', $invalgroups) }
            if ($PSBoundParameters.ContainsKey('invalobjects')) { $Payload.Add('invalobjects', $invalobjects) }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
 
            if ($PSCmdlet.ShouldProcess("cachepolicy", "Add Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cachepolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCachepolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddCachepolicy: Finished"
    }
}

function Invoke-ADCDeleteCachepolicy {
<#
    .SYNOPSIS
        Delete Integrated Caching configuration Object
    .DESCRIPTION
        Delete Integrated Caching configuration Object
    .PARAMETER policyname 
       Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the policy is created.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteCachepolicy -policyname <string>
    .NOTES
        File Name : Invoke-ADCDeleteCachepolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicy/
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
        Write-Verbose "Invoke-ADCDeleteCachepolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$policyname", "Delete Integrated Caching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type cachepolicy -NitroPath nitro/v1/config -Resource $policyname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteCachepolicy: Finished"
    }
}

function Invoke-ADCUpdateCachepolicy {
<#
    .SYNOPSIS
        Update Integrated Caching configuration Object
    .DESCRIPTION
        Update Integrated Caching configuration Object 
    .PARAMETER policyname 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the policy is created.  
        Minimum length = 1 
    .PARAMETER rule 
        Expression against which the traffic is evaluated.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER action 
        Action to apply to content that matches the policy.  
        * CACHE or MAY_CACHE action - positive cachability policy  
        * NOCACHE or MAY_NOCACHE action - negative cachability policy  
        * INVAL action - Dynamic Invalidation Policy.  
        Possible values = CACHE, NOCACHE, MAY_CACHE, MAY_NOCACHE, INVAL 
    .PARAMETER storeingroup 
        Name of the content group in which to store the object when the final result of policy evaluation is CACHE. The content group must exist before being mentioned here. Use the "show cache contentgroup" command to view the list of existing content groups.  
        Minimum length = 1 
    .PARAMETER invalgroups 
        Content group(s) to be invalidated when the INVAL action is applied. Maximum number of content groups that can be specified is 16.  
        Minimum length = 1 
    .PARAMETER invalobjects 
        Content groups(s) in which the objects will be invalidated if the action is INVAL.  
        Minimum length = 1 
    .PARAMETER undefaction 
        Action to be performed when the result of rule evaluation is undefined.  
        Possible values = NOCACHE, RESET 
    .PARAMETER PassThru 
        Return details about the created cachepolicy item.
    .EXAMPLE
        Invoke-ADCUpdateCachepolicy -policyname <string>
    .NOTES
        File Name : Invoke-ADCUpdateCachepolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$policyname ,

        [string]$rule ,

        [ValidateSet('CACHE', 'NOCACHE', 'MAY_CACHE', 'MAY_NOCACHE', 'INVAL')]
        [string]$action ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$storeingroup ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$invalgroups ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$invalobjects ,

        [ValidateSet('NOCACHE', 'RESET')]
        [string]$undefaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCachepolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSBoundParameters.ContainsKey('storeingroup')) { $Payload.Add('storeingroup', $storeingroup) }
            if ($PSBoundParameters.ContainsKey('invalgroups')) { $Payload.Add('invalgroups', $invalgroups) }
            if ($PSBoundParameters.ContainsKey('invalobjects')) { $Payload.Add('invalobjects', $invalobjects) }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
 
            if ($PSCmdlet.ShouldProcess("cachepolicy", "Update Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type cachepolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCachepolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateCachepolicy: Finished"
    }
}

function Invoke-ADCUnsetCachepolicy {
<#
    .SYNOPSIS
        Unset Integrated Caching configuration Object
    .DESCRIPTION
        Unset Integrated Caching configuration Object 
   .PARAMETER policyname 
       Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the policy is created. 
   .PARAMETER storeingroup 
       Name of the content group in which to store the object when the final result of policy evaluation is CACHE. The content group must exist before being mentioned here. Use the "show cache contentgroup" command to view the list of existing content groups. 
   .PARAMETER invalgroups 
       Content group(s) to be invalidated when the INVAL action is applied. Maximum number of content groups that can be specified is 16. 
   .PARAMETER invalobjects 
       Content groups(s) in which the objects will be invalidated if the action is INVAL. 
   .PARAMETER undefaction 
       Action to be performed when the result of rule evaluation is undefined.  
       Possible values = NOCACHE, RESET
    .EXAMPLE
        Invoke-ADCUnsetCachepolicy -policyname <string>
    .NOTES
        File Name : Invoke-ADCUnsetCachepolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicy
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$policyname ,

        [Boolean]$storeingroup ,

        [Boolean]$invalgroups ,

        [Boolean]$invalobjects ,

        [Boolean]$undefaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCachepolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
            }
            if ($PSBoundParameters.ContainsKey('storeingroup')) { $Payload.Add('storeingroup', $storeingroup) }
            if ($PSBoundParameters.ContainsKey('invalgroups')) { $Payload.Add('invalgroups', $invalgroups) }
            if ($PSBoundParameters.ContainsKey('invalobjects')) { $Payload.Add('invalobjects', $invalobjects) }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
            if ($PSCmdlet.ShouldProcess("$policyname", "Unset Integrated Caching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type cachepolicy -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetCachepolicy: Finished"
    }
}

function Invoke-ADCRenameCachepolicy {
<#
    .SYNOPSIS
        Rename Integrated Caching configuration Object
    .DESCRIPTION
        Rename Integrated Caching configuration Object 
    .PARAMETER policyname 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the policy is created.  
        Minimum length = 1 
    .PARAMETER newname 
        New name for the cache policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created cachepolicy item.
    .EXAMPLE
        Invoke-ADCRenameCachepolicy -policyname <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameCachepolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$policyname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameCachepolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("cachepolicy", "Rename Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cachepolicy -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCachepolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameCachepolicy: Finished"
    }
}

function Invoke-ADCGetCachepolicy {
<#
    .SYNOPSIS
        Get Integrated Caching configuration object(s)
    .DESCRIPTION
        Get Integrated Caching configuration object(s)
    .PARAMETER policyname 
       Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the policy is created. 
    .PARAMETER GetAll 
        Retreive all cachepolicy object(s)
    .PARAMETER Count
        If specified, the count of the cachepolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCachepolicy
    .EXAMPLE 
        Invoke-ADCGetCachepolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCachepolicy -Count
    .EXAMPLE
        Invoke-ADCGetCachepolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetCachepolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCachepolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
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
        Write-Verbose "Invoke-ADCGetCachepolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all cachepolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicy configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCachepolicy: Ended"
    }
}

function Invoke-ADCAddCachepolicylabel {
<#
    .SYNOPSIS
        Add Integrated Caching configuration Object
    .DESCRIPTION
        Add Integrated Caching configuration Object 
    .PARAMETER labelname 
        Name for the label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the label is created. 
    .PARAMETER evaluates 
        When to evaluate policies bound to this label: request-time or response-time.  
        Possible values = REQ, RES, MSSQL_REQ, MSSQL_RES, MYSQL_REQ, MYSQL_RES 
    .PARAMETER PassThru 
        Return details about the created cachepolicylabel item.
    .EXAMPLE
        Invoke-ADCAddCachepolicylabel -labelname <string> -evaluates <string>
    .NOTES
        File Name : Invoke-ADCAddCachepolicylabel
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicylabel/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$labelname ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('REQ', 'RES', 'MSSQL_REQ', 'MSSQL_RES', 'MYSQL_REQ', 'MYSQL_RES')]
        [string]$evaluates ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCachepolicylabel: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
                evaluates = $evaluates
            }

 
            if ($PSCmdlet.ShouldProcess("cachepolicylabel", "Add Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cachepolicylabel -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCachepolicylabel -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddCachepolicylabel: Finished"
    }
}

function Invoke-ADCDeleteCachepolicylabel {
<#
    .SYNOPSIS
        Delete Integrated Caching configuration Object
    .DESCRIPTION
        Delete Integrated Caching configuration Object
    .PARAMETER labelname 
       Name for the label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the label is created. 
    .EXAMPLE
        Invoke-ADCDeleteCachepolicylabel -labelname <string>
    .NOTES
        File Name : Invoke-ADCDeleteCachepolicylabel
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicylabel/
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
        [string]$labelname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCachepolicylabel: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$labelname", "Delete Integrated Caching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type cachepolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteCachepolicylabel: Finished"
    }
}

function Invoke-ADCRenameCachepolicylabel {
<#
    .SYNOPSIS
        Rename Integrated Caching configuration Object
    .DESCRIPTION
        Rename Integrated Caching configuration Object 
    .PARAMETER labelname 
        Name for the label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the label is created. 
    .PARAMETER newname 
        New name for the cache-policy label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created cachepolicylabel item.
    .EXAMPLE
        Invoke-ADCRenameCachepolicylabel -labelname <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameCachepolicylabel
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicylabel/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$labelname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameCachepolicylabel: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("cachepolicylabel", "Rename Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cachepolicylabel -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCachepolicylabel -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameCachepolicylabel: Finished"
    }
}

function Invoke-ADCGetCachepolicylabel {
<#
    .SYNOPSIS
        Get Integrated Caching configuration object(s)
    .DESCRIPTION
        Get Integrated Caching configuration object(s)
    .PARAMETER labelname 
       Name for the label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the label is created. 
    .PARAMETER GetAll 
        Retreive all cachepolicylabel object(s)
    .PARAMETER Count
        If specified, the count of the cachepolicylabel object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCachepolicylabel
    .EXAMPLE 
        Invoke-ADCGetCachepolicylabel -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCachepolicylabel -Count
    .EXAMPLE
        Invoke-ADCGetCachepolicylabel -name <string>
    .EXAMPLE
        Invoke-ADCGetCachepolicylabel -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCachepolicylabel
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicylabel/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$labelname,

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
        Write-Verbose "Invoke-ADCGetCachepolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all cachepolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicylabel objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCachepolicylabel: Ended"
    }
}

function Invoke-ADCGetCachepolicylabelbinding {
<#
    .SYNOPSIS
        Get Integrated Caching configuration object(s)
    .DESCRIPTION
        Get Integrated Caching configuration object(s)
    .PARAMETER labelname 
       Name of the cache-policy label about which to display information. 
    .PARAMETER GetAll 
        Retreive all cachepolicylabel_binding object(s)
    .PARAMETER Count
        If specified, the count of the cachepolicylabel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCachepolicylabelbinding
    .EXAMPLE 
        Invoke-ADCGetCachepolicylabelbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetCachepolicylabelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCachepolicylabelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCachepolicylabelbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicylabel_binding/
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
        [string]$labelname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCachepolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all cachepolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicylabel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCachepolicylabelbinding: Ended"
    }
}

function Invoke-ADCAddCachepolicylabelcachepolicybinding {
<#
    .SYNOPSIS
        Add Integrated Caching configuration Object
    .DESCRIPTION
        Add Integrated Caching configuration Object 
    .PARAMETER labelname 
        Name of the cache policy label to which to bind the policy. 
    .PARAMETER policyname 
        Name of the cache policy to bind to the policy label. 
    .PARAMETER priority 
        Specifies the priority of the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or a user-defined policy label. After the invoked policies are evaluated, the flow returns to the policy with the next-lower priority. 
    .PARAMETER labeltype 
        Type of policy label to invoke: an unnamed label associated with a virtual server, or user-defined policy label.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER invoke_labelname 
        Name of the policy label to invoke if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created cachepolicylabel_cachepolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCachepolicylabelcachepolicybinding -labelname <string> -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddCachepolicylabelcachepolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicylabel_cachepolicy_binding/
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
        [string]$labelname ,

        [Parameter(Mandatory = $true)]
        [string]$policyname ,

        [Parameter(Mandatory = $true)]
        [double]$priority ,

        [string]$gotopriorityexpression ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$invoke_labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCachepolicylabelcachepolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
                policyname = $policyname
                priority = $priority
            }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('invoke_labelname')) { $Payload.Add('invoke_labelname', $invoke_labelname) }
 
            if ($PSCmdlet.ShouldProcess("cachepolicylabel_cachepolicy_binding", "Add Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type cachepolicylabel_cachepolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCachepolicylabelcachepolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddCachepolicylabelcachepolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCachepolicylabelcachepolicybinding {
<#
    .SYNOPSIS
        Delete Integrated Caching configuration Object
    .DESCRIPTION
        Delete Integrated Caching configuration Object
    .PARAMETER labelname 
       Name of the cache policy label to which to bind the policy.    .PARAMETER policyname 
       Name of the cache policy to bind to the policy label.    .PARAMETER priority 
       Specifies the priority of the policy.
    .EXAMPLE
        Invoke-ADCDeleteCachepolicylabelcachepolicybinding -labelname <string>
    .NOTES
        File Name : Invoke-ADCDeleteCachepolicylabelcachepolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicylabel_cachepolicy_binding/
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
        [string]$labelname ,

        [string]$policyname ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCachepolicylabelcachepolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$labelname", "Delete Integrated Caching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type cachepolicylabel_cachepolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteCachepolicylabelcachepolicybinding: Finished"
    }
}

function Invoke-ADCGetCachepolicylabelcachepolicybinding {
<#
    .SYNOPSIS
        Get Integrated Caching configuration object(s)
    .DESCRIPTION
        Get Integrated Caching configuration object(s)
    .PARAMETER labelname 
       Name of the cache policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all cachepolicylabel_cachepolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the cachepolicylabel_cachepolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCachepolicylabelcachepolicybinding
    .EXAMPLE 
        Invoke-ADCGetCachepolicylabelcachepolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCachepolicylabelcachepolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCachepolicylabelcachepolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCachepolicylabelcachepolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCachepolicylabelcachepolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicylabel_cachepolicy_binding/
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
        [string]$labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCachepolicylabelcachepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all cachepolicylabel_cachepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel_cachepolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicylabel_cachepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel_cachepolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicylabel_cachepolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel_cachepolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicylabel_cachepolicy_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel_cachepolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicylabel_cachepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel_cachepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCachepolicylabelcachepolicybinding: Ended"
    }
}

function Invoke-ADCGetCachepolicylabelpolicybindingbinding {
<#
    .SYNOPSIS
        Get Integrated Caching configuration object(s)
    .DESCRIPTION
        Get Integrated Caching configuration object(s)
    .PARAMETER labelname 
       Name of the cache policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all cachepolicylabel_policybinding_binding object(s)
    .PARAMETER Count
        If specified, the count of the cachepolicylabel_policybinding_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCachepolicylabelpolicybindingbinding
    .EXAMPLE 
        Invoke-ADCGetCachepolicylabelpolicybindingbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCachepolicylabelpolicybindingbinding -Count
    .EXAMPLE
        Invoke-ADCGetCachepolicylabelpolicybindingbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCachepolicylabelpolicybindingbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCachepolicylabelpolicybindingbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicylabel_policybinding_binding/
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
        [string]$labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCachepolicylabelpolicybindingbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all cachepolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicylabel_policybinding_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicylabel_policybinding_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCachepolicylabelpolicybindingbinding: Ended"
    }
}

function Invoke-ADCGetCachepolicybinding {
<#
    .SYNOPSIS
        Get Integrated Caching configuration object(s)
    .DESCRIPTION
        Get Integrated Caching configuration object(s)
    .PARAMETER policyname 
       Name of the cache policy about which to display details. 
    .PARAMETER GetAll 
        Retreive all cachepolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the cachepolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCachepolicybinding
    .EXAMPLE 
        Invoke-ADCGetCachepolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetCachepolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCachepolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCachepolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicy_binding/
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
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCachepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all cachepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicy_binding configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCachepolicybinding: Ended"
    }
}

function Invoke-ADCGetCachepolicycacheglobalbinding {
<#
    .SYNOPSIS
        Get Integrated Caching configuration object(s)
    .DESCRIPTION
        Get Integrated Caching configuration object(s)
    .PARAMETER policyname 
       Name of the cache policy about which to display details. 
    .PARAMETER GetAll 
        Retreive all cachepolicy_cacheglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the cachepolicy_cacheglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCachepolicycacheglobalbinding
    .EXAMPLE 
        Invoke-ADCGetCachepolicycacheglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCachepolicycacheglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetCachepolicycacheglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCachepolicycacheglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCachepolicycacheglobalbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicy_cacheglobal_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCachepolicycacheglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all cachepolicy_cacheglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_cacheglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicy_cacheglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_cacheglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicy_cacheglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_cacheglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicy_cacheglobal_binding configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_cacheglobal_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicy_cacheglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_cacheglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCachepolicycacheglobalbinding: Ended"
    }
}

function Invoke-ADCGetCachepolicycachepolicylabelbinding {
<#
    .SYNOPSIS
        Get Integrated Caching configuration object(s)
    .DESCRIPTION
        Get Integrated Caching configuration object(s)
    .PARAMETER policyname 
       Name of the cache policy about which to display details. 
    .PARAMETER GetAll 
        Retreive all cachepolicy_cachepolicylabel_binding object(s)
    .PARAMETER Count
        If specified, the count of the cachepolicy_cachepolicylabel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCachepolicycachepolicylabelbinding
    .EXAMPLE 
        Invoke-ADCGetCachepolicycachepolicylabelbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCachepolicycachepolicylabelbinding -Count
    .EXAMPLE
        Invoke-ADCGetCachepolicycachepolicylabelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCachepolicycachepolicylabelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCachepolicycachepolicylabelbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicy_cachepolicylabel_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCachepolicycachepolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all cachepolicy_cachepolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_cachepolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicy_cachepolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_cachepolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicy_cachepolicylabel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_cachepolicylabel_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicy_cachepolicylabel_binding configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_cachepolicylabel_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicy_cachepolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_cachepolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCachepolicycachepolicylabelbinding: Ended"
    }
}

function Invoke-ADCGetCachepolicycsvserverbinding {
<#
    .SYNOPSIS
        Get Integrated Caching configuration object(s)
    .DESCRIPTION
        Get Integrated Caching configuration object(s)
    .PARAMETER policyname 
       Name of the cache policy about which to display details. 
    .PARAMETER GetAll 
        Retreive all cachepolicy_csvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the cachepolicy_csvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCachepolicycsvserverbinding
    .EXAMPLE 
        Invoke-ADCGetCachepolicycsvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCachepolicycsvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetCachepolicycsvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCachepolicycsvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCachepolicycsvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicy_csvserver_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCachepolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all cachepolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicy_csvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicy_csvserver_binding configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCachepolicycsvserverbinding: Ended"
    }
}

function Invoke-ADCGetCachepolicylbvserverbinding {
<#
    .SYNOPSIS
        Get Integrated Caching configuration object(s)
    .DESCRIPTION
        Get Integrated Caching configuration object(s)
    .PARAMETER policyname 
       Name of the cache policy about which to display details. 
    .PARAMETER GetAll 
        Retreive all cachepolicy_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the cachepolicy_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCachepolicylbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetCachepolicylbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCachepolicylbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetCachepolicylbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCachepolicylbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCachepolicylbvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cachepolicy_lbvserver_binding/
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
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCachepolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all cachepolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicy_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicy_lbvserver_binding configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCachepolicylbvserverbinding: Ended"
    }
}

function Invoke-ADCAddCacheselector {
<#
    .SYNOPSIS
        Add Integrated Caching configuration Object
    .DESCRIPTION
        Add Integrated Caching configuration Object 
    .PARAMETER selectorname 
        Name for the selector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER rule 
        One or multiple PIXL expressions for evaluating an HTTP request or response.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created cacheselector item.
    .EXAMPLE
        Invoke-ADCAddCacheselector -selectorname <string> -rule <string[]>
    .NOTES
        File Name : Invoke-ADCAddCacheselector
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cacheselector/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$selectorname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$rule ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCacheselector: Starting"
    }
    process {
        try {
            $Payload = @{
                selectorname = $selectorname
                rule = $rule
            }

 
            if ($PSCmdlet.ShouldProcess("cacheselector", "Add Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cacheselector -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCacheselector -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddCacheselector: Finished"
    }
}

function Invoke-ADCDeleteCacheselector {
<#
    .SYNOPSIS
        Delete Integrated Caching configuration Object
    .DESCRIPTION
        Delete Integrated Caching configuration Object
    .PARAMETER selectorname 
       Name for the selector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .EXAMPLE
        Invoke-ADCDeleteCacheselector -selectorname <string>
    .NOTES
        File Name : Invoke-ADCDeleteCacheselector
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cacheselector/
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
        [string]$selectorname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCacheselector: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$selectorname", "Delete Integrated Caching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type cacheselector -NitroPath nitro/v1/config -Resource $selectorname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteCacheselector: Finished"
    }
}

function Invoke-ADCUpdateCacheselector {
<#
    .SYNOPSIS
        Update Integrated Caching configuration Object
    .DESCRIPTION
        Update Integrated Caching configuration Object 
    .PARAMETER selectorname 
        Name for the selector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER rule 
        One or multiple PIXL expressions for evaluating an HTTP request or response.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created cacheselector item.
    .EXAMPLE
        Invoke-ADCUpdateCacheselector -selectorname <string> -rule <string[]>
    .NOTES
        File Name : Invoke-ADCUpdateCacheselector
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cacheselector/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$selectorname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$rule ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCacheselector: Starting"
    }
    process {
        try {
            $Payload = @{
                selectorname = $selectorname
                rule = $rule
            }

 
            if ($PSCmdlet.ShouldProcess("cacheselector", "Update Integrated Caching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type cacheselector -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCacheselector -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateCacheselector: Finished"
    }
}

function Invoke-ADCGetCacheselector {
<#
    .SYNOPSIS
        Get Integrated Caching configuration object(s)
    .DESCRIPTION
        Get Integrated Caching configuration object(s)
    .PARAMETER selectorname 
       Name for the selector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retreive all cacheselector object(s)
    .PARAMETER Count
        If specified, the count of the cacheselector object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCacheselector
    .EXAMPLE 
        Invoke-ADCGetCacheselector -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCacheselector -Count
    .EXAMPLE
        Invoke-ADCGetCacheselector -name <string>
    .EXAMPLE
        Invoke-ADCGetCacheselector -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCacheselector
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cache/cacheselector/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$selectorname,

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
        Write-Verbose "Invoke-ADCGetCacheselector: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all cacheselector objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheselector -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cacheselector objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheselector -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cacheselector objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheselector -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cacheselector configuration for property 'selectorname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheselector -NitroPath nitro/v1/config -Resource $selectorname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cacheselector configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cacheselector -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCacheselector: Ended"
    }
}


