{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true; # Allowing unfree packages
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
    git = {
      enable = true;
    };
    starship = {
      enable = true;
      settings = {
        aws.disabled = true;
        gcloud.disabled = true;
      };
    };
    bash = {
      undistractMe.enable = true; # Notifications for long-running commands
      completion.enable = true;
      shellAliases = {
        # Shell aliases
        zed = "zeditor";
        brice = "zeditor brice && exit";
        rebuild = "sudo nixos-rebuild switch --flake /home/barab/brice/";
        update = "nix flake update --flake /home/barab/brice && nix flake update --flake /home/barab/brice/bags && flatpak update --noninteractive";
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
    hyprlux = {
      enable = true;
      night_light = {
        enabled = true;
        # Manual sunset and sunrise
        start_time = "22:00";
        end_time = "06:00";
        # Automatic sunset and sunrise
        latitude = 45.750000;
        longitude = 4.850000;
        temperature = 3500;
      };
      vibrance_configs = [
        # {
        #   window_class = "steam_app_1172470";
        #   window_title = "Apex Legends";
        #   strength = 100;
        # }
        # {
        #   window_class = "cs2";
        #   window_title = "";
        #   strength = 100;
        # }
      ];
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
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
    # Screenshots
    grim
    swappy
    slurp
    wl-clipboard
    gnome-themes-extra
    bibata-cursors
    greetd.regreet # reGreet
    gnome-disk-utility
    btop # Ressource monitor
    nwg-look # GTK theme editor
    rquickshare
    localsend
    rustup
    gcc
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
    hyprlock
    spotify
    discord
    nodejs
    caligula
    hyprls
    albert
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
