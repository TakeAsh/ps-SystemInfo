<#
  .SYNOPSIS
    AdminSharePolicy.ps1 [''|0|1]
      '': Get current policy
       0: Set policy 'Disabled'
       1: Set policy 'Enabled'
  .DESCRIPTION
    Get/Set Administrative share policy
  .PARAMETER Value
    '': Get current policy
     0: Set policy 'Disabled'
     1: Set policy 'Enabled'
#>
#Requires -RunAsAdministrator
Param(
  [ValidateSet('', 0, 1)][string]$Value
)
$path = 'HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/Policies/System'
$key = 'LocalAccountTokenFilterPolicy'
if ($Value) {
  Set-ItemProperty $path -name $key -value ([int32]$Value)
}
if ((Get-ItemProperty $path).$key) { 'Enabled' } else { 'Disabled' } 
