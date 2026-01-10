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

link-file .gitconfig .config/git/ignore .config/fish/config.fish .config/fish/fish_plugins

source-config

# make chache dir
if not test -d $CACHE_PATH
    mkdir $CACHE_PATH
end


brew-install jq pwgen gdb tree gpg gh git-lfs
brew-cask-install font-jetbrains-mono iterm2 rectangle
apt-install xclip jq pwgen gdb lldb tree

# mise
if is-mac
    brew-install mise
else
    curl https://mise.run | sh
end


# fisher
if not test -e $HOME/.config/fish/functions/fisher.fish
    curl -sL https://git.io/fisher | source
end
fisher install (cat $DOT_PATH/.config/fish/fish_plugins)


source-config

