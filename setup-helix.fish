#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish

cd $CACHE_PATH
if not test -d $CACHE_PATH/helix
    git clone --recurse-submodules --shallow-submodules -j8 https://github.com/helix-editor/helix
end
cd helix
git pull --recurse-submodules
cargo install --path helix-term
set -Ux HELIX_RUNTIME $CACHE_PATH/helix/runtime

set config_file .config/helix/config.toml
if not test -d $HOME/(dirname $config_file)
    mkdir -p $HOME/(dirname $config_file)
end
ln -snfv $DOT_PATH/$config_file $HOME/$config_file

cd $DOT_PATH
