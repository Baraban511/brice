{pkgs, ...}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    openssl
    curl
    gnome-disk-utility
    caligula
    chromium
    beeper
    spotify
    discord
    vlc
    joplin-desktop
    ente-auth
    distrobox
    seahorse # Gnome keyring manager
    eog # Image viewer
    podman-compose
    networkmanagerapplet # For managing wifi connections in the system tray
    libnotify # notify-send
    libreoffice
    file-roller
    typst
  ];

  imports = [
    ./packages/univ.nix
    ./packages/development.nix
    ./packages/nautilus.nix
    ./packages/system.nix
  ];
}
