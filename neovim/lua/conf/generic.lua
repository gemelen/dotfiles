local cmd = vim.cmd
local f = require("api.functions")
local opt = f.opt
local o, wo, bo = vim.o, vim.wo, vim.bo

-- General
opt("o", "autoread", true)
opt("o", "autowrite", true)
opt("o", "history", 500)
opt("o", "clipboard", "unnamedplus")
opt("o", "shortmess", string.gsub(o.shortmess, "F", "") .. "c")
-- Persistence
opt("o", "backup", true)
opt("o", "undofile", true)
opt("o", "undodir", "~/.config/nvim/backup,/tmp")
opt("o", "backupdir", "~/.config/nvim/backup,/tmp")
opt("o", "directory", "~/.config/nvim/backup,/tmp")
-- Search
---- hlsearch default on
opt("o", "ignorecase", true)
opt("o", "smartcase", true)
-- Look and feel
---- cmdheight default 1
cmd("colorscheme duoduo")
opt("o", "signcolumn", "yes")
---- [ make 81st column to stand out if text reaches it
cmd([[highlight ColorColumn ctermbg=magenta]])
cmd([[call matchadd('ColorColumn', '\\%81v', 100)]])
---- ]
opt("o", "listchars", "tab:»»,lead:·,trail:·,nbsp:~")
opt("w", "list", true)
---- Menu
---- wildemnu default on
opt("o", "wildignore", o.wildignore .. "*~")
opt("o", "wildignore", o.wildignore .. "*.o")
opt("o", "wildignore", o.wildignore .. "*.class")
opt("o", "wildignore", o.wildignore .. "*/.bloop/*")
opt("o", "wildignore", o.wildignore .. "*/.bsp/*")
opt("o", "wildignore", o.wildignore .. "*/.DS_Store")
opt("o", "wildignore", o.wildignore .. "*/.git/*")
opt("o", "wildignore", o.wildignore .. "*/.metals/*")
opt("o", "wildignore", o.wildignore .. "*/target/*")
---- Status line
---- ruler default on
--FIXME
-- opt("o", "statusline", "%(%y%)%(%F%)%([%p%%]%)")
-- opt("o", "rulerformat", "%4l≡ %4v⦀ %p%%")
---- Text properties
---- smarttab default on
local indent = 4
---- [ control tab to spaces insert
opt("b", "tabstop", indent)
opt("b", "shiftwidth", indent)
opt("b", "expandtab", true)
---- ]
--- autoindent default on
opt("b", "smartindent", true)
opt("o", "showmode", true)
opt("o", "showmatch", true)
---- wrap default on
opt("o", "whichwrap", "<,>,h,l")
opt("b", "textwidth", 120)
opt("b", "formatoptions", "jnqr1")
---- foldenable default on
---- Panes
opt("o", "splitbelow", true)
opt("o", "splitright", true)
---- backspace default "indent,eol,start"
opt("o", "termguicolors", true)
opt("o", "completeopt", "menu,menuone,noselect,noinsert")
opt("b", "fileformat", "unix")
-- spellcheck [
opt("o", "spelling", "en_gb")
opt("o", "spell", true)
-- ]
