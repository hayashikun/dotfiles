#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish

cd $CACHE_PATH

curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg ./AWSCLIV2.pkg -target /

# TODO (hayashikun): mac only 
if is-mac
    curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/mac_arm64/sessionmanager-bundle.zip" -o "sessionmanager-bundle.zip"
    unzip sessionmanager-bundle.zip
    sudo ./sessionmanager-bundle/install -i /usr/local/sessionmanagerplugin -b /usr/local/bin/session-manager-plugin
end
