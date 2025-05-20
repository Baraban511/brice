{
  description = "brice, barab.'s nixos configuration and bags ags project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprlux = {
      url = "github:amadejkastelic/Hyprlux";
    };

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ags,
    hyprlux,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # NixOS configurations
    nixosConfigurations = {
      nix-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/hosts/nix-pc
          hyprlux.nixosModules.default
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
          {
            environment.etc."greetd/hyprland.conf".source = "${self}/config/greetd/hyprland.conf";
            environment.etc."gtk-3.0/settings.ini".source = "${self}/config/gtk-3.0.ini";
            environment.etc."greetd/regreet.toml".source = "${self}/config/greetd/regreet.toml";
            environment.etc."greetd/regreet.png".source = "${self}/wallpapers/regreet.png";
          }
        ];
      };
    };

    # AGS project (bags)
    packages.${system} = {
      bags = ags.lib.bundle {
        inherit pkgs;
        src = ./bags;
        name = "bags";
        entry = "app.ts";
        gtk4 = false;

        # additional libraries and executables to add to gjs' runtime
        extraPackages = [
          ags.packages.${system}.battery
          ags.packages.${system}.wireplumber
          ags.packages.${system}.mpris
          ags.packages.${system}.network
          ags.packages.${system}.hyprland
        ];
      };
    };
  };
}
