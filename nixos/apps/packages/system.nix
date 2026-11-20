{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ### Screenshots
    grim
    swappy
    slurp

    regreet
    rofi
    wl-clipboard
    fastfetch
    btop
    quickshell
    tuigreet
    kitty # Terminal
    awww
    hyprshutdown
    hyprsunset
    sbctl
    wallust
    cliphist # Clipboard manager
    hyprpolkitagent
  ];
}
