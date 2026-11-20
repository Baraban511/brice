{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nodejs
    gh
    zed-editor-fhs
    gcc
    hyprls
    antigravity-cli
    nil
    alejandra # Nix formatter
    nixd
    clang-tools
    kdePackages.qtdeclarative
  ];
}
