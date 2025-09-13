{
  config,
  pkgs,
  ...
}: {
  # systemd.services.network-sync = {
  #   description = "Network files sync";
  #   after = ["network-online.target"];
  #   wants = ["network-online.target"];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     # Définir le chemin vers le fichier de config rclone
  #     Environment = "RCLONE_CONFIG=${config.age.secrets.rclone.path}";
  #     ExecStart = ''
  #       ${pkgs.rclone}/bin/rclone bisync /etc/NetworkManager/system-connections/ network:
  #     '';
  #     User = "root"; # on reste root
  #   };

  #   wantedBy = ["multi-user.target"];
  # };
}
