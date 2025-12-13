{lib, ...}: {
  imports = [
    ./common
  ];

  programs.ssh = let
    standard_config = hostname: {
      inherit hostname;
      identityFile = ["~/.ssh/ai-duo-personal"];
      port = 8102;
    };
  in {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = ["~/.ssh/ai-duo-github"];
      };

      "ai-desk" = standard_config "ai-desk";

      # Cluster Nodes
      "master" = standard_config "master";
      "worker" = standard_config "worker";
      "worker-2" = standard_config "worker-2";
    };
  };

  ## Extend common bashrc located in ./common/bash.nix
  programs.bash.bashrcExtra = lib.mkAfter ''
    ## Runs after rebuild command defined in ./common/bash.nix
    function post_rebuild()  {
      toggle-monitor
    }
  '';

  wayland.windowManager.hyprland.settings.exec-once = ["duo-manage-monitors"];
}
