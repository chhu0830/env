#/bin/sh

sudo apt-get install -y zsh vim tmux
# git
cp ./.gitconfig .gitconfig

# zsh
chsh -s /bin/zsh $USER
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
ln -s ./.zshrc .zshrc
source ~/.zshrc

# vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s ./.vimrc ~/.vimrc
vim +PluginInstall +qall

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s ./.tmux.conf ~/.tmux.conf
tmux source ~/.tmux.conf

rm -rf env
