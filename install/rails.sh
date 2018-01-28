curl -sSL https://rvm.io/mpapis.asc | gpg --import
curl -L https://get.rvm.io | bash -s stable --ruby

rvm get stable --autolibs=enable
rvm install ruby
source ~/.rvm/scripts/rvm
rvm --default use ruby-2.3.1

sudo apt install nodejs -y
gem install rails --no-ri --no-rdoc

sudo apt install libmysqlclient-dev
