<#
.SYNOPSIS
Retrieves Windows Update status information from the local computer.

.DESCRIPTION
Collects the current Windows Update service status and reports on the
most recently installed Windows update.

.PARAMETER OutputPath
Optional path to export results as CSV.

.EXAMPLE
.\Get-WindowsUpdateStatus.ps1

.EXAMPLE
.\Get-WindowsUpdateStatus.ps1 -OutputPath .\reports\WindowsUpdateStatus.csv
#>

[CmdletBinding()]
param(
    [string]$OutputPath
)

try {

    Write-Verbose "Checking Windows Update service..."

    $Service = Get-Service -Name wuauserv -ErrorAction Stop

    Write-Verbose "Retrieving installed updates..."

    $LastUpdate = Get-HotFix |
        Sort-Object InstalledOn -Descending |
        Select-Object -First 1

    $Result = [PSCustomObject]@{

        ComputerName      = $env:COMPUTERNAME
        WindowsUpdateSvc  = $Service.Status
        LastKB            = $LastUpdate.HotFixID
        InstalledOn       = $LastUpdate.InstalledOn
        InstalledBy       = $LastUpdate.InstalledBy

    }

    $Result

    if ($OutputPath) {

        $Folder = Split-Path $OutputPath -Parent

        if ($Folder -and !(Test-Path $Folder)) {

            New-Item -ItemType Directory -Path $Folder -Force | Out-Null

        }

        $Result |
            Export-Csv $OutputPath -NoTypeInformation

        Write-Verbose "Report exported."

    }

}
catch {

    Write-Error $_

}
