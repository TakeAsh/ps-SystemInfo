<#
  .SYNOPSIS
    AdminSharePolicy.ps1 [''|0|1|?|h|help]
      '': Get current policy
       0: Set policy 'Disabled'
       1: Set policy 'Enabled'
      ?|h|help: Show help
  .DESCRIPTION
    Get/Set administrative share policy
    Requires admin privilege
  .PARAMETER Value
    '': Get current policy
     0: Set policy 'Disabled'
     1: Set policy 'Enabled'
    ?|h|help: Show help
#>

#Requires -RunAsAdministrator

Param(
  [ValidateSet('', 0, 1, '?', 'h', 'help')][string]$Value
)
if (@('?', 'h', 'help' ).Contains($Value)) {
  Get-Help $PSCommandPath
  Exit
}
$path = 'HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/Policies/System'
$key = 'LocalAccountTokenFilterPolicy'
if ($Value) {
  Set-ItemProperty $path -name $key -value ([int32]$Value)
}
if ((Get-ItemProperty $path).$key) { 'Enabled' } else { 'Disabled' } 
