#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish

set GO_VERSION (get-version go "1.18")

switch (uname -m)
    case "arm64"
        set ARCH "arm64"
    case "*"
        set ARCH "amd64"
end
set OS (string lower (uname -s))
set ARC "go$GO_VERSION.$OS-$ARCH.tar.gz"

cd $CACHE_PATH
if not test -f $ARC
    curl https://dl.google.com/go/$ARC -O
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf $ARC
end
fish_add_path /usr/local/go/bin
fish_add_path $HOME/go/bin

cd $DOT_PATH
for p in (cat go-packages)
    go install $p
end
