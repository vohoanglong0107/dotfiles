#!/usr/bin/bash

install_config() {
	dest="$HOME/.${1#./}"
	mkdir -p "$(dirname "$dest")"
	cp -p "$1" "$dest"
	# rm "$dest"
}

export -f install_config

SRC_DIR=$(dirname "$(readlink -f "$0")")
cd "$SRC_DIR" || exit
find . -type f -not -path "./install.sh" -exec sh -c 'install_config "$1"' shell {} \;

bat cache --build
