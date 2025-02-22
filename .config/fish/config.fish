# for M1 mac
if test (uname -sm) = "Darwin arm64"
    eval (/opt/homebrew/bin/brew shellenv)
end

if test (uname -s) = "Linux"
    alias pbcopy="xclip -selection c"
    alias pbpaste="xclip -selection c -o" 
end


# asdf
# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

asdf completion fish > ~/.config/fish/completions/asdf.fish


# alias
for al in "cat bat" "k kubectl" "g git"
    set p (string split ' ' $al)
    if type -q $p[2]
        alias $p[1]=$p[2]
    end
end


# for atmark
if type -q @
    function cd@; cd (@ $argv); end
    function cat@; cat (@ $argv); end
    function ls@; ls (@ $argv); end
    complete -c cd@ -w @
    complete -c cat@ -w @
    complete -c ls@ -w @
end


# aws cli
complete -c aws -f -a '(begin; set -lx COMP_SHELL fish; set -lx COMP_LINE (commandline); /usr/local/bin/aws_completer; end)'


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ryosuke_hayashi/google-cloud-sdk/path.fish.inc' ]; . '/Users/ryosuke_hayashi/google-cloud-sdk/path.fish.inc'; end


# utils
function camel_to_snake -d "Convert camelCase to snake_case"
    set -l string (string replace -ar '([A-Z])' '_\L$1' -- $argv)
    set -l result (string trim --chars '_' $string)
    echo $result
end

function snake_to_camel -d "Convert snake_case to camelCase"
    set -l string (string replace -ar '_(.)' '\U$1' -- $argv)
    echo $string
end

function load_env_file -d "Load env file"
    for r in (cat $argv)
        if test (string sub -l 1 $r) = '#'
            continue
        end
        echo $r
        set p (string split '=' $r)
        set -xg $p[1] $p[2]
    end
end
