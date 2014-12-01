#!/bin/bash

# ============================================================================
# Dotfiles install script
# ============================================================================
PWD=$(pwd)

function linkall() {

	local SRC_DIR=$1
	local DES_DIR=$2

	mkdir -p "$HOME/$DES_DIR"

	for file in $(find "$SRC_DIR" -mindepth 1 -maxdepth 1)
	do
		basename=$(basename $file)
		if [ -e "$HOME/$DES_DIR/$basename" ]; then
			link=$(readlink "$HOME/$DES_DIR/$basename")
			if [ ! "$PWD/$file" == "$link" ]; then
				echo "Must delete '$HOME/$DES_DIR/$basename' !"
			else
				echo "[OK] $DES_DIR/$basename"
			fi
		else
			ln -vs "$PWD/$file" "$HOME/$DES_DIR"
		fi
	done

	for file in $(find "$HOME/$DES_DIR" -mindepth 1 -maxdepth 1 -type l -xtype l)
	do
		basename=$(basename $file)
		echo "[INFO] deleting broken link '$basename'"
		rm "$HOME/$DES_DIR/$basename"
	done

}

linkall 'root' ''
linkall 'bin'  'bin'

