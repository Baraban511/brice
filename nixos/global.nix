{pkgs, ...}: {
  imports = [
    ./packages.nix
    ./services.nix
  ];
  system.userActivationScripts = {
    linkHypr = "ln -s /home/barab/brice/config/hypr /home/barab/.config/";
    linkZed = "ln -s /home/barab/brice/config/zed /home/barab/.config/";
  };
  networking = {
    networkmanager.enable = true; # Networkmanager for networking
    firewall = {
      enable = true;
    };
  };
  nix = {
    channel.enable = false;
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    settings.experimental-features = ["nix-command" "flakes"]; # Enable flakes and New ClI
  };

  boot = {
    plymouth = {
      enable = true;
      theme = "catppuccin-macchiato";
      themePackages = with pkgs; [
        catppuccin-plymouth
      ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };

  time.timeZone = "Europe/Paris"; # Time zone

  i18n.defaultLocale = "fr_FR.UTF-8"; # Internationalisation properties.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };
  xdg.mime = {
    enable = true;
    defaultApplications = {
      "text/plain" = "zed.desktop";
      "text/markdown" = "zed.desktop";
      "text/x-nix" = "zed.desktop";
      "application/json" = "zed.desktop";
      "text/json" = "zed.desktop";
      "text/css" = "zed.desktop";
    };
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.barab = {
    isNormalUser = true;
    home = "/home/barab";
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
  };
  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1"; # Hint Electron apps to use Wayland
    variables = {
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "16";
      HYPRLAND_CONFIG = "brice/config/hypr/hyprland.conf";
      EDITOR = "zeditor --wait";
      KITTY_CONFIG_DIRECTORY = "/home/barab/brice/config";
      XDG_SESSION_DESKTOP = "Hyprland";
    };
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
