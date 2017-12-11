#!/bin/sh

sudo apt-get install -y apache2 php libapache2-mod-php
sudo service apache2 restart
sudo apt-get install -y mysql-server php-mysql phpmyadmin
