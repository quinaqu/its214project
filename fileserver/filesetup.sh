yum install -y samba samba-client samba-common
systemctl enable smb.service
systemctl enable nmb.service
setsebool -P samba_enable_home_dirs 1
systemctl restart smb.service
mkdir /fileshare
chcon -R -t samba_share_t /fileshare

firewall-cmd --permanent --zone=project --add-service=samba
systemctl restart firewalld

groupadd projectusers
chmod -R 770 /fileshare
useradd client
useradd vagrant
