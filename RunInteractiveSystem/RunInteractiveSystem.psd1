@{
    ModuleName = 'RunInteractiveSystem'
    ModuleVersion = '1.0'
    Author = 'STY1001'
    CompanyName = 'STY Inc.'
    Copyright = 'Copyright © 2024 STY Inc. (STY1001)'
    GUID = 'd9001879-abde-40d7-941f-14d3cc33bd0e'
    Description = 'A module that allows you to run interactive apps from the system user using task scheduler.'
    FunctionsToExport = @(
        'Start-RunInteractiveSystem'
    )
    PrivateData = @{
        PSData = @{
            Tags = @()
            LicenseUri = 'https://github.com/STY1001/RunInteractiveSystem/blob/main/LICENCE'
            ProjectUri = 'https://github.com/STY1001/RunInteractiveSystem'
            ReleaseNotes = '
            - 1.0:
                - Initial release of RunInteractiveSystem module.'
        }
    }
}
