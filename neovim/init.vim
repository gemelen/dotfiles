" ======== Plugin management ========
call plug#begin('~/.config/nvim/plugged')

" Plugins:
" Look and feel
    Plug 'flazz/vim-colorschemes'
    Plug 'myusuf3/numbers.vim'	" relative/absolue line numbers
    " visual indentation
    Plug 'Yggdroot/indentLine'
    Plug 'lukas-reineke/indent-blankline.nvim'

" Pandoc/Markdown
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'

" LSP stuff
    Plug 'nvim-lua/completion-nvim'
    Plug 'scalameta/nvim-metals'

" commenting
    Plug 'tomtom/tcomment_vim'
" filetypes
    Plug 'satabin/hocon-vim'
" file explorer
    Plug 'scrooloose/nerdtree'
" glow inside neovim
    Plug 'npxbr/glow.nvim', {'do': ':GlowInstall'}
" Git support
    Plug 'tpope/vim-fugitive'

call plug#end()

" ======== General behaviour ========
set autowrite       " write file on switch commands
set autoread        " read external changes
set ttyfast
set lazyredraw
set history=500     " extend command/search history
set clipboard^=unnamed,unnamedplus " clipboard seamless interop
set updatetime=300  " Smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c    " don't give |ins-completion-menu| messages.
set shortmess-=F    " nvim-metals pre-requisite
set signcolumn=yes  " always show signcolumns

" ======== Persistance ========
set backup          " file versioning
set undofile
set undodir=~/.config/nvim/backup,/tmp
set backupdir=~/.config/nvim/backup,/tmp
set directory=~/.config/nvim/backup,/tmp " swapfile

" ======== UI ========
colorscheme duoduo
set ruler           " display current position in lower right corner
set cmdheight=1     " command bar height
" Make the 81st column stand out  OR ELSE just the 81st column of wide lines...
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)
" Make trailing whitespace, and non-breaking spaces visible
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list
" Search
set hlsearch
set ignorecase
set smartcase

" ======== Menus ========
set wildmenu        " More useful command-line completion
" Ignore binary and auxiliary files in menu
set wildignore+=*.o
set wildignore+=*~
set wildignore+=*.class
set wildignore+=*/.git/*
set wildignore+=*/.hg/*
set wildignore+=*/.svn/*
set wildignore+=*/.DS_Store
set wildignore+=*/.metals/*
set wildignore+=*/.bloop/*

" ======== Status line ========
" statusbar, see https://www.vi-improved.org/recommendations/
set statusline=%(%y%)%(%F%)%([%p%%]%)
set rulerformat=%4l\≡\ %4v⦀\ %p%%

" ======== Text properties ========
set tabstop=4       " 1 tab = 4 spaces
set shiftwidth=4
set expandtab
set smarttab
" Indenting
set autoindent
set smartindent
set showmode
set showmatch       " show matched brackets
" Line wrapping
set wrap
set textwidth=120
set formatoptions=qrn1
" folding
set foldenable

" ======== Panes behaviour ========
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" ======== ??? ========
set backspace=eol,start,indent " Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l

" ======== Key mappings ========
set pastetoggle=<F3>    " F3 switches formatting on paste
command! Q q!           " :Q to quit without save
command! W w !sudo tee % > /dev/null    " :W sudo saves the file 
" Remove the Windows' ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" arrows no more
noremap <Up>        :resize +2<CR>
noremap <Down>      :resize -2<CR>
noremap <Left>      :vertical resize +2<CR>
noremap <Right>     :vertical resize -2<CR>
" Swap : and ; to make colon commands easier to type
nnoremap  ;  :
nnoremap  :  ;
" from https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" ======== Plugins settings ========
" NERDTree {
    nnoremap <C-g> :NERDTreeToggle<CR>
    let NERDTreeMinimalUI = 1
    let NERDTreeDirArrows = 1
" }
" Pandoc {
    let g:vim_markdown_toc_autofit = 1
    set conceallevel=2
" }
" Glow {
    nnoremap <C-l> :Glow<CR>
" }
" nvim-metals {
"-----------------------------------------------------------------------------
" nvim-lsp Mappings
"-----------------------------------------------------------------------------
    nnoremap <silent> gd          <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> K           <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> gi          <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> gds         <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <silent> gws         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
    nnoremap <silent> <leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <silent> <leader>f   <cmd>lua vim.lsp.buf.formatting()<CR>
    nnoremap <silent> <leader>ca  <cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap <silent> <leader>ws  <cmd>lua require'metals'.worksheet_hover()<CR>
    nnoremap <silent> <leader>a   <cmd>lua require'metals'.open_all_diagnostics()<CR>
    nnoremap <silent> <space>d    <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
    nnoremap <silent> [c          <cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>
    nnoremap <silent> ]c          <cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>
    " nvim-metals setup with a few additions such as nvim-completions
:lua << EOF
  metals_config = require'metals'.bare_config
  metals_config.settings = {
     showInferredType = true,
     showImplicitArguments = true,
     showImplicitConversionsAndClasses = true
  }

  metals_config.on_attach = function()
    require'completion'.on_attach();
  end

  metals_config.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = {
        prefix = '',
      }
    }
  )
EOF

if has('nvim-0.5')
  augroup lsp
    au!
    au FileType scala,sbt lua require('metals').initialize_or_attach(metals_config)
    au BufWritePre *.scala lua vim.lsp.buf.formatting()
  augroup end
endif

"-----------------------------------------------------------------------------
" completion-nvim settings
"-----------------------------------------------------------------------------
" configure type, speed and other characteristics of completion list
    set completeopt=menuone,noinsert,noselect
    let g:completion_confirm_key = ""
    imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
                     \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"
    let g:completion_matching_strategy_list = ['fuzzy', 'substring']
    let g:completion_matching_smart_case = 1
    let g:completion_timer_cycle = 200
" Use <Tab> and <S-Tab> to navigate through popup menu
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" }
