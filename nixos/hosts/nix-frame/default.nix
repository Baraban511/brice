{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../global.nix
    ../../system/bluetooth.nix
  ];
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16 GB
      options = ["discard"];
    }
  ];
  zramSwap.enable = true;
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
  networking.hostName = "nix-frame";
  hardware = {
    graphics.enable = true;
    enableAllFirmware = true;
    sensor.iio.enable = true; # Needed for desktop environments to detect/manage display brightness
    bluetooth.powerOnBoot = true;
  };
  services = {
    logind.settings.Login = {
      HandlePowerKey = "lock";
      HandlePowerKeyLongPress = "poweroff";
    };

    libinput.enable = true;
    fprintd.enable = true; # For fingerprint support
    auto-cpufreq.enable = true;
    power-profiles-daemon.enable = false; # To bypass nixos-hardware
    tlp.enable = false; # To bypass nixos-harware
  };

  environment = {
    systemPackages = with pkgs; [
      brightnessctl
      snapshot # Camera app
      scrcpy # For using Android phone as webcam
      hyprpwcenter
      prismlauncher # Goated minecraft client
    ];
    variables = {
      AWWW_TRANSITION_FPS = "120";
      BELL_TYPE = "portable";
    };
  };
  programs = {
    steam = {
      enable = true;
    };
    zsh.shellAliases = {
      wifi = "nmtui";
    };
  };

  fileSystems."/boot".options = ["umask=0077"]; # Supposed to fix warnings about secret seed

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #clearcpuid=rdseed
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
