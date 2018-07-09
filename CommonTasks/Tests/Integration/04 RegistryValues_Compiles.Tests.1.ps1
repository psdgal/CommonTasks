$configData = Import-LocalizedData -BaseDirectory $PSScriptRoot\Assets -FileName Config1.psd1 -SupportedCommand New-Object, ConvertTo-SecureString -ErrorAction Stop
$moduleName = $env:BHProjectName

Remove-Module -Name $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module -Name  $ENV:BHProjectName -ErrorAction Stop

Import-Module -Name Datum

Describe 'RegistryValues DSC Resource compiles' -Tags 'FunctionalQuality' {
    It 'RegistryValues Compiles' {
        configuration Config_RegistryValues {

            Import-DscResource -ModuleName CommonTasks
        
            node localhost_RegistryValues {
                RegistryValues registryValues {
                    Values = $ConfigurationData.RegistryValues.Values
                }
            }
        }
        
        { Config_RegistryValues -ConfigurationData $configData -OutputPath $env:BHBuildOutput\ -ErrorAction Stop } | Should -Not -Throw
    }
}