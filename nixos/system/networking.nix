{...}: {
  hardware.wirelessRegulatoryDatabase = true;
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom="FR"
  ''; # Ensure no international limitation is applied to wifi card
  networking = {
    wireless = {
      iwd = {
        enable = true;
        settings = {
          Network = {
            EnableIPv6 = true;
          };
          Settings = {
            AutoConnect = true;
          };
          General = {
            EnableNetworkConfiguration = true;
            AddressRandomization = "network";
          };
        };
      };
    };
    networkmanager = {
      enable = true;
      wifi.powersave = true;
      wifi.backend = "iwd";
      insertNameservers = [
        "1.1.1.1"
        "1.0.0.1"
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"
        "8.8.8.8"
        "2001:4860:4860::8888"
      ];
    };
    firewall = {
      enable = true;
    };
  };
}
