#!/usr/bin/env fish


set DOT_PATH $HOME/.dotfiles
set CACHE_PATH $DOT_PATH/.cache

cd $CACHE_PATH
if not test -d $CACHE_PATH/helix
    git clone --recurse-submodules --shallow-submodules -j8 https://github.com/helix-editor/helix
end
cd helix
git pull --recurse-submodules
cargo install --path helix-term
set -Ux HELIX_RUNTIME $CACHE_PATH/helix/runtime
cd $DOT_PATH
