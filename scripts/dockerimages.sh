#!/bin/bash
#Comment - Installs the required packages for building images
#Author - Komali and gang

AZ_REPO=$(lsb_release -cs)
LOG="/tmp/install.log.`date +%d%m%Y_%T`"
GIT_URL="$1"
ACR_SRVNAME="$2"
ACR_USERNAME="$3"
ACR_PASSWD="$4"
TAG="$5"
GIT_PATH=`pwd`

#Installing Azure CLI
sudo apt-get install apt-transport-https lsb-release ca-certificates curl software-properties-common gnupg2 pass -y
sleep 10
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key --keyring /etc/apt/trusted.gpg.d/Microsoft.gpg adv --keyserver packages.microsoft.com --recv-keys BC528686B50D79E339D3721CEB3E94ADBE1229CF
sudo apt-get update
sleep 10
sudo apt-get install azure-cli
sleep 10
az -v
if [ $? -eq 0 ]
then
        echo "------------------------------------" >> $LOG
        echo "Azure CLI installation is successful" >> $LOG
else
        echo "------------------------------------" >> $LOG
        echo "Azure CLI installation failed" >> $LOG
fi

#Installing Docker CE & Compose

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sleep 10
sudo apt-get install docker-ce docker-compose -y
sleep 10
docker -v
if [ $? -eq 0 ]
then
        echo "------------------------------------" >> $LOG
        echo "Docker CE installation is successful" >> $LOG
else
        echo "------------------------------------" >> $LOG
        echo "Docker CE installation failed" >> $LOG
fi

#Initialize Docker Swarn

sudo docker swarm init

#Installing kubectl

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
kubectl version
 
if [ $? -eq 0 ]
then
echo "------------------------------------" >> $LOG
echo "kubectl installation is successful" >> $LOG
else
echo "------------------------------------" >> $LOG
echo "kubectl installation failed" >> $LOG
fi

#Cloning your GIT Repository

git clone $GIT_URL
if [ -d $GIT_PATH ]
then
        echo "------------------------------------" >> $LOG
        echo "The $GIT_PATH exist & clone successful" >> $LOG
        cd $GIT_PATH/ProjectEdison
        sudo docker-compose build

else
        echo "------------------------------------" >> $LOG
        echo "The $GIT_PATH doen't exist & clone failed" >> $LOG
fi

#Checking for Edison images

        IMAGE=`docker images edison* --format "{{.Repository}}" | wc -l`
        
        if [ $IMAGE -eq 11 ]
        then
            echo "------------------------------------" >> $LOG
            echo "All the 11 Edison Images are successfully built" >> $LOG
            echo "$ACR_PASSWD" | docker login $ACR_SRVNAME -u $ACR_USERNAME --password-stdin >> $LOG
           IMAGE_NAMES=`docker images edison* --format "{{.Repository}}"`
                for i in $IMAGE_NAMES 
                    do  
                        echo "------------------------------------" >> $LOG
                        echo "$i" >> $LOG
                        docker tag $i $ACR_SRVNAME/$i:$TAG
                        docker push $ACR_SRVNAME/$i:$TAG
                        echo "The Image $i is successfully pushed"
                    done      
        else 
            echo "Edison Images didn't built" >>  $LOG
        fi

