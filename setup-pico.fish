#!/usr/bin/env fish

source common.fish

set PICO_HOME $HOME/development/pico 

brew install cmake
brew tap ArmMbed/homebrew-formulae
brew install arm-none-eabi-gcc

if not test -d $PICO_HOME
    mkdir $PICO_HOME
end
cd $PICO_HOME

if not test -d $PICO_HOME/pico-sdk
    git clone -b master https://github.com/raspberrypi/pico-sdk.git
end
cd pico-sdk
git pull
git submodule update --init
cd ..

if not test -d $PICO_HOME/pico-examples
    git clone -b master https://github.com/raspberrypi/pico-examples.git
end
cd pico-examples
git pull

