#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish


link-file .vimrc .vim/config/autocmd.vim .vim/config/lsp.vim

brew-install fzf
apt-install fzf vim

# vim-plug
if not test -e $HOME/.vim/autoload/plug.vim
  curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
end

