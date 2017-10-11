#!/bin/bash

# ============================================================================
# Log auxiliary functions
# ============================================================================
escape="\033["
reset="${escape}0m"

# Colors
green="32"
yellow="33"
red="31"

function info() {
	message="${1}"
	_log "INFO" "${green}" "${message}"
}

function warn() {
	message="${1}"
	_log "WARN" "${yellow}" "${message}"
}

function error() {
	message="${1}"
	_log "ERROR" "${red}" "${message}"
}

# USAGE: log "info" "message"
function log() {
	level="${1}"
	message="${2}"

	$1 "${message}"

}

# USAGE: _log "info" "32" "message"
function _log() {
	level="${1}"
	if [ -t 2 ]; then
		color="${escape}0;${2}m"
	else
		color=""
		reset=""
	fi
	message="${3}"

	>&2 echo -e "${color}[${level}]${reset}\t${message}"

}

# ============================================================================
# Main
# ============================================================================

# implementation here

