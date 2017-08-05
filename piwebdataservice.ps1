
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
$dataserviceconfig = "C:\Program Files (x86)\Default Company Name\DataServiceSetup\DataService.exe.config"
$doc = (Get-Content $dataserviceconfig) -as [Xml]
$obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'AzureConnectionString'}
$obj.value = 'Server=tcp:mspowergrid1.database.windows.net,1433;Initial Catalog=energymanagement1;Persist Security Info=False;User ID=piadmin1;Password=Micr0s0ft12!@1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=301'
$obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'StorageConnectionString'}
$obj.value = 'DefaultEndpointsProtocol=https;AccountName=mseastusupdate;AccountKey=soqNhHi+qQDwJIjXAD9fAQR5EXpH4CA6oCXLpX7aCVDdlO+AfvjLh5w/rkXaKFq/ZfF+etn1ViV8TiZGS8PyDQ==update;EndpointSuffix=core.windows.net'
$obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'PiServerConnectionString'}
$obj.value = 'data source=TEMPSQLSERVERVM\SQLEXPRESS1;initial catalog=PIEMView1;persist security info=True;user id=dataservice1;password=dataservice1'
$doc.Save($dataserviceconfig)
Start-Service -SERVICENAME DataServiceEM
Start-Sleep -s 30
Start-Process -FilePath " C:\Program Files (x86)\Default Company Name\PiWebAPISimulatorSetup\WebAPISimulator.exe "
