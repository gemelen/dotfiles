local h = require("api.hacks")
local cmd = vim.cmd
local execute = vim.api.nvim_command
local fn = vim.fn

-- autoload Packer if plugin is missing
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

cmd([[packadd packer.nvim]])        -- wbthomason/packer.nvim

require("mappings")                 -- load gemeric mappings
require("conf.generic")             -- load generic settings
require("conf.plugins").setup()     -- load plugin-specific settings
require("plugins.list")             -- load plugins
require("plugins.mappings")         -- load plugin-specific mappings

require("lspsaga").init_lsp_saga({
  server_filetype_map = { metals = { "sbt", "scala" } },
  code_action_prompt = { virtual_text = false },
})

h.create_augroup({
  { "FileType", "scala,sbt", "lua require('metals').initialize_or_attach(metals_config)" },
  { "FileType", "scala", "setlocal omnifunc=v:lua.vim.lsp.omnifunc" },
  { "BufWritePre", "scala", "lua vim.lsp.buf.formatting()" },
}, "LSPMetals")
