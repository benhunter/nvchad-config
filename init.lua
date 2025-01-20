--- Ensure that the config's lua directory is in the module search path
--local config = vim.fn.stdpath("config")
--package.path = config .. "/lua/?.lua;" .. config .. "/lua/?/init.lua; /lua/plugins/init.lua;" .. package.path

-- print("init.lua: DEBUG")

-- Diagnostic: print the package.path (you can remove this after debugging)
--print("lua package.path: ", package.path)
---

vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- print("init.lua: before lazy + NvChad")

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- print("init.lua: before options")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

