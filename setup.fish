#!/usr/bin/env fish

set NODE_VERSION "16.13.0"
set PYTHON_VERSION "3.9.7"


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


set DOT_PATH $HOME/.dotfiles
set CACHE_PATH $DOT_PATH/.cache

if not test -d $DOT_PATH
    if test $HTTPS_REPO
        set REPO_URL "https://github.com/hayashikun/dotfiles.git"
    else
        set REPO_URL "git@github.com:hayashikun/dotfiles.git"
    end
    git clone $REPO_URL $DOT_PATH
end

cd $DOT_PATH

set -e fish_user_paths[0..-1]

for file in (cat link_files)
  ln -snfv $DOT_PATH/$file $HOME/$file
end


if not test -d $CACHE_PATH
    mkdir $CACHE_PATH
end


# fisher
if not test -e $HOME/.config/fish/functions/fisher.fish
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
end
fisher update


# powerline
cd $CACHE_PATH
if not test -e $CACHE_PATH/font
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

pyenv install $PYTHON_VERSION -s


# rustup
if not type -q rustup
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
end

set -U fish_user_paths $HOME/.cargo/bin $fish_user_paths
rustup component add clippy rls rust-analysis rust-src rust-docs rustfmt
rustup update
cargo install bat exa


cd $CACHE_PATH
if not test -d $CACHE_PATH/rust-analyzer
    git clone https://github.com/rust-analyzer/rust-analyzer.git
end
cd rust-analyzer
git pull
cargo xtask install --server


# nodenv
if not test -d $HOME/.nodenv
    git clone https://github.com/nodenv/nodenv.git $HOME/.nodenv
end

cd $HOME/.nodenv
git pull
src/configure && make -C src

set -U fish_user_paths $HOME/.nodenv/bin $fish_user_paths

if not test -d $HOME/.nodenv/plugins/node-build
    git clone https://github.com/nodenv/node-build.git $HOME/.nodenv/plugins/node-build
end

if not test -d $HOME/.nodenv/plugins/node-build-update-defs
    git clone https://github.com/nodenv/node-build-update-defs.git $HOME/.nodenv/plugins/node-build-update-defs
end

nodenv install $NODE_VERSION -s
nodenv global $NODE_VERSION


# helix
if not test $SKIP_HELIX
    cd $CACHE_PATH
    if not test -d $CACHE_PATH/helix
        git clone --recurse-submodules --shallow-submodules -j8 https://github.com/helix-editor/helix
    end
    cd helix
    git pull --recurse-submodules
    cargo install --path helix-term
    set -Ux HELIX_RUNTIME $CACHE_PATH/helix/runtime
    cd $DOT_PATH
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

cd $DOT_PATH

exec fish
