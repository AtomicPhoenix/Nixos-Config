let
  enableLanguage = {
    enable = true;
    lsp.enable = true;
  };
in {
  # Turn on Formatting, Treesitter, and extraDiagnostics for enabled languages by default
  enableFormat = true;
  enableTreesitter = true;

  nix = enableLanguage;
  java = enableLanguage;
  lua = enableLanguage;
  python = enableLanguage;
  go = enableLanguage;
  bash = enableLanguage;
  clang = enableLanguage;
  ts = enableLanguage // {format.type = "prettierd";};
  css = enableLanguage // {format.type = "prettierd";};
  html.enable = true;

  markdown = {
    enable = true;
    lsp.enable = true;
    extensions.render-markdown-nvim.enable = true;
  };
}
