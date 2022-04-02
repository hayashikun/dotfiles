#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish


for cmd in git curl
    if not type -q $cmd
        echo $cmd "is required."; exit 1
    end
end


if not test -d $DOT_PATH
    git clone git@github.com:hayashikun/dotfiles.git $DOT_PATH
end


set -e fish_user_paths[0..-1]


link-file \
    .vimrc \
    .vim/config/autocmd.vim \
    .vim/config/lsp.vim \
    .gitconfig \
    .config/fish/config.fish \
    .config/fish/fish_plugins \

source-config


# make chache dir
if not test -d $CACHE_PATH
    mkdir $CACHE_PATH
end


brew-install jq pwgen fzf gdb tree gcc cmake
apt-install xclip build-essential jq pwgen fzf gdb lldb tree vim

# fisher
if not test -e $HOME/.config/fish/functions/fisher.fish
    curl -sL https://git.io/fisher | source
end
fisher install (cat $DOT_PATH/.config/fish/fish_plugins)


# powerline
cd $CACHE_PATH
if not test -e $CACHE_PATH/font
    git clone https://github.com/powerline/fonts.git --depth=1
end
cd fonts && git pull && ./install.sh


# vim-plug
if not test -e $HOME/.vim/autoload/plug.vim
  curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
end


for target in python rust node go flutter
    cd $DOT_PATH && source setup-$target.fish
end

source-config

