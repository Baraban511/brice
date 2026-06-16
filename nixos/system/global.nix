{pkgs, ...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users = {
      barab = {
        isNormalUser = true;
        extraGroups = ["wheel" "podman" "networkmanager" "plugdev" "dialout"]; #  Wheel enable ‘sudo’ for the user.
      };
      root.hashedPassword = "!"; # Disable root password
    };
  };
  system = {
    userActivationScripts = {
      linkHypr = "ln -sfn /home/barab/brice/config/hypr /home/barab/.config/";
      linkZed = "ln -sfn /home/barab/brice/config/zed /home/barab/.config/";
      linkFastfetch = "ln -sfn /home/barab/brice/config/fastfetch /home/barab/.config/";
      linkApplications = "ln -sfn /home/barab/brice/config/desktop/applications /home/barab/.local/share/";
      mkdirRclone = "mkdir -p /home/barab/rclone/Onedrive /home/barab/rclone/Cloudflare /home/barab/rclone/Freebox";
      configDir = "mkdir -p /home/barab/.config/brice";
      joplinDir = "mkdir -p /home/barab/.config/joplin-desktop";
    };
    activationScripts = {
      linkWallpaper = "ln -f /home/barab/.config/brice/unsplash.jpg /etc/unsplash.jpg";
    };
  };
  systemd.tmpfiles.rules = [
    "d /var/log/regreet 0755 greeter greeter - -"
    "d /var/lib/regreet 0755 greeter greeter - -"
  ];
  security = {
    polkit.enable = true;
    #pam.services.greetd.enableGnomeKeyring = true;
  };

  nix = {
    channel.enable = false;
    optimise.automatic = true;
    settings = {
      download-buffer-size = 524288000; # 500 MiB
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 20d";
    };
    settings.experimental-features = ["nix-command" "flakes"]; # Enable flakes and New ClI
  };
  time.timeZone = "Europe/Paris"; # Time zone

  i18n.defaultLocale = "fr_FR.UTF-8"; # Internationalisation properties.
  hardware = {
    enableRedistributableFirmware = true;
  };
  imports = [
    ./boot.nix
    ./networking.nix
    ./systemd.nix
    ./fonts.nix
    ./shell.nix
    ./audio.nix
  ];
}
