Describe "Get-DiskSpaceReport Script" {

    It "Script file exists" {

        $ScriptPath = Join-Path $PSScriptRoot "..\scripts\Windows\Get-DiskSpaceReport.ps1"

        Test-Path $ScriptPath | Should -BeTrue

    }

}