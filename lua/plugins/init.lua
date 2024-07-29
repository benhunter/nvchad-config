return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

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
          keymap = {
            -- accept = "<M-p>",
         },
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

  {
    -- install with yarn or npm
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  { import = "nvchad.blink.lazyspec" },

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

--   {
--     'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- -- or                              , branch = '0.1.x',
--     dependencies = { 'nvim-lua/plenary.nvim' },
--     config = function ()
--       require('telescope').setup{
--         defaults = {
--           mappings = {
--             n = {
--               ["<leader>fs"] = require('telescope.builtin').lsp_document_symbols,
--             },
--           },
--         }
--       }
--     end
--   }
}
