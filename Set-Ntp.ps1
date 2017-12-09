# Get/Set NTP Server
# [setting NTP server on Windows machine using PowerShell - Stack Overflow](https://stackoverflow.com/questions/17507339/)
#
# If you want to delete a server from the server list, enter the command like below.
# > Remove-ItemProperty -LiteralPath $ntpServersPath -Name "3"

$ntpServersPath = "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/DateTime/Servers"
$w32timeParametersPath = "HKLM:/SYSTEM/CurrentControlSet/services/W32Time/Parameters"
$servers = Get-Item -LiteralPath $ntpServersPath

function Get-ServerIndexes() {
  $servers.GetValueNames() |
    ? {$_ -ne ""} |
    Sort-Object
}

function Show-Servers() {
  $selected = $servers.GetValue("")
  Get-ServerIndexes |
    % {$(if ($_ -eq $selected) {"*"} else {" "}) + $_ + ": " + $servers.GetValue($_)}
}

$serverIndexes = Get-ServerIndexes
Show-Servers
$in = Read-Host "Select index, or enter new NTP server host"
if ($in -eq "") {
  Write-Host "Canceled."
  Exit
}
$serverIndex = 0
if (
  -not [int]::TryParse($in, [ref]$serverIndex) -or
  $serverIndex -lt 0 -or
  $serverIndex -ge $serverIndexes.Length
) {
  $serverIndex = $serverIndexes.Length
  New-ItemProperty -LiteralPath $ntpServersPath -Name $serverIndex -Value $in | Out-Null
}
Set-ItemProperty -LiteralPath $ntpServersPath -Name "(Default)" -Value $serverIndex
Set-ItemProperty -LiteralPath $w32timeParametersPath -Name "NtpServer" -Value $servers.GetValue($serverIndex)
Show-Servers
Stop-Service w32time
Start-Service w32time
