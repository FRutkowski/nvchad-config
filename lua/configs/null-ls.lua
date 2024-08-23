local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null-ls = require('null-ls')

local opts = {
  sources = {
    null-ls.builtins.formatting.black,
    null-ls.builtins.diagnostics.mypy
    null-ls.builtins.diagnostics.ruff
  },
  
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd({
        group = augroup,
        buffer = bufnr
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
}

return opts
