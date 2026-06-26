_: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = false;

      wallpaper = {
        monitor = "*"; # Duplicate across all monitors
        path = "/home/ai/Pictures/Wallpapers/";
        timeout = 180;
      };
    };
  };
}
