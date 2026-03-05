{pkgs-unstable, ...}: {
  services.hyprpaper = {
    enable = true;
    package = pkgs-unstable.hyprpaper;
    settings = {
      ipc = false;
      splash = false;

      wallpaper = {
        monitor = "*"; # Duplicate across all monitors
        path = "/home/ai/Pictures/Wallpapers/";
        timeout = 180;
      };
    };
  };
}
