set nocompatible
set ruler
set hlsearch
set ignorecase smartcase
set wildmenu
set expandtab tabstop=4 shiftwidth=4 smarttab
set autoindent smartindent
set showmatch
set wrap textwidth=120
set formatoptions=qrn1
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set pastetoggle=<F3>
set shiftwidth=4
set modeline
filetype plugin on
syntax on
command! W w !sudo tee % > /dev/null
nnoremap  ;  :
nnoremap  :  ;
