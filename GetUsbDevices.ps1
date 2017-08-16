# [Displaying USB Devices using WMI | PowerShell Team Blog](https://blogs.msdn.microsoft.com/powershell/2007/02/24/displaying-usb-devices-using-wmi/)

Get-WmiObject Win32_USBControllerDevice |
  % {[wmi]($_.Dependent)} |
  sort PNPClass, Service, Description, DeviceID |
  Format-Table -auto PNPClass, Service, Description, DeviceID
