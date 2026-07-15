<#
.SYNOPSIS
Retrieves members of the local Administrators group.

.DESCRIPTION
Collects members of the local Administrators group from one or more
Windows computers.

The script identifies the member name, object class, principal source,
and whether the account appears to be local or domain-based.

.PARAMETER ComputerName
One or more computer names to query. Defaults to the local computer.

.PARAMETER OutputPath
Optional CSV export path.

.EXAMPLE
.\Get-LocalAdministrators.ps1

.EXAMPLE
.\Get-LocalAdministrators.ps1 -ComputerName SERVER01,SERVER02

.EXAMPLE
.\Get-LocalAdministrators.ps1 `
    -OutputPath .\reports\LocalAdministrators.csv
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
        Write-Verbose "Retrieving local Administrators group members from $Computer."

        if ($Computer -eq $env:COMPUTERNAME -or $Computer -eq "localhost") {
            $Members = Get-LocalGroupMember `
                -Group "Administrators" `
                -ErrorAction Stop
        }
        else {
            $Members = Invoke-Command `
                -ComputerName $Computer `
                -ScriptBlock {
                    Get-LocalGroupMember `
                        -Group "Administrators" `
                        -ErrorAction Stop
                } `
                -ErrorAction Stop
        }

        foreach ($Member in $Members) {
            $AccountType = if ($Member.Name -like "$Computer\*") {
                "Local"
            }
            elseif ($Member.Name -like "*\*") {
                "Domain or Directory"
            }
            else {
                "Unknown"
            }

            [PSCustomObject]@{
                ComputerName    = $Computer
                Name            = $Member.Name
                ObjectClass     = $Member.ObjectClass
                PrincipalSource = $Member.PrincipalSource
                AccountType     = $AccountType
                ReportCreated   = Get-Date
            }
        }
    }
    catch {
        Write-Warning "Unable to retrieve local administrators from $Computer. $($_.Exception.Message)"
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

    Write-Verbose "Local administrators report exported to $OutputPath."
}

$Results
