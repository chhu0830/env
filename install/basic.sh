#/bin/sh
DIR="$PWD/config/basic"

sudo apt install -y git curl zsh vim tmux screen htop smbclient cifs-utils p7zip-full p7zip-rar iostat manpages-posix-dev glibc-doc

# git
ln -b -s $DIR/.gitconfig $HOME/.gitconfig

# ssh
mkdir ~/.ssh
cp $DIR/.ssh.conf $HOME/.ssh/config
sudo chmod 644 $HOME/.ssh/config

# zsh
sudo chsh -s /bin/zsh $USER
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s $DIR/rkj-repos-customize.zsh-theme $HOME/.oh-my-zsh/custom/themes/
ln -b -s $DIR/.zshrc $HOME/.zshrc
git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -b -s $DIR/.vimrc $HOME/.vimrc
vim +PlugInstall +qall
sudo apt install silversearcher-ag

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/
git clone https://github.com/Bosma/tmux-mem ~/.tmux/plugins/
ln -b -s $DIR/.tmux.conf $HOME/.tmux.conf
tmux source-file ~/.tmux.conf
