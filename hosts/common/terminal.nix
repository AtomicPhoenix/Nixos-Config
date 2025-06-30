{pkgs, ...}: {
  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.departure-mono
    nerd-fonts.symbols-only
    nerd-fonts.fira-code
  ];

  environment.variables = {
    XCURSOR_SIZE = "32";
    EDITOR = "nvim";
  };
}
