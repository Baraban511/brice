{pkgs, ...}: {
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };
  fonts = {
    # List fonts : fc-list : family | sort | uniq
    enableDefaultPackages = true;
    packages = with pkgs; [
      # Nerd Fonts
      nerd-fonts.noto
      nerd-fonts.monaspace
      # Emoji font
      noto-fonts-color-emoji
    ];

    fontconfig = {
      useEmbeddedBitmaps = true; # Enable bitmap fonts for Firefox
      defaultFonts = {
        monospace = ["MonaspiceNe Nerd Font"];
        sansSerif = ["NotoSans Nerd Font"];
        serif = ["NotoSerif Nerd Font"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
