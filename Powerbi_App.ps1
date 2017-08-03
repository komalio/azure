#  Grab the Azure AD Service principal

#Example to Run Command
#.\AAD.ps1 -TenantId "ac12acb5-a79a-4ca7-87eb-c5e6ebbbcd38" -DisplayName "myappauto" -IdentifierUris "https://yapp.azurewebsites.net"


param(

[string] $TenantId, [string] $DisplayName, [string] $IdentifierUris)

Set-ExecutionPolicy -ExecutionPolicy Unrestricted  -Force
Install-Module AzureADPreview
connect-azuread -TenantId "ac12acb5-a79a-4ca7-87eb-c5e6ebbbcd38"

$aad = (Get-AzureADServicePrincipal | `
    where {$_.ServicePrincipalNames.Contains("https://graph.windows.net")})[0]
#  Grab the User.Read permission
$userRead = $aad.Oauth2Permissions | ? {$_.Value -eq "User.Read"}
#  Grab the Directory.ReadWrite.All permission
$directoryWrite = $aad.Oauth2Permissions | `
  ? {$_.Value -eq "Directory.ReadWrite.All"}
 
 
 
 $DirectoryAccessAsUserAll = $aad.Oauth2Permissions | `
  ? {$_.Value -eq "Directory.AccessAsUser.All"}

   $DirectoryReadAll = $aad.Oauth2Permissions | `
  ? {$_.Value -eq "Directory.Read.All"} 

    $GroupReadWriteAll = $aad.Oauth2Permissions | `
  ? {$_.Value -eq "Group.ReadWrite.All"} 
 
#  Resource Access User.Read + Sign in & Directory.ReadWrite.All
$readWriteAccess = [Microsoft.Open.AzureAD.Model.RequiredResourceAccess]@{
  ResourceAppId=$aad.AppId ;
  ResourceAccess=[Microsoft.Open.AzureAD.Model.ResourceAccess]@{
    Id = $userRead.Id ;
    Type = "Scope"}, [Microsoft.Open.AzureAD.Model.ResourceAccess]@{
    Id = $directoryWrite.Id ;
    Type = "Scope"}, [Microsoft.Open.AzureAD.Model.ResourceAccess]@{
    Id = $DirectoryAccessAsUserAll.Id ;
    Type = "Scope"}, [Microsoft.Open.AzureAD.Model.ResourceAccess]@{
    Id = $DirectoryReadAll.Id ;
    Type = "Scope"}, [Microsoft.Open.AzureAD.Model.ResourceAccess]@{
    Id = $GroupReadWriteAll.Id ;
    Type = "Scope"}}
 
 $readWriteAccess1 = [Microsoft.Open.AzureAD.Model.RequiredResourceAccess]@{
  ResourceAppId="00000009-0000-0000-c000-000000000000" ;
  ResourceAccess=[Microsoft.Open.AzureAD.Model.ResourceAccess]@{
    Id = "7504609f-c495-4c64-8542-686125a5a36f";
    Type = "Scope"},[Microsoft.Open.AzureAD.Model.ResourceAccess]@{
    Id = "a65a6bd9-0978-46d6-a261-36b3e6fdd32e";
    Type = "Scope"},[Microsoft.Open.AzureAD.Model.ResourceAccess]@{
    Id = "47df08d3-85e6-4bd3-8c77-680fbe28162e";
    Type = "Scope"},[Microsoft.Open.AzureAD.Model.ResourceAccess]@{
    Id = "4ae1bf56-f562-4747-b7bc-2fa0874ed46f";
    Type = "Scope"},[Microsoft.Open.AzureAD.Model.ResourceAccess]@{
    Id = "f3076109-ca66-412a-be10-d4ee1be95d47";
    Type = "Scope"},[Microsoft.Open.AzureAD.Model.ResourceAccess]@{
    Id = "ecf4e395-4315-4efa-ba57-a253fe0438b4";
    Type = "Scope"},[Microsoft.Open.AzureAD.Model.ResourceAccess]@{
    Id = "322b68b2-0804-416e-86a5-d772c567b6e6";
    Type = "Scope"},[Microsoft.Open.AzureAD.Model.ResourceAccess]@{
    Id = "7f33e027-4039-419b-938e-2f8ca153e68e";
    Type = "Scope"},[Microsoft.Open.AzureAD.Model.ResourceAccess]@{
    Id = "2448370f-f988-42cd-909c-6528efd67c1a";
    Type = "Scope"},[Microsoft.Open.AzureAD.Model.ResourceAccess]@{
    Id = "ecc85717-98b0-4465-af6d-1cbba6f9c961";
    Type = "Scope"}}

#  Create querying App
$queryApp = New-AzureADApplication -DisplayName "$DisplayName" `
    -IdentifierUris "$IdentifierUris" -ReplyUrls "$IdentifierUris" -Homepage "$IdentifierUris" `
    -RequiredResourceAccess $readWriteAccess , $readWriteAccess1

 
#  Associate a Service Principal so it can login
$spQuery = New-AzureADServicePrincipal -AppId $queryApp.AppId 
 
#  Create a key credential for the app valid from now
#  (-1 day, to accomodate client / service time difference)
#  till three months from now
$startDate = (Get-Date).AddDays(-1)
$endDate = $startDate.AddYears(1)
 
$pwd = New-AzureADApplicationPasswordCredential -ObjectId $queryApp.ObjectId `
  -StartDate $startDate -EndDate $endDate `
  -CustomKeyIdentifier "MyCredentials"


  
  

   #$Test = [Microsoft.Open.AzureAD.Model.OAuth2PermissionGrant]@{  ConsentType = "AllPrincipals"; ClientId =  $spQuery.AppId; Scope = "Dataset.ReadWrite.All Dashboard.Read.All Report.Read.All Group.Read Group.Read.All Content.Create Metadata.View_Any Dataset.Read.All Data.Alter_Any"}
 #$queryApp.OAuth2PermissionGrant  = $Test
 
