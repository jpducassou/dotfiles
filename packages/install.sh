#!/bin/bash

# ============================================================================
# Software packages install script
# ============================================================================
# Can get list with:
# # dpkg --get-selections

if [ "$#" == "0" ]; then
	echo 'Usage ./install.sh <file_with_list_of_packages>'
	exit 1
fi

grep -vh '#' $@ | xargs aptitude install

