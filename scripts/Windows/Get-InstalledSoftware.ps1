<#
.SYNOPSIS
Retrieves installed software from a Windows computer.

.DESCRIPTION
Collects installed software information from the Windows registry.
Supports optional filtering by software name and CSV export.

.PARAMETER ComputerName
The computer to query. Defaults to the local computer.

.PARAMETER NameFilter
Optional software name filter.

.PARAMETER OutputPath
Optional CSV export path.

.EXAMPLE
.\Get-InstalledSoftware.ps1

.EXAMPLE
.\Get-InstalledSoftware.ps1 -NameFilter "Microsoft"

.EXAMPLE
.\Get-InstalledSoftware.ps1 -ComputerName SERVER01 -OutputPath .\reports\InstalledSoftware.csv
#>

param(
    [string]$ComputerName = $env:COMPUTERNAME,
    [string]$NameFilter,
    [string]$OutputPath
)

try {
    $RegistryPaths = @(
        "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )

    $Results = foreach ($Path in $RegistryPaths) {
        Get-CimInstance -ClassName StdRegProv -ComputerName $ComputerName -Namespace root/default | Out-Null

        $BasePath = "HKLM:\$Path"

        if ($ComputerName -eq $env:COMPUTERNAME) {
            Get-ItemProperty $BasePath -ErrorAction SilentlyContinue |
                Where-Object { $_.DisplayName } |
                Select-Object @{
                    Name="ComputerName";Expression={$ComputerName}
                }, DisplayName, DisplayVersion, Publisher, InstallDate
        }
    }

    if ($NameFilter) {
        $Results = $Results | Where-Object { $_.DisplayName -like "*$NameFilter*" }
    }

    $Results

    if ($OutputPath) {
        $Folder = Split-Path $OutputPath -Parent

        if ($Folder -and !(Test-Path $Folder)) {
            New-Item -ItemType Directory -Path $Folder -Force | Out-Null
        }

        $Results | Export-Csv -Path $OutputPath -NoTypeInformation
    }
}
catch {
    Write-Warning "Unable to retrieve installed software from $ComputerName. $($_.Exception.Message)"
}
