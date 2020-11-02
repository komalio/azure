Set-ExecutionPolicy -ExecutionPolicy Unrestricted  -Force
Get-Partition -DriveLetter "D" | Set-Partition -NewDriveLetter "T"
$TempDriveLetter = "T"
$TempDriveLetter = $TempDriveLetter + ":"
$drive = Get-WmiObject -Class win32_volume -Filter “DriveLetter = '$TempDriveLetter'”
#re-enable page file on new Drive
$drive = Get-WmiObject -Class win32_volume -Filter “DriveLetter = '$TempDriveLetter'”
Set-WMIInstance -Class Win32_PageFileSetting -Arguments @{ Name = "$TempDriveLetter\pagefile.sys"; MaximumSize = 0; }
Restart-Computer -Force