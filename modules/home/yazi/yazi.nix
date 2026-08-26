{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";

    flavors = {
      catppuccin-mocha = ./flavors;
    };

    settings = {
      flavor = {
        use = "catppuccin-mocha";
      };
    };

    plugins = with pkgs.yaziPlugins; {
      inherit git; # Show the status of Git file changes as linemode in the file list
      inherit ouch; # Preview archives
      inherit clipboard; # Sync yazi clipboard with wl-clipboard
    };

    keymap = {
      mgr.prepend_keymap = [
        {
          on = ["y"];
          run = [
            "yank"
            "plugin clipboard -- --action=copy"
          ];
          desc = "Yank selected files to system clipboard";
        }
      ];
    };
  };
}
