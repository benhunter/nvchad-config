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
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "typescript-language-server",
        "clangd",
        "clang-format",
        -- "rust-analyzer",
        -- "python-lsp-server"
        "pyright"
      },
    },
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
        "rust",
        "python"
      },
    },
  },

  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({})
  --   end,
  -- }

  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    event = { "InsertEnter" },
    opts = {
      suggestion = {
        auto_trigger = true,
      }
    },
    config = function ()
      require("copilot").setup({
        -- suggestion = { enabled = false },
        -- panel = { enabled = false },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    -- config = function()
    --   require("treesitter-context").setup{
    --     enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    --     multiline_threshold = 20, -- Maximum number of lines to show for a single context
    --     max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    --     min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    --     line_numbers = true,
    --     trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    --     mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
    --     -- Separator between context and content. Should be a single character string, like '-'.
    --     -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    --     separator = nil,
    --     zindex = 20, -- The Z-index of the context window
    --     on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    --   }
    -- end,
  },
}
