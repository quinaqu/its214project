yum install postfix dovecot mailx -y

systemctl enable postfix

sed -i 's:#myhostname = host.domain.tld:myhostname = mail.final.local:' /etc/postfix/main.cf
sed -i 's:#mydomain = domain.tld:mydomain = final.local:' /etc/postfix/main.cf
sed -i 's:#myorigin = $mydomain:myorigin = $mydomain:' /etc/postfix/main.cf
sed -i 's:#inet_interfaces = all:inet_interfaces = all:' /etc/postfix/main.cf
sed -i 's:#mynetworks = 168.100.189.0/28, 127.0.0.0/8:mynetworks = 192.168.33.11/24, 127.0.0.0/8:' /etc/postfix/main.cf
sed -i 's:#home_mailbox = Maildir/:home_mailbox = Maildir/:' /etc/postfix/main.cf
sed -i 's:#myorigin = $myhostname:myorigin = $myhostname:' /etc/postfix/main.cf
sed -i 's:mydestination = $myhostname, localhost.$mydomain, localhost:mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain:' /etc/postfix/main.cf
sed -i 's:#relay_domains = $mydestination:relay_domains = :' /etc/postfix/main.cf

sed -i 's:#protocols = imap pop3 lmtp:protocols = imap imaps pop3 pop3s:' /etc/dovecot/dovecot.conf
echo "mail_location = maildir:~/Maildir" >> /etc/dovecot/dovecot.conf
echo "pop3_uidl_format = %08Xu%08Xv" >> /etc/dovecot/dovecot.conf

chkconfig --level 345 dovecot on
systemctl enable --now dovecot
systemctl enable --now postfix
systemctl restart postfix
