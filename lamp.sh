#!/bin/sh

sudo apt install -y apache2 php libapache2-mod-php
sudo service apache2 restart
sudo apt install -y mysql-server php-mysql phpmyadmin
