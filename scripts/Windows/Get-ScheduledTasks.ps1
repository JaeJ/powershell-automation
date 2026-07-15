<#
.SYNOPSIS
Retrieves scheduled task information from a Windows computer.

.DESCRIPTION
Collects scheduled task names, paths, states, authors, last run times,
next run times, and result codes.

The script supports filtering and optional CSV export.

.PARAMETER ComputerName
The computer to query. Defaults to the local computer.

.PARAMETER State
Filters tasks by state. Valid values are All, Ready, Running,
Disabled, and Queued.

.PARAMETER ExcludeMicrosoft
Excludes tasks stored beneath the Microsoft task folder.

.PARAMETER OutputPath
Optional CSV export path.

.EXAMPLE
.\Get-ScheduledTasks.ps1

.EXAMPLE
.\Get-ScheduledTasks.ps1 -State Ready -ExcludeMicrosoft

.EXAMPLE
.\Get-ScheduledTasks.ps1 `
    -OutputPath .\reports\ScheduledTasks.csv
#>

[CmdletBinding()]
param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$ComputerName = $env:COMPUTERNAME,

    [Parameter()]
    [ValidateSet("All", "Ready", "Running", "Disabled", "Queued")]
    [string]$State = "All",

    [Parameter()]
    [switch]$ExcludeMicrosoft,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$OutputPath
)

try {
    Write-Verbose "Retrieving scheduled tasks from $ComputerName."

    $Session = $null

    if ($ComputerName -eq $env:COMPUTERNAME -or $ComputerName -eq "localhost") {
        $Tasks = Get-ScheduledTask -ErrorAction Stop
    }
    else {
        $Session = New-CimSession `
            -ComputerName $ComputerName `
            -ErrorAction Stop

        $Tasks = Get-ScheduledTask `
            -CimSession $Session `
            -ErrorAction Stop
    }

    if ($State -ne "All") {
        $Tasks = $Tasks |
            Where-Object State -eq $State
    }

    if ($ExcludeMicrosoft) {
        $Tasks = $Tasks |
            Where-Object TaskPath -notlike "\Microsoft\*"
    }

    $Results = foreach ($Task in $Tasks) {
        try {
            if ($Session) {
                $TaskInfo = Get-ScheduledTaskInfo `
                    -InputObject $Task `
                    -CimSession $Session `
                    -ErrorAction Stop
            }
            else {
                $TaskInfo = Get-ScheduledTaskInfo `
                    -InputObject $Task `
                    -ErrorAction Stop
            }

            [PSCustomObject]@{
                ComputerName = $ComputerName
                TaskName     = $Task.TaskName
                TaskPath     = $Task.TaskPath
                State        = $Task.State
                Author       = $Task.Author
                LastRunTime  = $TaskInfo.LastRunTime
                NextRunTime  = $TaskInfo.NextRunTime
                LastResult   = $TaskInfo.LastTaskResult
            }
        }
        catch {
            Write-Warning "Unable to retrieve details for task $($Task.TaskName)."
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
    }

    $Results
}
catch {
    Write-Error "Unable to retrieve scheduled tasks from $ComputerName. $($_.Exception.Message)"
}
finally {
    if ($Session) {
        Remove-CimSession -CimSession $Session
    }
}
