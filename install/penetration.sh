#!/bin/sh

# enumerate subdomains
# usage: knockpy <url>
git clone https://github.com/guelfoweb/knock.git knock
mv knock/knockpy/knockpy.py knock/knockpy/knockpy
sudo chmod +x knock/knockpy/knockpy
sudo mv knock /opt/

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
git clone https://github.com/epinna/weevely3.git weevely
mv weevely/weevely.py weevely/weevely
sudo chmod +x ~/.weevely/weevely
sudo mv weevly /opt/

# proxy
# usage: BurpSuitCommunity &
sudo apt install -y openjdk-8-jre
curl -fsSL https://raw.githubusercontent.com/chhu0830/env/master/install/burpsuite.sh > burpsuite.sh
sudo chmod +x burpsuite.sh
./burpsuite.sh
rm burpsuite.sh
sudo mv BurpSuitCommunity /opt/

# SQL injection vulnerability
# usage: sqlmap -u <url>
sudo apt install sqlmap

# BeEF
# cd /opt/beef && ./beef
zsh -c "source $HOME/.zshrc && rvm install 2.3.0"
zsh -c "source $HOME/.zshrc && rvm use 2.3.0 && gem install bundler"
git clone git://github.com/beefproject/beef.git
cd beef
zsh -c "source $HOME/.zshrc && rvm use 2.3.0 && bundle"
cd ..
sudo mv beef /opt/

# Veil
sudo git clone https://github.com/Veil-Framework/Veil/ /opt/Veil
cd /opt/Veil/setup
sudo ./setup.py -c
cd -
