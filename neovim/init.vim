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

" Scala stuff
    " quite old.
    " watch on new language schemas
    Plug 'derekwyatt/vim-scala'
    " CoC/CoC-metals
    " watch on metals via neovim-lsp
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

" commenting
    Plug 'tomtom/tcomment_vim'
" filetypes
    Plug 'satabin/hocon-vim'
" file explorer
    Plug 'scrooloose/nerdtree'
" glow inside neovim, required > 0.4.4
    Plug 'npxbr/glow.nvim', {'do': ':GlowInstall'}

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
" Metals {
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    " Used in the tab autocompletion for coc
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[c` and `]c` to navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Used to expand decorations in worksheets
    nmap <Leader>ws <Plug>(coc-metals-expand-decoration)

    " Use K to either doHover or show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold *.scala silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Remap for format selected region
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType scala setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add status line support, for integration with other plugin, checkout `:h coc-status`
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Show all diagnostics
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
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

    " Notify coc.nvim that <enter> has been pressed.
    " Currently used for the formatOnType feature.
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
          \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    " Toggle panel with Tree Views
    nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>
    " Toggle Tree View 'metalsBuild'
    nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
    " Toggle Tree View 'metalsCompile'
    nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
    " Reveal current current class (trait or object) in Tree View 'metalsBuild'
    nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsBuild<CR>   
" }
" Pandoc {
    let g:vim_markdown_toc_autofit = 1
    set conceallevel=2
" }
" Glow {
    nnoremap <C-l> :Glow<CR>
" }
