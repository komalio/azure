workflow  container{
    param(
       
        [Parameter(Mandatory=$true)]
        [string]
        $tenantId,
		
        [Parameter(Mandatory=$true)]
        [string]
        $azureAccountName,

        [Parameter(Mandatory=$true)]
        [string]
        $azurePassword,

        [Parameter(Mandatory=$true)]
        [string]
        $cosmosDBAccountKey,

        [Parameter(Mandatory=$true)]
        [string]
        $cosmosDbAccountName,
        
        [Parameter(Mandatory=$true)]
        [string]
        $cosmosDbName

    )

    InlineScript{
        
        $tenantId = $Using:tenantId
        $azureAccountName = $Using:azureAccountName
        $azurePassword = $Using:azurePassword
        $cosmosDBAccountKey = $Using:cosmosDBAccountKey
        $cosmosDbAccountName = $Using:cosmosDbAccountName
        $cosmosDbName = $Using:cosmosDbName
      

    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned  -Force
    $password = ConvertTo-SecureString $azurePassword -AsPlainText -Force
    $psCred = New-Object System.Management.Automation.PSCredential($azureAccountName, $password)
    start-Sleep -s 20
    Login-AzureRmAccount -TenantId $tenantId -Credential $psCred 
    start-Sleep -s 20

    $primaryKey = ConvertTo-SecureString -String $cosmosDBAccountKey -AsPlainText -Force
    $cosmosDbContext = New-CosmosDbContext -Account $cosmosDbAccountName -Database $cosmosDbName -Key $primaryKey
    start-Sleep -s 20

    # Create CosmosDB
    New-CosmosDbDatabase -Context $cosmosDbContext -Id $cosmosDbName
    start-Sleep -s 30

    # Create CosmosDB Collections
    New-CosmosDbCollection -Context $cosmosDbContext -Id 'EventClusters'  -OfferThroughput 400
    start-Sleep -s 20
    New-CosmosDbCollection -Context $cosmosDbContext -Id 'Responses' -OfferThroughput 400
    start-Sleep -s 20
    New-CosmosDbCollection -Context $cosmosDbContext -Id 'Devices' -OfferThroughput 400
    start-Sleep -s 30
    New-CosmosDbCollection -Context $cosmosDbContext -Id 'ActionPlans' -OfferThroughput 400
    start-Sleep -s 30
    New-CosmosDbCollection -Context $cosmosDbContext -Id 'Notifications' -OfferThroughput 400
    start-Sleep -s 30
}
}
