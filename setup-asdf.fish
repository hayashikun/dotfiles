#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish

if test $ASDF_SETUPED
    exit 0
end

if is-mac
    brew-install asdf
else
    set -x ASDF_ROOT $HOME/.asdf
    set -x ASDF_VERSION v0.16.3
    if not test -d $ASDF_ROOT
        git clone git@github.com:asdf-vm/asdf.git $ASDF_ROOT --branch $ASDF_VERSION
    end
    cd $ASDF_ROOT & git pull origin $ASDF_VERSION
end

set ASDF_SETUPED 1
