# Dotfiles

A modular, cross-platform dotfiles configuration supporting CachyOS (Niri), NixOS, and Arch Linux (i3).

## Structure

This repository is organized to support multiple operating systems while keeping reusable configurations modular:

```
dotfiles/
├── nvim/              # Neovim config (submodule: github.com/yourusername/nvim-config)
├── rofi/              # Rofi launcher (submodule: github.com/yourusername/rofi-config)
├── hypr/              # Hyprland WM (submodule: github.com/yourusername/hypr-config)
├── niri/              # Niri WM (submodule: github.com/yourusername/niri-config)
├── tmux/              # Tmux terminal multiplexer (submodule: github.com/yourusername/tmux-config)
├── zsh/               # Zsh shell (submodule: github.com/yourusername/zsh-config)
├── kanata/            # Kanata keyboard remapper (submodule: github.com/yourusername/kanata-config)
├── kitty/             # Kitty terminal (submodule: github.com/yourusername/kitty-config)
├── waybar/            # Waybar status bar (submodule: github.com/yourusername/waybar-config)
├── shared/            # Cross-platform utilities
│   ├── bin/           # Installation scripts
│   ├── scripts/       # Helper scripts
│   ├── themes/        # Color schemes and themes
│   ├── wallpapers/    # Wallpaper collection
│   └── run.sh         # Main installation orchestrator
├── cachyos/           # CachyOS-specific configs
│   ├── dunst/         # Notification daemon
│   ├── wal/           # Pywal theming
│   ├── waypaper/      # Wallpaper manager
│   ├── nix-files/     # Nix packages on CachyOS
│   └── package-manager/
├── nixos/             # NixOS-specific configs
│   ├── flake.nix      # NixOS flake configuration
│   ├── flake.lock     # Flake lock file
│   ├── hosts/         # Per-host configurations
│   └── stow/          # Stow-based configs
└── arch-i3/           # Arch Linux i3 configs
    ├── i3/            # i3 window manager
    ├── polybar/       # Polybar status bar
    ├── picom/         # Compositor
    └── alacritty/     # Alacritty terminal
```

## Installation

### First-Time Clone

Clone the repository with all submodules:

```bash
git clone --recurse-submodules https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

If you already cloned without submodules, initialize them:

```bash
git submodule update --init --recursive
```

### CachyOS / Arch Linux Installation

The automated installation script will install packages and symlink configurations using GNU Stow:

```bash
cd ~/dotfiles/shared
chmod +x run.sh
./run.sh
```

This will:
1. Install `stow` if not present
2. Run all `install_*.sh` scripts in `shared/bin/`
3. Install packages via `paru` (Arch-based systems)
4. Symlink configurations to `~/.config/`

### Manual Installation (per-config)

You can install individual configurations:

```bash
cd ~/dotfiles/shared/bin
./install_nvim.sh     # Install Neovim and symlink config
./install_hypr.sh     # Install Hyprland and symlink config
./install_zsh.sh      # Install Zsh and symlink config
# etc...
```

### NixOS Installation

For NixOS, use the flake configuration:

```bash
cd ~/dotfiles/nixos
sudo nixos-rebuild switch --flake .#yourhostname
```

## Managing Submodules

### Updating All Submodules

Pull latest changes from all submodule repositories:

```bash
git submodule update --remote --merge
```

### Updating a Single Submodule

```bash
cd nvim  # or any submodule directory
git pull origin main
cd ..
git add nvim
git commit -m "Update nvim submodule"
```

### Making Changes to a Submodule

1. Navigate to the submodule directory:
   ```bash
   cd nvim
   ```

2. Make your changes and commit within the submodule:
   ```bash
   git checkout main
   git add .
   git commit -m "Update configuration"
   git push origin main
   ```

3. Return to the main dotfiles repo and update the submodule reference:
   ```bash
   cd ..
   git add nvim
   git commit -m "Update nvim submodule reference"
   ```

### Adding a New Submodule

```bash
git submodule add https://github.com/yourusername/new-config.git new-config
git commit -m "Add new-config as submodule"
```

### Removing a Submodule

```bash
git submodule deinit -f new-config
git rm -f new-config
rm -rf .git/modules/new-config
git commit -m "Remove new-config submodule"
```

## OS-Specific Configurations

### CachyOS (Niri)

Uses Wayland with Niri window manager. Key configs:
- Window Manager: `niri/` (submodule)
- Terminal: `kitty/` (submodule)
- Status Bar: `waybar/` (submodule)
- Launcher: `rofi/` (submodule)
- Notifications: `cachyos/dunst/`
- Theming: `cachyos/wal/`

### NixOS

Declarative system configuration using Flakes:
- Main config: `nixos/flake.nix`
- Host-specific: `nixos/hosts/`
- All submodules are available and symlinked via Stow

### Arch Linux (i3)

X11-based setup with i3 window manager:
- Window Manager: `arch-i3/i3/`
- Terminal: `arch-i3/alacritty/`
- Status Bar: `arch-i3/polybar/`
- Compositor: `arch-i3/picom/`
- Editor: `nvim/` (submodule, shared across OS)

## Stow Usage

Configurations are symlinked using GNU Stow. Each submodule at the root level can be stowed:

```bash
cd ~/dotfiles
stow -t ~ nvim    # Creates symlinks: ~/.config/nvim -> ~/dotfiles/nvim/.config/nvim
stow -t ~ zsh     # Creates symlinks: ~/.config/zsh -> ~/dotfiles/zsh/.config/zsh
```

To unstow (remove symlinks):

```bash
stow -D nvim
```

To restow (update symlinks):

```bash
stow -R nvim
```

## Branches

- `main` - Unified configuration (current)
- `cachyos/niri` - Original CachyOS/Niri branch (preserved)
- `nixos` - Original NixOS branch (preserved)
- `arch/i3` - Original Arch i3 branch (preserved)

The `main` branch merges all OS-specific configurations into organized directories while keeping shared configs as submodules at the root level.

## Development

### Testing Changes

When testing changes to a submodule configuration:

1. Edit files in the submodule directory (e.g., `nvim/`)
2. Symlinks created by Stow will reflect changes immediately
3. Commit and push changes from within the submodule
4. Update the submodule reference in the main repo

### Adding New Scripts

Installation scripts follow this pattern:

```bash
#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"  # Points to dotfiles root

source "$SCRIPT_DIR/includes/install.sh"
source "$SCRIPT_DIR/includes/stow_config.sh"

install_pkg "package-name" "command-name"
stow_config "config-name" "$DOTFILES_DIR"
```

Place new scripts in `shared/bin/install_<name>.sh` and they'll be picked up by `run.sh`.

## License

MIT License - Feel free to use and modify as needed.

## Contributing

This is a personal dotfiles repository, but feel free to fork and adapt for your own use. If you find bugs or have suggestions, open an issue or PR.

## Credits

Built with inspiration from the dotfiles community. Thanks to all the open-source projects that make this configuration possible.
