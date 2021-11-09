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
#$ModulePath = Join-Path -Path $ModuleParent -ChildPath "$ModuleName.psm1"

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

      $file.fullname | Should -Exist

      $contents = Get-Content -Path $file.fullname -ErrorAction Stop
      $errors = $null
      $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
      $errors.Count | Should -Be 0
    }
    $scriptAnalyzerRules = Get-ScriptAnalyzerRule
    It "<file> should pass ScriptAnalyzer" -TestCases $testCase {
      param($file)
      $analysis = Invoke-ScriptAnalyzer -Path  $file.fullname -ExcludeRule @(
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
          Where-Object RuleName -EQ $rule -outvariable failures |
          Out-Default
          $failures.Count | Should -Be 0
        }
      }
    }
  }
}
