# https://github.com/sysgain/iot-automation/raw/main/powerBItemplates/PowerBI_Templates.zip

# https://projectiot.blob.core.windows.net/iotp2/PBIDesktop_x64.msi

# https://projectiot.blob.core.windows.net/iothub/LightSensor.msi

# https://projectiot.blob.core.windows.net/iothub/DataServiceSetup.msi
param(
    
    [string] $powerBItemplates = "$1",
    
    [string] $powerbidesktop = "$2",
    
    [string] $lightsensor = "$3",

    [string] $dataservicesetup = "$4",

    [string] $azureConnection = "$5",

    [string] $storageConnection = "$6",

    [string] $PiServerConnection = "$7"

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

    $dataserviceconfig = "C:\Program Files (x86)\Default Company Name\DataServiceSetup\DataService.exe.config"

    $doc = (Get-Content $dataserviceconfig) -as [Xml]

    $obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'AzureConnectionString'}

    $obj.value = $azureConnection

    $obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'StorageConnectionString'}

    $obj.value = $storageConnection

    $obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'PiServerConnectionString'}

    $obj.value = $PiServerConnection

    $doc.Save($dataserviceconfig)
    
    Start-Service -SERVICENAME DataServiceEM
