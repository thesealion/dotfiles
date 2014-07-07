#!/bin/bash

set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"

function ensure_link {
    test -L "$HOME/$2" || ln -sf "$DIR/$1" "$HOME/$2"
}

function github_clone {
    test -d $2 || git clone http://github.com/$1/$2.git
}

ensure_link "gitconfig" ".gitconfig"
ensure_link "bashrc"    ".bashrc"
ensure_link "git-completion.bash" ".git-completion.bash"
ensure_link "tmux.conf" ".tmux.conf"

mkdir -p $HOME/.config/Terminal
ensure_link "xfce-terminal" ".config/Terminal/terminalrc"

mkdir -p $HOME/.vim
ensure_link "vim/vimrc" ".vimrc"
ensure_link "vim/gvimrc" ".gvimrc"
ensure_link "vim/colors" ".vim/colors"
ensure_link "vim/autoload" ".vim/autoload"
mkdir -p $HOME/.vim/tmp/backup
mkdir -p $HOME/.vim/tmp/swap
mkdir -p $HOME/.vim/tmp/undo

mkdir -p $HOME/.vim/bundle
cd $HOME/.vim/bundle
github_clone "scrooloose" "nerdtree"
github_clone "scrooloose" "nerdcommenter"
github_clone "scrooloose" "syntastic"
github_clone "sjl" "gundo.vim"
github_clone "tpope" "vim-fugitive"
github_clone "mileszs" "ack.vim"

if [ ! -d "Command-T" ]; then
    github_clone "wincent" "Command-T"

    cd Command-T
    bundle install
    rake make
fi

echo "done"
