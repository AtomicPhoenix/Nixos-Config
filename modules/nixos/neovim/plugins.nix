{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
in {
  # NOTE: Plugins (Built-into nvf)
  vim = {
    startPlugins = [
      "plenary-nvim"
    ];

    clipboard.providers.wl-copy.enable = true;
    # folke/todo-comments.nvim: highlight and search for todo comments
    notes.todo-comments.enable = true;
    # tpope/vim-sleuth: Detects tabstop and shiftwidth automatically
    utility.sleuth.enable = true;
    # 'stevearc/conform.nvim: Autoformatter
    formatter.conform-nvim = {
      enable = true;
      setupOpts = {
        notify_on_error = true;
        format_on_save = mkLuaInline ''
          function(bufnr)
            local disable_filetypes = { }
            local lsp_format_opt
            if disable_filetypes[bo[bufnr].filetype] then
              lsp_format_opt = 'never'
            else
              lsp_format_opt = 'fallback'
            end
            return {
              timeout_ms = 500,
              lsp_format = lsp_format_opt,
            }
          end
        '';
      };
    };
    # hrsh7th/nvim-cmp: Autocompletion
    autocomplete.nvim-cmp = {
      enable = true;
      mappings = {
        complete = "<C-Space>";
        confirm = "<C-y>";
        next = "<C-n>";
        previous = "<C-p>";
        close = "<C-x>";
        scrollDocsUp = "<C-b>";
        scrollDocsDown = "<C-f>";
      };
    };

    vim = {
      theme.transparent = true;
    };

    telescope = {
      enable = true;
      extensions = [];
    };

    # TODO: Plugins
    # "nvim-telescope/telescope-file-browser.nvim" # File browser extension for telescope.nvim
    # 'nvim-treesitter/nvim-treesitter', # Highlight, edit, and navigate code
    # ui.icons = g.have_nerd_font and {} or {}

    lazy.plugins = {
      "vim-tmux-navigator" = {
        package = pkgs.vimPlugins.vim-tmux-navigator;

        cmd = [
          "TmuxNavigateLeft"
          "TmuxNavigateDown"
          "TmuxNavigateUp"
          "TmuxNavigateRight"
          "TmuxNavigatePrevious"
          "TmuxNavigatorProcessList"
        ];
      };
    };

    # "folke/which-key.nvim": Shows pending keybinds
    binds.whichKey = {
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
    };
  };
}
