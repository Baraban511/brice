{ config, lib, pkgs, ... }:
{
imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];



  # Use the systemd-boot EFI boot loader.
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

networking.hostName = "Nixos"; # Define your hostname.
networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

# Set your time zone.
time.timeZone = "Europe/Paris";

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Select internationalisation properties.
i18n.defaultLocale = "fr_FR.UTF-8";
console = {
   font = "Noto Sans 11";
   keyMap = "fr";
   # useXkbConfig = true; # use xkb.options in tty.
};
# Enable the X11 windowing system.
# services.xserver.enable = true;

nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Configure keymap in X11
# services.xserver.xkb.layout = "fr";
# services.xserver.xkb.options = "eurosign:e,caps:escape";

# Enable CUPS to print documents.
services.printing.enable = true;

# Enable sound.
services.pipewire = {
   enable = true;
   pulse.enable = true;
 };
# Aliases
programs.bash.shellAliases = {
  zed = "zeditor";
  brice = "zeditor brice && exit";
  wifi = "nmtui";
  rebuild = "sudo nixos-rebuild switch";
};
services.libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).
hardware.bluetooth.enable = true; # Enable support for Bluetooth

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
services.blueman.enable = true; # GUI Bluetooth manager
services.upower.enable = true; # For Astal battery

programs.firefox.enable = true;
programs.hyprland.enable = true;
programs.git.enable = true;
programs.kdeconnect.enable = true;
programs.neovim.enable = true;
programs.neovim.defaultEditor = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
  environment.systemPackages = with pkgs; [
    kitty
    nautilus # File manager
    fastfetch
    walker
    hyprpaper
    hyprpolkitagent
    zed-editor
    bun
    gh
    wrangler
    nixd # Nix language daemon
    nil # Nix language server
    brightnessctl
    starship
    grim # Screenshots
    gnome-themes-extra
    bibata-cursors
    greetd.regreet
    gnome-disk-utility
    btop # Ressource monitor
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
};

environment.sessionVariables.NIXOS_OZONE_WL = "1"; # Hint Electron apps to use Wayland
environment.etc."greetd/hyprland.conf".source = /home/barab/brice/config/greetd/hyprland.conf;
environment.etc."gtk-3.0/settings.ini".source = /home/barab/brice/config/gtk-3.0.ini;
environment.etc."greetd/regreet.toml".source = /home/barab/brice/config/greetd/regreet.toml;
environment.etc."greetd/wallpaper.png".source = /home/barab/brice/assets/wallpapers/regreet.png;
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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
system.stateVersion = "24.11"; # Did you read the comment?
}
