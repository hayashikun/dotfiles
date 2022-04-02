#!/usr/bin/env fish

set SKIP_OS_PKG false  # --skip-os-pkg

cd (dirname (status -f)) && source init.fish

function brew-install
    if not type -q brew
        echo "brew is required"; exit 1
    end
    brew upgrade && brew install (cat brew-packages)
end


function apt-install
    if not type -q apt
        echo "apt is required"; exit 1
    end
    sudo apt update && sudo apt upgrade -y && sudo apt install -y (cat apt-packages)
end

for a in $argv
    switch $a
        case "--skip-os-pkg"
            set SKIP_OS_PKG true
    end
end


for cmd in "git" "curl"
    if not type -q $cmd
        echo $cmd "is required."; exit 1
    end
end


if not test -d $DOT_PATH
    git clone "git@github.com:hayashikun/dotfiles.git" $DOT_PATH
end


set -e fish_user_paths[0..-1]


link-file \
    ".vimrc" \
    ".vim/config/autocmd.vim" \
    ".vim/config/lsp.vim" \
    ".gitconfig" \
    ".config/fish/config.fish" \
    ".config/fish/fish_plugins" \

source-config


# make chache dir
if not test -d $CACHE_PATH
    mkdir $CACHE_PATH
end


if not $SKIP_OS_PKG
    switch (uname -s)
        case "Darwin"
            brew-install
        case "Linux"
            apt-install
    end
end


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


for target in python rust node go
    cd $DOT_PATH && source setup-$target.fish
end

source-config

