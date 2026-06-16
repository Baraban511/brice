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
    discord
    vlc
    joplin-desktop
    ente-auth
    wallust
    bitwarden-desktop
    hyprsunset
    distrobox
    hyprshutdown
    seahorse # Gnome keyring manager
    eog # Image viewer
    libheif # HEIC image support for Nautilus
    libheif.out # For thumbnail support of HEIC images in Nautilus
    cliphist # Clipboard manager
    podman-compose
    networkmanagerapplet # For managing wifi connections in the system tray
    ffmpeg-headless # For thumbnail support of videos in Nautilus
    ffmpegthumbnailer # For thumbnail support of videos in Nautilus
    evince # For thumbnail support of pdf in Nautilus
    libgsf # For thumbnail support of opendocuments in Nautilus
    libnotify # notify-send
    libsecret # Allow bitwarden-desktop to store secrets
  ];
  environment.pathsToLink = [
    "share/thumbnailers"
  ]; # Allow usage of thumbnailers in nautilus

  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ]; # Temporary for bitwarden-desktop
}
