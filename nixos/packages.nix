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
        rebuild = "git -C /home/barab/brice add . && sudo nixos-rebuild switch --flake /home/barab/brice/";
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
    ### Screenshots
    grim
    swappy
    slurp
    gnome-frog
    ### Development
    bun
    gh
    zed-editor-fhs
    alejandra # Nix formatter
    nixd
    nil
    rustup
    gcc
    nodejs
    hyprls
    ### Needed
    kitty # Terminal
    hyprpaper # Wallpaper utility
    hyprpolkitagent
    nautilus # File manager
    gnome-themes-extra
    adwaita-icon-theme
    bibata-cursors
    greetd.regreet # reGreet
    hyprlock
    albert
    imagemagick
    jq
    bc
    curl
    wl-clipboard
    ### System helpers
    rclone
    fastfetch
    btop # Ressource monitor
    gnome-disk-utility
    pavucontrol
    nwg-look # GTK theme editor
    caligula
    ### Utilities
    rquickshare
    localsend
    chromium
    beeper
    spotify
    discord
    vlc
  ];

  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons

      # normal fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.fira-code
      nerd-fonts.noto
      fira-code-symbols
      adwaita-icon-theme
    ]; # List fonts : convert -list font | grep -i mono

    enableDefaultPackages = false;
    # fontconfig.useEmbeddedBitmaps = true; # Fix for firefox color emojis

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
