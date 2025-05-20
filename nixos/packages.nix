{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true; # Allowing unfree packages
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = false; # Open ports in the firewall for Steam Local Network Game Transfers
    };
    git = {
      enable = true;
    };
    starship = {
      enable = true;
      # custom settings
      settings = {
        aws.disabled = true;
        gcloud.disabled = true;
      };
    };
    bash = {
      completion.enable = true;
      shellAliases = {
        # Shell aliases
        zed = "zeditor";
        brice = "zeditor brice && exit";
        rebuild = "sudo nixos-rebuild switch --flake /home/barab/brice/";
      };
      interactiveShellInit = ''
        if [[ -z $WAYLAND_DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
          exec Hyprland
        fi
      '';
    };
    firefox.enable = true;
    hyprland.enable = true;
    kdeconnect.enable = true;
    neovim.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kitty # Terminal
    nautilus # File manager
    fastfetch
    walker # Launcher
    hyprpaper # Wallpaper utility
    hyprpolkitagent
    bun
    gh
    brightnessctl
    grim # Screenshots
    gnome-themes-extra
    bibata-cursors
    greetd.regreet # reGreet
    gnome-disk-utility
    btop # Ressource monitor
    nwg-look # GTK theme editor
    rquickshare
    localsend
    rustup
    zed-editor-fhs
    alejandra # Nix formatter
    nixd
    nil
    chromium
    beeper
    pavucontrol
    kitty # Terminal
    nautilus # File manager
    fastfetch
  ];

  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons

      # normal fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      fira-code
      fira-code-symbols
    ];

    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = ["Noto Serif"];
      sansSerif = ["Noto Sans"];
      monospace = ["FiraCode Mono"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
