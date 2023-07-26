#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish

set GO_VERSION (get-version go "1.20.6")

set -x GOENV_ROOT $HOME/.goenv
if not test -d $GOENV_ROOT
    git clone https://github.com/syndbg/goenv.git $GOENV_ROOT
end
cd $GOENV_ROOT & git pull

fish_add_path $GOENV_ROOT/bin
source-config

cd $DOT_PATH
if not test (goenv global) = $GO_VERSION
    goenv install $GO_VERSION -s && goenv global $GO_VERSION
end

source-config

cd $DOT_PATH
for p in (cat go-packages)
    go install $p
end
