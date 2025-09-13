{
  description = "brice, barab.'s nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprlux = {
      url = "github:amadejkastelic/Hyprlux";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = ""; # Avoid darwin dependency
    };
    bags = {
      url = "path:./bags";
    };
  };

  outputs = {
    nixpkgs,
    bags,
    hyprlux,
    agenix,
    ...
  }: let
    system = "x86_64-linux";
    extraApps = {
      imports = [
        agenix.nixosModules.default
        hyprlux.nixosModules.default
      ];
      environment.systemPackages = [
        bags.packages.${system}.default
        agenix.packages.${system}.default
      ];
    };
  in {
    # NixOS configurations
    nixosConfigurations = {
      nix-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/hosts/nix-pc
          extraApps
        ];
      };

      nix-portable = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/hosts/nix-portable
          extraApps
        ];
      };
    };
  };
}
