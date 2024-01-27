-- Infos 
--- Plugin Manager: Lazy
--- Plugins: Catppuccin Theme, Telescope, Treesitter

-- Install Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Run
--- Lazy
local lazy_plugins = require("plugins")
local lazy_opts = {}
require("lazy").setup(lazy_plugins, lazy_opts)

-- Editor Settings
--- Tabs
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

--- Bar for long lines
vim.opt.colorcolumn = "81"

--- Keybinds
---- Global
vim.g.mapleader = " "

---- Plugin Specific
----- Telescope
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, {})

--- Color Scheme
vim.cmd.colorscheme "catppuccin-mocha"
