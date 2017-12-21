#!/bin/bash
username=ubuntu
pwd=gigamon@123
sudo usermod -l $username ubuntu
usermod -d /home/$username -m $username
echo -e "$pwd\n$pwd" | sudo passwd $username
file="/etc/ssh/sshd_config"
passwd_auth="yes"
cat $file \
| sed -e "s:\(PasswordAuthentication\).*:PasswordAuthentication $passwd_auth:" \
> $file.new
mv $file.new $file
service sshd restart

sudo wget http://apt-stable.ntop.org/16.04/all/apt-ntop-stable.deb
sudo dpkg -i apt-ntop-stable.deb
sudo apt-get clean all
sudo apt-get update
sudo apt-get install ntopng -y 

sudo sed -i -e "s/run/tmp/g" /etc/ntopng/ntopng.conf
sudo echo "-e=" >> /etc/ntopng/ntopng.conf
sudo echo "-i=2" >> /etc/ntopng/ntopng.conf
sudo echo "-w=3000" >> /etc/ntopng/ntopng.conf
sudo echo "-m=10.0.0.0/16" >> /etc/ntopng/ntopng.conf
sudo echo "-n=1" >> /etc/ntopng/ntopng.conf
sudo echo "-S=" >> /etc/ntopng/ntopng.conf
sudo echo "-d=/var/tmp/ntopng" >> /etc/ntopng/ntopng.conf
sudo echo "-q=" >> /etc/ntopng/ntopng.conf
sudo echo "-W=0" >> /etc/ntopng/ntopng.conf
sudo echo "-g=-1" >> /etc/ntopng/ntopng.conf
sudo touch /etc/ntopng/ntopng.start
sudo echo "--local-networks "10.0.0.0/16"" >> /etc/ntopng/ntopng.start
sudo echo "--interface 1" >> /etc/ntopng/ntopng.start

sudo apt-get update
sudo apt-get install firewalld -y
firewall-cmd --zone=public --add-port=3000/tcp --permanent
sudo firewall-cmd --reload
systemctl restart redis-server.service ;service ntopng restart
