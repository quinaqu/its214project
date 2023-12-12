yum install nginx -y
yum install policycoreutils-python -y
yum install vsftpd -y


#https://www.nginx.com/blog/using-nginx-plus-with-selinux/
#https://teamignition.us/selinux-practical-intro-to-audit2why-and-audit2allow.html
setsebool -P httpd_read_user_content 1
systemctl enable --now nginx

firewall-cmd --zone project --add-service http --permanent
firewall-cmd --zone project --add-service ftp --permanent
systemctl restart firewalld

systemctl start vsftpd
systemctl enable vsftpd
sed -i 's#anonymous_enable=YES#anonymous_enable=NO#' /etc/vsftpd/vsftpd.conf
sed -i 's/#chroot_list_enable=YES/chroot_list_enable=YES/' /etc/vsftpd/vsftpd.conf
sed -i 's:#xferlog_file=/var/log/xferlog:xferlog_file=/var/log/xferlog:' /etc/vsftpd/vsftpd.conf
sed -i '7,$d' /etc/vsftpd/user_list

echo "userlist_deny=NO">> /etc/vsftpd/vsftpd.conf
echo 'allow_writeable_chroot=YES' >> /etc/vsftpd/vsftpd.conf
echo "webdev" >> /etc/vsftpd/user_list
echo "webdev" > /etc/vsftpd/chroot_list
setsebool -P ftpd_full_access 1
systemctl restart vsftpd

mv -f its214project/webserver/{*.html,*.css} /usr/share/nginx/html/

#i looked at options for encrypting the passwords in the script but got lazy (and they're already exposed in the assignment)
groupadd webdevs
adduser webdev
sudo echo "4TheWeb!" | passwd "webdev" --stdin
chgrp -R webdevs /usr/share/nginx
chmod g+rwx /usr/share/nginx
usermod -d /usr/share/nginx webdev
usermod -aG webdevs webdev
