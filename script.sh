#!/bin/bash
debconf-set-selections <<< 'mysql-server mysql-server/root_password password mysql@123'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password mysql@123'
apt-get -y install mysql-server mysql-client
