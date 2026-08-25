{
  lib,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    plugins = with pkgs.yaziPlugins; {
      git.package = git; # Show the status of Git file changes as linemode in the file list
      ouch.package = ouch; # Preview archives

      yatline-catppuccin.package = yatline-catppuccin;

      # Plugins with setup({settings})
      yatline = {
        package = yatline;
        setup = true;
        settings = {
          tab_width = 20;
          # Return as lua code
          theme = lib.mkLuaInline ''require("yatline-catppuccin"):setup("mocha")'';
        };
      };
    };
  };
}
