# Sample Output

## System Information

```text
ComputerName : DESKTOP-12345
OS           : Microsoft Windows 11 Pro
Version      : 10.0.26100
MemoryGB     : 16
LastBoot     : 7/5/2026 7:30 AM
```

## Disk Space Report

```text
ComputerName Drive SizeGB FreeGB FreePercent
------------ ----- ------ ------ -----------
DESKTOP-12345 C:    476.00 82.50  17.33
```

## Service Status

```text
Name        DisplayName              Status
----        -----------              ------
Spooler     Print Spooler            Running
WinRM       Windows Remote Management Running
```

## Get-SystemInfo.ps1

```text
ComputerName    : DESKTOP-12345
Manufacturer    : Dell Inc.
Model           : Inspiron 14 7420 2-in-1
OperatingSystem : Microsoft Windows 11
OSVersion       : 10.0.26100
Processor       : 12th Gen Intel(R) Core(TM) i7-1255U
MemoryGB        : 16
LastBootTime    : 7/5/2026 7:30 AM
```

## Get-DiskSpaceReport.ps1

```text
ComputerName Drive SizeGB FreeGB FreePercent

SERVER01     C:    476.2  181.4  38.09

SERVER01     D:    931.5  410.6  44.08
```

## Get-RunningServices.ps1

```text
ComputerName ServiceName DisplayName Status StartType

SERVER01     WinRM       Windows Remote Management Running Automatic

SERVER01     Spooler     Print Spooler             Running Automatic

SERVER01     W32Time     Windows Time              Running Automatic
```

## Get-InstalledSoftware.ps1

```text
ComputerName DisplayName              DisplayVersion Publisher
------------ -----------              -------------- ---------
SERVER01     Microsoft Edge           126.0.2592.87  Microsoft Corporation
SERVER01     Microsoft 365 Apps       16.0.17726     Microsoft Corporation
SERVER01     Google Chrome            126.0.6478.127 Google LLC
```

## Get-WindowsUpdateStatus.ps1

```text
ComputerName     : SERVER01

WindowsUpdateSvc : Running

LastKB           : KB5062553

InstalledOn      : 7/8/2026

InstalledBy      : NT AUTHORITY\SYSTEM
```

## Get-EventLogErrors.ps1

### Command

```powershell
.\Get-EventLogErrors.ps1 -Days 3 -MaxEvents 10
```

### Example Output

```text
ComputerName : SERVER01
LogName      : System
TimeCreated  : 7/9/2026 6:42:15 PM
Level        : Error
EventID      : 7031
Provider     : Service Control Manager
Message      : The Example Service terminated unexpectedly.

ComputerName : SERVER01
LogName      : Application
TimeCreated  : 7/9/2026 5:18:31 PM
Level        : Critical
EventID      : 1000
Provider     : Application Error
Message      : Faulting application name: ExampleApp.exe
```

### CSV Export

```powershell
.\Get-EventLogErrors.ps1 `
    -Days 7 `
    -OutputPath .\reports\EventLogErrors.csv
```

---

## Get-SystemUptime.ps1

### Command

```powershell
.\Get-SystemUptime.ps1
```

### Example Output

```text
ComputerName  : SERVER01
LastBootTime  : 7/10/2026 6:32:11 AM
UptimeDays    : 4
UptimeHours   : 12
UptimeMinutes : 28
TotalHours    : 108.47
ReportCreated : 7/14/2026 7:00:24 PM
```

### CSV Export

```powershell
.\Get-SystemUptime.ps1 `
    -OutputPath .\reports\SystemUptime.csv
```

---
## Get-LocalAdministrators.ps1

### Command

```powershell
.\Get-LocalAdministrators.ps1
```

### Example Output

```text
ComputerName    : SERVER01
Name            : SERVER01\Administrator
ObjectClass     : User
PrincipalSource : Local
AccountType     : Local

ComputerName    : SERVER01
Name            : CONTOSO\Domain Admins
ObjectClass     : Group
PrincipalSource : ActiveDirectory
AccountType     : Domain or Directory
```

### CSV Export

```powershell
.\Get-LocalAdministrators.ps1 `
    -OutputPath .\reports\LocalAdministrators.csv
```

---

## Get-ScheduledTasks.ps1

### Command

```powershell
.\Get-ScheduledTasks.ps1 -ExcludeMicrosoft
```

### Example Output

```text
ComputerName : SERVER01
TaskName     : Daily Backup
TaskPath     : \
State        : Ready
Author       : CONTOSO\Administrator
LastRunTime  : 7/13/2026 11:00:00 PM
NextRunTime  : 7/14/2026 11:00:00 PM
LastResult   : 0

ComputerName : SERVER01
TaskName     : System Inventory
TaskPath     : \IT Operations\
State        : Ready
Author       : CONTOSO\ServiceAccount
LastRunTime  : 7/14/2026 6:00:00 AM
NextRunTime  : 7/15/2026 6:00:00 AM
LastResult   : 0
```

### Filter by State

```powershell
.\Get-ScheduledTasks.ps1 -State Running
```

### CSV Export

```powershell
.\Get-ScheduledTasks.ps1 `
    -ExcludeMicrosoft `
    -OutputPath .\reports\ScheduledTasks.csv
```
