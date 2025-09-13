{pkgs, ...}: {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        zed = "zeditor";
        brice = "zeditor brice && exit";
        rebuild = "git -C /home/barab/brice add . && sudo nixos-rebuild switch --flake /home/barab/brice/";
        update = "nix flake update --flake /home/barab/brice && nix flake update --flake /home/barab/brice/bags && flatpak update --noninteractive";
      };

      histSize = 1000;
      histFile = "$HOME/.zsh_history";
    };
    obs-studio = {
      enable = true; # Screen recording utility
      plugins = with pkgs.obs-studio-plugins; [
        obs-vaapi # Enable GPU Hardware encoder through NVidia
        obs-backgroundremoval # Replace background in portait video & image
      ];
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      gamescopeSession.enable = true;
    };
    gamescope.enable = true;

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
        optimize = "sudo nix-store --optimize && nix-store --gc";
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
      # vibrance_configs = [
      #   {
      #     window_class = "steam_app_1172470";
      #     window_title = "Apex Legends";
      #     strength = 100;
      #   }
      # ];
    };
  };
}
