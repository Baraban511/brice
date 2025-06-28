let
  nix-pc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILvDHZqwfI5SUPPpNiqCle+pjjDprNziOE6IK0CMJNlj barab@nix-pc";
  nix-portable = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrL/2pJHSITUsLRLVP8yB31F5HCtlYtmc4NKl14CLM3 nix-portable";
  systems = [nix-pc nix-portable];
in {
  "unsplash.age".publicKeys = systems;
  "rclone.conf".publicKeys = systems;
}
