Set-ExecutionPolicy -ExecutionPolicy Unrestricted  -Force
gwmi win32_pagefilesetting
$pf=gwmi win32_pagefilesetting
$pf.Delete()
Restart-Computer –Force
