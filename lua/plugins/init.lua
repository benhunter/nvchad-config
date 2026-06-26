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

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css",
        "javascript", "typescript", "tsx",
        "c",
        "markdown", "markdown_inline",
        "rust"
      },
    },
  },

  -- test new blink
  { import = "nvchad.blink.lazyspec" },

  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    event = { "InsertEnter" },
    config = function ()
      require("copilot").setup({
        suggestion = {
          enabled = false,
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

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy", -- Loads the plugin lazily after UI starts
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Requires treesitter parsers
    opts = {
      enable = true,            -- Enable this plugin (Can be enabled/disabled later)
      max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = "outer",     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "cursor",          -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above the viewport
      separator = nil,
      zindex = 20,              -- The Z-index of the context window
      on_attach = nil,          -- (fun(buf: integer): boolean) return false to disable attaching
    },
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
