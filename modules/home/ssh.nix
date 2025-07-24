_: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = ["~/.ssh/ai-desk-key" "~/.ssh/ai-duo-key"];
      };
    };
  };
}
