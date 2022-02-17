#!/usr/bin/env fish

for a in $argv
    switch $a
        case "--https-repo"
            set HTTPS_REPO 1
        case "--skip-helix"
            set SKIP_HELIX 1
    end
end

for cmd in "git"
    if not type -q $cmd
        echo $cmd "is required."
        exit 1
    end
end


set DOTPATH $HOME/.dotfiles

if not test -d $DOTPATH
    if test $HTTPS_REPO
        set REPO_URL https://github.com/hayashikun/dotfiles.git
    else
        set REPO_URL git@github.com:hayashikun/dotfiles.git
    end
    git clone $URL $DOTPATH
end

cd $DOTPATH

set -e fish_user_paths[0..-1]

for file in (cat link_files)
  ln -snfv $DOTPATH/$file $HOME/$file
end

if not test -d $DOTPATH/.cache
    mkdir $DOTPATH/.cahce
end


# fisher
if not test -e $HOME/.config/fish/functions/fisher.fish
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
end
fisher update


# powerline
cd $DOTPATH/.cache
if not test -e $DOTPATH/.cache/font
    git clone https://github.com/powerline/fonts.git --depth=1
end
cd fonts
git pull
./install.sh


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


# rustup
if not type -q rustup
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
end

set -U fish_user_paths $HOME/.cargo/bin $fish_user_paths
rustup install stable
rustup update
cargo install bat exa


# nodenv
if not test -d $HOME/.nodenv
    git clone https://github.com/nodenv/nodenv.git $HOME/.nodenv
    cd $HOME/.nodenv && src/configure && make -C src
end

set -U fish_user_paths $HOME/.nodenv/bin $fish_user_paths

if not test -d $HOME/.nodenv/plugins/node-build
    git clone https://github.com/nodenv/node-build.git $HOME/.nodenv/plugins/node-build
end

if not test -d $HOME/.nodenv/plugins/node-build-update-defs
    git clone https://github.com/nodenv/node-build-update-defs.git $HOME/.nodenv/plugins/node-build-update-defs
end


# helix
if not test $SKIP_HELIX
    cd $DOTPATH/.cache
    if not test -d $DOTPATH/.cache/helix
        git clone --recurse-submodules --shallow-submodules -j8 https://github.com/helix-editor/helix
    end
    cd helix
    git pull --recurse-submodules
    cargo install --path helix-term
    set -Ux HELIX_RUNTIME $DOTPATH/.cache/helix/runtime
    cd $DOTPATH
end


# haskell
if not test -d $HOME/.ghcup
    set -x BOOTSTRAP_HASKELL_NONINTERACTIVE 1
    set -x BOOTSTRAP_HASKELL_INSTALL_HLS 1
    set -x BOOTSTRAP_HASKELL_INSTALL_STACK 1
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
end
set -U fish_user_paths ~/.ghcup/bin $fish_user_paths
set -U fish_user_paths ~/.cabal/bin $fish_user_paths
ghcup upgrade

cd $DOTPATH

exec fish
