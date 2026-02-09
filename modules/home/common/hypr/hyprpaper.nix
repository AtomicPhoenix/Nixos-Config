{pkgs-unstable, ...}: {
  services.hyprpaper = {
    enable = true;
    package = pkgs-unstable.hyprpaper;
    settings = {
      ipc = false;
      splash = false;

      wallpaper = {
        monitor = "eDP-1";
        path = "/home/ai/Pictures/Wallpapers/";
      };
    };
  };
}
