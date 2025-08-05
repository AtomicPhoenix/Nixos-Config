{lib, ...}: {
  imports = [
    ./common
  ];

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = ["~/.ssh/ai-duo-github"];
      };

      "ai-desk" = {
        hostname = "ai-desk";
        identityFile = ["~/.ssh/ai-duo-personal"];
        port = 8102;
      };
    };
  };

  wayland.windowManager.hyprland.settings.exec-once = ["duo-manage-monitors"];
}
