{
  description = "Nixos config flake";

  inputs = {
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
    };
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms.url = "github:AvengeMedia/DankMaterialShell";
  };

  outputs = { self, nix-ld, nixpkgs, ... }@inputs:
    let
      # system = "x86_64-linux";
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs; inherit system;
        };
        modules = [
          ./hosts/default/configuration.nix
          inputs.grub2-themes.nixosModules.default
          nix-ld.nixosModules.nix-ld
          { programs.nix-ld.dev.enable = true; }
        ];
      };
    };
}
