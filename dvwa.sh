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

sudo apt-get -y install apache2
sudo apt-get -y install php php-mysql
sudo apt-get install zip -y
export DEBIAN_FRONTEND=noninteractive
sudo -E apt-get -q -y install mysql-server
wget https://github.com/komalio/komali-test/raw/master/DVWA-master.zip
unzip DVWA-master.zip
sudo mv DVWA-master /var/www/html/dvwa
sudo chmod -R 755 /var/www/html/dvwa
sudo cp /var/www/html/dvwa/config/config.inc.php.dist /var/www/html/dvwa/config/config.inc.php
sudo apt-get update
sudo apt-get install php-gd -y
sudo service apache2 start
sudo service mysql start
sudo mysql -u root -e "create database dvwa";
sudo mysql -u root -e "create user DVWA";
sudo mysql -u root -e "grant all on dvwa.* to DVWA@localhost IDENTIFIED BY 'password'";
sudo mysql -u root -e "FLUSH PRIVILEGES";
sudo sed -i -e "s/allow_url_include = Off/allow_url_include = On/g" /etc/php/7.0/apache2/php.ini
sudo sed -i -e "s/root/DVWA/g" /var/www/html/dvwa/config/config.inc.php
sudo sed -i -e "s/p@ssw0rd/password/g" /var/www/html/dvwa/config/config.inc.php
sudo sed -i -e "s/public_key' ]  = ''/public_key' ]  = '6LfWsT4UAAAAAJgZBWzGlvN99BZtczIxaoxN5mep'/g" /var/www/html/dvwa/config/config.inc.php
sudo sed -i -e "s/private_key' ] = ''/private_key' ] = '6LfWsT4UAAAAAFqQN7PtbPMWhjG0-T5fwCytGRPZ'/g" /var/www/html/dvwa/config/config.inc.php
sudo chgrp www-data /var/www/html/dvwa/hackable/uploads
sudo chgrp www-data /var/www/html/dvwa/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt
sudo chgrp www-data /var/www/html/dvwa/config
sudo chmod g+w /var/www/html/dvwa/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt
sudo chmod g+w /var/www/html/dvwa/hackable/uploads
sudo chmod g+w /var/www/html/dvwa/config
sudo service apache2 restart
sudo service mysql start
