{pkgs, ...}: {
  programs = {
    dconf = {
      enable = true;
      profiles.user.databases = [
        {
          settings."org/gnome/desktop/interface" = {
            gtk-theme = "Adwaita-dark";
            icon-theme = "Adwaita";
            font-name = "Noto Sans Medium 11";
            document-font-name = "Noto Sans Medium 11";
            monospace-font-name = "Noto Sans Mono Medium 11";
            color-scheme = "prefer-dark";
          };
        }
      ];
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        zed = "zeditor";
        wifi = "nmtui";
        brice = "zeditor brice && exit";
        rebuild = "git -C /home/barab/brice add . && sudo nixos-rebuild switch --flake /home/barab/brice/";
        update = "nix flake update --flake /home/barab/brice && flatpak update --noninteractive";
        optimize = "sudo nix-store --optimize && nix-store --gc";
      };

      histSize = 1000;
      histFile = "$HOME/.zsh_history";
    };
    obs-studio = {
      enable = true; # Screen recording utility
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-vaapi # Enable GPU Hardware encoder through NVidia
        obs-backgroundremoval # Replace background in portait video & image
      ];
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
