# Lab3: Implement and Manage Storage

## Table of Contents

[Overview](#overview)

[Pre-requisites](#pre-requisites) 

[Login](#login) 

[Scenario and Objectives](#scenario-and-objectives) 

[Exercise 0: Prepare the lab environment](#exercise-0-prepare-the-lab-environment)

[Exercise 1: Implement and use Azure Blob Storage](#exercise-1-implement-and-use-azure-blob-storage)

[Exercise 2: Implement and use Azure File Storage](#exercise-2-prepare-the-lab-environment)

[Exercise 3: Remove lab resources](#exercise-3-remove-lab-resources)


## Overview

The aim of this lab is to implement azure blob storage and manage storage. In this lab you have create two Azure Storage accounts, review their configuration settings, create a blob container, upload blobs into the container, copy the container and blobs between the storage accounts, and use a SAS key to access one of the blobs. 
In this lab we are also Implement and use Azure File Storage. you have create an Azure File Service share, map a drive to the file share from an Azure VM, and use File Explorer from the Azure VM to create a folder and a file in the file share.

## Pre-requisites

1.	Familiarity with azure portal

2.	Familiarity with Remote Desktop Connection

3.	Familiarity with azure virtual machine (VM)

4.	Familiarity with ARM Templates

All tasks in this lab are performed from the Azure portal (including a PowerShell Cloud Shell session) except for Exercise 2 Task 2, which includes steps performed from a Remote Desktop session to an Azure VM

Note: When not using Cloud Shell, the lab virtual machine must have the Azure PowerShell 1.2.0 module (or newer) installed https://docs.microsoft.com/en-us/powershell/azure/install-az-ps

Lab files:
* https://github.com/sysgain/qloudable-tl-labs/blob/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Allfiles/Labfiles/Module_03/Implement_and_Manage_Storage/az-100-02_azuredeploy.json

* https://github.com/sysgain/qloudable-tl-labs/blob/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Allfiles/Labfiles/Module_03/Implement_and_Manage_Storage/az-100-02_azuredeploy.json

## Login 

Note down the azure portal login credentials which are provided from lab.

Username

Password

Resource group

Location

## Scenario& Objectives

Xyz training Corporation wants to leverage Azure Storage for hosting its data.

After completing this lab, you will be able to:
*	Deploy an Azure VM by using an Azure Resource Manager template
*	Implement and use Azure Blob Storage
*	Implement and use Azure File Storage

## Exercise 0: Prepare the lab environment

The main tasks for this exercise are as follows:
1.	Deploy an Azure VM by using an Azure Resource Manager template

**Task 1: Deploy an Azure VM by using an Azure Resource Manager template**

1.	From the lab virtual machine, start Microsoft Edge, browse to the Azure portal at **http://portal.azure.com** and sign in by using a Microsoft account that has the Owner role in the Azure subscription you intend to use in this lab.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-1.png)

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-2.png)

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-3.png)

2.	In the Azure portal, navigate to the **Subscriptions** blade by searching and click on that Subscriptions icon.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-4.png)

3.	From the **Subscriptions** blade, navigate to the blade displaying properties of your Azure subscription by click on the subscription name

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-5.png)

4.	From the blade displaying the properties of your subscription, navigate to its **Resource providers** blade.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-6.png)

5.	On the Resource providers blade, register the following resource providers (if these resource providers have not been yet registered):
*  Microsoft.Network
*  Microsoft.Compute
*  Microsoft.Storage

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-7.png)

>  **Note:** This step registers the Azure Resource Manager Microsoft.Network, Microsoft.Compute, and Microsoft.Storage resource providers. This is a one-time operation (per subscription) required when using Azure Resource Manager templates to deploy resources managed by these resource providers (if these resource providers have not been yet registered).

1.	In the Azure portal, navigate to the **Create a resource** blade.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-8.png)

2.	From the **Create a resource** blade, search Azure Marketplace for **Template deployment, then select Template deployment (deploy using customer templates)**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-9.png)

3.	Click **Create**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-10.png)

4.	On the **Custom deployment** blade, click the **Build your own template in the editor** link. If you do not see this link, click **Edit template** instead.
 
 ![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-11.png)

 ![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-12.png)
 
5.	From the **Edit template** blade, load the template file **Labfiles\Module_03\Implement_and_Manage_Storage\az-100-02_azuredeploy.json**.
 
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-13.png)
 
>  **Note:** Review the content of the template and note that it defines deployment of an Azure VM hosting Windows Server 2016 Datacenter.

6.	Save the template and return to the **Custom deployment** blade.

7.	From the Custom deployment blade, navigate to the **Edit parameters** blade.
 
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-14.png)

8.	From the **Edit parameters** blade, load the parameters file **Labfiles\Module_03\Implement_and_Manage_Storage\az-100-02_azuredeploy.parameters.json**.
 
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-15.png)  

9.	Save the parameters and return to the **Custom deployment** blade.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-16.png)  
 
10.	From the **Custom deployment** blade, initiate a template deployment with the following settings:

-	Subscription: the name of the subscription you are using in this lab

-	Resource group: the name of a new resource group az1000201-RG

-	Location: the name of the Azure region which is closest to the lab location and where you can provision Azure VMs

-	Vm Size: Standard_DS2_v2

-	Vm Name: az1000201-vm1

-	Admin Username: Student

-	Admin Password: Password@1234

-	Virtual Network Name: az1000201-vnet
       
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-17.png)  
 
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-18.png) 

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-19.png) 

>  **Note:** To identify Azure regions where you can provision Azure VMs, refer to https://azure.microsoft.com/en-us/regions/offers/
Note: Do not wait for the deployment to complete but proceed to the next exercise. You will use the virtual machine **az1000201-vm1** in the second exercise of this lab.

>  **Result:** After you completed this exercise, you have initiated template deployment of an Azure VM **az1000201-vm1** that you will use in the second exercise of this lab.

## Exercise 1: Implement and use Azure Blob Storage

The main tasks for this exercise are as follows:
1.	Create Azure Storage accounts

2.	Review configuration settings of Azure Storage accounts

3.	Manage Azure Storage Blob Service

4.	Copy a container and blobs between Azure Storage accounts

5.	Use a Shared Access Signature (SAS) key to access a blob

### Task 1: Create Azure Storage accounts

1.	In the Azure portal, navigate to the **Create a resource** blade.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-20.png) 
 
2.	From the **Create a resource** blade, search Azure Marketplace for **Storage account**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-21.png) 
 
3.	Use the list of search results to navigate to the **Create storage account** blade.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-22.png) 
 
4.	From the **Create storage account** blade, create a new storage account with the following settings:

-	Subscription: the same subscription you selected in the previous task

-	Resource group: the name of a new resource group **az1000202-RG**

-	Storage account name: any valid, unique name between 3 and 24 characters consisting of lowercase letters and digits

-	Location: the name of the Azure region which you selected in the previous task

-	Performance: **Standard**

-	Account kind: **Storage (general purpose v1)**

-	Replication: **Locally-redundant storage (LRS)**

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-23.png)  

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-24.png) 

5.	 Click **Review + create**, and then click **Create**

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-25.png) 
 
6.	Do not wait for the storage account to be provisioned but proceed to the next step.

7.	In the Azure portal, navigate to the **Create a resource** blade.

8.	From the **Create a resource** blade, search Azure Marketplace for **Storage account**.

9.	Use the list of search results to navigate to the **Create storage account** blade.

10.	From the **Create storage account** blade, create a new storage account with the following settings:

-	Subscription: the same subscription you selected in the previous task

-	Resource group: the name of a new resource group **az1000203-RG**

-	Storage account name: any valid, unique name between 3 and 24 characters consisting of lowercase letters and digits

-	Location: the name of an Azure region different from the one you chose when creating the first storage account

-	Performance: **Standard**

-	Account kind: **StorageV2 (general purpose v2)**

-	Access tier: **Hot**

-	Replication: **Geo-redundant storage (GRS)**

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-26.png) 
 
11.	Click **Review + create**, then click **Create**.
 
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-27.png) 

12.	Wait for the storage account to be provisioned. This should take less than a minute.

### Task 2: Review configuration settings of Azure Storage accounts

1.	In Azure Portal, navigate to the blade of the first storage account you created.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-28.png)   

2.	With your storage account blade open, review the storage account configuration in the **Overview** section, including the performance, replication, and account kind settings.
 
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-29.png) 

3.	Display the **Access keys** blade. Note that you have the option of copying the values of storage account name, as well as the values of key1 and key2. You also have the option to regenerate each of the keys.
 
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-30.png) 

4.	Display the **Configuration** blade of the storage account.

5.	On the **Configuration** blade, note that you have the option of performing an upgrade to **General Purpose v2** account, enforcing secure transfer, and changing the replication settings to either **Geo-redundant storage (GRS)** or **Read-access geo-redundant storage (RA-GRS)**. However, you cannot change the performance setting (this setting can only be assigned when the storage account is created).

6.	Display the **Encryption** blade of the storage account. Note that encryption is enabled by default and that you have the option of using your own key.

>  **Note:** Do not change the configuration of the storage account.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-31.png)                             
7.	In Azure Portal, navigate to the blade of the second storage account you created.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-32.png) 
 
8.	With your storage account blade open, review the storage account configuration in the **Overview** section, including the performance, replication, and account kind settings.
 
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-33.png) 

9.	Display the **Configuration** blade of the storage account.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-34.png) 

10.	On the **Configuration** blade, note that you have the option of disabling the secure transfer requirement, setting the default access tier to **Cool**, and changing the replication settings to either **Locally-redundant storage (LRS)** or **Read-access geo-redundant storage (RA-GRS)**. In this case, you also cannot change the performance setting.

11.	Display the **Encryption** blade of the storage account. Note that in this case encryption is also enabled by default and that you have the option of using your own key.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-35.png) 


### Task 3: Manage Azure Storage Blob Service

1.	In the Azure portal, navigate to the **Blobs** blade of the first storage account.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-35.png) 
 
2.	From the **Blobs** blade of the first storage account, create a new container named **az1000202-container** with the **Public access level** set to **Private (no anonymous access)**.
 
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-36.png) 

3.	From the **az1000202-container** blade, upload **Labfiles\Module_03\Implement_and_Manage_Storage\az-100-02_azuredeploy.json and Labfiles\Module_03\Implement_and_Manage_Storage\az-100-02_azuredeploy.parameters.json** into the container.

>  **Note:** Take the raw of those two files from git hub and save with same name in your local machine.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-37.png) 

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-38.png) 

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-39.png) 

 
### Task 4: Copy a container and blobs between Azure Storage accounts

1.	From the Azure Portal, start a PowerShell session in the Cloud Shell pane.
 
 >  **Note:** If this is the first time you are launching the Cloud Shell in the current Azure  subscription, you will be asked to create an Azure file share to persist Cloud Shell files. If so, accept the defaults, which will result in creation of a storage account in an automatically generated resource group.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-40.png) 

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-41.png) 
    
2.	In the Cloud Shell pane, run the following commands:
  
$containerName = 'az1000202-container'
$storageAccount1Name = (Get-AzStorageAccount -ResourceGroupName 'az1000202-RG')[0].StorageAccountName
$storageAccount2Name = (Get-AzStorageAccount -ResourceGroupName 'az1000203-RG')[0].StorageAccountName
$storageAccount1Key1 = (Get-AzStorageAccountKey -ResourceGroupName 'az1000202-RG' -StorageAccountName $storageAccount1Name)[0].Value
$storageAccount2Key1 = (Get-AzStorageAccountKey -ResourceGroupName 'az1000203-RG' -StorageAccountName $storageAccount2Name)[0].Value
$context1 = New-AzStorageContext -StorageAccountName $storageAccount1Name -StorageAccountKey $storageAccount1Key1
$context2 = New-AzStorageContext -StorageAccountName $storageAccount2Name -StorageAccountKey $storageAccount2Key1
       
      
>  **Note:** These commands set the values of variables representing the names of the blob container containing the blobs you uploaded in the previous task, the two storage account, their corresponding keys, and the corresponding security context for each. You will use these values to generate a SAS token to copy blobs between storage accounts by using the AZCopy command line utility.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-42.png) 
 
3.	 In the Cloud Shell pane, run the following command:

New-AzStorageContainer -Name $containerName -Context $context2 -Permission Off

>  **Note:** This command creates a new container with the matching name in the second storage account

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-43.png)        

4.	In the Cloud Shell pane, run the following commands:

$containerToken1 = New-AzStorageContainerSASToken -Context $context1 -ExpiryTime(get-date).AddHours(24) -FullUri -Name $containerName -Permission rwdl
$containerToken2 = New-AzStorageContainerSASToken -Context $context2 -ExpiryTime(get-date).AddHours(24) -FullUri -Name $containerName -Permission rwdl

>  **Note:** These commands generate SAS keys that you will use in the next step to copy blobs between two containers.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-44.png) 
 
5.	In the Cloud Shell pane, run the following command:
        
     azcopy cp $containerToken1 $containerToken2 --recursive=true

>  **Note:** This command uses the AzCopy utility to copy the content of the container between the two storage accounts.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-45.png) 
      
6.	 Verify that the command returned the results confirming that the two files were transferred.

7.	Navigate to the **Blobs** blade of the second storage account and verify that it includes the entry representing the newly created **az1000202-container** and that the container includes two copied blobs.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-46.png)


### Task 5: Use a Shared Access Signature (SAS) key to access a blob

1.	From the **Blobs** blade of the second storage account, navigate to the container **az1000202-container**, and then open the **az-100-02_azuredeploy.json** blade.

2.	On the **az-100-02_azuredeploy.json** blade, copy the value of the **URL** property.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-47.png)
 
3.	Open another Microsoft Edge window and navigate to the URL you copied in the previous step.

>  **Note:** The browser will display the **ResourceNotFound**. This is expected since the container has the Public access level set to Private (no anonymous access).

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-48.png)

4.	On the **az-100-02_azuredeploy.json** blade, generate a shared access signature (SAS) and the corresponding URL with the following settings:

-	Permissions: **Read**

-	Start date/time: specify the current date/time in your current time zone

-	Expiry date/time: specify the date/time 24 hours ahead of the current time

-	Allowed IP addresses: leave blank

-	Allowed protocols: **HTTP**

-	Signing key: **Key 1**

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-49.png)
 
5.	On the **az-100-02_azuredeploy.json** blade, copy **Blob SAS URL**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-50.png)
 
6.	From the previously opened Microsoft Edge window, navigate to the URL you copied in the previous step.

>  **Note:** This time, you will be prompted whether you want to open or save **az-100-02_azuredeploy.json**. This is expected as well, since this time you are no longer accessing the container anonymously, but instead you are using the newly generated SAS key, which is valid for the next 24 hours.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-51.png)
 
7.	Close the Microsoft Edge window displaying the prompt.

>  **Result:** After you completed this exercise, you have created two Azure Storage accounts, reviewed their configuration settings, created a blob container, uploaded blobs into the container, copied the container and blobs between the storage accounts, and used a SAS key to access one of the blobs.

## Exercise 2: Implement and use Azure File Storage
 
The main tasks for this exercise are as follows:
1.	Create an Azure File Service share
2.	Map a drive to the Azure File Service share from an Azure VM

### Task 1: Create an Azure File Service share

1.	In the Azure portal, navigate to the blade displaying the properties of the second storage account you created in the previous exercise.

2.	From the storage account blade, display the properties of its File Service.

