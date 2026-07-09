<#
.SYNOPSIS
Checks available disk space on local drives.
#>

Get-PSDrive -PSProvider FileSystem |
Select-Object Name,
@{Name="FreeSpaceGB";Expression={[math]::Round($_.Free / 1GB,2)}},
@{Name="UsedSpaceGB";Expression={[math]::Round(($_.Used / 1GB),2)}}

Write-Host "Disk space check completed." -ForegroundColor Green
