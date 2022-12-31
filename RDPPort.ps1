<#
  .SYNOPSIS
    RDPPort.ps1 [PortNumber]
      '': Get current RDP port
      number: Set RDP port. 1-65535.
  .DESCRIPTION
    Get/Set RDP port
    Requires admin privilege
  .PARAMETER PortNumber
    '': Get current RDP port
    number: Set RDP port. 1-65535.
#>

#Requires -RunAsAdministrator

Param(
  [ValidateScript({ !$_ -or 0 -lt $_ -and $_ -lt 65536 })][string]$PortNumber
)
$path = 'HKLM:/SYSTEM/CurrentControlSet/Control/Terminal Server/WinStations/RDP-Tcp'
$key = 'PortNumber'
if ($PortNumber) {
  Set-ItemProperty $path -name $key -value ([int32]$PortNumber)
}
(Get-ItemProperty $path).$key
