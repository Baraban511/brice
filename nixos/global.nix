{config, ...}: {
  age = {
    identityPaths = ["/home/barab/.ssh/id_ed25519" "/home/barab/age_ed25519"];
    secrets.unsplash = {
      file = ../secrets/unsplash.age;
      owner = "barab";
    };
    secrets.rclone = {
      file = ../secrets/rclone.conf;
      owner = "barab";
    };
    secrets.joplin = {
      file = ../secrets/joplin.json;
      path = "/home/barab/.config/joplin-desktop/settings.json";
      owner = "barab";
    };
  };

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "text/plain" = "zed.desktop";
      "text/markdown" = "zed.desktop";
      "text/x-nix" = "zed.desktop";
      "application/json" = "zed.desktop";
      "text/json" = "zed.desktop";
      "text/css" = "zed.desktop";
      "text/html" = "zed.desktop";
      "image/png" = "eog";
      "image/jpeg" = "eog";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  environment = {
    etc = {
      "xdg/gtk-2.0/gtkrc".text = "gtk-error-bell=0";
      "xdg/gtk-3.0/settings.ini".text = ''
        [Settings]
        gtk-error-bell=false
      '';
      "xdg/gtk-4.0/settings.ini".text = ''
        [Settings]
        gtk-error-bell=false
      '';
      "greetd".source = ../config/greetd;
      regreet-session = {
        text = ''
          last_user = "barab"

          [user_to_last_sess]
          barab = "Hyprland"
        '';
        target = "regreet/state.toml";
      };
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1"; # Hint Electron apps to use Wayland
      RCLONE_CONFIG = config.age.secrets.rclone.path;
    };
    variables = {
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "16";
      HYPRLAND_CONFIG = "brice/config/hyprland/hyprland.lua";
      EDITOR = "zeditor --wait";
      KITTY_CONFIG_DIRECTORY = "/home/barab/brice/config/kitty";
      XDG_SESSION_DESKTOP = "Hyprland";
      UNSPLASH_API_KEY = config.age.secrets.unsplash.path;
      BROWSER = "firefox";
    };
  };

  imports = [
    ./apps/global.nix
    ./system/global.nix
  ];
}
