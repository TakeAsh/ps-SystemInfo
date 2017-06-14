# ChangeNetCategory.ps1
# Show the list of networks, then input the index of the network that you want to change its NetworkCategory.
# You have to run this script as an administrator.

Get-WmiObject Win32_NetworkAdapterConfiguration |
  ? {$_.InterfaceIndex -ne $null} |
  % {$adptors = @{}} {$adptors[$_.InterfaceIndex] = $_}
$networks = @( Get-NetConnectionProfile |
    Sort-Object Name |
    % {$index = 0} {
    $adaptor = $adptors[$_.InterfaceIndex];
    [PSCustomObject] @{
      Index            = $index++;
      Profile          = $_;
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
  })
$networks |
  Format-List -Property Index, Name, NetworkCategory, Description, DHCPEnabled, IPAddress, IPSubnet, DefaultIPGateway, MACAddress, DNSDomain

$in = Read-Host "Input index"
$profIndex = 0
if (
  -not [int]::TryParse( $in, [ref]$profIndex ) -or 
  $profIndex -lt 0 -or 
  $profIndex -ge $networks.Length
) {
  Write-Host "Canceled."
  Exit
}
$prof = $networks[$profIndex].Profile
$newCategory = if ($prof.NetworkCategory -eq "Public") {
  "Private"
} else {
  "Public" 
}
$prof | Set-NetConnectionProfile -NetworkCategory $newCategory
Write-Host "'$($prof.Name)' is changed to '$newCategory'."
