#/bin/sh
DIR=$PWD/config/basic

sudo apt install -y git curl zsh vim tmux screen htop smbclient cifs-utils p7zip-full
# git
rm -f ~/.gitconfig
ln -s $DIR/.gitconfig ~/.gitconfig

# ssh
mkdir ~/.ssh
cp $DIR/.ssh.conf ~/.ssh/config
sudo chmod 644 ~/.ssh/config

# zsh
sudo chsh -s /bin/zsh $USER
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv ~/.oh-my-zsh/themes/rkj-repos.zsh-theme ~/.oh-my-zsh/themes/rkj-repos.zsh-theme.bak
ln -s $DIR/rkj-repos.zsh-theme ~/.oh-my-zsh/themes/
rm -f ~/.zshrc
ln -s $DIR/.zshrc ~/.zshrc
git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
rm -f ~/.vimrc
ln -s $DIR/.vimrc ~/.vimrc
vim +PlugInstall
sudo apt install silversearcher-ag

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
rm -f ~/.tmux.conf
ln -s $DIR/.tmux.conf ~/.tmux.conf
# tmux source ~/.tmux.conf

