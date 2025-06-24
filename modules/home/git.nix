{
  pkgs,
  ...
}: {
  home.packages = [pkgs.gh];

  programs.git = {
    enable = true;
    userName = "PossiblyAI";
    userEmail = "imrana50280@gmail.com";
    extraConfig = {
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
    };
  };
}
