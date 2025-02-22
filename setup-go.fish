#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish
cd (dirname (status -f)) && source setup-asdf.fish

source-config

asdf plugin add golang https://github.com/asdf-community/asdf-golang.git

asdf install golang latest
asdf set -u golang latest

source-config

cd $DOT_PATH
for p in (cat go-packages)
    go install $p
end
