{lib, ...}: {
  programs.nvf = {
    enable = true;
    # enableManpages = true;
    settings = {
      vim = lib.mkMerge [
        (import ./plugins { inherit lib;} ) 
        {
          autocmds = import ./autocmds.nix {inherit lib;};
          keymaps = import ./keymaps.nix;
          languages = import ./languages.nix;
          options = import ./options.nix;

          viAlias = true;
          vimAlias = true;

          globals.mapleader = " ";
          globals.maplocalleader = " ";

          luaConfigPre = " listchars = { tab = '» '; trail = '·'; nbsp = '␣'; };";

          lsp.enable = true;
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
