# Scripts

This folder contains PowerShell scripts organized by administrative purpose.

## Windows

The `Windows` folder contains scripts for Windows inventory, monitoring, troubleshooting, and administration.

### Completed

- `Get-SystemInfo.ps1`
- `Get-DiskSpaceReport.ps1`
- `Get-RunningServices.ps1`
- `Get-InstalledSoftware.ps1`
- `Get-WindowsUpdateStatus.ps1`
- `Get-EventLogErrors.ps1`
- `Get-SystemUptime.ps1`
- `Get-LocalAdministrators.ps1`
- `Get-ScheduledTasks.ps1`

### Planned

- `Export-SystemHealthReport.ps1`

## Additional Scripts

The following earlier utility scripts remain in the root scripts folder and will be reviewed for possible consolidation:

- `Check-DiskSpace.ps1`
- `Get-SystemHealth.ps1`
- `Restart-ServiceSafe.ps1`

## Usage

Run scripts from the repository root:

```powershell
.\scripts\Windows\Get-SystemInfo.ps1
```

View full help:

```powershell
Get-Help .\scripts\Windows\Get-SystemInfo.ps1 -Full
```

Review and test all scripts before using them in a production environment.
