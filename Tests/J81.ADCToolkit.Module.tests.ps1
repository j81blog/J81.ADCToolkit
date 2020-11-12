[OutputType()]
Param()

# Set variables
if (Test-Path env:APPVEYOR_BUILD_FOLDER) {
  # AppVeyor Testing
  $ProjectRoot = Resolve-Path -Path $env:APPVEYOR_BUILD_FOLDER
  $ModuleName = $env:Module
} else {
  $ProjectRoot = (Resolve-Path -Path (Split-Path -Parent -Path (Split-Path -Parent -Path $MyInvocation.MyCommand.Definition))).Path
  $ModuleName = Split-Path -Path $ProjectRoot -Leaf
}
$ModuleParent = Join-Path -Path $ProjectRoot -ChildPath $ModuleName
$ManifestPath = Join-Path -Path $ModuleParent -ChildPath "$ModuleName.psd1"
$ModulePath = Join-Path -Path $ModuleParent -ChildPath "$ModuleName.psm1"

# Import module
Import-Module $ManifestPath -Force

# Run tests
Describe "General project validation" {
  $scripts = Get-ChildItem -Path $ModuleParent -Recurse -Include *.ps1, *.psm1

  # TestCases are splatted to the script so we need hashtables
  $testCase = $scripts | ForEach-Object { @{file = $_ } }
  Context "The scripts should contain valid PowerShell code" {
    It "Script <file> should be valid PowerShell" -TestCases $testCase {
      param($file)

      $file.fullname | Should Exist

      $contents = Get-Content -Path $file.fullname -ErrorAction Stop
      $errors = $null
      $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
      $errors.Count | Should Be 0
    }
  }
  Context "The scripts should pass ScriptAnalyzer" {

    $scriptAnalyzerRules = Get-ScriptAnalyzerRule
    It "<file> should pass ScriptAnalyzer" -TestCases $testCase {
      param($file)
      $analysis = Invoke-ScriptAnalyzer -Path  $file.fullname -ExcludeRule @('PSAvoidGlobalVars', 'PSAvoidUsingConvertToSecureStringWithPlainText', 'PSUseSingularNouns') -Severity @('Warning', 'Error')   
      
      ForEach ($rule in $scriptAnalyzerRules) {
        If ($analysis.RuleName -contains $rule) {
          $analysis |
          Where-Object RuleName -EQ $rule -outvariable failures |
          Out-Default
          $failures.Count | Should Be 0
        }
      }
    }
  }
}

Describe "Module Function validation" {
  $scripts = Get-ChildItem -Path $ModuleParent -Recurse -Include *.ps1
  $testCase = $scripts | ForEach-Object { @{file = $_ } }
  Context "Function must be present in manifest" {
    It "Function <file> must be present in manifest" -TestCases $testCase {
      param($file)   
      $file.fullname | Should Exist
      $contents = Get-Content -Path $file.fullname -ErrorAction Stop
      $describes = [Management.Automation.Language.Parser]::ParseInput($contents, [ref]$null, [ref]$null)
      $test = $describes.FindAll( { $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $true)
      if ($file.fullname -like "*Public*") {
        $ManifestPath | Should Contain $($test.Name)
      } else {
        $ManifestPath | Should not Contain $($test.Name)
      }
    }
  }
  Context "One function per script" {
    It "Script <file> should only contain one function" -TestCases $testCase {
      param($file)   
      $file.fullname | Should Exist
      $contents = Get-Content -Path $file.fullname -ErrorAction Stop
      $describes = [Management.Automation.Language.Parser]::ParseInput($contents, [ref]$null, [ref]$null)
      $test = $describes.FindAll( { $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $true) 
      $test.Count | Should Be 1
    }
  }
  Context "Function should match the filename" {
    It "<file> should match function name" -TestCases $testCase {
      param($file)
      $file.fullname | Should Exist
      $contents = Get-Content -Path $file.fullname -ErrorAction Stop
      $describes = [Management.Automation.Language.Parser]::ParseInput($contents, [ref]$null, [ref]$null)
      $test = $describes.FindAll( { $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $true) 
      $test[0].name | Should Be $file.basename
    }
  }
  context "Function should have a help block" {
    It "<file> should have help block" -TestCases $testCase {
      param($file)
      $file.fullname | Should Contain '<#'
      $file.fullname | Should Contain '#>'
    }
  }
  context "Function should have a SYNOPSIS block" {
    It "<file> should have a SYNOPSIS section in the help block"  -TestCases $testCase {
      param($file)
      $file.fullname | Should Contain '.SYNOPSIS'
    }
  }
  context "Function should have a DESCRIPTION block" {
    It "<file> should have a DESCRIPTION section in the help block"  -TestCases $testCase {
      param($file)
      $file.fullname | Should Contain '.DESCRIPTION'
    }
  }
  context "Function should have a EXAMPLE block" {
    It "<file> should have a EXAMPLE section in the help block"  -TestCases $testCase {
      param($file)
      $file.fullname | Should Contain '.EXAMPLE'
    }
  }
  context "Function should be an advanced function" {
    It "<file> should be an advanced function"  -TestCases $testCase {
      param($file)
      $file.fullname | Should Contain 'function'
      $file.fullname | Should Contain 'cmdletbinding'
      $file.fullname | Should Contain 'param'
    }
  }
  context "Function should contain Write-Verbose blocks" {
    It "<file> should contain Write-Verbose blocks"  -TestCases $testCase {
      param($file)
      $file.fullname | Should Contain 'Write-Verbose'
    }
  }
}
