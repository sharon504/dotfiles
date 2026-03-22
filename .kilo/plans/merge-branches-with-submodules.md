# Plan: Merge All Branches into Unified Main Branch with Modular Submodules

## Objective
Merge all OS-specific branches (`cachyos/niri`, `nixos`, and `arch/i3`) into a single unified `main` branch that contains:
- All modular configuration submodules (nvim, rofi, hypr, niri, zsh, tmux, kanata, kitty, waybar)
- OS-specific configurations organized in separate directories
- Shared utilities and scripts accessible across all systems

## Current State Analysis

### Branch Structure
- **cachyos/niri** (current): Contains 9 submodules + CachyOS/Niri-specific files
- **nixos**: Contains NixOS flake configuration + stow setup (no submodules)
- **arch/i3**: Contains i3wm configuration + various WM configs (no submodules)

### Modular Submodules (in cachyos/niri)
✅ nvim, rofi, hypr, niri, zsh, tmux, kanata, kitty, waybar

### Unique Configurations by Branch

**cachyos/niri only:**
- `.gitmodules` (submodules configuration)
- `bin/` (installation scripts)
- `dunst/` (notification daemon)
- `nix-files/` (nix configuration)
- `package-manager/` (package management)
- `run.sh` (main runner script)
- `scripts/` (utility scripts)
- `themes/` (theme configurations)
- `wal/` (pywal themes)
- `wallpapers/` (wallpaper collection)
- `waypaper/` (wallpaper selector)

**nixos only:**
- `flake.nix` (Nix flake)
- `flake.lock` (Nix dependencies)
- `hosts/` (NixOS host configurations)
- `stow/` (GNU Stow configurations)

**arch/i3 only:**
- `i3/` (i3 window manager)
- `polybar/` (status bar)
- `picom/` (compositor)
- `alacritty/` (terminal emulator)
- `htop/` (system monitor)
- `Thunar/` (file manager)
- `swaylock/` (lock screen)
- `wlogout/` (logout menu)
- `xfce4/` (XFCE components)
- `.lock/` (lock screen assets)
- `.wallpapers/` (wallpaper assets)
- `user-dirs.dirs`, `user-dirs.locale` (XDG directories)
- `make_project.py`, `move_files.py` (utility scripts)

## Merge Strategy

### Phase 1: Prepare Main Branch
1. Create new `main` branch from `cachyos/niri` (has all submodules)
2. Clean up temporary directories (`*_tmp` folders)
3. Verify all submodules are properly initialized and pointing to correct commits

### Phase 2: Organize Directory Structure
Create OS-specific directories to avoid conflicts:

```
dotfiles/
├── .gitmodules                    # Submodule definitions
├── nvim/                          # Submodule
├── rofi/                          # Submodule
├── hypr/                          # Submodule
├── niri/                          # Submodule
├── zsh/                           # Submodule
├── tmux/                          # Submodule
├── kanata/                        # Submodule
├── kitty/                         # Submodule
├── waybar/                        # Submodule
├── shared/                        # NEW: Shared configs across all systems
│   ├── bin/
│   ├── scripts/
│   ├── themes/
│   ├── wallpapers/
│   └── run.sh
├── cachyos/                       # NEW: CachyOS-specific configs
│   ├── dunst/
│   ├── wal/
│   ├── waypaper/
│   ├── nix-files/
│   └── package-manager/
├── nixos/                         # NEW: NixOS-specific configs
│   ├── flake.nix
│   ├── flake.lock
│   ├── hosts/
│   └── stow/
└── arch-i3/                       # NEW: Arch i3-specific configs
    ├── i3/
    ├── polybar/
    ├── picom/
    ├── alacritty/
    ├── htop/
    ├── Thunar/
    ├── swaylock/
    ├── wlogout/
    ├── xfce4/
    ├── .lock/
    └── .wallpapers/
```

### Phase 3: Merge nixos Branch
1. Checkout nixos branch
2. Copy NixOS-specific files to staging area:
   - `flake.nix` → `nixos/flake.nix`
   - `flake.lock` → `nixos/flake.lock`
   - `hosts/` → `nixos/hosts/`
   - `stow/` → `nixos/stow/`
3. Switch back to main branch
4. Add and commit NixOS configurations

### Phase 4: Merge arch/i3 Branch
1. Checkout arch/i3 branch
2. Copy Arch i3-specific files to staging area:
   - `i3/` → `arch-i3/i3/`
   - `polybar/` → `arch-i3/polybar/`
   - `picom/` → `arch-i3/picom/`
   - `alacritty/` → `arch-i3/alacritty/`
   - `htop/` → `arch-i3/htop/`
   - `Thunar/` → `arch-i3/Thunar/`
   - `swaylock/` → `arch-i3/swaylock/`
   - `wlogout/` → `arch-i3/wlogout/`
   - `xfce4/` → `arch-i3/xfce4/`
   - `.lock/` → `arch-i3/.lock/`
   - `.wallpapers/` → `arch-i3/.wallpapers/`
   - `user-dirs.*` → `arch-i3/`
   - `*.py` scripts → `arch-i3/scripts/`
3. Switch back to main branch
4. Add and commit Arch i3 configurations

### Phase 5: Reorganize CachyOS-specific Files
1. Move CachyOS-specific configs to `cachyos/` directory:
   - `dunst/` → `cachyos/dunst/`
   - `wal/` → `cachyos/wal/`
   - `waypaper/` → `cachyos/waypaper/`
   - `nix-files/` → `cachyos/nix-files/`
   - `package-manager/` → `cachyos/package-manager/`

2. Move shared configs to `shared/` directory:
   - `bin/` → `shared/bin/`
   - `scripts/` → `shared/scripts/`
   - `themes/` → `shared/themes/`
   - `wallpapers/` → `shared/wallpapers/`
   - `run.sh` → `shared/run.sh`

3. Update any path references in scripts

### Phase 6: Update Installation Scripts
Update scripts in `shared/bin/` to handle the new directory structure:
- Modify installation scripts to reference correct submodule paths
- Update `run.sh` to work with new structure
- Add OS detection logic to determine which configs to install

### Phase 7: Update Documentation
1. Create/Update README.md with:
   - New directory structure explanation
   - Installation instructions per OS
   - Submodule update instructions
   - Contributing guidelines

2. Document how to:
   - Clone the repository with submodules
   - Update specific submodules
   - Use OS-specific configurations
   - Add new configurations

### Phase 8: Finalize and Push
1. Clean up any remaining temporary directories
2. Update `.gitignore` if needed
3. Verify all submodules are at correct commits
4. Create comprehensive commit message
5. Push to remote and set as default branch
6. Update branch protection rules (optional)

## Commands Summary

```bash
# Phase 1: Create main branch from cachyos/niri
git checkout cachyos/niri
git checkout -b main
rm -rf *_tmp/  # Clean temporary directories
git add -A
git commit -m "chore: clean up temporary directories"

# Phase 2-5: Reorganization (multiple commits)
# ... detailed commands during implementation ...

# Phase 8: Push and set as default
git push -u origin main
gh repo edit --default-branch main  # Set as default branch on GitHub
```

## Risks and Mitigation

### Risk 1: Submodule Conflicts
**Mitigation:** The current branch (cachyos/niri) already has all submodules properly configured. We'll preserve `.gitmodules` throughout.

### Risk 2: Path Reference Breakage
**Mitigation:** Systematically update all scripts that reference moved directories. Test installation scripts after reorganization.

### Risk 3: Lost Configurations
**Mitigation:** No files will be deleted, only moved. Keep original branches intact as backup until merge is verified.

### Risk 4: Merge Conflicts
**Mitigation:** We're not using `git merge` but rather manual file copying/moving to avoid conflicts. This gives us full control over the final structure.

## Verification Checklist

After implementation, verify:
- [ ] All 9 submodules are present and initialized
- [ ] Submodule URLs are correct in `.gitmodules`
- [ ] Each OS-specific directory contains expected files
- [ ] Shared directory contains common utilities
- [ ] Installation scripts reference correct paths
- [ ] No `*_tmp` directories remain
- [ ] README documentation is up to date
- [ ] Branch can be cloned fresh with: `git clone --recurse-submodules`
- [ ] Submodules can be updated with: `git submodule update --remote`

## Post-Merge Actions

1. Update remote default branch to `main`
2. Archive or delete old branches (optional, recommended to keep as backup)
3. Update any CI/CD configurations pointing to old branches
4. Notify collaborators of new structure
5. Update any external documentation referencing the repository

## Rollback Plan

If issues arise:
1. Original branches (`cachyos/niri`, `nixos`, `arch/i3`) remain intact
2. Can delete `main` branch and restart
3. All submodule repositories are independent and unaffected

## Timeline Estimate

- Phase 1: 5 minutes
- Phase 2: 10 minutes
- Phase 3: 10 minutes
- Phase 4: 15 minutes
- Phase 5: 15 minutes
- Phase 6: 20 minutes
- Phase 7: 15 minutes
- Phase 8: 10 minutes
- **Total: ~1.5-2 hours** (including testing)
