{pkgs, ...}: {
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };
  system.userActivationScripts = {
    enableMprisPulse = "systemctl --user enable mpris-proxy.service";
  };
  services = {
    pulseaudio.extraConfig = "
      load-module module-switch-on-connect
    ";
    #blueman.enable = true; # Bluetooth manager
  };

  environment.systemPackages = with pkgs; [
    overskride
  ];
}
