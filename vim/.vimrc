set nocompatible

" Plugin managemenet
if has ('nvim')
    call plug#begin('~/.config/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

    " Courtesy of tpope
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'

    " misc stuff
    Plug 'scrooloose/nerdtree'
    Plug 'flazz/vim-colorschemes'
    Plug 'myusuf3/numbers.vim'	" relative/absolue line numbers

    " scala
    Plug 'derekwyatt/vim-scala'
    " LSP integration, different for Vim and Neovim
    if has ('nvim')
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
    else 
        Plug 'natebosch/vim-lsc'
    endif

    " markdown
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'

    " clojure
    Plug 'guns/vim-clojure-static'
    Plug 'tpope/vim-fireplace'    " REPL support
    Plug 'tpope/vim-salve'        " Leiningen support

call plug#end()

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
colorscheme duoduo

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

if has ('nvim')
    " Smaller updatetime for CursorHold & CursorHoldI
    set updatetime=300
    " don't give |ins-completion-menu| messages.
    set shortmess+=c
    " always show signcolumns
    set signcolumn=yes
    " Some server have issues with backup files, see #649
    set nobackup
    set nowritebackup
    " Better display for messages
    set cmdheight=2
    
    " Use <c-space> for trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()
    " Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " Use `[c` and `]c` for navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Remap for do codeAction of current line
    nmap <leader>ac <Plug>(coc-codeaction)

    " Remap for do action format
    nnoremap <silent> F :call CocAction('format')<CR>

    " Use K for show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
    if &filetype == 'vim'
    execute 'h '.expand('<cword>')
    else
    call CocAction('doHover')
    endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Show all diagnostics
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Find symbol of current document
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
else
    " Configuration for vim-lsc
    let g:lsc_enable_autocomplete = v:true
    let g:lsc_server_commands = {
      \ 'scala': 'metals-vim',
      \    'log_level': 'Log'
      \}
    let g:lsc_auto_map = {
        \ 'GoToDefinition': '<C-]>',
        \ 'GoToDefinitionSplit': ['<C-W>]', '<C-W><C-]>'],
        \ 'FindReferences': 'gr',
        \ 'NextReference': '<C-n>',
        \ 'PreviousReference': '<C-p>',
        \ 'FindImplementations': 'gI',
        \ 'FindCodeActions': 'ga',
        \ 'Rename': 'gR',
        \ 'ShowHover': v:true,
        \ 'DocumentSymbol': 'go',
        \ 'WorkspaceSymbol': 'gS',
        \ 'SignatureHelp': 'gm',
        \ 'Completion': 'completefunc',
        \}
endif

