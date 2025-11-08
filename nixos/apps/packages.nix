{pkgs, ...}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kdePackages.qtdeclarative
    quickshell
    openssl
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
    swww # Wallpaper utility
    hyprpolkitagent
    nautilus # File manager
    gnome-themes-extra
    adwaita-icon-theme
    bibata-cursors
    regreet
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
    chromium
    beeper
    spotify
    vesktop #discord
    vlc
    joplin-desktop
    ente-auth
    wallust
    bitwarden-desktop
  ];

  fonts = {
    packages = with pkgs; [
      # Nerd Fonts (Noto & Fira Code)
      nerd-fonts.noto
      nerd-fonts.fira-code

      # material-design-icons
      # adwaita-icon-theme

      # Polices utiles / classiques
      dejavu_fonts
      liberation_ttf
      source-code-pro
      ubuntu-classic
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];

    # (optionnel) forcer une police par défaut dans le système
    fontconfig.defaultFonts = {
      monospace = ["FiraCode Nerd Font" "Source Code Pro"];
      sansSerif = ["Noto Sans" "Liberation Sans"];
      serif = ["Noto Serif" "Liberation Serif"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
