#Requires -RunAsAdministrator
[cmdletbinding()]
param()

$Packages = Get-AppxPackage

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
