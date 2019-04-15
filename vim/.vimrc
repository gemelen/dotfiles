set nocompatible
filetype off                    " required by vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" No comments
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'

" misc stuff
Plugin 'scrooloose/nerdtree'
Plugin 'flazz/vim-colorschemes'
Plugin 'myusuf3/numbers.vim'	" relative/absolue line numbers

" java
Plugin 'java_checkstyle.vim'

" scala
Plugin 'scala.vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'natebosch/vim-lsc'      " LSP client

" markdown
Plugin 'vim-pandoc/vim-pandoc-syntax'

" clojure
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'    " REPL support
Plugin 'tpope/vim-salve'        " Leiningen support

call vundle#end()               " required by vundle
filetype plugin indent on       " required by vundle
syntax on

" Write file on switch commands
set autowrite

" auto load files if vim detects they have been changed outside of Vim
set autoread

" Display current cursor position in lower right corner
set ruler

" Height of the command bar
set cmdheight=2

set ttyfast
set lazyredraw

" remember more commands and search history
set history=500

" from https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Coloring
colorscheme carrot

" statusbar, see https://www.vi-improved.org/recommendations/
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

" Tab and spaces
" 1 tab == 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Indenting
set autoindent
set smartindent
set showmode

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Show matched bracket
set showmatch

" Line wrapping
set wrap
set textwidth=120
set formatoptions=qrn1

" folding
set foldenable

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Search
set hlsearch
set ignorecase
set smartcase

" More useful command-line completion
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.class,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" Persiste VIM state
" file versioning
set backup
set backupdir=~/.vim/backup,/tmp
" swapfile
set directory=~/.vim/backup,/tmp
" unfodile
set undofile
set undodir=~/.vim/backup,/tmp

" clipboard seamless interop
set clipboard^=unnamed,unnamedplus

let g:vim_markdown_toc_autofit = 1
set conceallevel=2

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
" let mapleader = ","

" Paste with F3
set pastetoggle=<F3>

" :Q to quit without save
command! Q q!

" :W sudo saves the file 
command! W w !sudo tee % > /dev/null

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Courtesy of Damian Conway

"====[ Make the 81st column stand out ]====================
    " OR ELSE just the 81st column of wide lines...
    highlight ColorColumn ctermbg=magenta
    call matchadd('ColorColumn', '\%81v', 100)
    
"====[ Swap : and ; to make colon commands easier to type ]======
    nnoremap  ;  :
    nnoremap  :  ;

"====[ Make trailing whitespace, and non-breaking spaces visible ]======
    exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
    set list

" making new habits
noremap <Up>        :resize +2<CR>
noremap <Down>      :resize -2<CR>
noremap <Left>      :vertical resize +2<CR>
noremap <Right>     :vertical resize -2<CR>

" toggle presence of NerdTree in tab by Control-g
nnoremap <C-g> :NERDTreeToggle<CR>

" Configuration for vim-lsc
let g:lsc_enable_autocomplete = v:false
let g:lsc_server_commands = {
  \ 'scala': 'metals-vim',
  \    'log_level': 'Log'
  \}
