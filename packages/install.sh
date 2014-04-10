#!/bin/bash

# ============================================================================
# Software packages install script
# ============================================================================
if [ "$#" == "0" ]; then
	echo 'Usage ./install.sh <file_with_list_of_packages>'
	exit 1
fi
cat $@ | xargs aptitude install -y

