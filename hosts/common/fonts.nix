{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      # Terminal/Programming font
      nerd-fonts.fira-code

      # Fallback font with large unicode coverage
      noto-fonts
      noto-fonts-cjk-sans # Chinese, Japanese, Korean sans rendering
      noto-fonts-cjk-serif # Chinese, Japanese, Korean serif rendering
      noto-fonts-color-emoji # Emoji Support

      font-awesome # Icons
      liberation_ttf # Open source equivalent of Microsoft fonts for Office compatability
    ];
  };
}
