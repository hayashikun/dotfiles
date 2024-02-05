#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish
cd (dirname (status -f)) && source setup-asdf.fish

source-config

asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git

asdf install ruby latest
asdf global ruby latest

source-config

asdf reshim ruby
