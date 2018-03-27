# https://github.com/sysgain/iot-automation/raw/main/powerBItemplates/PowerBI_Templates.zip

# https://projectiot.blob.core.windows.net/iotp2/PBIDesktop_x64.msi

# https://projectiot.blob.core.windows.net/iothub/LightSensor.msi

# https://projectiot.blob.core.windows.net/iothub/DataServiceSetup.msi
param(
    
    [string] $powerBItemplates = "$1",
    
    [string] $powerbidesktop = "$2",
    
    [string] $lightsensor = "$3",

    [string] $dataservicesetup = "$4",

    [string] $databaseName1 = "$5",

    [string] $webjobStorageName = "$6",

    [string] $webJobStorageKey = "$7",

    [string] $databaseName = "$8"

    )
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned  -Force
    
    $client = new-object System.Net.WebClient
    
    $client.DownloadFile($powerBItemplates,"C:\PowerBI_Templates.zip")

    $client.DownloadFile($lightsensor,"C:\LightSensor.msi")

    C:\LightSensor.msi /qn

    Start-Sleep -s 12
    
    $client.DownloadFile($dataservicesetup,"C:\DataServiceSetup.msi")

    C:\DataServiceSetup.msi /qn

    Start-Sleep -s 12
     
    $client.DownloadFile($powerbidesktop,"C:\PBIDesktop_x64.msi")
    
    $LocalTempDir = $env:TEMP; $ChromeInstaller = "ChromeInstaller.exe"; (new-object    System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; $Process2Monitor =  "ChromeInstaller"; Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } else { rm "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)
    
    C:\PBIDesktop_x64.msi /qn /norestart ACCEPT_EULA=1

    # update dataservice config

    $dataserviceconfig = "C:\Program Files (x86)\Default Company Name\DataServiceSetup\DataService.exe.config"

    $doc = (Get-Content $dataserviceconfig) -as [Xml]

    $obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'AzureConnectionString'}

    $azureConnection = Write-host "Server=tcp:emsdemosqlsrv.database.windows.net,1433;Initial Catalog=$($databaseName1);Persist Security Info=False;User ID=sqluser;Password=Password@1234;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"

    $obj.value= "$($azureConnection)"

    write-output $obj.value

    $obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'StorageConnectionString'}

    $storageConnection = Write-host "DefaultEndpointsProtocol=https;AccountName=$($webjobStorageName);AccountKey=$($webjobStorageKey);EndpointSuffix=core.windows.net"
    
    $obj.value = "$($storageConnection)"
   
    write-output $obj.value

    $obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'PiServerConnectionString'}

    $piServerConnection = Write-host "data source=tcp:emsdemosqlsrv.database.windows.net,1433;initial catalog=$($databaseName);persist security info=True;user id=sqluser;password=Password@1234"

    $obj.value = "$($piServerConnection)"

    write-output $obj.value

    $doc.Save($dataserviceconfig)

    Start-Service -SERVICENAME DataServiceEM
