#Requires -RunAsAdministrator

[cmdletbinding()]
param(    
)

$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
$registryName = "DisableCloudOptimizedContent"
$registryValue = 1

Write-Verbose -Message "Getting Operating System"

$os = Get-ComputerInfo -Verbose | Select-Object OsName
if ($os -match "Microsoft Windows 11") {

    Write-Verbose "Confirmed Windows 11"
}
else {

    Write-Error -Message "This is will not work on your version of Windows" -Category InvalidOperation
    exit (1)
}

if(-not (Test-Path $registryPath)) {    

    Write-Verbose "Creating registry path"
    New-Item -Path $registryPath -Force -Confirm:$false -Verbose
    Write-Verbose "Registry path created"
}

try {
    Write-Verbose "Setting registry value"
    Set-ItemProperty -Path $registryPath -Name $registryName -Value $registryValue -ErrorAction Stop
    Write-Verbose "Registry value set"
}
catch {
    Write-Error -Message "Error" -Category InvalidOperation
    exit (1)
}

gpupdate /force