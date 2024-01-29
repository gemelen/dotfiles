local cmd = vim.cmd
local fn = vim.fn
local execute = vim.api.nvim_command

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("mappings")                 -- load gemeric mappings
require("conf.generic")             -- load generic settings
require("plugins.list")             -- load plugins
require("conf.plugins").setup()     -- load plugin-specific settings
require("plugins.mappings")         -- load plugin-specific mappings
