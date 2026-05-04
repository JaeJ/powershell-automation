# Troubleshooting Notes

## Common Issues

### PowerShell Execution Policy

```powershell
Set-ExecutionPolicy RemoteSigned
```

### Script Not Running

- Run PowerShell as Administrator
- Verify execution policy
- Check script path

### Service Restart Failures

- Confirm service exists
- Verify admin permissions
- Check event logs
