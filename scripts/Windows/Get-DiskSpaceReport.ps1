<#
.SYNOPSIS
Generates a disk space report for one or more Windows computers.

.DESCRIPTION
Collects drive size, free space, and free percentage using CIM.
Exports results to CSV if an output path is provided.

.PARAMETER ComputerName
One or more computer names to query. Defaults to the local computer.

.PARAMETER OutputPath
Optional CSV output path.

.EXAMPLE
.\Get-DiskSpaceReport.ps1

.EXAMPLE
.\Get-DiskSpaceReport.ps1 -ComputerName SERVER01,SERVER02 -OutputPath .\reports\DiskReport.csv
#>

param(
    [string[]]$ComputerName = $env:COMPUTERNAME,
    [string]$OutputPath
)

$Results = foreach ($Computer in $ComputerName) {
    try {
        $Disks = Get-CimInstance Win32_LogicalDisk -ComputerName $Computer -Filter "DriveType=3"

        foreach ($Disk in $Disks) {
            [PSCustomObject]@{
                ComputerName = $Computer
                Drive        = $Disk.DeviceID
                SizeGB       = [math]::Round($Disk.Size / 1GB,2)
                FreeGB       = [math]::Round($Disk.FreeSpace / 1GB,2)
                FreePercent  = [math]::Round(($Disk.FreeSpace / $Disk.Size) * 100,2)
            }
        }
    }
    catch {
        Write-Warning "Unable to query $Computer"
    }
}

$Results

if ($OutputPath) {

    $Folder = Split-Path $OutputPath -Parent

    if ($Folder -and !(Test-Path $Folder)) {
        New-Item -ItemType Directory -Path $Folder | Out-Null
    }

    $Results | Export-Csv $OutputPath -NoTypeInformation

    Write-Host "Report exported to $OutputPath" -ForegroundColor Green
}
