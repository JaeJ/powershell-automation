# Script Development Guide

## Purpose

This guide defines the standards used when creating PowerShell scripts for this repository.

## Script Standards

Each script should include:

- Clear purpose
- Comment-based help
- Parameters when useful
- Basic error handling
- Readable output
- Export option when appropriate

## Recommended Script Header

```powershell
<#
.SYNOPSIS
Short description of what the script does.

.DESCRIPTION
Longer explanation of the task being automated.

.PARAMETER OutputPath
Optional path for exported results.

.EXAMPLE
.\Script-Name.ps1 -OutputPath .\report.csv
#>
```

## Naming Standard

Use approved PowerShell verb-noun style when possible.

Examples:

```text
Get-DiskSpaceReport.ps1
Get-SystemInfo.ps1
Get-ServiceStatus.ps1
Export-InventoryReport.ps1
```

## Output Standard

Scripts should return structured objects when possible and export to CSV or HTML when useful.

## Notes

These scripts are designed for portfolio and lab use. Production use should include additional security review, logging, testing, and change management.
