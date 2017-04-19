# SystemInfo.ps1
show system informations

## Usage sample
```
> .\SystemInfo.ps1
# System Informations
Start: 03/15/2017 00:01:42

# System
Name             : localhost
PSComputerName   : localhost
Manufacturer     : Red Hat
Model            : KVM
PhysicalMemory   : 4
PartOfDomain     : False
Domain           : WORKGROUP
DomainRole       : 0
Workgroup        : WORKGROUP
PrimaryOwnerName : Windows ユーザー

# OS Version
Platform      : Win32NT
ServicePack   : 
Version       : 10.0.14393.0
VersionString : Microsoft Windows NT 10.0.14393.0

# Physical Memory
BankLabel Size(GB) Form Factor Memory Type Speed
--------- -------- ----------- ----------- -----
                 4 DIMM        RAM         18756

# Disk Drives
DeviceID           Model                    Size(GB) Partitions InterfaceType
--------           -----                    -------- ---------- -------------
\\.\PHYSICALDRIVE0 QEMU HARDDISK ATA Device       86          4 IDE          

# Networks
Description      : Intel(R) PRO/1000 MT Network Connection
ServiceName      : E1G60
DHCPEnabled      : False
IPAddress        : {192.168.0.206}
IPSubnet         : {255.255.255.0}
DefaultIPGateway : {192.168.0.1}
MACAddress       : xx:xx:xx:xx:xx:xx
DNSDomain        : localdomain

# ServerManager: Not Installed

# Applied Patches
HotFixID  Description     InstalledOn       
--------  -----------     -----------       
KB4010250 Security Update 2017/02/22 0:00:00
KB3213986 Security Update 2017/02/01 0:00:00
KB3211320 Update          2017/02/01 0:00:00

# Installed Applications
DisplayName                                                                     DisplayVersion   Publisher               
-----------                                                                     --------------   ---------               
7-Zip 16.04 (x64)                                                               16.04            Igor Pavlov             
doxygen 1.8.13                                                                  1.8.13           Dimitri van Heesch      
Git version 2.11.1                                                              2.11.1           The Git Development Community
Google Chrome                                                                   56.0.2924.87     Google Inc.             
Graphviz                                                                        2.38             AT&T Research Labs.     
Microsoft .NET Framework 4.5 Multi-Targeting Pack                               4.5.50710        Microsoft Corporation   
Microsoft .NET Framework 4.5.1 Multi-Targeting Pack                             4.5.50932        Microsoft Corporation   
Microsoft .NET Framework 4.5.1 Multi-Targeting Pack (ENU)                       4.5.50932        Microsoft Corporation   
Microsoft .NET Framework 4.5.1 Multi-Targeting Pack (日本語)                       4.5.50932        Microsoft Corporation   
Microsoft .NET Framework 4.5.1 SDK                                              4.5.51641        Microsoft Corporation   
Microsoft .NET Framework 4.5.1 SDK (日本語)                                        4.5.51641        Microsoft Corporation   
Microsoft .NET Framework 4.5.2 Multi-Targeting Pack                             4.5.51651        Microsoft Corporation   
Microsoft .NET Framework 4.5.2 Multi-Targeting Pack (ENU)                       4.5.51209        Microsoft Corporation   
Microsoft .NET Framework 4.5.2 Multi-Targeting Pack (日本語)                       4.5.51209        Microsoft Corporation   
Microsoft Visual C++ 2005 Redistributable                                       8.0.61001        Microsoft Corporation   
Microsoft Visual C++ 2005 Redistributable (x64)                                 8.0.61000        Microsoft Corporation   
Microsoft Visual C++ 2008 Redistributable - x64 9.0.30729.6161                  9.0.30729.6161   Microsoft Corporation   
Microsoft Visual C++ 2008 Redistributable - x86 9.0.30729.6161                  9.0.30729.6161   Microsoft Corporation   
Microsoft Visual C++ 2010  x64 Redistributable - 10.0.40219                     10.0.40219       Microsoft Corporation   
Microsoft Visual C++ 2010  x64 Runtime - 10.0.40219                             10.0.40219       Microsoft Corporation   
Microsoft Visual C++ 2010  x86 Redistributable - 10.0.40219                     10.0.40219       Microsoft Corporation   
Microsoft Visual C++ 2010  x86 Runtime - 10.0.40219                             10.0.40219       Microsoft Corporation   
Microsoft Visual C++ 2010 Express - ENU                                         10.0.40219       Microsoft Corporation   
Microsoft Visual C++ 2012 Redistributable (x64) - 11.0.60610                    11.0.60610.1     Microsoft Corporation   
Microsoft Visual C++ 2012 Redistributable (x86) - 11.0.60610                    11.0.60610.1     Microsoft Corporation   
Microsoft Visual C++ 2013 Redistributable (x64) - 12.0.21005                    12.0.21005.1     Microsoft Corporation   
Microsoft Visual C++ 2013 Redistributable (x64) - 12.0.30501                    12.0.30501.0     Microsoft Corporation   
Microsoft Visual C++ 2013 Redistributable (x86) - 12.0.21005                    12.0.21005.1     Microsoft Corporation   
Microsoft Visual C++ 2013 Redistributable (x86) - 12.0.30501                    12.0.30501.0     Microsoft Corporation   
Microsoft Visual C++ 2015 Redistributable (x64) - 14.0.24215                    14.0.24215.1     Microsoft Corporation   
Microsoft Visual C++ 2015 Redistributable (x86) - 14.0.24215                    14.0.24215.1     Microsoft Corporation   
Microsoft Visual Studio Code                                                    1.10.2           Microsoft Corporation   
Microsoft ヘルプ ビューアー 2.2 言語パック - 日本語                                             2.2.25420        Microsoft Corporation   
Prerequisites for SSDT                                                          12.0.2000.8      Microsoft Corporation   
Prerequisites for SSDT                                                          13.0.1601.5      Microsoft Corporation   

# Environment Variables
Name                             Value                                                             
----                             -----                                                             
ALLUSERSPROFILE                  C:\ProgramData                                                    
APPDATA                          C:\Users\User01\AppData\Roaming                                
ChocolateyInstall                C:\ProgramData\chocolatey                                         
ChocolateyLastPathUpdate         Wed Feb  1 17:11:58 2017                                          
ChocolateyToolsLocation          C:\tools                                                          
CommonProgramFiles               C:\Program Files\Common Files                                     
CommonProgramFiles(x86)          C:\Program Files (x86)\Common Files                               
CommonProgramW6432               C:\Program Files\Common Files                                     
COMPUTERNAME                     localhost                                                           
ComSpec                          C:\Windows\system32\cmd.exe                                       
HOME                             C:\Users\User01                                                
HOMEDRIVE                        C:                                                                
HOMEPATH                         \Users\User01                                                  
LANG                             en_US.UTF-8                                                       
LOCALAPPDATA                     C:\Users\User01\AppData\Local                                  
LOGONSERVER                      \\localhost                                                         
NUMBER_OF_PROCESSORS             2                                                                 
OneDrive                         C:\Users\User01\OneDrive                                       
OS                               Windows_NT                                                        
PATHEXT                          .COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC;.CPL        
PROCESSOR_ARCHITECTURE           AMD64                                                             
PROCESSOR_IDENTIFIER             Intel64 Family 6 Model 44 Stepping 1, GenuineIntel                
PROCESSOR_LEVEL                  6                                                                 
PROCESSOR_REVISION               2c01                                                              
ProgramData                      C:\ProgramData                                                    
ProgramFiles                     C:\Program Files                                                  
ProgramFiles(x86)                C:\Program Files (x86)                                            
ProgramW6432                     C:\Program Files                                                  
PUBLIC                           C:\Users\Public                                                   
SystemDrive                      C:                                                                
SystemRoot                       C:\Windows                                                        
TEMP                             C:\Users\User01\AppData\Local\Temp                              
TMP                              C:\Users\User01\AppData\Local\Temp                              
USERDOMAIN                       localhost                                                           
USERDOMAIN_ROAMINGPROFILE        localhost                                                           
USERNAME                         User01                                                         
USERPROFILE                      C:\Users\User01                                                
VSCODE_CWD                       C:\Work                                                           
VSCODE_IPC_HOOK                  \\.\pipe\code-63aa8c-1.10.2-main-sock                             
VSCODE_NLS_CONFIG                {"locale":"ja","availableLanguages":{"*":"ja"}}                   
VSCODE_NODE_CACHED_DATA_DIR_7572 C:\Users\User01\AppData\Roaming\Code\CachedData                
VSCODE_PID                       7572                                                              
VSCODE_SHARED_IPC_HOOK           \\.\pipe\code-63aa8c-1.10.2-shared-sock                           
VSSDK140Install                  C:\Program Files (x86)\Microsoft Visual Studio 14.0\VSSDK\        
windir                           C:\Windows                                                        

## Path
C:\Windows\system32
C:\Windows
C:\Windows\System32\Wbem
C:\Windows\System32\WindowsPowerShell\v1.0\
C:\ProgramData\chocolatey\bin
C:\Program Files\Git\cmd
C:\Program Files\Git\usr\bin
%USERPROFILE%\.dnx\bin
C:\Program Files\Microsoft DNX\Dnvm\
C:\Program Files\doxygen\bin
C:\Program Files (x86)\Graphviz2.38\bin
C:\Users\User01\AppData\Local\Microsoft\WindowsApps
C:\Program Files (x86)\Microsoft VS Code\bin

## PSModulePath
C:\Users\User01\Documents\WindowsPowerShell\Modules
C:\Program Files\WindowsPowerShell\Modules
C:\Windows\system32\WindowsPowerShell\v1.0\Modules
```

# ChangeNetCategory.ps1
show the network profiles, and change its NetworkCategory (Public/Private).

## Usage sample
```
> .\ChangeNetCategory.ps1

Index            : 0
Name             : Unidentified Network
NetworkCategory  : Public
Description      : TAP-Windows Adapter V9
DHCPEnabled      : True
IPAddress        : {10.8.0.6}
IPSubnet         : {255.255.255.252}
DefaultIPGateway :
MACAddress       : xx:xx:xx:xx:xx:xx

Index            : 1
Name             : Network
NetworkCategory  : Private
Description      : Intel(R) PRO/1000 MT Network Connection
DHCPEnabled      : False
IPAddress        : {192.168.0.206}
IPSubnet         : {255.255.255.0}
DefaultIPGateway : {192.168.0.1}
MACAddress       : xx:xx:xx:xx:xx:xx

Input index: 0
'Unidentified Network' is changed to 'Private'.
```
