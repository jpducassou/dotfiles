#!/bin/bash

# ============================================================================
# Dotfiles install script
# ============================================================================
cd "$(dirname "$(readlink -f "${0}")")" || exit 1
dotfiles_dir="$(pwd)"
verbose=0
while getopts "hv" options; do
	case "${options}" in
		h)
			echo "usage: ${0} [-hv]"
			exit 0
		;;
		v)
			verbose=1
		;;
		*)
			echo "usage: ${0} [-hv]" >&2
			exit 1
		;;
	esac
done

# ============================================================================
# Color setup
# ============================================================================
if test -t 1 && test -n "$(tput colors 2>/dev/null)"; then
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

	while IFS= read -r -d '' src_path; do
		local file_name
		file_name=$(basename "${src_path}")
		local dst_path="${HOME}/${dst_dir}/${file_name}"
		if [ -e "${dst_path}" ]; then
			local link
			link=$(readlink "${dst_path}")
			if [ ! "${dotfiles_dir}/${src_path}" == "${link}" ]; then
				echo "${warn} Must delete '${dst_path}'."
			else
				[ ${verbose} -eq 1 ] && echo "${info} '${dst_dir}/${file_name}' OK."
			fi
		else
			ln -s "${dotfiles_dir}/${src_path}" "${dst_path}"
			if [ $? -ne 0 ]; then
				echo "${error} linking '${dotfiles_dir}/${src_path}' -> '${dst_path}'"
			else
				echo "${info} linking '${dotfiles_dir}/${src_path}' -> '${dst_path}'"
			fi
		fi
	done < <(find "${src_dir}" -mindepth 1 -maxdepth 1 -print0)

	# Eliminar symlinks rotos en la carpeta ${HOME}/${dst_dir}
	while IFS= read -r -d '' src_path; do
		if [ ! -e "${src_path}" ]; then
			local file_name
			file_name=$(basename "${src_path}")
			echo "${info} deleting broken link '${file_name}'"
			rm "${HOME}/${dst_dir}/${file_name}"
		fi
	done < <(find "${HOME}/${dst_dir}" -mindepth 1 -maxdepth 1 -type l -print0)

}

# ============================================================================
# This function install this script as several git hooks
# ============================================================================
function install_hooks() {

	local hook_names=(post-checkout post-merge)
	local script_name
	script_name=$(basename "${0}")
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

# ============================================================================
# Done
# ============================================================================
echo "${info} Done. You may need to restart your terminal."

