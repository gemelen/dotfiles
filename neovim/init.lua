-- vi:nospell
vim.loader.enable()
require("setup.lazy")
require("conf.options")
require("conf.keymapping")
require("setup.plugins").setup()
require("conf.lsp").setup()
require("conf.filetypes")
