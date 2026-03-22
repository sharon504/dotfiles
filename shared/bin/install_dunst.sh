#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
DOTFILES_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

source "$SCRIPT_DIR/includes/install.sh"
source "$SCRIPT_DIR/includes/stow_config.sh"

install_pkg "dunst" "dunst"
stow_config "cachyos/dunst" "$DOTFILES_DIR"

