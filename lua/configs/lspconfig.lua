-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "lua_ls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
-- lspconfig.tsserver.setup {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
-- }


require('mason-lspconfig').setup_handlers({
  function(server_name)
    local server_config = {}
    if require("neoconf").get(server_name .. ".disable") then
      return
    end
    if server_name == "volar" then
        server_config.filetypes = { 'vue', 'typescript', 'javascript' }
    end
    lspconfig[server_name].setup(server_config)
  end,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.lua_ls.setup {
  capabilities = capabilities,
}

lspconfig.volar.setup {
  capabilities = capabilities,
}

lspconfig.tailwindcss.setup {
  capabilities = capabilities,
}

lspconfig.eslint.setup {
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
 capabilities = capabilities

}
