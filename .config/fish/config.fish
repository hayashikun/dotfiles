# for M1 mac
if test (uname -sm) = "Darwin arm64"
    eval (/opt/homebrew/bin/brew shellenv)
end

if test (uname -s) = "Linux"
    alias pbcopy="xclip -selection c"
    alias pbpaste="xclip -selection c -o" 
end

# asdf
source $HOME/.asdf/asdf.fish

# pyenv
if type -q pyenv
    pyenv init --path | source
    pyenv init - | source
end

for al in "ls exa" "cat bat" "k kubectl" "g git"
    set p (string split ' ' $al)
    if type -q $p[2]
        alias $p[1]=$p[2]
    end
end

# for exa
alias la="ls -lah"


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
