{
  description = "brice, barab.'s nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = ""; # Avoid darwin dependency
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {
    nixpkgs,
    agenix,
    nixos-hardware,
    ...
  }: let
    system = "x86_64-linux";
    extraApps = {
      imports = [
        agenix.nixosModules.default
      ];
      environment.systemPackages = [
        agenix.packages.${system}.default
      ];
    };
  in {
    # NixOS configurations
    nixosConfigurations = {
      nix-pc = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/hosts/nix-pc
          extraApps
        ];
      };

      nix-portable = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/hosts/nix-portable
          extraApps
        ];
      };

      nix-frame = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/hosts/nix-frame
          extraApps
          nixos-hardware.nixosModules.framework-amd-ai-300-series
        ];
      };

      default = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/hosts/default
          extraApps
        ];
      };
    };
  };
}
