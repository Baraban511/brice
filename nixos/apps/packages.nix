{pkgs, ...}: {
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
