#!/usr/bin/env fish

cd (dirname (status -f)) && source init.fish
cd (dirname (status -f)) && source setup-asdf.fish

source-config

set PYTHON_VERSION (get-version python "3.12.9")

brew-install readline zlib xz openssl
apt-install build-essential libreadline-dev libffi-dev libssl-dev zlib1g-dev liblzma-dev libbz2-dev libsqlite3-dev

asdf plugin add python
asdf install python $PYTHON_VERSION
asdf set -u python $PYTHON_VERSION

source-config

pip install -U -r pip-packages

# poetry install
curl -sSL https://install.python-poetry.org | python3 -
fish_add_path $HOME/.local/bin

link-file \
    .config/pycodestyle \
    .jupyter/lab/user-settings/@jupyterlab/shortcuts-extension/shortcuts.jupyterlab-settings

if not test -e $HOME/.config/asciinema/install-id
    echo "asciinema auth is needed!"
end
