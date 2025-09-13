{...}: {
  services = {
    hypridle.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "Hyprland --config /etc/greetd/hyprland.conf";
          user = "greeter";
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
      openFirewall = true;
    };
    pipewire = {
      # Sound manager
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
    printing.enable = true; # CUPS to manage printers
    flatpak.enable = true;
    cloudflare-warp.enable = true;
    gvfs.enable = true; # For nautilus
    upower.enable = true; # For Astal battery
  };
  services.gnome.gnome-keyring.enable = true;
}
