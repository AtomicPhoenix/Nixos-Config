{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      # Terminal/Programming font
      nerd-fonts.fira-code

      # Fallback font with large unicode coverage
      noto-fonts
      noto-fonts-cjk-sans # Chinese, Japanese, Korean sans rendering
      noto-fonts-color-emoji # Emoji Support

      font-awesome # Icons
      liberation_ttf # Open source equivalent of Microsoft fonts for Office compatability
    ];

    fontconfig = {
      enable = true;

      # Default fonts for X11 applications and other applications that support it.
      defaultFonts = {
        serif = [
          "Noto Serif"
          "Liberation Serif"
        ];

        sansSerif = [
          "Noto Sans"
          "Liberation Sans"
        ];

        monospace = [
          "FiraCode Nerd Font Mono"
        ];

        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };
}
