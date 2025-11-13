{ config, pkgs, inputs, system, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./programs.nix
      ./services.nix
    ];

  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback.out
  ];
  # boot.loader.systemd-boot.enable = true;
  boot.loader = {
    grub = {
      enable = true;
      useOSProber = true;
      copyKernels = true;
      efiSupport = true;
      fsIdentifier = "label";
      devices = [ "nodev" ];
      extraEntries = ''
        menuentry "Reboot" {
            reboot
        }
        menuentry "Poweroff" {
            halt
        }
      '';
    };
  };
  boot.loader.grub2-theme = {
    enable = true;
    theme = "vimix";
    footer = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  security.polkit.enable = true;
  virtualisation.docker.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.fantasque-sans-mono
    fira-sans
    font-awesome
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware = {
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
    graphics = {
      enable = true;
    };
  };

  networking = {
    firewall = {
      enable = false;
      # allowedTCPPorts = [ 22 8081 ];
      # allowedUDPPorts = [ 8081 ];
    };
    networkmanager = {
      enable = true;
      dns = "none";
    };
    useDHCP = false;
    dhcpcd.enable = false;

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
      "8.8.4.4"
    ];
  };

  time.timeZone = "Asia/Kolkata";

  users.users.alpha = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "kvm" "adbusers" "uniput" ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    packages = with pkgs; [
      tree
      brightnessctl
      blueman
      neofetch
    ];
  };

  security.rtkit.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}

