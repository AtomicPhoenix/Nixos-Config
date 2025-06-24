{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./alacritty.nix
    ./bash.nix
    # ./nvf.nix
  ];

  home.username = "ai";
  home.homeDirectory = "/home/ai";
  home.stateVersion = "25.05";
}
