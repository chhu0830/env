#!/bin/sh
URL="https://raw.githubusercontent.com/chhu0830/env/master/config/apache2"
DIR="/etc/apache2/sites-available"

sudo cp $DIR/apache2.example $DIR/$1.conf
sudo sed -i "/ServerAdmin/a \  DocumentRoot `pwd`" $DIR/$1.conf
sudo sed -i "/ServerAdmin/a \  ServerName $2" $DIR/$1.conf
sudo sed -i "/ServerAdmin/a \  ServerAlias $1.$2" $DIR/$1.conf
sudo sed -i "s/error\.log/$1.error\.log/g" $DIR/$1.conf
sudo sed -i "s/access\.log/$1.access\.log/g" $DIR/$1.conf

sudo a2ensite $1
sudo service apache2 restart
