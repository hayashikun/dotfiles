#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish

set FLUTTER_PATH $HOME/flutter

if not test -d $FLUTTER_PATH
    git clone git@github.com:flutter/flutter.git -b stable $FLUTTER_PATH
end
cd $FLUTTER_PATH && git pull

fish_add_path $FLUTTER_PATH/bin

source-config

flutter precache

flutter doctor