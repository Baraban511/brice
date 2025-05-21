{
  description = "brice, barab.'s nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprlux = {
      url = "github:amadejkastelic/Hyprlux";
    };

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bags = {
      url = "path:./bags";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.ags.follows = "ags"; # Assurez-vous que bags utilise le même ags
    };
  };

  outputs = {
    self,
    nixpkgs,
    bags,
    hyprlux,
    ...
  }: let
    system = "x86_64-linux";

    # Module commun pour inclure bags dans les deux configurations
    bagsModule = {
      environment.systemPackages = [
        bags.packages.${system}.default # Utilisez le package par défaut du flake bags
      ];
    };
  in {
    packages.${system} = {
      bags = bags.packages.${system}.default;
    };
    # NixOS configurations
    nixosConfigurations = {
      nix-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/hosts/nix-pc
          hyprlux.nixosModules.default
          bagsModule
          {
            environment.etc."greetd/hyprland.conf".source = "${self}/config/greetd/hyprland.conf";
            environment.etc."gtk-3.0/settings.ini".source = "${self}/config/gtk-3.0.ini";
            environment.etc."greetd/regreet.toml".source = "${self}/config/greetd/regreet.toml";
            environment.etc."greetd/regreet.png".source = "${self}/wallpapers/regreet.png";
          }
        ];
      };

      nix-portable = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/hosts/nix-portable
          hyprlux.nixosModules.default
          bagsModule
          {
            environment.etc."greetd/hyprland.conf".source = "${self}/config/greetd/hyprland.conf";
            environment.etc."gtk-3.0/settings.ini".source = "${self}/config/gtk-3.0.ini";
            environment.etc."greetd/regreet.toml".source = "${self}/config/greetd/regreet.toml";
            environment.etc."greetd/regreet.png".source = "${self}/wallpapers/regreet.png";
          }
        ];
      };
    };
  };
}
