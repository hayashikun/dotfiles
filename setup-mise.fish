#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish

if test $MISE_SETUPED
    exit 0
end

if is-mac
    brew-install mise
else
    curl https://mise.run | sh
end

set MISE_SETUPED 1
