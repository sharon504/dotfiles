#!/bin/bash

install_pkg() {
  local package_name="$1"
  local command_to_check="$2"

  # Default command_to_check to package_name if not provided
  if [ -z "$command_to_check" ]; then
    command_to_check="$package_name"
  fi

  if ! command -v "$command_to_check" &> /dev/null; then
    echo "Installing $package_name (command: $command_to_check)..."
    paru -S --noconfirm --needed "$package_name"
    # Return 0 if paru succeeded, or its error code if it failed
    return $?
  else
    echo "$package_name (command: $command_to_check) is already installed."
    # Still check for updates, as --needed will handle it
    echo "Checking for updates for $package_name..."
    paru -S --noconfirm --needed "$package_name"
    return 1 # Represents "false" / "was already installed"
  fi
}
