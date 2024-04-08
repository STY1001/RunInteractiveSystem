# RunInteractiveSystem by STY1001
# Version: 1.0
# Description: A module that allows you to run interactive app from the system user using task scheduler.

function Start-RunInteractiveSystem {
    <#
    .SYNOPSIS
    A useful module to run interactive software from the system user.

    .DESCRIPTION
    A module that allows you to run interactive app from the system user using task scheduler.
    To run this script, you need a logged-in user.
    The current logged-in user needs to be in the local group that you select otherwise you can select Current.
    Run with the highest privilege needs the user to be in the local admin group.

    .PARAMETER FilePath
    The path of the file to run.

    .PARAMETER Arguments
    Optional argument for the file.

    .PARAMETER RunAs
    Run the task as a specific local group or current user.
    Default is Current.
    Available options are Users, Admins, Current.
    Current will use the current logged-in user (doesn't work if the user is logged-in with RDP).

    .PARAMETER HighestPrivilege
    Run the task with the highest privilege.

    .EXAMPLE
    Start-RunInteractiveSystem -FilePath "C:\Windows\System32\cmd.exe" -HighestPrivilege

    Description:
    Run cmd.exe with the highest privilege of the current user.

    .EXAMPLE
    Start-RunInteractiveSystem -FilePath "C:\Windows\System32\cmd.exe" -Arguments "/c echo Hello World" 

    Description:
    Run cmd.exe with the lowest privilege of the current user and run echo Hello World.

    .EXAMPLE
    Start-RunInteractiveSystem -FilePath "C:\Windows\System32\cmd.exe" -RunAs "Admins"

    Description:
    Run cmd.exe with the lowest privilege of the local admins group (current user must be in the local admins group).
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath,

        [Parameter()]
        [string]$Arguments,

        [ValidateSet("Users", "Admins", "Current")]
        [string]$RunAs = "Current",

        [Parameter()]
        [switch]$HighestPrivilege = $false
    )

    if (!$FilePath) {
        break
    }

    if ($Arguments) {
        $TaskRun = $FilePath + " " + $Arguments
    }
    else {
        $TaskRun = $FilePath
    }

    if ($RunAs -eq "Current") {
        $RunAsName = (Get-WMIObject -class Win32_ComputerSystem | Select-Object username)
    }
    elseif ($RunAs -eq "Users") {
        $RunAsName = "BUILTIN\" + (Get-CimInstance -ClassName win32_group -filter "LocalAccount = $TRUE And SID = 'S-1-5-32-545'" | Select-Object -expand name)
    }
    elseif ($RunAs -eq "Admins") {
        $RunAsName = "BUILTIN\" + (Get-CimInstance -ClassName win32_group -filter "LocalAccount = $TRUE And SID = 'S-1-5-32-544'" | Select-Object -expand name)
    }

    if ($RunAsName -eq "" -or $null -eq $RunAsName) {
        break
    }

    if ($HighestPrivilege) {
        $PrivilegeLevel = "HIGHEST"
    }
    else {
        $PrivilegeLevel = "LIMITED"
    }

    try {
        schtasks /CREATE /SC MONTHLY /TN "RunSystemBypass" /TR "$TaskRun" /F /IT /RL $PrivilegeLevel /RU "$RunAsName"
        schtasks /RUN /TN "RunSystemBypass"
        schtasks /DELETE /TN "RunSystemBypass" /F
    }
    catch {
        Write-Error "Error: $_"
    }
}

Export-ModuleMember -Function Start-RunInteractiveSystem
