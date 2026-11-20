{pkgs, ...}: {
  services = {
    hypridle.enable = true;
    accounts-daemon.enable = true; # Needed by regreet to access user accounts
    fwupd.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = "greeter";
          command = "tuigreet --config /etc/greetd/tuigreet.toml --user barab --cmd start-hyprland";
        };
        terminal = {
          vt = 1;
        };
      };
    };
    avahi = {
      # mDNS, IPv4
      enable = true;
      nssmdns4 = true;
      openFirewall = false;
    };
    flatpak.enable = true;
    # cloudflare-warp.enable = true;
    gvfs.enable = true; # For nautilus
    upower.enable = true; # For battery
    gnome.gnome-keyring.enable = true;
    gnome.sushi.enable = true; # Nautilus previewer
  };
}
