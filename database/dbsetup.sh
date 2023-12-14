adduser dbdev 
echo "4TheDB!" | passwd "dbdev" --stdin

sudo yum install mariadb-server -y
sudo systemctl enable --now mariadb

sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | mysql_secure_installation
      # current root password (emtpy after installation)
    y # Set root password?
    test1234 # new root password
    test1234 # new root password
    y # Remove anonymous users?
    y # Disallow root login remotely?
    y # Remove test database and access to it?
    y # Reload privilege tables now?
EOF

mysql -uroot -ptest1234 -e "CREATE USER 'dbdev'@'localhost' IDENTIFIED BY 'projectfinal'; GRANT ALL PRIVILEGES ON *.* TO 'dbdev@localhost'; FLUSH PRIVILEGES;"

firewall-cmd --zone=project --add-port=1433/tcp --permanent
systemctl restart firewalld
