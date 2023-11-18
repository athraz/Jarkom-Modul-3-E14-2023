echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update && apt-get install mariadb-server -y
service mysql start
echo '#!/bin/bash

# MySQL connection parameters
MYSQL_USER="root"
MYSQL_PASSWORD=""
# MySQL commands
mysql -u$MYSQL_USER -p$MYSQL_PASSWORD <<EOF
CREATE USER '\''kelompokE14'\''@'\''%'\'' IDENTIFIED BY '\''passwordE14'\''; 
CREATE USER '\''kelompokE14'\''@'\''localhost'\'' IDENTIFIED BY '\''passwordE14'\''; 
CREATE DATABASE dbkelompokE14; 
GRANT ALL PRIVILEGES ON *.* TO '\''kelompokE14'\''@'\''%'\''; 
GRANT ALL PRIVILEGES ON *.* TO '\''kelompokE14'\''@'\''localhost'\''; 
FLUSH PRIVILEGES; 
EOF' > /run.sh
chmod +x /run.sh
./run.sh

echo '[mysqld]
skip-networking=0
skip-bind-address' >> /etc/mysql/my.cnf

service mysql restart

echo nameserver 192.213.1.2 > /etc/resolv.conf