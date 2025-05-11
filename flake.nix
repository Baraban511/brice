{
  description = "brice, barab.'s nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: {
    nixosConfigurations = {
      nix-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/hosts/nix-pc
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
