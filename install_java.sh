#!/bin/bash

set -e

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

echo "[info] Installing Java SDK 17 with SDKMAN ..."
sdk install java '17.0.16-amzn'
JAVA_17_DIR=$(sdk home java '17.0.16-amzn')

echo "[info] Installing Java SDK 21 with SDKMAN ..."
sdk install java '21.0.8-amzn'
JAVA_21_DIR=$(sdk home java '21.0.8-amzn')

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

echo "[info] Addding Java SDK 17 to jenv ..."
jenv add "${JAVA_17_DIR}"

echo "[info] Addding Java SDK 21 to jenv ..."
jenv add "${JAVA_21_DIR}"

echo "[info] Adding gradle plugin to jenv ..."
jenv enable-plugin export
jenv enable-plugin gradle

echo "[info] setting Java SDK 21 as default ..."
jenv global 21

echo ""
echo "[info] Done."
echo "[info] Use 'jenv global <version>' or 'jenv local <version>' to change sdk."
echo "[info] To uninstall just rm -rf ${HOME}/.sdkman && ${HOME}/.jenv."

