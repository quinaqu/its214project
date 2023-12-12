yum install epel-release -y
yum install nginx -y
systemctl enable --now nginx
yum install vsftpd -y
mv -f its214project/{*.html,*.css} /usr/share/nginx/html/
adduser webdev
echo echo "webdev:4TheWeb!" | sudo chpasswd
