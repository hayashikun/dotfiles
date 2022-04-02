#!/usr/bin/env fish

source common.fish


cd $CACHE_PATH
if not test -d $CACHE_PATH/helix
    git clone --recurse-submodules --shallow-submodules -j8 https://github.com/helix-editor/helix
end
cd helix
git pull --recurse-submodules
cargo install --path helix-term
set -Ux HELIX_RUNTIME $CACHE_PATH/helix/runtime
cd $DOT_PATH
