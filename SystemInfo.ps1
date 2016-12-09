# システム情報の表示
# [PowerShellでOSの基本情報を取得する | Windowsインフラ管理者への道](http://ebi.dyndns.biz/windowsadmin/2012/01/15/powershell%E3%81%A7os%E3%81%AE%E5%9F%BA%E6%9C%AC%E6%83%85%E5%A0%B1%E3%82%92%E5%8F%96%E5%BE%97%E3%81%99%E3%82%8B/)
# [PowerShell の コマンドレット例外を取得する - tech.guitarrapc.cóm](http://tech.guitarrapc.com/entry/2013/07/22/000738)
# [インストール済みのWindows Serverの役割と機能を一覧するPowerShellコマンド - YOMON8.NET](http://yomon.hatenablog.com/entry/2014/11/11/170524)

$ErrorActionPreference = "Stop"

function header($title){
  Write-Output "# $title"
}

# 開始メッセージ
Write-Output "# System Informations"
$date = Get-Date
Write-Output "Start: $date"
Write-Output ""

# システム
header "System"
Get-WmiObject Win32_ComputerSystem |
  Format-List -Property Name,PSComputerName,Manufacturer,Model,TotalPhysicalMemory,PartOfDomain,Domain,DomainRole,Workgroup,PrimaryOwnerName

# OSバージョン
header "OS Version"
[Environment]::OSVersion | Format-List

# ディスク構成
header "Disk Drives"
Get-WmiObject Win32_DiskDrive |
  sort DeviceID |
  Format-Table -Wrap -AutoSize -Property DeviceID,Model,Size,Partitions,InterfaceType

# ネットワーク設定
header "Networks"
Get-WmiObject Win32_NetworkAdapterConfiguration |
  ?{$_.IPEnabled -eq $TRUE} |
  sort Description |
  Format-List -Property Description,ServiceName,DHCPEnabled,IPAddress,IPSubnet,DefaultIPGateway,MACAddress,DNSDomain

# 役割情報、機能情報
try {
  Import-Module ServerManager
  header "Roles and Features"
  Get-WindowsFeature |
    ?{$_.InstallState -eq [Microsoft.Windows.ServerManager.Commands.InstallState]::Installed} |
    sort Name | 
    Format-Table -Wrap -AutoSize -Property Name,DisplayName
} catch [Exception] {
  header "ServerManager: Not Installed"
  Write-Output ""
}

# 適用済みセキュリティパッチ
header "Applied Patches"
Get-WmiObject Win32_QuickFixEngineering |
  sort -Descending HotFixID |
  Format-Table -Wrap -AutoSize -Property HotFixID,Description,InstalledOn

# インストール済みアプリケーション
header "Installed Applications"
$path = "\Microsoft\Windows\CurrentVersion\Uninstall"
$testpath = @()
foreach($regTop in @("HKLM:", "HKCU:")){
  foreach($regPlatform in @("", "\Wow6432Node")){
    $testpath += $regTop + "\SOFTWARE" + $regPlatform + $path 
  }
}
$testpath |
  ?{Test-Path $_} |
  %{Get-ChildItem -Path $_} |
  %{Get-ItemProperty $_.PsPath} |
  ?{$_.SystemComponent -ne 1 -and $_.ParentKeyName -eq $null -and $_.DisplayName -ne $null} |
  sort DisplayName |
  Format-Table -Wrap -AutoSize -Property DisplayName,DisplayVersion,Publisher
