#!/bin/bash

# ============================================================================
# Dotfiles install script
# ============================================================================
PWD=$(pwd)

function linkall() {

	local SRC_DIR=$1
	local DES_DIR=$2

	for file in $(find "$PWD/$SRC_DIR" -mindepth 1 -maxdepth 1)
	do
			ln --symbolic --verbose --force --target-directory="$HOME/$DES_DIR" "$file"
	done

}

linkall 'root' ''
linkall 'bin'  'bin'

