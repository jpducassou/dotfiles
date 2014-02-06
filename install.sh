#!/bin/bash

# ============================================================================
# Dotfiles install script
# ============================================================================

PWD=$(pwd)
echo $PWD

DIR="root"
for file in $(find "$PWD/$DIR" -mindepth 1 -maxdepth 1)
do
    echo "linking $file..."
		ln -sv "$file" "$HOME/"
done


# ln -vs $PWD/root/* ~



