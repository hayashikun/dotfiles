#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish
cd (dirname (status -f)) && source setup-asdf.fish

source-config

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

asdf install nodejs latest
asdf global nodejs latest

source-config

cd $DOT_PATH
for p in (cat npm-packages)
    npm install $p
end

asdf reshim nodejs
