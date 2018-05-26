#!/bin/bash

# ============================================================================
# Dotfiles install script
# ============================================================================
PWD=$(pwd)
verbose=0
while getopts "v" options; do
	case "${options}" in
		v)
			verbose=1
		;;
	esac
done

# ============================================================================
# Color setup
# ============================================================================
if test -t 1 && test -n $(tput colors); then
	normal="$(tput sgr0)"
	red="$(tput setaf 1)"
	green="$(tput setaf 2)"
	yellow="$(tput setaf 3)"
	info="${green}[INFO]${normal}"
	warn="${yellow}[WARN]${normal}"
	error="${red}[ERROR]${normal}"
fi

# ============================================================================
# This function links the files of a given directory into another
# ============================================================================
function linkall() {

	local src_dir="${1}"
	local dst_dir="${2}"
	local src_path

	mkdir -p "${HOME}/${dst_dir}"

	for src_path in $(find "${src_dir}" -mindepth 1 -maxdepth 1)
	do
		local file_name=$(basename "${src_path}")
		local dst_path="${HOME}/${dst_dir}/${file_name}"
		if [ -e "${dst_path}" ]; then
			local link=$(readlink "${dst_path}")
			if [ ! "${PWD}/${src_path}" == "${link}" ]; then
				echo "${warn} Must delete '${dst_path}'."
			else
				[ ${verbose} -eq 1 ] && echo "${info} '${dst_dir}/${file_name}' OK."
			fi
		else
			ln -s "${PWD}/${src_path}" "${dst_path}"
			if [ $? -ne 0 ]; then
				echo "${error} linking '${PWD}/${src_path}' -> '${dst_path}'"
			else
				echo "${info} linking '${PWD}/${src_path}' -> '${dst_path}'"
			fi
		fi
	done

	for src_path in $(find "${HOME}/${dst_dir}" -mindepth 1 -maxdepth 1 -type l -xtype l)
	do
		local file_name=$(basename "${src_path}")
		echo "${info} deleting broken link '${file_name}'"
		rm "${HOME}/${dst_dir}/${file_name}"
	done

}

# ============================================================================
# This function install this script as several git hooks
# ============================================================================
function install_hooks() {

	local hook_names=(post-checkout post-merge)
	local script_name=$(basename "${0}")
	local script_path="../../${script_name}"

	for hook_name in "${hook_names[@]}"; do
		local hook_path=".git/hooks/${hook_name}"
		if [ ! -h "${hook_path}" ]; then
			ln -s "${script_path}" "${hook_path}"
			if [ $? -ne 0 ]; then
				echo "${error} linking '${hook_path}' -> '${0}'"
			else
				echo "${info} linking '${hook_path}' -> '${0}'"
			fi
		fi
	done

}

# ============================================================================
# Main
# ============================================================================
linkall 'root' ''
linkall 'bin'  'bin'

git submodule init
git submodule update

install_hooks

