yum install centos-release-scl -y
yum install https://packages.icinga.com/epel/icinga-rpm-release-7-latest.noarch.rpm -y
yum install httpd icinga2 icinga2-ido-mysql nagios-plugins-all icinga2-selinux mariadb-server mariadb icingaweb2 icingacli icingaweb2-selinux rh-php71-php-mysqlnd -y
systemctl enable --now icinga2
systemctl enable --now mariadb
