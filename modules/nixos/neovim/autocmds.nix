{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in [
  {
    enable = true;
    event = ["BufWritePre"];
    callback = mkLuaInline ''
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end
    '';
    desc = "Autoformat buffer on BufWritePre Event";
  }
  {
    enable = true;
    event = ["TextYankPost"];
    callback = mkLuaInline ''
      function()
          vim.highlight.on_yank()
      end
    '';
    desc = "Highlight when yanking (copying) text";
  }
]
