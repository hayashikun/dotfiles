#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish

set PYTHON_VERSION (get-version python "3.10.4")

brew-install readline zlib xz openssl llvm@11
apt-install build-essential libreadline-dev libffi-dev libssl-dev zlib1g-dev liblzma-dev libbz2-dev libsqlite3-dev

set -x PYENV_ROOT $HOME/.pyenv
if not test -d $PYENV_ROOT
    git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
end
cd $PYENV_ROOT && git pull

fish_add_path $PYENV_ROOT/bin
source-config

cd $DOT_PATH
if not test (pyenv global) = $PYTHON_VERSION
    pyenv install $PYTHON_VERSION -s && pyenv global $PYTHON_VERSION
end

function pip-install
    pip install -U -r pip-packages
end

if is-mac  # for llvmlite
    LLVM_CONFIG=(brew --prefix llvm@11)/bin/llvm-config pip-install
else
    pip-install
end

link-file \
    .config/pycodestyle \
    .jupyter/lab/user-settings/@jupyterlab/shortcuts-extension/shortcuts.jupyterlab-settings

if not test -e $HOME/.config/asciinema/install-id
    echo "asciinema auth is needed!"
end
