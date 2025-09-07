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

  programs.bash.bashrcExtra = lib.mkForce ''
    function rebuild()  {
      # Get hostname and rebuild
      if [[ -z $host ]]; then
        host="$HOSTNAME"
        printf "\033[0;33mWARNING: \033[0mNo hostname specified. Defaulting to using hostname (%s) for flake...\n" "$HOSTNAME"
      else
        host="$1"
        printf "Using flake %s...\n" "$host"
      fi
      printf "System will be rebuilt using the selected flake (%s)\n" "$host"
      printf " Rebuilding...\n\n"
      sudo nixos-rebuild switch --show-trace --flake ~/Nixos-Config/#$host
      toggle-monitor
    }
  '';

  wayland.windowManager.hyprland.settings.exec-once = ["duo-manage-monitors"];
}
