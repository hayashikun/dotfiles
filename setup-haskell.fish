#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish

if not test -d $HOME/.ghcup
    set -x BOOTSTRAP_HASKELL_NONINTERACTIVE 1
    set -x BOOTSTRAP_HASKELL_INSTALL_HLS 1
    set -x BOOTSTRAP_HASKELL_INSTALL_STACK 1
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
end
fish_add_path ~/.ghcup/bin
fish_add_path ~/.cabal/bin
ghcup upgrade

