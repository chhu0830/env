#!/bin/sh

# enumerate subdomains
# usage: knockpy <url>
git clone https://github.com/guelfoweb/knock.git ~/.knock
mv $HOME/.knock/knockpy/knockpy.py $HOME/.knock/knockpy/knockpy
sudo chmod +x $HOME/.knock/knockpy/knockpy

# web content scanner
# usage: dirb <url> /usr/share/dirb/wordlists/<wordlist>
wget -c 'http://sourceforge.net/projects/dirb/files/dirb/2.03/dirb203.tar.gz/download' -O dirb203.tar.gz
tar -zxvf dirb203.tar.gz
rm dirb203.tar.gz
cd dirb
sudo apt install -y libcurl4-gnutls-dev
./configure
make
sudo make install
cd ..
sudo mv -f dirb /usr/share/dirb

# web shell
# usage: weevely generate <passwd> <name-of-reverse-php>.php
# usage: weevely <url-of-reverse-php> <passwd>
sudo apt install -y build-essential python-pip libyaml-dev python-dev
sudo pip install --upgrade prettytable Mako PyYAML python-dateutil PySocks
git clone https://github.com/epinna/weevely3.git ~/.weevely
mv $HOME/.weevely/weevely.py $HOME/.weevely/weevely
sudo chmod +x ~/.weevely/weevely

# proxy
# usage: BurpSuitCommunity &
sudo apt install -y openjdk-8-jre
curl -fsSL https://raw.githubusercontent.com/chhu0830/env/master/install/burpsuite.sh > burpsuite.sh
sudo chmod +x burpsuite.sh
./burpsuite.sh
rm burpsuite.sh

# SQL injection vulnerability
# usage: sqlmap -u <url>
sudo apt install sqlmap

# BeEF
rvm install 2.3.0
rvm use 2.3.0
zsh -c "source .zshrc && gem install bundler"
git clone git://github.com/beefproject/beef.git
cd beef
bundle
cd ..
sudo chown -R root:root beef
sudo mv beef /opt/beef
