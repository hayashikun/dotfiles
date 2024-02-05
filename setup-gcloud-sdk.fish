#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish

set GCLOUD_SDK_VERSION (get-version gcloud-sdk "460.0.0")
set GCLOUD_SDK_PATH $HOME/google-cloud-sdk

if not test -d $GCLOUD_SDK_PATH
    switch (uname -m)
        case "arm64"
            set ARCH "arm"
        case "*"
            set ARCH "x86_64"
    end
    set OS (string lower (uname -s))
    set ARC "google-cloud-sdk-$GCLOUD_SDK_VERSION-$OS-$ARCH.tar.gz"

    cd $CACHE_PATH
    curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/$ARC -O
    tar -xzf $ARC && mv google-cloud-sdk $GCLOUD_SDK_PATH
    
    cd $GCLOUD_SDK_PATH/..
    ./google-cloud-sdk/install.sh
    ./google-cloud-sdk/bin/gcloud init
end

fish_add_path $GCLOUD_SDK_PATH/bin
yes | gcloud components update
yes | gcloud components install gke-gcloud-auth-plugin
