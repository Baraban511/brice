{pkgs, ...}: {
  system = {
    userActivationScripts = {
      linkHypr = "ln -sfn /home/barab/brice/config/hypr /home/barab/.config/";
      linkZed = "ln -sfn /home/barab/brice/config/zed /home/barab/.config/";
      linkFastfetch = "ln -sfn /home/barab/brice/config/fastfetch /home/barab/.config/";
      linkAlbert = "ln -sfn /home/barab/brice/config/albert /home/barab/.config/";
      mkdirRclone = "mkdir -p /home/barab/rclone/Onedrive /home/barab/rclone/Cloudflare /home/barab/rclone/Freebox";
    };
    activationScripts = {
      linkWallpaper = "ln -f /home/barab/brice/wallpapers/unsplash.jpg /etc/unsplash.jpg";
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
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
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  users.defaultUserShell = pkgs.zsh;
  imports = [
    ./boot.nix
    ./networking.nix
    ./systemd.nix
  ];
}
