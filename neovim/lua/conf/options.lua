-- vi:nospell
-- General
vim.o.autoread = true
vim.o.autowrite = true
vim.o.history = 500
vim.o.clipboard = "unnamedplus"
vim.o.shortmess = string.gsub(vim.o.shortmess, "F", "") .. "c"
-- Persistence
vim.o.backup = true
vim.o.undofile = true
vim.o.undodir = "~/.config/nvim/backup,/tmp"
vim.o.backupdir = "~/.config/nvim/backup,/tmp"
vim.o.directory = "~/.config/nvim/backup,/tmp"
-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
-- Look and feel
vim.cmd("colorscheme duoduo")
vim.o.signcolumn = "yes"
---- [ make 81st column to stand out if text reaches it
vim.cmd([[highlight ColorColumn ctermbg=magenta]])
vim.cmd([[call matchadd('ColorColumn', '\\%81v', 100)]])
---- ]
vim.o.listchars = "tab:»»,lead:·,trail:·,nbsp:~"
vim.wo.list = true
---- Menu
---- wildemnu default on
vim.o.wildignore = vim.o.wildignore .. "*~"
vim.o.wildignore = vim.o.wildignore .. "*.o"
vim.o.wildignore = vim.o.wildignore .. "*.class"
vim.o.wildignore = vim.o.wildignore .. "*/.bloop/*"
vim.o.wildignore = vim.o.wildignore .. "*/.bsp/*"
vim.o.wildignore = vim.o.wildignore .. "*/.DS_Store"
vim.o.wildignore = vim.o.wildignore .. "*/.git/*"
vim.o.wildignore = vim.o.wildignore .. "*/.metals/*"
vim.o.wildignore = vim.o.wildignore .. "*/target/*"
---- Text properties
local indent = 2
---- [ control tab to spaces insert
vim.o.tabstop = indent
vim.o.shiftwidth = indent
vim.o.expandtab = true
---- ]
vim.bo.smartindent = true
vim.o.showmode = true
vim.o.showmatch = true
vim.o.whichwrap = "<,>,h,l"
vim.bo.textwidth = 120
vim.bo.formatoptions = "jnqr1"
---- Panes
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.completeopt = "menu,menuone,noselect,noinsert"
vim.bo.fileformat = "unix"
-- spellcheck [
vim.o.spelllang = "en_gb"
vim.o.spell = true
-- ]
