<#
.SYNOPSIS
Safely restarts a Windows service.
#>

$ServiceName = "Spooler"

Write-Host "Restarting service: $ServiceName" -ForegroundColor Yellow

Restart-Service -Name $ServiceName -Force

Write-Host "Service restarted successfully." -ForegroundColor Green
