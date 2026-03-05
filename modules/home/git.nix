{pkgs, ...}: {
  home.packages = [pkgs.gh];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Possiblyai";
        email = "imrana50280@gmail.com";
      };
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
    };
  };
}
