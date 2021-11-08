#!/bin/bash

set -e

DOTPATH=$HOME/.dotfiles

for file in ".vimrc" ".gitconfig"
do
  src="$DOTPATH/$file"
  ln -snfv $src $HOME
done

if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
  curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

