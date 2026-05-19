#!/bin/bash

set -e

BASH_POST="${HOME}/.bash_post"

if ! command -v pyenv >/dev/null 2>&1; then
	echo "[error] pyenv is not installed or not available in PATH."
	echo "[info] Install pyenv first, for example:"
	echo "[info]   curl -fsSL https://pyenv.run | bash"
	echo "[info] Then add pyenv to your shell startup and run this script again."
	echo "[info] See: https://github.com/pyenv/pyenv?tab=readme-ov-file#installation"
	exit 1
fi

touch "${BASH_POST}"

export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init - bash)"

if ! grep -sq 'pyenv init - bash' "${BASH_POST}"; then
	echo "[info] Adding pyenv configuration to .bash_post"
	cat <<-'EOF' >> "${BASH_POST}"
	# ============================================================================
	# pyenv
	# ============================================================================
	export PYENV_ROOT="${HOME}/.pyenv"
	export PATH="${PYENV_ROOT}/bin:${PATH}"
	eval "$(pyenv init - bash)"
	EOF
fi

echo ""
echo "[info] Done."
echo "[info] Use 'pyenv install <version>' to install a Python version."
echo "[info] Use 'pyenv global <version>' or 'pyenv local <version>' to select it."
