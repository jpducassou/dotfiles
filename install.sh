#!/bin/bash

# ============================================================================
# Dotfiles install script
# ============================================================================

PWD=$(pwd)

function linkall() {
	local DIR=$1

	for file in $(find "$PWD/$DIR" -mindepth 1 -maxdepth 1)
	do
			echo "linking $file..."
			ln -sv "$file" "$HOME/"
	done

}

linkall "root"

