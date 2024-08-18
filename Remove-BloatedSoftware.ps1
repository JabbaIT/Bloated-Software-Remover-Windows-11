#Requires -RunAsAdministrator

<#
    .SYNOPSIS
    This script will remove bloated software from Windows 11

    .DESCRIPTION
    This script will remove bloated software from Windows 11

    .PARAMETER None

    .EXAMPLE
        Remove-BloatedSoftware.ps1

#>

[cmdletbinding()]
param()

$AllowList = @(
    '*WindowsCalculator*',
    '*Office.OneNote*',
    '*Microsoft.net*',
    '*MicrosoftEdge*',
    '*WindowsStore*',
    '*WindowsTerminal*',
    '*WindowsNotepad*',
    '*Paint*'
)


Get-AppxPackage | ForEach-Object {
    if ($AllowList -notcontains $_.Name) {
        Write-Verbose -Message "Removing $($_.Name)"
        ##Remove-AppxPackage -Package $_.PackageFullName -ErrorAction SilentlyContinue
    }
    else {
        Write-Host "$($_.Name) is in the allow list"
    }
}
