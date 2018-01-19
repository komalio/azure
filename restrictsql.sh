######################################################################################################################
#
#                               script to install Magento software on ubuntu VM
#
######################################################################################################################
#!/bin/bash
# Parameters
AZUREUSER=$1;
BASE_URL=$2
SCRIPTNAME=$3
HOMEDIR="/home/$AZUREUSER";
touch $HOMEDIR/config.log
CONFIG_LOG_FILE_PATH="$HOMEDIR/config.log";
echo "AZUREUSER=$1" >> $HOMEDIR/config.log
# Validate that all arguments are supplied
if [ $# -lt 5 ]; then echo "Insufficient parameters supplied. Exiting"; exit 1; fi

# Get the script for running as Azure user
cd "/home/$AZUREUSER"
sudo -u $AZUREUSER /bin/bash -c "wget -N ${BASE_URL}/scripts/${SCRIPTNAME}";
cat ${SCRIPTNAME} | tr -d '\r' > new${SCRIPTNAME}

# Initiate loop for error checking
for LOOPCOUNT in `seq 1 2`; do
    if [ "new$SCRIPTNAME" = "newmysql-script.sh" ]; then
       sudo -u $AZUREUSER /bin/bash /home/$AZUREUSER/newmysql-script.sh "$4" "$5" "$6" "$7" >> $CONFIG_LOG_FILE_PATH 2>&1;
    elif [ "new$SCRIPTNAME" = "newmagento-vmscript.sh" ]; then
       sudo -u $AZUREUSER /bin/bash /home/$AZUREUSER/newmagento-vmscript.sh "$4" "$5">> $CONFIG_LOG_FILE_PATH 2>&1;
    elif [ "new$SCRIPTNAME" = "newmagento-install.sh" ]; then
       sudo -u $AZUREUSER /bin/bash /home/$AZUREUSER/newmagento-install.sh "$4" "$5" "$6" "$7" "$8" "$9" "${10}" "${11}" "${12}" "${13}" >> $CONFIG_LOG_FILE_PATH 2>&1;
    else
      exit 1
    fi
    	
	if [ $? -ne 0 ]; then
		echo "Command failed on try $LOOPCOUNT, retrying..." >> $CONFIG_LOG_FILE_PATH;
		sleep 5;
		continue;
	else
		echo "======================================== Deployment Successful! ========================================" >> $CONFIG_LOG_FILE_PATH;
		exit 0;
	fi
done

echo "One or more commands failed after 2 tries. Deployment failed." >> $CONFIG_LOG_FILE_PATH;
exit 1
##Steps for Test Drive
apt-get install -y dos2unix 
mkdir /tmp/azurefiles

## Restricted Environment Setup
cp /bin/bash /bin/rbash 
usermod -s /bin/rbash $AZUREUSER
mkdir  -p /home/$AZUREUSER/programs
wget -O /tmp/azurefiles/bashprofile.txt https://s3.amazonaws.com/verticatestdrive/PredictiveMaint/bashprofile.txt

cat /tmp/azurefiles/bashprofile.txt | dos2unix | sudo tee /home/$AZUREUSER/.bash_profile

ln -s /usr/bin/mysql /home/$AZUREUSER/programs/
ln -s /usr/bin/sudo rm -rf  /home/$AZUREUSER/programs/
ln -s /usr/bin/sudo vim  /home/$AZUREUSER/programs/
ln -s /usr/bin/sudo /home/$AZUREUSER/programs/
ln -s /bin/systemctl /home/$AZUREUSER/programs/
ln -s /usr/bin/sudo vi /home/$AZUREUSER/programs/
chattr +i /home/$AZUREUSER/.bash_profile
