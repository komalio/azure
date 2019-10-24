# Sending telemetry data to IoTHub using Node.js code

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Excercise-1: Create IoT Hub using Azure Portal](#excercise-1-create-iot-hub-using-azure-portal)

[Excercize-2: Create a device in IoT Hub](#Excercize-2-create-a-device-in-iot-hub)

[Excercize-3: Listen for direct method calls from IoT Hub](#Excercize-3-listen-for-direct-method-calls-from-iot-hub)


## Overview 

IoT Hub is an Azure service which allows to intake high volume of telemetry to cloud for storage or processing from IoT Devices. The direct method is used to control a simulated device and remotely change the behavior of a device connected to IoT Hub.

Here we use two node.js applications.

* Simulated device application

* Back-end device application

* The calls made from a back-end application through a direct method, will in turn be responded by a simulated device application. This application connects to a device-specific endpoint on IoT Hub for receiving the direct method calls.

* The direct method call is made by back-end application on the simulated device. The back-end application connects to service-side endpoint on IoT Hub for calling the direct method on a simulated device.

**Scenario and Objective**

*   Create a device in IoT Hub

*   Listen for direct method calls from IoT Hub

*   Call the direct method from device

## Pre-Requisites

*   Azure Portal access

>   **Note**: Azure Portal access is provided as part of the Lab environment

The two applications which we are using in the lab are written using Node.js, for which Node.js v4.x.x or later version is to be there on development machine.

The sample Node.js applications code can be downloaded from below link.

URL:https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/AppCode/azure-iot-samples-node-master.zip

## Excercise-1: Create IoT Hub using Azure Portal

### Task 1: IoT Hub Creation

1.	Go to the **Azure Portal** and provide your credentials for login.

From Lab computer, start Chrome, browse to http://portal.azure.com and, if prompted, sign in by using the Microsoft account that is the Service Administrator of your Azure subscription.

Using the Chrome browser, login into Azure portal with the below details.

```
Azure Username: {{ Azure Portal Username }}

Azure Password: {{ Azure Portal Password }}

```
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/1.png)

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/2.png)

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/3.png)

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/4.png)

2.	Click **+Create a resource**, then search for IoT Hub in search box of Marketplace and select the **IoT Hub** from the list.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/5.png)
Click **Create**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/6.png)

Then you will see the below screen, fill all the required fields.

```
Subscription: Select the default

Resource Group: {{ ResourceGroup }}

Region: {{ Location }}

IoTHub Name :Enter globally unique name for your IoT Hub. If the name you provided is available, then a green check mark will appear.

Click Next: Size and scale to proceed further with creating IoT hub.

```
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/7.png)

You can take the defaults by just clicking **Review + create** at the bottom.

**Pricing and scale tier:** You can select from different tiers depending on the features and messages you want to send through your solution per day. You can use free tier for testing and evaluation, which allows 500 devices to be connected to the IoT hub with the limit of 8,000 messages per day. For each Azure Subscription we can have only one free tier.

*Basic and Standard Tier:*

For IoT solution which require only Uni-directional communication from devices to the cloud, then you can use Basic Tier. Standard tier implements all the features, and it is for IoT solution which require bi-directional communication. Both tiers offer the same security and authentication features.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/8.png)

Click **Review + create**. 

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/9.png)

Click **Create**, which will take few minutes for IoT Hub creation.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/10.png)

After successful deployment you can see the Deployment succeeded notification as shown like below screen.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/11.png)

### Task 2: Open Cloud Shell

1. At the top of the portal, click the **Cloud Shell** icon to open a new shell instance.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/12.png)

 > **Note**: The **Cloud Shell** icon is a symbol that is constructed of the combination of the *greater than* and *underscore* characters.

2. If this is your first time opening the **Cloud Shell** using your subscription, you will see a wizard to configure **Cloud Shell** for first-time usage. When prompted, in the **Welcome to Azure Cloud Shell** pane, click **Bash (Linux)**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/13.png)

   > **Note**: If you do not see the configuration options for **Cloud Shell**, this is most likely because you are using an existing subscription with this course's labs. If so, proceed directly to the next task. 

3. In the **You have no storage mounted** pane, click **Show advanced settings**, perform the following tasks:

    - Leave the **Subscription** drop-down list entry set to its default value.

    - In the **Cloud Shell region** drop-down list, select the Azure region matching or near the location where you deployed resources in this lab.

    - In the **Resource group** section, select the **Use existing** option and then, in the drop-down list, select {{ ResourceGroup }}.

    - In the **Storage account** section, ensure that the **Create new** option is selected and then, in the text box below, type a unique name consisting of a combination of between 3 and 24 characters and digits. 

    - In the **File share** section, ensure that the **Create new** option is selected and then, in the text box below, type **cloudshell**.

    - Click the **Create storage** button.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/14.png)

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/15.png)

To verify the current version of Node.js, execute the below command.

***Command:*** `node –version`

!![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/16.png)

Microsoft Azure IoT Extension can be added to Azure CLI by executing the below command in the cloud Shell instance, which will add IoT Hub, IoT Edge, and IoT Device Provisioning Service specific commands to it.

***Command:*** `az extension add –name azure-cli-iot-ext`

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/17.png)


## Excercise-2: Create a device in IoT Hub

A device should be registered along with your IoT hub before it will connect. during this lab, you employ the Azure Cloud Shell to create a simulated device.

Run the below command in Azure Cloud Shell to create the device identity in your IoT Hub.

Replace IoT Hub in the below commands with the name you used for your IoT hub.

The name of the device you're creating in IoT Hub. Use device1 as given in the commands. If you decide on a special name for your device, you would like to use that name throughout the lab.

```
Syntax: `az iot hub device-identity create --hub-name <IoTHubName> --device-id <DotnetDeviceName>`

Ex: `az iot hub device-identity create --hub-name aziothubt1 --device-id device1`

```
>   ***Note:*** `if you want to change the device name(device1) then you also need to change in the sample application before you run it.`

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/18.png)

Run the below commands in Azure Cloud Shell to get the device connection string for the device you just created in IoT Hub.

```
Syntax: `az iot hub device-identity show-connection-string –hub-name <IoTHubName> --device-id <DotNetDeviceName> --output table`

Ex: `az iot hub device-identity show-connection-string --hub-name aziothub2504 --device-id device1 --output table`

```
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/19.png)

Note down the device connection string in notepad we will use it later.

you also want IoT Hub connection string to modify the back-end application to attach to your IoT hub and retrieve the messages. the subsequent command retrieves the connection string for your IoT hub.

```
Syntax: `az iot hub show-connection-string --name <IoTHubName> --output table`

Ex: `az iot hub show-connection-string --name aziothub2504 --output table`

```
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/20.png)

Note down the IoT Hub connection string, the IoT Hub connection string is totally different from the device connection string.

If you use any special device name instead of device1 you have to do the below changes in application code.

1. In your local system, navigate to the root folder of the sample node.js application which you downloaded and extract before.Go to that extract node.js application folder then navigate to the iot-hub\Quickstarts\back-end-application.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/21.png)

2. Click on that folder and open the BackEndApplication.cs file from text editior update the device1 with your device name in that file and save.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/22.png)

## Excercize-3: Listen for direct method calls from IoT Hub

The device-specific endpoint on IoT hub is connected by simulated device application, which sends simulated measuring and listens for direct method calls. The interval at which telemetry is sent by simulated device, can be changed by the direct method call from the IoT Hub and the simulated device responds back with an acknowledgement to IoT Hub once the direct method is executed.

From the command prompt, go to the root folder of the sample Node.js project, which we downloaded earlier. 

Now go to IoT Hub -> QuickStarts->simulated-device-2 folder.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/23.png)

Open “SimulatedDevice.js” file in any text editor from “simulated-device-2”

The **connectionString** variable value need to be changed with the device connection string, which we saved earlier and save the SimulatedDevice.js file.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/24.png)

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/25.png)

In the command prompt, navigate to the path of node.js application code 
“azure-iot-samples-node-master\azure-iot-samples-node-master\iot-hub\Quickstarts\simulated-device-2”. 

Execute the below commands to install the needed libraries and run the simulated device application.

```
Command: `npm install`
```

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/26.png)

```
Command: `node SimulatedDevice.js`
```
The simulated device application sends telemetry to IoT Hub as shown in below screen.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/nodejsiotlab/17.png)

>   ***Note:*** *Run the back-end-application simultaneously while sending data to simulated-device-2.*
