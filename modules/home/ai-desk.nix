{lib, ...}: {
  imports = [
    ./common
  ];

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = ["~/.ssh/ai-desk-key"];
      };

      "ai-duo" = {
        hostname = "ai-duo";
        identityFile = ["~/.ssh/ai-desk-personal"];
        port = 8102;
      };
    };
  };
}
