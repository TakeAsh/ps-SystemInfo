# システム情報の表示
# [Computer System Hardware Classes (Windows)](https://msdn.microsoft.com/en-us/library/aa389273.aspx)
# [PowerShellでOSの基本情報を取得する | Windowsインフラ管理者への道](http://ebi.dyndns.biz/windowsadmin/2012/01/15/powershell%E3%81%A7os%E3%81%AE%E5%9F%BA%E6%9C%AC%E6%83%85%E5%A0%B1%E3%82%92%E5%8F%96%E5%BE%97%E3%81%99%E3%82%8B/)
# [PowerShell の コマンドレット例外を取得する - tech.guitarrapc.cóm](http://tech.guitarrapc.com/entry/2013/07/22/000738)
# [インストール済みのWindows Serverの役割と機能を一覧するPowerShellコマンド - YOMON8.NET](http://yomon.hatenablog.com/entry/2014/11/11/170524)
# [PowerShell: ◆メモリーサイズを調べる](http://mtgpowershell.blogspot.jp/2010/12/blog-post_13.html)

$ErrorActionPreference = "Stop"

function header($title) {
  Write-Output "# $title"
}

function header2($title) {
  Write-Output "## $title"
}

# 開始メッセージ
Write-Output "# System Informations"
$date = Get-Date
Write-Output "Start: $date"
Write-Output ""

# システム
header "System"
$physicalMemory = @{Name = "PhysicalMemory"; Expression = {[math]::round($_.TotalPhysicalMemory / 1GB, 3)}}
Get-WmiObject Win32_ComputerSystem |
  Format-List -Property Name, PSComputerName, Manufacturer, Model, $physicalMemory, PartOfDomain, Domain, DomainRole, Workgroup, PrimaryOwnerName

# OSバージョン
header "OS Version"
[Environment]::OSVersion | Format-List

# CPU
header "Processor"
$architectures = "x86", "MIPS", "Alpha", "PowerPC", "Unknown", "ARM", "ia64", "Unknown", "Unknown", "x64"
$processorArchitecture = @{Name = 'Architecture'; Expression = {$architectures[$_.Architecture]}}
Get-WmiObject -Class Win32_Processor |
  Format-List -Property DeviceID, Role, Name, Manufacturer, Description, SocketDesignation, $processorArchitecture, NumberOfCores, NumberOfLogicalProcessors, ThreadCount, VirtualizationFirmwareEnabled, VMMonitorModeExtensions, CurrentClockSpeed, MaxClockSpeed, ExtClock, Status

# 物理メモリ
header "Physical Memory"
$formfactors = "Unknown", "Other", "SIP", "DIP", "ZIP", "SOJ", "Proprietary",
"SIMM", "DIMM", "TSOP", "PGA", "RIMM", "SODIMM", "SRIMM", "SMD", "SSMP",
"QFP", "TQFP", "SOIC", "LCC", "PLCC", "BGA", "FPBGA", "LGA"
$memorytypes = "Unknown", "Other", "DRAM", "Synchronous DRAM", "Cache DRAM",
"EDO", "EDRAM", "VRAM", "SRAM", "RAM", "ROM", "Flash", "EEPROM", "FEPROM",
"EPROM", "CDRAM", "3DRAM", "SDRAM", "SGRAM", "RDRAM", "DDR", "DDR2", 
"DDR2 FB-DIMM", "Unknown", "DDR3", "FBD2"
$memorySize = @{Name = 'Size(GB)'; Expression = {$_.Capacity / 1GB}}
$memoryFormFactor = @{Name = "Form Factor"; Expression = {$formfactors[$_.FormFactor]}}
$memoryTypeName = @{Name = "Memory Type"; Expression = {$memorytypes[$_.MemoryType]}}
Get-WmiObject Win32_PhysicalMemory |
  Format-Table -AutoSize BankLabel, $memorySize, $memoryFormFactor, $memoryTypeName, Speed

# ディスク構成
header "Disk Drives"
$diskSize = @{Name = 'Size(GB)'; Expression = {[math]::round($_.Size / 1E9, 0)}}
Get-WmiObject Win32_DiskDrive |
  Sort-Object DeviceID |
  Format-Table -Wrap -AutoSize -Property DeviceID, Model, $diskSize, Partitions, InterfaceType

# ディスクパーティション / 論理ドライブ
header "Partition / Logical Drive"
$partitions = @{}
Get-WmiObject -Class Win32_DiskPartition | % {
  $disk = '' + $_.DiskIndex
  $partition = '' + $_.Index
  if (!$partitions[$disk]) {
    $partitions[$disk] = @{}
  }
  $partitions[$disk][$partition] = [PSCustomObject] @{
    Disk        = $disk;
    Partition   = $partition;
    Size        = [math]::round($_.Size / 1E9, 3)
    Drive       = '-';
    Description = $_.Description;
  }
}
Get-WmiObject Win32_LogicalDiskToPartition | % {
  $_.Antecedent -match '"Disk\s#(?<disk>\d+),\s*Partition\s#(?<partition>\d+)"$' | Out-Null
  $disk = $Matches.disk
  $partition = $Matches.partition
  $_.Dependent -match '"(?<drive>[^"]+)"$' | Out-Null
  $partitions[$disk][$partition].Drive = $Matches.drive
}
$partitions.GetEnumerator() |
  % { $_.Value.GetEnumerator() | % { $_.Value }} |
  Sort-Object Disk, Partition | Format-Table -AutoSize

# ネットワーク設定
header "Networks"
Get-WmiObject Win32_NetworkAdapterConfiguration |
  ? {$_.InterfaceIndex -ne $null} |
  % {$networkAdptors = @{}} {$networkAdptors[$_.InterfaceIndex] = $_}
Get-NetConnectionProfile |
  Sort-Object Name | % {
  $adaptor = $networkAdptors[$_.InterfaceIndex];
  [PSCustomObject] @{
    Name             = $_.Name;
    NetworkCategory  = $_.NetworkCategory;
    Description      = $adaptor.Description;
    DHCPEnabled      = $adaptor.DHCPEnabled;
    IPAddress        = $adaptor.IPAddress;
    IPSubnet         = $adaptor.IPSubnet;
    DefaultIPGateway = $adaptor.DefaultIPGateway;
    MACAddress       = $adaptor.MACAddress;
    DNSDomain        = $adaptor.DNSDomain;
  }
} | Format-List -Property Index, Name, NetworkCategory, Description, DHCPEnabled, IPAddress, IPSubnet, DefaultIPGateway, MACAddress, DNSDomain

# 静的ルーティング
header "Static routes"
Get-WmiObject -class Win32_IP4PersistedRouteTable |
  Format-Table -AutoSize -Property Destination, Mask, NextHop, Metric1

# NTP Server
header "NTP Server"
$ntpServersPath = "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/DateTime/Servers"
$w32timeNtpClientPath = "HKLM:/SYSTEM/CurrentControlSet/services/W32Time/TimeProviders/NtpClient"
$ntpServers = Get-Item -LiteralPath $ntpServersPath
$selectedNtpServer = $ntpServers.GetValue("")
$ntpServers.GetValueNames() |
  ? {$_ -ne ""} |
  Sort-Object |
  % {$(if ($_ -eq $selectedNtpServer) {"*"} else {" "}) + $_ + ": " + $ntpServers.GetValue($_)}
$hourToSec = 60.0 * 60
$ntpInterval = (Get-ItemProperty -LiteralPath $w32timeNtpClientPath).SpecialPollInterval / $hourToSec
Write-Output "Interval (hours): ${ntpInterval}" 
Write-Output ""

# 役割情報、機能情報
try {
  Import-Module ServerManager
  header "Roles and Features"
  Get-WindowsFeature |
    ? {$_.InstallState -eq [Microsoft.Windows.ServerManager.Commands.InstallState]::Installed} |
    Sort-Object Name | 
    Format-Table -Wrap -AutoSize -Property Name, DisplayName
}
catch [Exception] {
  header "ServerManager: Not Installed"
  Write-Output ""
}

# 適用済みセキュリティパッチ
header "Applied Patches"
Get-WmiObject Win32_QuickFixEngineering |
  Sort-Object -Descending HotFixID |
  Format-Table -Wrap -AutoSize -Property HotFixID, Description, InstalledOn

# インストール済みアプリケーション
header "Installed Applications"
$path = "\Microsoft\Windows\CurrentVersion\Uninstall"
$testpath = @()
foreach ($regTop in @("HKLM:", "HKCU:")) {
  foreach ($regPlatform in @("", "\Wow6432Node")) {
    $testpath += $regTop + "\SOFTWARE" + $regPlatform + $path 
  }
}
$testpath |
  ? {Test-Path $_} |
  % {Get-ChildItem -Path $_} |
  % {Get-ItemProperty $_.PsPath} |
  ? {$_.SystemComponent -ne 1 -and $_.ParentKeyName -eq $null -and $_.DisplayName -ne $null} |
  Sort-Object DisplayName |
  Format-Table -Wrap -AutoSize -Property DisplayName, DisplayVersion, Publisher

# 環境変数
header "Environment Variables"
$binpaths = @("Path", "PSModulePath")
Get-ChildItem env: |
  ? {-not ($binpaths -contains $_.Name)} |
  Format-Table -Wrap -AutoSize
$binpaths |
  % {header2 $_; [environment]::getenvironmentvariable($_) -split ";"; Write-Output ""}
