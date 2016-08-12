#/bin/sh

cp env/.gitconfig ~/.gitconfig

chsh -s /bin/zsh
export LC_ALL=en_US.UTF-8

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
cp env/.zshrc ~/.zshrc
source ~/.zshrc

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp env/.vimrc ~/.vimrc
vim +PluginInstall +qall

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp env/.tmux.conf ~/.tmux.conf
tmux source ~/.tmux.conf

rm -rf env
