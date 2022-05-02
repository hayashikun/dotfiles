#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish

apt-install build-essential

cd $DOT_PATH
if not type -q rustup
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
end

fish_add_path $HOME/.cargo/bin
rustup install stable nightly
rustup component add clippy rust-docs rustfmt
rustup update

for p in (cat cargo-packages)
    cargo install $p
end

