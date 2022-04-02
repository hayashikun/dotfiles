#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish

cd $DOT_PATH
if not type -q rustup
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
end

fish_add_path $HOME/.cargo/bin
rustup install stable nightly
rustup component add clippy rls rust-analysis rust-src rust-docs rustfmt
rustup update

for p in (cat cargo-packages)
    cargo install $p
end

cd $CACHE_PATH
if not test -d $CACHE_PATH/rust-analyzer
    git clone https://github.com/rust-analyzer/rust-analyzer.git
end
cd rust-analyzer && git checkout release && git pull && cargo xtask install --server

link-file ".svls.toml"
