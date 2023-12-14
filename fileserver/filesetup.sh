yum install -y samba samba-client samba-common
systemctl enable smb.service
systemctl enable nmb.service
setsebool -P samba_enable_home_dirs 1
systemctl restart smb.service
mkdir /srv/fileshare
chcon -R -t samba_share_t /srv/fileshare

firewall-cmd --permanent --zone=project --add-service=samba
systemctl restart firewalld

cat >> /etc/samba/smb.conf << EOF
[fileshare]
path = /srv/fileshare
valid users = admin client webdev vagrant
read only = no
public = no
browsable = yes
EOF
