#!/usr/bin/env fish

if not test $INIT_LOADED
    set DOT_PATH $HOME/.dotfiles
    set CACHE_PATH $DOT_PATH/.cache

    function link-file
        for file in $argv
            if not test $DOT_PATH/$file
                continue
            end
            if not test -d $HOME/(dirname $file)
                mkdir -p $HOME/(dirname $file)
            end
            ln -snfv $DOT_PATH/$file $HOME/$file
        end
    end


    function is-mac
        return (test (uname -s) = "Darwin")
    end


    function is-arm-mac
        return (test (uname -sm) = "Darwin arm64")
    end

    function source-config
        source $HOME/.config/fish/config.fish
    end

    set INIT_LOADED 1
end
