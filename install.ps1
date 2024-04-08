if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run this script as admin."
    Exit
}
$zipurl = 'https://github.com/STY1001/RunInteractiveSystem/releases/latest/download/RunInteractiveSystem.zip'
Invoke-WebRequest -Uri $zipurl -OutFile "$env:TEMP\RunInteractiveSystem.zip"
$modulepath = "$env:ProgramFiles\WindowsPowerShell\Modules\RunInteractiveSystem"
if (Test-Path $modulepath) {
    Remove-Item -Path $modulepath -Recurse -Force
}
Expand-Archive -Path "$env:TEMP\RunInteractiveSystem.zip" -DestinationPath $modulepath
Remove-Item -Path "$env:TEMP\RunInteractiveSystem.zip" -Force
Import-Module RunInteractiveSystem
Write-Host "RunInteractiveSystem has been installed."