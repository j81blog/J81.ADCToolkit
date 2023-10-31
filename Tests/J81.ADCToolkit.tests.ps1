<#
    .SYNOPSIS
        Main Pester function tests.
#>
[OutputType()]
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
param ()


BeforeDiscovery {
    # Get the ScriptAnalyzer rules
    $scriptAnalyzerRules = Get-ScriptAnalyzerRule

    # Find module scripts to create the test cases
    $scripts = Get-ChildItem -Path $(Join-Path -Path $ProjectRoot -ChildPath "*") -Recurse -Include *.ps1 | Where-Object { $_.Fullname -like "*\public\*" -or $_.Fullname -like "*\private\*" }
    $testCase = $scripts | ForEach-Object { @{file = $_ } }
    $moduleDataTestCase = $moduleData | ForEach-Object { @{Data = $_ } }
}

# Test module and manifest
Describe "Module Metadata validation" {
    It "Import module should be OK" -TestCases $moduleDataTestCase {
        param ($Data)
        { 
            $modulePath = $(Join-Path -Path $ProjectRoot -ChildPath $Data.ModuleRoot)
            Import-Module "$modulePath" -Force -ErrorAction Stop
        } | Should -Not -Throw
    }

    It "Module FunctionsToExport should have multiple functions" -TestCases $moduleDataTestCase {
        param ($Data)
        { 
            $modulePath = $(Join-Path -Path $ProjectRoot -ChildPath $Data.ModuleRoot)
            $dataFile = Import-PowerShellDataFile -Path $modulePath | Should -Not Throw -ErrorAction Stop
            [Int]($dataFile.FunctionsToExport.Count) | Should -BeGreaterThan 0 -ErrorAction Stop
        }
    }
    It "Module version not be Null" -TestCases $moduleDataTestCase {
        param ($Data)
        { 
            $modulePath = $(Join-Path -Path $ProjectRoot -ChildPath $Data.ModuleRoot)
            $dataFile = Import-PowerShellDataFile -Path $modulePath | Should -Not Throw -ErrorAction Stop
            $dataFile.ModuleVersion | Should -Not -BeNullOrEmpty -ErrorAction Stop
        }
    }
    It "Module CompanyName should not be Null" -TestCases $moduleDataTestCase {
        param ($Data)
        { 
            $modulePath = $(Join-Path -Path $ProjectRoot -ChildPath $Data.ModuleRoot)
            $dataFile = Import-PowerShellDataFile -Path $modulePath | Should -Not Throw -ErrorAction Stop
            $dataFile.CompanyName | Should -Not -BeNullOrEmpty -ErrorAction Stop
        }
    }
    It "Module Copyright should not be Null" -TestCases $moduleDataTestCase {
        param ($Data)
        { 
            $modulePath = $(Join-Path -Path $ProjectRoot -ChildPath $Data.ModuleRoot)
            $dataFile = Import-PowerShellDataFile -Path $modulePath | Should -Not Throw -ErrorAction Stop
            $dataFile.Copyright  | Should -Not -BeNullOrEmpty -ErrorAction Stop
        }
    }
    It "Module Author should not be Null" -TestCases $moduleDataTestCase {
        param ($Data)
        { 
            $modulePath = $(Join-Path -Path $ProjectRoot -ChildPath $Data.ModuleRoot)
            $dataFile = Import-PowerShellDataFile -Path $modulePath | Should -Not Throw -ErrorAction Stop
            $dataFile.Author | Should -Not -BeNullOrEmpty -ErrorAction Stop
        }
    }
    It "Module GUID should not be Null" -TestCases $moduleDataTestCase {
        param ($Data)
        { 
            $modulePath = $(Join-Path -Path $ProjectRoot -ChildPath $Data.ModuleRoot)
            $dataFile = Import-PowerShellDataFile -Path $modulePath | Should -Not Throw -ErrorAction Stop
            $dataFile.GUID | Should -Not -BeNullOrEmpty -ErrorAction Stop
        }
    }


    <#It "Script fileinfo should be OK" -TestCases $moduleDataTestCase {
        param ($Data) { 
            Test-ModuleManifest -Path $Data.ManifestFilepath
        } | Should -Not -Throw
    }#>
}

Describe "General project validation" {    
    It "Script <file.Name> should be valid PowerShell" -TestCases $testCase {
        param ($file)

        $file.FullName | Should -Exist

        $contents = Get-Content -Path $file.FullName -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors.Count | Should -Be 0
    }

    if ($environment -ne "APPVEYOR" ) {
        It "Script <file.Name> should be signed" -TestCases $testCase {
            param ($file)
            $file.FullName | Should -Exist
            $Signature = Get-AuthenticodeSignature -FilePath $file
            $Signature.Status | Should -Be "Valid"
        }
    }

    It "Script <file.Name> should pass ScriptAnalyzer" -TestCases $testCase {
        param ($file)
        $analysis = Invoke-ScriptAnalyzer -Path $file.FullName -ExcludeRule @(
            'PSAvoidGlobalVars',
            'PSAvoidUsingConvertToSecureStringWithPlainText', 
            'PSUseSingularNouns',
            'PSAvoidUsingUserNameAndPasswordParams',
            'PSAvoidUsingPlainTextForPassword',
            'PSAvoidUsingWriteHost'
            'PSUseBOMForUnicodeEncodedFile'
        ) -Severity @('Warning', 'Error')    
        
        ForEach ($rule in $scriptAnalyzerRules) {
            If ($analysis.RuleName -contains $rule) {
                $analysis |
                    Where-Object RuleName -EQ $rule -OutVariable failures |
                    Out-Default
                $failures.Count | Should -Be 0
            }
        }
    }
}

