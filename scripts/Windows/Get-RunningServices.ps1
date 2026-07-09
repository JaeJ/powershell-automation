<#
.SYNOPSIS
Retrieves Windows services from one or more computers.

.DESCRIPTION
Queries Windows services and allows filtering by service status.
Results can optionally be exported to a CSV file.

.PARAMETER ComputerName
One or more computer names. Defaults to the local computer.

.PARAMETER Status
Filter services by status:
Running, Stopped, or All.

.PARAMETER OutputPath
Optional path to export the results as a CSV file.

.EXAMPLE
.\Get-RunningServices.ps1

.EXAMPLE
.\Get-RunningServices.ps1 -Status Stopped

.EXAMPLE
.\Get-RunningServices.ps1 -ComputerName SERVER01,SERVER02 -Status Running -OutputPath .\reports\Services.csv
#>

param(
    [string[]]$ComputerName = $env:COMPUTERNAME,

    [ValidateSet("Running","Stopped","All")]
    [string]$Status = "Running",

    [string]$OutputPath
)

$Results = foreach ($Computer in $ComputerName) {

    try {

        $Services = Get-Service -ComputerName $Computer

        switch ($Status) {

            "Running" {
                $Services = $Services | Where-Object Status -eq "Running"
            }

            "Stopped" {
                $Services = $Services | Where-Object Status -eq "Stopped"
            }

            "All" { }

        }

        foreach ($Service in $Services) {

            [PSCustomObject]@{
                ComputerName = $Computer
                ServiceName  = $Service.Name
                DisplayName  = $Service.DisplayName
                Status       = $Service.Status
                StartType    = $Service.StartType
            }

        }

    }

    catch {

        Write-Warning "Unable to retrieve services from $Computer"

    }

}

$Results

if ($OutputPath) {

    $Folder = Split-Path $OutputPath -Parent

    if ($Folder -and !(Test-Path $Folder)) {

        New-Item -ItemType Directory -Path $Folder -Force | Out-Null

    }

    $Results | Export-Csv $OutputPath -NoTypeInformation

    Write-Host "Report exported to $OutputPath" -ForegroundColor Green

}
