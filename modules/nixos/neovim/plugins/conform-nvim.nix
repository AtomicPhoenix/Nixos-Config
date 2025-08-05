{lib, ...}: {
  enable = true;
  setupOpts = {
    notify_on_error = true;
    format_on_save = lib.generators.mkLuaInline ''
      function(bufnr)
        local disable_filetypes = { }
        local lsp_format_opt
        local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
        if disable_filetypes[ft] then
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
}
