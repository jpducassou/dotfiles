#!/bin/bash

set -euo pipefail

# ============================================================================
# Dotfiles upgrade script
# ============================================================================
git submodule foreach --recursive git pull --ff-only

