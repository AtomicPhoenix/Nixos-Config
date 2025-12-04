[
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
]
