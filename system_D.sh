#! /bin/bash
##################################################
################ Написать service ################
##################################################
cp /vagrant/watchlog.log /var/log/
cp /vagrant/watchlog /etc/default/
cp /vagrant/watchlog.sh /opt/
chmod +x /opt/watchlog.sh
cp /vagrant/watchlog.service /etc/systemd/system/
cp /vagrant/watchlog.timer /etc/systemd/system/
systemctl start watchlog.timer

##################################################
############# Установить spawn-fcgi ##############
##################################################
apt update && apt install net-tools spawn-fcgi php php-cgi php-cli apache2 libapache2-mod-fcgid -y
mkdir /etc/spawn-fcgi/
cp /vagrant/fcgi.conf /etc/spawn-fcgi/
cp /vagrant/spawn-fcgi.service /etc/systemd/system/
systemctl enable --now spawn-fcgi

##################################################
################ unit-файл Nginx #################
##################################################
apt install nginx -y
systemctl stop nginx
cp /vagrant/default /etc/nginx/sites-available/ 
cp /vagrant/nginx@.service /etc/systemd/system/
cp /vagrant/nginx-first.conf /etc/nginx/
cp /vagrant/nginx-second.conf /etc/nginx/
systemctl daemon-reload
systemctl start nginx nginx@first nginx@second