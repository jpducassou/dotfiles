#!/bin/bash

set -e

# ============================================================================
# nvm installation
# ============================================================================
export NVM_DIR="${HOME}/.nvm"

if [ ! -d "${NVM_DIR}" ]; then
	echo "[info] Installing nvm ..."
	mkdir "${NVM_DIR}"
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

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

# ============================================================================
# SDKs installation
# ============================================================================
echo "[info] Installing nodejs lts/krypton = 24 with nvm ..."
nvm install lts/krypton

echo "[info] Installing nodejs lts/jod = 22 with nvm ..."
nvm install lts/jod

echo "[info] setting nodejs 24 as default ..."
nvm alias default lts/krypton

# ============================================================================
# THE END
# ============================================================================
echo ""
echo "[info] Done."

