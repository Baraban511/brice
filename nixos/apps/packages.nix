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
    cargo
    rustc
    rust-analyzer
    rustfmt
    gcc
    nodejs
    hyprls
    ### Needed
    kitty # Terminal
    awww # Wallpaper utility
    hyprpolkitagent
    nautilus # File manager
    gnome-themes-extra # Adwaita
    morewaita-icon-theme
    bibata-cursors
    regreet
    hyprlock
    rofi
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
    hyprsunset
    distrobox
    hyprshutdown
    seahorse
    eog # Image viewer
    libheif # HEIC image support for Nautilus / EOG?
    #libheif.out # For thumbnail support of HEIC images in Nautilus
    cliphist
    podman-compose
    networkmanagerapplet
  ];
}
