{pkgs, ...}: {
  programs = {
    localsend = {
      enable = true;
      openFirewall = true;
    };
    obs-studio = {
      enable = true; # Screen recording utility
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-vaapi
        obs-backgroundremoval # Replace background in portait video & image
      ];
    };
    git = {
      enable = true;
    };
    firefox = {
      enable = true;
      policies = import ./firefox/policies.nix;
      # preferences = ./firefox/preferences.nix;
    };
    hyprland = {
      enable = true;
      withUWSM = false;
    };
    hyprlock.enable = true;
    kdeconnect.enable = true;
    neovim.enable = true;
  };
}
