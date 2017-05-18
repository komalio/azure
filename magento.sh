sudo sed -i "s/127.0.0.1/\*/" "/etc/mysql/mysql.conf.d/mysqld.cnf"
service mysql restart
sleep 15

# create random password
DBUSER=$1
PASSWDDB=$2
# replace "-" with "_" for database username

#mysql -uroot -pmsr@123123 -e "CREATE DATABASE ${DBUSER} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
mysql -uroot -pmsr@123123 -e "CREATE USER ${DBUSER} IDENTIFIED BY '${PASSWDDB}';"
