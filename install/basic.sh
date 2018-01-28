#/bin/sh
URL="https://raw.githubusercontent.com/chhu0830/env/master/config/basic"
DIR="$PWD/config/basic"

mkdir -p $DIR
sudo apt install -y git curl zsh vim tmux screen htop smbclient cifs-utils p7zip-full
# git
rm -f $HOME/.gitconfig
curl -fsSL $URL/.gitconfig > $DIR/.gitconfig
ln -s $DIR/.gitconfig $HOME/.gitconfig

# ssh
mkdir ~/.ssh
curl -fsSL $URL/.ssh.conf > $DIR/.ssh.conf
cp $DIR/.ssh.conf $HOME/.ssh/config
sudo chmod 644 $HOME/.ssh/config

# zsh
sudo chsh -s /bin/zsh $USER
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
curl -fsSL $URL/zsh-repos.zsh-theme > $DIR/zsh-repos.zsh-theme
mv $HOME/.oh-my-zsh/themes/rkj-repos.zsh-theme $HOME/.oh-my-zsh/themes/rkj-repos.zsh-theme.bak
ln -s $DIR/rkj-repos.zsh-theme $HOME/.oh-my-zsh/themes/
mv $HOME/.zshrc $HOME/.zshrc.bak
curl -fsSL $URL/.zshrc > $DIR/.zshrc
ln -s $DIR/.zshrc $HOME/.zshrc
git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mv $HOME/.vimrc $HOME/.vimrc.bak
curl -fsSL $URL/.vimrc > $DIR/.vimrc
ln -s $DIR/.vimrc ~/.vimrc
vim +PlugInstall
sudo apt install silversearcher-ag

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
curl -fsSL $URL/.tmux.conf > $DIR/.tmux.conf
mv $HOME/.tmux.conf $HOME/.tmux.conf.bak
ln -s $DIR/.tmux.conf $HOME/.tmux.conf
# tmux source ~/.tmux.conf

