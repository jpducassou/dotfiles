#!/bin/bash

# ============================================================================
# Dotfiles install script
# ============================================================================
PWD=$(pwd)

function linkall() {

	local SRC_DIR=$1
	local DES_DIR=$2

	mkdir --parents "$HOME/$DES_DIR"

	for file in $(find "$SRC_DIR" -mindepth 1 -maxdepth 1)
	do
		basename=$(basename $file)
		if [ -a "$HOME/$DES_DIR/$basename" ]; then
			link=$(readlink "$HOME/$DES_DIR/$basename")
			if [ ! "$PWD/$file" == "$link" ]; then
				echo "Must delete '$HOME/$DES_DIR/$basename' !"
			else
				echo "[OK] $DES_DIR/$basename"
			fi
		else
			ln --symbolic --verbose --target-directory="$HOME/$DES_DIR" "$PWD/$file"
		fi
	done

}

linkall 'root' ''
linkall 'bin'  'bin'

