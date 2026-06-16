{pkgs, ...}: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    raopOpenFirewall = true;
    extraConfig.pipewire-pulse = {
      "context.properties" = {
        "flat.volumes" = false;
      };
    };
    extraConfig.pipewire = {
      # "10-airplay" = {
      #   "context.modules" = [
      #     {
      #       name = "libpipewire-module-raop-discover";

      #       # increase the buffer size if you get dropouts/glitches
      #       # args = {
      #       #   "raop.latency.ms" = 500;
      #       # };
      #     }
      #   ];
      # };
    };
  };
  environment.systemPackages = with pkgs; [
    pwvucontrol
    crosspipe
    playerctl # Control media players with function keys
  ];
}
