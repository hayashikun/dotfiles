# pyenv
if type -q pyenv
    pyenv init --path | source
    pyenv init - | source
end

# nodenv
if type -q nodenv
    eval (nodenv init - | source)
end


for al in "ls exa" "diff delta" "cat bat"
    set p (string split ' ' $al)
    if type -q $p[2]
        alias $p[1]=$p[2]
    end
end

# for exa
alias la="ls -lah"
