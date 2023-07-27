#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish
cd (dirname (status -f)) && source setup-asdf.fish

source-config

asdf plugin-add golang https://github.com/kennyp/asdf-golang.git

asdf install golang latest
asdf global golang latest

source-config

cd $DOT_PATH
for p in (cat go-packages)
    go install $p
end
