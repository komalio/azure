#!/bin/bash
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password komali@123'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password komali@123'
sudo apt-get -y install mysql-server mysql-client