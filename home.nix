{config, pkgs, ... }:
{

  home.username = "alpha";
  home.homeDirectory = "/home/alpha";
  home.stateVersion = "23.05"; # Please read the comment before changing.
  
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    gcc
    booster
    obsidian
    bat
    tmux
    btop
    gdrive
    fzf
    kitty
    zsh-powerlevel10k
    oh-my-zsh
    lua
    p7zip
    python3Full
    telegram-desktop
    unzip
    usbutils
    vlc
    vscode
    whatsapp-for-linux
    discord
    cmake
    gcc
    gnumake
    cargo
    gnupg
  ];


  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/nvim/lua".source = ./nvim/lua;
    ".config/nvim/after".source = ./nvim/after;
    ".config/alacritty".source = ./alacritty;
    ".config/bspwm".source = ./bspwm;
    ".config/kitty".source = ./kitty;
    ".config/neofetch".source = ./neofetch;
    ".config/old-polybar".source = ./old-polybar;
    ".config/picom".source = ./picom;
    ".config/polybar".source = ./polybar;
    ".config/ranger".source = ./ranger;
    ".config/tint2".source = ./tint2;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  services = {
    clipmenu = {
        enable = true;
        launcher = "rofi";
    };
  };

  programs = {
    git = {
      enable = true;
      userEmail = "sharonshajan2017@gmail.com";
      userName = "Sharon218";
    };
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      withPython3 = true;
      withNodeJs = true;
      extraLuaConfig = builtins.readFile ./nvim/init.lua;
    };
    fish = { 
      enable = true; 
      shellInit = ''
	neofetch
	starship init fish | source
	set fish_greeting
    direnv hook fish | source
    export NIXPKGS_ALLOW_INSECURE=1
      '';
    };
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/alpha/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
