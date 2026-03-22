#!/bin/bash

stow_config() {
  local package_name="$1"
  local dotfiles_dir="$2"
  
  if [ -z "$dotfiles_dir" ]; then
    echo "Error: DOTFILES_DIR not provided to stow_config."
    return 1
  fi

  if ! command -v stow &> /dev/null; then
    echo "Error: 'stow' command not found. Run the main install_all.sh script to install it."
    return 1
  fi

  local target_dir="$HOME"
  
  echo "Stowing $package_name configuration..."
  
  # -R = --restow: Unstows existing package first, then stows. This clears old configs/links.
  # -t = --target: The directory to link into (your home directory).
  # -d = --dir: The directory containing the stowable packages (your dotfiles root).
  # We change directory to the dotfiles dir to avoid stow issues with paths
  
  if (cd "$dotfiles_dir" && stow -R -t "$target_dir" "$package_name"); then
    echo "Successfully stowed $package_name."
  else
    echo "Error: Failed to stow $package_name. Does a '$package_name' directory exist in your dotfiles root?"
    return 1
  fi
}
