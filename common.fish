#!/usr/bin/env fish

set DOT_PATH $HOME/.dotfiles
set CACHE_PATH $DOT_PATH/.cache


function is-mac
    return (test (uname -s) = "Darwin")
end


function is-arm-mac
    return (test (uname -sm) = "Darwin arm64")
end

function source-config
    source $HOME/.config/fish/config.fish
end

