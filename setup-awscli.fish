#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish

cd $CACHE_PATH

curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"

sudo installer -pkg ./AWSCLIV2.pkg -target /

