[
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
]
