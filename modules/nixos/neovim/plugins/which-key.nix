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
        Up = "<Up> ";
        Down = "<Down> ";
        Left = "<Left> ";
        Right = "<Right> ";
        C = "<C-…> ";
        M = "<M-…> ";
        D = "<D-…> ";
        S = "<S-…> ";
        CR = "<CR> ";
        Esc = "<Esc> ";
        ScrollWheelDown = "<ScrollWheelDown> ";
        ScrollWheelUp = "<ScrollWheelUp> ";
        NL = "<NL> ";
        BS = "<BS> ";
        Space = "<Space> ";
        Tab = "<Tab> ";
        F1 = "<F1>";
        F2 = "<F2>";
        F3 = "<F3>";
        F4 = "<F4>";
        F5 = "<F5>";
        F6 = "<F6>";
        F7 = "<F7>";
        F8 = "<F8>";
        F9 = "<F9>";
        F10 = "<F10>";
        F11 = "<F11>";
        F12 = "<F12>";
      };
    };

    # Document existing key chains
    spec = [
      {
        lhs = "<leader>c";
        group = "[C]ode";
        mode = ["n" "x"];
      }
      {
        lhs = "<leader>d";
        group = "[D]ocument";
      }
      {
        lhs = "<leader>r";
        group = "[R]ename";
      }
      {
        lhs = "<leader>s";
        group = "[S]earch";
      }
      {
        lhs = "<leader>w";
        group = "[W]orkspace";
      }
      {
        lhs = "<leader>t";
        group = "[T]oggle";
      }
      {
        lhs = "<leader>h";
        group = "Git [H]unk";
        mode = ["n" "v"];
      }
    ];
  };
}
