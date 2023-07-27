#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish

if test $ASDF_SETUPED
    exit 0
end

set -x ASDF_ROOT $HOME/.asdf
set -x ASDF_VERSION v0.12.0
if not test -d $ASDF_ROOT
    git clone git@github.com:asdf-vm/asdf.git $ASDF_ROOT --branch $ASDF_VERSION
end
cd $ASDF_ROOT & git pull origin $ASDF_VERSION

rm -rf $HOME/.config/fish/completions
mkdir -p $HOME/.config/fish/completions
ln -s $ASDF_ROOT/completions/asdf.fish $HOME/.config/fish/completions

set ASDF_SETUPED 1
