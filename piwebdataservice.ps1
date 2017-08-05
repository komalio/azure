
#https://projectiot.blob.core.windows.net/iotp2/SimulatorSetup.msi
#https://projectiot.blob.core.windows.net/iotp2/PiWebAPISimulatorSetup.msi
#https://projectiot.blob.core.windows.net/iotp2/DataServiceSetup.msi


param(
[string] $simulatorurl = "$1",
[string] $piwebsimulatorUrl = "$2",
[string] $dataserviceUrl = "$3"
)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned  -Force
$client = new-object System.Net.WebClient
$client.DownloadFile($simulatorUrl,"C:\SimulatorSetup.msi")
$client.DownloadFile($piwebsimulatorUrl,"C:\PiWebAPISimulatorSetup.msi")
$client.DownloadFile($dataserviceUrl,"C:\DataServiceSetup.msi")
C:\PiWebAPISimulatorSetup.msi /qn
Start-Sleep -s 12
$piwebconfig = "C:\Program Files (x86)\Default Company Name\PiWebAPISimulatorSetup\WebAPISimulator.exe.config"
$doc = (Get-Content $piwebconfig) -as [Xml]
$obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'UserName'}
$obj.value = 'adminuser'
$obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'Password'}
$obj.value = 'Sysgain@1234'
$obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'BaseURL'}
$obj.value = 'https://tempsqlservervm.demo.deploy.com'
$obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'DatabaseName'}
$obj.value = 'EnergyManagement'
$obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'TimeStarter'}
$obj.value = '200'
$doc.Save($piwebconfig)
C:\DataServiceSetup.msi /qn
Start-Sleep -s 12
