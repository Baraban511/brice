{pkgs, ...}: {
  programs = {
    localsend.enable = true;
    dconf = {
      enable = true;
      profiles.user.databases = [
        {
          settings."org/gnome/desktop/interface" = {
            gtk-theme = "Adwaita-dark";
            icon-theme = "MoreWaita";
            font-name = "Noto Sans Medium 11";
            document-font-name = "Noto Sans Medium 11";
            monospace-font-name = "Noto Sans Mono Medium 11";
            color-scheme = "prefer-dark";
          };
        }
      ];
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
    hyprland.enable = true;
    kdeconnect.enable = true;
    neovim.enable = true;
  };
}
