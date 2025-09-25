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

  markdown = {
    enable = true;
    lsp.enable = true;
    extensions.render-markdown.enable = true;
  };
}
