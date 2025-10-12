require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "rust_analyzer",
  "clangd",
  "lua_ls",
  "ts_ls",
  "bashls",
  "pyright"
}

vim.lsp.enable(servers)

-- Config a single LSP
-- read :h vim.lsp.config for changing options of lsp servers 
-- local nvlsp = require "nvchad.configs.lspconfig"
--
-- vim.lsp.config('pyright', {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   filetypes = {"python"},
-- })
