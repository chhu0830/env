#!/bin/sh

bash -c "$(curl https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh)"
zsh -c "source $HOME/.zshrc && nvm install v4.7.3"
sh -c "$(curl https://www.npmjs.com/install.sh)"
