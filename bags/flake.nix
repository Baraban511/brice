{
  description = "bags is my ags project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ags,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system} = {
      default = ags.lib.bundle {
        inherit pkgs;
        src = ./.;
        name = "bags";
        entry = "app.ts";

        # additional libraries and executables to add to gjs' runtime
        extraPackages = [
          ags.packages.${system}.battery
          ags.packages.${system}.wireplumber
          ags.packages.${system}.mpris
          ags.packages.${system}.network
          ags.packages.${system}.hyprland
          ags.packages.${system}.notifd
          ags.packages.${system}.tray
          ags.packages.${system}.apps
        ];
      };
    };

    devShells.${system} = {
      default = pkgs.mkShell {
        buildInputs = [
          (ags.packages.${system}.default.override {
            extraPackages = [
              ags.packages.${system}.battery
              ags.packages.${system}.wireplumber
              ags.packages.${system}.mpris
              ags.packages.${system}.network
              ags.packages.${system}.hyprland
              ags.packages.${system}.notifd
              ags.packages.${system}.tray
              ags.packages.${system}.apps
            ];
          })
        ];
      };
    };
  };
}
