#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish
cd (dirname (status -f)) && source setup-asdf.fish

source-config

asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git

asdf install terraform latest
asdf global terraform latest

source-config

cd $DOT_PATH
