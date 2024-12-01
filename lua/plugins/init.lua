return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- {
  --   "williamboman/mason.nvim",
  --   opts = {
  --     ensure_installed = {
  --       "lua-language-server",
  --       "stylua",
  --       "html-lsp",
  --       "css-lsp",
  --       "prettier",
  --       "typescript-language-server",
  --       "clangd",
  --       "clang-format",
  --       "rust-analyzer",
  --       -- "python-lsp-server"
  --       "pyright"
  --     },
  --   },
  -- },

  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = {
  --     ensure_installed = {
  --       "vim", "lua", "vimdoc",
  --       "html", "css",
  --       "javascript", "typescript", "tsx",
  --       "c",
  --       "markdown", "markdown_inline",
  --       "rust"
  --     },
  --   },
  -- },

  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    event = { "InsertEnter" },
    config = function ()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
        },
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            open = "<M-p>"
          },
        },
      })
      print("Copilot setup loaded")
    end,
  },
}
