#!/usr/bin/bash

# $1 is relative path to file, $2 is the the dotfiles directory in this repo, maybe useful when I need linking
install_config() {
	dest="$HOME/.${1#./}"
	mkdir -p "$(dirname "$dest")"
	cp -p "$1" "$dest"
}

export -f install_config

SRC_DIR=$(dirname "$(readlink -f "$0")")
cd "$SRC_DIR" || exit
find . -type f -not -path "./install.sh" -not -path "./config/nvim/*" -exec sh -c 'install_config "$1" '"$SRC_DIR" shell {} \;

ln -s "$SRC_DIR/config/nvim" "$HOME/.config/nvim"

bat cache --build
