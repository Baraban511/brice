{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../global.nix
  ];
  environment.variables = {
    BAGS_TYPE = "pc";
  };
  networking = {
    hostName = "nix-pc";
  };
  users.users.barab.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG9E0eLPf83egy9vJdwO01w7P9oIGsWRN2Sx/2mrdwQu nix-portable"
  ];
  services = {
    openssh = {
      enable = true;
      ports = [22];
      startWhenNeeded = true;
      banner = "Hi there...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                                                %%
%%                                                                                                %%
%%                                                                                                %%
%%   %%%%%%%%%%%           %%%%       %%%%%%%%%%%          %%%%        %%%%%%%%%%%                %%
%%   %%%%%%%%%%%%%         %%%%       %%%%%%%%%%%%%        %%%%        %%%%%%%%%%%%               %%
%%   %%%       %%%%       %%%%%%      %%%%      %%%%      %%%%%%       %%%       %%%              %%
%%   %%%       %%%%       %%%%%%%     %%%%      %%%%      %%%%%%%      %%%       %%%              %%
%%   %%%      %%%%       %%%  %%%     %%%%      %%%%     %%%  %%%      %%%     %%%%%              %%
%%   %%%%%%%%%%%%%%     %%%%  %%%%    %%%%      %%%%    %%%%  %%%%     %%%%%%%%%%%%%              %%
%%   %%%       %%%%%    %%%    %%%    %%%%%%%%%%%%%     %%%    %%%     %%%       %%%%%            %%
%%   %%%         %%%%  %%%%%%%%%%%%   %%%%%%%%%%%      %%%%%%%%%%%%    %%%         %%%            %%
%%   %%%         %%%%  %%%%%%%%%%%%%  %%%%   %%%%      %%%%%%%%%%%%%   %%%         %%%            %%
%%   %%%%%%%%%%%%%%%  %%%        %%%  %%%%     %%%    %%%        %%%   %%%%%%%%%%%%%%%   %%%%     %%
%%   %%%%%%%%%%%%%%  %%%%        %%%% %%%%      %%%%  %%%        %%%%  %%%%%%%%%%%%%     %%%%     %%
%%                                                                                                %%
%%                                                                                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
";
      settings = {
        PasswordAuthentication = false;
        AllowUsers = ["barab"];
        UseDns = true;
        PermitRootLogin = "no";
      };
    };
    fail2ban.enable = true; # SSH brute-force protection
    blueman.enable = true; # GUI Bluetooth manager
    hardware.openrgb.enable = true;
    sunshine = {
      enable = true;
      autoStart = true;
      openFirewall = true;
      capSysAdmin = true;
    };
  };

  hardware = {
    bluetooth.enable = true; # Enable support for Bluetooth
    i2c.enable = true;
  };
  virtualisation.waydroid.enable = true;
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev"; # Empêche l'installation sur un périphérique spécifique
      useOSProber = true; # Active la détection automatique des autres systèmes
      default = "2";
      theme = "${pkgs.catppuccin-grub}";
      splashImage = "/home/barab/brice/wallpapers/boot.png";
    };
    timeout = 10;
    efi.canTouchEfiVariables = true;
  };
  # hardware.printers = {
  #   ensureDefaultPrinter = "Samsung_M2020";
  #   ensurePrinters = [
  #     {
  #       deviceUri = "ipp://192.168.1.174/ipp";
  #       location = "home";
  #       name = "Samsung_M2020";
  #       model = "everywhere";
  #     }
  #   ];
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Needed
    hyperhdr
    catppuccin-grub
    ddcutil
    sunshine
    catppuccinifier-cli
    # In tests
    openrgb-with-all-plugins
    ledfx
    #ente-auth
    zettlr
    typst
    rclone
    postman
  ];
  # systemd.services.monitor-on = {
  #   description = "Allumer le moniteur via DDC/CI au démarrage";
  #   wantedBy = ["multi-user.target"];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.ddcutil}/bin/ddcutil setvcp D6 01";
  #   };
  # };
  # systemd.services.monitor-off = {
  #   description = "Éteindre le moniteur via DDC/CI à l'arrêt";
  #   wantedBy = ["shutdown.target"];
  #   before = ["shutdown.target"];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.ddcutil}/bin/ddcutil setvcp D6 05";
  #   };
  # };

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
