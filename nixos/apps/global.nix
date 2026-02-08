{...}: {
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
    waydroid.enable = false;
  };

  nixpkgs.config.allowUnfree = true; # Allowing unfree packages

  imports = [
    ./packages.nix
    ./programs.nix
    ./services.nix
  ];
}
