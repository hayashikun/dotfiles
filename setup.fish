#!/usr/bin/env fish

for cmd in git curl
    if not type -q $cmd
        echo $cmd "is required."; exit 1
    end
end

set DOT_PATH $HOME/.dotfiles

if not test -d $DOT_PATH
    git clone git@github.com:hayashikun/dotfiles.git $DOT_PATH
end

cd $DOT_PATH

source init.fish

set -e fish_user_paths[0..-1]

link-file .gitconfig .config/git/ignore .config/fish/config.fish .config/fish/fish_plugins .config/fish-ai.ini

source-config

# make chache dir
if not test -d $CACHE_PATH
    mkdir $CACHE_PATH
end


brew-install jq pwgen gdb tree gpg gh git-lfs
apt-install xclip jq pwgen gdb lldb tree

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


# target
set TARGETS vim python rust node go
if test -f $DOT_PATH/.target
    set TARGETS (cat $DOT_PATH/.target)
end

for t in $TARGETS
    cd $DOT_PATH && source setup-$t.fish
end

source-config

