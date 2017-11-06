#/bin/sh

sudo apt-get update
sudo apt-get install -y git curl zsh vim tmux
# git
rm -f ~/.gitconfig
ln -s $PWD/.gitconfig ~/.gitconfig

# ssh
mkdir ~/.ssh
ln -s $PWD/.ssh.conf ~/.ssh/config

# zsh
chsh -s /bin/zsh $USER
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv ~/.oh-my-zsh/themes/rkj-repos.zsh-theme ~/.oh-my-zsh/themes/rkj-repos.zsh-theme.bak
ln -s $PWD/rkj-repos.zsh-theme ~/.oh-my-zsh/themes/
rm -f ~/.zshrc
ln -s $PWD/.zshrc ~/.zshrc
git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
rm -f ~/.vimrc
ln -s $PWD/.vimrc ~/.vimrc
vim +PluginInstall +qall

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
rm -f ~/.tmux.conf
ln -s $PWD/.tmux.conf ~/.tmux.conf
tmux source ~/.tmux.conf

