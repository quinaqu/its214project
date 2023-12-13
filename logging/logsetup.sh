yum install -y httpd nagios nagios-plugins-all nagios-plugins-nrpe
systemctl enable --now nagios
systemctl enable --now httpd

adduser nagiosadmin
echo "testpass" | htpasswd "nagiosadmin" --stdin


declare -a client=("webserver" "database" "mailserver" "client" "fileserver")
declare -a address=("192.168.33.11" "192.168.33.12" "192.168.33.13" "192.168.33.14" "192.168.33.15")

for i in "${!client[@]}"
do
  echo "${address[i]}"
  echo "${client[i]}"
  echo "cfg_file=/etc/nagios/objects/${client[i]}.cfg" | sudo tee -a /etc/nagios/nagios.cfg
  cp /etc/nagios/objects/localhost.cfg /etc/nagios/objects/${client[i]}.cfg
  sudo sed -i "s/localhost/${client[i]}/g" /etc/nagios/objects/${client[i]}.cfg
  sudo sed -i "s/127.0.0.1/${address[i]}/g" /etc/nagios/objects/${client[i]}.cfg
  sudo sed -i "s/linux-servers/remote-vms/g" /etc/nagios/objects/${client[i]}.cfg
  sudo sed -i 's/check_local/check_nrpe!check_client/g' /etc/nagios/objects/${client[i]}.cfg
done

cat <<HERE | sudo tee -a /etc/nagios/objects/commands.cfg
define command{
command_name check_nrpe
command_line \$USER1\$/check_nrpe -H \$HOSTADDRESS\$ -c
\$ARG1\$
}
HERE
