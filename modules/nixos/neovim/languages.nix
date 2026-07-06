let
  enableLanguage = {
    enable = true;
    lsp.enable = true;
  };
in {
  # Turn on Formatting, Treesitter, and extraDiagnostics for enabled languages by default
  enableFormat = true;
  enableTreesitter = true;
  enableExtraDiagnostics = true;

  nix = enableLanguage;
  java = enableLanguage;
  lua = enableLanguage;
  python = enableLanguage;
  bash = enableLanguage;
  clang = enableLanguage;
  html.enable = true;
  css = enableLanguage;
  typescript = enableLanguage;
  markdown = enableLanguage // {extensions.render-markdown-nvim.enable = true;};
}
