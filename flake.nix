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

    # ags = {
    #   url = "github:aylur/ags";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    bags = {
      url = "path:./bags";
      #inputs.nixpkgs.follows = "nixpkgs";
      #inputs.ags.follows = "ags"; # Assurez-vous que bags utilise le même ags
    };
  };

  outputs = {
    self,
    nixpkgs,
    bags,
    hyprlux,
    agenix,
    ...
  }: let
    system = "x86_64-linux";
    extraModules = {
      imports = [
        agenix.nixosModules.default
        hyprlux.nixosModules.default
      ];
    };

    extraPackages = {
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
          extraModules
          extraPackages
          {
            environment.etc."greetd".source = "${self}/config/greetd";
            environment.etc."gtk-3.0/settings.ini".source = "${self}/config/gtk-3.0.ini";
            environment.etc."scripts".source = "${self}/scripts";
          }
        ];
      };

      nix-portable = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/hosts/nix-portable
          extraModules
          extraPackages
          {
            environment.etc."greetd/hyprland.conf".source = "${self}/config/greetd/hyprland.conf";
            environment.etc."gtk-3.0/settings.ini".source = "${self}/config/gtk-3.0.ini";
            environment.etc."greetd/regreet.toml".source = "${self}/config/greetd/regreet.toml";
            environment.etc."greetd/regreet.jpg".source = "${self}/wallpapers/unsplash.jpg";
          }
        ];
      };
    };
  };
}
