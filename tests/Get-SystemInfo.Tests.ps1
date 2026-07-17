Describe "Get-SystemInfo Script" {

    It "Script file exists" {

        $ScriptPath = Join-Path $PSScriptRoot "..\scripts\Windows\Get-SystemInfo.ps1"

        Test-Path $ScriptPath | Should -BeTrue

    }

}