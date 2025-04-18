{ config, lib, pkgs, ... }:
{
imports = [];
networking.firewall = {
  allowedUDPPorts = [ 4242 ];
};

  services.avahi = { # mDNS, IPv4
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
boot.loader.systemd-boot.enable = true; # Systemd boot
boot.loader.efi.canTouchEfiVariables = true;

networking.networkmanager.enable = true;  # Networkmanager for networking

time.timeZone = "Europe/Paris"; # Time zone

i18n.defaultLocale = "fr_FR.UTF-8"; # Internationalisation properties.
console = {
   font = "Lat2-Terminus16";
   keyMap = "fr";
};

nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Enable flakes and New ClI
services.printing.enable = true; # CUPS to manage printers
services.pipewire = { # Sound manager
   enable = true;
   pulse.enable = true;
 };

# Define a user account. Don't forget to set a password with ‘passwd’.
users.users.barab = {
   isNormalUser = true;
   home = "/home/barab";
   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
 };

services.greetd = {
  enable = true;
  settings = {
    default_session = {
        command = "Hyprland --config /etc/greetd/hyprland.conf";
      };
  };
};

services.flatpak.enable = true;
services.cloudflare-warp.enable = true;
services.gvfs.enable = true; # For nautilus
services.upower.enable = true; # For Astal battery
programs.git = {
  enable = true;
};
programs.starship = {
    enable = true;
    # custom settings
    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
    };
  };
programs.bash = {
    completion.enable = true;
    shellAliases = { # Shell aliases
      zed = "zeditor";
      brice = "zeditor brice && exit";
      rebuild = "sudo nixos-rebuild switch --flake /home/barab/brice/";
    };
    interactiveShellInit = ''
          if [[ -z $WAYLAND_DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
            exec Hyprland
          fi
        '';
  };
programs.firefox.enable = true;
programs.hyprland.enable = true;
programs.kdeconnect.enable = true;
programs.neovim.enable = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
  environment.systemPackages = with pkgs; [
    kitty # Terminal
    nautilus # File manager
    fastfetch
    walker # Launcher
    hyprpaper # Wallpaper utility
    hyprpolkitagent
    zed-editor
    bun
    gh
    nixd # Nix language server
    nil
    brightnessctl
    grim # Screenshots
    gnome-themes-extra
    bibata-cursors
    greetd.regreet # reGreet
    gnome-disk-utility
    btop # Ressource monitor
    nwg-look # GTK theme editor
    lan-mouse
    rquickshare
    localsend
];
fonts.packages = with pkgs; [
  noto-fonts
  noto-fonts-emoji
  fira-code
  fira-code-symbols
];
# Allowing unfree packages
nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "cloudflare-warp"
];
# Définir le curseur globalement
environment.variables = {
  XCURSOR_THEME = "Bibata-Modern-Classic";
  XCURSOR_SIZE = "16";
  HYPRLAND_CONFIG = "brice/config/hypr/hyprland.conf";
  EDITOR="zeditor --wait";
  KITTY_CONFIG_DIRECTORY="/home/barab/brice/config/";
};

environment.sessionVariables.NIXOS_OZONE_WL = "1"; # Hint Electron apps to use Wayland
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 4321 ];
  };
}
