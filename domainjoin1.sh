#!/bin/bash
hostname=$1
domainToJoin=$2
adusername=$3
adpassword=$4
domainUppercase=$5
ouPath=$6

echo "ouPath" >> $LOG
#Configure the hosts file
sudo sed -i -e "s/127.0.0.1 localhost/127.0.0.1 $hostname.$domainToJoin $hostname/g" /etc/hosts 
#Install required packages
sudo apt-get update
export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y install krb5-user samba sssd sssd-tools libnss-sss libpam-sss ntp ntpdate realmd adcli 
#Configure NTP
sudo -i
sudo echo "server $domainToJoin" >> /etc/ntp.conf
sudo systemctl stop ntp
sudo ntpdate $domainToJoin
sudo systemctl start ntp
# Join VM to the managed domain
sudo realm discover $domainUppercase
echo $adpassword | kinit $adusername
sudo -i
sudo echo $adpassword | realm join --verbose $domainUppercase -U $adusername --computer-ou="OU=advmsOU;DC=bornonthecloud;DC=in" --install=/ >> $LOG
#Update the SSSD configuration
sudo sed -i -e "s/use_fully_qualified_names = True/# use_fully_qualified_names = True/g" /etc/sssd/sssd.conf
sudo systemctl restart sssd
# Allow password authentication for SSH
#sudo sed -i -e "s/PasswordAuthentication /PasswordAuthentication yes/g" /etc/ssh/sshd_config
#Configure automatic home directory creation
sudo echo "session required pam_mkhomedir.so skel=/etc/skel/ umask=0077" >>/etc/pam.d/common-session
#Grant the 'AAD DC Administrators' group sudo privileges
sudo echo "# Add 'AAD DC Administrators' group members as admins" >> /etc/sudoers
sudo echo "%AAD\ DC\ Administrators ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
#signin check
#ssh -l komali@BORNONTHECLOUD.IN adtestvm.bornonthecloud.in


#sudo echo 'Qwerty#12345' | realm join --verbose BORNONTHECLOUD.IN -U 'komali@BORNONTHECLOUD.IN' --computer-ou 'OU=advmsOU;DC=bornonthecloud;DC=in'
