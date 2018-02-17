#!/bin/sh

# enumerate subdomains
# usage: knockpy <url>
git clone https://github.com/guelfoweb/knock.git knock
sudo chmod +x knock/knockpy/knockpy.py
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
sudo chmod +x weevely/weevely.py
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

# Veil - create backdoor
# usage: cd /opt/Veil && ./Veil.py
sudo git clone https://github.com/Veil-Framework/Veil/ /opt/Veil
cd /opt/Veil/setup
sudo ./setup.py -c
cd -

# msfconsole
sh -c "$(curl -fsSL https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb)"

# Tools for Brute Force
sudo apt install crunch
git clone https://github.com/vanhauser-thc/thc-hydra
cd thc-hydra && zsh -c "./configure && make && sudo make install" && cd ..
rm -rf thc-hydra

# Tool for auto detect web vulnerability
wget https://github.com/zaproxy/zaproxy/releases/download/2.7.0/ZAP_2_7_0_unix.sh
sudo chmod +x ZAP_2_7_0_unix
sudo ./ZAP_2_7_0_unix.sh
rm ZAP_2_7_0_unix
