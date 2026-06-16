{pkgs, ...}: {
  hardware = {
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Experimental = true; # To access devices battery level
        };
      };
    };
  };
  services = {
    pipewire.wireplumber.extraConfig = {
      "bluetooth" = {
        "monitor.bluez.properties" = {
          "bluez5.codecs" = ["sbc_xq" "aac" "aptx" "aptx_hd" "ldac" "lhdc"]; # List codecs I want to use, no "sbc" to force sbc_xq
        };
      };
    };
    pulseaudio.extraConfig = "
      load-module module-switch-on-connect
    "; # This automatically switches to the newly connected Bluetooth audio device.
  };

  environment.systemPackages = with pkgs; [
    overskride
  ];
}
