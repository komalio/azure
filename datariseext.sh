#!/bin/bash

datasunrise_pass=$1
pg_pass=$2

#configure firewall
echo '<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>datasunrise</short>
  <description>DataSunrise Web Interface.</description>
  <port protocol="tcp" port="11000"/>
  <port protocol="tcp" port="5432"/>
  <port protocol="tcp" port="54321"/>
</service>' >> /usr/lib/firewalld/services/datasunrise.xml
sed 's/ssh"\/>/ssh"\/>\n  <service name="datasunrise"\/>/' /usr/lib/firewalld/zones/public.xml -i
sed 's/ssh"\/>/ssh"\/>\n  <service name="datasunrise"\/>/' /etc/firewalld/zones/public.xml -i
firewall-cmd --reload

#update and install soft
#yum update -y
yum install unixODBC mysql-connector-odbc.x86_64 postgresql-odbc.x86_64 java postgresql-server -y
wget https://update.datasunrise.com/get-last-datasunrise?cloud=azure -O /tmp/datasunrise.run
chmod +x /tmp/datasunrise.run
/tmp/datasunrise.run install -f
rm -f /tmp/datasunrise.run


#configure postgres
#mkdir /usr/local/pgsql
#chown postgres:postgres /usr/local/pgsql
#su postgres -c "initdb -D /usr/local/pgsql/data -U postgres"
#awk 'BEGIN {OFS="\t"} {if ($1 != "#" && NF > 0 && NF > 4) {$5 = "md5"; print} else {print}}' /usr/local/pgsql/data/pg_hba.conf > /tmp/pg_hba.conf
#echo 'port = 54321' >> /usr/local/pgsql/data/postgresql.conf
#echo 'log_connections = on' >> /usr/local/pgsql/data/postgresql.conf
#echo 'log_disconnections = on' >> /usr/local/pgsql/data/postgresql.conf
#echo 'log_error_verbosity = verbose' >> /usr/local/pgsql/data/postgresql.conf
#echo 'log_line_prefix = \'%t: \'' >> /usr/local/pgsql/data/postgresql.conf 
#echo 'log_statement = \'all\'' >> /usr/local/pgsql/data/postgresql.conf 

#mv /tmp/pg_hba.conf  /usr/local/pgsql/data/pg_hba.conf
#chown posgres:postgres /usr/local/pgsql/data/pg_hba.conf
#su postgres -c "pg_ctl start -D /usr/local/pgsql/data/ -l /usr/local/pgsql/data/postgresql.log -c"

# create custom systemd script with overriden port
#rm /etc/systemd/system/postgresql.service
echo '.include /usr/lib/systemd/system/postgresql.service' > /etc/systemd/system/postgresql.service
echo '[Service]' >> /etc/systemd/system/postgresql.service
echo 'Environment=PGPORT=54321' >> /etc/systemd/system/postgresql.service
# init database & start service
rm -rf  /var/lib/pgsql/data/*
postgresql-setup initdb
# save old pg_hba.conf
mv /var/lib/pgsql/data/pg_hba.conf /var/lib/pgsql/data/pg_hba.conf.example
# create new pg_hba.conf
echo '# TYPE  DATABASE        USER            ADDRESS                 METHOD' > /var/lib/pgsql/data/pg_hba.conf
echo 'local   all             all                                     trust' >> /var/lib/pgsql/data/pg_hba.conf
echo 'host    all             all             127.0.0.1/32            md5' >> /var/lib/pgsql/data/pg_hba.conf
echo 'host    all             all             ::1/128                 md5' >> /var/lib/pgsql/data/pg_hba.conf

# init database & start service 
#postgresql-setup initdb
#service postgresql start
systemctl enable postgresql.service
systemctl start postgresql.service

#set license
#curl http://95.211.162.209:9000/generateKey?customer=AzureTestDrive\;os=OS_LINUX  > /opt/datasunrise/appfirewall.reg
# workaround for quick fix
echo 'N76T6hP3Uv6xdupalJ7oivb1Yf7g9lOi2Vc89cu4sJjZXWmprC5HLyV0r5VDdMsk7nMcNs7bTRjAOL41j4FNMw==:0:AzureTestDrive' > /opt/datasunrise/appfirewall.reg

#set datasunrise password
cd /opt/datasunrise
/opt/datasunrise/AppBackendService SET_ADMIN_PASSWORD=$datasunrise_pass
service datasunrise restart

#configure datasunrise for postgres
AF_STATE_DIR=/tmp
cd /opt/datasunrise/cmdline
chmod +x executecommand.sh
./executecommand.sh connect -host 127.0.0.1 -password "$datasunrise_pass" -login admin
psql -p 54321 postgres postgres -c "ALTER USER postgres WITH PASSWORD '$pg_pass';"
./executecommand.sh addInstancePlus -name PostgresTestDb -dbType postgresql -dbHost 127.0.0.1 -dbPort 54321 -database postgres  -login postgres -password "$pg_pass" -proxyHost 0.0.0.0 -proxyPort 5432
./executecommand.sh addRule -action audit -name AuditRuleAdmin -logData true -filterType ddl -ddlSelectAll true
./executecommand.sh addRule -action audit -name AuditRuleDML -logData true

exit 0