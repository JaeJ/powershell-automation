<#
.SYNOPSIS
Retrieves system uptime information from one or more Windows computers.

.DESCRIPTION
Queries Windows operating system information and calculates the amount
of time elapsed since each computer last started.

The script returns structured PowerShell objects and can optionally
export the results to a CSV file.

.PARAMETER ComputerName
One or more computer names to query. Defaults to the local computer.

.PARAMETER OutputPath
Optional CSV export path.

.EXAMPLE
.\Get-SystemUptime.ps1

.EXAMPLE
.\Get-SystemUptime.ps1 -ComputerName SERVER01,SERVER02

.EXAMPLE
.\Get-SystemUptime.ps1 `
    -ComputerName SERVER01 `
    -OutputPath .\reports\SystemUptime.csv
#>

[CmdletBinding()]
param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string[]]$ComputerName = $env:COMPUTERNAME,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$OutputPath
)

$Results = foreach ($Computer in $ComputerName) {
    try {
        Write-Verbose "Retrieving uptime information from $Computer."

        $OperatingSystem = Get-CimInstance `
            -ClassName Win32_OperatingSystem `
            -ComputerName $Computer `
            -ErrorAction Stop

        $LastBootTime = $OperatingSystem.LastBootUpTime
        $CurrentTime  = Get-Date
        $Uptime       = $CurrentTime - $LastBootTime

        [PSCustomObject]@{
            ComputerName  = $Computer
            LastBootTime  = $LastBootTime
            UptimeDays    = $Uptime.Days
            UptimeHours   = $Uptime.Hours
            UptimeMinutes = $Uptime.Minutes
            TotalHours    = [math]::Round($Uptime.TotalHours, 2)
            ReportCreated = $CurrentTime
        }
    }
    catch {
        Write-Warning "Unable to retrieve uptime information from $Computer. $($_.Exception.Message)"
    }
}

if ($OutputPath) {
    $ParentFolder = Split-Path -Path $OutputPath -Parent

    if ($ParentFolder -and -not (Test-Path -Path $ParentFolder)) {
        New-Item -ItemType Directory -Path $ParentFolder -Force |
            Out-Null
    }

    $Results |
        Export-Csv `
            -Path $OutputPath `
            -NoTypeInformation `
            -Encoding UTF8

    Write-Verbose "Uptime report exported to $OutputPath."
}

$Results
