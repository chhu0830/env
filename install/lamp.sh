#!/bin/sh
URL="https://raw.githubusercontent.com/chu0830/env/master/config/apache2"
DIR=$PWD/config/apache2

sudo apt install -y apache2 php libapache2-mod-php
curl -fsSL $URL/apache2.example > $DIR/apache2.example
sudo cp $DIR/apache2.example /etc/apache2/sites-available/
sudo service apache2 restart
sudo apt install -y mysql-server php-mysql phpmyadmin
