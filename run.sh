#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
BIN_DIR="$SCRIPT_DIR/bin"
INCLUDES_DIR="$BIN_DIR/includes"

# --- 1. Safety Check ---
# Make sure the helper scripts exist before doing anything else.
if [ ! -f "$INCLUDES_DIR/install.sh" ] || [ ! -f "$INCLUDES_DIR/stow_config.sh" ]; then
  echo "Error: Helper scripts not found in $INCLUDES_DIR"
  echo "Please make sure install.sh and stow_config.sh exist."
  exit 1
fi

# --- 2. Install Stow First ---
# This is critical. We must install 'stow' *before* any other script
# tries to use the 'stow_config' function.
echo "--- Ensuring 'stow' is installed ---"
source "$INCLUDES_DIR/install.sh"
install_pkg "stow" "stow"
echo "--- 'stow' check complete ---"
echo ""

# --- 3. Run All Other Installers ---
for script in "$BIN_DIR"/install_*.sh; do
  echo "--- Making $script executable ---"
  chmod +x "$script"
  
  echo "--- Running $script ---"
  "$script"
  echo "--- Finished $script ---"
  echo ""
done

echo "All installations and stowing complete."
