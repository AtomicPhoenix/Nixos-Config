{...}: {
  vim = {
    lsp.enable = true;
    languages = let
      enableLanguage = {
        enable = true;
        lsp.enable = true;
      };
    in {
      enableFormat = true;
      enableTreesitter = true;

      nix = enableLanguage // {extraDiagnostics.enable = true;};
      java = enableLanguage;
      lua = enableLanguage;
      python = enableLanguage;
    };
  };
}
