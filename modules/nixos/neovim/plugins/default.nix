{lib, ...}: {
  startPlugins = [
    "plenary-nvim"
  ];

  # Enable wl-copy support (share system copy)
  clipboard.providers.wl-copy.enable = true;

  # folke/todo-comments.nvim: highlight and search for todo comments
  notes.todo-comments.enable = true;

  # tpope/vim-sleuth: Detects tabstop and shiftwidth automatically (auto indents)
  utility.sleuth.enable = true;

  # 'stevearc/conform.nvim: Autoformatter
  formatter.conform-nvim = import ./conform-nvim.nix {inherit lib;};

  # hrsh7th/nvim-cmp: Autocompletion
  autocomplete.nvim-cmp = import ./nvim-cmp.nix;

  # telescope
  telescope.enable = true;

  # "folke/which-key.nvim": Shows pending keybinds
  binds.whichKey = import ./which-key.nix;
}
