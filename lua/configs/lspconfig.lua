require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = {
  "html",
  "cssls",
  "rust_analyzer",
  "clangd",
  "lua_ls",
  "ts_ls"
}

vim.lsp.enable(servers)

local nvlsp = require "nvchad.configs.lspconfig"

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

lspconfig.pyright.setup({
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = {"python"},
})


-- read :h vim.lsp.config for changing options of lsp servers 
