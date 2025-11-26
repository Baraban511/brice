{
  description = "brice, barab.'s nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = ""; # Avoid darwin dependency
    };
  };

  outputs = {
    nixpkgs,
    agenix,
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
