local cmd = vim.cmd
local fn = vim.fn
local execute = vim.api.nvim_command

-- autoload Packer if plugin is missing
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

cmd([[packadd packer.nvim]])        -- wbthomason/packer.nvim

require("mappings")                 -- load gemeric mappings
require("conf.generic")             -- load generic settings
require("plugins.list")             -- load plugins
require("conf.plugins").setup()     -- load plugin-specific settings
require("plugins.mappings")         -- load plugin-specific mappings
