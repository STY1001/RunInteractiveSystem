# RunInteractiveSystem
A useful Powershell module that allows you to run interactive app from the system user using task scheduler.

To run this script, you need a logged-in user.

The current logged-in user needs to be in the local group that you select otherwise you can select Current (don't work with RDP).

Run with the highest privilege needs the user to be in the local admin group.

## Install guide
### Auto install
1. Open Powershell **as Admin**
2. Type `irm https://raw.githubusercontent.com/STY1001/RunInteractiveSystem/main/install.ps1 | iex`
3. Done !

### Manual install
1. Download [RunInteractiveSystem.zip](https://github.com/STY1001/RunInteractiveSystem/releases/latest/download/RunInteractiveSystem.zip) (from releases)
2. Extract the zip file in `$env:userprofile\Documents\WindowsPowerShell\modules\RunInteractiveSystem` (you need to create the folder)
3. Done !

## Usage

`Start-RunInteractiveSystem [-FilePath] <String> [[-Arguments] <String>] [[-RunAs] <Users|Admins|Current>] [-HighestPrivilege]`

`-FilePath` : Path of the program you want to execute

`-Arguments` : Optionnal args for the program

`-RunAs` : Run the task as a specific local group or current user.
- `Users` to run as a member of the local users group
- `Admins` to run as a member of the local admins group
- `Current` to run as the current user, but doesn't work with RDP

`-HighestPrivilege` : Run the task with the highest privilege of the user.

## Example command

- Run cmd.exe with the highest privilege of the current user.
```powershell
Start-RunInteractiveSystem -FilePath 'C:\Windows\System32\cmd.exe' -HighestPrivilege
```

- Run cmd.exe with the lowest privilege of the current user and run echo Hello World.
```powershell
Start-RunInteractiveSystem -FilePath 'C:\Windows\System32\cmd.exe' -Arguments '/c echo Hello World' 
```

- Run cmd.exe with the lowest privilege of the local admins group (current user must be in the local admins group).
```powershell
Start-RunInteractiveSystem -FilePath 'C:\Windows\System32\cmd.exe' -RunAs 'Admins'
```