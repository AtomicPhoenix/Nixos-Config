{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      font-awesome
      nerd-fonts.departure-mono
      nerd-fonts.symbols-only
      nerd-fonts.fira-code
      nerd-fonts.caskaydia-cove
    ];
  };
}
