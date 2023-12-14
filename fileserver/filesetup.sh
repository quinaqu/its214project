yum install -y samba samba-client samba-common
systemctl enable smb.service
systemctl enable nmb.service
setsebool -P samba_enable_home_dirs 1
systemctl restart smb.service
mkdir /shares/fileshare
chcon -R -t samba_share_t /fileshare

firewall-cmd --permanent --zone=project --add-service=samba
systemctl restart firewalld

cat >> /etc/samba/smb.conf << EOF
[fileshare]
path = /fileshare
valid users = username
read only = no
EOF
