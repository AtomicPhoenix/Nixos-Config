{pkgs, ...}: {
  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.departure-mono
    nerd-fonts.symbols-only
    nerd-fonts.fira-code
  ];

  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    variables = {
      XCURSOR_SIZE = "32";
      EDITOR = "nvim";
    };
  };
}
