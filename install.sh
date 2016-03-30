#!/bin/bash

# ============================================================================
# Dotfiles install script
# ============================================================================
PWD=$(pwd)

function linkall() {

	local src_dir="${1}"
	local dst_dir="${2}"
	local file

	mkdir -p "${HOME}/${dst_dir}"

	for file in $(find "${src_dir}" -mindepth 1 -maxdepth 1)
	do
		local file_name=$(basename "${file}")
		local dst_path="${HOME}/${dst_dir}/${file_name}"
		if [ -e "${dst_path}" ]; then
			local link=$(readlink "${dst_path}")
			if [ ! "${PWD}/${file}" == "${link}" ]; then
				echo "Must delete '${dst_path}' !"
			else
				echo "[OK] ${dst_dir}/${file_name}"
			fi
		else
			ln -vs "${PWD}/${file}" "${HOME}/${dst_dir}"
		fi
	done

	for file in $(find "${HOME}/${dst_dir}" -mindepth 1 -maxdepth 1 -type l -xtype l)
	do
		local file_name=$(basename "${file}")
		echo "[INFO] deleting broken link '${file_name}'"
		rm "${HOME}/${dst_dir}/${file_name}"
	done

}

function install_hooks() {

	local hook_names=(post-checkout post-merge)
	local script_basename=$(basename "${0}")
	local script_path="../../${script_basename}"

	for hook_name in "${hook_names[@]}"; do
		local hook_path=".git/hooks/${hook_name}"
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

