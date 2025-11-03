{lib, ...}: {
  imports = [
    ./common
  ];

  programs.ssh = let
    standard_config = hostname: {
      inherit hostname;
      identityFile = ["~/.ssh/ai-desk-personal"];
      port = 8102;
    };
  in {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = ["~/.ssh/ai-desk-github"];
      };

      "ai-duo" = standard_config "ai-duo";

      # Cluster Nodes
      "master" = standard_config "master";
      "worker" = standard_config "worker";
      "worker-2" = standard_config "worker-2";
    };
  };
}
