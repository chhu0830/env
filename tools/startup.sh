#!/usr/bin/zsh

sudo service ssh start
sudo service apache2 start
sudo service php7.0-fpm start
sudo service mysql start

sudo mkdir /var/run/screen
sudo chmod 777 /var/run/screen

# nvm use 8.1.4
