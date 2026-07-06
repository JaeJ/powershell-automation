# Troubleshooting Notes

## Purpose

This document tracks common issues, fixes, and lessons learned while building and testing the PowerShell Automation toolkit.

## Common Issues

### PowerShell Execution Policy

Issue:

Scripts may not run if execution policy blocks them.

Fix: 

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

