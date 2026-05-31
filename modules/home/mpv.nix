{pkgs, ...}: {
  programs.mpv = {
    enable = true;

    package = pkgs.mpv.wrapper {
      scripts = with pkgs.mpvScripts; [
        uosc
        sponsorblock
      ];

      mpv = pkgs.mpv.override {
        waylandSupport = true;
      };
    };

    config = {
      profile = "high-quality";
      ytdl-format = "bestvideo+bestaudio";
      cache-default = 4000000;
    };
  };
}
