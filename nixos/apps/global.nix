{...}: {
  virtualisation = {
    docker.enable = true;
    waydroid.enable = true;
  };

  nixpkgs.config.allowUnfree = true; # Allowing unfree packages

  imports = [
    ./packages.nix
    ./programs.nix
    ./services.nix
  ];
}
