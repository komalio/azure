#!/bin/bash
#Comment - Installs the required packages for building images

AZ_REPO=$(lsb_release -cs)
LOG="/tmp/install.log"
GIT_URL="$1"
GIT_PATH="/var/lib/waagent/custom-script/download/0/ProjectEdison"

#Installing Azure CLI
sudo apt-get install apt-transport-https lsb-release ca-certificates curl software-properties-common git -y
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

#Cloning your GIT Repository
git clone $1
if [ -d $GIT_PATH ]
then
        echo "------------------------------------" >> $LOG
        echo "The $GIT_PATH exist & clone successful" >> $LOG
        cd $GIT_PATH
        sudo docker-compose build

else
        echo "------------------------------------" >> $LOG
        echo "The $GIT_PATH doen't exist & clone failed" >> $LOG
fi
