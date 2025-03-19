-- vi:nospell
-- General
vim.o.autoread = true
vim.o.autowrite = true
vim.o.history = 500
vim.o.clipboard = "unnamedplus" -- suse/Wayland: wl-clipboard
vim.bo.fileformat = "unix"
vim.o.shortmess = string.gsub(vim.o.shortmess, "F", "") .. "c"
-- Persistence
vim.o.backup = true
vim.o.undofile = true
vim.o.swapfile = true
vim.o.undodir = "~/.cache/nvim/undo,/tmp,."
vim.o.backupdir = "~/.cache/nvim/backup,/tmp,."
vim.o.directory = "~/.cache/nvim/swap,/tmp,."
-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmatch = true
-- Look and feel
-- dark-ish: desert / evening / horizon / userscape
-- bright: carrot / peachpuff
-- light: monochromenote / quiet
vim.cmd.colorscheme("horizon")
vim.o.termguicolors = true
vim.o.signcolumn = "auto:1-4"
vim.o.relativenumber = false
vim.o.number = false
vim.o.showmode = true
vim.o.listchars = "tab:»»,trail:·,nbsp:~"
vim.wo.list = true
vim.o.matchtime = 3
---- Menu
vim.o.completeopt = "menu,menuone,noselect,noinsert,fuzzy"
vim.o.wildoptions = "pum,tagfile,fuzzy"
vim.o.wildignorecase = true
local ignore_extensions = "*.zwc,*.o,*.class,*~"
local ignore_directories = "target,.bloop,.bsp,.DS_Store,.git,.idea,.metals"
local ignore_patterns = ignore_extensions .. ',' .. ignore_directories
vim.o.wildignore = vim.o.wildignore .. ignore_patterns
---- Text properties
vim.bo.textwidth = 100
vim.bo.formatoptions = "jnqr1"
---- [ control tab-to-spaces insert
local indent = 2
vim.o.tabstop = indent
vim.o.shiftwidth = indent
vim.o.expandtab = true
vim.bo.smartindent = true
---- ]
vim.o.whichwrap = "<,>,h,l"
---- Panes
vim.o.splitbelow = true
vim.o.splitright = true
-- folds [
vim.o.foldenable = true
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevelstart = 99
-- ]
-- spellcheck [
vim.o.spell = true
-- TODO: replace swe with :h thesaurus
vim.o.spelllang = "swe,en_gb,en_us,uk,es,ru"
-- ]
-- custom flag, state of autoformat feature for
vim.g.formatonsave = true
