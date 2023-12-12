sed -i 's:#myhostname = host.domain.tld:myhostname = final.vagrant.local:' /etc/postfix/main.cf
sed -i 's:#mydomain = domain.tld:mydomain = final.project:' /etc/postfix/main.cf
sed -i 's:#myorigin = $mydomain:myorigin = $mydomain:' /etc/postfix/main.cf
sed -i 's:#inet_interfaces = all:inet_interfaces = all:' /etc/postfix/main.cf
sed -i '#mynetworks = 168.100.189.0/28, 127.0.0.0/8:mynetworks = 192.168.33.11/24, 127.0.0.0/8:' /etc/postfix/main.cf
sed -i 's:#home_mailbox = Maildir/:home_mailbox = Maildir/:' /etc/postfix/main.cf
systemctl enable postfix
systemctl restart postfix
