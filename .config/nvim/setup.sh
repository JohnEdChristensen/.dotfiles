#!/bin/bash

mkdir ~/.virtualenvs
python -m venv ~/.virtualenvs/neovim/
source ~/.virtualenvs/neovim/bin/activate

pip install pynvim jupyter_client cairosvg plotly kaleido pnglatex pyperclip

tput setaf 2
echo
echo "Created a neovim venv at ~/.virtualenvs/neovim"
echo "Add new dependencies to ~/.config/nvim/setup.sh"
tput sgr0

echo "Consider setting up an ipykernel to use as a 'daily driver'
  venv project_name # activate the project venv
  pip install ipykernel
  python -m ipykernel install --user --name project_name"
