#!/bin/bash

# ============================================================================
# Dotfiles install script
# ============================================================================
PWD=$(pwd)

function linkall() {

	local src_dir="${1}"
	local des_dir="${2}"

	mkdir -p "${HOME}/${des_dir}"

	for file in $(find "${src_dir}" -mindepth 1 -maxdepth 1)
	do
		basename=$(basename "${file}")
		if [ -e "${HOME}/${des_dir}/${basename}" ]; then
			link=$(readlink "${HOME}/${des_dir}/$basename")
			if [ ! "${PWD}/${file}" == "${link}" ]; then
				echo "Must delete '${HOME}/${des_dir}/${basename}' !"
			else
				echo "[OK] ${des_dir}/${basename}"
			fi
		else
			ln -vs "${PWD}/${file}" "${HOME}/${des_dir}"
		fi
	done

	for file in $(find "${HOME}/${des_dir}" -mindepth 1 -maxdepth 1 -type l -xtype l)
	do
		basename=$(basename "${file}")
		echo "[INFO] deleting broken link '${basename}'"
		rm "${HOME}/${des_dir}/${basename}"
	done

}

function install_hooks() {

	hook_names=(post-checkout post-merge)
	script_basename=$(basename "${0}")
	script_path="../../${script_basename}"

	for hook_name in "${hook_names[@]}"; do
		hook_path=".git/hooks/${hook_name}"
		if [ ! -h "${hook_path}" ]; then
			echo "[INFO] linking ${hook_path} -> ${0}"
			ln -vs "${script_path}" "${hook_path}"
		fi
	done

}

linkall 'root' ''
linkall 'bin'  'bin'

git submodule init
git submodule update

install_hooks

