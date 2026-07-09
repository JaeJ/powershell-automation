<#
.SYNOPSIS
Displays basic system health information.
#>

Write-Host "System Health Report" -ForegroundColor Cyan

Get-ComputerInfo |
Select-Object WindowsProductName,
WindowsVersion,
CsSystemType,
CsTotalPhysicalMemory

Get-Process |
Sort-Object CPU -Descending |
Select-Object -First 5 Name, CPU

Write-Host "Health report completed." -ForegroundColor Green
