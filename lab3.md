# Module 3: Azure Storage

# Lab: Implement and Manage Storage

## Table of Contents

[Overview](#overview)

[Pre-requisites](#pre-requisites) 

[Login](#login) 

[Scenario& Objectives](#scenario& objectives) 

[Exercise 0: Prepare the lab environment](#exercise-0-prepare-the-lab-environment)

[Exercise 1: Implement and use Azure Blob Storage](#exercise-1:implement-and-use-azure-blob-storage)

[Exercise 2: Implement and use Azure File Storage](#exercise-2:prepare-the-lab-environment)

[Exercise 3: Remove lab resources](#exercise-3:remove-lab-resources)


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

* https://github.com/sysgain/qloudable-tl-labs/blob/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Allfiles/Labfiles/Module_03/Implement_and_
Manage_Storage/az-100-02_azuredeploy.json

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

1.	From the lab virtual machine, start Microsoft Edge, browse to the Azure portal at http://portal.azure.com and sign in by using a Microsoft account that has the Owner role in the Azure subscription you intend to use in this lab.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/MicrosoftLearnings/AZ-103-MicrosoftAzureAdministrator/Images/lab3/lab3-1.png)
