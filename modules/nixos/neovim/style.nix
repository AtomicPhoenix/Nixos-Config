_: {
  vim = {
    theme = {
      enable = true;
      name = "tokyonight";
      style = "night";
    };

    highlight.Command = {
      italic = true;
    };

    luaConfigPre = "listchars = { tab = '» '; trail = '·'; nbsp = '␣'; };";
  };
}
