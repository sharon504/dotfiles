#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

source "$SCRIPT_DIR/includes/install.sh"
source "$SCRIPT_DIR/includes/stow_config.sh"

install_pkg "zsh" "zsh"
stow_config "zsh" "$DOTFILES_DIR"
