#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish

set NODE_VERSION "16.13.0"

apt-install build-essential

if not test -d $HOME/.nodenv
    git clone https://github.com/nodenv/nodenv.git $HOME/.nodenv
end
cd $HOME/.nodenv && git pull && src/configure && make -C src

fish_add_path $HOME/.nodenv/bin
source-config

if not test -d $HOME/.nodenv/plugins/node-build
    git clone https://github.com/nodenv/node-build.git $HOME/.nodenv/plugins/node-build
end
cd $HOME/.nodenv/plugins/node-build && git pull

if not test -d $HOME/.nodenv/plugins/node-build-update-defs
    git clone https://github.com/nodenv/node-build-update-defs.git $HOME/.nodenv/plugins/node-build-update-defs
end
cd $HOME/.nodenv/plugins/node-build-update-defs && git pull

nodenv install $NODE_VERSION -s && nodenv global $NODE_VERSION

cd $DOT_PATH
for p in (cat npm-packages)
    if test -n $p
        npm install -g $p
    end
end

