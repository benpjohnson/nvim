let $NVIM=$HOME . "/.config/nvim"

" ---------------------------------- plugins ---------------------------------

call plug#begin('~/.config/nvim/plugged')
Plug 'jnurmine/Zenburn'
Plug 'benekastah/neomake'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'rking/ag.vim'
Plug 'vimwiki'
Plug 'kassio/neoterm'
Plug '~/devel/elevate.vim'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-markdown'
Plug 'juneedahamed/vc.vim'
Plug 'benpjohnson/dbtables'
Plug 'benpjohnson/vim-pipe'
Plug 'mattboehm/vim-unstack'
Plug 'SirVer/ultisnips'
call plug#end()

" ---------------------------------- look/feel ---------------------------------

" Zenburn
" -------
" make zenburn user darker colours
let g:zenburn_high_Contrast = 1
" Nicer selections
let g:zenburn_old_Visual = 1
let g:zenburn_alternate_Visual = 1
colorscheme zenburn 

" Give signs a more sensible background colour
hi SignColumn ctermbg=234
" turn on auto syntax highlight
syntax on
set wildmenu
set wildmode=list:longest,full
" turn bells off
set noerrorbells
set vb t_vb= 
" highlight current line
set cul 
set ruler
set laststatus=2
" Elimate delays switching out of insert mode and leader
set timeoutlen=300
" Causes slowdown in neovim
set nocursorline
" disable folding
set nofoldenable

" ------------------------------- text handling --------------------------------
" convert tabs to spaces
set expandtab
" amount of whitespace to insert
set softtabstop=4
" width of a tab in spaces
set tabstop=4
set smarttab
" controls the spaces inserted when using indentation commands
set shiftwidth=4
" set cindent
" set autoindent
set notagbsearch
" show line numbers by default
set number
" repair wired terminal/vim settings
set backspace=start,eol,indent
" use incremental searching
set incsearch

" ---------------------------------- buffers -----------------------------------
set hidden

" auto close the preview onmi complete buffer after we are done with it
autocmd CursorMovedI * if pumvisible() == 0 && bufname("%") != "[Command Line]"|pclose|endif
autocmd InsertLeave * if pumvisible() == 0 && bufname("%") != "[Command Line]"|pclose|endif
" Start new splits on the rhs
set splitright

" Use * by default
if $TMUX == ''
	set clipboard=unnamed
endif

" --------------------------------- filetypes ----------------------------------
filetype on
filetype plugin on
filetype indent on

" --------------------------------- filesystem ---------------------------------
" friendly menu when tabbing though file matches
set wildmenu
" stick backup files where they belong 
silent !mkdir ~/.vim_backup > /dev/null 2>&1
set backupdir=~/.vim_backup
set directory=~/.vim_backup
" Search upwards for a tags file
set tags=tags;

" ----------------------------------- paths ------------------------------------
" Search all the things
set path=**
" Don't require common file extensions
set suffixesadd=.php

" -------------------------------- key mappings --------------------------------
let mapleader = "\<Space>"
let maplocalleader = "\\"
source $HOME/.config/nvim/keymaps.vim

" ---------------------------------- plugins -----------------------------------
" stop gap solution to somewhat isolate plugin-specific settings/key mappings
source $HOME/.config/nvim/plugin-settings.vim

" ------------------------------------ misc  -----------------------------------
set history=1000

" Stuff specific to local machine
if filereadable($NVIM . "/init.vim.local")
      exec 'source ' . $NVIM . '/init.vim.local'
endif

" Here be dragons
if filereadable($NVIM . "/wip.vim")
      exec 'source ' . $NVIM . '/wip.vim'
endif
