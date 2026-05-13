{
  enable = true;
  setupOpts = {
    # Show a warning when issues were detected with mappings
    notify = true;

    icons = {
      # Set icon mappings to true if you have a Nerd Font
      # mappings = g.have_nerd_font;
      # If you are using a Nerd Font: set icons.keys to an empty table which will use the
      # Default which-key.nvim defined Nerd Font icons, otherwise define a string table
      # keys = g.have_nerd_font and {}
      keys = {
        Up = " ";
        Down = " ";
        Left = " ";
        Right = " ";
        C = "󰘴 ";
        M = "󰘵 ";
        D = "󰘳 ";
        S = "󰘶 ";
        CR = "󰌑 ";
        Esc = "󱊷 ";
        ScrollWheelDown = "󱕐 ";
        ScrollWheelUp = "󱕑 ";
        NL = "󰌑 ";
        BS = "󰁮";
        Space = "󱁐 ";
        Tab = "󰌒 ";
        F1 = "󱊫";
        F2 = "󱊬";
        F3 = "󱊭";
        F4 = "󱊮";
        F5 = "󱊯";
        F6 = "󱊰";
        F7 = "󱊱";
        F8 = "󱊲";
        F9 = "󱊳";
        F10 = "󱊴";
        F11 = "󱊵";
        F12 = "󱊶";
      };
    };
  };
}
