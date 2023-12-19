{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      systemd-boot = {
	enable = true;
      };
      efi = {
	canTouchEfiVariables = true;
      };
    };
    supportedFilesystems = [ "ntfs" ];
    initrd = {
      kernelModules = [ "amdgpu" ];
    };
  };

  services = {
    clipmenu = {
      enable = true;
    };
    pcscd = {
      enable = true;
    };
    spice-vdagentd = {
      enable = true;
    };
    xserver = {
      enable = true;
      layout = "us";
      displayManager = {
	lightdm = {
	  enable = true;
	};
      };
      windowManager = {
        bspwm = {
	  enable = true;
	};
      };
      videoDrivers = [ "amdgpu" ];
    };
    picom = {
      enable = true;
    };
    auto-cpufreq = {
      enable = true;
    };
    gvfs = {
      enable = true;
    };
    samba = {
      openFirewall = true;
      enable = true;
    securityType = "user";
    shares = {
	public =
	{ 
	  path = "/share/public";
	  writable = "yes";
	  browsable = "yes";
	  "guest ok" = "yes";
	  comment = "Public server";
	  public = "yes";
	  "force user" = "smbuser";
	  "force group" = "smbgroup";
	  "create mask" = "0664";
	  "force create mode" = "0664";
	  "directory mask" = "0775";
	  "force directory mode" = "0775";
	};
    };
    extraConfig = ''
workgroup = WORKGROUP
map to guest = Bad User
name resolve order = bcast host
server string = File Server
    '';
    };
  };

  environment  = {
    sessionVariables = rec {
      CM_DIR = "$HOME/.config/.clipmenu/";
    };
  };

  networking = {
    wireless = {
      enable = true;
    };
    dhcpcd = {
      enable = true;
    };
    nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" ];
    firewall = {
      enable = true;
      allowPing = true;
      extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';
    };
  };

  time.timeZone = "Asia/Kolkata";

  virtualisation.libvirtd.enable = true;
  
  sound.enable = true;

  hardware = {
    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
      extraConfig = "load-module module-combine-sink";
      configFile = pkgs.runCommand "default.pa" {} ''
    sed 's/module-udev-detect$/module-udev-detect tsched=0/' \
      ${pkgs.pulseaudio}/etc/pulse/default.pa > $out
  '';
    };
    
    enableAllFirmware = true;
    bluetooth = {
      enable = true;
    };
  };

  programs = {
    gnupg = {
      agent = {
	enable = true;
	pinentryFlavor = "curses";
	enableSSHSupport = true;
      };
    };
    fish = {
      enable = true;
    };
    dconf = {
      enable = true;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      pulseaudio = true;
      packageOverrides = pkgs: {
	nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      	  inherit pkgs;
        };
      };
    };
  };

   fonts.fonts = with pkgs; [
    nerdfonts
    jetbrains-mono
  ];

  nix = {
    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
	automatic = true;
	dates = "weekly";
	options = "--delete-older-than 10d";
    };

  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alpha = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "libvirtd"]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    packages = with pkgs; [
      firefox
      tree
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    alacritty
    bspwm
    sxhkd
    git
    picom
    polybar
    feh
    fish
    neofetch
    starship
    spice-gtk
    brightnessctl
    betterlockscreen
    lm_sensors
    rofi
    xfce.thunar
    xfce.tumbler
    auto-cpufreq
    virt-manager
    home-manager
    python3Full
    nur.repos.nltch.spotify-adblock #for installing spotify-adblock
    nur.repos.nltch.ciscoPacketTracer8 #for installing packettracer8
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  }

