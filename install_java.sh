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
install_latest_java_sdk() {
	local major="$1"
	local vendor="${2:-amzn}"

	local latest
	latest=$(sdk list java \
		| grep -oE "[0-9]+\.[0-9]+\.[0-9]+-${vendor}" \
		| grep "^${major}\." \
		| sort -V | tail -1)

	if [ -z "${latest}" ]; then
		echo "[error] No version found for Java ${major} (${vendor})"
		return 1
	fi

	if [ -d "${HOME}/.sdkman/candidates/java/${latest}" ]; then
		echo "[info] Java SDK ${latest} is already up to date."
		return 0
	fi

	echo "[info] Installing Java SDK ${latest} with SDKMAN ..."
	sdk install java "${latest}"

	echo "[info] Adding Java SDK ${latest} to jenv ..."
	jenv add "$(sdk home java "${latest}")" 2>/dev/null || true
}

install_latest_java_sdk 17
install_latest_java_sdk 21
install_latest_java_sdk 25

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

