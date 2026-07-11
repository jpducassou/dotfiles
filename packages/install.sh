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

if [ "$(id -u)" -ne 0 ]; then
	echo 'This script must be run as root.' >&2
	exit 1
fi

grep -vhE '^[[:space:]]*(#|$)' "$@" | xargs -r apt-get install -y

