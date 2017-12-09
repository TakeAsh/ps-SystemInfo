# Get/Set NTP Server
# - This script require the administrator privilege.
# - [setting NTP server on Windows machine using PowerShell - Stack Overflow](https://stackoverflow.com/questions/17507339/)
# - If you want to delete a server from the server list, enter the command like below.
#   > Remove-ItemProperty -LiteralPath $ntpServersPath -Name "3"

$ntpServersPath = "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/DateTime/Servers"
$w32timeParametersPath = "HKLM:/SYSTEM/CurrentControlSet/services/W32Time/Parameters"
$w32timeNtpClientPath = "HKLM:/SYSTEM/CurrentControlSet/services/W32Time/TimeProviders/NtpClient"
$hourToSec = 60.0 * 60
$servers = Get-Item -LiteralPath $ntpServersPath

function Get-ServerIndexes() {
  $index = 0
  $servers.GetValueNames() |
    ? {$_ -ne ""} |
    % {$(if ([int]::TryParse($_, [ref]$index)) {$index} else {0})} |
    Sort-Object
}

function Show-Servers() {
  $selected = $servers.GetValue("")
  Get-ServerIndexes |
    % {$(if ($_ -eq $selected) {"*"} else {" "}) + $_ + ": " + $servers.GetValue($_)}
}

function Show-Interval() {
  $value = (Get-ItemProperty -LiteralPath $w32timeNtpClientPath).SpecialPollInterval / $hourToSec
  Write-Output "Interval (hours): ${value}" 
}

Show-Servers
Show-Interval
$in1 = Read-Host "Select index, or enter new NTP server host"
if ($in1 -eq "") {
  Write-Host "Canceled."
  Exit
}
$maxIndex = @(Get-ServerIndexes)[-1]
$serverIndex = 0
if (
  -not [int]::TryParse($in1, [ref]$serverIndex) -or
  $serverIndex -lt 0 -or
  $serverIndex -gt $maxIndex
) {
  $serverIndex = $maxIndex + 1
  New-ItemProperty -LiteralPath $ntpServersPath -Name $serverIndex -Value $in1 | Out-Null
}
Set-ItemProperty -LiteralPath $ntpServersPath -Name "(Default)" -Value $serverIndex
Set-ItemProperty -LiteralPath $w32timeParametersPath -Name "NtpServer" -Value $servers.GetValue($serverIndex)
Show-Servers
Stop-Service w32time
Start-Service w32time

Show-Interval
$in2 = Read-Host "Enter Interval (hours)"
$interval = 0
if (
  -not [double]::TryParse($in2, [ref]$interval) -or
  $interval -le 0
) {
  Write-Host "Canceled."
  Exit
}
Set-ItemProperty -LiteralPath $w32timeNtpClientPath -Name "SpecialPollInterval" -Value ($interval * $hourToSec)
Show-Interval
Stop-Service w32time
Start-Service w32time
