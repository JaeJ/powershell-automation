# PowerShell Automation

## Overview

This repository contains PowerShell automation scripts designed for Windows administration, system maintenance, troubleshooting, reporting, and infrastructure support.

The goal of this project is to build practical automation solutions that reduce manual administrative effort, improve operational consistency, and demonstrate real-world systems administration skills.

---

## Business Problem

Systems administrators often spend significant time performing repetitive tasks such as gathering system information, reviewing disk utilization, restarting services, and troubleshooting workstation or server issues.

Automation improves operational efficiency by reducing manual work, increasing consistency, and providing reusable solutions that can be applied across multiple environments.

This repository demonstrates practical PowerShell automation techniques commonly used in enterprise IT operations.

---

## Objectives

- Improve PowerShell scripting skills
- Automate repetitive administration tasks
- Build reusable infrastructure tools
- Practice troubleshooting automation
- Develop operational reporting solutions
- Maintain professional documentation standards

---

## Skills Demonstrated

### Windows Administration

- Windows Services
- Disk Management
- Event Logs
- System Information
- System Health Reporting

### PowerShell Automation

- Functions
- Reporting
- Automation
- Error Handling
- Script Documentation

### Infrastructure Support

- Troubleshooting
- Diagnostics
- Operational Support
- Process Improvement

---

## Repository Structure

```text
powershell-automation/
│
├── .github/
│   └── workflows/
│       └── powershell-validation.yml
│
├── docs/
│   ├── architecture.md
│   ├── project-roadmap.md
│   └── troubleshooting-notes.md
│
├── examples/
│   └── sample-output.md
│
├── images/
│   └── README.md
│
├── scripts/
│   ├── Utilities/
│   │   ├── Check-DiskSpace.ps1
│   │   ├── Get-SystemHealth.ps1
│   │   └── Restart-ServiceSafe.ps1
│   │
│   └── Windows/
│       ├── Get-DiskSpaceReport.ps1
│       ├── Get-EventLogErrors.ps1
│       ├── Get-InstalledSoftware.ps1
│       ├── Get-LocalAdministrators.ps1
│       ├── Get-RunningServices.ps1
│       ├── Get-ScheduledTasks.ps1
│       ├── Get-SystemInfo.ps1
│       ├── Get-SystemUptime.ps1
│       └── Get-WindowsUpdateStatus.ps1
│
├── tests/
│   ├── README.md
│   ├── Get-SystemInfo.Tests.ps1
│   ├── Get-DiskSpaceReport.Tests.ps1
│   └── Get-EventLogErrors.Tests.ps1
│
├── CHANGELOG.md
├── LICENSE
├── README.md
└── .gitignore
```

## Documentation

Additional project documentation is provided in the `/docs` folder.

Available documentation includes:

- Architecture Overview
- Project Roadmap
- Troubleshooting Notes

Examples and sample output can be found in:

- `/examples/sample-output.md`
---

## Current Scripts

| Script | Description |
|----------|-------------|
| Check-DiskSpace.ps1 | Displays available disk space |
| Get-SystemHealth.ps1 | Generates a basic system health report |
| Restart-ServiceSafe.ps1 | Safely restarts Windows services |
| Cleanup-TempFiles.ps1 | Removes temporary files |

---

## Example Output

### Disk Space Report

```text
Drive  FreeSpaceGB
-----  -----------
C:     125
D:      88
```

### System Health Summary

```text
Computer Name: WORKSTATION01
CPU Usage: 18%
Memory Usage: 42%
Status: Healthy
```

---

## Technologies Used

- PowerShell
- Windows 10
- Windows 11
- Windows Server
- Git
- GitHub

---

## Future Improvements

Planned enhancements include:

- Advanced reporting
- HTML dashboards
- Email notifications
- Logging framework
- Scheduled automation
- Configuration files
- Pester testing
- GitHub Actions automation

---

## Recruiter Summary

This repository demonstrates practical Windows administration and PowerShell automation skills used in enterprise IT environments.

The scripts focus on operational support, troubleshooting, reporting, and administrative automation that align with responsibilities commonly found in Systems Administration, Infrastructure Engineering, Technical Operations, and Cloud Operations roles.

---

## Author

**Jae McNeal**

Senior Systems Administrator

PowerShell • Azure • Microsoft 365 • Active Directory • Infrastructure Automation • Windows Server
