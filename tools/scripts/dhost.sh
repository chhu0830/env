#!/bin/sh
DIR="/etc/apache2/sites-available"

sudo a2dissite $1 > /dev/null 2>&1
sudo rm $DIR/$1.conf
sudo service apache2 restart
