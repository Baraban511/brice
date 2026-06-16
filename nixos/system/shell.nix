{pkgs, ...}: {
  users = {
    defaultUserShell = pkgs.zsh;
  };
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        zed = "zeditor";
        wifi = "nmtui";
        rebuild = "git -C /home/barab/brice add . && sudo nixos-rebuild switch --flake /home/barab/brice/";
        update = "nix flake update --flake /home/barab/brice && flatpak update --noninteractive";
      };
      histSize = 1000;
      histFile = "$HOME/.config/brice/.histfile";
    };
    starship = {
      enable = true;
      settings = {
        aws.disabled = true;
        gcloud.disabled = true;
      };
    };
  };
  environment.etc = {
    "zshrc".text = ''
      bindkey -e # Emacs keybindings
      bindkey '^[[1;5D' backward-word
      bindkey '^[[1;5C' forward-word
    '';
  };
  system = {
    userActivationScripts = {
      touchZsh = "touch /home/barab/.zshrc"; # Avoid zsh error on first login because of missing .zshrc
    };
  };
}
