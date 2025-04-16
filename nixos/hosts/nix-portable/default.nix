{ config, lib, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../global.nix
    ];
    networking.hostName = "nix-portable";
  programs.bash.shellAliases = {
    wifi = "nmtui";
  };
  services.libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).
  hardware.bluetooth.enable = true; # Enable support for Bluetooth
  services.blueman.enable = true; # GUI Bluetooth manager

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [];
  # Allowing unfree packages
  #nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [];
  # Définir le curseur globalement
  #environment.variables = {};
  #networking.firewall = {
    # allowedTCPPorts = [ 4321 ];
    #};
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true; # not supported by flakes

  # This option defines the firEDITOR="zeditor --wait"st version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
