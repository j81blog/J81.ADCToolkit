function Invoke-ADCAddFeoaction {
<#
    .SYNOPSIS
        Add Front configuration Object
    .DESCRIPTION
        Add Front configuration Object 
    .PARAMETER name 
        The name of the front end optimization action.  
        Minimum length = 1 
    .PARAMETER pageextendcache 
        Extend the time period during which the browser can use the cached resource. 
    .PARAMETER cachemaxage 
        Maxage for cache extension.  
        Default value: 30  
        Minimum value = 0  
        Maximum value = 360 
    .PARAMETER imgshrinktoattrib 
        Shrink image dimensions as per the height and width attributes specified in the <img> tag. 
    .PARAMETER imggiftopng 
        Convert GIF image formats to PNG formats. 
    .PARAMETER imgtowebp 
        Convert JPEG, GIF, PNG image formats to WEBP format. 
    .PARAMETER imgtojpegxr 
        Convert JPEG, GIF, PNG image formats to JXR format. 
    .PARAMETER imginline 
        Inline images whose size is less than 2KB. 
    .PARAMETER cssimginline 
        Inline small images (less than 2KB) referred within CSS files as background-URLs. 
    .PARAMETER jpgoptimize 
        Remove non-image data such as comments from JPEG images. 
    .PARAMETER imglazyload 
        Download images, only when the user scrolls the page to view them. 
    .PARAMETER cssminify 
        Remove comments and whitespaces from CSSs. 
    .PARAMETER cssinline 
        Inline CSS files, whose size is less than 2KB, within the main page. 
    .PARAMETER csscombine 
        Combine one or more CSS files into one file. 
    .PARAMETER convertimporttolink 
        Convert CSS import statements to HTML link tags. 
    .PARAMETER jsminify 
        Remove comments and whitespaces from JavaScript. 
    .PARAMETER jsinline 
        Convert linked JavaScript files (less than 2KB) to inline JavaScript files. 
    .PARAMETER htmlminify 
        Remove comments and whitespaces from an HTML page. 
    .PARAMETER cssmovetohead 
        Move any CSS file present within the body tag of an HTML page to the head tag. 
    .PARAMETER jsmovetoend 
        Move any JavaScript present in the body tag to the end of the body tag. 
    .PARAMETER domainsharding 
        Domain name of the server. 
    .PARAMETER dnsshards 
        Set of domain names that replaces the parent domain. 
    .PARAMETER clientsidemeasurements 
        Send AppFlow records about the web pages optimized by this action. The records provide FEO statistics, such as the number of HTTP requests that have been reduced for this page. You must enable the Appflow feature before enabling this parameter. 
    .PARAMETER PassThru 
        Return details about the created feoaction item.
    .EXAMPLE
        Invoke-ADCAddFeoaction -name <string>
    .NOTES
        File Name : Invoke-ADCAddFeoaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feoaction/
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
        [string]$name ,

        [boolean]$pageextendcache ,

        [ValidateRange(0, 360)]
        [double]$cachemaxage = '30' ,

        [boolean]$imgshrinktoattrib ,

        [boolean]$imggiftopng ,

        [boolean]$imgtowebp ,

        [boolean]$imgtojpegxr ,

        [boolean]$imginline ,

        [boolean]$cssimginline ,

        [boolean]$jpgoptimize ,

        [boolean]$imglazyload ,

        [boolean]$cssminify ,

        [boolean]$cssinline ,

        [boolean]$csscombine ,

        [boolean]$convertimporttolink ,

        [boolean]$jsminify ,

        [boolean]$jsinline ,

        [boolean]$htmlminify ,

        [boolean]$cssmovetohead ,

        [boolean]$jsmovetoend ,

        [string]$domainsharding ,

        [string[]]$dnsshards ,

        [boolean]$clientsidemeasurements ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddFeoaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('pageextendcache')) { $Payload.Add('pageextendcache', $pageextendcache) }
            if ($PSBoundParameters.ContainsKey('cachemaxage')) { $Payload.Add('cachemaxage', $cachemaxage) }
            if ($PSBoundParameters.ContainsKey('imgshrinktoattrib')) { $Payload.Add('imgshrinktoattrib', $imgshrinktoattrib) }
            if ($PSBoundParameters.ContainsKey('imggiftopng')) { $Payload.Add('imggiftopng', $imggiftopng) }
            if ($PSBoundParameters.ContainsKey('imgtowebp')) { $Payload.Add('imgtowebp', $imgtowebp) }
            if ($PSBoundParameters.ContainsKey('imgtojpegxr')) { $Payload.Add('imgtojpegxr', $imgtojpegxr) }
            if ($PSBoundParameters.ContainsKey('imginline')) { $Payload.Add('imginline', $imginline) }
            if ($PSBoundParameters.ContainsKey('cssimginline')) { $Payload.Add('cssimginline', $cssimginline) }
            if ($PSBoundParameters.ContainsKey('jpgoptimize')) { $Payload.Add('jpgoptimize', $jpgoptimize) }
            if ($PSBoundParameters.ContainsKey('imglazyload')) { $Payload.Add('imglazyload', $imglazyload) }
            if ($PSBoundParameters.ContainsKey('cssminify')) { $Payload.Add('cssminify', $cssminify) }
            if ($PSBoundParameters.ContainsKey('cssinline')) { $Payload.Add('cssinline', $cssinline) }
            if ($PSBoundParameters.ContainsKey('csscombine')) { $Payload.Add('csscombine', $csscombine) }
            if ($PSBoundParameters.ContainsKey('convertimporttolink')) { $Payload.Add('convertimporttolink', $convertimporttolink) }
            if ($PSBoundParameters.ContainsKey('jsminify')) { $Payload.Add('jsminify', $jsminify) }
            if ($PSBoundParameters.ContainsKey('jsinline')) { $Payload.Add('jsinline', $jsinline) }
            if ($PSBoundParameters.ContainsKey('htmlminify')) { $Payload.Add('htmlminify', $htmlminify) }
            if ($PSBoundParameters.ContainsKey('cssmovetohead')) { $Payload.Add('cssmovetohead', $cssmovetohead) }
            if ($PSBoundParameters.ContainsKey('jsmovetoend')) { $Payload.Add('jsmovetoend', $jsmovetoend) }
            if ($PSBoundParameters.ContainsKey('domainsharding')) { $Payload.Add('domainsharding', $domainsharding) }
            if ($PSBoundParameters.ContainsKey('dnsshards')) { $Payload.Add('dnsshards', $dnsshards) }
            if ($PSBoundParameters.ContainsKey('clientsidemeasurements')) { $Payload.Add('clientsidemeasurements', $clientsidemeasurements) }
 
            if ($PSCmdlet.ShouldProcess("feoaction", "Add Front configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type feoaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetFeoaction -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddFeoaction: Finished"
    }
}

function Invoke-ADCUpdateFeoaction {
<#
    .SYNOPSIS
        Update Front configuration Object
    .DESCRIPTION
        Update Front configuration Object 
    .PARAMETER name 
        The name of the front end optimization action.  
        Minimum length = 1 
    .PARAMETER pageextendcache 
        Extend the time period during which the browser can use the cached resource. 
    .PARAMETER cachemaxage 
        Maxage for cache extension.  
        Default value: 30  
        Minimum value = 0  
        Maximum value = 360 
    .PARAMETER imgshrinktoattrib 
        Shrink image dimensions as per the height and width attributes specified in the <img> tag. 
    .PARAMETER imggiftopng 
        Convert GIF image formats to PNG formats. 
    .PARAMETER imgtowebp 
        Convert JPEG, GIF, PNG image formats to WEBP format. 
    .PARAMETER imgtojpegxr 
        Convert JPEG, GIF, PNG image formats to JXR format. 
    .PARAMETER imginline 
        Inline images whose size is less than 2KB. 
    .PARAMETER cssimginline 
        Inline small images (less than 2KB) referred within CSS files as background-URLs. 
    .PARAMETER jpgoptimize 
        Remove non-image data such as comments from JPEG images. 
    .PARAMETER imglazyload 
        Download images, only when the user scrolls the page to view them. 
    .PARAMETER cssminify 
        Remove comments and whitespaces from CSSs. 
    .PARAMETER cssinline 
        Inline CSS files, whose size is less than 2KB, within the main page. 
    .PARAMETER csscombine 
        Combine one or more CSS files into one file. 
    .PARAMETER convertimporttolink 
        Convert CSS import statements to HTML link tags. 
    .PARAMETER jsminify 
        Remove comments and whitespaces from JavaScript. 
    .PARAMETER jsinline 
        Convert linked JavaScript files (less than 2KB) to inline JavaScript files. 
    .PARAMETER htmlminify 
        Remove comments and whitespaces from an HTML page. 
    .PARAMETER cssmovetohead 
        Move any CSS file present within the body tag of an HTML page to the head tag. 
    .PARAMETER jsmovetoend 
        Move any JavaScript present in the body tag to the end of the body tag. 
    .PARAMETER domainsharding 
        Domain name of the server. 
    .PARAMETER dnsshards 
        Set of domain names that replaces the parent domain. 
    .PARAMETER clientsidemeasurements 
        Send AppFlow records about the web pages optimized by this action. The records provide FEO statistics, such as the number of HTTP requests that have been reduced for this page. You must enable the Appflow feature before enabling this parameter. 
    .PARAMETER PassThru 
        Return details about the created feoaction item.
    .EXAMPLE
        Invoke-ADCUpdateFeoaction -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateFeoaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feoaction/
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
        [string]$name ,

        [boolean]$pageextendcache ,

        [ValidateRange(0, 360)]
        [double]$cachemaxage ,

        [boolean]$imgshrinktoattrib ,

        [boolean]$imggiftopng ,

        [boolean]$imgtowebp ,

        [boolean]$imgtojpegxr ,

        [boolean]$imginline ,

        [boolean]$cssimginline ,

        [boolean]$jpgoptimize ,

        [boolean]$imglazyload ,

        [boolean]$cssminify ,

        [boolean]$cssinline ,

        [boolean]$csscombine ,

        [boolean]$convertimporttolink ,

        [boolean]$jsminify ,

        [boolean]$jsinline ,

        [boolean]$htmlminify ,

        [boolean]$cssmovetohead ,

        [boolean]$jsmovetoend ,

        [string]$domainsharding ,

        [string[]]$dnsshards ,

        [boolean]$clientsidemeasurements ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateFeoaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('pageextendcache')) { $Payload.Add('pageextendcache', $pageextendcache) }
            if ($PSBoundParameters.ContainsKey('cachemaxage')) { $Payload.Add('cachemaxage', $cachemaxage) }
            if ($PSBoundParameters.ContainsKey('imgshrinktoattrib')) { $Payload.Add('imgshrinktoattrib', $imgshrinktoattrib) }
            if ($PSBoundParameters.ContainsKey('imggiftopng')) { $Payload.Add('imggiftopng', $imggiftopng) }
            if ($PSBoundParameters.ContainsKey('imgtowebp')) { $Payload.Add('imgtowebp', $imgtowebp) }
            if ($PSBoundParameters.ContainsKey('imgtojpegxr')) { $Payload.Add('imgtojpegxr', $imgtojpegxr) }
            if ($PSBoundParameters.ContainsKey('imginline')) { $Payload.Add('imginline', $imginline) }
            if ($PSBoundParameters.ContainsKey('cssimginline')) { $Payload.Add('cssimginline', $cssimginline) }
            if ($PSBoundParameters.ContainsKey('jpgoptimize')) { $Payload.Add('jpgoptimize', $jpgoptimize) }
            if ($PSBoundParameters.ContainsKey('imglazyload')) { $Payload.Add('imglazyload', $imglazyload) }
            if ($PSBoundParameters.ContainsKey('cssminify')) { $Payload.Add('cssminify', $cssminify) }
            if ($PSBoundParameters.ContainsKey('cssinline')) { $Payload.Add('cssinline', $cssinline) }
            if ($PSBoundParameters.ContainsKey('csscombine')) { $Payload.Add('csscombine', $csscombine) }
            if ($PSBoundParameters.ContainsKey('convertimporttolink')) { $Payload.Add('convertimporttolink', $convertimporttolink) }
            if ($PSBoundParameters.ContainsKey('jsminify')) { $Payload.Add('jsminify', $jsminify) }
            if ($PSBoundParameters.ContainsKey('jsinline')) { $Payload.Add('jsinline', $jsinline) }
            if ($PSBoundParameters.ContainsKey('htmlminify')) { $Payload.Add('htmlminify', $htmlminify) }
            if ($PSBoundParameters.ContainsKey('cssmovetohead')) { $Payload.Add('cssmovetohead', $cssmovetohead) }
            if ($PSBoundParameters.ContainsKey('jsmovetoend')) { $Payload.Add('jsmovetoend', $jsmovetoend) }
            if ($PSBoundParameters.ContainsKey('domainsharding')) { $Payload.Add('domainsharding', $domainsharding) }
            if ($PSBoundParameters.ContainsKey('dnsshards')) { $Payload.Add('dnsshards', $dnsshards) }
            if ($PSBoundParameters.ContainsKey('clientsidemeasurements')) { $Payload.Add('clientsidemeasurements', $clientsidemeasurements) }
 
            if ($PSCmdlet.ShouldProcess("feoaction", "Update Front configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type feoaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetFeoaction -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateFeoaction: Finished"
    }
}

function Invoke-ADCUnsetFeoaction {
<#
    .SYNOPSIS
        Unset Front configuration Object
    .DESCRIPTION
        Unset Front configuration Object 
   .PARAMETER name 
       The name of the front end optimization action. 
   .PARAMETER pageextendcache 
       Extend the time period during which the browser can use the cached resource. 
   .PARAMETER imgshrinktoattrib 
       Shrink image dimensions as per the height and width attributes specified in the <img> tag. 
   .PARAMETER imggiftopng 
       Convert GIF image formats to PNG formats. 
   .PARAMETER imgtowebp 
       Convert JPEG, GIF, PNG image formats to WEBP format. 
   .PARAMETER imgtojpegxr 
       Convert JPEG, GIF, PNG image formats to JXR format. 
   .PARAMETER imginline 
       Inline images whose size is less than 2KB. 
   .PARAMETER cssimginline 
       Inline small images (less than 2KB) referred within CSS files as background-URLs. 
   .PARAMETER jpgoptimize 
       Remove non-image data such as comments from JPEG images. 
   .PARAMETER imglazyload 
       Download images, only when the user scrolls the page to view them. 
   .PARAMETER cssminify 
       Remove comments and whitespaces from CSSs. 
   .PARAMETER cssinline 
       Inline CSS files, whose size is less than 2KB, within the main page. 
   .PARAMETER csscombine 
       Combine one or more CSS files into one file. 
   .PARAMETER convertimporttolink 
       Convert CSS import statements to HTML link tags. 
   .PARAMETER jsminify 
       Remove comments and whitespaces from JavaScript. 
   .PARAMETER jsinline 
       Convert linked JavaScript files (less than 2KB) to inline JavaScript files. 
   .PARAMETER htmlminify 
       Remove comments and whitespaces from an HTML page. 
   .PARAMETER cssmovetohead 
       Move any CSS file present within the body tag of an HTML page to the head tag. 
   .PARAMETER jsmovetoend 
       Move any JavaScript present in the body tag to the end of the body tag. 
   .PARAMETER clientsidemeasurements 
       Send AppFlow records about the web pages optimized by this action. The records provide FEO statistics, such as the number of HTTP requests that have been reduced for this page. You must enable the Appflow feature before enabling this parameter. 
   .PARAMETER domainsharding 
       Domain name of the server.
    .EXAMPLE
        Invoke-ADCUnsetFeoaction -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetFeoaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feoaction
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
        [string]$name ,

        [Boolean]$pageextendcache ,

        [Boolean]$imgshrinktoattrib ,

        [Boolean]$imggiftopng ,

        [Boolean]$imgtowebp ,

        [Boolean]$imgtojpegxr ,

        [Boolean]$imginline ,

        [Boolean]$cssimginline ,

        [Boolean]$jpgoptimize ,

        [Boolean]$imglazyload ,

        [Boolean]$cssminify ,

        [Boolean]$cssinline ,

        [Boolean]$csscombine ,

        [Boolean]$convertimporttolink ,

        [Boolean]$jsminify ,

        [Boolean]$jsinline ,

        [Boolean]$htmlminify ,

        [Boolean]$cssmovetohead ,

        [Boolean]$jsmovetoend ,

        [Boolean]$clientsidemeasurements ,

        [Boolean]$domainsharding 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetFeoaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('pageextendcache')) { $Payload.Add('pageextendcache', $pageextendcache) }
            if ($PSBoundParameters.ContainsKey('imgshrinktoattrib')) { $Payload.Add('imgshrinktoattrib', $imgshrinktoattrib) }
            if ($PSBoundParameters.ContainsKey('imggiftopng')) { $Payload.Add('imggiftopng', $imggiftopng) }
            if ($PSBoundParameters.ContainsKey('imgtowebp')) { $Payload.Add('imgtowebp', $imgtowebp) }
            if ($PSBoundParameters.ContainsKey('imgtojpegxr')) { $Payload.Add('imgtojpegxr', $imgtojpegxr) }
            if ($PSBoundParameters.ContainsKey('imginline')) { $Payload.Add('imginline', $imginline) }
            if ($PSBoundParameters.ContainsKey('cssimginline')) { $Payload.Add('cssimginline', $cssimginline) }
            if ($PSBoundParameters.ContainsKey('jpgoptimize')) { $Payload.Add('jpgoptimize', $jpgoptimize) }
            if ($PSBoundParameters.ContainsKey('imglazyload')) { $Payload.Add('imglazyload', $imglazyload) }
            if ($PSBoundParameters.ContainsKey('cssminify')) { $Payload.Add('cssminify', $cssminify) }
            if ($PSBoundParameters.ContainsKey('cssinline')) { $Payload.Add('cssinline', $cssinline) }
            if ($PSBoundParameters.ContainsKey('csscombine')) { $Payload.Add('csscombine', $csscombine) }
            if ($PSBoundParameters.ContainsKey('convertimporttolink')) { $Payload.Add('convertimporttolink', $convertimporttolink) }
            if ($PSBoundParameters.ContainsKey('jsminify')) { $Payload.Add('jsminify', $jsminify) }
            if ($PSBoundParameters.ContainsKey('jsinline')) { $Payload.Add('jsinline', $jsinline) }
            if ($PSBoundParameters.ContainsKey('htmlminify')) { $Payload.Add('htmlminify', $htmlminify) }
            if ($PSBoundParameters.ContainsKey('cssmovetohead')) { $Payload.Add('cssmovetohead', $cssmovetohead) }
            if ($PSBoundParameters.ContainsKey('jsmovetoend')) { $Payload.Add('jsmovetoend', $jsmovetoend) }
            if ($PSBoundParameters.ContainsKey('clientsidemeasurements')) { $Payload.Add('clientsidemeasurements', $clientsidemeasurements) }
            if ($PSBoundParameters.ContainsKey('domainsharding')) { $Payload.Add('domainsharding', $domainsharding) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Front configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type feoaction -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetFeoaction: Finished"
    }
}

function Invoke-ADCDeleteFeoaction {
<#
    .SYNOPSIS
        Delete Front configuration Object
    .DESCRIPTION
        Delete Front configuration Object
    .PARAMETER name 
       The name of the front end optimization action.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteFeoaction -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteFeoaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feoaction/
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
        Write-Verbose "Invoke-ADCDeleteFeoaction: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Front configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type feoaction -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteFeoaction: Finished"
    }
}

function Invoke-ADCGetFeoaction {
<#
    .SYNOPSIS
        Get Front configuration object(s)
    .DESCRIPTION
        Get Front configuration object(s)
    .PARAMETER name 
       The name of the front end optimization action. 
    .PARAMETER GetAll 
        Retreive all feoaction object(s)
    .PARAMETER Count
        If specified, the count of the feoaction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFeoaction
    .EXAMPLE 
        Invoke-ADCGetFeoaction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetFeoaction -Count
    .EXAMPLE
        Invoke-ADCGetFeoaction -name <string>
    .EXAMPLE
        Invoke-ADCGetFeoaction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFeoaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feoaction/
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
        Write-Verbose "Invoke-ADCGetFeoaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all feoaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feoaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for feoaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feoaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving feoaction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feoaction -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving feoaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feoaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving feoaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feoaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFeoaction: Ended"
    }
}

function Invoke-ADCGetFeoglobalbinding {
<#
    .SYNOPSIS
        Get Front configuration object(s)
    .DESCRIPTION
        Get Front configuration object(s)
    .PARAMETER GetAll 
        Retreive all feoglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the feoglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFeoglobalbinding
    .EXAMPLE 
        Invoke-ADCGetFeoglobalbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetFeoglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetFeoglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFeoglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feoglobal_binding/
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
        Write-Verbose "Invoke-ADCGetFeoglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all feoglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feoglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for feoglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feoglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving feoglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feoglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving feoglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving feoglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feoglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFeoglobalbinding: Ended"
    }
}

function Invoke-ADCAddFeoglobalfeopolicybinding {
<#
    .SYNOPSIS
        Add Front configuration Object
    .DESCRIPTION
        Add Front configuration Object 
    .PARAMETER policyname 
        The name of the globally bound front end optimization policy. 
    .PARAMETER priority 
        The priority assigned to the policy binding. 
    .PARAMETER type 
        Bindpoint to which the policy is bound.  
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT, NONE 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created feoglobal_feopolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddFeoglobalfeopolicybinding -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddFeoglobalfeopolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feoglobal_feopolicy_binding/
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
        [string]$policyname ,

        [Parameter(Mandatory = $true)]
        [double]$priority ,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT', 'NONE')]
        [string]$type ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddFeoglobalfeopolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
                priority = $priority
            }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("feoglobal_feopolicy_binding", "Add Front configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type feoglobal_feopolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetFeoglobalfeopolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddFeoglobalfeopolicybinding: Finished"
    }
}

function Invoke-ADCDeleteFeoglobalfeopolicybinding {
<#
    .SYNOPSIS
        Delete Front configuration Object
    .DESCRIPTION
        Delete Front configuration Object
     .PARAMETER policyname 
       The name of the globally bound front end optimization policy.    .PARAMETER type 
       Bindpoint to which the policy is bound.  
       Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT, NONE    .PARAMETER priority 
       The priority assigned to the policy binding.
    .EXAMPLE
        Invoke-ADCDeleteFeoglobalfeopolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteFeoglobalfeopolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feoglobal_feopolicy_binding/
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

        [string]$policyname ,

        [string]$type ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteFeoglobalfeopolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("feoglobal_feopolicy_binding", "Delete Front configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type feoglobal_feopolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteFeoglobalfeopolicybinding: Finished"
    }
}

function Invoke-ADCGetFeoglobalfeopolicybinding {
<#
    .SYNOPSIS
        Get Front configuration object(s)
    .DESCRIPTION
        Get Front configuration object(s)
    .PARAMETER GetAll 
        Retreive all feoglobal_feopolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the feoglobal_feopolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFeoglobalfeopolicybinding
    .EXAMPLE 
        Invoke-ADCGetFeoglobalfeopolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetFeoglobalfeopolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetFeoglobalfeopolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetFeoglobalfeopolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFeoglobalfeopolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feoglobal_feopolicy_binding/
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
        Write-Verbose "Invoke-ADCGetFeoglobalfeopolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all feoglobal_feopolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feoglobal_feopolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for feoglobal_feopolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feoglobal_feopolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving feoglobal_feopolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feoglobal_feopolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving feoglobal_feopolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving feoglobal_feopolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feoglobal_feopolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFeoglobalfeopolicybinding: Ended"
    }
}

function Invoke-ADCUpdateFeoparameter {
<#
    .SYNOPSIS
        Update Front configuration Object
    .DESCRIPTION
        Update Front configuration Object 
    .PARAMETER jpegqualitypercent 
        The percentage value of a JPEG image quality to be reduced. Range: 0 - 100.  
        Default value: 75  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER cssinlinethressize 
        Threshold value of the file size (in bytes) for converting external CSS files to inline CSS files.  
        Default value: 1024  
        Minimum value = 1  
        Maximum value = 2048 
    .PARAMETER jsinlinethressize 
        Threshold value of the file size (in bytes), for converting external JavaScript files to inline JavaScript files.  
        Default value: 1024  
        Minimum value = 1  
        Maximum value = 2048 
    .PARAMETER imginlinethressize 
        Maximum file size of an image (in bytes), for coverting linked images to inline images.  
        Default value: 1024  
        Minimum value = 1  
        Maximum value = 2048
    .EXAMPLE
        Invoke-ADCUpdateFeoparameter 
    .NOTES
        File Name : Invoke-ADCUpdateFeoparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feoparameter/
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

        [ValidateRange(0, 100)]
        [double]$jpegqualitypercent ,

        [ValidateRange(1, 2048)]
        [double]$cssinlinethressize ,

        [ValidateRange(1, 2048)]
        [double]$jsinlinethressize ,

        [ValidateRange(1, 2048)]
        [double]$imginlinethressize 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateFeoparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('jpegqualitypercent')) { $Payload.Add('jpegqualitypercent', $jpegqualitypercent) }
            if ($PSBoundParameters.ContainsKey('cssinlinethressize')) { $Payload.Add('cssinlinethressize', $cssinlinethressize) }
            if ($PSBoundParameters.ContainsKey('jsinlinethressize')) { $Payload.Add('jsinlinethressize', $jsinlinethressize) }
            if ($PSBoundParameters.ContainsKey('imginlinethressize')) { $Payload.Add('imginlinethressize', $imginlinethressize) }
 
            if ($PSCmdlet.ShouldProcess("feoparameter", "Update Front configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type feoparameter -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateFeoparameter: Finished"
    }
}

function Invoke-ADCUnsetFeoparameter {
<#
    .SYNOPSIS
        Unset Front configuration Object
    .DESCRIPTION
        Unset Front configuration Object 
   .PARAMETER jpegqualitypercent 
       The percentage value of a JPEG image quality to be reduced. . 
   .PARAMETER cssinlinethressize 
       Threshold value of the file size (in bytes) for converting external CSS files to inline CSS files. 
   .PARAMETER jsinlinethressize 
       Threshold value of the file size (in bytes), for converting external JavaScript files to inline JavaScript files. 
   .PARAMETER imginlinethressize 
       Maximum file size of an image (in bytes), for coverting linked images to inline images.
    .EXAMPLE
        Invoke-ADCUnsetFeoparameter 
    .NOTES
        File Name : Invoke-ADCUnsetFeoparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feoparameter
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

        [Boolean]$jpegqualitypercent ,

        [Boolean]$cssinlinethressize ,

        [Boolean]$jsinlinethressize ,

        [Boolean]$imginlinethressize 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetFeoparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('jpegqualitypercent')) { $Payload.Add('jpegqualitypercent', $jpegqualitypercent) }
            if ($PSBoundParameters.ContainsKey('cssinlinethressize')) { $Payload.Add('cssinlinethressize', $cssinlinethressize) }
            if ($PSBoundParameters.ContainsKey('jsinlinethressize')) { $Payload.Add('jsinlinethressize', $jsinlinethressize) }
            if ($PSBoundParameters.ContainsKey('imginlinethressize')) { $Payload.Add('imginlinethressize', $imginlinethressize) }
            if ($PSCmdlet.ShouldProcess("feoparameter", "Unset Front configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type feoparameter -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetFeoparameter: Finished"
    }
}

function Invoke-ADCGetFeoparameter {
<#
    .SYNOPSIS
        Get Front configuration object(s)
    .DESCRIPTION
        Get Front configuration object(s)
    .PARAMETER GetAll 
        Retreive all feoparameter object(s)
    .PARAMETER Count
        If specified, the count of the feoparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFeoparameter
    .EXAMPLE 
        Invoke-ADCGetFeoparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetFeoparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetFeoparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFeoparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feoparameter/
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
        Write-Verbose "Invoke-ADCGetFeoparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all feoparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feoparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for feoparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feoparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving feoparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feoparameter -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving feoparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving feoparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feoparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFeoparameter: Ended"
    }
}

function Invoke-ADCAddFeopolicy {
<#
    .SYNOPSIS
        Add Front configuration Object
    .DESCRIPTION
        Add Front configuration Object 
    .PARAMETER name 
        The name of the front end optimization policy.  
        Minimum length = 1 
    .PARAMETER rule 
        The rule associated with the front end optimization policy. 
    .PARAMETER action 
        The front end optimization action that has to be performed when the rule matches.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created feopolicy item.
    .EXAMPLE
        Invoke-ADCAddFeopolicy -name <string> -rule <string> -action <string>
    .NOTES
        File Name : Invoke-ADCAddFeopolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feopolicy/
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
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [string]$rule ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$action ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddFeopolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                rule = $rule
                action = $action
            }

 
            if ($PSCmdlet.ShouldProcess("feopolicy", "Add Front configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type feopolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetFeopolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddFeopolicy: Finished"
    }
}

function Invoke-ADCDeleteFeopolicy {
<#
    .SYNOPSIS
        Delete Front configuration Object
    .DESCRIPTION
        Delete Front configuration Object
    .PARAMETER name 
       The name of the front end optimization policy.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteFeopolicy -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteFeopolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feopolicy/
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
        Write-Verbose "Invoke-ADCDeleteFeopolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Front configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type feopolicy -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteFeopolicy: Finished"
    }
}

function Invoke-ADCUpdateFeopolicy {
<#
    .SYNOPSIS
        Update Front configuration Object
    .DESCRIPTION
        Update Front configuration Object 
    .PARAMETER name 
        The name of the front end optimization policy.  
        Minimum length = 1 
    .PARAMETER rule 
        The rule associated with the front end optimization policy. 
    .PARAMETER action 
        The front end optimization action that has to be performed when the rule matches.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created feopolicy item.
    .EXAMPLE
        Invoke-ADCUpdateFeopolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateFeopolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feopolicy/
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
        [string]$name ,

        [string]$rule ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$action ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateFeopolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
 
            if ($PSCmdlet.ShouldProcess("feopolicy", "Update Front configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type feopolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetFeopolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateFeopolicy: Finished"
    }
}

function Invoke-ADCUnsetFeopolicy {
<#
    .SYNOPSIS
        Unset Front configuration Object
    .DESCRIPTION
        Unset Front configuration Object 
   .PARAMETER name 
       The name of the front end optimization policy. 
   .PARAMETER rule 
       The rule associated with the front end optimization policy. 
   .PARAMETER action 
       The front end optimization action that has to be performed when the rule matches.
    .EXAMPLE
        Invoke-ADCUnsetFeopolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetFeopolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feopolicy
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
        [string]$name ,

        [Boolean]$rule ,

        [Boolean]$action 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetFeopolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Front configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type feopolicy -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetFeopolicy: Finished"
    }
}

function Invoke-ADCGetFeopolicy {
<#
    .SYNOPSIS
        Get Front configuration object(s)
    .DESCRIPTION
        Get Front configuration object(s)
    .PARAMETER name 
       The name of the front end optimization policy. 
    .PARAMETER GetAll 
        Retreive all feopolicy object(s)
    .PARAMETER Count
        If specified, the count of the feopolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFeopolicy
    .EXAMPLE 
        Invoke-ADCGetFeopolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetFeopolicy -Count
    .EXAMPLE
        Invoke-ADCGetFeopolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetFeopolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFeopolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feopolicy/
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
        Write-Verbose "Invoke-ADCGetFeopolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all feopolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for feopolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving feopolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving feopolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving feopolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFeopolicy: Ended"
    }
}

function Invoke-ADCGetFeopolicybinding {
<#
    .SYNOPSIS
        Get Front configuration object(s)
    .DESCRIPTION
        Get Front configuration object(s)
    .PARAMETER name 
       The name of the front end optimization policy. 
    .PARAMETER GetAll 
        Retreive all feopolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the feopolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFeopolicybinding
    .EXAMPLE 
        Invoke-ADCGetFeopolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetFeopolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetFeopolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFeopolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feopolicy_binding/
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
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetFeopolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all feopolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for feopolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving feopolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving feopolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving feopolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFeopolicybinding: Ended"
    }
}

function Invoke-ADCGetFeopolicycsvserverbinding {
<#
    .SYNOPSIS
        Get Front configuration object(s)
    .DESCRIPTION
        Get Front configuration object(s)
    .PARAMETER name 
       The name of the front end optimization policy. 
    .PARAMETER GetAll 
        Retreive all feopolicy_csvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the feopolicy_csvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFeopolicycsvserverbinding
    .EXAMPLE 
        Invoke-ADCGetFeopolicycsvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetFeopolicycsvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetFeopolicycsvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetFeopolicycsvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFeopolicycsvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feopolicy_csvserver_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetFeopolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all feopolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for feopolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving feopolicy_csvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving feopolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving feopolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFeopolicycsvserverbinding: Ended"
    }
}

function Invoke-ADCGetFeopolicyfeoglobalbinding {
<#
    .SYNOPSIS
        Get Front configuration object(s)
    .DESCRIPTION
        Get Front configuration object(s)
    .PARAMETER name 
       The name of the front end optimization policy. 
    .PARAMETER GetAll 
        Retreive all feopolicy_feoglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the feopolicy_feoglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFeopolicyfeoglobalbinding
    .EXAMPLE 
        Invoke-ADCGetFeopolicyfeoglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetFeopolicyfeoglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetFeopolicyfeoglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetFeopolicyfeoglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFeopolicyfeoglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feopolicy_feoglobal_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetFeopolicyfeoglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all feopolicy_feoglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_feoglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for feopolicy_feoglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_feoglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving feopolicy_feoglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_feoglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving feopolicy_feoglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_feoglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving feopolicy_feoglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_feoglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFeopolicyfeoglobalbinding: Ended"
    }
}

function Invoke-ADCGetFeopolicylbvserverbinding {
<#
    .SYNOPSIS
        Get Front configuration object(s)
    .DESCRIPTION
        Get Front configuration object(s)
    .PARAMETER name 
       The name of the front end optimization policy. 
    .PARAMETER GetAll 
        Retreive all feopolicy_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the feopolicy_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFeopolicylbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetFeopolicylbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetFeopolicylbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetFeopolicylbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetFeopolicylbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFeopolicylbvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/feo/feopolicy_lbvserver_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetFeopolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all feopolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for feopolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving feopolicy_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving feopolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving feopolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type feopolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFeopolicylbvserverbinding: Ended"
    }
}


