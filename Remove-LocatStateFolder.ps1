#Requires -RunAsAdministrator

<#  
    .SYNOPSIS
    This script will remove the Local State Folder from Windows 11

    .DESCRIPTION
    This script will remove the Local State Folder from Windows 11

    .PARAMETER None

    .EXAMPLE
        Remove-LocatStateFolder.ps1

#>

[cmdletbinding()]
param()

# Variable to store the Local State Folder
$localStateFolder = "Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState"

Write-Verbose -Message "Getting AppData Local Folder Location"
$UserAppDataLocal = [System.Environment]::GetFolderPath('LocalApplicationData')

if(-not(Test-Path $UserAppDataLocal)) {
    Write-Error -Message "User AppData Local Path not found" -Category ObjectNotFound
    exit (1)
}

if(Test-Path -Path "$($UserAppDataLocal)\$($localStateFolder)") {
 
    Write-Verbose -Message "Removing Locate State Found $($UserAppDataLocal)"    
    try {
        
        Remove-Item -Path "$($UserAppDataLocal)\$($localStateFolder)" -Force -Recurse -Confirm:$false -ErrorAction Stop
        Write-Verbose -Message "Locate Folder State Removed"
    }
    catch {
        Write-Error -Message "Error" -Category InvalidOperation
        exit (1)
    }
}
else {

    Write-Warning -Message "Locate Folder State not found - $($UserAppDataLocal)\$($localStateFolder)"
    exit (1)
}

Read-Host -Prompt "Press Enter to exit"
Restart-Computer -Force