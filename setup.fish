#!/usr/bin/env fish

for cmd in "git"
    if not type -q $cmd
        echo $cmd "is required."
        exit 1
    end
end


set DOTPATH $HOME/.dotfiles

if not test -d $DOTPATH
    git clone git@github.com:hayashikun/dotfiles.git $DOTPATH
end


set -e fish_user_paths[0..-1]

for file in ".vimrc" ".gitconfig" ".config/fish/config.fish" ".config/fish/fish_plugins"
  ln -snfv $DOTPATH/$file $HOME/$file
end


# fisher
if not test -e $HOME/.config/fish/functions/fisher.fish
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
end
fisher update


# vim-plug
if not test -e $HOME/.vim/autoload/plug.vim
  curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
end


# pyenv
if not test -d $HOME/.pyenv
    git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
end
set -x PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths


# cargo
if not type -q rustup
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
end

set -U fish_user_paths $HOME/.cargo/bin $fish_user_paths

rustup install stable
rustup update

cargo install bat exa

