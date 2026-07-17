Describe "Get-EventLogErrors Script" {

    It "Script file exists" {

        $ScriptPath = Join-Path $PSScriptRoot "..\scripts\Windows\Get-EventLogErrors.ps1"

        Test-Path $ScriptPath | Should -BeTrue

    }

}