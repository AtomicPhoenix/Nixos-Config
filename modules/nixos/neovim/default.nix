{lib, ...}: {
  programs.nvf = {
    enable = true;
    # enableManpages = true;
    settings = {
      vim = lib.mkMerge [
        (import ./plugins {inherit lib;})
        {
          utility.direnv.enable = true;

          autocmds = import ./autocmds.nix {inherit lib;};
          keymaps = import ./keymaps.nix;
          languages = import ./languages.nix;
          options = import ./options.nix;

          viAlias = true;
          vimAlias = true;

          globals.mapleader = " ";
          globals.maplocalleader = " ";

          luaConfigPre = " listchars = { tab = '» '; trail = '·'; nbsp = '␣'; };";

          binds.cheatsheet.enable = true;

          lsp = {
            enable = true;
            formatOnSave = true;
          };

          highlight.Command.italic = true;

          theme = {
            enable = true;
            transparent = true;
            name = "tokyonight";
            style = "night";
          };
        }
      ];
    };
  };
}
