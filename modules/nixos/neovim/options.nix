{
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
}
