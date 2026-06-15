#!/bin/bash

set -e

# ============================================================================
# SDKMAN installation
# ============================================================================
if [ ! -d "${HOME}/.sdkman" ]; then
	echo "[info] Installing SDKMAN ..."
	curl -s 'https://get.sdkman.io?ci=true&rcupdate=false' | bash
fi
source "${HOME}/.sdkman/bin/sdkman-init.sh"

if ! grep -sq 'sdkman' "${HOME}/.bash_post"; then
	echo "[info] Adding sdkman configuration to .bash_post"
	cat <<- 'EOF' >> "${HOME}/.bash_post"
	# ============================================================================
	# sdkman
	# ============================================================================
	if [ -f "${HOME}/.sdkman/bin/sdkman-init.sh" ]; then
		. "${HOME}/.sdkman/bin/sdkman-init.sh"
	fi
	EOF
fi

# ============================================================================
# jenv installation
# ============================================================================
if [ ! -d "${HOME}/.jenv" ]; then
	echo "[info] Installing jenv ..."
	git clone https://github.com/jenv/jenv.git ~/.jenv
fi

# Load jenv to environment (can copy the folling to the bashrc file)
export PATH="${HOME}/.jenv/bin:${PATH}"
eval "$(jenv init -)"

if ! grep -sq 'jenv' "${HOME}/.bash_post"; then
	echo "[info] Adding jenv configuration to .bash_post"
	cat <<- 'EOF' >> "${HOME}/.bash_post"
	# ============================================================================
	# jenv
	# ============================================================================
	export PATH="${HOME}/.jenv/bin:${PATH}"
	eval "$(jenv init -)"
	EOF
fi

echo "[info] Adding gradle plugin to jenv ..."
jenv enable-plugin export
jenv enable-plugin gradle

# ============================================================================
# SDKs installation
# ============================================================================
install_java_sdk() {
	local version="$1"
	echo "[info] Installing Java SDK ${version} with SDKMAN ..."
	sdk install java "${version}"
	echo "[info] Adding Java SDK ${version} to jenv ..."
	jenv add "$(sdk home java "${version}")"
}

install_java_sdk '17.0.16-amzn'
install_java_sdk '21.0.8-amzn'
install_java_sdk '25.0.3-amzn'

# ============================================================================
# Set default
# ============================================================================
echo "[info] setting Java SDK 21 as default ..."
jenv global 21

# ============================================================================
# THE END
# ============================================================================
echo ""
echo "[info] Done."
echo "[info] Use 'jenv global <version>' or 'jenv local <version>' to change sdk."
echo "[info] To uninstall just rm -rf ${HOME}/.sdkman && ${HOME}/.jenv."

