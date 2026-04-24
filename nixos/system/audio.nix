{pkgs, ...}: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.extraConfig = {
      "bluetooth" = {
        "monitor.bluez.properties" = {
          "bluez5.codecs" = ["sbc" "sbc_xq" "aac" "aptx" "aptx_hd"]; # List codecs I want to use "ldac" is broken now
        };
      };
    };

    raopOpenFirewall = true;
    extraConfig.pipewire-pulse = {
      "context.properties" = {
        "flat.volumes" = false;
      };
    };
    extraConfig.pipewire = {
      "10-airplay" = {
        "context.modules" = [
          {
            name = "libpipewire-module-raop-discover";

            # increase the buffer size if you get dropouts/glitches
            # args = {
            #   "raop.latency.ms" = 500;
            # };
          }
        ];
      };
    };
  };
  environment.systemPackages = with pkgs; [
    pwvucontrol
    #paprefs
    crosspipe
  ];
}
