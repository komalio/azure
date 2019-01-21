#!/bin/bash
#Comment - Updates the appsettings file for Edison Api code

#------------------------------------
COSMOSDBENDPOINT=$1
COSMOSDBKEY=$2
ADCLIENTID=$3
ADSECRET=$4
ADDOMAIN=$5
ADTENANTID=$6
B2CCLIENTID=$7
B2CDOMAIN=$8
B2CSIGNINPOLICY=$9
NOTIFICATIONHUBNAME=$10
NOTIFICATIONCONNSTRING=$11
SIGNALLRCONNSTRING=$12
RABBITMQUSER=$13
RABBITMQPWD=$14
SERVICEBUSCONNSTRING=$15
TWILIOUSER=$16
TWILIOPWD=$17
TWILIOACCID=$18
TWILIOAUTHTOKEN=$19
MSAPPID=$20
MSAPPPWD=$21
IOTHUBCONN=$22
#------------------------------------
GITPATH=`pwd`
GIT_DIRPATH="$GITPATH/ProjectEdison"
GIT_DIRCONFIGPATH="$GIT_DIRPATH/Edison.Web"
APPSET="appsettings.json"
APPSETDEV="appsettings.Development.json"
LOG="/tmp/appsettings.log.`date +%d%m%Y_%T`"
#------------------------------------
export COSMOSDBENDPOINT
export ADCLIENTID
export ADSECRET
export ADDOMAIN
export ADTENANTID
export B2CCLIENTID
export B2CDOMAIN
export B2CSIGNINPOLICY
export NOTIFICATIONHUBNAME
export TWILIOACCID
export SIGNALLRCONNSTRING
export COSMOSDBKEY 
export RABBITMQUSER 
export RABBITMQPWD 
export SERVICEBUSCONNSTRING 
export NOTIFICATIONCONNSTRING 
export TWILIOUSER 
export TWILIOPWD 
export TWILIOAUTHTOKEN
export MSAPPID
export MSAPPPWD
export IOTHUBCONN
#------------------------------------
apt install jq -y

ls $GIT_DIRPATH
if [ $? -eq 0 ]
then
        echo "------------------------------------" >> $LOG
        echo "The $GIT_DIRPATH exists" >> $LOG
        cd $GIT_DIRCONFIGPATH
        echo "------------------------------------" >> $LOG
        echo "Updating $APPSET with the values..." >> $LOG
        mv $GIT_DIRCONFIGPATH/Edison.Api/$APPSET $GIT_DIRCONFIGPATH/Edison.Api/$APPSET.bak
        cat $GIT_DIRCONFIGPATH/Edison.Api/$APPSET.bak | jq '.ServiceBusRabbitMQ.Username=env.RABBITMQUSER' | jq '.ServiceBusRabbitMQ.Password=env.RABBITMQPWD' | jq '.ServiceBusAzure.ConnectionString=env.SERVICEBUSCONNSTRING' | jq '.CosmosDb.AuthKey=env.COSMOSDBKEY' | jq '.CosmosDb.Endpoint=env.COSMOSDBENDPOINT' | jq '.SignalR.ConnectionString=env.SIGNALLRCONNSTRING' | jq '.Twilio.UserName=env.TWILIOUSER' | jq '.Twilio.Password=env.TWILIOPWD' | jq '.AzureAd.ClientId=env.ADCLIENTID' | jq '.AzureAd.Domain=env.ADDOMAIN' | jq '.AzureAd.TenantId=env.ADTENANTID' | jq '.AzureAdB2CWeb.ClientId=env.B2CCLIENTID' | jq '.AzureAdB2CWeb.Domain=env.B2CDOMAIN' | jq '.AzureAdB2CWeb.SignUpSignInPolicyId=env.B2CSIGNINPOLICY' | jq '.NotificationHub.PathName=env.NOTIFICATIONHUBNAME' |jq '.NotificationHub.ConnectionString=env.NOTIFICATIONCONNSTRING' | jq '.Twilio.AuthToken=env.TWILIOAUTHTOKEN' | jq '.Twilio.AccountSID=env.TWILIOACCID' > $GIT_DIRCONFIGPATH/Edison.Api/$APPSET
        echo "Updating $APPSETDEV with the values..." >> $LOG
        mv $GIT_DIRCONFIGPATH/Edison.Api/$APPSETDEV $GIT_DIRCONFIGPATH/Edison.Api/$APPSETDEV.bak
        cat $GIT_DIRCONFIGPATH/Edison.Api/$APPSETDEV.bak | jq '.SignalR.ConnectionString=env.SIGNALLRCONNSTRING' > $GIT_DIRCONFIGPATH/Edison.Api/$APPSETDEV
        echo "------------------------------------" >> $LOG 
        echo "Updating ChatService appsettings with the values..." >> $LOG
        mv $GIT_DIRCONFIGPATH/Edison.Microservices.ChatService/$APPSET $GIT_DIRCONFIGPATH/Edison.Microservices.ChatService/$APPSET.bak
          
        echo "------------------------------------" >> $LOG 
        echo "Updating DeviceSynchronizationService appsettings with the values..." >> $LOG
        mv $GIT_DIRCONFIGPATH/Edison.Microservices.DeviceSynchronizationService/$APPSET $GIT_DIRCONFIGPATH/Edison.Microservices.DeviceSynchronizationService/$APPSET.bak
        cat $GIT_DIRCONFIGPATH/Edison.Microservices.DeviceSynchronizationService/$APPSET.bak | jq '.ServiceBusRabbitMQ.Username=env.RABBITMQUSER' | jq '.ServiceBusRabbitMQ.Password=env.RABBITMQPWD' | jq '.AzureAd.TenantId=env.TENANTID' | jq '.ServiceBusAzure.ConnectionString=env.SERVICEBUSCONNSTRING' | jq '.AzureAd.ClientId=env.ADCLIENTID' | jq '.AzureAd.ClientSecret=env.ADSECRET' > $GIT_DIRCONFIGPATH/Edison.Microservices.DeviceSynchronizationService/$APPSET
        echo "------------------------------------" >> $LOG  
        echo "Updating EventProcessorService appsettings with the values..." >> $LOG
        mv $GIT_DIRCONFIGPATH/Edison.Microservices.EventProcessorService/$APPSET $GIT_DIRCONFIGPATH/Edison.Microservices.EventProcessorService/$APPSET.bak
        cat $GIT_DIRCONFIGPATH/Edison.Microservices.EventProcessorService/$APPSET.bak | jq '.ServiceBusRabbitMQ.Username=env.RABBITMQUSER' | jq '.ServiceBusRabbitMQ.Password=env.RABBITMQPWD' | jq '.AzureAd.TenantId=env.TENANTID' | jq '.ServiceBusAzure.ConnectionString=env.SERVICEBUSCONNSTRING' | jq '.AzureAd.ClientId=env.ADCLIENTID' | jq '.AzureAd.ClientSecret=env.ADSECRET' > $GIT_DIRCONFIGPATH/Edison.Microservices.EventProcessorService/$APPSET  
        echo "------------------------------------" >> $LOG  
        echo "Updating IoTHubControllerService appsettings with the values..." >> $LOG
        mv $GIT_DIRCONFIGPATH/Edison.Microservices.IoTHubControllerService/$APPSET $GIT_DIRCONFIGPATH/Edison.Microservices.IoTHubControllerService/$APPSET.bak
        cat $GIT_DIRCONFIGPATH/Edison.Microservices.IoTHubControllerService/$APPSET.bak | jq '.ServiceBusRabbitMQ.Username=env.RABBITMQUSER' | jq '.ServiceBusRabbitMQ.Password=env.RABBITMQPWD' | jq '.ServiceBusAzure.ConnectionString=env.SERVICEBUSCONNSTRING' | jq '.IoTHubController.IoTHubConnectionString=env.IOTHUBCONN' > $GIT_DIRCONFIGPATH/Edison.Microservices.IoTHubControllerService/$APPSET
        echo "------------------------------------" >> $LOG  
        echo "Updating MessageDispatcherService appsettings with the values..." >> $LOG
        mv $GIT_DIRCONFIGPATH/Edison.Microservices.MessageDispatcherService/$APPSET $GIT_DIRCONFIGPATH/Edison.Microservices.MessageDispatcherService/$APPSET.bak
        cat $GIT_DIRCONFIGPATH/Edison.Microservices.MessageDispatcherService/$APPSET.bak | jq '.ServiceBusRabbitMQ.Username=env.RABBITMQUSER' | jq '.ServiceBusRabbitMQ.Password=env.RABBITMQPWD' | jq '.ServiceBusAzure.ConnectionString=env.SERVICEBUSCONNSTRING' > $GIT_DIRCONFIGPATH/Edison.Microservices.MessageDispatcherService/$APPSET
        echo "------------------------------------" >> $LOG  
        echo "Updating NotificationHubService appsettings with the values..." >> $LOG
        mv $GIT_DIRCONFIGPATH/Edison.Microservices.NotificationHubService/$APPSET $GIT_DIRCONFIGPATH/Edison.Microservices.NotificationHubService/$APPSET.bak
        cat $GIT_DIRCONFIGPATH/Edison.Microservices.NotificationHubService/$APPSET.bak | jq '.ServiceBusRabbitMQ.Username=env.RABBITMQUSER' | jq '.ServiceBusRabbitMQ.Password=env.RABBITMQPWD' | jq '.ServiceBusAzure.ConnectionString=env.SERVICEBUSCONNSTRING' | jq '.AzureAd.ClientId=env.ADCLIENTID' | jq '.AzureAd.ClientSecret=env.ADSECRET' | jq '.AzureAd.TenantId=env.ADTENANTID' > $GIT_DIRCONFIGPATH/Edison.Microservices.NotificationHubService/$APPSET
        echo "------------------------------------" >> $LOG  
        echo "Updating ResponseService appsettings with the values..." >> $LOG
        mv $GIT_DIRCONFIGPATH/Edison.Microservices.ResponseService/$APPSET $GIT_DIRCONFIGPATH/Edison.Microservices.ResponseService/$APPSET.bak
        cat $GIT_DIRCONFIGPATH/Edison.Microservices.ResponseService/$APPSET.bak | jq '.ServiceBusRabbitMQ.Username=env.RABBITMQUSER' | jq '.ServiceBusRabbitMQ.Password=env.RABBITMQPWD' | jq '.ServiceBusAzure.ConnectionString=env.SERVICEBUSCONNSTRING' | jq '.AzureAd.ClientId=env.ADCLIENTID' | jq '.AzureAd.ClientSecret=env.ADSECRET' | jq '.AzureAd.TenantId=env.ADTENANTID' > $GIT_DIRCONFIGPATH/Edison.Microservices.ResponseService/$APPSET
        echo "------------------------------------" >> $LOG  
        echo "Updating SignalRService appsettings with the values..." >> $LOG
        mv $GIT_DIRCONFIGPATH/Edison.Microservices.SignalRService/$APPSET $GIT_DIRCONFIGPATH/Edison.Microservices.SignalRService/$APPSET.bak
        cat $GIT_DIRCONFIGPATH/Edison.Microservices.SignalRService/$APPSET.bak | jq '.ServiceBusRabbitMQ.Username=env.RABBITMQUSER' | jq '.ServiceBusRabbitMQ.Password=env.RABBITMQPWD' | jq '.ServiceBusAzure.ConnectionString=env.SERVICEBUSCONNSTRING' | jq '.AzureAd.ClientId=env.ADCLIENTID' | jq '.AzureAd.ClientSecret=env.ADSECRET' | jq '.AzureAd.TenantId=env.ADTENANTID' > $GIT_DIRCONFIGPATH/Edison.Microservices.SignalRService/$APPSET
        echo "------------------------------------" >> $LOG  
        echo "Updating Workflows appsettings with the values..." >> $LOG
        mv $GIT_DIRCONFIGPATH/Edison.Workflows/$APPSET $GIT_DIRCONFIGPATH/Edison.Workflows/$APPSET.bak
        cat $GIT_DIRCONFIGPATH/Edison.Workflows/$APPSET.bak | jq '.ServiceBusRabbitMQ.Username=env.RABBITMQUSER' | jq '.ServiceBusRabbitMQ.Password=env.RABBITMQPWD' | jq '.ServiceBusAzure.ConnectionString=env.SERVICEBUSCONNSTRING' | jq '.AzureAd.ClientId=env.ADCLIENTID' | jq '.AzureAd.ClientSecret=env.ADSECRET' | jq '.AzureAd.TenantId=env.ADTENANTID' > $GIT_DIRCONFIGPATH/Edison.Workflows/$APPSET
else
        echo "------------------------------------" >> $LOG
        echo "The $GIT_DIRPATH doesn't exists" >> $LOG
fi
