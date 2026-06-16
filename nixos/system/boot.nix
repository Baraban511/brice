{
  pkgs,
  config,
  ...
}: {
  boot = {
    plymouth = {
      enable = true;
      theme = "catppuccin-macchiato";
      themePackages = with pkgs; [
        catppuccin-plymouth
      ];
    };
    loader.systemd-boot.configurationLimit = 20; # Ensure /boot is never full
    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    kernel.sysctl."kernel.sysrq" = 1; # Enable magic SysRq key
    kernelModules = ["v4l2loopback"]; # For creating video sinks
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    # scrcpy --video-source=camera --camera-size=1920x1080 --camera-f²ps=60 --v4l2-sink=/dev/videoN --no-video-playback
    extraModprobeConfig = ''
      options v4l2loopback devices=4 exclusive_caps=1
    '';
  };
}
