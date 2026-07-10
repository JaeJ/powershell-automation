<#
.SYNOPSIS
Retrieves recent critical and error events from Windows event logs.

.DESCRIPTION
Queries one or more Windows event logs for Critical and Error events
within a specified number of days.

The script returns structured PowerShell objects and can optionally
export the results to a CSV file.

.PARAMETER ComputerName
The computer to query. Defaults to the local computer.

.PARAMETER LogName
One or more Windows event logs to query.
Defaults to System and Application.

.PARAMETER Days
The number of previous days to search.
Defaults to 7.

.PARAMETER MaxEvents
The maximum number of events to return from each log.
Defaults to 100.

.PARAMETER OutputPath
Optional CSV export path.

.EXAMPLE
.\Get-EventLogErrors.ps1

Retrieves Critical and Error events from the System and Application
logs for the previous seven days.

.EXAMPLE
.\Get-EventLogErrors.ps1 -Days 2 -MaxEvents 50

Retrieves up to 50 events per log from the previous two days.

.EXAMPLE
.\Get-EventLogErrors.ps1 `
    -ComputerName SERVER01 `
    -LogName System `
    -OutputPath .\reports\EventLogErrors.csv

Queries the System log on SERVER01 and exports the results to CSV.

.NOTES
Remote event log access may require administrative permissions,
firewall configuration, and access to the Remote Event Log Management
service rules.
#>

[CmdletBinding()]
param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$ComputerName = $env:COMPUTERNAME,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string[]]$LogName = @("System", "Application"),

    [Parameter()]
    [ValidateRange(1, 365)]
    [int]$Days = 7,

    [Parameter()]
    [ValidateRange(1, 5000)]
    [int]$MaxEvents = 100,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$OutputPath
)

$StartTime = (Get-Date).AddDays(-$Days)

$Results = foreach ($Log in $LogName) {
    try {
        Write-Verbose "Querying the $Log log on $ComputerName."

        $Filter = @{
            LogName   = $Log
            Level     = 1, 2
            StartTime = $StartTime
        }

        $Events = Get-WinEvent `
            -ComputerName $ComputerName `
            -FilterHashtable $Filter `
            -MaxEvents $MaxEvents `
            -ErrorAction Stop

        foreach ($Event in $Events) {
            [PSCustomObject]@{
                ComputerName = $ComputerName
                LogName      = $Event.LogName
                TimeCreated  = $Event.TimeCreated
                Level        = $Event.LevelDisplayName
                EventID      = $Event.Id
                Provider     = $Event.ProviderName
                Message      = $Event.Message
            }
        }
    }
    catch {
        Write-Warning "Unable to query the $Log log on $ComputerName. $($_.Exception.Message)"
    }
}

$Results = $Results | Sort-Object -Property TimeCreated -Descending

if ($OutputPath) {
    $ParentFolder = Split-Path -Path $OutputPath -Parent

    if ($ParentFolder -and -not (Test-Path -Path $ParentFolder)) {
        New-Item `
            -ItemType Directory `
            -Path $ParentFolder `
            -Force |
            Out-Null
    }

    $Results |
        Export-Csv `
            -Path $OutputPath `
            -NoTypeInformation `
            -Encoding UTF8

    Write-Verbose "Event log report exported to $OutputPath."
}

$Results
