filetype plugin on
syntax on

set nocompatible
set ttyfast lazyredraw termguicolors

set autoread
set viminfofile=NONE
set backup undofile
set patchmode=".orig"
set backupdir=$XDG_DATA_HOME/vim//,/tmp//, .
set undodir=$XDG_DATA_HOME/vim//,/tmp//, .

set modeline

set clipboard^=unnamed,unnamedplus

set splitbelow splitright
set wildmenu wildignorecase wildignore+=*~,*.swp
set showmode statusline=%(%y%)%(%F%)%([%p%%]%)
set ruler rulerformat=%4l\≡\ %4v⦀\ %p%%
set cursorline cursorlineopt=screenline
set smoothscroll scrolljump=-50 scrolloff=20

set showmatch
set foldenable foldmethod=indent

set hlsearch ignorecase smartcase

set textwidth=100
set tabstop=2 shiftwidth=0 softtabstop=-1 "settings in this group set to follow `tabstop`
set expandtab smarttab shiftround
set autoindent smartindent
set list listchars="trail:~"
set formatoptions=qrn1
set backspace=eol,start,indent
set wrap whichwrap+=h,l

set pastetoggle=<F3>

nnoremap  ;  :
nnoremap  :  ;
nnoremap  n  nzzzv
nnoremap  N  Nzzzv
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>

command! W w !sudo tee % > /dev/null
