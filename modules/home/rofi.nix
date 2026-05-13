{pkgs, ...}: {
  # Window switcher, run dialog, ssh-launcher and dmenu replacement
  programs.rofi = {
    enable = true;
    theme = "solarized_alternate";
    plugins = with pkgs; [
      rofi-bluetooth
      rofi-calc
      # rofimoji
    ];
    modes = [
      "drun" # Launch desktop applications
      "run" # Execute shell commands
      "filebrowser" # Execute shell commands
      "calc" # Quick calculator; Use rofi -show calc -modi calc (uses rofi-calc plugin)
      # "emoji" # Copy/paste emojis (uses rojimoji plugin)
    ];
  };
}
