#!/bin/sh

sudo apt install traceroute default-jdk default-jre
sudo add-apt-repository ppa:wireshark-dev/stable
sudo apt update
sudo apt install wireshark-gtk
sudo adduser $USER wireshark

# Maltego
# https://www.paterva.com/web7/downloads.php
# sudo dpkg -i maltego

# enumerate subdomains
# Usage: cd /opt/knock/knockpy && ./knockpy.py <url>
git clone https://github.com/guelfoweb/knock.git knock
sudo chmod +x knock/knockpy/knockpy.py
sudo mv knock /opt/

# web content scanner
# Usage: dirb <url> /usr/share/dirb/wordlists/<wordlist>
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
# Usage: ./opt/weevely/weevely.py generate <passwd> <name-of-reverse-php>.php
# Usage: ./opt/weevely/weevely.py <url-of-reverse-php> <passwd>
sudo apt install -y build-essential python-pip libyaml-dev python-dev
sudo pip install --upgrade prettytable Mako PyYAML python-dateutil PySocks
git clone https://github.com/epinna/weevely3.git weevely
sudo chmod +x weevely/weevely.py
sudo mv weevly /opt/

# proxy
# Usage: ./opt/BurpSuiteCommunity/BurpSuiteCommunity &
sudo apt install -y openjdk-8-jre
curl -fsSL https://raw.githubusercontent.com/chhu0830/env/master/install/burpsuite.sh > burpsuite.sh
sudo chmod +x burpsuite.sh
./burpsuite.sh
rm burpsuite.sh
sudo mv BurpSuitCommunity /opt/

# SQL injection vulnerability
# Usage: sqlmap -u <url>
sudo apt install sqlmap

# BeEF
# Usage: cd /opt/beef && ./beef
zsh -c "source $HOME/.zshrc && rvm install 2.3.0"
zsh -c "source $HOME/.zshrc && rvm use 2.3.0 && gem install bundler"
git clone git://github.com/beefproject/beef.git
cd beef
zsh -c "source $HOME/.zshrc && rvm use 2.3.0 && bundle"
cd ..
sudo mv beef /opt/

# Veil - create backdoor
# Usage: cd /opt/Veil && ./Veil.py
sudo git clone https://github.com/Veil-Framework/Veil/ /opt/Veil
cd /opt/Veil/setup
sudo ./setup.py -c
cd -

# msfconsole
# Usage: msfconsole
sh -c "$(curl -fsSL https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb)"

# Tools for Brute Force
# Usage: crunch
# Ex: crunch 5 5 abcdefghijklmn -t a@@@n -o test.txt
# Usage: hydra
# Ex: hydra -l admin -P test.txt 192.168.1.73 http-post-form "/mutillidae/index.php?page=login.php:username=^USER^&password=^PASS^&login-php-submit-button=Login:Not Logged In"
sudo apt install crunch
git clone https://github.com/vanhauser-thc/thc-hydra
cd thc-hydra && zsh -c "./configure && make && sudo make install" && cd ..
rm -rf thc-hydra

# Tool for auto detect web vulnerability
# Usage: ./opt/zaproxy/zap.sh
wget https://github.com/zaproxy/zaproxy/releases/download/2.7.0/ZAP_2_7_0_unix.sh
sudo chmod +x ZAP_2_7_0_unix
sudo ./ZAP_2_7_0_unix.sh
rm ZAP_2_7_0_unix

# privoxy & tor
# default port is 8118 & 9050
sudo apt install privoxy tor
sudo service tor stop
sudo sed -i "\$aforward-socks4a / localhost:9050 ." /etc/privoxy/config

# DirBuster - Tool for Scan Directory
# Usage: java -jar /opt/DirBuster/DirBuster-1.0-RC1.jar
wget -O DirBuster.tar.bz2 "https://downloads.sourceforge.net/project/dirbuster/DirBuster%20%28jar%20%2B%20lists%29/1.0-RC1/DirBuster-1.0-RC1.tar.bz2?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fdirbuster%2Ffiles%2FDirBuster%2520%2528jar%2520%252B%2520lists%2529%2F1.0-RC1%2FDirBuster-1.0-RC1.tar.bz2%2Fdownload&ts=1522125805"
tar -xf DirBuster.tar.bz2
sudo mv DirBurster-1.0-RC1 /opt/DirBuster
rm DirBuster.tar.bz2

# DNSenum
# Usage: cd /opt/dnsenum && perl dnsenum.pl
git clone http://www.github.com/fwaeytens/dnsenum
sudo cpan Net::IP Net::DNS Net::Netmask String::Random XML::Writer
sudo mv dnsenum /opt/
