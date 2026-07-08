<#
.SYNOPSIS
Collects basic system information from a Windows computer.

.DESCRIPTION
This script collects operating system, hardware, memory, processor, and last boot information.
It is designed for system administrators who need a quick inventory report.

.PARAMETER ComputerName
The name of the computer to query. Defaults to the local computer.

.PARAMETER OutputPath
Optional CSV export path.

.EXAMPLE
.\Get-SystemInfo.ps1

.EXAMPLE
.\Get-SystemInfo.ps1 -ComputerName SERVER01 -OutputPath .\reports\system-info.csv
#>

param(
    [string]$ComputerName = $env:COMPUTERNAME,

    [string]$OutputPath
)

try {
    Write-Host "Collecting system information from $ComputerName..." -ForegroundColor Cyan

    $OperatingSystem = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $ComputerName
    $ComputerSystem  = Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName
    $Processor       = Get-CimInstance -ClassName Win32_Processor -ComputerName $ComputerName | Select-Object -First 1

    $SystemInfo = [PSCustomObject]@{
        ComputerName = $ComputerName
        Manufacturer = $ComputerSystem.Manufacturer
        Model = $ComputerSystem.Model
        OperatingSystem = $OperatingSystem.Caption
        OSVersion = $OperatingSystem.Version
        Processor = $Processor.Name
        MemoryGB = [math]::Round($ComputerSystem.TotalPhysicalMemory / 1GB, 2)
        LastBootTime = $OperatingSystem.LastBootUpTime
    }

    $SystemInfo

    if ($OutputPath) {
        $Folder = Split-Path $OutputPath -Parent

        if ($Folder -and -not (Test-Path $Folder)) {
            New-Item -ItemType Directory -Path $Folder -Force | Out-Null
        }

        $SystemInfo | Export-Csv -Path $OutputPath -NoTypeInformation
        Write-Host "Report exported to $OutputPath" -ForegroundColor Green
    }
}
catch {
    Write-Error "Failed to collect system information from $ComputerName. Error: $($_.Exception.Message)"
}
