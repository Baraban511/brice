{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../global.nix
  ];
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true; # Systemd boot
    };
  };
  networking.hostName = "nix-portable";
  # networking.firewall = {
  #   allowedTCPPorts = [1701 9001];
  # };
  programs.bash.shellAliases = {
    wifi = "nmtui";
  };
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
      ];
    };
    xone.enable = true;
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
    enableAllFirmware = true;
  };
  services = {
    openssh = {
      enable = true;
      openFirewall = false;
      knownHosts = {
        nix-pc = {
          hostNames = ["192.168.1.202" "100.96.0.1"];
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO0GFQia1VGrSKwryR0S+aJDmEDBAN5z2uio5hltmkPn nix pc";
        };
      };
    };
    libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).
    blueman.enable = true; # GUI Bluetooth manager
    ollama = {
      enable = true;
      loadModels = ["gemma3:1b"];
    };
  };
  environment = {
    systemPackages = with pkgs; [
      moonlight-qt
      brightnessctl
    ];
    variables = {
      BAGS_TYPE = "portable";
    };
    sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true; # not supported by flakes

  # This option defines the first version of NixOS you have installed on this particular machine,
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
