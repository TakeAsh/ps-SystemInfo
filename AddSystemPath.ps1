# add path items to system path, remove duplicated items
$addingPathItems = @(
  'C:\Program Files\7-Zip',
  'C:\Program Files\Git\usr\bin',
  'C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin', # nmake.exe
  'C:\tools\selenium'
)
$registryEnvironment = 'HKLM:/SYSTEM/CurrentControlSet/Control/Session Manager/Environment'

$identity = [Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
If (-not $identity.IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  Write-Warning "No administrator privilege."
  Break
}
$pathItems = @()
((Get-ItemProperty -LiteralPath $registryEnvironment).Path -split ";") + $addingPathItems |
  Where-Object {$pathItems -notcontains $_} |
  ForEach-Object {$pathItems += $_}
$pathItems | ForEach-Object {Write-Output $_}
Set-ItemProperty -LiteralPath $registryEnvironment -Name 'Path' –Value ($pathItems -join ";")
