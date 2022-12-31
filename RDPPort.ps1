<#
  .SYNOPSIS
    RDPPort.ps1 [PortNumber]
      '': Get current RDP port
      number: Set RDP port. 1-65535.
      ?|h|help: Show help
  .DESCRIPTION
    Get/Set RDP port
    Requires admin privilege
  .PARAMETER PortNumber
    '': Get current RDP port
    number: Set RDP port. 1-65535.
    ?|h|help: Show help
#>

#Requires -RunAsAdministrator

Param(
  [ValidateScript({ (!$_) 
      -or (@('?', 'h', 'help').Contains($_)) 
      -or (0 -lt $_ -and $_ -lt 65536) })]
  [string]$PortNumber
)
if (@('?', 'h', 'help').Contains($PortNumber)) {
  Get-Help $PSCommandPath
  Exit
}
$path = 'HKLM:/SYSTEM/CurrentControlSet/Control/Terminal Server/WinStations/RDP-Tcp'
$key = 'PortNumber'
if ($PortNumber) {
  Set-ItemProperty $path -name $key -value ([int32]$PortNumber)
}
(Get-ItemProperty $path).$key
