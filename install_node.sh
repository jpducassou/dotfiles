#!/bin/bash

set -e

if [ ! -d "${HOME}/.nvm" ]; then
	echo "[info] Installing nvm ..."
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

export NVM_DIR="${HOME}/.nvm"
source "${NVM_DIR}/nvm.sh"

if ! grep -sq 'nvm' "${HOME}/.bash_post"; then
  echo "[info] Adding nvm configuration to .bash_post"
  cat <<- 'EOF' >> "${HOME}/.bash_post"
	# ============================================================================
	# nvm
	# ============================================================================
	export NVM_DIR="${HOME}/.nvm"
	[ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"
	EOF
fi

echo "[info] Installing nodejs lts/jod  = 22 with nvm ..."
nvm install lts/jod

echo "[info] Installing nodejs lts/iron = 20 with nvm ..."
nvm install lts/iron

echo "[info] setting nodejs 22 as default ..."
nvm alias default lts/jod

