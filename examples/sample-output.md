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

