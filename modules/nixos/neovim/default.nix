{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
in {
  programs.nvf = {
    enable = true;
    # enableManpages = true;
    settings = {
      vim = {
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

        globals.mapleader = " ";
        globals.maplocalleader = " ";
        clipboard.providers.wl-copy.enable = true;
        luaConfigPre = " listchars = { tab = '» '; trail = '·'; nbsp = '␣'; };";
        options = {
          number = true;
          relativenumber = false;
          # Enable mouse mode, can be useful for resizing splits for example!
          mouse = "a";

          # Don"t show the mode, since it"s already in the status line
          showmode = true;

          # Sync clipboard between OS and Neovim.
          # Schedule the setting after `UiEnter` because it can increase startup-time.
          clipboard = "unnamedplus";

          # Enable break indent
          breakindent = true;

          # Save undo history
          undofile = true;

          # Case-insensitive searching UNLESS \C or one or more capital letters in the search term
          ignorecase = true;
          smartcase = true;

          # Keep signcolumn on by default
          signcolumn = "yes";

          # Decrease update time
          updatetime = 250;

          # Decrease mapped sequence wait time
          # Displays which-key popup sooner
          timeoutlen = 300;

          # Configure how new splits should be opened
          splitright = true;
          splitbelow = true;

          # Sets how neovim will display certain whitespace characters in the editor.
          # See `:help "list"`
          list = true;
          # listchars = { tab = "» "; trail = "·"; nbsp = "␣"; };

          # Preview substitutions live, as you type!
          inccommand = "split";

          # Show which line your cursor is on
          cursorline = true;

          # Minimal number of screen lines to keep above and below the cursor.
          scrolloff = 10;
        };

        theme = {
          enable = true;
          name = "tokyonight";
          style = "night";
        };

        # NOTE: Plugins (Built-into nvf)

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
                if disable_filetypes[vim.bo[bufnr].filetype] then
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

        highlight.Command = {
          italic = true;
        };

        viAlias = false;
        vimAlias = true;
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
          markdown = {
            enable = true;
            lsp.enable = true;
            extensions.render-markdown-nvim = {
              enable = true;
            };
          };
        };
        # "folke/which-key.nvim"r# Shows pending keybinds
        binds.whichKey = {
          enable = true;
          setupOpts = {
            # Show a warning when issues were detected with mappings
            notify = true;

            icons = {
              # Set icon mappings to true if you have a Nerd Font
              # mappings = vim.g.have_nerd_font;
              # If you are using a Nerd Font: set icons.keys to an empty table which will use the
              # Default which-key.nvim defined Nerd Font icons, otherwise define a string table
              # keys = vim.g.have_nerd_font and {}
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

        keymaps = [
          {
            key = "<c-h>";
            mode = "n";
            action = "<cmd><C-U>TmuxNavigateLeft<cr>";
            desc = "Navigate left a pane";
          }
          {
            key = "<c-j>";
            mode = "n";
            action = "<cmd><C-U>TmuxNavigateDown<cr>";
            desc = "Navigate down a pane";
          }
          {
            key = "<c-k>";
            mode = "n";
            action = "<cmd><C-U>TmuxNavigateUp<cr>";
            desc = "Navigate up a pane";
          }
          {
            key = "<c-l>";
            mode = "n";
            action = "<cmd><C-U>TmuxNavigateRight<cr>";
            desc = "Navigate right a pane";
          }
          {
            key = "<c-\\>";
            mode = "n";
            action = "<cmd><C-U>TmuxNavigatePrevious<cr>";
            desc = "Navigate to the previous pane";
          }
          {
            key = "<Esc>";
            mode = "n";
            silent = true;
            action = "<cmd>nohlsearch<CR>";
            desc = "Clears highlights on search when pressing <Esc> in normal mode";
          }
          {
            key = "<leader>q";
            mode = ["n"];
            silent = true;
            action = "vim.diagnostic.setloclist";
            lua = true;
            desc = "Open diagnostic [Q]uickfix list";
          }
          {
            key = "<leader>f";
            mode = "n";
            silent = true;
            lua = true;
            desc = "[F]ormat buffer";
            action = ''
              function()
                require('conform').format { async = true, lsp_format = 'fallback' }
              end
            '';
          }
        ];

        startPlugins = [
          "plenary-nvim"
        ];

        autocmds = [
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
        ];
      };
    };
  };

  # TODO: Plugins

  # "xiyaowong/transparent.nvim" # Removes all background colors to make nvim transparent.
  # 'nvim-telescope/telescope.nvim'
  # "nvim-telescope/telescope-file-browser.nvim" # File browser extension for telescope.nvim
  #  NOTE: not sure if I wanna keep telescope-file-browser.nvim

  # TODO: LSP Plugins
  # 'folke/lazydev.nvim' # configures Lua LSP for your Neovim config, runtime and plugins;
  #                      # used for completion, annotations and signatures of Neovim apis
  # 'Bilal2453/luvit-meta' # collection of definition files for the framework Luvitl; Getting rid of this prob
  # 'neovim/nvim-lspconfig' # Main LSP Config
  # 'echasnovski/mini.nvim' # Collection of various small independent plugins/modules
  # 'nvim-treesitter/nvim-treesitter', # Highlight, edit, and navigate code

  # TODO: Misc
  # ui.icons = vim.g.have_nerd_font and {} or {}
  # Disable Arrow Keys
  # Bash Language Server Auto start????
}
# {
#   lib,
#   self,
#   inputs,
#   ...
# }: {
#   keymaps = import ./keymaps.nix {inherit lib self;};
#   languages = import ./languages.nix {inherit lib;};
#   style = import ./style.nix {inherit lib;};
#   options = import ./options.nix {inherit lib;};
#   plugins = import ./plugins.nix {inherit lib;};
#   neovimConfiguration = import ../modules {inherit self inputs lib;};
# }

