yum install epel-release -y
yum install nginx -y
yum install policycoreutils-python -y
yum install vsftpd -y
yum install git -y

#https://www.nginx.com/blog/using-nginx-plus-with-selinux/
#https://teamignition.us/selinux-practical-intro-to-audit2why-and-audit2allow.html
setsebool -P httpd_read_user_content 1
systemctl enable --now nginx

mv -f its214project/{*.html,*.css} /usr/share/nginx/html/

adduser webdev
echo "webdev:4TheWeb!" | chpasswd
