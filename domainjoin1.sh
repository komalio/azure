#!/bin/bash
hostname=$1
#Configure the hosts file
sudo sed -i -e "s/127.0.0.1 localhost/127.0.0.1 $1.bornonthecloud.in $1/g" /etc/hosts

#Install required packages
domainToJoin=$2
adusername=$3
adpassword=$4
domainUppercase=$5
sudo apt-get update
export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y install krb5-user samba sssd sssd-tools libnss-sss libpam-sss ntp ntpdate realmd adcli 

#Configure NTP
sudo -i
sudo echo "server $2" >> /etc/ntp.conf
sudo systemctl stop ntp
sudo ntpdate $2
sudo systemctl start ntp

# Join VM to the managed domain
sudo realm discover $5
echo $4 | kinit $3
sudo echo $4 | realm join --verbose $5 -U $3 --install=/

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
