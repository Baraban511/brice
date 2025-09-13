{...}: {
  networking = {
    wireless.iwd.settings = {
      IPv6 = {
        Enabled = true;
      };
      Settings = {
        AutoConnect = true;
      };
    };
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    firewall = {
      enable = true;
    };
  };
}
